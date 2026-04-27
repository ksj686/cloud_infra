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

## [강의 기반 실무 명세 보완 및 인벤토리 정교화]

| 날짜       | 분류          | 수정 내용                                                                  | 수정 파일                                               |
| :--------- | :------------ | :------------------------------------------------------------------------- | :------------------------------------------------------ |
| 2026-04-27 | `🛠️ Fix`      | `uv` 환경 내 `pip` 의존성 명시적 고정을 통한 취약점 근본 해결 및 사례 기록 | `pyproject.toml`, `docs/case_studies/*`                 |
| 2026-04-27 | `🔒 Security` | **인증서 라이프사이클 관리** 전략 수립 및 자동 갱신(Certbot) 절차 보완     | `docs/build-up/02_perimeter/*`                          |
| 2026-04-27 | `⚙️ Refactor` | K8s 재배포 전략 현업 표준화 (**Reloader Operator** 및 Helm 자동화 채택)    | `docs/standards/*`, `docs/build-up/06_scalability/*`    |
| 2026-04-27 | `📝 Docs`     | Phase 6 설계 가이드(README) 내 MetalLB 전략 반영 및 문서 동기화            | `docs/build-up/06_scalability/README.md`                |
| 2026-04-27 | `🚀 Feature`  | 온프레미스 K8s 외관 접점 확보를 위한 **MetalLB** 실구축 절차 추가          | `docs/build-up/06_scalability/IMPLEMENTATION.md`        |
| 2026-04-27 | `⚙️ Refactor` | **Checksum 어노테이션** 기반 설정 변경 자동 재배포 전략 수립               | `docs/standards/k8s_deployment_strategy.md`             |
| 2026-04-27 | `📝 Docs`     | AWS 하이브리드 보안 설계(VPC/SG) 및 목적별 DB 선정 가이드 통합             | `docs/standards/aws_s3_cloudfront_strategy.md`          |
| 2026-04-27 | `🚀 Feature`  | 하이브리드 확장 전략의 전방위 동기화 (성과 지표 명문화 및 발표 자료 반영)  | `docs/CORE_FEATURE_EXPLAINER.md`, `docs/presentation/*` |

| 2026-04-27 | `📝 Docs` | 온프레미스(MinIO)에서 클라우드(S3)로의 운영 전이(Promotion) 전략 수립 | `docs/standards/*`, `docs/project_outline.md` |

| 2026-04-27 | `⚙️ Refactor` | Phase 3 구현 지침서 내 클라우드 전이(Migration) 실무 절차 및 참조 보완 | `docs/build-up/03_persistence/IMPLEMENTATION.md` |
| 2026-04-27 | `🛠️ Fix` | Phase 3 섹션 내 누락된 백업 및 복구 정책 링크 복구 | `docs/project_outline.md` |
| 2026-04-27 | `⚙️ Refactor` | Phase 3 스토리지 전략 전면 개편 (NFS 배제 및 **Ceph/MinIO** 채택) | `docs/project_outline.md`, `docs/build-up/03_persistence/*` |
| 2026-04-27 | `⚙️ Refactor` | 단계별 설계 가이드(README)와 상세 구현 명세(Implementation) 간 기술 정합성 동기화 | `docs/build-up/**/README.md` |
| 2026-04-27 | `⚙️ Refactor` | **L7 경로 기반 라우팅(Ingress)** 개념을 반영한 Nginx 가상 호스트 명세 보완 | `docs/build-up/02_perimeter/IMPLEMENTATION.md` |
| 2026-04-27 | `📝 Docs` | 백업본 기술 지침(Git Hook 충돌 해결 및 LF 규약) 통합 및 시나리오별 가이드 완결 | `docs/ENVIRONMENT_SETUP.md` |

---

## [인벤토리 구조화 및 사용자 맞춤형 가이드 고도화]

| 날짜       | 분류          | 수정 내용                                                                    | 수정 파일                                              |
| :--------- | :------------ | :--------------------------------------------------------------------------- | :----------------------------------------------------- |
| 2026-04-24 | `📝 Docs`     | 패키지 관리 도구(pnpm, uv) 주요 명령어 퀵 레퍼런스 가이드 추가               | `docs/ENVIRONMENT_SETUP.md`                            |
| 2026-04-24 | `🧪 Test`     | **Step 7-5: Istio Sidecar 주입 실습** 공간 구축 및 샘플 매니페스트 작성      | `docs/to-do-space/step7_cloud_native_ai/*`             |
| 2026-04-24 | `📝 Docs`     | K8s 재배포 전략 가이드 내 Sidecar 도입 단계를 향후 과제(TO-BE)로 명시        | `docs/standards/*`                                     |
| 2026-04-24 | `🛠️ Fix`      | `pip-audit` 윈도우 권한 오류 해결을 위한 로컬 캐시 경로(`.audit_cache`) 적용 | `.pre-commit-config.yaml`, `.gitignore`                |
| 2026-04-24 | `🔒 Security` | SCA 종속성 보안 감사(`pip-audit`, `pnpm audit`)의 `pre-commit` 자동화 연동   | `.pre-commit-config.yaml`, `docs/ENVIRONMENT_SETUP.md` |

| 2026-04-24 | `📝 Docs` | 환경 구축 가이드 내 백업본 핵심 내용(Git Hook 충돌 해결 및 LF 규약) 통합 보완 | `docs/ENVIRONMENT_SETUP.md` |

| 2026-04-24 | `🚀 Feature` | Husky-precommit 통합 브릿지 스크립트 구축 및 충돌 해결 지침 보완 | `.husky/*`, `docs/playbooks/dev/*` |
| 2026-04-24 | `📝 Docs` | 사용자 역할(초기 구축자, 협업자, 공통) 기반 환경 구축 가이드 전면 개편 | `docs/ENVIRONMENT_SETUP.md` |

| 2026-04-24 | `⚙️ Refactor` | Phase 6 가이드 내 K8s 설정 및 배포 자동화(Helm & GitOps) 공정 정식 반영 | `docs/build-up/06_scalability/README.md` |
| 2026-04-24 | `⚙️ Refactor` | Phase 6 구현 지침서 내 Helm Chart 및 Argo CD GitOps 상세 절차 보완 | `docs/build-up/06_scalability/IMPLEMENTATION.md` |

---

## [클라우드 확장 전략 및 협업 자동화 완결]

| 날짜       | 분류         | 수정 내용                                                                                   | 수정 파일                                              |
| :--------- | :----------- | :------------------------------------------------------------------------------------------ | :----------------------------------------------------- |
| 2026-04-23 | `🛠️ Fix`     | Husky와 pre-commit 간의 `core.hooksPath` 충돌 해결 및 통합 브릿지(`.husky/pre-commit`) 구축 | `.husky/*`, `docs/ENVIRONMENT_SETUP.md`                |
| 2026-04-24 | `🚀 Feature` | K8s 설정 관리 및 재배포 전략(Helm Chart & Argo CD GitOps) 수립                              | `docs/standards/*`, `docs/project_outline.md`          |
| 2026-04-23 | `🚀 Feature` | Phase 7: Hybrid Cloud 설계 청사진 반영 및 AWS 연동 가이드 구축                              | `docs/project_outline.md`, `docs/build-up/07_hybrid/*` |

| 2026-04-23 | `🚀 Feature` | AWS S3 & CloudFront 기반의 데이터 가속 및 보안 전략(`aws_s3_cloudfront_strategy.md`) 수립 | `docs/standards/*` |
| 2026-04-23 | `🚀 Feature` | Husky 기반의 `post-merge` 자동 동기화 실구축 및 권한 설정 완료 | `.husky/*`, `docs/playbooks/dev/*` |
| 2026-04-23 | `📝 Docs` | 사용자 시나리오(초기 구축자, 협업자, 공통) 기반 환경 구축 가이드 전면 개편 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-23 | `📝 Docs` | Git Hook 자동화 가이드 내 세부 구현 절차 및 팀 협업자 지침 보완 | `docs/playbooks/dev/*` |

---

## [인프라 구축 가이드 정교화 및 기술 명세 완결]

| 날짜       | 분류          | 수정 내용                                                                         | 수정 파일               |
| :--------- | :------------ | :-------------------------------------------------------------------------------- | :---------------------- |
| 2026-04-22 | `🎨 Style`    | 역할 기반 마스터 일정(Gantt)의 5월 전환 및 Project Lead 공백 태스크 보완          | `docs/standards/*`      |
| 2026-04-22 | `🎨 Style`    | 역할 기반 병렬 트랙(Role-based Parallel Track) 중심의 프로젝트 마스터 일정 재설계 | `docs/standards/*`      |
| 2026-04-22 | `📝 Docs`     | 팀 협업 모델 내 역할 기반 병렬 로드맵(1-Month Sprint) 상세화 및 보완              | `docs/standards/*`      |
| 2026-04-22 | `📝 Docs`     | 팀 협업 모델 및 프로젝트 확장 전략(`team_collaboration_and_expansion.md`) 수립    | `docs/standards/*`      |
| 2026-04-22 | `⚙️ Refactor` | YAML 커스텀 태그 등록을 통한 `mkdocs.yml` 에디터 경고 제거 및 포맷팅 설정 강화    | `.vscode/settings.json` |

| 2026-04-22 | `📝 Docs` | Phase 1~6 전체 단계별 상세 구현 지침서(`IMPLEMENTATION.md`) 전수 구축 | `docs/build-up/**/IMPLEMENTATION.md` |

| 2026-04-22 | `🎨 Style` | MkDocs 내비게이션 내 구현 지침서 메뉴 등록 및 전체 구조 최적화 | `mkdocs.yml`, `docs/build-up/README.md` |
| 2026-04-22 | `⚙️ Refactor` | K8s 준비를 위한 Swap 비활성화 및 Cloud-init 자동화 템플릿 명세 보완 | `docs/build-up/01_foundation/README.md` |
| 2026-04-22 | `⚙️ Refactor` | YAML DRY 원칙(앵커/별칭) 및 무중단 롤링 업데이트 세부 전략 가이드 통합 | `docs/standards/*`, `docs/build-up/06_scalability/*` |

---

## [운영 프로세스 내실화 및 가용성 전략 보완]

---

## [긴급 대응 플레이북 확충 및 기록 정비]

| 날짜       | 분류          | 수정 내용                                                                | 수정 파일              |
| :--------- | :------------ | :----------------------------------------------------------------------- | :--------------------- |
| 2026-04-20 | `🔒 Security` | `git-filter-repo` 삭제 가이드 내 설치 명령어를 `uv tool` 체계로 업데이트 | `docs/playbooks/dev/*` |
| 2026-04-20 | `🔒 Security` | `git-filter-repo` 기반의 Git 히스토리 비밀번호 일괄 삭제 가이드 구축     | `docs/playbooks/dev/*` |
| 2026-04-20 | `🎨 Style`    | MkDocs 내비게이션 내 긴급 대응 플레이북(`History Cleanup`) 메뉴 등록     | `mkdocs.yml`           |

---

## [기술 자산 분류 체계 전면 개편 및 문서 구조화]

| 날짜       | 분류          | 수정 내용                                                                             | 수정 파일                        |
| :--------- | :------------ | :------------------------------------------------------------------------------------ | :------------------------------- |
| 2026-04-16 | `⚙️ Refactor` | **Engineering Standards** 섹션 신설을 통한 프로젝트 표준 가이드와 일반 지식 문서 분리 | `docs/standards/*`, `mkdocs.yml` |
| 2026-04-16 | `🎨 Style`    | MkDocs 내비게이션을 '표준 가이드'와 '기술 지식'으로 이원화하여 관리 가시성 확보       | `mkdocs.yml`                     |

---

## [파이썬 관리 도구 uv 전환 및 아키텍처 정립]

| 날짜       | 분류          | 수정 내용                                                                          | 수정 파일                                     |
| :--------- | :------------ | :--------------------------------------------------------------------------------- | :-------------------------------------------- |
| 2026-04-15 | `🚀 Feature`  | Husky 기반의 Git Hook 공유 및 의존성 자동 동기화(`post-merge`) 체계 구축           | `docs/playbooks/dev/*`, `.husky/*`            |
| 2026-04-15 | `⚙️ Refactor` | 개발자 환경 자동화 가이드를 `playbooks/dev/`로 이관하여 기술 자산 분류 체계 정교화 | `docs/playbooks/dev/*`, `mkdocs.yml`          |
| 2026-04-15 | `⚙️ Refactor` | `pyproject.toml` 구조 최적화(build-system 제거 등) 및 `uv` 표준 의존성 문법 적용   | `pyproject.toml`, `docs/ENVIRONMENT_SETUP.md` |

| 2026-04-14 | `📝 Docs` | 상세 마이그레이션 가이드(`poetry_to_uv_migration.md`) 구축 및 호스트 환경 정리 지침 보완 | `docs/knowledge_base/*` |
| 2026-04-14 | `🛠️ Fix` | 윈도우 환경 Poetry 삭제 오류 및 백신 오탐(Gitleaks) 대응 사례(`20260414_*.md`) 추가 | `docs/case_studies/*` |
| 2026-04-15 | `🚀 Feature` | Git Hook 기반 협업 자동화 가이드(`git_hook_automation.md`) 구축 및 Husky 설정 최적화 | `docs/knowledge_base/*`, `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-15 | `⚙️ Refactor` | Prettier 포맷팅 대상에서 `uv.lock` 제외를 위한 설정 업데이트 | `.prettierignore`, `.pre-commit-config.yaml` |

| 2026-04-15 | `⚙️ Refactor` | 파이썬 환경 관리 도구를 Poetry/pyenv에서 **`uv`**로 전면 전환 및 환경 구축 가이드 개편 | `docs/ENVIRONMENT_SETUP.md`, `pyproject.toml`, `docs/PROJECT_WORKFLOW.md` |

| 2026-04-14 | `⚙️ Refactor` | `pip-audit` 실행 명령어 및 가이드 내 모든 파이썬 실행 환경을 `uv run` 체계로 업데이트 | `docs/ENVIRONMENT_SETUP.md`, `docs/case_studies/*` |
| 2026-04-14 | `📝 Docs` | ADR-008 아키텍처 결정서 내 파이썬 도구 선정 근거를 `uv` 중심으로 최신화 및 재승인 | `docs/decisions/ADR-008-tech-stack-rationale.md` |

## [인프라 포맷팅 표준화 및 환경 최적화 완결]

| 날짜       | 분류       | 수정 내용                                                                                | 수정 파일               |
| :--------- | :--------- | :--------------------------------------------------------------------------------------- | :---------------------- |
| 2026-04-13 | `📝 Docs`  | 엔터프라이즈 분산 스토리지 Ceph 기술 분석 및 가이드(`ceph_storage_deep_dive.md`) 구축    | `docs/knowledge_base/*` |
| 2026-04-13 | `📝 Docs`  | 인프라(Proxmox) vs 앱(K8s/Swarm) HA 계층형 가용성 전략 분석 문서 구축                    | `docs/knowledge_base/*` |
| 2026-04-13 | `🎨 Style` | MkDocs 내비게이션에 `Build-up Guide`의 모든 Phase별 실구축 명세(AS_BUILT) 등록 및 구조화 | `mkdocs.yml`            |

| 2026-04-13 | `🔒 Security` | Python 의존성 보안 도구(`pip-audit`) 도입 및 SCA 보안 가드레일 강제화(자동 차단 로직) 상세화 | `docs/build-up/05_pipeline/*`, `docs/project_outline.md` |
| 2026-04-13 | `📝 Docs` | `ENVIRONMENT_SETUP.md` 내 `pip-audit` 설치 및 수동 실행 지침 추가 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-13 | `⚙️ Refactor` | MkDocs 로컬 가동 포트 변경(8000 -> 8008)을 통한 파이썬 서버와의 충돌 방지 | `docs/ENVIRONMENT_SETUP.md` |

| 2026-04-13 | `⚙️ Refactor` | `pnpm` 기반 Prettier 버전 고정(v3.7.4) 및 `.prettierignore` 도입을 통한 포맷팅 일관성 확보 | `.prettierignore`, `package.json`, `.pre-commit-config.yaml` |

---

## [구축 가이드 전수 복구 및 지식 베이스 체계 수립]

| 날짜       | 분류          | 수정 내용                                                                                              | 수정 파일                                      |
| :--------- | :------------ | :----------------------------------------------------------------------------------------------------- | :--------------------------------------------- |
| 2026-04-11 | `📝 Docs`     | `build-up` 가이드(Phase 2, 4, 5) 상세 맥락 복구 및 최신 Docker 기술(Healthcheck 등) 정밀 통합          | `docs/build-up/*`                              |
| 2026-04-11 | `📝 Docs`     | `GEMINI.md` 내 구축 가이드 무결성 유지 및 부주의한 누락 방지 지침 강화                                 | `GEMINI.md`                                    |
| 2026-04-11 | `⚙️ Refactor` | VS Code 저장 설정(LF 강제, 마크다운 전용 포맷터) 정밀화로 `pre-commit` 충돌 해결                       | `.vscode/settings.json`                        |
| 2026-04-11 | `📝 Docs`     | `ENVIRONMENT_SETUP.md` 내 로컬 호스트 설정 집중 및 누락된 Marp/PDF 가이드 전수 복구                    | `docs/ENVIRONMENT_SETUP.md`                    |
| 2026-04-11 | `🔒 Security` | 서버 측 Docker 보안 강화(pass/GPG) 및 cloud-init 기반 호스트 고정 지침을 Phase 1 가이드로 이관 및 통합 | `docs/build-up/01_foundation/README.md`        |
| 2026-04-11 | `📝 Docs`     | 클라우드 인프라 공통 표준 요소에 '인프라 도구 유지보수 전략' 섹션 추가                                 | `docs/knowledge_base/common_infra_elements.md` |
| 2026-04-11 | `📝 Docs`     | 엔터프라이즈 인프라 자산 관리 전략 및 프로젝트 유형 분류 지식 베이스 구축                              | `docs/knowledge_base/*`                        |
| 2026-04-11 | `🎨 Style`    | MkDocs 내비게이션에 신규 지식 베이스 문서 연동 및 구조 최적화                                          | `mkdocs.yml`                                   |

---

## [단계별 구축 가이드 수립 및 태스크 관리 최적화]

| 날짜       | 분류         | 수정 내용                                                                                | 수정 파일                                              |
| :--------- | :----------- | :--------------------------------------------------------------------------------------- | :----------------------------------------------------- |
| 2026-04-08 | `📝 Docs`    | Phase 1-6 설계안 기반의 단계별 기술 구축 가이드(`docs/build-up/`) 체계 신규 수립         | `docs/build-up/*`                                      |
| 2026-04-08 | `🚀 Feature` | 운영체제별 Marp PDF 변환 단축 스크립트(`gen-pdf.ps1`, `gen-pdf.sh`) 구축                 | `gen-pdf.ps1`, `gen-pdf.sh`                            |
| 2026-04-08 | `📝 Docs`    | 핵심 기술 용어에 대한 한국어(영어) 병기 지침 수립 및 `GEMINI.md` 반영                    | `GEMINI.md`                                            |
| 2026-04-08 | `📝 Docs`    | SPoF 및 HA 핵심 기술 개념을 포함한 발표 자료(03_high_availability.md) 정교화             | `docs/presentation/*`                                  |
| 2026-04-08 | `📝 Docs`    | 클라우드 인프라 6대 공통 표준 요소(`common_infra_elements.md`) 정의 및 팀 협업 규약 추가 | `docs/knowledge_base/*`                                |
| 2026-04-08 | `📝 Docs`    | 인프라 프로젝트 유형 분류(`infra_project_taxonomy.md`) 및 단계별 확장 로드맵 수립        | `docs/knowledge_base/*`                                |
| 2026-04-08 | `🛠️ Fix`     | Phase별 상세 구축 기록(AS_BUILT) 체계 수립 및 트러블슈팅 로그 보완                       | `docs/build-up/*`, `docs/INFRA_INVENTORY.md`           |
| 2026-04-08 | `🛠️ Fix`     | `check-yaml` 훅의 커스텀 태그 에러를 `--unsafe` 대신 `exclude` 방식으로 안전하게 해결    | `.pre-commit-config.yaml`                              |
| 2026-04-08 | `🛠️ Fix`     | `.gitattributes` 도입을 통한 쉘 스크립트 줄바꿈(LF) 강제화 (ShellCheck 오류 해결)        | `.gitattributes`                                       |
| 2026-04-08 | `🚀 Feature` | 기업용 사설 레지스트리(Harbor) 및 애플리케이션 성능 튜닝 전략 설계 반영                  | `docs/to-do-list.md`, `docs/CORE_FEATURE_EXPLAINER.md` |
| 2026-04-08 | `🚀 Feature` | MacVLAN 네트워크 설계 및 호스트-컨테이너 타임존 동기화 지침 수립                         | `docs/to-do-list.md`, `docs/presentation/*`            |
| 2026-04-08 | `🧪 Test`    | stress 도구를 이용한 부하 테스트 및 자원 제한 실습 항목 로드맵 추가                      | `docs/to-do-list.md`                                   |
| 2026-04-08 | `📝 Docs`    | 프로젝트 규모에 따른 단계별 태스크 관리 전략(Script -> Poe -> Package) 수립              | `docs/PROJECT_WORKFLOW.md`                             |
| 2026-04-08 | `📝 Docs`    | 단축 스크립트 활용 PDF 변환 가이드 보완                                                  | `docs/ENVIRONMENT_SETUP.md`                            |
| 2026-04-08 | `📝 Docs`    | `pre-commit` 설정 절차를 최초 설정(Creator)과 신규 참여(Contributor)로 구분하여 정밀화   | `docs/ENVIRONMENT_SETUP.md`                            |

---

## [프로젝트 가치 입증 및 품질 관리 자동화]

| 날짜       | 분류          | 수정 내용                                                                            | 수정 파일                                              |
| :--------- | :------------ | :----------------------------------------------------------------------------------- | :----------------------------------------------------- |
| 2026-04-07 | `📝 Docs`     | 발표 자료(`docs/presentation/`)를 Marp 형식으로 전면 재구성 및 발표자 스크립트 분리  | `docs/presentation/*`                                  |
| 2026-04-07 | `🚀 Feature`  | 단일 PDF 변환을 위한 통합 발표 마스터 파일(`presentation.md`) 구축                   | `docs/presentation/presentation.md`                    |
| 2026-04-07 | `📝 Docs`     | 프로젝트 핵심 기술 및 보안 특장점 설명서(`CORE_FEATURE_EXPLAINER.md`) 신규 구축      | `docs/CORE_FEATURE_EXPLAINER.md`                       |
| 2026-04-07 | `📝 Docs`     | 발표 자료(`docs/presentation/`)를 Marp 형식으로 전면 재구성 및 발표자 스크립트 분리  | `docs/presentation/*`                                  |
| 2026-04-07 | `🚀 Feature`  | 단일 PDF 변환을 위한 통합 발표 마스터 파일(`presentation.md`) 구축                   | `docs/presentation/presentation.md`                    |
| 2026-04-07 | `📝 Docs`     | 프로젝트 발표 자료 체계(`docs/presentation/`) 구축 및 개별 파일 보관                 | `docs/presentation/*`                                  |
| 2026-04-07 | `⚙️ Refactor` | 웹 포털 내비게이션에서 발표 자료 섹션 제외 및 기술 가이드 중심의 메뉴 간소화         | `mkdocs.yml`                                           |
| 2026-04-07 | `📝 Docs`     | 핵심 특장점 및 발표 자료의 상시 최신화를 위한 `GEMINI.md` 지침 개정                  | `GEMINI.md`                                            |
| 2026-04-07 | `⚙️ Refactor` | `pre-commit` 및 ShellCheck 도입을 통한 스크립트 품질 진단 및 시크릿 유출 차단 자동화 | `.pre-commit-config.yaml`, `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-07 | `📝 Docs`     | VS Code 저장 시 자동 줄맞춤 연동 지침 및 트러블슈팅 가이드 보완                      | `docs/ENVIRONMENT_SETUP.md`                            |

---

## [도커 데이터 관리 전략 수립 및 로드맵 보완]

---

## [MkDocs UI/UX 고도화 및 그리드 UI 적용]

| 날짜       | 분류         | 수정 내용                                                                                        | 수정 파일                   |
| :--------- | :----------- | :----------------------------------------------------------------------------------------------- | :-------------------------- |
| 2026-04-06 | `🛠️ Fix`     | 메인 페이지 카드 그리드와 기술 청사진(`project_outline.md`) 간의 앵커 링크(#phase-n) 불일치 해결 | `docs/project_outline.md`   |
| 2026-04-06 | `🚀 Feature` | Material 테마 최신 기능(Footer, Annotations, Tab Sync) 활성화 및 UI 편의성 강화                  | `mkdocs.yml`                |
| 2026-04-06 | `🎨 Style`   | 메인 페이지(`index.md`) 내 인프라 구축 단계(Phase 1-6) 시각적 그리드 카드 UI 도입                | `docs/index.md`             |
| 2026-04-06 | `📝 Docs`    | MkDocs 확장 기능 및 UI 확인 포인트(그리드 카드 동작 등) 환경 설정 문서 반영                      | `docs/ENVIRONMENT_SETUP.md` |

---

## [환경 구축 절차 고도화 및 도구 설치 편의성 개선]

| 날짜       | 분류      | 수정 내용                                                                                    | 수정 파일                   |
| :--------- | :-------- | :------------------------------------------------------------------------------------------- | :-------------------------- |
| 2026-04-06 | `📝 Docs` | `pyenv-win` 및 `Poetry` 설치를 위한 즉시 실행 PowerShell 명령어 추가로 환경 구축 편의성 개선 | `docs/ENVIRONMENT_SETUP.md` |

---

## [도커 데이터 관리 전략 수립 및 로드맵 보완]

| 날짜       | 분류         | 수정 내용                                                                                     | 수정 파일                                                       |
| :--------- | :----------- | :-------------------------------------------------------------------------------------------- | :-------------------------------------------------------------- |
| 2026-04-06 | `🚀 Feature` | 도커 데이터 보존 3대 방식(Bind, Named, Anonymous) 비교 및 데이터 성격별 권장 전략 가이드 구축 | `docs/to-do-space/step4_expansion/02_docker_strategy/README.md` |
| 2026-04-06 | `🚀 Feature` | `docker commit` 기반 골든 이미지 전략 및 `--net-alias` 이용 내부 로드 밸런싱 설계 가이드 추가 | `docs/to-do-space/step4_expansion/02_docker_strategy/README.md` |
| 2026-04-06 | `🧪 Test`    | 바인드 마운트 DB 보호 및 네트워크 별칭 기반 로드 밸런싱 실습 항목 로드맵 추가                 | `docs/to-do-list.md`                                            |
| 2026-04-06 | `📝 Docs`    | `poetry lock` 절차 및 상황별(신규/참여) 환경 구축 가이드 정밀화                               | `docs/ENVIRONMENT_SETUP.md`, `docs/CURRENT_TASK_GUIDE.md`       |

| 2026-04-04 | `📝 Docs` | `nvm` 설치 전 기존 Node.js 삭제 권고 및 경로 충돌 방지 지침 추가 | `docs/ENVIRONMENT_SETUP.md`, `docs/CURRENT_TASK_GUIDE.md` |
| 2026-04-04 | `📝 Docs` | Poetry 설치 시 터미널 로그를 통한 절대 경로 확인 및 PATH 등록 절차 구체화 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-03 | `⚙️ Refactor` | Python 의존성 관리 도구를 Poetry로 전환하고 결정론적 빌드 환경 구축 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-03 | `⚙️ Refactor` | Node.js 버전 관리를 위한 nvm 도입 지침 명시 및 pnpm 권장 사양 추가 | `docs/ENVIRONMENT_SETUP.md` |
| 2026-04-03 | `🧹 Chore` | .venv 가상 환경 및 캐시 파일의 Git 추적 제외 규칙 강화 | `.gitignore` |

---

## [MkDocs 빌드 오류 수정 및 경로 일관성 확보]

| 날짜       | 분류          | 수정 내용                                                                                | 수정 파일                                                            |
| :--------- | :------------ | :--------------------------------------------------------------------------------------- | :------------------------------------------------------------------- |
| 2026-04-02 | `🚀 Feature`  | Nginx 로드 밸런싱 기반 무중단 롤링 업데이트(Rolling Update) 시나리오 설계 및 반영        | `docs/SCENARIOS.md`                                                  |
| 2026-04-02 | `🔒 Security` | ClamAV 보안 스캔 인터페이스 고도화(자동 격리, 로깅, Slack 알림 기능 통합)                | `docs/to-do-space/step4_expansion/03_security_clamav/clamav_scan.sh` |
| 2026-04-02 | `🛠️ Fix`      | `exclude_docs` 설정 형식 오류(List -> Multiline String) 수정 및 빌드 정상화              | `mkdocs.yml`                                                         |
| 2026-04-02 | `⚙️ Refactor` | MkDocs 내비게이션 구조 최종 최적화 및 누락된 모든 문서(Scenario, Playbooks 등) 메뉴 등록 | `mkdocs.yml`                                                         |
| 2026-04-02 | `🧪 Test`     | 각 실습 Step별 인덱스(README.md) 생성 및 웹 포털 내비게이션 연결성 강화                  | `docs/to-do-space/*/README.md`                                       |
| 2026-04-02 | `📝 Docs`     | 문서 간 잘못된 상대 경로 및 디렉토리 직접 링크 전수 수정                                 | `README.md`, `docs/*.md`                                             |

---

## [프로젝트 관리 및 실행 가이드 체계 구축]

| 날짜       | 분류          | 수정 내용                                                                      | 수정 파일                    |
| :--------- | :------------ | :----------------------------------------------------------------------------- | :--------------------------- |
| 2026-04-01 | `📝 Docs`     | 대화 기반 의사결정 로그 및 향후 과업 관리를 위한 프로젝트 워크플로우 문서 생성 | `docs/PROJECT_WORKFLOW.md`   |
| 2026-04-01 | `📝 Docs`     | 현재 진행 중인 웹 포털 전환 및 루트 정리 작업을 위한 단계별 실행 매뉴얼 구축   | `docs/CURRENT_TASK_GUIDE.md` |
| 2026-04-01 | `📝 Docs`     | MkDocs 가동 및 초기 환경 구축을 위한 영구적 환경 설정 가이드 생성              | `docs/ENVIRONMENT_SETUP.md`  |
| 2026-04-01 | `⚙️ Refactor` | 모든 문서 내 참조 링크 경로 최신화 및 README 가이드 보완                       | `README.md`, `docs/*.md`     |

---

## [문서 작성 원칙 강화 및 고도화 기술 분석]

| 날짜       | 분류          | 수정 내용                                                                                                                | 수정 파일                        |
| :--------- | :------------ | :----------------------------------------------------------------------------------------------------------------------- | :------------------------------- |
| 2026-03-28 | `📝 Docs`     | `GEMINI.md` 내 순수 명사형 종결 원칙 및 기술적 정교함 지침 강화                                                          | `GEMINI.md`                      |
| 2026-03-28 | `🚀 Feature`  | 고도화 기술 가이드 및 프로젝트 개선 전략 분석 문서 구축                                                                  | `knowledge_base/*`               |
| 2026-03-28 | `⚙️ Refactor` | 기존 작성 문서(`project_outline.md`, `README.md`, `knowledge_base/*`, `playbooks/*`)에 순수 명사형 종결 스타일 일괄 적용 | `*.md`                           |
| 2026-03-28 | `🧪 Test`     | 엔터프라이즈 HA(Step 6) 및 클라우드 네이티브/AI(Step 7) 실습 로드맵 확장 및 학습 공간 구축                               | `to-do-list.md`, `to-do-space/*` |
| 2026-03-30 | `🚀 Feature`  | MkDocs Material 기반 웹 포털 환경 구축 및 사이드바 내비게이션 구조 설계                                                  | `mkdocs.yml`                     |

---

## [인프라 설계 상세 복구 및 가상화 전략 전환]

| 날짜       | 분류          | 수정 내용                                                              | 수정 파일            |
| :--------- | :------------ | :--------------------------------------------------------------------- | :------------------- |
| 2026-03-27 | `📝 Docs`     | `project_outline.md` 내 생략된 기술 사양 및 정책 링크 상세 복구함      | `project_outline.md` |
| 2026-03-27 | `⚙️ Refactor` | 가상화 전략을 Proxmox 중심(Main) 및 VMware 보조(Sandbox) 체계로 전환함 | `project_outline.md` |

---

## [가상화 인프라 및 고가용성(HA) 설계 도입]

| 날짜       | 분류         | 수정 내용                                                                 | 수정 파일                            |
| :--------- | :----------- | :------------------------------------------------------------------------ | :----------------------------------- |
| 2026-03-26 | `🚀 Feature` | Proxmox VE 기반 프라이빗 클라우드 설계 및 하이퍼바이저 HA 시나리오 추가함 | `project_outline.md`, `SCENARIOS.md` |
| 2026-03-26 | `📝 Docs`    | Proxmox 설치, 클러스터링, PBS 백업 및 API 자동화 상세 가이드 구축함       | `solutions/05_proxmox_ve/*`          |

---

## [핵심 오픈소스 솔루션 가이드 구축]

| 날짜       | 분류         | 수정 내용                                                                                          | 수정 파일                  |
| :--------- | :----------- | :------------------------------------------------------------------------------------------------- | :------------------------- |
| 2026-03-25 | `🚀 Feature` | 현대적 인프라 운영을 위한 4대 솔루션(Airflow, Wazuh, Prometheus/Grafana, Vault) 상세 가이드 구축함 | `solutions/*`, `README.md` |

---

## [실습 로드맵 및 보안 학습 환경 강화]

| 날짜       | 분류      | 수정 내용                                                                                       | 수정 파일                                                |
| :--------- | :-------- | :---------------------------------------------------------------------------------------------- | :------------------------------------------------------- |
| 2026-03-25 | `🧪 Test` | `project_outline.md` 구현을 위한 단계별 실습 항목(auditd, 로드 밸런싱 등) 추가 및 가이드 생성함 | `to-do-list.md`, `to-do-space/step5_advanced_security/*` |

---

## [프로젝트 비전 및 벤치마킹 반영]

| 날짜       | 분류      | 수정 내용                                                                         | 수정 파일                         |
| :--------- | :-------- | :-------------------------------------------------------------------------------- | :-------------------------------- |
| 2026-03-25 | `📝 Docs` | 프로젝트 비전(표준 환경 키트) 정립 및 유사 오픈소스 프로젝트 벤치마킹 사례 추가함 | `README.md`, `project_outline.md` |

---

## [SPoF 방지 및 가용성 설계 고도화]

| 날짜       | 분류         | 수정 내용                                                                         | 수정 파일                            |
| :--------- | :----------- | :-------------------------------------------------------------------------------- | :----------------------------------- |
| 2026-03-24 | `🚀 Feature` | SPoF 방지를 위한 가용성 아키텍처(부하 분산, 셀프 힐링) 설계 및 심화 로드맵 보완함 | `project_outline.md`, `SCENARIOS.md` |

---

## [보안 대응 사례 기록 체계 구축]

| 날짜       | 분류         | 수정 내용                                                            | 수정 파일                     |
| :--------- | :----------- | :------------------------------------------------------------------- | :---------------------------- |
| 2026-03-24 | `🚀 Feature` | 실제 보안 대응 사례 아카이브(`case_studies/`) 구축 및 첫 사례 기록함 | `case_studies/*`, `README.md` |

---

## [보안 자동화 파이프라인 설계]

| 날짜       | 분류         | 수정 내용                                                                | 수정 파일                                                                    |
| :--------- | :----------- | :----------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| 2026-03-21 | `🚀 Feature` | 단계별 보안 자동화 도구(Gitleaks, Trivy 등) 체계 설계 및 플레이북 생성함 | `project_outline.md`, `SCENARIOS.md`, `playbooks/build/security_pipeline.md` |
| 2026-03-21 | `🛠️ Fix`     | GitHub Push Protection 대응을 위한 예시 URL 추상화 및 오탐지 수정함      | `to-do-space/.../README.md`, `daily_report.sh`                               |

---

## [운영 정책 및 감사 시스템 수립]

| 날짜       | 분류      | 수정 내용                                                              | 수정 파일                                                                              |
| :--------- | :-------- | :--------------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| 2026-03-21 | `📝 Docs` | 백업 및 로그 보존 정책 수립 및 `auditd` 보안 감사 플레이북 생성함      | `policies/backup_policy.md`, `policies/log_policy.md`, `playbooks/ops/audit_system.md` |
| 2026-03-21 | `📝 Docs` | 백업 정책에 자체 구축(On-premise) 및 클라우드(Managed) 시나리오 반영함 | `policies/backup_policy.md`                                                            |

---

## [인프라 구축 로드맵 재설계]

| 날짜       | 분류          | 수정 내용                                                    | 수정 파일                                      |
| :--------- | :------------ | :----------------------------------------------------------- | :--------------------------------------------- |
| 2026-03-21 | `⚙️ Refactor` | 'Layer' 용어를 'Phase'로 변경하여 단계별 빌드업 흐름 강조함  | `README.md`, `project_outline.md`, `GEMINI.md` |
| 2026-03-21 | `⚙️ Refactor` | README, SCENARIOS, playbooks의 3계층 문서 체계 확립함        | `README.md`, `SCENARIOS.md`, `playbooks/*`     |
| 2026-03-21 | `⚙️ Refactor` | 모든 문서를 개조식(간결성, 명사형 종결) 스타일로 전면 개편함 | `*.md`                                         |
