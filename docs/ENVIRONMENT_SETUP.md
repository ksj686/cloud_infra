# Project Environment Setup Guide

본 문서는 프로젝트 가동을 위한 Python(Poetry), Node.js(nvm) 기반 개발 환경 구축 지침 및 가상 환경 관리 절차 정리

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
- **설치:** [pyenv-win](https://github.com/pyenv-win/pyenv-win) 가이드에 따라 설치 및 PATH 등록
- **버전 적용:**
    ```bash
    # .python-version 파일에 명시된 버전과 일치화
    pyenv install 3.12.8
    pyenv local 3.12.8
    ```

### 2.2 Poetry 설치 및 가상 환경 관리
- **Poetry 설치:** [공식 설치 가이드](https://python-poetry.org/docs/#installation) 참조
- **PATH 등록 (중요):** 설치 로그 하단 `Add ... to your PATH` 경로를 시스템 `Path` 최상단에 직접 등록
- **프로젝트 내부 가상 환경 설정:**
    ```bash
    poetry config virtualenvs.in-project true
    ```

### 2.3 의존성 초기화 및 설치 (상황별 절차)

#### Case A: 처음 프로젝트 환경을 구축할 때 (Initial Setup)
1. **설정 파일 생성:** `poetry init` (대화형 가이드에 따라 작성)
2. **패키지 추가:** `poetry add mkdocs-material mkdocs-mermaid2-plugin`
3. **잠금 파일 생성:** `poetry lock` (의존성 그래프 확정)
4. **실제 설치:** `poetry install` (.venv 생성 및 패키지 설치)

#### Case B: 이미 구축된 환경에 참여할 때 (Joining Project)
1. **의존성 설치:** `poetry install` (기존 `poetry.lock` 기반 완벽 동기화)
    - **참고:** 설정이 바뀌어 경고 발생 시 `poetry lock` 후 `poetry install` 재실행

---

## 3. MkDocs 웹 포털 가동
구축된 가상 환경 내에서 문서화 사이트 실행

- **로컬 가동:**
    ```bash
    poetry run mkdocs serve
    ```
- **접속:** [http://127.0.0.1:8000](http://127.0.0.1:8000)

---

## 4. 트러블슈팅 및 관리 원칙
- **의존성 불일치 경고:** `pyproject.toml changed significantly...` 발생 시 `poetry lock` 명령어로 잠금 파일 갱신 필수
- **.venv 푸시 금지:** 로컬 경로가 포함된 가상 환경 폴더는 절대 Git에 커밋하지 않음 (`.gitignore` 확인)
- **명령어 미인식:** 시스템 환경 변수 등록 후 반드시 **터미널 재시작** 필수
- **상시 업데이트:** 환경 관련 모든 특이 사항은 본 문서에 누적 기록하여 최신 상태 유지
