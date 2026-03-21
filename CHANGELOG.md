# CHANGELOG

본 프로젝트의 주요 설계 및 설정 변경 이력을 작업 단위로 기록함.

## 📋 기록 관리 원칙 (Principles)
- **분류 체계:** 
    - `🚀 Feature`: 신규 기능 설계 및 Phase 아키텍처 추가
    - `🛠️ Fix`: 시스템 오류 수정 및 버그 해결
    - `🔥 Removal`: 불필요한 기능, 설정, 파일 및 정책 삭제
    - `🔒 Security`: 보안 하드닝, 취약점 패치 및 인증 관련 작업
    - `📝 Docs`: 가이드, 플레이북, 정책 문서의 내용 보완
    - `⚙️ Refactor`: 기능 변경 없는 구조 개선 및 용어 변경
    - `🧪 Test`: 실습(Lab) 환경 구축, 검증 스크립트 및 테스트 케이스 추가
    - `📦 Dependency`: OS 패키지 버전 업데이트 및 라이브러리 관리
    - `🎨 Style`: 개조식 변환, 포맷팅 등 문서 스타일 및 UI 개선
- **아카이빙:** 파일 크기가 500라인을 초과하거나 분기가 바뀔 시 `archives/changelogs/`로 이전 보관함.
- **최신성 유지:** 루트의 `CHANGELOG.md`는 최신 이력 위주로 관리함.

---

## [보안 대응 사례 기록 체계 구축]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-21 | `🚀 Feature` | 실제 보안 대응 사례 아카이브(`case_studies/`) 구축 및 첫 사례 기록함 | `case_studies/*`, `README.md` |

## [보안 자동화 파이프라인 설계]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-21 | `🚀 Feature` | 단계별 보안 자동화 도구(Gitleaks, Trivy 등) 체계 설계 및 플레이북 생성함 | `project_outline.md`, `SCENARIOS.md`, `playbooks/build/security_pipeline.md` |
| 2026-03-21 | `🛠️ Fix` | GitHub Push Protection 대응을 위한 예시 URL 추상화 및 오탐지 수정함 | `to-do-space/.../README.md`, `daily_report.sh` |

## [운영 정책 및 감사 시스템 수립]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-21 | `📝 Docs` | 백업 및 로그 보존 정책 수립 및 `auditd` 보안 감사 플레이북 생성함 | `policies/backup_policy.md`, `policies/log_policy.md`, `playbooks/ops/audit_system.md` |
| 2026-03-21 | `📝 Docs` | 백업 정책에 자체 구축(On-premise) 및 클라우드(Managed) 시나리오 반영함 | `policies/backup_policy.md` |

## [인프라 구축 로드맵 재설계]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-21 | `⚙️ Refactor` | 'Layer' 용어를 'Phase'로 변경하여 단계별 빌드업 흐름 강조함 | `README.md`, `project_outline.md`, `GEMINI.md` |
| 2026-03-21 | `⚙️ Refactor` | README, SCENARIOS, playbooks의 3계층 문서 체계 확립함 | `README.md`, `SCENARIOS.md`, `playbooks/*` |
| 2026-03-21 | `⚙️ Refactor` | 모든 문서를 개조식(간결성, 명사형 종결) 스타일로 전면 개편함 | `*.md` |
