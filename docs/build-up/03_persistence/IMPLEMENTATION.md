# Implementation Guide: Phase 3 Persistence

본 문서는 Phase 3 데이터 영속성 및 고가용성 스토리지(Ceph, MinIO) 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. 가용 스토리지 구성 (RAID/LVM)

### 1.1 RAID 1 (Mirroring) 구축

```bash
# mdadm 도구 설치 및 어레이 생성
sudo apt update && sudo apt install mdadm -y
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
```

---

## 2. 분산 블록 스토리지 (Ceph)

하이퍼바이저 레벨의 데이터 가용성 및 VM 영속성 확보

### 2.1 Proxmox 기반 Ceph 초기화

```bash
# Proxmox CLI 설치 및 모니터/매니저 구성
pveceph install
pveceph init --network 10.0.0.0/24
pveceph mon create
pveceph mgr create
```

### 2.2 OSD 생성 및 풀(Pool) 설정

```bash
# 디스크 등록 및 3중화 풀 생성
pveceph osd create /dev/sdd
pveceph pool create vm_storage --size 3 --min_size 2
```

---

## 3. 사설 객체 저장소 (MinIO)

애플리케이션 계층의 S3 호환 파일 저장소 구축

### 3.1 Docker Compose를 이용한 MinIO 클러스터 가동

```yaml
# minio-compose.yml
services:
  minio:
    image: quay.io/minio/minio:latest
    command: server /data --console-address ":9001"
    ports:
      - "9000:9000" # API 포트
      - "9001:9001" # 관리 UI 포트
    environment:
      MINIO_ROOT_USER: admin
      MINIO_ROOT_PASSWORD: YourStrongPassword
    volumes:
      - minio_data:/data

volumes:
  minio_data:
```

### 3.2 MinIO 클라이언트(mc) 기본 설정

```bash
# CLI 도구 설치 및 서버 등록
wget https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
./mc alias set myminio http://localhost:9000 admin YourStrongPassword

# 버킷 생성 및 정책 설정
./mc mb myminio/infra-assets
./mc anonymous set public myminio/infra-assets
```

---

## 4. 클라우드 전이 및 데이터 마이그레이션 (Migration)

온프레미스(MinIO) 데이터를 운영 환경(AWS S3)으로 이관하는 실무 절차

### 4.1 마이그레이션 수행 (mc mirror)

```bash
# 1. AWS S3 타겟 등록
./mc alias set awss3 https://s3.ap-northeast-2.amazonaws.com ACCESS_KEY SECRET_KEY

# 2. 온프레미스 데이터를 클라우드로 동기화 (미러링)
./mc mirror --overwrite myminio/infra-assets awss3/kosa-infra-static-assets
```

### 4.2 하이브리드 운영 전략 참조

- **상세 아키텍처 및 전이 전략:** [AWS S3 & CloudFront 가속 전략](../../standards/aws_s3_cloudfront_strategy.md) 문서 참조 필수.

---

## 5. 엔터프라이즈 백업 (PBS)

... (기존 PBS 설정 유지)
