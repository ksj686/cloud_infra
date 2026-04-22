# Implementation Guide: Phase 3 Persistence

본 문서는 Phase 3 데이터 영속성 및 가용 스토리지 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. 가용 스토리지 구성 (RAID/LVM)

### 1.1 RAID 1 (Mirroring) 구축

```bash
# mdadm 도구 설치
sudo apt update && sudo apt install mdadm -y

# sdb, sdc 디스크를 RAID 1로 묶음
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc

# 상태 확인
cat /proc/mdstat
sudo mdadm --detail /dev/md0
```

### 1.2 LVM 논리 볼륨 관리

```bash
# 물리 볼륨 생성
sudo pvcreate /dev/md0

# 볼륨 그룹 생성
sudo vgcreate infra_vg /dev/md0

# 논리 볼륨 생성 (100GB)
sudo lvcreate -L 100G -n data_lv infra_vg

# 파일 시스템 포맷 및 마운트
sudo mkfs.ext4 /dev/infra_vg/data_lv
sudo mkdir -p /data
sudo mount /dev/infra_vg/data_lv /data
```

---

## 2. 분산 스토리지 (Ceph)

### 2.1 Proxmox 기반 Ceph 초기화

```bash
# Proxmox CLI에서 Ceph 설치 (각 노드 공통)
pveceph install

# 초기 네트워크 설정 (10.0.0.x 대역 권장)
pveceph init --network 10.0.0.0/24

# 모니터(MON) 및 매니저(MGR) 생성
pveceph mon create
pveceph mgr create
```

### 2.2 OSD(디스크) 추가 및 풀 생성

```bash
# 각 노드의 비어있는 디스크(예: /dev/sdd)를 OSD로 등록
pveceph osd create /dev/sdd

# 스토리지 풀 생성 (3중화 복제)
pveceph pool create vm_storage --size 3 --min_size 2
```

---

## 3. 컨테이너 데이터 보존 (Volumes)

### 3.1 Docker 네임드 볼륨 생성 및 확인

```bash
# 데이터베이스용 영구 볼륨 생성
docker volume create db_data_prod

# 볼륨 상세 확인 (실제 저장 경로 파악)
docker volume inspect db_data_prod
```

### 3.2 Docker Compose 볼륨 매핑

```yaml
# docker-compose.yml 내 볼륨 정의 예시
services:
  db:
    image: mariadb:latest
    volumes:
      - db_data_prod:/var/lib/mysql
      - ./config/my.cnf:/etc/mysql/my.cnf:ro # 바인드 마운트

volumes:
  db_data_prod:
    external: true
```

---

## 4. 엔터프라이즈 백업 (PBS)

### 4.1 PBS 서버 등록 및 스케줄링 (Proxmox CLI)

```bash
# PBS 서버 인증 정보 등록
pvesm add pbs my-backup --server 192.168.100.20 --datastore main-store \
  --username admin@pbs --password "YourSecretPassword" --fingerprint "AA:BB:CC..."

# 백업 작업 생성 (매일 02시)
pvescheduler job create backup --id nightly-backup --storage my-backup \
  --vmid 101,102 --schedule "02:00" --mode snapshot
```
