# Current Active Task Execution Guide

본 문서는 현재 진행 중인 '웹 포털 전환 및 루트 정리' 작업의 마무리를 위한 단계별 상세 실행 매뉴얼

---

## 🏃 1단계: 루트 정리 완료 (Cleanup Finished)
모든 콘텐츠 소스의 `docs/` 하위 통합 완료

- **완료 현황:** `lecture/` 이동 완료 (`docs/lecture/`)
- **특이 사항:** `lecture/` 폴더는 분석용 소스로서 MkDocs 웹 메뉴(nav)에서 제외하여 보안 및 가시성 관리

---

## 📂 2단계: MkDocs 최종 점검
이동된 소스들이 웹 빌드에 영향을 주지 않는지 확인

- **작업 파일:** `mkdocs.yml`
- **점검 항목:** `nav` 섹션에 `lecture/` 관련 경로가 포함되지 않았는지 확인 (현재 포함 안 됨)

---

## 🌿 3단계: Git 최종 커밋 (Final Committing)
웹 포털 전환 작업을 마무리하는 논리적 분할 커밋 실행

### [커밋 A] 웹 포털 인프라 및 소스 통합
- **대상:** `mkdocs.yml`, `docs/`, `README.md`
- **메시지:** `feat: MkDocs Material 웹 포털 구축 및 전 소스 docs/ 통합`

### [커밋 B] 루트 정리 및 중복 제거
- **대상:** 루트에서 삭제된 모든 폴더 및 파일의 삭제 상태 스테이징
- **메시지:** `refactor: 루트 디렉토리 정리 및 docs/ 디렉토리로 소스 일원화`

### [커밋 C] 프로젝트 관리 지침 및 로드맵 최신화
- **대상:** `GEMINI.md`, `docs/CHANGELOG.md`, `docs/PROJECT_WORKFLOW.md`, `docs/CURRENT_TASK_GUIDE.md`
- **메시지:** `docs: 프로젝트 관리 지침 고도화 및 실행 워크플로우 구축`

---

## 🔍 4단계: 최종 검증 (Validation)
1. **로컬 웹 서버 가동:** `mkdocs serve` 실행
2. **메뉴 확인:** `lecture/` 내용이 좌측 메뉴에 노출되지 않는지 확인
3. **콘텐츠 확인:** 나머지 문서들이 정상적으로 렌더링되는지 확인
