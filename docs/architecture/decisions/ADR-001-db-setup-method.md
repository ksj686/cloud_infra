# ADR-001: DB 구축 방식: 직접 구축(Self-managed) 채택

- **Status:** ✅ Accepted
- **Date:** 2026-03-31
- **Decider:** Gemini CLI & User

## Context (배경)

- 데이터베이스 인프라 구축 시, 블랙박스 형태의 Managed 서비스(RDS 등) 대신 인프라 전 계층의 제어권을 확보해야 함.
- 고가용성 구현을 위해 **최소 3개 노드의 VM 프로비저닝**이 필요하며, 이 과정에서 **Terraform**과 같은 IaC 도구의 도입을 검토 중임.

## Alternatives Considered (대안 분석)

1. **Managed Service:** 운영은 편하나 복제 메커니즘(Quorum, GCache) 학습이 불가능하고 비용이 높음.
2. **Container-only:** 오케스트레이션 엔진 없이 운영 시 데이터 영속성 관리가 까다로움.

## Decision (결정)

- **Self-managed (Proxmox VM 직접 설치)** 방식을 채택하여 학습 깊이를 극대화함.
- MariaDB Galera Cluster + ProxySQL 조합으로 L7 계층까지 포함된 HA 아키텍처를 직접 구축함.

## Consequences (결과)

- **이득:** DB 내부 동작 원리에 대한 완벽한 이해 및 인프라 특화 튜닝 가능.
- **비용:** 프로비저닝 및 클러스터 관리 공수가 크며, 3개 노드 운영을 위한 자원 확보 필요.
