# Cloud Infrastructure Project Outline (A to Z)

**프로젝트 목표:** 실무 수준 인프라 설계 및 단계적 고도화 (A to Z)
- **보안 표준 환경 구축 키트 지향:** 최소한의 설정만으로 보안 필수 체계가 완비된 인프라 환경 구축을 지원함.
**핵심 원칙:** 보안(Security), 가용성(Availability), 자동화(Automation)

---

## Phase 1: 기초 시스템 및 OS 환경 (Foundation)
**구축 단계:** 인프라의 근간이 되는 OS 안정성 및 보안 하드닝 수행

- **가상화 플랫폼 (Virtualization)**
    - VMware: 로컬 개발 및 윈도우 호스트 기반 신속 테스트 환경으로 활용함.
    - Proxmox VE: 오픈소스 기반 프라이빗 클라우드 구축 및 실서비스 운영용으로 활용함.
- **패키지 및 시스템 유지보수 (Maintenance)**
    - 보안 패치 최우선: `unattended-upgrades`를 통한 보안 업데이트 자동화함.
    - 안전한 디스크 정리: 시스템 안정성을 위해 `apt autoremove` 대신 `apt clean` 위주의 캐시 정리를 기본 원칙으로 함.
- **접근 제어 (Access Control)**
    - SSH 키 기반 인증 강제: 패스워드 로그인 차단 (`PasswordAuthentication no`)함.
    - Root 로그인 원격 차단: 일반 계정 접속 후 `sudo` 활용 권장함.
- **시스템 감사 (Audit)**
    - `auditd` 활용: 주요 설정 파일(` /etc/passwd` 등) 변경 및 특정 명령어 실행 기록함.

## Phase 2: 네트워크 구성 및 보안 경계 (Perimeter)
**구축 단계:** 안전한 데이터 통신을 위한 네트워크 세분화 및 경계 보안 설정

- **서비스 가용성 (Availability)**
    - 부하 분산(Load Balancing): Nginx 리버스 프록시를 활용한 트래픽 분산 및 장애 서버 감지함.
- **네트워크 세분화 (Segmentation)**
    - Public/Private 서브넷 구분: 서비스 서버 내부망 배치 및 외부 노출 최소화함.
- **방화벽 정책 (Firewall)**
    - `UFW/IPTables` 최적화: 서비스 포트 외 전체 차단 (Default Deny 정책)함.
- **보안 통신**
    - 전송 구간 암호화: 모든 웹 서비스 SSL/TLS(HTTPS) 적용 필수임.

## Phase 3: 데이터 관리 및 스토리지 가용성 (Persistence)
**구축 단계:** 데이터 영속성 확보를 위한 가용 스토리지 및 백업 체계 구축
**관련 정책:** [백업 및 복구 정책](./policies/backup_policy.md)

- **엔터프라이즈 백업 (Backup Server)**
    - Proxmox Backup Server (PBS): 증분 백업 및 중복 제거 기술을 통한 대규모 환경 백업 자동화함.
- **스토리지 가용성 (RAID/LVM/ZFS)**
    - 결함 허용 설계: RAID 1/5 및 Proxmox ZFS를 통한 데이터 보호 강화함.
    - 유연한 용량 관리: LVM 활용 가변적 파티션 설계 및 온라인 확장함.
- **백업 및 복구 (DR Strategy)**
    - **RPO(복구 시점 목표):** 최소 일 단위 백업 수행함.
    - **RTO(복구 시간 목표):** 스크립트 및 하이퍼바이저 기능을 통한 신속 복구 지향함.

## Phase 4: 운영 가시성 및 서비스 안정화 (Observability)
**구축 단계:** 안정적 서비스 운영을 위한 모니터링 및 성능 최적화
**관련 정책:** [로그 보존 및 관리 정책](./policies/log_policy.md)

- **고가용성 유지 (High Availability)**
    - 하이퍼바이저 HA: Proxmox 클러스터링 기반 노드 장애 시 자동 페일오버 구현함.
    - 셀프 힐링: 서비스 포트 감시 및 비정상 종료 시 자동 재기동 스크립트 운용함.
- **모니터링 및 알림 (Observability)**
    - 리소스 임계치 알림: 디스크/CPU/메모리 사용량 90% 이상 시 크론 알림함.
    - **전체 태스크 현황 리포트:** 매일 새벽 Crontab/At 작업 및 실행 프로세스 요약 발송함.

## Phase 5: 자동화 워크플로우 및 CI/CD (Pipeline)
**구축 단계:** 인프라 변경 신뢰성 확보를 위한 단계별 보안 자동화 파이프라인 구축함.

- **로컬 보안 검증 (Local Security)**
    - `pre-commit/Gitleaks`: 민감 정보 유출 차단 및 코드 품질 유지함.
- **지속적 통합 보안 (CI Security)**
    - `Semgrep`: SAST 기반 소스 코드 보안 취약점 심층 분석함.
    - `pnpm audit`: SCA 기반 종속성 라이브러리 취약점 점검함.
- **아티팩트 및 알림 (Artifact & Alert)**
    - `Trivy`: Docker 이미지 취약점 스캔 및 결과 Slack 알림 연동함.

## Phase 6: 코드형 인프라 및 확장성 (Scalability)
**구축 단계:** 인적 실수 방지 및 대규모 환경 복제를 위한 IaC 체계 완성

- **인프라 프로비저닝 (IaC)**
    - Terraform + Proxmox API: 코드 기반의 가상 머신 자동 생성 및 자원 할당 수행함.
- **서버 설정 자동화 (Ansible)**
    - Playbook 관리: 보안 하드닝 및 서비스 구성의 일관성 보장함.
- **향후 심화 과제 (Roadmap)**
    - DB 이중화: 자체 구축 DB의 실시간 복제 및 페일오버 체계 설계함.
    - 자동 확장(Auto-scaling): 부하 기반 인스턴스 오케스트레이션 구현함.
