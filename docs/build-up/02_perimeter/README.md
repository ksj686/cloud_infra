# [Phase 2] Perimeter: 네트워크 및 경계 보안

네트워크 세분화 및 트래픽 제어를 통한 인프라 방어선 구축 절차

---

## 1. 외부 트래픽 제어 (Nginx)

- **리버스 프록시 구축:** Nginx 설치 및 외부 요청의 백엔드 분산 처리 설정
- **보안 헤더 적용:** HSTS, X-Frame-Options 등 보안 강화를 위한 HTTP 헤더 구성
- **SSL/TLS 강제화:** Let's Encrypt 또는 사설 인증서를 통한 모든 통신 암호화 적용

## 2. 네트워크 고도화 (MacVLAN)

- **MacVLAN 구성:** 도커 컨테이너에 호스트 네트워크 대역의 독립 IP 할당 (`docker network create -d macvlan ...`)
- **통신 효율화:** L2 레벨의 직접 통신을 통한 오버헤드 감소 및 관리 가시성 확보

## 3. 방화벽 및 접근 정책 (Firewall)

- **UFW 정책 수립:** `default deny` 기반의 최소 허용 포트(80, 443, 2222 등) 설정
- **ICMP 제어:** 무분별한 외부 정찰 차단을 위해 Ping 응답(ICMP Echo) 선택적 비활성화
- **IP 마스킹:** 리버스 프록시를 통한 백엔드 서버의 실제 내부 IP 은닉
