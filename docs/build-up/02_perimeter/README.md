# [Phase 2] Perimeter: 네트워크 및 경계 보안

네트워크 세분화 및 트래픽 제어를 통한 인프라 외부 방어선 구축 절차 정리

---

## 1. 외부 트래픽 제어 및 리버스 프록시 (Nginx)

공개 서비스 진입점 단일화 및 백엔드 서버의 직접 노출 방지 전략

- **Nginx 서버 엔진 구축:** Nginx 설치 및 외부 전용 80(HTTP), 443(HTTPS) 포트 트래픽 수신 환경 구성
- **부하 분산 및 지능형 라우팅:**
  - `upstream` 설정을 활용한 다중 백엔드 노드 부하 분산 및 고가용성(HA) 확보
  - **가상 호스트(Virtual Host) 운영:** 단일 IP 기반에서 도메인별 서버 블록 분리를 통한 멀티 서비스 수용
  - **최적화 파라미터:** `max_fails=1`, `fail_timeout=10s` 설정을 통한 장애 노드 즉각 감지

  - **응답 가용성:** `proxy_connect_timeout 2s`, `proxy_read_timeout 5s` 적용 및 `proxy_next_upstream` 설정을 통한 실시간 페일오버(Failover) 구현

- **보안 강화 및 IP 은닉:**
  - HSTS(HTTP Strict Transport Security) 강제 및 TLS 1.3 기반 고강도 암호화 프로토콜 적용
  - `proxy_pass` 및 `X-Forwarded-For` 설정을 통한 실제 백엔드 서버 IP 마스킹(Masking) 수행
  - `client_max_body_size 0` 설정을 통한 대용량 데이터 전송(이미지 Push 등) 지원
- **암호화 통신(SSL/TLS) 적용:** Let's Encrypt 또는 엔터프라이즈 사설 인증 발급 기능을 통한 데이터 전송 구간 기밀성 확보

## 2. HTTPS 사설 레지스트리 구축 (Docker Registry v2)

보안이 강화된 사설 도메인(`hub.kosa.kr`) 기반 이미지 저장소 운영

- **인증서 및 사용자 관리:**
  - **OpenSSL 기반 인증서 생성:** SAN(Subject Alternative Name) 및 IP가 포함된 자가 서명 CA 및 서버 인증서(`domain.crt`) 생성
  - **계정 인증 체계:** `htpasswd`를 이용한 ID/PW 기반 Basic Auth 적용 및 Nginx 프록시 계층 연동
- **신뢰 기반 통신 환경:**
  - 모든 클라이언트 서버의 `/usr/local/share/ca-certificates/` 경로에 CA 인증서 복사 및 `update-ca-certificates` 명령 수행
  - `/etc/hosts` 파일 내 레지스트리 도메인 수동 등록 또는 cloud-init 템플릿 반영

## 3. 컨테이너 네트워크 고도화 (MacVLAN)

성능 최적화 및 기존 네트워크 인프라와의 투명한 연동 구현

- **MacVLAN 환경 기술 명세:** 도커 컨테이너에 호스트 시스템 물리 네트워크 대역의 독립적인 IP 주소 할당
- **IP 할당 및 서브넷 계획:**
  - **Subnet:** `172.16.31.0/24` (예시 대역)
  - **Gateway:** `172.16.31.1`
  - **인터페이스:** 호스트의 물리 NIC(예: `eth0`)를 부모 인터페이스로 지정
- **구축 명령어:** `docker network create -d macvlan --subnet=172.16.31.0/24 --gateway=172.16.31.1 -o parent=eth0 macvlan_net`
- **기대 효과:**
  - L2 레벨 직접 통신을 통한 네트워크 스택 오버헤드 최소화 및 통신 효율 극대화
  - 관리 및 보안 장비(IDS/IPS) 관점에서의 개별 컨테이너 식별 가시성 확보

## 4. 방화벽 정책 및 네트워크 접근 제어 (Firewall)

최소 권한 원칙(Principle of Least Privilege) 기반의 시스템 인입 트래픽 필터링

- **UFW 방화벽 운용 지침:**
  - `default deny incoming` 원칙 적용을 통한 인가되지 않은 모든 외부 접근 원천 차단
  - 서비스 필수 포트(2222, 80, 443 등) 및 내부 관리망 대역에 대한 명시적 화이트리스트 정책 수립
- **ICMP(Ping) 제어 및 정보 은닉:**
  - 네트워크 정찰 및 스캐닝 공격 차단을 위해 `/etc/ufw/before.rules` 수정을 통한 외부 Echo Request 응답 선택적 비활성화
  - 공격자로부터 내부 네트워크 구조를 은닉하는 스텔스 전략 수립
- **네트워크 세분화 (Segmentation):** Public(DMZ) 및 Private 서브넷 설계를 통한 데이터베이스 및 핵심 로직 서버의 논리적 격리 배치
