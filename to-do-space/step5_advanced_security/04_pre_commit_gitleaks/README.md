# [Step 5-4] pre-commit 및 Gitleaks를 활용한 기밀 정보 유출 방지

**목표:** 로컬 개발 단계에서 커밋 전 소스 코드 내 민감 정보(API Key, Secret 등) 유출을 사전에 차단함.

### 1. pre-commit 및 Gitleaks 설치
- **Python 환경 준비:** `pip install pre-commit`
- **Gitleaks 설치:** `brew install gitleaks` (macOS) 또는 공식 바이너리 다운로드함.

### 2. 설정 파일 작성 (.pre-commit-config.yaml)
- 프로젝트 루트 디렉토리에 설정 파일 생성함.
- `gitleaks` 훅(hook)을 추가하여 커밋 시마다 스캔하도록 함.

### 3. 로컬 훅 설치 및 실행
- **훅 설치:** `pre-commit install`
- **전체 파일 수동 스캔:** `pre-commit run --all-files`

### 4. 커밋 시 유의 사항
- 민감 정보가 포함된 커밋은 차단되므로, 발견 시 정보를 제거하거나 `.gitleaksignore` 파일에 등록함.
