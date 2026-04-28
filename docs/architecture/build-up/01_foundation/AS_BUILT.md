# As-built Specification: Phase 1 Foundation

본 문서는 Phase 1 가이드를 바탕으로 실제 환경에 구축된 시스템의 세부 명세 및 설정값 기록

---

## 1. 하이퍼바이저 실구축 정보 (Hypervisor Details)

- **노드 명칭:** `pve-node-01`
- **관리 IP:** `192.168.100.10` / MAC: `AA:BB:CC:DD:EE:FF`
- **커널 버전:** `Linux 6.5.11-8-pve`
- **스토리지 구성:**
  - `/ (Root)`: 500GB SSD (ZFS Single)
  - `/mnt/pve/data`: 2TB HDD (LVM-Thin)

## 2. 가상 머신(VM) 할당 내역 (VM Provisioning)

| VM ID | 호스트명     | 할당 IP          | CPU/RAM | 비고                      |
| :---- | :----------- | :--------------- | :------ | :------------------------ |
| `101` | `db-node-01` | `192.168.100.11` | 2C/4G   | Galera Master 1           |
| `102` | `db-node-02` | `192.168.100.12` | 2C/4G   | Galera Master 2           |
| `201` | `mgmt-srv`   | `192.168.100.50` | 1C/2G   | 중앙 관리 및 Ansible 서버 |

## 3. OS 수준 세부 설정 (OS Specifics)

- **사용자 계정:** `infra-admin` (UID 1001)
- **SSH 키 지문:** `SHA256:... (ed25519)`
- **비표준 포트:** `2022` (TCP) 적용 확인
- **auditd 적용 상태:**
  - 규칙 파일 무결성 검사 완료
  - `/var/log/audit/audit.log` 정상 기록 중

## 4. 특이 사항 및 현장 조치 (Field Notes)

- **인코딩 이슈:** 윈도우 PowerShell에서 Git 로그 확인 시 한글 깨짐 현상 발생 -> `chcp 65001` 및 `git config` UTF-8 설정으로 해결 완료
- **네트워크:** 초기 설치 시 `eno1` 인터페이스 미인식 발생 -> 비공식 드라이버 추가 로드를 통해 해결
