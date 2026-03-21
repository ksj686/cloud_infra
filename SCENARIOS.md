# 인프라 운영 및 대응 시나리오 (Master Index)

본 문서는 특정 상황(Scenario) 발생 시 따라야 할 전체적인 흐름과 세부 실행 절차(Playbook)를 안내함.

---

## 🟢 Scenario 1: 신규 인프라 구축 (Day 0)
- **개요:** 리눅스 서버 초기 설치 및 서비스 운영 환경 표준 구축.
- **주요 절차:**
    1.  **OS 하드닝 및 보안 설정:** [Playbook: build/os_setup.md]
    2.  **가용 스토리지 설계 (RAID/LVM):** [Playbook: build/storage_setup.md]
    3.  **네트워크 및 방화벽 연동:** [Playbook: build/network_ufw.md]
    4.  **서비스(Nginx) 최적화:** [Playbook: build/nginx_config.md]

## 🟡 Scenario 2: 일상 운영 및 관제 (Day 1)
- **개요:** 시스템의 가시성 확보 및 주기적인 건강 상태 체크.
- **주요 절차:**
    1.  **태스크 리포팅 확인:** 매일 아침 Slack 채널을 통한 Cron/At/Jobs 현황 검토. [Playbook: ops/task_reporting.md]
    2.  **리소스 모니터링:** 디스크/CPU 임계치 초과 여부 확인 및 대응. [Playbook: ops/resource_monitor.md]
    3.  **시스템 보안 감사:** `auditd`를 통한 중요 파일 변조 감시 및 추적. [Playbook: ops/audit_system.md]
    4.  **정기 사용자 감사:** 불필요한 계정 및 취약한 권한 점검. [Playbook: ops/user_audit.md]
    4.  **로그 순환 최적화:** Logrotate를 통한 디스크 용량 관리. [Playbook: ops/log_rotate.md]
    5.  **안전한 인프라 업데이트:** 패키지 업데이트 리스크 관리. [Playbook: ops/safe_upgrade.md]
        - **흐름:** Backup -> Test in Staging -> Selective Update -> Verification.

## 🔵 Scenario 3: 신입 사원 온보딩 (Human Operation)
- **개요:** 새로운 팀원이 합류했을 때의 서버 접속 및 권한 부여 절차.
- **주요 절차:**
    1.  **SSH 키 기반 접속 보안:** 개별 키 생성 및 서버 공개키 등록 가이드. [Playbook: ops/ssh_onboarding.md]
    2.  **계정 생성 및 권한 부여:** 일반 계정 생성 및 sudo 그룹 지정. [Playbook: ops/account_setup.md]
    3.  **프로젝트 운영 정책 교육:** 전체 아키텍처 및 SCENARIOS.md 활용법 교육.

## 🔴 Scenario 4: 장애 상황 대응 및 복구 (Resilience)
- **개요:** 하드웨어 장애 또는 데이터 유실 발생 시 시스템 정상화 절차.
- **주요 절차:**
    1.  **RAID 디스크 장애 복구:** 결함 발생 디스크 교체 및 미러링 리빌딩. [Playbook: recovery/raid_rebuild.md]
    2.  **스토리지 부족 대응:** LVM 온라인 볼륨 확장 또는 데이터 정리. [Playbook: recovery/lvm_resize.md]
    3.  **데이터 유실 복구:** 최신 백업본(7일 내)을 활용한 시점 복구(RTO 1시간 이내). [Playbook: recovery/backup_restore.md]
    4.  **커널/부팅 불가 복구:** GRUB 응급 복구 모드를 통한 설정 원복. [Playbook: recovery/grub_rescue.md]
