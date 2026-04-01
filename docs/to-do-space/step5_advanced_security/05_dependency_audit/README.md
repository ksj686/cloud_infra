# [Step 5-5] 종속성 보안 감사 (npm audit)

**목표:** 오픈소스 라이브러리(SCA)의 취약점을 점검하고 보안 패치를 적용함.

### 1. npm audit 핵심 개념
- **Vulnerability Check:** 프로젝트의 `package.json`과 `package-lock.json`을 분석함.
- **SCA(Software Composition Analysis):** 알려진 보안 취약점 데이터베이스와 비교함.

### 2. 취약점 점검 실습
- **취약점 스캔:** `npm audit` 실행하여 보고서 확인함.
- **자동 수정 시도:** `npm audit fix` 실행하여 안전한 버전으로 업그레이드함.
- **강제 수정 (주의 필요):** `npm audit fix --force` 실행하여 호환성이 깨질 수 있는 메이저 버전 업데이트 수행함.

### 3. dummy_webserver 실습 (취약한 라이브러리 예시)
- `dummy_webserver` 디렉토리로 이동함.
- `npm install` 후 `npm audit` 명령어로 `express`나 `lodash` 등의 구 버전에서 발견된 취약점 리스트 확인함.
