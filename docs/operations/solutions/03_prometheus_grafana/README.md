# Prometheus & Grafana - 메트릭 모니터링

시스템 성능 지표를 수집하고 이를 시각화하여 인프라의 가동률과 성능을 관리.

### 1. Prometheus 핵심 요소 (Monitoring Metrics)

- **TSDB (Time Series Database)**: 시계열 데이터 저장소.
- **Exporter**: 메트릭 수집 도구 (Node Exporter, MySQL Exporter 등).
- **PromQL**: 유연한 데이터 쿼리 언어.
- **Scraping**: 대상 서버의 `/metrics` 엔드포인트에서 데이터 수동/자동 수집.

### 2. Alertmanager (Alerting)

- 특정 임계값(CPU > 90% 등) 초과 시 알람 발송 규칙 설정.
- Email, Slack, PagerDuty 등 외부 알림 서비스 연동.

### 3. Grafana 대시보드 (Dashboard Setup)

- Prometheus를 데이터 소스(Data Source)로 연결.
- 다양한 시각화 패널 제공 (Graph, Gauge, Table 등).
- 공식 및 커뮤니티 제공 대시보드 ID를 통한 간편 설치.

### 4. 인프라 실습 활용

- `configs/prometheus.yml`에서 수집 대상(Target) 정의 및 관리.
- 리소스(CPU, RAM, DISK) 사용률 실시간 시각화.
- 서비스 가용성(Up-time) 모니터링 및 알림 자동화.

### 상업적 사용 (License)

- **Apache License 2.0**: 상업적으로 자유롭게 사용 가능.
- **AGPL v3 (Grafana)**: 오픈소스 에디션은 상업적 이용 가능 (수정 배포 시 소스 공개 의무).
