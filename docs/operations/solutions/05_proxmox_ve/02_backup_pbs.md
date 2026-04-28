# Proxmox Backup Server (PBS) 활용 가이드

Proxmox Backup Server(PBS)는 PVE 환경에 최적화된 백업 솔루션으로, 강력한 중복 제거와 고속 복구 기능을 제공합니다.

### 1. PBS 개요 (Introduction)

- **전용 서버**: PVE와 별도의 하드웨어 또는 VM에 설치하여 독립적으로 운영 가능.
- **오픈소스**: PVE와 마찬가지로 엔터프라이즈 기능이 오픈소스로 공개되어 있음.
- **보안**: AES-256GCM 클라이언트 측 암호화를 지원하여 데이터 유출 방지.

### 2. PBS의 주요 이점 (Benefits)

- **중복 제거 (Deduplication)**:
  - 서로 다른 VM 간의 동일한 데이터 블록을 하나만 저장하여 저장 공간을 획기적으로 절약.
- **증분 백업 (Incremental Backup)**:
  - 초기 백업 이후 변경된 데이터만 전송하여 백업 속도를 대폭 향상.
- **무결성 검사 (Integrity Check)**:
  - 저장된 백업 데이터가 손상되지 않았는지 정기적으로 자동 검증.
- **고속 복구 (Live Restore)**:
  - 백업 이미지에서 즉시 VM을 부팅하여 복구 시간을 최소화 (데이터는 백그라운드에서 점진적으로 복구).

### 3. PVE-PBS 연동 및 스케줄링

1. **PBS 설정**:
   - PBS 설치 후 'Datastore' 생성.
   - PVE 연동을 위한 'Fingerprint' 정보 확인.
2. **PVE에 PBS 스토리지 추가**:
   - PVE UI의 `Datacenter -> Storage -> Add -> Proxmox Backup Server` 메뉴 이용.
   - 서버 IP, ID, 패스워드, 지문 정보 입력.
3. **백업 작업 예약 (Scheduling)**:
   - `Datacenter -> Backup -> Add`에서 대상 VM과 PBS 스토리지를 선택.
   - 백업 주기(Daily, Weekly 등)와 보관 정책(Retention Policy) 설정.
   - 예: 'Keep last 7 backups' (최근 7개 백업본만 유지).
