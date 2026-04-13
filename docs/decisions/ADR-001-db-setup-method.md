# ADR-001: DB 구축 방식: 직접 구축(Self-managed) 채택

- **Status:** ✅ Accepted
- **Date:** 2026-03-31
- **Decider:** Gemini CLI & User

## Context (배경)

- 데이터베이스 인프라 구축 시, Managed 서비스(RDS 등)를 사용할지 아니면 직접 VM/컨테이너에 설치하여 운영할지에 대한 선택이 필요함.
- 프로젝트의 핵심 목적이 '인프라 엔지니어링 역량 강화'와 '시스템 내부 구조 이해'에 있음.

## Decision (결정)

- 데이터베이스를 직접 설치 및 구성하는 **Self-managed** 방식을 채택함.
- MariaDB Galera Cluster 및 ProxySQL 등을 활용하여 고가용성(HA) 아키텍처를 직접 설계하고 구축함.

## Consequences (결과)

- **이득:** DB 엔진의 세부 설정, 복제 메커니즘, 장애 조치(Failover) 프로세스에 대한 깊은 기술적 이해 확보.
- **비용:** 패치, 백업, 튜닝 등 운영 부하가 증가하며, 고도의 관리 역량이 요구됨.
