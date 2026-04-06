# Current Active Task Execution Guide

본 문서는 환경 관리 도구(pyenv, Poetry, nvm)의 실제 설치 및 'Step 6: 고가용성 DB 환경' 구축 착수를 위한 단계별 정밀 실행 매뉴얼

---

## 🛠️ 1단계: 개발 환경 표준화 적용 (Environment Migration)

### 1.1 Python 버전 고정 및 pyenv 설치
- **목적:** 프로젝트 권장 안정판(3.12.8) 사용 보장
- **실행 절차:**
    1.  **pyenv-win 설치 (명령어 미인식 시):**
        ```powershell
        Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
        ```
    2.  **환경 변수 반영:** 터미널 종료 후 재시작
    3.  **Python 3.12.8 설치:** `pyenv install 3.12.8`
    4.  **로컬 버전 적용:** `pyenv local 3.12.8` (프로젝트 루트에서 실행)

### 1.2 Poetry 설치 및 초기화
- **목적:** 라이브러리 의존성 관리 및 버전 고정
- **실행 절차:**
    1.  **Poetry 설치 (명령어 미인식 시):**
        ```powershell
        (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
        ```
    2.  **PATH 등록:** 설치 완료 메시지에 표시된 경로를 시스템 `Path`에 추가
        - **주의:** `%APPDATA%` 대신 `C:\Users\[사용자]\AppData\...`와 같은 **절대 경로** 사용 권장
    3.  **반영 확인:** 설정 완료 후 반드시 **모든 터미널 종료 후 재시작**
    4.  **가상환경 생성 위치 설정:**
        ```bash
        poetry config virtualenvs.in-project true
        ```
    4.  **프로젝트 초기화:** `poetry init` (Python 버전 질문 시 `^3.12` 입력)
    5.  **필수 의존성 추가:**
        ```bash
        poetry add mkdocs-material mkdocs-mermaid2-plugin
        ```
    6.  **의존성 잠금 및 동기화 (NEW):**
        ```bash
        # pyproject.toml 변경 사항을 poetry.lock에 반영
        poetry lock
        ```
    7.  **가상 환경 최종 구축 (CRITICAL):**
        ```bash
        # lock 파일 기반 패키지 실제 설치
        poetry install
        ```
        - **확인:** 프로젝트 루트에 `.venv` 폴더가 생성되었는지 확인

### 1.3 Node.js nvm 설치 및 적용
- **목적:** 프로젝트 권장 LTS 버전 사용 보장
- **실행 절차:**
    1.  **기존 Node.js 제거 (중요):** 제어판 → 프로그램 제거를 통해 기존 설치된 Node.js 삭제 (경로 충돌 방지)
    2.  **nvm-windows 설치:** [공식 릴리즈](https://github.com/coreybutler/nvm-windows/releases)에서 `nvm-setup.exe` 다운로드 및 설치
    3.  **LTS 버전 설치:**
        ```bash
        nvm install lts
        ```
    4.  **버전 적용:**
        ```bash
        nvm use lts
        ```
    5.  **pnpm 설치 (권장):**
        ```bash
        npm install -g pnpm
        ```

---

## 🚀 2단계: 웹 포털 최종 빌드 및 검증
가상 환경 기반에서의 웹 사이트 무결성 최종 확인

- **로컬 서버 실행:**
    ```bash
    poetry run mkdocs serve
    ```
- **검증 포인트:**
    - `Management Docs` 메뉴 내 `Workflow`, `Task Guide`, `Env Setup` 링크 정상 작동 확인
    - `SCENARIOS.md` 내 'Scenario 6: Rolling Update' 내용 노출 확인
    - `clamav_scan.sh` 내 고도화된 주석 및 로직 렌더링 확인

---

## 🏗️ 3단계: Step 6 기술 실습 설계 (Target: DB HA)
로드맵에 따른 엔터프라이즈 고가용성 환경 구축 기초 설계

- **작업 대상:** `docs/to-do-space/step6_enterprise_ha/02_galera_cluster/README.md`
- **수행 내용:**
    - Galera Cluster의 3개 노드 아키텍처 도식화 (Mermaid 활용)
    - 노드 간 통신을 위한 네트워크 포트(4567, 4568, 4444 등) 요구사항 정의
    - `garbd` 배치 전략 수립

---

## 🌿 4단계: 형상 관리 (Git)
환경 초기화 결과물에 대한 커밋 수행 (에이전트의 커밋 제안 가이드 준수)

### [커밋 제안] 개발 환경 표준화 완결 (Chore)
- **대상:** `pyproject.toml`, `poetry.lock`, `.python-version`
- **커밋 메시지:**
  ```text
  chore: Poetry 및 pyenv 기반 Python 의존성 관리 체계 구축

  - pyenv를 통한 Python 3.12.8 버전 고정 및 표준화
  - pyproject.toml 생성을 통한 MkDocs 관련 패키지 버전 동기화
  ```
