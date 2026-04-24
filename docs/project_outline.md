# Cloud Infrastructure Technical Blueprint (Phase 1-6)

**목적:** 엔터프라이즈급 보안 표준 환경 구축을 위한 단계별 기술 요구사항 및 설계 원칙 정의
**핵심 원칙:** 보안(Security), 가용성(Availability), 자동화(Automation), 최적화(Optimization)

---

## Phase 1: Foundation (기초 시스템 및 OS) {: #phase-1 }

**목표:** OS 안정성 확보 및 시스템 보안 하드닝 기초 수립

- **가상화 전략:**
  - Proxmox VE: 프라이빗 클라우드 구축을 위한 메인 하이퍼바이저로 운용
  - VMware: 로컬 샌드박스 및 프로토타입 검증용 보조 환경으로 활용
- **유지보수 자동화:**
  - `unattended-upgrades`: 보안 패치 자동 적용을 통한 제로데이 취약점 노출 최소화
  - 시스템 최적화: `apt autoremove` 및 `apt clean`을 이용한 디스크 잔여 패키지 제거 및 파일 시스템 안정성 유지
- **접근 제어 (Access Control):**
  - SSH 하드닝: `PasswordAuthentication no`, `PubkeyAuthentication yes` 설정을 통한 무차별 대입 공격 원천 봉쇄
  - Root 권한 제한: `PermitRootLogin no` 설정 및 일반 계정 접속 후 `sudo` 활용을 통한 권한 상승 이력 관리
- **시스템 감사 (Audit):**
  - `auditd` 정책 수립: `/etc/passwd`, `/etc/shadow`, `/etc/sudoers` 등 핵심 설정 파일의 변경 및 민감 명령어 실행 추적성 확보

## Phase 2: Perimeter (네트워크 및 경계 보안) {: #phase-2 }

**목표:** 네트워크 세분화 및 트래픽 제어를 통한 외부 위협 차단

- **부하 분산 및 가용성:**
  - Nginx 리버스 프록시: 업스트림 서버 부하 분산 및 백엔드 서버의 실제 IP 노출 방지(IP Masking)
- **네트워크 격리 및 고도화:**
  - Public/Private 서브넷 설계: 데이터베이스 및 내부 핵심 서비스를 인터넷으로부터 완전 격리 배치
  - **MacVLAN 도입:** 컨테이너에 호스트 네트워크 대역의 독립 IP를 할당하여 통신 효율성 및 관리 가시성 극대화
- **방화벽 정책 (Firewall):**
  - `UFW/IPTables`: `default deny incoming` 원칙 기반의 최소 포트 개방 정책 적용
  - **ICMP(Ping) 제어:** 정보 노출 방지를 위한 선택적 응답 비활성화 및 외부 정찰 차단 전략 수립
- **데이터 전송 보안:**
  - TLS 강제화: 모든 서비스 접점에 HSTS(HTTP Strict Transport Security) 및 TLS 1.3 기반 암호화 통신 적용

## Phase 3: Persistence (데이터 및 스토리지 가용성) {: #phase-3 }

**목표:** 데이터 손실 방지 및 고가용 스토리지 체계 구축
**관련 정책:** [백업 및 복구 정책](./policies/backup_policy.md)

- **엔터프라이즈 백업 (Backup Server):**
  - Proxmox Backup Server (PBS): 증분 백업 및 청크 단위 중복 제거 기술을 통한 스토리지 효율성 및 백업 자동화 구현
- **스토리지 가용성 (RAID/LVM/ZFS):**
  - 결함 허용 설계: RAID 1/5 및 ZFS 미러링 구성을 통한 하드웨어 장애 시 데이터 보호 능력 강화
  - 유연한 용량 관리: LVM(Logical Volume Manager) 기반의 가변적 파티션 설계 및 무중단 온라인 확장 지원
- **컨테이너 데이터 보존:**
  - **Named Volume 및 Bind Mount:** 데이터 성격(DB, 설정, 로그)에 따른 최적화된 마운트 전략 적용으로 데이터 영속성 확보
- **백업 및 복구 전략 (DR Strategy):**
  - **RPO(복구 시점 목표):** 주요 데이터의 일 단위 백업을 통한 유실 범위 제한
  - **RTO(복구 시간 목표):** 자동화 스크립트 및 스냅샷 기능을 활용한 수 시간 이내 서비스 복원 지향

## Phase 4: Observability (운영 가시성 및 성능 최적화) {: #phase-4 }

**목표:** 실시간 모니터링, 성능 튜닝 및 자동 장애 대응 체계 구축을 통한 서비스 가용성 극대화
**관련 정책:** [로그 보존 및 관리 정책](./policies/log_policy.md)

- **고가용성 유지 (High Availability):**
  - 하이퍼바이저 HA: Proxmox 3노드 이상 클러스터 구성을 통한 노드 장애 시 VM 자동 페일오버 보장
  - 셀프 힐링 (Self-healing): 프로세스 비정상 종료 감지 시 시스템 유닛(Systemd) 또는 별도 스크립트를 통한 자동 재기동 구현
- **성능 분석 및 튜닝 (Optimization):**
  - **애플리케이션 프로파일링:** APM(Pinpoint, Scouter) 도구를 활용하여 Throttling 원인 분석 및 코드/쿼리 병목 개선
  - **Stress 기반 검증:** `stress` 도구를 이용한 극한 부하 시뮬레이션 수행 및 자원 할당량(cgroups) 최적화
  - **환경 동기화:** 호스트-컨테이너 간 타임존(Timezone) 일치화를 통한 로그 분석 무결성 확보
- **모니터링 및 알림:**
  - 리소스 임계치 관리: CPU/MEM/DISK 사용률 90% 초과 시 Webhook 기반 즉각 알림 송출
  - **통합 상태 리포트:** 매일 정기적으로 시스템 가동 시간, 실패한 프로세스, Crontab 작업 상태를 요약한 보고서 자동 생성
- **로그 및 서비스 최적화:**
  - `Logrotate`: 로그 로테이션 및 압축을 통한 디스크 풀(Full) 장애 예방
  - Nginx 튜닝: 정적 파일 캐싱 및 Gzip 압축 적용을 통한 응답 지연 시간 최적화

## Phase 5: Pipeline (보안 자동화 및 이미지 관리) {: #phase-5 }

**목표:** 공급망 보안 강화 및 인프라 변경 신뢰성 확보

- **로컬 보안 검증 (Local Security):**
  - `pre-commit`/`Gitleaks`: 로컬 스테이징 단계에서 API Key, Secret Token 등 민감 정보 유출 사전 차단
- **지속적 통합 보안 (CI Security):**
  - `Semgrep`: SAST 기반의 소스 코드 내 보안 취약점(Insecure Patterns) 탐지 자동화
  - `pnpm audit` / `pip-audit`: 프로젝트 종속성 라이브러리(Node.js, Python)의 알려진 취약점(CVE) 스캔 및 업그레이드 유도
- **기업형 이미지 관리:**
  - **Harbor Registry:** 사설 저장소 구축을 통한 이미지 권한 관리 및 내장 엔진 기반 취약점 자동 스캔 연동
- **패키지 검사:**
  - `Trivy`: 컨테이너 이미지 아티팩트 및 OS 패키지의 보안 결함 분석 후 Slack 연동 통보

## Phase 6: Scalability (IaC 및 하이브리드 확장) {: #phase-6 }

**목표:** 인적 실수 배제 및 인프라 프로비저닝 자동화

- **인프라 프로비저닝 (IaC):**
  - Terraform: Proxmox API 연동을 통한 선언적 방식의 VM 생성 및 환경 복제 자동화
- **구성 관리 (Configuration Management):**
  - Ansible Playbook: 모든 서버의 보안 설정 및 패키지 구성을 코드화하여 환경 일관성(Idempotency) 유지
- **심화 로드맵:**
  - **설정 및 배포 자동화:** Helm Chart 기반 패키징 및 Argo CD를 활용한 GitOps 운영 체계 구축
  - **서비스 메시(고급):** Istio 사이드카 도입을 통한 정밀 트래픽 제어 및 서비스 간 mTLS 보안 강화
  - DB 가용성 고도화: MariaDB Galera Cluster 기반의 동기식 이중화 및 ProxySQL 부하 분산 구현
  - **오토 스케일링:** 트래픽 부하에 따른 리소스 동적 할당 및 인스턴스 확장 체계 연구
  - 하이브리드 확장: 온프레미스와 퍼블릭 클라우드 간의 유연한 자원 연동(Cloud Bursting) 체계 분석

## Phase 7: Hybrid Cloud (AWS Integration) {: #phase-7 }

**목표:** 클라우드 리소스 연동을 통한 서비스 가속 및 보안 경계 확장

- **클라우드 스토리지 (S3):**
  - 정적 자산 오프로딩(Offloading): 서버 I/O 부하 절감을 위해 대용량 파일 및 정적 데이터를 S3로 이관
  - **보안 강화(OAC):** S3 버킷에 대한 직접 접근을 차단하고 오직 CloudFront를 통한 인가된 접근만 허용
- **글로벌 전송 가속 (CDN):**
  - **CloudFront 도입:** 전 세계 엣지 로케이션 캐싱을 통한 응답 지연 시간(Latency) 최소화
  - 전송 암호화: ACM 인증서 기반의 전 구간 HTTPS 통신 및 TLS 최신 프로토콜 적용
- **하이브리드 자동화 (IaC):**
  - Terraform 기반 관리: 온프레미스(Proxmox)와 클라우드(AWS) 리소스를 단일 코드로 통합 프로비저닝
