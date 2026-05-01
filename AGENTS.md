# Agent Instructions

이 파일은 Codex가 `cloud_infra` 저장소에서 작업할 때 우선 적용할 프로젝트 지침이다. 문서 품질과 프로젝트 연속성을 유지하는 데 목적이 있다.

## 프로젝트 성격

- MkDocs Material 기반의 Cloud Infrastructure 문서화 프로젝트.
- 주요 문서는 `docs/` 하위에 위치하며, 루트의 `new_content.md`, `new_content1.md`, `which_should_be_included.md` 등은 정식 반영 전 검토용 작업 노트로 취급.
- `mkdocs.yml`이 사이트 내비게이션을 관리하며, `resources/lecture/**`는 `exclude_docs`로 빌드 대상에서 제외.
- 문서는 한국어 기술 문서 작성을 원칙으로 하며, 기존 용어와 기술 맥락을 보존.

## 인프라 Phase 기준

새로운 강의 내용, 실습, 아키텍처 설명, 운영 가이드를 추가하거나 정리할 때 해당 내용이 어느 Phase에 속하는지 판단하여 반영.

- Phase 1: OS/기초. 시스템 설치, 하드닝, 커널 최적화, 감사(Audit).
- Phase 2: Network/보안. 방화벽 설계, 서브넷 관리, 암호화 통신, 게이트웨이.
- Phase 3: Storage/데이터. RAID/LVM, 백업, 복구(DR), 데이터 지속성.
- Phase 4: Ops/운영. 모니터링, 로그 분석, 서비스 가용성, 운영 튜닝.
- Phase 5: CI/CD/자동화. 워크플로우 자동화, 보안 스캔, GitOps.
- Phase 6: IaC/확장. Ansible/Terraform, 환경 복제, 스케일링.
- Phase 7: Hybrid Cloud. 온프레미스와 클라우드 연동, 공통 인터페이스, 환경별 설정 분리.

하위 Phase의 전제가 부족한 상태에서 상위 Phase 내용을 확장하지 않도록 의존 관계를 확인. 필요한 경우 선행 Phase 보완 항목을 함께 제안.

## 문서 동기화 원칙

- 설계 변경 시 `docs/architecture/project_outline.md`의 Phase별 구축 순서와 보안/자동화 원칙에 어긋나지 않는지 확인.
- 새로운 실습 항목은 가능한 한 `docs/labs/` 하위에 실습 가이드(`README.md`)와 실행 파일을 함께 구성.
- 환경 설정, 개발 도구, MkDocs 설정, 시스템 변수, hook, dependency 변경은 `docs/management/ENVIRONMENT_SETUP.md`에 반영.
- 주요 설계, 운영 정책, 실습 구조 변경은 `docs/management/CHANGELOG.md`에 작업 단위로 기록. 날짜가 필요한 경우 작성 직전 `Get-Date -Format "yyyy-MM-dd"`로 시스템 날짜 확인.
- 아키텍처나 실습 흐름이 바뀌면 영향 범위에 따라 다음 문서를 검토하고 필요한 부분만 갱신:
  - `README.md`
  - `docs/architecture/project_outline.md`
  - `docs/architecture/CORE_FEATURE_EXPLAINER.md`
  - `docs/management/PROJECT_WORKFLOW.md`
  - `docs/management/to-do-list.md`
  - `docs/management/CURRENT_TASK_GUIDE.md`
  - `docs/resources/presentation/`

## 핵심 관리 문서 역할

- `docs/management/PROJECT_WORKFLOW.md`: 전체 진행 상황, 차기 과제, 주요 의사결정 이력 관리.
- `docs/architecture/CORE_FEATURE_EXPLAINER.md`: 프로젝트 핵심 기술, 차별성, 보안 강점 정리.
- `docs/resources/presentation/`: 프로젝트 진척도에 따른 발표 자료와 시나리오 동기화.
- `docs/management/to-do-list.md`: 실습 로드맵과 학습 항목별 체크리스트 관리.
- `docs/management/CURRENT_TASK_GUIDE.md`: 현재 활성 작업의 단계별 실행 매뉴얼 관리.

## 작성 원칙

- 간결하고 실행 가능한 기술 문서 작성.
- 과장된 표현을 피하고 객관적인 기술 언어 사용. 예: "완벽한", "100%", "초정밀" 대신 "구체적인", "검증 가능한", "운영 가능한" 사용.
- 명령어 옵션, 설정값, 파일 경로, 기술 의존 관계를 누락하지 않음.
- 기존의 유효한 기술 정보는 보존. 새 내용과 정면으로 충돌하거나 대체 근거가 명확한 경우에만 수정.
- 여러 도구를 묶어 설명할 때 개별 도구명과 역할을 생략하지 않음. 예: `pnpm audit`, `pip-audit`, `Gitleaks`, `ShellCheck`.
- 핵심 기술 용어나 표준 약어는 처음 등장할 때 가능한 한 `한국어(English/약어)` 형식으로 명확화. 예: 단일 장애점(SPoF), 고가용성(HA).
- 정보 전달 효율을 위해 개조식(번호, 불렛 포인트)을 사용하되, 기술적 깊이가 필요한 구간에서는 충분한 설명을 제공.
- `docs/architecture/build-up/` 하위 문서는 실제 구현을 위한 상세 매뉴얼로 취급. 구조 변경이 필요하면 근거를 남기고, 기존 세부 정보가 사라지지 않도록 보완 중심으로 편집.

## 작업 절차

- 편집 전 대상 문서와 인접한 관련 문서를 먼저 읽어 기존 맥락을 파악.
- 변경 범위는 요청과 관련된 파일로 제한하고, 관련 없는 리팩터링이나 문체 변경을 섞지 않음.
- 문서 변경 후에는 필요 시 MkDocs 내비게이션(`mkdocs.yml`) 반영 여부를 확인.
- 작업 완료 전 `git status --short`로 변경 파일을 확인하고, 사용자 변경분과 내가 만든 변경분을 구분하여 보고.
- 커밋이나 푸시는 사용자가 명시적으로 요청한 경우에만 수행. 커밋 메시지를 제안할 때는 한국어로 작성하고, 변경 목적별로 그룹화.

## 도구 참고

도구 명령은 상세 절차가 필요할 때만 사용한다. `AGENTS.md`에는 전체 사용법을 길게 반복하지 않고, 이 저장소에서 자주 쓰는 기준 명령만 참고로 유지.

- 로컬 문서 확인: `uv run mkdocs serve -a localhost:8008`
- 전체 품질 검사: `uv run pre-commit run --all-files`
- Python 환경 동기화: `uv sync`
- Node 패키지 동기화: `pnpm install`

## Git 및 파일 위생

- 작업 트리에 사용자 작성 untracked 파일이 있을 수 있음. 관련 없는 파일을 삭제, 되돌리기, 덮어쓰기 금지.
- `uv.lock`, `pnpm-lock.yaml`은 직접 편집하지 않음.
- `.venv/`, `node_modules/`, `.audit_cache/`, `site/`, 로그, PDF, 임시 파일은 문서에 필요한 경우를 제외하고 추적 대상으로 추가하지 않음.
- 스크립트와 문서는 UTF-8, LF 줄바꿈 기준을 유지.
