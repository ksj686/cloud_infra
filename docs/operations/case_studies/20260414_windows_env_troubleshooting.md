# Case Study: Windows 환경의 도구 삭제 권한 및 백신 오탐 이슈 해결

**날짜:** 2026-04-14
**대상:** Poetry(Cleanup), Gitleaks(Security Tool)

---

## 1. 문제 상황 (Problem)

- **Poetry 삭제 실패:** `PermissionError: [WinError 5]` 발생으로 인한 언인스톨 중단. 특정 바이너리 파일(`.pyd`) 점유 현상 확인.
- **Gitleaks 차단:** Avast 백신이 `gitleaks` 실행 파일을 위협으로 오탐하여 지속적으로 격리 및 삭제 처리. `Executable not found` 에러 발생.

---

## 2. 원인 분석 (Analysis)

- **파일 잠금 (Locking):** VS Code 또는 터미널 내 파이썬 인터프리터가 Poetry 내부 라이브러리를 참조 중인 상태에서 삭제 시도.
- **휴리스틱 탐지:** 코드 전체를 스캔하는 Gitleaks의 동작이 백신의 실시간 감시 엔진에 의해 악성 스캐닝 행위로 간주됨.

---

## 3. 해결 조치 (Solution)

- **점유 프로세스 제어:** 에디터(VS Code) 및 터미널 전면 종료 후 `%APPDATA%\pypoetry` 등 잔여 폴더 수동 강제 삭제 수행.
- **백신 예외 처리:** Avast 설정 내 `pre-commit` 캐시 경로(`~/.cache/pre-commit`)를 검사 예외 목록에 등록.
- **훅 환경 복구:** `uv run pre-commit clean` 명령을 통한 손상된 캐시 제거 및 재구축 수행.

---

## 4. 교훈 및 시사점 (Lessons Learned)

- **윈도우 개발 환경의 특수성:** 리눅스와 달리 파일 점유에 민감한 윈도우 환경에서는 자동화 스크립트보다 수동 정리가 더 확실할 수 있음을 숙지.
- **보안 도구 간의 상충:** 로컬 보안 도구(Gitleaks)가 기업용 백신과 충돌할 수 있으므로, 팀 단위 도입 시 사전에 예외 처리 가이드 배포 필요.
