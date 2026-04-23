# Project Environment Setup Guide (Local Host)

본 문서는 프로젝트 가동을 위한 로컬 개발 환경 구축 지침임. 사용자의 역할(초기 구축자 vs 협업 참여자)에 따른 맞춤형 절차를 제공함.

---

## 1. 전 공통 필수 런타임 설치 (Common Prerequisites)

역할과 관계없이 모든 작업자가 로컬 PC에 사전에 갖추어야 할 기본 도구

### 1.1 Node.js 및 전역 도구 (nvm & pnpm)

- **Node.js LTS 설치:** `nvm install lts` 후 `nvm use lts` 수행
- **패키지 매니저:** `npm install -g pnpm`
- **Gemini CLI:** `npm install -g @google/gemini-cli`

### 1.2 Python 환경 관리 (uv)

- **uv 설치:**
  ```powershell
  powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
  ```
- **설치 확인:** `uv --version` (별도의 파이썬 설치 불필요, uv가 프로젝트 설정에 맞춰 자동 관리)

---

## 2. 초기 환경 구축자 가이드 (For Project Initializer)

저장소 생성 및 프로젝트 초기 자동화 표준을 수립하는 관리자 전용 절차

### 2.1 프로젝트 초기화 및 표준 수립

- **의존성 그룹 정의:** `pyproject.toml` 내 `[dependency-groups]` 표준 문법 적용 및 빌드 시스템 최적화
- **포맷팅 표준 고정:** `pnpm add -D prettier@3.7.4`를 통해 팀 공통 버전 고정 및 `.prettierignore` 작성

### 2.2 Git Hook 자동화 체계 실구축

- **Husky 초기화:** `pnpm exec husky init` 수행
- **자동 동기화 스크립트 작성:** `.husky/post-merge` 파일 생성 및 락파일 감지 로직 구현
- **상세 실구축 가이드:** [Git Hook 협업 자동화 플레이북](./playbooks/dev/git_hook_automation.md)을 반드시 참조하여 전 공정 수행

---

## 3. 협업 참여자 가이드 (For Collaborators & Team Members)

저장소 `clone` 이후 프로젝트에 신규 합류한 팀원이 수행해야 할 최소 온보딩 절차

### 3.1 저장소 복제 및 초기 활성화

```powershell
# 1. 저장소 복제
git clone <repository_url>
cd cloud_infra

# 2. 통합 의존성 설치 (Husky 훅 자동 활성화 포함)
# 실행 시 Husky가 자동으로 Git Hook 경로를 설정하며, post-merge 및 pre-commit이 연결됨
pnpm install
uv sync
```

### 3.2 자동화 적용 확인

- 초기 활성화(3.1 단계)를 완료하면, 이후 `git pull` 수행 시 락파일 변경이 감지될 때마다 패키지가 자동으로 업데이트됨(`post-merge`).
- 커밋 시에는 `pre-commit` 도구가 자동으로 실행되어 코드 품질 및 보안 검사를 수행함.
- 협업자는 별도의 `pre-commit install` 실행 없이 `pnpm install`만으로 모든 자동화 혜택 수혜 가능.

---

## 4. 품질 관리 및 에디터 최적화 (Quality & Editor)

### 4.1 수동 보안 검사 (SCA)

- **Node.js:** `pnpm audit`
- **Python:** `uv run pip-audit`
- **수동 훅 실행:** 전체 파일에 대해 보안/포맷 검사를 수동으로 수행하려면 `uv run pre-commit run --all-files` 실행

### 4.2 에디터 연동 (VS Code 권장)

- **Prettier 동기화:** `.vscode/settings.json` 내 `esbenp.prettier-vscode` 지정 필수
- **YAML 경고 제거:** MkDocs 전용 Python 태그(!!python/name)에 대한 `customTags` 등록 필수 (Full URI 형식 권장)

---

## 5. 트러블슈팅 및 관리 원칙

### 5.1 Git Hook 충돌 (Cowardly refusing 에러)

만약 `uv run pre-commit install` 실행 시 `core.hooksPath` 관련 에러가 발생한다면, 이는 Husky와 pre-commit이 설정을 공유하지 못해 발생하는 현상임.

- **해결책:** `git config --unset core.hooksPath`를 실행한 후 다시 `pnpm install`을 수행하여 Husky 기반으로 통합 관리되도록 유도함. 본 프로젝트는 Husky가 pre-commit을 호출하는 구조이므로 별도의 `pre-commit install`이 불필요함.

### 5.2 포트 및 보안 준수

- **포트 준수:** MkDocs 로컬 가동 시 **8008** 포트 사용 (파이썬 서버 충돌 방지)
- **보안 준수:** `.venv`, `node_modules`, `passwords.txt` 등 민감 자산 Git 추적 금지
- **환경 현행화:** 모든 환경 변경 사항은 본 문서에 실시간 기록하여 온보딩 무결성 유지

### 5.3 셸 스크립트 호환성 (줄바꿈 및 인코딩)

본 프로젝트는 리눅스 인프라 구축을 목표로 하므로, 모든 `.sh` 파일과 `.husky` 훅 파일은 리눅스 표준을 준수해야 함.

- **줄바꿈 규칙:** 반드시 **LF**(`\n`) 사용. Windows 스타일의 **CRLF**(`\r\n`)는 `shellcheck` 오류를 유발함.
- **인코딩 규칙:** **UTF-8 (BOM 없음)** 사용. BOM이 포함될 경우 스크립트 실행 시 문법 오류가 발생할 수 있음.
- **자동 교정:** `.gitattributes` 설정에 의해 Git Checkout 시 자동으로 LF로 변환되나, 에디터 설정(VS Code 등)에서도 기본 줄바꿈을 LF로 설정할 것을 권장함.
