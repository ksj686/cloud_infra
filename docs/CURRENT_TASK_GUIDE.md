# MkDocs Material Setup & Execution Manual

본 문서는 MkDocs Material 웹 포털 환경 구축 및 로컬 가동을 위한 단계별 정밀 실행 가이드

---

## 🛠️ 1단계: 환경 구축 (Environment Setup)
MkDocs 가동을 위한 필수 라이브러리 및 테마 설치

- **실행 위치:** 로컬 PC의 터미널 (PowerShell, Bash 등)
- **필수 구성 요소 설치:**
    ```bash
    # Python 패키지 매니저를 통한 설치
    pip install mkdocs-material mkdocs-mermaid2-plugin
    ```
- **설치 확인:**
    ```bash
    mkdocs --version
    ```

---

## 🚀 2단계: 로컬 서버 가동 (Local Serving)
실시간 변경 사항 확인을 위한 개발 서버 실행

- **실행 위치:** **프로젝트 루트 디렉토리** (C:\Users\SamuelK\Desktop\cloud_infra\)
    - `mkdocs.yml` 파일이 존재하는 위치에서 실행 필수
- **명령어:**
    ```bash
    mkdocs serve
    ```
- **상태 확인:**
    - 출력 로그에 `[INFO] - Serving on http://127.0.0.1:8000/` 문구 확인
    - 해당 주소를 브라우저(Chrome, Edge 등) 주소창에 입력하여 접속

---

## 🔍 3단계: 웹 인터페이스 전수 검증 (Validation)
브라우저 접속 후 아래 항목별 정상 작동 여부 확인

### 3.1 내비게이션 및 메뉴 (Navigation)
- **좌측 메뉴:** `Blueprint`, `Knowledge Base`, `Playbooks` 등 모든 카테고리가 트리 구조로 정상 출력되는지 확인
- **섹션 확장:** 하위 메뉴가 있는 항목 클릭 시 정상적으로 펼쳐지는지 확인
- **상단 탭:** `Home`, `Blueprint` 등 탭 클릭 시 해당 페이지로 즉시 이동하는지 확인

### 3.2 검색 및 다크모드 (Features)
- **통합 검색:** 상단 검색창에 'Ceph' 또는 'Audit' 입력 시 관련 문서가 즉시 검색되는지 확인
- **모드 전환:** 우측 상단의 밝기 아이콘 클릭 시 다크 모드(Slate)와 라이트 모드가 정상 전환되는지 확인

### 3.3 콘텐츠 렌더링 (Content)
- **코드 스니펫:** 플레이북 내의 명령어들이 코드 블록으로 가독성 있게 표시되며, 우측 상단의 'Copy' 버튼이 작동하는지 확인
- **다이어그램:** `README.md` 메인의 Mermaid 로드맵 다이어그램이 텍스트가 아닌 그림으로 정상 렌더링되는지 확인
- **이미지:** 가이드 문서 내 삽입된 이미지 파일이 깨지지 않고 표시되는지 확인

---

## 🌿 4단계: 형상 관리 및 마감 (Git Finalize)
검증 완료 후 최종 변경 사항을 논리적 단위로 나누어 커밋

### [커밋 1] 웹 포털 인프라 통합
- **대상:** `mkdocs.yml`, `docs/`, `README.md`
- **메시지:** `feat: MkDocs Material 웹 포털 구축 및 전 소스 docs/ 통합`

### [커밋 2] 관리 지침 및 워크플로우 보완
- **대상:** `GEMINI.md`, `docs/CHANGELOG.md`, `docs/PROJECT_WORKFLOW.md`, `docs/CURRENT_TASK_GUIDE.md`, `.gitignore`
- **메시지:** `docs: 프로젝트 관리 지침 고도화 및 실시간 실행 가이드 구축`

---

## 📦 5단계: 정적 빌드 (Production Build) - 선택 사항
배포용 정적 HTML 파일 생성 필요 시

- **명령어:** `mkdocs build`
- **결과물:** 루트에 생성된 `site/` 폴더 확인 (실제 웹 서버 배포용 데이터)
