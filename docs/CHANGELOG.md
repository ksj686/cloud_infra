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
    - `🧹 Chore`: 빌드 설정, 패키지 매니저 관리, .gitignore 수정 등 단순 유지보수 작업
- **아카이빙:** 파일 크기가 500라인을 초과하거나 분기가 바뀔 시 `docs/archives/changelogs/`로 이전 보관함.
- **최신성 유지:** 루트의 `CHANGELOG.md`는 최신 이력 위주로 관리함.

---

## [태스크 관리 최적화 및 크로스 플랫폼 스크립트 구축]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-04-08 | `🚀 Feature` | 운영체제별 Marp PDF 변환 단축 스크립트(`gen-pdf.ps1`, `gen-pdf.sh`) 구축 | `gen-pdf.ps1`, `gen-pdf.sh` |
| 2026-04-08 | `📝 Docs` | 프로젝트 규모에 따른 단계별 태스크 관리 전략(Script -> Poe -> Package) 수립 | `docs/PROJECT_WORKFLOW.md` |
| 2026-04-08 | `📝 Docs` | 단축 스크립트 활용 PDF 변환 가이드 보완 | `docs/ENVIRONMENT_SETUP.md` |

## [프로젝트 가치 입증 및 품질 관리 자동화]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-04-07 | `📝 Docs` | 발표 자료(`docs/presentation/`)를 Marp 형식으로 전면 재구성 및 발표자 스크립트 분리 | `docs/presentation/*` |
| 2026-04-07 | `🚀 Feature` | 단일 PDF 변환을 위한 통합 발표 마스터 파일(`presentation.md`) 구축 | `docs/presentation/presentation.md` |
| 2026-04-07 | `📝 Docs` | 프로젝트 핵심 기술 및 보안 특장점 설명서(`CORE_FEATURE_EXPLAINER.md`) 신규 구축 | `docs/CORE_FEATURE_EXPLAINER.md` |
| 2026-04-07 | `📝 Docs` | 발표 자료(`docs/presentation/`)를 Marp 형식으로 전면 재구성 및 발표자 스크립트 분리 | `docs/presentation/*` |
| 2026-04-07 | `🚀 Feature` | 단일 PDF 변환을 위한 통합 발표 마스터 파일(`presentation.md`) 구축 | `docs/presentation/presentation.md` |
| 2026-04-07 | `📝 Docs` | 프로젝트 발표 자료 체계(`docs/presentation/`) 구축 및 개별 파일 보관 | `docs/presentation/*` |
| 2026-04-07 | `⚙️ Refactor` | 웹 포털 내비게이션에서 발표 자료 섹션 제외 및 기술 가이드 중심의 메뉴 간소화 | `mkdocs.yml` |
| 2026-04-07 | `📝 Docs` | 핵심 특장점 및 발표 자료의 상시 최신화를 위한 `GEMINI.md` 지침 개정 | `GEMINI.md` |
| 2026-04-07 | `⚙️ Refactor` | `pre-commit` 및 ShellCheck 도입을 통한 스크립트 품질 진단 및 시크릿 유출 차단 자동화 | `.pre-commit-config.yaml`, `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-07 | `📝 Docs` | VS Code 저장 시 자동 줄맞춤 연동 지침 및 트러블슈팅 가이드 보완 | `docs/ENVIRONMENT_SETUP.md` |

## [도커 데이터 관리 전략 수립 및 로드맵 보완]

## [MkDocs UI/UX 고도화 및 그리드 UI 적용]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-04-06 | `🛠️ Fix` | 메인 페이지 카드 그리드와 기술 청사진(`project_outline.md`) 간의 앵커 링크(#phase-n) 불일치 해결 | `docs/project_outline.md` |
| 2026-04-06 | `🚀 Feature` | Material 테마 최신 기능(Footer, Annotations, Tab Sync) 활성화 및 UI 편의성 강화 | `mkdocs.yml` |
| 2026-04-06 | `🎨 Style` | 메인 페이지(`index.md`) 내 인프라 구축 단계(Phase 1-6) 시각적 그리드 카드 UI 도입 | `docs/index.md` |
| 2026-04-06 | `📝 Docs` | MkDocs 확장 기능 및 UI 확인 포인트(그리드 카드 동작 등) 환경 설정 문서 반영 | `docs/ENVIRONMENT_SETUP.md` |

## [환경 구축 절차 고도화 및 도구 설치 편의성 개선]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-04-06 | `📝 Docs` | `pyenv-win` 및 `Poetry` 설치를 위한 즉시 실행 PowerShell 명령어 추가로 환경 구축 편의성 개선 | `docs/ENVIRONMENT_SETUP.md` |

## [도커 데이터 관리 전략 수립 및 로드맵 보완]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-04-06 | `🚀 Feature` | 도커 데이터 보존 3대 방식(Bind, Named, Anonymous) 비교 및 데이터 성격별 권장 전략 가이드 구축 | `docs/to-do-space/step4_expansion/02_docker_strategy/README.md` |
| 2026-04-06 | `🚀 Feature` | `docker commit` 기반 골든 이미지 전략 및 `--net-alias` 이용 내부 로드 밸런싱 설계 가이드 추가 | `docs/to-do-space/step4_expansion/02_docker_strategy/README.md` |
| 2026-04-06 | `🧪 Test` | 바인드 마운트 DB 보호 및 네트워크 별칭 기반 로드 밸런싱 실습 항목 로드맵 추가 | `docs/to-do-list.md` |
| 2026-04-06 | `📝 Docs` | `poetry lock` 절차 및 상황별(신규/참여) 환경 구축 가이드 정밀화 | `docs/ENVIRONMENT_SETUP.md`, `docs/CURRENT_TASK_GUIDE.md` |

| 2026-04-04 | `📝 Docs` | `nvm` 설치 전 기존 Node.js 삭제 권고 및 경로 충돌 방지 지침 추가 | `docs/ENVIRONMENT_SETUP.md`, `docs/CURRENT_TASK_GUIDE.md` |
| 2026-04-04 | `📝 Docs` | Poetry 설치 시 터미널 로그를 통한 절대 경로 확인 및 PATH 등록 절차 구체화 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-03 | `⚙️ Refactor` | Python 의존성 관리 도구를 Poetry로 전환하고 결정론적 빌드 환경 구축 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-03 | `⚙️ Refactor` | Node.js 버전 관리를 위한 nvm 도입 지침 명시 및 pnpm 권장 사양 추가 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-03 | `🧹 Chore` | .venv 가상 환경 및 캐시 파일의 Git 추적 제외 규칙 강화 | `.gitignore` |

## [MkDocs 빌드 오류 수정 및 경로 일관성 확보]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-04-02 | `🚀 Feature` | Nginx 로드 밸런싱 기반 무중단 롤링 업데이트(Rolling Update) 시나리오 설계 및 반영 | `docs/SCENARIOS.md` |
| 2026-04-02 | `🔒 Security` | ClamAV 보안 스캔 인터페이스 고도화(자동 격리, 로깅, Slack 알림 기능 통합) | `docs/to-do-space/step4_expansion/03_security_clamav/clamav_scan.sh` |
| 2026-04-02 | `🛠️ Fix` | `exclude_docs` 설정 형식 오류(List -> Multiline String) 수정 및 빌드 정상화 | `mkdocs.yml` |
| 2026-04-02 | `⚙️ Refactor` | MkDocs 내비게이션 구조 최종 최적화 및 누락된 모든 문서(Scenario, Playbooks 등) 메뉴 등록 | `mkdocs.yml` |
| 2026-04-02 | `🧪 Test` | 각 실습 Step별 인덱스(README.md) 생성 및 웹 포털 내비게이션 연결성 강화 | `docs/to-do-space/*/README.md` |
| 2026-04-02 | `📝 Docs` | 문서 간 잘못된 상대 경로 및 디렉토리 직접 링크 전수 수정 | `README.md`, `docs/*.md` |

## [프로젝트 관리 및 실행 가이드 체계 구축]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-04-01 | `📝 Docs` | 대화 기반 의사결정 로그 및 향후 과업 관리를 위한 프로젝트 워크플로우 문서 생성 | `docs/PROJECT_WORKFLOW.md` |
| 2026-04-01 | `📝 Docs` | 현재 진행 중인 웹 포털 전환 및 루트 정리 작업을 위한 단계별 실행 매뉴얼 구축 | `docs/CURRENT_TASK_GUIDE.md` |
| 2026-04-01 | `📝 Docs` | MkDocs 가동 및 초기 환경 구축을 위한 영구적 환경 설정 가이드 생성 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-01 | `⚙️ Refactor` | 모든 문서 내 참조 링크 경로 최신화 및 README 가이드 보완 | `README.md`, `docs/*.md` |

## [문서 작성 원칙 강화 및 고도화 기술 분석]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-28 | `📝 Docs` | `GEMINI.md` 내 순수 명사형 종결 원칙 및 기술적 정교함 지침 강화 | `GEMINI.md` |
| 2026-03-28 | `🚀 Feature` | 고도화 기술 가이드 및 프로젝트 개선 전략 분석 문서 구축 | `knowledge_base/*` |
| 2026-03-28 | `⚙️ Refactor` | 기존 작성 문서(`project_outline.md`, `README.md`, `knowledge_base/*`, `playbooks/*`)에 순수 명사형 종결 스타일 일괄 적용 | `*.md` |
| 2026-03-28 | `🧪 Test` | 엔터프라이즈 HA(Step 6) 및 클라우드 네이티브/AI(Step 7) 실습 로드맵 확장 및 학습 공간 구축 | `to-do-list.md`, `to-do-space/*` |
| 2026-03-30 | `🚀 Feature` | MkDocs Material 기반 웹 포털 환경 구축 및 사이드바 내비게이션 구조 설계 | `mkdocs.yml` |

## [인프라 설계 상세 복구 및 가상화 전략 전환]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-27 | `📝 Docs` | `project_outline.md` 내 생략된 기술 사양 및 정책 링크 상세 복구함 | `project_outline.md` |
| 2026-03-27 | `⚙️ Refactor` | 가상화 전략을 Proxmox 중심(Main) 및 VMware 보조(Sandbox) 체계로 전환함 | `project_outline.md` |

## [가상화 인프라 및 고가용성(HA) 설계 도입]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-26 | `🚀 Feature` | Proxmox VE 기반 프라이빗 클라우드 설계 및 하이퍼바이저 HA 시나리오 추가함 | `project_outline.md`, `SCENARIOS.md` |
| 2026-03-26 | `📝 Docs` | Proxmox 설치, 클러스터링, PBS 백업 및 API 자동화 상세 가이드 구축함 | `solutions/05_proxmox_ve/*` |

## [핵심 오픈소스 솔루션 가이드 구축]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-25 | `🚀 Feature` | 현대적 인프라 운영을 위한 4대 솔루션(Airflow, Wazuh, Prometheus/Grafana, Vault) 상세 가이드 구축함 | `solutions/*`, `README.md` |

## [실습 로드맵 및 보안 학습 환경 강화]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-25 | `🧪 Test` | `project_outline.md` 구현을 위한 단계별 실습 항목(auditd, 로드 밸런싱 등) 추가 및 가이드 생성함 | `to-do-list.md`, `to-do-space/step5_advanced_security/*` |

## [프로젝트 비전 및 벤치마킹 반영]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-25 | `📝 Docs` | 프로젝트 비전(표준 환경 키트) 정립 및 유사 오픈소스 프로젝트 벤치마킹 사례 추가함 | `README.md`, `project_outline.md` |

## [SPoF 방지 및 가용성 설계 고도화]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-24 | `🚀 Feature` | SPoF 방지를 위한 가용성 아키텍처(부하 분산, 셀프 힐링) 설계 및 심화 로드맵 보완함 | `project_outline.md`, `SCENARIOS.md` |

## [보안 대응 사례 기록 체계 구축]
| 날짜 | 분류 | 수정 내용 | 수정 파일 |
| :--- | :--- | :--- | :--- |
| 2026-03-24 | `🚀 Feature` | 실제 보안 대응 사례 아카이브(`case_studies/`) 구축 및 첫 사례 기록함 | `case_studies/*`, `README.md` |

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
