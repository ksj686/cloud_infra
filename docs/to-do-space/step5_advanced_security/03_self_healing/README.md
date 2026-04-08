# [Step 5-3] 서비스 상태 확인 및 자동 복구(Self-healing)

**목표:** 서비스 중단 발생 시 자동으로 인지하고 재기동하여 서비스 연속성을 유지함.

### 1. 셀프 힐링 메커니즘

- **Health Check:** 주기적으로 서비스의 활성 상태 확인함.
- **Auto-restart:** 비정상 종료 시 시스템 명령을 통해 자동 복구함.

### 2. 구현 방법

- `systemctl is-active` 명령으로 프로세스 생존 여부 확인함.
- Nginx의 경우 `curl -I http://localhost`를 통해 응답 코드 확인함.
- 크론탭(Crontab)에 1분 단위로 실행되도록 등록함.

### 3. 검증 방법

- 특정 서비스를 수동으로 중지하고 스크립트 실행 후 서비스 재가동 여부 확인함.
- `sudo systemctl stop nginx` -> 스크립트 실행 -> `sudo systemctl status nginx` 확인함.
