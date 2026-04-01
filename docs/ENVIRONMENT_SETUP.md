# Project Environment Setup Guide

본 문서는 프로젝트의 문서화 포털(MkDocs) 가동 및 초기 개발 환경 구축을 위한 영구적 실행 지침

---

## 1. 필수 소프트웨어 (Prerequisites)
- **Python 3.x:** MkDocs 엔진 구동을 위한 기본 런타임
- **Pip:** 파이썬 패키지 관리 도구

---

## 2. 라이브러리 및 테마 설치 (Installation)
MkDocs Material 테마 및 필수 플러그인 설치

- **명령어:**
    ```bash
    pip install mkdocs-material mkdocs-mermaid2-plugin
    ```
- **구성 요소 설명:**
    - `mkdocs-material`: Google Material Design 기반 고성능 문서 테마
    - `mkdocs-mermaid2-plugin`: 마크다운 내 Mermaid 다이어그램 렌더링 지원

---

## 3. 로컬 서버 가동 (Local Development)
문서 수정 사항을 실시간으로 확인하기 위한 로컬 개발 서버 실행

- **실행 위치:** **프로젝트 루트 디렉토리** (`mkdocs.yml` 파일 존재 위치)
- **명령어:**
    ```bash
    mkdocs serve
    ```
- **접속 주소:** [http://127.0.0.1:8000](http://127.0.0.1:8000)
- **기능:** 파일 수정 시 브라우저 자동 새로고침 및 즉시 렌더링 지원

---

## 4. 웹 포털 검증 체크리스트 (Validation)
서버 가동 후 정상 작동 여부 전수 검사 항목

- [ ] **내비게이션:** 좌측 트리 메뉴 및 상단 탭 정상 작동 여부
- [ ] **검색 엔진:** 우측 상단 검색창 키워드 검색 결과 표시 여부
- [ ] **다이어그램:** Mermaid 기반 아키텍처 그림 정상 출력 여부
- [ ] **코드 기능:** 코드 블록 내 문법 강조(Highlighting) 및 복사(Copy) 버튼 작동 여부
- [ ] **이미지:** `docs/` 하위 문서 내 삽입된 이미지 출력 여부

---

## 5. 정적 빌드 및 배포 (Build)
실제 배포용 정적 자산(HTML/CSS/JS) 생성

- **명령어:**
    ```bash
    mkdocs build
    ```
- **결과물:** 루트의 `site/` 디렉토리에 생성 (웹 서버 호스팅용 소스)
