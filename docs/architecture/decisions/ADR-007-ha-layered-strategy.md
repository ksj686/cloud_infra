# ADR-007: HA 계층형 가용성(Layered Availability) 채택

- **Status:** ✅ Accepted
- **Date:** 2026-04-13
- **Decider:** Gemini CLI & User

## Context (배경)

- Proxmox 하이퍼바이저 수준의 HA와 Kubernetes/Docker Swarm 수준의 HA는 복구 계층(VM vs Container)이 다름.
- 두 시스템이 중복 동작하거나, 혹은 상부 시스템의 복구 능력을 맹신하여 하부 인프라를 방치할 경우 '기반 시스템 붕괴' 시 복구 불능 상태에 빠질 수 있음.

## Alternatives Considered (대안 분석)

1. **Hypervisor-only HA:** 하드웨어 장애에는 강하나, VM 내 프로세스(앱) 중단 시 이를 감지하고 재시작하는 속도가 느림.
2. **Orchestrator-only HA:** 앱 가용성은 유연하게 관리하나, 워커 노드(VM) 자체가 죽었을 때 물리 노드 간의 리소스 재배치 및 펜싱(Fencing) 기능이 약함.

## Decision (결정)

- **계층형 가용성(Layered Availability)** 아키텍처를 표준으로 채택함.
- **인프라 계층(Phase 1-3):** Proxmox HA + Ceph 공유 스토리지를 통해 물리 장애 시 VM 전체의 '생존'을 보장.
- **애플리케이션 계층(Phase 5-6):** K8s/Swarm의 오케스트레이션을 통해 프로세스 수준의 '무중단 서비스' 구현.
- **원칙:** "하부 인프라가 튼튼해야 상부 애플리케이션의 유연성이 가치를 발휘한다."

## Consequences (결과)

- **이득:**
  - 하드웨어, 네트워크, 커널, 애플리케이션 전 계층에 걸친 다중 방어선(Multi-tier Defense) 구축.
  - 한 계층의 장애가 시스템 전체의 치명적 실패(Cascading Failure)로 이어지는 것을 방지.
- **비용:** 클러스터 구성의 난이도가 상승하며, 최소 3개 이상의 물리 노드가 필수적이므로 하드웨어 자원 비용 발생.
