# Current Active Task Execution Guide

본 문서는 현재 진행 중인 '웹 포털 전환 및 루트 정리' 작업을 완수하기 위한 단계별 상세 실행 매뉴얼

---

## 🏃 1단계: 루트 잔여 폴더 정리 (Final Cleanup)
웹 포털 통합을 위해 아직 루트에 남아있는 마지막 콘텐츠 소스를 `docs/` 하위로 이동

- **작업 현황:** `disk_mount/`, `vi편집기/`, `우분투커널빌드/` 삭제 완료
- **남은 대상:** `lecture/`
- **실행 명령어:**
    ```powershell
    mv lecture docs/
    ```

---

## 📂 2단계: MkDocs 내비게이션 최적화
새로 이동한 `lecture/` 폴더를 웹 사이트 메뉴에 노출하도록 설정 업데이트

- **작업 파일:** `mkdocs.yml`
- **추가 항목 제안:**
    ```yaml
    - Materials:
        - Lecture Notes: lecture/ (주요 파일 경로 지정)
    ```

---

## 🌿 3단계: Git 분할 커밋 (Logical Committing)
남은 변경 사항을 논리적 단위로 나누어 커밋

### [커밋 A] 프로젝트 관리 및 실행 가이드 구축
- **대상:** `docs/PROJECT_WORKFLOW.md`, `docs/CURRENT_TASK_GUIDE.md`, `README.md`, `docs/index.md`, `docs/CHANGELOG.md`
- **메시지:** `docs: 프로젝트 관리 및 실시간 실행 가이드 체계 구축`

### [커밋 B] 기술 지침 및 원칙 개정
- **대상:** `GEMINI.md`, `.gitignore`
- **메시지:** `docs: Git 커밋 제안 자동화 지침 및 분류 체계 개정`

---

## 🔍 4단계: 최종 검증 (Validation)
작업 결과물이 의도대로 작동하는지 로컬 환경에서 테스트

1. **로컬 웹 서버 가동:** `mkdocs serve` 실행
2. **접속 확인:** `http://127.0.0.1:8000` 접속 후 좌측 메뉴 작동 여부 확인
3. **경로 체크:** 모든 하이퍼링크 및 이미지 정상 출력 확인
