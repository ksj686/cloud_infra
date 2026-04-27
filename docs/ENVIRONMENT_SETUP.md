# Project Environment Setup Guide (Local Host)

본 문서는 프로젝트 가동을 위한 로컬 개발 환경 구축 지침임. 사용자의 역할(초기 구축자 vs 협업 참여자) 및 공통 필수 사항에 따른 단계별 절차를 제공함.

---

## 1. 전 공통 필수 런타임 설치 (Common Prerequisites)

역할과 관계없이 모든 작업자가 로컬 PC에 사전에 갖추어야 할 기본 도구

### 1.1 Node.js 및 패키지 매니저 (nvm & pnpm)

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

- **설정 최적화:** `pyproject.toml` 내 `[dependency-groups]` 표준 문법 적용 및 불필요한 빌드 시스템 섹션 제거
- **도구 버전 고정:** `pnpm add -D prettier@3.7.4`를 통해 팀 공통 포맷터 버전 고정 및 `.prettierignore` 작성

### 2.2 Git Hook 자동화 체계 설계 (Husky & pre-commit)

- **Husky 초기화:** `pnpm exec husky init` 수행
- **자동화 훅 구축:**
  - `post-merge`: 락파일 변경 시 의존성 자동 동기화 로직 구현
  - `pre-commit`: Husky가 파이썬 기반 `pre-commit` 도구를 호출하도록 브릿지 구성
- **상세 실구축 가이드:** [Git Hook 협업 자동화 플레이북](./playbooks/dev/git_hook_automation.md)을 참조하여 전 공정 수행

---

## 3. 협업 참여자 가이드 (For Collaborators & Team Members)

저장소 `clone` 이후 프로젝트에 신규 합류한 팀원이 수행해야 할 최소 온보딩 절차

### 3.1 저장소 복제 및 초기 활성화

초기 1회 수행으로 모든 자동화 훅과 개발 환경 동기화 완료

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

- **의존성 자동 동기화:** 이후 `git pull` 수행 시 락파일(`pnpm-lock.yaml`, `uv.lock`) 변경이 감지되면 패키지가 자동으로 업데이트됨(`post-merge`).
- **보안/품질 자동 검사:** 커밋 시 `pre-commit` 도구가 자동으로 실행되어 코드 무결성을 검증함.
- **사후 관리:** 협업자는 별도의 `pre-commit install` 실행 없이 `pnpm install`만으로 모든 자동화 혜택 수혜 가능.

---

## 4. 품질 관리 및 에디터 최적화 (Quality & Editor)

### 4.1 보안 감사 및 훅 관리

- **자동화된 SCA 검사:** 커밋 시 `pre-commit` 훅에 의해 `pnpm audit` 및 `pip-audit`이 자동으로 수행됨. 취약점 발견 시 커밋이 거부됨.
- **수동 훅 실행:** 전체 파일 대상의 전수 검사 시 `uv run pre-commit run --all-files` 수행

### 4.2 VS Code 환경 최적화

- **Prettier 연동:** `.vscode/settings.json` 내 `esbenp.prettier-vscode` 지정 및 저장 시 자동 포맷팅 활성화
- **YAML 경고 제거:** MkDocs 전용 Python 태그 미인식 해결을 위한 `yaml.customTags` 등록 필수 (Full URI 형식 사용)

---

## 5. 트러블슈팅 및 관리 원칙 (Troubleshooting)

### 5.1 Git Hook 충돌 (core.hooksPath 에러)

만약 `uv run pre-commit install` 실행 시 `core.hooksPath` 관련 에러가 발생한다면, 이는 Husky와 pre-commit이 설정을 공유하지 못해 발생하는 현상임.

- **해결책:** `git config --unset core.hooksPath` 실행 후 다시 `pnpm install` 수행. 본 프로젝트는 Husky가 pre-commit을 호출하는 구조이므로 별도의 `pre-commit install`이 불필요함.

### 5.2 셸 스크립트 호환성 (줄바꿈 및 인코딩)

본 프로젝트는 리눅스 인프라 구축을 목표로 하므로, 모든 스크립트 및 훅 파일은 리눅스 표준 준수 필수.

- **줄바꿈 규칙:** 반드시 **LF**(`\n`) 사용 (Windows CRLF 사용 시 shellcheck 오류 유발).
- **인코딩 규칙:** **UTF-8 (BOM 없음)** 사용.
- **자동 교정:** `.gitattributes` 설정에 의해 자동 관리되나, 에디터 기본 설정을 LF로 유지할 것을 강력 권장.

### 5.3 기타 관리 원칙

- **MkDocs 로컬 가동:** `uv run mkdocs serve -a localhost:8008`
  (MkDocs 로컬 가동 시 **8008** 포트 사용. 애플리케이션 서버 8000 포트와 분리).
- **보안 가드레일:** `.venv`, `node_modules`, `passwords.txt` 등 민감 자산의 Git 추적 원천 금지.
- **환경 현행화:** 모든 환경 변경 사항은 본 문서에 실시간 기록하여 팀 온보딩 무결성 유지.

---

## 6. 주요 도구 명령어 가이드 (Quick Reference)

프로젝트 운영 중 자주 사용되는 패키지 관리 및 환경 제어 명령어 요약.

### 6.1 Node.js (pnpm)

- **패키지 목록/검색:** `pnpm list [package]` (예: `pnpm list lodash`)
- **의존성 설치:** `pnpm add [package]` (개발용: `-D` 옵션 추가)
- **의존성 제거:** `pnpm remove [package]`
- **보안 감사:** `pnpm audit`
- **스크립트 실행:** `pnpm run [script]`

### 6.2 Python (uv)

- **패키지 정보 확인:** `uv pip show [package]` (예: `uv pip show httpx`)
- **패키지 목록:** `uv pip list`
- **의존성 추가:** `uv add [package]`
- **의존성 제거:** `uv remove [package]`
- **환경 동기화:** `uv sync` (lock 파일 기준 환경 재구축)
- **도구 실행:** `uv run [command]` (가상환경 내에서 명령 실행)
