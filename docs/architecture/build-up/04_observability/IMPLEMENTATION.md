# Implementation Guide: Phase 4 Observability

본 문서는 Phase 4 운영 가시성 확보 및 자동 장애 대응 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. 애플리케이션 성능 분석 (APM)

### 1.1 Python APM 에이전트 설치 및 실행

```bash
# Pinpoint 에이전트 설치 (예시)
pip install pinpoint-py-agent

# 애플리케이션 가동 시 에이전트 연동
export PINPOINT_AGENT_ID="infra-api-01"
export PINPOINT_APP_NAME="INFRA_API"
export PINPOINT_COLLECTOR_HOST="192.168.100.50"

uv run python app.py
```

---

## 2. 통합 모니터링 (Thanos)

### 2.1 Thanos 사이드카 구성 (Prometheus 연동)

```yaml
# prometheus-deployment.yaml 사이드카 컨테이너 추가
containers:
  - name: prometheus
    image: prom/prometheus:v2.45.0
    args:
      - "--storage.tsdb.max-block-duration=2h"
      - "--storage.tsdb.min-block-duration=2h"
  - name: thanos-sidecar
    image: thanosio/thanos:v0.31.0
    args:
      - "sidecar"
      - "--prometheus.url=http://localhost:9090"
      - "--objstore.config-file=/etc/thanos/bucket_config.yaml"
```

---

## 3. 부하 검증 및 신뢰도 측정 (k6)

### 3.1 k6 설치 및 테스트 스크립트 실행

```bash
# k6 설치 (Windows)
winget install k6

# 테스트 시나리오 작성 (script.js)
vi script.js
```

```javascript
import http from "k6/http";
import { sleep } from "k6";

export default function () {
  http.get("http://api.kosa.kr/health");
  sleep(1);
}
```

```bash
# 부하 테스트 실행 (50명 동시 접속, 30초간)
k6 run --vus 50 --duration 30s script.js
```

---

## 4. 장애 자동 대응 (Self-healing)

### 4.1 Systemd 기반 프로세스 자동 재기동

```bash
sudo vi /etc/systemd/system/infra-api.service
```

```yaml
# /etc/systemd/system/infra-api.service
[Unit]
Description=Cloud Infra API Service
After=network.target

[Service]
User=infra-admin
WorkingDirectory=/home/infra-admin/app
ExecStart=/usr/local/bin/uv run python app.py
Restart=always
RestartSec=5s
KillSignal=SIGTERM

[Install]
WantedBy=multi-user.target
```

```bash
# 서비스 활성화 및 가동
sudo systemctl daemon-reload
sudo systemctl enable --now infra-api
```

### 4.2 Docker 헬스체크 및 자동 복구

```yaml
# docker-compose.yml 내 적용
services:
  web:
    image: my-app:latest
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 5s
```

---

## 5. 환경 무결성 (Timezone)

### 5.1 시스템 및 컨테이너 시간 동기화

```bash
# 호스트 타임존 설정
sudo timedatectl set-timezone Asia/Seoul

# Docker Compose 내 타임존 공유
services:
  app:
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
```
