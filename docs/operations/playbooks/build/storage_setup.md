# RAID 1 및 LVM 기반 스토리지 구축 가이드

## 1. 개요

- **목적:** RAID 1(미러링)과 LVM을 결합한 데이터 안정성 및 확장성 확보
- **주요 구성 요소:** mdadm, LVM2, ext4

## 2. 작업 절차

### 단계 1: 물리 디스크 추가 및 파티션 설정

- 신규 디스크 인식 확인 (`lsblk` 또는 `fdisk -l`)
- `fdisk /dev/sdb`, `fdisk /dev/sdc` 등을 통해 파티션 생성
- 파티션 타입 설정을 RAID용(`fd`)으로 변경 권장
- `partprobe` 명령으로 커널에 파티션 정보 갱신

### 단계 2: RAID 1 어레이(Array) 생성

- `mdadm`을 이용한 미러링 구성
  ```bash
  sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
  ```
- 어레이 초기화 상태 확인 (`cat /proc/mdstat`)

### 단계 3: LVM 구성 (PV, VG, LV)

- **PV(Physical Volume) 생성:** RAID 장치 기반
  ```bash
  sudo pvcreate /dev/md0
  ```
- **VG(Volume Group) 생성:**
  ```bash
  sudo vgcreate dataVG /dev/md0
  ```
- **LV(Logical Volume) 생성:**
  ```bash
  sudo lvcreate -L 10G -n dataLV dataVG
  ```

### 단계 4: 파일 시스템 생성 및 마운트

- **파일 시스템 포맷:**
  ```bash
  sudo mkfs.ext4 /dev/dataVG/dataLV
  ```
- **마운트 포인트 생성 및 연결:**
  ```bash
  sudo mkdir -p /mnt/storage
  sudo mount /dev/dataVG/dataLV /mnt/storage
  ```

### 단계 5: 영구 마운트 설정 (/etc/fstab)

- UUID 확인 (`blkid`)
- `/etc/fstab` 파일에 마운트 정보 추가
- `mount -a` 수행으로 오타 및 설정 오류 검증
