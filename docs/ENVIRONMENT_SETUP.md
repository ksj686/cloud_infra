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

저장소 생성 및 프로젝트 초기 표준을 수립하는 관리자 전용 절차

### 2.1 프로젝트 초기화 및 표준 수립

- **의존성 그룹 정의:** `pyproject.toml` 내 `[dependency-groups]` 표준 문법 적용 및 빌드 시스템 최적화
- **포맷팅 표준 고정:** `pnpm add -D prettier@3.7.4`를 통해 팀 공통 버전 고정 및 `.prettierignore` 작성

### 2.2 Git Hook 자동화 체계 수립

- **Husky 초기화:** `pnpm exec husky init`
- **자동 동기화 스크립트 구축:** `post-merge` 훅 생성 및 락파일 감지 로직 구현
- **상세 절차서:** [Git Hook 협업 자동화 가이드](./playbooks/dev/git_hook_automation.md) 참조하여 실구축 수행

---

## 3. 협업 참여자 가이드 (For Collaborators & Team Members)

저장소 `clone` 이후 프로젝트에 신규 합류한 팀원이 수행해야 할 온보딩 절차

### 3.1 저장소 복제 및 초기 활성화

```powershell
# 1. 저장소 복제
git clone <repository_url>
cd cloud_infra

# 2. 통합 의존성 설치 및 Husky 훅 활성화 (최초 1회 필수)
pnpm install
uv sync

# 3. 보안 및 품질 검사(pre-commit) 훅 등록
uv run pre-commit install
```

### 3.2 자동화 적용 확인

- 설정 완료 후 `git pull` 수행 시 락파일 변경이 감지되면 패키지가 자동으로 업데이트됨.
- 별도의 수동 설치 명령 없이 최신 개발 환경 상시 유지 가능.

---

## 4. 품질 관리 및 에디터 최적화 (Quality & Editor)

### 4.1 수동 보안 검사 (SCA)

- **Node.js:** `pnpm audit`
- **Python:** `uv run pip-audit`

### 4.2 에디터 연동 (VS Code 권장)

- **Prettier 동기화:** `.vscode/settings.json` 내 `esbenp.prettier-vscode` 지정 필수
- **YAML 경고 제거:** MkDocs 전용 Python 태그(!!python/name)에 대한 `customTags` 등록 필수

---

## 5. 트러블슈팅 및 관리 원칙

- **포트 준수:** MkDocs 로컬 가동 시 **8008** 포트 사용 (파이썬 서버 충돌 방지)
- **보안 준수:** `.venv`, `node_modules`, `passwords.txt` 등 민감 자산 Git 추적 금지
- **환경 현행화:** 모든 환경 변경 사항은 본 문서에 실시간 기록하여 온보딩 무결성 유지
