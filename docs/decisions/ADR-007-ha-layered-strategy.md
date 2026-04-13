# ADR-007: HA 계층형 가용성(Layered Availability) 채택

- **Status:** ✅ Accepted
- **Date:** 2026-04-13
- **Decider:** Gemini CLI & User

## Context (배경)

- Proxmox 하이퍼바이저 기반의 인프라 HA와 Kubernetes/Docker Swarm 기반의 애플리케이션 HA의 역할이 중첩됨에 따라, 어떤 계층에서 가용성을 보장할지에 대한 명확한 기준이 필요함.
- 인프라 하부(OS/Storage)의 안정성이 담보되지 않은 상태에서의 앱 계층 HA는 클러스터 전체의 붕괴(Cascading Failure) 위험을 초래할 수 있음.

## Decision (결정)

- **계층형 가용성(Layered Availability)** 전략을 프로젝트의 표준 아키텍처로 채택함.
- **인프라 계층(Phase 1-3):** Proxmox HA를 통해 VM 및 기반 스토리지의 생존성 보장.
- **애플리케이션 계층(Phase 5-6):** K8s/Swarm을 통해 컨테이너 단위의 자가 치유 및 중단 없는 서비스 제공.

## Consequences (결과)

- **이득:** 하드웨어 장애부터 앱 오류까지 전 범위에 걸친 복구력(Resilience) 확보.
- **비용:** 이중 HA 구성에 따른 시스템 복잡도 및 리소스 오버헤드 증가. 쿼럼(Quorum) 유지를 위한 최소 노드 수(3개 이상) 준수 필요.
