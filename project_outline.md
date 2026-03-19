# Cloud Infrastructure Project Outline (A to Z)

본 문서는 실무 수준의 인프라 설계를 목표로 하며, 강의 진행에 따라 지속적으로 고도화됩니다. 모든 설계는 **보안(Security)**, **가용성(Availability)**, **자동화(Automation)**를 핵심 원칙으로 합니다.

---

## [Layer 1] 기초 시스템 인프라 (Core System & OS)
*기초가 되는 OS의 안정성과 보안을 강화하는 단계입니다.*

- **OS Hardening (보안 강화)**
    - 최소 설치(Minimized) 지향: 불필요한 패키지 제거로 공격 표면 최소화.
    - 패키지 업데이트 자동화: `apt update/upgrade` 자동화 및 크론 알림 설정.
- **접근 제어 (Access Control)**
    - SSH 키 기반 인증 강제: 패스워드 로그인 차단 (`PasswordAuthentication no`).
    - Root 로그인 원격 차단: 일반 계정 접속 후 `sudo` 활용 권장.
- **시스템 감사 (Audit)**
    - `auditd` 활용: 주요 설정 파일(` /etc/passwd` 등) 변경 및 특정 명령어 실행 기록.

## [Layer 2] 네트워크 및 보안 게이트웨이 (Network & Security)
*안전한 데이터 통신과 외부 공격 차단을 설계합니다.*

- **네트워크 세분화 (Segmentation)**
    - Public/Private 서브넷 구분: 서비스 서버는 내부망 배치, 외부 노출 최소화.
- **방화벽 정책 (Firewall)**
    - `UFW/IPTables` 최적화: 서비스 포트 외 전체 차단 (Default Deny 정책).
    - ICMP(Ping) 제어: 실제 운영 환경에서는 보안을 위해 Ping 응답 비활성화 고려.
- **보안 통신**
    - 전송 구간 암호화: 모든 웹 서비스는 SSL/TLS(HTTPS) 적용 필수.

## [Layer 3] 스토리지 및 데이터 거버넌스 (Storage & Data)
*데이터의 영속성과 재해 복구 전략을 수립합니다.*

- **스토리지 가용성 (RAID/LVM)**
    - 결함 허용 설계: RAID 1/5 등을 통한 디스크 장애 대응.
    - 유연한 용량 관리: LVM을 활용한 가변적 파티션 설계 및 온라인 확장.
- **백업 및 복구 (DR Strategy)**
    - **RPO(복구 시점 목표):** 최소 일 단위 백업 수행.
    - **RTO(복구 시간 목표):** 스크립트 기반 자동 복구로 장애 인지 후 1시간 내 복구 지향.
    - 백업 순환(Retention): 7일/30일 단위 보관 정책 수립 및 `find` 명령어 자동화.

## [Layer 4] 서비스 운영 및 가용성 (Operations & Reliability)
*서비스의 성능과 운영 편의성을 극대화합니다.*

- **모니터링 및 알림 (Observability)**
    - 리소스 임계치 알림: 디스크/CPU/메모리 사용량 90% 이상 시 크론 알림.
    - 크론탭 로깅: 모든 배치 작업의 성공/실패 여부를 별도 로그로 기록.
- **로그 관리 (Log Management)**
    - `Logrotate` 최적화: 디스크 용량 점유 방지를 위한 자동 압축 및 보관.
- **웹 서버 튜닝**
    - Nginx 성능 최적화: 캐싱, 압축(Gzip), 버퍼 튜닝으로 응답 속도 향상.

## [Layer 5] CI/CD 및 형상 관리 자동화 (GitOps & CI/CD)
*인프라 변경의 신뢰성을 확보하고 자동화합니다.*

- **Pre-commit 검증**
    - 코드 품질 체크: 설정 파일(YAML 등) 구문 검증 및 Lint 적용.
    - 보안 스캔: 코드 내 시크릿(API Key 등) 노출 방지 스캔.
- **GitHub Actions Workflows**
    - 검증 자동화: 변경 사항 발생 시 테스트 VM 상에서의 구성 적합성 자동 검증.
    - 배포 자동화: 승인된 코드만 인프라에 반영되는 GitOps 체계.

## [Layer 6] 코드형 인프라 (IaC & Configuration Management)
*사람의 실수를 줄이고 동일한 환경을 반복 생산합니다.*

- **서버 설정 자동화 (Ansible)**
    - Playbook 관리: OS 설정, 패키지 설치, 보안 설정을 코드로 관리.
- **인프라 프로비저닝 (Terraform)**
    - 클라우드 자원 관리: AWS/Azure 등 자원의 생성 및 삭제를 자동화.
