# CHANGELOG

본 프로젝트의 주요 설계 및 설정 변경 이력을 작업 단위로 기록함.

---

## [인프라 구축 로드맵 재설계]
| 날짜 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- |
| 2026-03-21 | 'Layer' 용어를 'Phase'로 변경하여 단계별 빌드업 흐름 강조함 | `README.md`, `project_outline.md`, `GEMINI.md` |

## [표준 문서 시스템 구축]
| 날짜 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- |
| 2026-03-21 | README, SCENARIOS, playbooks의 3계층 문서 체계 확립함 | `README.md`, `SCENARIOS.md`, `playbooks/*` |

## [운영 정책 및 감사 시스템 수립]
| 날짜 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- |
| 2026-03-21 | 백업 및 로그 보존 정책 수립 및 `auditd` 보안 감사 플레이북 생성함 | `policies/backup_policy.md`, `policies/log_policy.md`, `playbooks/ops/audit_system.md` |
| 2026-03-21 | 백업 정책에 자체 구축(On-premise) 및 클라우드(Managed) 시나리오 반영함 | `policies/backup_policy.md` |

## [문서 작성 표준화]
| 날짜 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- |
| 2026-03-21 | 모든 문서를 개조식(간결성, 명사형 종결) 스타일로 전면 개편함 | `*.md` |
