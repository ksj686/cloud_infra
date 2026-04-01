# 인프라 운영 및 대응 시나리오 (Master Index)

본 문서는 특정 상황(Scenario) 발생 시 따라야 할 전체적인 흐름과 세부 실행 절차(Playbook) 안내

---

## 🟢 Scenario 1: 신규 인프라 구축 (Day 0)
- **개요:** 가상화 환경 기반 리눅스 서버 초기 설치 및 서비스 운영 환경 표준 구축
- **주요 절차:**
    1.  **가상화 플랫폼 준비:** VMware(테스트) 또는 Proxmox(운영) 설치 및 노드 구성. [Playbook: build/virt_setup.md]
    2.  **OS 하드닝 및 보안 설정:** 보안 템플릿 기반 게스트 OS 설치 및 강화. [Playbook: build/os_setup.md]
    3.  **가용 스토리지 설계 (ZFS/RAID/LVM):** 하이퍼바이저 및 게스트 레벨 스토리지 최적화. [Playbook: build/storage_setup.md]
    4.  **네트워크 및 방화벽 연동:** 하이퍼바이저 브릿지 및 UFW 화이트리스트 설정. [Playbook: build/network_ufw.md]

## 🟡 Scenario 2: 일상 운영 및 관제 (Day 1)
- **개요:** 시스템의 가시성 확보 및 주기적인 건강 상태 체크
- **주요 절차:**
    1.  **태스크 리포팅 확인:** 매일 아침 Slack 채널을 통한 Cron/At/Jobs 현황 검토. [Playbook: ops/task_reporting.md]
    2.  **리소스 모니터링:** Prometheus/Grafana를 통한 하이퍼바이저 및 VM 상태 감시. [Playbook: ops/resource_monitor.md]
    3.  **시스템 보안 감사:** Wazuh 및 auditd를 통한 침입 탐지 및 파일 변조 추적. [Playbook: ops/audit_system.md]
    4.  **안전한 인프라 업데이트:** 스냅샷 선행 후 패키지 및 커널 업데이트 시행. [Playbook: ops/safe_upgrade.md]

## 🔵 Scenario 3: 신입 사원 온보딩 (Human Operation)
- **개요:** 새로운 팀원이 합류했을 때의 서버 접속 및 가상화 자원 할당 절차
- **주요 절차:**
    1.  **SSH 키 기반 접속 보안:** 개별 키 생성 및 서버 공개키 등록 가이드. [Playbook: ops/ssh_onboarding.md]
    2.  **가상화 콘솔 계정 생성:** Proxmox 권한 기반 사용자 계정 및 API 토큰 발급.
    3.  **프로젝트 운영 정책 교육:** 전체 아키텍처 및 SCENARIOS.md 활용법 교육.

## 🔴 Scenario 4: 장애 상황 대응 및 복구 (Resilience)
- **개요:** 하이퍼바이저 장애, 하드웨어 결함 또는 데이터 유실 시 복구 절차
- **주요 절차:**
    1.  **하이퍼바이저 노드 장애:** Proxmox HA 작동 확인 및 VM 자동 페일오버 모니터링.
    2.  **RAID/ZFS 디스크 장애:** 결함 장치 식별 및 리빌딩(Rebuilding) 프로세스 수행. [Playbook: recovery/raid_rebuild.md]
    3.  **서비스 프로세스 자동 복구:** 셀프 힐링 스크립트를 통한 주요 서비스 중단 대응.
    4.  **전체 백업본 복원:** PBS(Proxmox Backup Server)를 활용한 이미지 레벨 복구. [Playbook: recovery/backup_restore.md]

## 🛡️ Scenario 5: 보안 자동화 파이프라인 (Security Pipeline)
- **개요:** 인프라 코드 및 서비스 변경 시 단계별 자동화 도구를 통한 보안 무결성 검증
- **주요 절차:**
    1.  **로컬 커밋 보안 검증:** pre-commit 및 Gitleaks를 통한 시크릿 유출 차단. [Playbook: build/security_pipeline.md]
    2.  **종속성 취약점 점검 (SCA):** pnpm audit을 활용한 라이브러리 보안 검사.
    3.  **이미지 및 인프라 스캔:** Trivy를 이용한 Docker 이미지 및 IaC 코드 취약점 스캔.
