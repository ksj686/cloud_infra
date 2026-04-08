# Cloud Infra Project: 실무 기반 인프라 구축 및 운영

본 프로젝트는 보안성, 가용성, 자동화를 핵심 가치로 하는 실무 수준의 클라우드 인프라 설계 및 운영 가이드

---

## 🚀 학습 로드맵 (Learning Roadmap)

```mermaid
graph TD
    subgraph "Phase 1-3: Foundation & Persistence"
    S1[Step 1: Automation] --> S2[Step 2: Troubleshoot]
    S2 --> S3[Step 3: Optimization]
    end
    subgraph "Phase 4-5: Ops & Security"
    S3 --> S4[Step 4: Expansion]
    S4 --> S5[Step 5: Advanced Security]
    end
    subgraph "Phase 6-7: Enterprise & AI"
    S5 --> S6[Step 6: Enterprise HA]
    S6 --> S7[Step 7: Cloud Native AI]
    end
    style S1 fill:#f9f,stroke:#333,stroke-width:2px
```

---

## 1. 프로젝트 개요 (Overview)

- **목적:** 안정적이고 보안이 강화된 리눅스 기반 인프라 아키텍처 설계 및 운영 표준 정립
- **핵심 원칙:**
  - **Security:** SSH 키 기반 인증, 방화벽 최적화, 정기 보안 감사 수행
  - **Availability:** RAID/LVM 기반 스토리지 설계, 자동 백업 및 복구 체계 구축
  - **Automation:** Bash 쉘 스크립트 및 IaC(Ansible) 기반 운영 자동화 구현

## 2. 기술 스택 (Tech Stack)

- **Virtualization:** Proxmox VE (Primary), VMware (Sandbox)
- **OS:** Ubuntu Server 24.04 LTS, Alpine Linux
- **Web/Proxy:** Nginx
- **Storage:** RAID 1/5, ZFS, LVM, Ceph (Advanced)
- **Automation:** Bash Shell, Ansible, Terraform
- **Monitoring:** Prometheus, Grafana, Thanos (Multi-cluster), Loki

## 3. 문서 시스템 가이드 (Documentation Guide)

- **[README.md](./docs/index.md):** 프로젝트 전체 개요 및 아키텍처 청사진 제공
- **[CORE_FEATURE_EXPLAINER.md](./docs/CORE_FEATURE_EXPLAINER.md):** 프로젝트 핵심 기술적 차별성 및 보안 특장점 상세 설명
- **[project_outline.md](./docs/project_outline.md):** 단계별(Phase 1-6) 기술적 상세 설계 및 체크리스트
- **[SCENARIOS.md](./docs/SCENARIOS.md):** 상황별 흐름 및 운영 전략(Strategy) 마스터 인덱스
- **[playbooks/](./docs/playbooks/):** 실제 수행 명령어가 담긴 원자적(Atomic) 절차서(Tactics)
  - `ops/`: 일상 운영 및 온보딩 절차
  - `recovery/`: 장애 대응 및 복구 절차
- **[case_studies/](./docs/case_studies/):** 실제 보안 대응 및 트러블슈팅 사례(Lessons Learned) 기록물
- **[knowledge_base/](./docs/knowledge_base/):** 고도화 기술 가이드 및 아키텍처 분석(Thanos, Ceph, AI 등) 자료
- **[Management Docs]:**
  - [Workflow](./docs/PROJECT_WORKFLOW.md): 프로젝트 실행 공정 및 대화 기반 의사결정 로그
  - [Task Guide](./docs/CURRENT_TASK_GUIDE.md): 현재 진행 중인 활성 작업 실행 매뉴얼
  - [Env Setup](./docs/ENVIRONMENT_SETUP.md): MkDocs 가동 및 초기 환경 구축 영구 지침
- **[to-do-list.md](./docs/to-do-list.md):** 인프라 구축 및 보안 표준 환경 실습 로드맵
- **[to-do-space/](./docs/to-do-space/):** 로드맵 항목별 단계별 가이드 및 실전 스크립트 보관소
- **[solutions/](./docs/solutions/):** 핵심 오픈소스 솔루션(Airflow, Wazuh, Vault 등) 구축 가이드

## 4. 인프라 구축 단계 (Infrastructure Phases)

- **Phase 1 (Foundation):** 시스템 기초, 하드닝 및 커널 최적화 수행
- **Phase 2 (Perimeter):** 보안 경계 설정, 방화벽 및 네트워크 세분화 구현
- **Phase 3 (Persistence):** 데이터 영속성 확보, 가용 스토리지 및 데이터 거버넌스 수립
- **Phase 4 (Observability):** 운영 가시성 확보, 서비스 안정화 및 가용성 관리
- **Phase 5 (Pipeline):** 자동화 워크플로우, 형상 관리 및 배포 자동화 구축
- **Phase 6 (Scalability):** 코드형 인프라 완성, 대규모 환경 복제 및 확장성 확보

## 5. 단계별 자동화 보안 도구 (Automated Security Tools)

| 단계 (Phase)          | 도구 (Tool)                       | 목적                                          |
| :-------------------- | :-------------------------------- | :-------------------------------------------- |
| **Phase 1: Local**    | `pre-commit`, `Gitleaks`          | 커밋 전 민감 정보 유출 차단 및 코드 품질 검사 |
| **Phase 2: CI**       | `CodeQL`, `Semgrep`, `pnpm audit` | SAST 및 오픈소스 라이브러리 취약점 심층 분석  |
| **Phase 3: Artifact** | `Trivy`                           | Docker 이미지 OS 및 패키지 취약점 스캔        |
| **Phase 4: Alert**    | `Slack`, `SMTP`, `Webhook`        | 파이프라인 실패 및 보안 이벤트 실시간 알림    |

## 6. 프로젝트 비전: 보안 필수 체계가 완비된 표준 환경 (Starter Kit)

단순 실습을 넘어, 어떤 클라우드/온프레미스 환경에서도 **적용 가능한 보안 표준 기반** 제공 목표. 최소한의 설정만으로도 검증된 보안 인프라 신속 구축 가능.

## 7. 유사 사례 및 참고 프로젝트 (Benchmarking)

- **[Ansible Lockdown]:** 업계 표준 보안 지침(CIS Benchmark) 기반 OS 자동 강화 프로젝트
- **[DevSec Hardening Framework]:** "보안을 코드처럼" 관리하는 자동화 템플릿 제공
- **[AWS Landing Zone]:** 대규모 클라우드 환경 초기 보안 가드레일 설정 서비스
- **차별점:** 실무 중심의 명사형 가이드와 즉시 실행 가능한 스크립트 제공을 통한 현업 접근성 강화

## 8. 향후 보완 방향 (Roadmap)

- **IaC 코드화 (Ansible/Terraform):** 현재 문서 가이드를 원클릭 실행 가능한 코드로 전환
- **Golden Image 빌드:** 보안 하드닝 완료 표준 OS 이미지 생성 자동화(Packer 활용)
- **컴플라이언스 매핑:** KISA 가이드라인 및 CIS Benchmark 항목 준수 여부 시각화
- **하이브리드 확장:** 온프레미스(Proxmox)와 퍼블릭 클라우드 간의 유연한 자원 연동(Cloud Bursting) 구현
