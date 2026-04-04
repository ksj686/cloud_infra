# Project Environment Setup Guide

본 문서는 프로젝트의 안정적인 가동을 위해 Python(Poetry) 및 Node.js(nvm) 기반의 표준화된 개발 환경 구축 지침 및 웹 포털 검증 절차 정리

---

## 1. Node.js 환경 구축 (nvm)
버전 관리 및 충돌 방지를 위해 `nvm` 사용 필수

### 1.1 사전 준비 (주의 사항)
- **기존 Node.js 삭제:** `nvm` 설치 전 제어판에서 기존 설치된 모든 Node.js 버전 전수 삭제 필수. 기존 설치본과 `nvm` 간의 실행 경로(Path) 충돌 방지 목적
- **잔여 폴더 정리:** 삭제 후 `C:\Program Files\nodejs` 또는 `%AppData%\npm` 등 관련 폴더 잔존 여부 확인 및 수동 제거 권장

### 1.2 nvm 설치 및 설정
- **nvm 설치 (Windows):** [nvm-windows](https://github.com/coreybutler/nvm-windows/releases) 다운로드 및 설치
- **Node.js 설치 및 사용:**
    ```bash
    # LTS 버전 설치 (Node.js 20.x 이상 권장)
    nvm install lts
    nvm use lts
    ```
- **권장 도구 설치 (pnpm):** 속도 및 용량 효율을 위해 `pnpm` 사용 권장
    ```bash
    npm install -g pnpm
    ```

---

### 2.1 Python 버전 관리 (pyenv)
- **목적:** `.python-version` 파일에 명시된 버전과 로컬 실행 버전의 완벽한 일치 보장
- **권장 버전:** **Python 3.12.x (안정성 및 라이브러리 호환성 최적)**
- **관리 원칙 (중요):** 
    - 시스템 전역 파이썬(Windows Installer 방식) 및 **Python Launcher(py.exe) 전수 삭제**
    - 모든 버전 관리를 `pyenv`로 일원화하여 PATH 및 명령어 실행 우선순위 충돌 방지
- **설치:** [pyenv-win](https://github.com/pyenv-win/pyenv-win) (Windows용) 설치
- **버전 동기화:**
    ```bash
    # .python-version에 명시된 버전 설치 및 적용
    pyenv install 3.12.8
    pyenv local 3.12.8
    ```

### 2.2 Poetry 설치 및 설정
- **공식 설치 스크립트 (Windows):**
    ```powershell
    (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
    ```
- **설치 경로 확인 및 등록 (CRITICAL):** 
    1.  **로그 확인:** 설치 완료 직후 터미널에 출력되는 **`Add ... to your PATH`** 문구 뒤의 절대 경로를 반드시 확인 및 복사
    2.  **절대 경로 등록:** 시스템 환경 변수(`%APPDATA%`) 인식 오류 방지를 위해, 복사한 **실제 절대 경로**를 시스템 `Path` 최상단에 직접 입력
    3.  **경로 예시:** `C:\Users\[사용자계정]\AppData\Roaming\Python\Scripts`
- **가상 환경 경로 설정:** 프로젝트 폴더 내에 가상 환경이 생성되도록 설정 권장
    ```bash
    poetry config virtualenvs.in-project true
    ```

### 2.2 프로젝트 초기화 및 가상 환경 가동
- **패키지 설치:** `pyproject.toml`에 정의된 의존성 일괄 설치
    ```bash
    poetry install
    ```
- **가상 환경 진입:** `poetry shell` 명령을 통해 활성화

---

## 3. MkDocs 웹 포털 가동 및 빌드
가상 환경 내에서 MkDocs 서버 실행 및 정적 자산 생성

- **로컬 개발 서버 실행:**
    ```bash
    poetry run mkdocs serve
    ```
- **실행 오류 시 (Windows PATH 미설정):**
    ```bash
    python -m mkdocs serve
    ```
- **정적 빌드 (Production):** 실제 배포용 HTML 파일 생성
    ```bash
    poetry run mkdocs build
    ```
- **결과물:** 루트의 `site/` 디렉토리에 생성

---

## 4. 웹 포털 검증 체크리스트 (Validation)
서버 가동 후 정상 작동 여부 전수 검사 항목

- [ ] **내비게이션:** 좌측 트리 메뉴 및 상단 탭 정상 작동 여부
- [ ] **검색 엔진:** 우측 상단 검색창 키워드 검색 결과 표시 여부
- [ ] **다이어그램:** Mermaid 기반 아키텍처 그림 정상 출력 여부
- [ ] **코드 기능:** 코드 블록 내 문법 강조(Highlighting) 및 복사(Copy) 버튼 작동 여부
- [ ] **이미지:** `docs/` 하위 문서 내 삽입된 이미지 출력 여부

---

## 5. 트러블슈팅 및 관리 원칙
- **.venv 푸시 금지:** 가상 환경 폴더(`.venv`)는 머신 의존적 경로를 포함하므로 절대 Git에 커밋하지 않음 (`.gitignore` 설정 확인)
- **환경 변수 설정:** `mkdocs` 또는 `poetry` 명령어가 인식되지 않을 경우 시스템 `Path`에 아래 경로 추가
    - **권장 방식:** 환경 변수(`%APPDATA%`) 인식 오류 방지를 위해 **절대 경로** 직접 입력 권장
    - **대상 경로 예시:** `C:\Users\[사용자계정]\AppData\Roaming\Python\Scripts`
- **반영 확인 (중요):** 환경 변수 등록 후 반드시 **현재 실행 중인 모든 터미널 창을 닫고 재시작**해야 변경 사항이 적용됨
- **pyenv 우선순위 (중요):** `pyenv local` 설정 후에도 버전이 변하지 않을 경우 아래 사항 확인
    - **시스템 변수 충돌:** 윈도우 시스템 변수 `Path`에 기존 파이썬 경로가 등록된 경우 사용자 변수보다 우선 실행됨. 시스템 변수 내 파이썬 경로 삭제 또는 하단 이동 조치 권장
    - **명령어 우선순위:** `where.exe python` 실행 시 `pyenv` 경로가 가장 상단에 출력되는지 확인
- **의존성 동기화:** 패키지 추가/삭제 시 반드시 `poetry add` 또는 `poetry remove` 사용하여 `poetry.lock` 파일 유지
- **빌드 제외:** 분석용 소스(`lecture/**`)는 `mkdocs.yml`의 `exclude_docs` 설정을 통해 가시성 및 빌드 오류 관리
- **상시 업데이트:** 환경과 관련된 모든 사항은 본 문서(`docs/ENVIRONMENT_SETUP.md`)에 누적 기록하여 최신 상태 유지
