# Cloud Infra Project: 실무 기반 인프라 구축 및 운영

본 프로젝트는 보안성, 가용성, 자동화를 핵심 가치로 하는 실무 수준의 클라우드 인프라 설계 및 운영 가이드임.

---

## 1. 프로젝트 개요 (Overview)
- **목적:** 안정적이고 보안이 강화된 리눅스 기반 인프라 아키텍처 설계 및 운영 표준 정립함.
- **핵심 원칙:**
    - **Security:** SSH 키 기반 인증, 방화벽 최적화, 정기 보안 감사 수행함.
    - **Availability:** RAID/LVM 기반 스토리지 설계, 자동 백업 및 복구 체계 구축함.
    - **Automation:** 쉘 스크립트 및 IaC(Ansible)를 이용한 운영 자동화 구현함.

## 2. 기술 스택 (Tech Stack)
- **OS:** Ubuntu Server 24.04 LTS, Alpine Linux.
- **Web/Proxy:** Nginx.
- **Storage:** RAID 0/1/5, LVM.
- **Automation:** Bash Shell, Ansible (Planned).
- **Monitoring:** Cron-based reporting, Slack Webhook.

## 3. 문서 시스템 가이드 (Documentation Guide)
- **[README.md](./README.md):** 프로젝트 전체 개요 및 아키텍처 청사진 제공함.
- **[SCENARIOS.md](./SCENARIOS.md):** 상황별 흐름 및 운영 전략(Strategy) 마스터 인덱스임.
- **[playbooks/](./playbooks/):** 실제 수행 명령어가 담긴 원자적(Atomic) 절차서(Tactics)임.
    - `build/`: 초기 설치 및 구성 절차임.
    - `ops/`: 일상 운영 및 온보딩 절차임.
    - `recovery/`: 장애 대응 및 복구 절차임.
- **[case_studies/](./case_studies/):** 실제 보안 대응 및 트러블슈팅 사례(Lessons Learned) 기록물임.

## 4. 인프라 구축 단계 (Infrastructure Phases)
- **Phase 1 (Foundation):** 시스템 기초 다지기, 하드닝 및 커널 최적화 수행함.
- **Phase 2 (Perimeter):** 보안 경계 설정, 방화벽 및 네트워크 세분화 구현함.
- **Phase 3 (Persistence):** 데이터 영속성 확보, 가용 스토리지 및 데이터 거버넌스 수립함.
- **Phase 4 (Observability):** 운영 가시성 확보, 서비스 안정화 및 가용성 관리함.
- **Phase 5 (Pipeline):** 자동화 워크플로우, 형상 관리 및 배포 자동화 구축함.
- **Phase 6 (Scalability):** 코드형 인프라 완성, 대규모 환경 복제 및 확장성 확보함.

## 5. 단계별 자동화 보안 도구 (Automated Security Tools)
| 단계 (Phase) | 도구 (Tool) | 목적 |
| :--- | :--- | :--- |
| **Phase 1: Local** | `pre-commit`, `Husky`, `Gitleaks` | 커밋 전 민감 정보 유출 차단 및 코드 품질 검사함 |
| **Phase 2: CI** | `CodeQL`, `Semgrep`, `npm/pnpm audit` | SAST 및 오픈소스 라이브러리 취약점 심층 분석함 |
| **Phase 3: Artifact** | `Trivy` | Docker 이미지 OS 및 패키지 취약점 스캔함 |
| **Phase 4: Alert** | `Slack`, `Discord`, `SMTP` | 파이프라인 실패 및 보안 이벤트 실시간 알림함 |
