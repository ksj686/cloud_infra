# [Step 5-2] Nginx 로드 밸런싱(Load Balancing) 설정

**목표:** Nginx의 리버스 프록시 기능을 활용하여 트래픽을 분산하고 서비스 가용성을 확보함.

### 1. 로드 밸런싱 핵심 개념

- **Upstream Block:** 백엔드 서버 그룹을 정의함.
- **Proxy Pass:** 유입된 트래픽을 정의된 서버 그룹으로 전달함.

### 2. 설정 방법

- `/etc/nginx/sites-available/default` 또는 별도 설정 파일에 적용함.
- `upstream` 섹션에서 서버 목록 나열함 (기본 라운드 로빈 방식).
- `location` 블록에서 `proxy_pass http://backend_servers;` 사용함.

### 3. 상태 확인

- `sudo nginx -t`: 설정 파일 문법 검사함.
- `sudo systemctl reload nginx`: 설정 적용함.
