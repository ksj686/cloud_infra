# [Phase 4] Observability: 운영 가시성 및 성능 최적화

실시간 모니터링, 성능 튜닝 및 자동 장애 대응 체계 구축을 통한 서비스 가용성 극대화 절차 정리

---

## 1. 컨테이너 기반 실시간 관측성 (Docker Native Monitoring)

모니터링 솔루션 장애 시에도 신뢰할 수 있는 로컬 진단 체계 확보

- **리소스 실시간 스트리밍 (`docker stats`):**
  - 컨테이너별 CPU 점유율, 메모리 사용량/제한, 네트워크 및 블록 I/O 현황 모니터링
  - **명령어:** `docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"`
- **라이프사이클 이벤트 로그 (`docker events`):**
  - 컨테이너 생성, 시작, 중단, 삭제 등 도커 데몬의 활동 이력 실시간 추적
  - **명령어:** `docker events --filter 'type=container' --since '1h'`
- **스토리지 점유 분석 (`docker system df`):**
  - 이미지, 컨테이너, 볼륨, 빌드 캐시가 차지하는 디스크 공간 분석 및 불필요 자원 식별
  - **정리 명령어:** `docker system prune -a --volumes` (미사용 자원 일괄 삭제)

## 2. 애플리케이션 성능 분석 및 프로파일링 (APM)

서비스 Throttling 원인 규명 및 코드 레벨 최적화

- **APM 도구 도입 및 연동:**
  - Pinpoint 또는 Scouter 설치 및 Java/Python 에이전트 설정
  - 트랜잭션 추적 및 데이터베이스 쿼리 응답 시간 실시간 모니터링
- **병목 지점 정밀 진단:**
  - 비효율적 알고리즘 및 I/O 대기 시간 분석을 통한 성능 최적화
  - **CPU Affinity 설정:** `taskset` 또는 도커 `--cpuset-cpus` 설정을 통해 핵심 프로세스의 코어 격리 및 간섭 최소화

## 3. 정밀 모니터링 및 통합 관제 (Thanos)

하이브리드 환경의 메트릭 통합 및 장기 데이터 보존 체계 구축

- **Thanos 클러스터링:**
  - 여러 사이트의 Prometheus 데이터를 Sidecar 및 Query 구성으로 통합
  - S3/MinIO 기반의 객체 스토리지를 활용한 모니터링 데이터 무제한 보관
- **시각화 및 대시보드:** Grafana를 활용하여 인프라 자원 및 서비스 가용성 지표 통합 대시보드 구축

## 4. 부하 검증 및 신뢰도 측정 (Stress/k6)

극한 상황 시뮬레이션을 통한 시스템 한계 및 안정성 검증

- **Stress 테스트 수행:**
  - `stress` 도구를 이용한 CPU/Memory/IO 임계치 부하 주입 및 cgroups 기반 자원 제한(Limits) 설정 검증
  - **명령어:** `stress --cpu 2 --io 1 --vm 1 --vm-bytes 512M --timeout 60s`
- **정밀 벤치마킹 (k6):**
  - 실제 사용자 접속 시나리오 기반 부하 테스트 수행 및 p95(상위 5%) 지연 시간 기준 서비스 신뢰도 정량 측정

## 5. 장애 자동 대응 및 환경 무결성 (Self-healing)

인적 개입 없는 서비스 복구 및 신뢰성 있는 분석 환경 확보

- **컨테이너 자가 진단 (HEALTHCHECK):**
  - Dockerfile 내 `HEALTHCHECK` 지시어를 통한 애플리케이션 상태(HTTP 응답 등) 주기적 검증
  - **예시:** `HEALTHCHECK --interval=30s --timeout=5s --start-period=3s --retries=3 CMD curl -f http://localhost:8000/health || exit 1`
  - `unhealthy` 상태 감지 시 컨테이너 자동 재기동 및 로드 밸런서 트래픽 차단 연동
- **서비스 레벨 셀프 힐링 (Host-level):**
  - **Systemd Unit 활용:** `Restart=always`, `RestartSec=5s` 설정을 통한 프로세스 비정상 종료 시 자동 복구 강제화
  - **자동 재기동 스크립트:** 크론탭(Cron)과 연동하여 주기적으로 프로세스 생존 여부를 확인하고 미가동 시 즉각 재시작 수행
- **장애 알림 및 이력 관리:**
  - **Webhook 연동:** 감지 및 복구 시점의 로그를 Slack/Email 등 외부 채널로 실시간 송출하여 가시성 확보
  - 복구 성공/실패 여부를 별도 로그 파일에 기록하여 장애 사후 분석(Post-mortem) 자료로 활용
- **우아한 종료 (STOPSIGNAL):** `STOPSIGNAL SIGTERM` 설정을 통해 데이터 유실 없는 안전한 서비스 중단 및 정리 작업(Graceful Shutdown) 보장
- **통합 상태 리포트 자동화:** 매일 정기적으로 시스템 가동 시간, 실패한 작업(Cron), 보안 이벤트를 요약한 일일 보고서 생성
- **환경 무결성 확보 (Timezone & NTP):**
  - **시간 동기화:** 호스트와 모든 컨테이너의 타임존(Asia/Seoul)을 일치화하여 로그 타임스탬프의 무결성 보장
  - **분석 신뢰도:** 분산된 여러 서버의 로그를 시간순으로 정렬하여 장애 상관관계를 정확히 파악할 수 있는 인프라 기반 마련
