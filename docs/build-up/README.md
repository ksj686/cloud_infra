# Infrastructure Build-up Guide (Phase 1-6)

본 문서는 `project_outline.md` 설계 청사진을 바탕으로, 실제 인프라를 처음부터 끝까지 구축하기 위한 단계별 기술 실행 절차 정리

---

## 🏗️ 구축 단계별 바로가기 (Phases)

### [Phase 1] 시스템 기초 및 OS 하드닝

- **목표:** 안정적이고 보안이 강화된 베이스 서버 환경 구축
- **가이드:** [01_foundation/README.md](./01_foundation/README.md)
- **상세 구현:** [01_foundation/IMPLEMENTATION.md](./01_foundation/IMPLEMENTATION.md)

### [Phase 2] 네트워크 경계 보안 및 고도화

- **목표:** 트래픽 제어 및 MacVLAN 기반 네트워크 격리 구현
- **가이드:** [02_perimeter/README.md](./02_perimeter/README.md)
- **상세 구현:** [02_perimeter/IMPLEMENTATION.md](./02_perimeter/IMPLEMENTATION.md)

### [Phase 3] 데이터 영속성 및 가용 스토리지

- **목표:** RAID/Ceph 기반 데이터 보호 및 자동 백업 체계 수립
- **가이드:** [03_persistence/README.md](./03_persistence/README.md)
- **상세 구현:** [03_persistence/IMPLEMENTATION.md](./03_persistence/IMPLEMENTATION.md)

### [Phase 4] 운영 가시성 및 성능 최적화

- **목표:** APM 기반 프로파일링 및 서비스 가용성 튜닝
- **가이드:** [04_observability/README.md](./04_observability/README.md)
- **상세 구현:** [04_observability/IMPLEMENTATION.md](./04_observability/IMPLEMENTATION.md)

### [Phase 5] 보안 파이프라인 및 이미지 관리

- **목표:** 사설 레지스트리(Harbor) 및 자동화된 보안 스캔 환경 구축
- **가이드:** [05_pipeline/README.md](./05_pipeline/README.md)
- **상세 구현:** [05_pipeline/IMPLEMENTATION.md](./05_pipeline/IMPLEMENTATION.md)

### [Phase 6] IaC 기반 확장 및 고가용성

- **목표:** Terraform/Ansible을 통한 자동화 및 멀티 노드 HA 완성
- **가이드:** [06_scalability/README.md](./06_scalability/README.md)
- **상세 구현:** [06_scalability/IMPLEMENTATION.md](./06_scalability/IMPLEMENTATION.md)
