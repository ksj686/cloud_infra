# Project Compare Review

`project_compare.md` 대화 내용을 현재 Cloud Infrastructure 문서화 프로젝트의 Phase 1-7 구조와 비교한 반영 기준 정리

---

## 1. 검토 결론

대화 내용은 **2주 AWS 앱 배포 팀 프로젝트**에 최적화된 제안이 많음. 현재 저장소는 **온프레미스 Proxmox/Ceph 기반 표준 인프라를 Phase별로 구축하고, 마지막에 AWS와 연동하는 문서화 프로젝트**이므로 다음 기준으로 선별 반영함.

- **직접 반영:** 현재 Phase 구조를 더 명확하게 만드는 기술 판단 기준
- **조건부 반영:** Phase 7 또는 고급 실습에서 검증할 수 있는 AWS/EKS 확장안
- **보류:** 기존 프로젝트 범위를 AWS ECS 단독 배포 프로젝트로 바꾸는 내용

---

## 2. 영역별 비교 결과

| 영역          | 대화 내용                                         | 현재 프로젝트 판단                                                    | 반영 결과                                         |
| :------------ | :------------------------------------------------ | :-------------------------------------------------------------------- | :------------------------------------------------ |
| 프로젝트 범위 | 4명/2주 앱 배포 테스트 중심                       | 현재 프로젝트는 문서화·실습 로드맵 중심의 Phase 1-7 인프라 구축       | 일정/역할 분담은 보류                             |
| 컴퓨팅        | ECS Fargate 권장                                  | 온프레미스 Proxmox, VM, Kubernetes가 중심이고 AWS는 Phase 7 확장 영역 | ECS 단독 전환 보류                                |
| 네트워크/LB   | ALB/NLB/GWLB 선택 기준 제안                       | 현재 Nginx/Ingress 중심 설계에 AWS 연동 판단 기준이 부족              | ALB/NLB/GWLB 목적별 기준 반영                     |
| 스토리지      | S3, Ceph 용도 정리                                | Ceph/MinIO/S3 전이 전략과 잘 맞음                                     | RBD/RGW/CephFS 역할 분리 반영                     |
| DB            | RDS 미사용 시 EC2 기반 PXC + ProxySQL             | 기존 MariaDB Galera + ProxySQL 전략과 유사하나 PXC 대안 설명이 유용   | PXC를 MySQL 호환 대안으로 조건부 반영             |
| CI/CD         | GitHub Actions → ECR → ECS                        | 현재는 pre-commit, 보안 자동화, GitOps/Argo CD가 중심                 | ECS 배포 파이프라인은 보류, GitOps 유지           |
| 모니터링      | CloudWatch 중심                                   | 현재 Prometheus/Grafana/Thanos 중심, CloudWatch는 AWS 연동 보조       | CloudWatch 단독 전환 보류                         |
| 보안          | IAM, SG, WAF, Secrets Manager                     | Phase 7 AWS 보안 경계 설명에 적합                                     | 목적별 AWS 보안 진입점 설명에 부분 반영           |
| 오토스케일링  | HPA/KEDA/Karpenter, Route 53 Weighted             | Phase 6-7 고급 확장 주제와 정합                                       | Cloud Burst 모델로 반영                           |
| 발표 표현     | 계층별 구성보다 트래픽 흐름/구성 요소별 표현 제안 | 네트워크 계층과 혼동을 줄일 수 있음                                   | 문서 표현은 Phase/구성 요소/트래픽 흐름 중심 유지 |

---

## 3. 채택한 설계 보완

### 3.1 목적별 로드밸런서 선택

- **ALB(Application Load Balancer):** HTTP/HTTPS, 웹 앱, API, WAF 연동, 경로/호스트 기반 라우팅
- **NLB(Network Load Balancer):** TCP/UDP, 고정 IP, 낮은 지연 시간, DB 프록시 전면 진입점
- **GWLB(Gateway Load Balancer):** 방화벽, IDS/IPS 같은 보안 장비 체인
- **현재 기준:** 온프레미스 기본 진입점은 Nginx/Ingress와 MetalLB, AWS 연계 진입점은 ALB 중심

### 3.2 Ceph 활용 범위 명확화

- **RBD(RADOS Block Device):** Proxmox VM 디스크, Kubernetes PVC, DB 데이터 볼륨
- **RGW(RADOS Gateway):** S3 호환 백업 저장소, 파일 업로드 저장소, S3 전이 검증
- **CephFS:** 다중 노드 공유 파일, 모델/로그 공유 실험

### 3.3 직접 운영 DB 선택지 정리

- **기본:** MariaDB Galera Cluster + ProxySQL
- **대안:** Percona XtraDB Cluster(PXC) + ProxySQL
- **주의:** 2노드 동기식 클러스터는 쿼럼 문제가 있으므로 3노드 기준 검토, ProxySQL 단일 구성은 단일 장애점(SPoF)으로 관리

### 3.4 하이브리드 Kubernetes 확장 모델

- **권장:** 온프레미스 Kubernetes와 AWS EKS 분리 운영
- **트래픽 제어:** Route 53 Weighted/Failover 라우팅
- **Pod 확장:** HPA/KEDA
- **Node 확장:** Karpenter 또는 Cluster Autoscaler
- **보류:** 단일 Kubernetes 클러스터에 온프레미스와 AWS 노드를 혼합하는 방식은 고급 과제로 분리

---

## 4. 보류한 내용

- **ECS Fargate 단독 아키텍처:** 현재 프로젝트의 온프레미스 기반 Phase 1-6 흐름과 충돌
- **CloudWatch 단독 관측 체계:** Prometheus/Grafana/Thanos 중심 관측성 전략을 대체할 근거 부족
- **4명/2주 역할 분담:** 팀 프로젝트 일정표로는 유용하지만 현재 문서화 로드맵과 직접 연결되지 않음
- **RDS 중심 DB:** 비용과 직접 운영 경험을 중시하는 현재 HA 실습 방향과 다름

---

## 5. 반영 위치

- `docs/architecture/project_outline.md`: Phase 2/3/6/7 기준 보강
- `docs/resources/knowledge_base/ceph_storage_deep_dive.md`: Ceph 인터페이스와 프로젝트 활용 예시 보강
- `docs/architecture/build-up/06_scalability/README.md`: DB 대안, ProxySQL 이중화, K8s 확장 기준 보강
- `docs/architecture/build-up/07_hybrid/README.md`: Cloud Burst, Route 53, EKS 확장, LB 선택 기준 보강
- `docs/engineering/standards/hybrid_network_strategy.md`: 온프레미스-AWS 트래픽 라우팅 및 확장 기준 보강
- `docs/architecture/CORE_FEATURE_EXPLAINER.md`: 핵심 특장점 설명에 Ceph/LB/Cloud Burst 반영
