# Cloud Infrastructure Project Outline (A to Z)

**프로젝트 목표:** 실무 수준 인프라 설계 및 단계적 고도화 (A to Z)
- **보안 표준 환경 구축 키트 지향:** 최소한의 설정만으로 보안 필수 체계가 완비된 인프라 환경 구축을 지원함.
**핵심 원칙:** 보안(Security), 가용성(Availability), 자동화(Automation)

---

## Phase 1: 기초 시스템 및 OS 환경 (Foundation)
**구축 단계:** 인프라의 근간이 되는 OS 안정성 및 보안 하드닝 수행

- **패키지 및 시스템 유지보수 (Maintenance)**
    - 보안 패치 최우선: `unattended-upgrades`를 통한 보안 업데이트 자동화함.
    - 안전한 디스크 정리: 시스템 안정성을 위해 `apt autoremove` 대신 `apt clean` 위주의 캐시 정리를 기본 원칙으로 함.
    - 보수적 운영: `autoremove`는 시스템 정밀 점검 시에만 삭제 목록 확인 후 제한적으로 시행함.
- **접근 제어 (Access Control)**
    - SSH 키 기반 인증 강제: 패스워드 로그인 차단 (`PasswordAuthentication no`)함.
    - Root 로그인 원격 차단: 일반 계정 접속 후 `sudo` 활용 권장함.
- **시스템 감사 (Audit)**
    - `auditd` 활용: 주요 설정 파일(` /etc/passwd` 등) 변경 및 특정 명령어 실행 기록함.

## Phase 2: 네트워크 구성 및 보안 경계 (Perimeter)
**구축 단계:** 안전한 데이터 통신을 위한 네트워크 세분화 및 경계 보안 설정

- **네트워크 세분화 (Segmentation)**
    - Public/Private 서브넷 구분: 서비스 서버 내부망 배치 및 외부 노출 최소화함.
- **방화벽 정책 (Firewall)**
    - `UFW/IPTables` 최적화: 서비스 포트 외 전체 차단 (Default Deny 정책)함.
    - ICMP(Ping) 제어: 보안 강화를 위한 Ping 응답 비활성화 고려함.
- **보안 통신**
    - 전송 구간 암호화: 모든 웹 서비스 SSL/TLS(HTTPS) 적용 필수임.

## Phase 3: 데이터 관리 및 스토리지 가용성 (Persistence)
**구축 단계:** 데이터 영속성 확보를 위한 가용 스토리지 및 백업 체계 구축
**관련 정책:** [백업 및 복구 정책](./policies/backup_policy.md)

- **스토리지 가용성 (RAID/LVM)**
    - 결함 허용 설계: RAID 1/5 등을 통한 디스크 장애 대응함.
    - 유연한 용량 관리: LVM 활용 가변적 파티션 설계 및 온라인 확장함.
- **백업 및 복구 (DR Strategy)**
    - **RPO(복구 시점 목표):** 최소 일 단위 백업 수행함.
    - **RTO(복구 시간 목표):** 스크립트 기반 자동 복구로 장애 인지 후 1시간 내 복구 지향함.
    - 백업 순환(Retention): 7일/30일 단위 보관 정책 수립 및 `find` 명령어 자동화함.

## Phase 4: 운영 가시성 및 서비스 안정화 (Observability)
**구축 단계:** 안정적 서비스 운영을 위한 모니터링 및 성능 최적화
**관련 정책:** [로그 보존 및 관리 정책](./policies/log_policy.md)

- **모니터링 및 알림 (Observability)**
    - 리소스 임계치 알림: 디스크/CPU/메모리 사용량 90% 이상 시 크론 알림함.
    - 크론탭 로깅: 모든 배치 작업 성공/실패 여부 별도 로그 기록함.
    - **전체 태스크 현황 리포트:** 매일 새벽 Crontab/At 작업 및 실행 프로세스 요약 발송 (Slack/Email)함.
- **로그 관리 (Log Management)**
    - `Logrotate` 최적화: 자동 압축 및 보관을 통한 디스크 용량 점유 방지함.
- **웹 서버 튜닝**
    - Nginx 성능 최적화: 캐싱, 압축(Gzip), 버퍼 튜닝을 통한 응답 속도 향상함.

## Phase 5: 자동화 워크플로우 및 CI/CD (Pipeline)
**구축 단계:** 인프라 변경 신뢰성 확보를 위한 단계별 보안 자동화 파이프라인 구축함.

- **로컬 보안 검증 (Local Security)**
    - `pre-commit/Husky`: 커밋 전 로컬 환경에서 자동 검사 강제함.
    - `Gitleaks`: 소스 코드 내 민감 정보(API Key, Secret) 유출 원천 차단함.
    - `ESLint/Bandit`: 언어별 정적 분석을 통한 코드 품질 및 기초 보안 확보함.
- **지속적 통합 보안 (CI Security)**
    - `CodeQL/Semgrep`: SAST(정적 분석) 기반 소스 코드 보안 취약점 심층 분석함.
    - `npm audit/pnpm audit`: SCA(오픈소스 감사) 기반 종속성 라이브러리 취약점 점검함.
- **아티팩트 및 알림 (Artifact & Alert)**
    - `Trivy`: 빌드된 Docker 이미지의 OS 및 패키지 취약점 스캔함.
    - `Slack/Email`: 보안 이벤트 및 파이프라인 실패 시 실시간 알림 연동함.

## Phase 6: 코드형 인프라 및 확장성 (Scalability)
**구축 단계:** 인적 실수 방지 및 대규모 환경 복제를 위한 IaC 체계 완성

- **서버 설정 자동화 (Ansible)**
    - Playbook 관리: OS 설정, 패키지 설치, 보안 설정 코드 관리함.
- **인프라 프로비저닝 (Terraform)**
    - 클라우드 자원 관리: AWS/Azure 등 자원 생성 및 삭제 자동화함.
