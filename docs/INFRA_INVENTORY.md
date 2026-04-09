# Infrastructure Inventory & As-built Dashboard

본 문서는 실제 구축된 인프라 자산의 전체 요약 및 Phase별 상세 기록(`AS_BUILT.md`) 인덱스 관리

---

## 🏗️ Phase별 상세 구축 기록 (Detailed Logs)

- **[Phase 1] Foundation 상세 명세:** [01_foundation/AS_BUILT.md](./build-up/01_foundation/AS_BUILT.md)
- **[Phase 2] Perimeter 상세 명세:** [02_perimeter/AS_BUILT.md (작성 예정)](./build-up/02_perimeter/AS_BUILT.md)
- **[Phase 3] Persistence 상세 명세:** [03_persistence/AS_BUILT.md (작성 예정)](./build-up/03_persistence/AS_BUILT.md)

---

## 1. 노드 및 IP 주소 할당 요약 (Summary)

| 노드 구분      | 호스트명 (Hostname) | IP 주소 (Static) | OS / OS 버전   | 용도                      |
| :------------- | :------------------ | :--------------- | :------------- | :------------------------ |
| **Hypervisor** | `proxmox-host`      | `192.168.100.10` | Proxmox VE 8.x | 물리 서버 제어 및 VM 관리 |
| **DB Node 1**  | `db-node-01`        | `192.168.100.11` | Ubuntu 24.04   | Galera Cluster 마스터 1   |
| **DB Node 2**  | `db-node-02`        | `192.168.100.12` | Ubuntu 24.04   | Galera Cluster 마스터 2   |
| **Backup**     | `pbs-server`        | `192.168.100.20` | PBS 3.x        | 이미지 레벨 증분 백업     |

---

## 2. 서비스 포트 및 접근 정책 (Service Ports)

| 분류           | 서비스명       | 포트 (Port) | 프로토콜 | 비고                         |
| :------------- | :------------- | :---------- | :------- | :--------------------------- |
| **Management** | SSH (Hardened) | `2022`      | TCP      | 기존 2222에서 정책 변경 반영 |
| **Management** | Proxmox UI     | `8006`      | HTTPS    |                              |
| **Database**   | MariaDB        | `3306`      | TCP      |                              |
| **Database**   | Galera Sync    | `4567`      | TCP/UDP  | 노드 간 동기화 전용          |

---

## 3. 커스텀 설정 및 특이 사항 (Special Notes)

- **보안 감사:** `auditd` 로그 보존 용량 `100MB`로 확장 (기준: 8MB)
- **네트워크:** MacVLAN 게이트웨이 `172.16.31.1` 할당 확인
- **환경 이슈:** 윈도우 에디터 사용 시 쉘 스크립트 강제 LF 전환 적용 중
