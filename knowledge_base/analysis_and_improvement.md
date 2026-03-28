# Infrastructure Analysis & Improvement Strategy

본 문서는 사용자가 제안한 고도화 기술 스택을 바탕으로 현재 프로젝트의 적용 현황을 진단하고, 단계별 아키텍처 개선 방향을 제시함.

---

## 1. 기술 스택 적용 현황 진단 (Status Analysis)
현재 프로젝트(`project_outline.md` 및 실습 가이드) 대비 제안 기술의 도입 수준을 분류함.

| 분류 | 기술 항목 | 적용 현황 | 진단 결과 |
| :--- | :--- | :--- | :--- |
| **Data & Storage** | Redis (Cache/Session), Ceph, Galera Cluster | **Partial / None** | 단순 DB 이중화 수준이며, 고성능 캐싱 및 분산 스토리지 체계 부재함. |
| **Observability** | Thanos, Loki, k6 (p95 Latency) | **None** | 단일 클러스터 모니터링에 국한되어 있으며, 멀티 클러스터 및 정밀 부하 테스트 체계 부재함. |
| **Network & Security** | pfSense, Ingress API, Cloud Bursting | **None** | 기본 UFW/IPTables 수준의 방화벽 운용 중이며, 지능적 트래픽 제어 및 하이브리드 확장성 부족함. |
| **Automation & AI** | Argo CD, KEDA, Predictive AI Models | **None** | Ansible 기반 설정 자동화 수준이며, 이벤트 기반 동적 확장 및 AI 예측 제어 체계 부재함. |

---

## 2. 주요 아키텍처 개선 제안 (Strategic Proposals)

### 2.1 스토리지 및 DB 가용성 고도화 (Phase 3 개선)
- **현상:** 단일 노드 스토리지(RAID/LVM) 및 기본적인 DB 복제 구조.
- **개선:** 
    - **Ceph 도입:** 하드웨어 레벨의 분산 스토리지 클러스터 구축으로 VM 디스크 데이터의 완전한 가용성 확보함.
    - **Galera Cluster & ProxySQL:** 무중단 DB 서비스(Multi-Master)와 쿼리 기반 부하 분산(Read/Write Split) 체계 구현함.
    - **garbd 활용:** 최소 노드(2개 데이터 노드 + 1개 중재자) 환경에서 쿼럼(Quorum) 유지를 통한 비용 효율적 HA 구성함.

### 2.2 멀티 클러스터 관측성 강화 (Phase 4 개선)
- **현상:** 단일 프로메테우스/그라파나 기반 리소스 모니터링.
- **개세:** 
    - **Thanos 아키텍처:** 멀티 클러스터/하이브리드 환경의 프로메테우스 데이터를 통합 관리하고 장기 보관함.
    - **Loki & Fluent Bit:** 중앙 집중식 로그 수집 및 Ceph 기반 장기 보관 시스템 구축으로 사후 분석 역량 강화함.
    - **k6 부하 테스트:** 시스템 한계점(p95 Latency)을 정량적으로 측정하여 인프라 성능 벤치마킹 체계 마련함.

### 2.3 지능적 트래픽 및 자원 제어 (Phase 6 개선)
- **현상:** 단순 임계치(CPU/MEM) 기반의 정적 자원 관리.
- **개선:** 
    - **KEDA & Karpenter:** 요청 수(RPS) 및 이벤트 기반의 즉각적 쿠버네티스 자원 확장 체계 도입함.
    - **Predictive Scaling (AI):** MS AI 모델 등을 활용하여 과거 부하 패턴 분석 기반의 선제적 자원 증설(Proactive Scaling) 구현함.
    - **Cloud Bursting:** 온프레미스 임계 부하 초과 시 퍼블릭 클라우드 자원을 자동 연동하는 하이브리드 버스팅 구조 설계함.

---

## 3. 기술 도입 우선순위 로드맵 (Priority Roadmap)

1.  **우선순위 1 (고가용성 기반 다지기):**
    - **Ceph & Galera Cluster:** 인프라의 가장 취약한 지점(데이터 유실)을 보강하기 위해 최우선 도입 권장함.
    - **Redis (Session/Cache):** 웹 서비스 응답 속도 개선 및 DB 부하 절감을 위해 필수적임.
2.  **우선순위 2 (운영 가시성 및 신뢰성 확보):**
    - **k6 부하 테스트:** 현재 구축된 인프라의 실제 성능 검증 및 개선 지점 도출 위해 필요함.
    - **pfSense:** 네트워크 경계 보안 강화를 위한 전문 방화벽 솔루션 도입함.
3.  **우선순위 3 (자동화 고도화 및 지능화):**
    - **Argo CD (GitOps):** 관리 일관성 확보를 위해 쿠버네티스 전환 시 병행 도입함.
    - **AI 예측 모델:** 인프라가 안정화된 후 비용 및 자원 효율 극대화를 위한 최종 단계로 추진함.
