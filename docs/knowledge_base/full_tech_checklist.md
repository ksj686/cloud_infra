# Infrastructure Technology & Philosophy Checklist (Integrated Analysis)

본 문서는 사용자가 언급한 모든 기술적 단어와 인프라 구축 철학을 전수 정리함. 단순 정의를 넘어 멀티 클러스터 모니터링 한계, 제어 평면 설계 등 핵심 분석 내용을 통합하여 프로젝트 설계의 준거 틀로 활용

---

## 1. 인프라 철학 및 대원칙
- **무엇이든 반드시 이중화 (Redundancy for Everything):**
    - **개념:** 인프라의 모든 구성 요소(네트워크, 스토리지, 서버, DB)에 SPoF(단일 장애점)가 없도록 2개 이상의 자원을 배치
    - **분석:** 본 프로젝트의 최상위 설계 철학. 
		- Phase 2: Nginx 리버스 프록시 이중화 (Keepalived 등 활용)
		- Phase 3: 스토리지(Ceph) 및 DB(Galera Cluster) 이중화
		- Phase 4: Proxmox HA 구성을 통한 하이퍼바이저 이중화
		=> 전 단계에서 이중화 여부 검수
- **온프레미스 vs 클라우드 비용 비교:**
    - **개념:** 초기 구축 비용(CAPEX)과 운영 비용(OPEX)을 비교하여 워크로드별 최적의 배치(Hybrid Cloud) 결정

## 2. 가상화 및 제어 평면 (Control Plane)
- **Control Plane:**
    - **분석:** 시스템의 상태를 결정하고 리소스를 관리하는 중앙 제어부('뇌'). 쿠버네티스 마스터 노드, Proxmox 클러스터 관리부, Ansible 제어 노드 등이 해당
    - **설계 지침:** 실제 데이터가 흐르는 Data Plane과 논리적/물리적으로 분리하여 제어부 부하가 서비스에 영향을 주지 않도록 설계
- **Ansible 기반 자동화:**
    - **개념:** IaC(Infrastructure as Code)를 통해 서버 설정 및 애플리케이션 배포를 코드로 관리하여 환경 일관성(Idempotency) 확보

## 3. 고가용성 및 스토리지 (HA & Storage Mapping)
- **Ceph (하드웨어 레벨 고가용성):** 분산 스토리지 클러스터로 VM 데이터 및 로그의 물리적 안정성 보장
- **Galera Cluster (소프트웨어 레벨 복제):** 동기식 멀티 마스터 복제를 통해 DB 데이터 유실 방지 및 무중단 서비스 구현
- **garbd (Arbitrator):** 데이터 노드가 아닌 중재자 프로세스. 최소 비용으로 3노드 쿼럼(Quorum)을 유지하여 짝수 노드 시 발생할 수 있는 스플릿 브레인(Split-brain) 현상 방지
- **ProxySQL:** DB 레이어 프록시로서 Read/Write 분할 및 장애 노드 자동 제외 제어
- **Ceph & garbd 시너지:** 스토리지 가용성(Ceph)과 DB 쿼럼 유지(garbd)를 결합하여 데이터 정합성 극대화

## 4. 데이터 가속 및 로깅 (Redis & Logging)
- **Redis 구조 (Session vs Cache):**
    - **Session Redis:** 멀티 서버 환경에서 사용자 세션 상태를 공유하여 세션 불일치 문제 해결
    - **Cache Redis:** DB 쿼리 부하 절감 및 응답 속도 향상용 인메모리 저장소. DB 쿼리 결과 등을 임시 저장하여 성능 향상
- **Redis Sentinel (`/var/log/redis/sentinel.log`):** Redis 클러스터 상태 모니터링 및 자동 페일오버 수행. 로그를 통해 마스터/슬레이브 전환 이력 추적
- **자동 페일오버:** 문제가 생겼을 때 자동으로 예비군을 투입하는 시스템
- **Loki -> Ceph <- Grafana:** Fluent Bit(Push 방식)으로 수집된 로그를 Loki에 저장하고, 영구 저장소로 Ceph를 활용하여 장기 보관 및 시각화(Grafana)
- **Fluent Bit (Push):** 에이전트가 중앙 로그 서버(Loki)로 로그를 밀어넣는 방식

## 5. 모니터링 및 부하 테스트 (Observability)
- **멀티 클러스터 모니터링 (Prometheus + Thanos):**
    - **한계 분석:** 기본 프로메테우스는 Pull 방식과 로컬 저장소 한계로 인해 네트워크가 격리된 멀티 클러스터 통합 관리가 어려움
    - **해결책:** Thanos Receiver를 통한 Remote Write(Push) 방식을 채택하여 여러 클러스터의 데이터를 중앙 Ceph 저장소로 통합하고 통합 뷰 제공
		- **Thanos:**
			- Remote Write: 클라우드나 각 지점의 프로메테우스가 데이터를 중앙의 Thanos Receiver로 전송(Push)
           - Query: 사용자는 여러 클러스터에 흩어진 데이터를 하나의 그라파나 대시보드에서 Thanos Query를 통해 통합 조회 가능
           - 장기 보관: 데이터를 로컬 디스크가 아닌 S3/Ceph 같은 객체 스토리지에 저장하여 무제한 보관 가능
- **k6 Load Testing & p95 Latency:**
    - **분석:** 단순 평균 지연 시간이 아닌, 상위 5% 사용자가 겪는 p95 지연 시간을 기준으로 인프라의 실제 성능과 사용자 경험 신뢰성 검증
- **부하 테스트 대조군:**
    1. **Base:** 최적화 없음
    2. **HPA:** CPU/Memory 사용률 기반 정적 확장
    3. **KEDA:** RPS(초당 요청 수) 등 이벤트 기반 동적 확장

## 6. 클라우드 네이티브 및 확장 (K8s & AI)
- **Ingress API:** 외부 트래픽의 서비스 전달 규칙(도메인, 경로) 정의하는 L7 게이트웨이 리소스
- **Karpenter:** 트래픽 요구사항에 맞춰 최적의 노드를 즉시 프로비저닝하는 지능형 오토스케일러
- **Predictive AI 모델 (MS AI):** 
    - **분석:** Prophet 등 MS 기반 시계열 예측 모델 활용. 학습 없이 과거 부하 데이터를 기반으로 미래 부하를 예측하여 실제 트래픽 유입 전 선제적 자원 증설(Proactive Scaling) 수행
	- **활용:** 인프라 모니터링 데이터(CPU, Traffic)를 입력하면 향후 30분~1시간 뒤의 부하를 예측하여, 실제 부하가 오기 전에 노드를 미리 늘리는(Proactive Scaling) 용도로 사용
- **Argo CD:** GitOps 철학에 따라 Git 저장소의 선언적 상태를 클러스터에 강제 동기화
- **자동 클라우드 버스팅:** 관측 데이터 기반 온프레미스 자원 임계치 도달 시 퍼블릭 클라우드 자원을 자동 연동하는 하이브리드 확장 구조
