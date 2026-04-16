# Infrastructure vs Application HA 전략 분석 (Proxmox vs K8s/Swarm)

본 문서는 Proxmox 하이퍼바이저 기반의 인프라 HA와 Kubernetes/Docker Swarm 기반의 애플리케이션 HA의 기술적 차이점, 상호 보완성 및 대체 가능성을 분석함.

## 1. 개요 및 Phase 매핑 (Overview & Phase Mapping)

- **인프라 계층 HA (Phase 1-3):** 하드웨어 및 OS 장애 대응. VM 전체 복구 및 하이퍼바이저 수준의 생존성 확보.
- **애플리케이션 계층 HA (Phase 5-6):** 컨테이너 및 마이크로서비스 장애 대응. 서비스 가용성 극대화 및 자가 치유(Self-healing) 수행.

## 2. 기술적 비교 (Technical Comparison)

| 항목              | Proxmox HA (Infrastructure)              | K8s / Docker Swarm (Application)                      |
| :---------------- | :--------------------------------------- | :---------------------------------------------------- |
| **복구 단위**     | 가상 머신(VM), 컨테이너(LXC) 전체        | 포드(Pod), 컨테이너(Container), 서비스(Service)       |
| **복구 메커니즘** | VM 재시작 (Restart based)                | 서비스 재배치 및 오케스트레이션 (Orchestration based) |
| **복구 속도**     | 분 단위 (OS 부팅 시간 포함)              | 초 단위 (프로세스 실행 시간)                          |
| **상태 관리**     | 가상 디스크(VHD) 기반 상태 보존          | Stateless 권장, PV/PVC를 통한 상태 관리               |
| **핵심 기술**     | Corosync, Quorum, Fencing (Fence-device) | etcd, Control Plane, Scheduler, Health Check          |
| **의존성**        | 공유 스토리지(Shared Storage) 필수       | 네트워크 기반 서비스 디스커버리 및 오케스트레이터     |

## 3. 대체 가능성 및 한계점 (Substitutability & Limitations)

### 3.1. 대체 가능한 시나리오 (Substitutable)

- **Stateless 서비스:** 웹 서버, API 게이트웨이 등 데이터 저장이 필요 없는 서비스는 K8s/Swarm만으로도 충분한 HA 보장.
- **클라우드 네이티브 아키텍처:** 서비스 간 통신이 로드 밸런서를 통해 추상화되어 있는 경우, 하부 VM의 장애가 서비스 중단으로 이어지지 않음.

### 3.2. 대체 불가능한 시나리오 (Limitations)

- **인프라 기반 서비스:** DB 엔진, 스토리지 컨트롤러(Ceph OSD 등)와 같이 물리적 디스크나 커널 수준의 정밀 제어가 필요한 경우 Proxmox HA가 필수적임.
- **레거시 워크로드:** 컨테이너화되지 않은 모놀리식(Monolithic) 애플리케이션이나 특정 OS 환경에 종속된 서비스는 VM 단위의 보호가 필요함.
- **부트스트래핑(Bootstrapping) 문제:** K8s 클러스터 자체의 가용성을 유지하기 위해 하부의 VM/네트워크/스토리지가 안정적이어야 하므로, 인프라 HA는 K8s의 '기반(Foundation)' 역할을 수행함.

## 4. 계층형 가용성(Layered Availability) 전략

최적의 아키텍처는 두 기술을 상호 보완적으로 운용하는 **'Full-stack HA'** 구성임.

- **Phase 3 (Persistence):** Ceph와 같은 분산 공유 스토리지를 구축하여 데이터의 가용성 확보.
- **Phase 1-3 (Infra HA):** Proxmox HA를 통해 K8s 마스터/워커 노드(VM)의 생존성 보장. 물리 서버 장애 시 VM 자동 복구.
- **Phase 5-6 (App HA):** K8s/Swarm을 통해 컨테이너 단위의 헬스 체크 및 장애 전파 차단. 사용자 요청의 연속성 유지.

## 5. 결론 및 향후 과제 (Conclusion & Next Steps)

- **결론:** K8s/Swarm은 애플리케이션 가용성 측면에서 Proxmox HA를 능가하는 유연성을 제공하나, 인프라의 안정적인 기반(Foundation) 없이는 클러스터 전체의 붕괴(Cascading Failure) 위험이 존재함.
- **향후 과제:**
  - Proxmox 상에서 가동되는 K8s 클러스터의 장애 시나리오 테스트(VM Kill vs Node Kill) 수행.
  - IaC(Ansible/Terraform)를 활용한 클러스터 노드 자동 복구 및 확장성 검증 (Phase 6).
