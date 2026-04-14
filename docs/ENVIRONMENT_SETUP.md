# Project Environment Setup Guide (Local Host)

본 문서는 프로젝트 가동을 위한 로컬 개발 환경(Python, Node.js) 구축 지침 및 품질 관리 절차 정리.
**※ 주의:** 본 문서는 사용자 로컬 PC(Host) 설정 전용이며, 인프라 서버(Server) 내부 설정은 `docs/build-up/` 가이드를 참조.

---

## 1. Node.js 및 패키지 관리 환경 (nvm & pnpm)

버전 파편화 방지 및 도구 버전 고정을 위한 런타임 환경 구성

### 1.1 Node.js 환경 구축 (nvm)

- **기존 버전 삭제:** `nvm` 설치 전 제어판에서 기존 모든 Node.js 버전 삭제 및 `%AppData%\npm` 폴더 잔여물 정리 필수.
- **nvm-windows 설치:** [Releases](https://github.com/coreybutler/nvm-windows/releases)에서 `nvm-setup.exe` 다운로드 및 설치.
- **Node.js LTS 적용:**
  ```powershell
  nvm install lts
  nvm use lts
  ```

### 1.2 전역 도구 설치 (Global Tools)

- **패키지 매니저 설치:** `npm install -g pnpm`
- **Gemini CLI 설치:** `npm install -g @google/gemini-cli`

### 1.3 프로젝트 로컬 의존성 및 버전 고정 (Prettier)

에디터(VS Code)와 `pre-commit` 간의 포맷팅 버전 불일치 원천 차단

- **프로젝트 초기화:** `package.json`이 없는 경우 수행 (`pnpm init`)
- **Prettier 버전 명시적 설치:**
  ```powershell
  # pre-commit에 설정된 버전(예: 3.7.4)과 일치시켜 로컬 설치
  pnpm add -D prettier@3.7.4
  ```
- **팀 협업 적용:** 신규 참여자는 `pnpm install` 실행만으로 고정된 버전의 도구 즉시 확보.

---

## 2. Python 환경 구축 (uv)

고성능 리졸버 및 파이썬 버전 관리 통합 도구인 **`uv`** 기반의 환경 구축

### 2.1 uv 설치 및 파이썬 버전 관리

- **uv 설치 (Windows PowerShell):**
  ```powershell
  powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
  ```
- **파이썬 설치 및 고정:**
  - `uv`는 별도의 `pyenv` 없이 프로젝트의 `.python-version`을 참조하여 파이썬 자동 설치 지원.
  - **수동 설치 (필요 시):** `uv python install 3.12.8`

### 2.2 가상 환경 및 의존성 관리

- **환경 초기화 및 싱크:**
  ```powershell
  # 가상 환경 생성 및 pyproject.toml 기반 의존성 자동 설치
  uv sync
  ```
- **의존성 추가:**
  - 일반 패키지: `uv add <package_name>`
  - 개발용 패키지: `uv add --dev <package_name>`

---

## 3. 품질 및 보안 관리 (pre-commit)

커밋 전 자동 줄맞춤(Prettier) 및 시크릿 유출 차단(Gitleaks) 강제화

### 3.1 설치 및 Hook 등록

```powershell
# 1. 의존성 설치 (pre-commit 포함)
uv sync

# 2. Git Hook 등록 (로컬 .git 설정에 반영)
uv run pre-commit install
```

### 3.2 수동 실행 및 보안 검사

- **전수 스타일 교정:** `uv run pre-commit run --all-files` 명령으로 즉시 스타일 교정 및 보안 검사 실행.
- **Python 의존성 감사 (SCA):**
  - **설치:** `uv add --dev pip-audit`
  - **실행:** `uv run pip-audit` 명령어를 통해 `uv.lock` 기반의 라이브러리 취약점 실시간 진단.

### 3.3 에디터 연동 및 포맷팅 동기화 (VS Code)

로컬 `node_modules`에 고정된 Prettier를 사용하여 일관성 확보

- **VS Code 권장 설정 (`.vscode/settings.json`):**
  ```json
  {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "files.eol": "\n",
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true
  }
  ```

---

## 4. MkDocs 웹 포털 가동 및 확장

- **로컬 가동:** `uv run mkdocs serve -a localhost:8008`
- **포트 충돌 방지:** 기본 8000 포트 대신 `8008` 포트 사용 준수.

---

## 5. 발표 자료 관리 및 PDF 변환 (Marp)

- **PDF 변환 명령어:**
  - **단축 스크립트 이용 (추천):** `./gen-pdf.ps1` (Windows), `./gen-pdf.sh` (macOS/Linux)
  - **직접 실행:** `npx @marp-team/marp-cli@latest docs/presentation/presentation.md --pdf`

---

## 6. 트러블슈팅 및 관리 원칙

- **한글 깨짐 (PowerShell):** `$env:PYTHONUTF8=1` 설정 사용.
- **줄바꿈(LF) 강제:** `.gitattributes` 파일을 통해 Git 수준에서 LF 형식 강제화.
- **보안 준수:** `.venv`, `node_modules`, 민감 정보 파일은 절대 Git 추적 금지.
- **상시 업데이트:** 환경 관련 모든 변경 사항은 본 문서에 즉시 기록하여 최신 상태 유지.
