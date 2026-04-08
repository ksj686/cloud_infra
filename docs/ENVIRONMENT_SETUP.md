# Project Environment Setup Guide

본 문서는 프로젝트 가동을 위한 Python(Poetry), Node.js(nvm) 기반 개발 환경 구축 지침 및 품질 관리(pre-commit) 절차 정리

---

## 1. Node.js 환경 구축 (nvm)

버전 파편화 방지 및 Gemini CLI 구동을 위한 표준 런타임 구성

### 1.1 기존 Node.js 삭제 (주의 사항)

- **전수 삭제:** `nvm` 설치 전 제어판에서 기존 모든 Node.js 버전 삭제 필수 (경로 충돌 예방)
- **잔여물 정리:** `C:\Program Files\nodejs` 및 `%AppData%\npm` 폴더 수동 삭제 권장

### 1.2 nvm-windows 설치 및 설정

- **설치:** [nvm-windows](https://github.com/coreybutler/nvm-windows/releases)에서 `nvm-setup.exe` 다운로드 및 설치
- **Node.js LTS 설치:**
  ```bash
  nvm install lts
  nvm use lts
  ```
- **Gemini CLI 설치:**
  ```bash
  npm install -g @google/gemini-cli
  ```

---

## 2. Python 환경 구축 (pyenv & Poetry)

프로젝트별 독립된 가상 환경 및 의존성 버전 고정 체계 수립

### 2.1 pyenv-win을 이용한 버전 동기화

- **공식 PowerShell 설치 (권장):**
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

```bash
# 1. 의존성 설치 (pre-commit 포함)
poetry install

# 2. Git Hook 등록 (중요: 클론한 환경마다 개별 실행 필요)
poetry run pre-commit install
```

### 3.2 수동 실행 및 스타일 교정

```bash
# 모든 파일에 대해 즉시 줄맞춤 및 보안 검사 실행
poetry run pre-commit run --all-files
```

### 3.3 에디터 연동 (VS Code 추천)

- **저장 시 자동 줄맞춤:** `.vscode/settings.json`에 아래 설정 추가 권장
  ```json
  {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
  ```

---

## 4. MkDocs 웹 포털 가동 및 확장

Material for MkDocs 테마 기반의 기술 문서 사이트 운영

- **로컬 가동:** `poetry run mkdocs serve`
- **주요 확장:** Mermaid 다이어그램, 코드 주석, 수식 표현 등 지원 (`mkdocs.yml` 참조)

---

## 5. 발표 자료 관리 및 PDF 변환 (Marp)

마크다운 기반 장표 관리 및 표준 PDF 문서 생성 절차

- **대상 파일:** `docs/presentation/presentation.md`
- **PDF 변환 명령어:**

  ```bash
  # 방법 A: 단축 스크립트 이용 (추천)
  ./gen-pdf.ps1  # Windows
  ./gen-pdf.sh   # macOS/Linux (chmod +x 필수)

  # 방법 B: npx 직접 실행
  npx @marp-team/marp-cli@latest docs/presentation/presentation.md --pdf
  ```

- **관리 원칙:**
  - 슬라이드 구분은 `---` 사용
  - 발표자 전용 메모는 `<!-- 주석 -->` 활용
  - 테마 및 페이지 설정은 파일 상단 YAML Frontmatter에서 조정

---

## 6. 트러블슈팅 및 관리 원칙

- **한글 깨짐 (PowerShell):** `[Console]::OutputEncoding = [System.Text.Encoding]::UTF8` 명령어로 인코딩 고정
- **의존성 불일치:** `pyproject.toml` 변경 시 반드시 `poetry lock`으로 잠금 파일 동기화
- **보안 준수:** `.venv` 및 민감 정보가 포함된 파일은 절대 Git 추적 금지 (`.gitignore` 확인)
- **상시 업데이트:** 환경 관련 모든 사항은 본 문서에 누적 기록하여 최신 상태 유지
