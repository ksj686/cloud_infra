# Cloud Infrastructure Technical Blueprint (Phase 1-6)

**목적:** 엔터프라이즈급 보안 표준 환경 구축을 위한 단계별 기술 요구사항 및 설계 원칙 정의
**핵심 원칙:** 보안(Security), 가용성(Availability), 자동화(Automation)

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
- **네트워크 격리 (Segmentation):**
    - Public/Private 서브넷 설계: 데이터베이스 및 내부 핵심 서비스를 인터넷으로부터 완전 격리 배치
- **방화벽 정책 (Firewall):**
    - `UFW/IPTables`: `default deny incoming` 원칙 기반의 최소 포트 개방 정책 적용
    - ICMP(Ping) 제어: 정보 노출 방지를 위한 선택적 응답 비활성화 및 외부 정찰 차단
- **데이터 전송 보안:**
    - TLS 강제화: 모든 서비스 접점에 HSTS(HTTP Strict Transport Security) 및 TLS 1.3 기반 암호화 통신 적용

## Phase 3: Persistence (데이터 및 스토리지 가용성) {: #phase-3 }
**목표:** 데이터 손실 방지 및 고가용 스토리지 체계 구축
**관련 정책:** [백업 및 복구 정책](./policies/backup_policy.md)

- **엔터프라이즈 백업 (Backup Server):**
    - Proxmox Backup Server (PBS): 증분 백업(Incremental Backup) 및 청크 단위 중복 제거 기술을 통한 스토리지 효율성 및 백업 자동화 구현
- **스토리지 가용성 (RAID/LVM/ZFS):**
    - 결함 허용 설계: RAID 1/5 및 ZFS 미러링 구성을 통한 하드웨어 장애 시 데이터 보호 및 복구 능력 강화
    - 유연한 용량 관리: LVM(Logical Volume Manager) 기반의 가변적 파티션 설계 및 무중단 온라인 확장 지원
- **백업 및 복구 전략 (DR Strategy):**
    - **RPO(복구 시점 목표):** 주요 데이터의 일 단위 백업을 통한 유실 범위 제한
    - **RTO(복구 시간 목표):** 자동화 스크립트 및 스냅샷 기능을 활용한 수 시간 이내 서비스 복원 지향

## Phase 4: Observability (운영 가시성 및 안정화) {: #phase-4 }
**목표:** 실시간 모니터링 및 자동 장애 대응 체계 마련
**관련 정책:** [로그 보존 및 관리 정책](./policies/log_policy.md)

- **고가용성 유지 (High Availability):**
    - 하이퍼바이저 HA: Proxmox 3노드 이상 클러스터 구성을 통한 노드 장애 시 가상 머신 자동 페일오버(Failover) 보장
    - 셀프 힐링 (Self-healing): 프로세스 비정상 종료 감지 시 시스템 유닛(Systemd) 또는 별도 스크립트를 통한 자동 재기동 구현
- **모니터링 및 알림 (Observability):**
    - 리소스 임계치 관리: CPU/MEM/DISK 사용률 90% 초과 시 `msmtp` 또는 Webhook 기반 즉각 알림 송출
    - **통합 상태 리포트:** 매일 정기적으로 시스템 가동 시간, 실패한 프로세스, Crontab 작업 상태를 요약한 보고서 자동 생성
- **성능 최적화:**
    - `Logrotate`: 로그 로테이션 및 압축을 통한 디스크 풀(Full) 장애 예방
    - 서비스 튜닝: Nginx 정적 파일 캐싱 및 Gzip 압축 적용을 통한 최종 사용자 응답 지연 시간 최적화

## Phase 5: Pipeline (보안 자동화 파이프라인) {: #phase-5 }
**목표:** 코드 기반 검증을 통한 인프라 변경 신뢰성 확보

- **로컬 보안 검증 (Local Security):**
    - `pre-commit`/`Gitleaks`: 로컬 스테이징 단계에서 API Key, Secret Token 등의 민감 정보 유출 사전 차단
- **지속적 통합 보안 (CI Security):**
    - `Semgrep`: SAST 기반의 소스 코드 내 보안 취약점(Insecure Patterns) 탐지 자동화
    - `pnpm audit`: 프로젝트 종속성 라이브러리의 알려진 취약점(CVE) 스캔 및 업그레이드 유도
- **이미지 및 패키지 검사:**
    - `Trivy`: 컨테이너 이미지 아티팩트 및 OS 패키지의 보안 결함 분석 후 Slack 연동 통보

## Phase 6: Scalability (IaC 및 확장성) {: #phase-6 }
**목표:** 인적 실수 배제 및 인프라 프로비저닝 자동화

- **인프라 프로비저닝 (IaC):**
    - Terraform: Proxmox API 연동을 통한 선언적 방식의 VM 생성 및 환경 복제 자동화
- **구성 관리 (Configuration Management):**
    - Ansible Playbook: 모든 서버의 보안 설정 및 패키지 구성을 코드화하여 환경 일관성(Idempotency) 유지
- **심화 로드맵 (Roadmap):**
    - DB 가용성 고도화: 데이터베이스 실시간 이중화(Replication) 및 자동 장애 조치 설계
    - 오토 스케일링: 트래픽 부하에 따른 리소스 동적 할당 및 인스턴스 확장 체계 연구
