# Project Environment Setup Guide (Local Host)

본 문서는 프로젝트 가동을 위한 로컬 개발 환경(Python, Node.js) 구축 지침 및 품질 관리 절차 정리.
**※ 주의:** 본 문서는 사용자 로컬 PC(Host) 설정 전용이며, 인프라 서버(Server) 내부 설정은 `docs/build-up/` 가이드를 참조.

---

## 1. Node.js 및 패키지 관리 환경 (nvm & pnpm)

버전 파편화 방지 및 도구 버전 고정을 위한 런타임 환경 구성

### 1.1 Node.js 환경 구축 (nvm)

- **기존 Node.js 삭제:** `nvm` 설치 전 제어판에서 기존 모든 Node.js 버전 삭제 및 `%AppData%\npm` 폴더 잔여물 정리 필수.
- **nvm-windows 설치:** [Releases](https://github.com/coreybutler/nvm-windows/releases)에서 `nvm-setup.exe` 다운로드 및 설치.
- **Node.js LTS 설치 및 적용:**
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

## 2. Python 환경 구축 (pyenv & Poetry)

프로젝트별 독립된 가상 환경 및 의존성 버전 고정 체계 수립

### 2.1 pyenv-win을 이용한 버전 동기화

- **설치 스크립트:**
  ```powershell
  Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
  ```
- **중요 사전 설정:** '앱 실행 별칭'에서 `python.exe`, `python3.exe`를 모두 **'끔'**으로 변경하여 명령어 충돌 방지
- **버전 적용:**
  ```bash
  # .python-version 파일에 명시된 버전과 일치화
  pyenv install 3.12.8
  pyenv local 3.12.8
  ```

### 2.2 Poetry 설치 및 가상 환경 관리

- **Poetry 설치:**
  ```powershell
  (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
  ```
- **PATH 등록 (CRITICAL):** 설치 로그 하단의 **`Add ... to your PATH`** 뒤에 표시된 **절대 경로**를 시스템 환경 변수 `Path` 최상단에 직접 등록 필수
- **프로젝트 내부 가상 환경 설정:**
  ```bash
  poetry config virtualenvs.in-project true
  ```

### 2.3 의존성 초기화 및 설치 (상황별 절차)

- **Initial Setup:** `poetry init` 후 `poetry add mkdocs-material mkdocs-mermaid2-plugin` 실행
- **Joining Project:** `poetry lock` (설정 변경 시) 후 `poetry install` 실행

---

## 3. 품질 및 보안 관리 (pre-commit)

커밋 전 자동 줄맞춤(Prettier) 및 시크릿 유출 차단(Gitleaks) 강제화

### 3.1 설치 및 Hook 등록 (상황별 절차)

#### A. 프로젝트 최초 설정 시 (Project Creator)

`pyproject.toml`에 의존성을 추가하고 훅을 활성화하는 최초 1회 작업

```bash
# 1. 개발 의존성으로 툴 설치
poetry add --group dev pre-commit

# 2. Git Hook 등록 (로컬 .git 설정에 반영)
poetry run pre-commit install
```

#### B. 저장소 클론 후 신규 참여 시 (Contributors) - 필수

패키지 설치 후 **로컬 Git 훅 활성화**를 위해 반드시 수행

````bash
### 3.1 설치 및 Hook 등록
```powershell
# 1. 의존성 설치 (pre-commit 포함)
poetry install

# 2. Git Hook 등록 (로컬 .git 설정에 반영)
poetry run pre-commit install
````

### 3.2 수동 실행 및 스타일 교정

```bash
# 모든 파일에 대해 즉시 줄맞춤 및 보안 검사 실행
poetry run pre-commit run --all-files
```

### 3.3 에디터 연동 및 포맷팅 동기화 (VS Code)

로컬 `node_modules`에 고정된 Prettier를 사용하여 일관성 확보

- **VS Code 권장 설정 (`.vscode/settings.json`):**
  ```json
  {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
  ```
- **작동 원리:** 프로젝트 로컬에 설치된 `prettier` 패키지 버전을 자동으로 참조하여 포맷팅 수행.

---

## 4. MkDocs 웹 포털 가동 및 확장

Material for MkDocs 테마 기반의 기술 문서 사이트 운영

- **로컬 가동:** `poetry run mkdocs serve -a localhost:8008`
- **포트 지정:** 파이썬 애플리케이션 서버(8000)와의 포트 충돌 방지를 위해 `8008` 포트 사용 권장.
- **주요 확장:** Mermaid 다이어그램, 코드 주석, 수식 표현 등 지원 (`mkdocs.yml` 참조).

---

## 5. 발표 자료 관리 및 PDF 변환 (Marp)

마크다운 기반 장표 관리 및 표준 PDF 문서 생성 절차

- **대상 파일:** `docs/presentation/presentation.md`
- **PDF 변환 명령어:**
  - **단축 스크립트 이용 (추천):** `./gen-pdf.ps1` (Windows), `./gen-pdf.sh` (macOS/Linux)
  - **직접 실행:** `npx @marp-team/marp-cli@latest docs/presentation/presentation.md --pdf`
- **관리 원칙:** 슬라이드 구분(`---`), 발표자 전용 메모(`<!-- 주석 -->`) 및 YAML Frontmatter 조정 지침 준수.

---

## 6. 트러블슈팅 및 관리 원칙

- **한글 깨짐 (PowerShell):** `$env:PYTHONUTF8=1` 또는 인코딩 고정 명령 사용.
- **의존성 불일치:** `pyproject.toml` 변경 시 반드시 `poetry lock`으로 잠금 파일 동기화.
- **보안 준수:** `.venv`, `node_modules`, 민감 정보 파일은 절대 Git 추적 금지 (`.gitignore` 확인).
- **상시 업데이트:** 환경 관련 모든 변경 사항은 본 문서에 즉시 기록하여 최신 상태 유지.
