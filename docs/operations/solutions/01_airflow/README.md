# Apache Airflow - 인프라 워크플로우 자동화

복잡한 인프라 작업(백업, 리소스 프로비저닝, 로그 전처리 등)을 프로그래밍 방식으로 관리하고 예약하는 도구.

### 1. 핵심 개념 (Core Concepts)

- **DAG (Directed Acyclic Graph)**: 작업 간의 순서와 의존성을 정의한 작업 흐름 그래프.
- **Operator**: 실제 작업을 수행하는 단위 (Bash, Python, Docker 등).
- **Scheduler**: DAG의 실행 시점을 결정하고 Worker에게 작업 할당.
- **Web UI**: DAG 관리, 실행 이력 및 실시간 모니터링 제공.

### 2. 아키텍처 (Architecture)

- **Metadata DB**: DAG 상태 및 실행 이력 저장 (PostgreSQL 추천).
- **Executor**: 작업 실행 방식 결정 (Local, Celery, Kubernetes).
- **Worker**: 실제 Task를 실행하는 프로세스.

### 3. 설치 방법 (Docker Compose)

1. 공식 `docker-compose.yaml` 파일 다운로드.
2. `docker-compose up -d` 실행.
3. 초기 ID/PW: `airflow/airflow` (보안 설정 필수 변경).

### 4. 인프라 실습 활용

- 정기적인 데이터베이스 백업 파이프라인 구축.
- 멀티 클라우드 리소스 동기화 작업 자동화.
- 보안 스캔 도구 주기적 실행 및 리포트 생성.

### 상업적 사용 (License)

- **Apache License 2.0**: 상업적으로 자유롭게 사용 가능.
