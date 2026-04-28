# Case Study: pre-commit 훅과 Windows 환경 간 기술적 충돌 해결

**날짜:** 2026-04-08
**대상:** 품질 관리 자동화 시스템 (pre-commit)

---

## 1. 문제 상황 (Problem)

- **현상:** `uv run pre-commit run --all-files` 실행 시 `check-yaml` 및 `ShellCheck` 단계에서 대량의 Failed 발생

- **에러 메시지 1:** `could not determine a constructor for the tag 'tag:yaml.org,2002:python/name...'`
- **에러 메시지 2:** `SC1017 (error): Literal carriage return. Run script through tr -d '\r' .`

---

## 2. 원인 분석 (Analysis)

- **YAML 충돌:** MkDocs Material 테마의 파이썬 확장 태그를 표준 YAML 검사기가 인식하지 못함
- **인코딩 충돌:** 윈도우 환경의 기본 줄바꿈(CRLF) 형식을 리눅스 기반 도구인 ShellCheck가 문법 오류로 간주

---

## 3. 해결 조치 (Solution)

- **검사 예외 설정:** `.pre-commit-config.yaml`에서 `mkdocs.yml` 파일을 `exclude` 처리하여 불필요한 충돌 회피
- **줄바꿈 자동 관리:** `.gitattributes` 파일 생성 및 `*.sh text eol=lf` 설정을 통해 Git 저장소 내 LF 형식을 강제화
- **에디터 동기화:** VS Code 하단 바 설정을 CRLF에서 LF로 변경 후 저장 유도

---

## 4. 교훈 및 시사점 (Lessons Learned)

- **환경 이질성 고려:** 윈도우에서 인프라 도구(리눅스 기반)를 사용할 때 발생하는 인코딩/개행 문자의 차이를 사전 설계에 반영 필요
- **설계의 유연성:** 모든 파일을 검사하기보다, 도구의 특성에 맞는 예외 처리(`exclude`)를 적절히 활용하는 것이 빌드 신뢰도 향상에 기여
