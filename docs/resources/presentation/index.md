# Project Presentation Guide

본 문서는 프로젝트의 핵심 가치와 기술적 성과를 효과적으로 전달하기 위한 발표 시나리오 및 장표별 세부 내용 정리

---

## 🎤 발표 시나리오 및 흐름 (Storyline)

### [Part 1] 도입 및 비전 (Introduction)

- **문서:** [01_vision_and_goals.md](./01_vision_and_goals.md)
- **핵심:** 왜 이 프로젝트가 필요한가? (보안과 가용성이 결여된 인프라의 위험성 제시)

### [Part 2] 다계층 보안 방어 체계 (Layered Security)

- **문서:** [02_security_guardrails.md](./02_security_guardrails.md)
- **핵심:** 'Shift-Left' 철학 기반의 로컬 가드레일과 자동화된 보안 파이프라인 시연

### [Part 3] 무중단 가용성 아키텍처 (Redundancy & HA)

- **문서:** [03_high_availability.md](./03_high_availability.md)
- **핵심:** SPoF 없는 인프라 설계 (Proxmox HA, Galera DB Cluster, Ceph 분산 스토리지)

### [Part 4] 운영 자동화 및 관측성 (Ops & Observability)

- **문서:** [04_automated_ops.md](./04_automated_ops.md)
- **핵심:** 데이터 기반 의사결정 (Thanos 통합 모니터링, k6 부하 테스트, AI 예측 확장)

### [Part 5] 결론 및 기대 효과 (Conclusion)

- **문서:** [05_impact_and_future.md](./05_impact_and_future.md)
- **핵심:** 프로젝트 도입 후 얻게 되는 정량적/정성적 이득 및 향후 확장 계획
