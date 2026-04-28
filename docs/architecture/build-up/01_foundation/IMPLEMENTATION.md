# Implementation Guide: Phase 1 Foundation

본 문서는 Phase 1 인프라 기초 및 OS 하드닝 구성을 위한 상세 명령어 및 설정 파일 명세 정리

---

## 1. 하이퍼바이저 및 게스트 OS 준비

### 1.1 Proxmox 클라우드 템플릿 기반 VM 생성 (CLI 예시)

```bash
# Ubuntu 24.04 클라우드 이미지 다운로드
wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img

# Proxmox 템플릿 생성 (VM ID 9000 기준)
qm create 9000 --memory 4096 --core 2 --name ubuntu-2404-template --net0 virtio,bridge=vmbr0
qm importdisk 9000 noble-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
qm template 9000
```

---

## 2. OS 보안 하드닝 (System Hardening)

### 2.1 SSH 보안 강화 설정

```bash
# 설정 파일 수정
sudo vi /etc/ssh/sshd_config
```

```yaml
# /etc/ssh/sshd_config 수정 내역
Port 2222
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
LoginGraceTime 30
```

```bash
# 설정 적용 및 재시작
sudo sshd -t && sudo systemctl restart ssh
```

### 2.2 자동 보안 업데이트 활성화

```bash
sudo apt update && sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure -plow unattended-upgrades
```

### 2.3 Swap 비활성화 (K8s 준비)

```bash
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
```

---

## 3. 시스템 감사 체계 (auditd)

### 3.1 패키지 설치 및 규칙 적용

```bash
sudo apt install auditd -y

# 감사 규칙 작성
sudo vi /etc/audit/rules.d/audit.rules
```

```yaml
# /etc/audit/rules.d/audit.rules 추가 내역
# 파일 무결성 감시
-w /etc/passwd -p wa -k user_modify
-w /etc/shadow -p wa -k user_modify
-w /etc/sudoers -p wa -k priv_esc

# 명령어 실행 이력 전수 기록
-a always,exit -F arch=b64 -S execve -k cmd_history
```

```bash
# 규칙 로드 및 상태 확인
sudo augenrules --load
sudo auditctl -l
```

---

## 4. 서버 측 Docker 보안 설정

### 4.1 Docker Credential Helper (pass) 설정

```bash
sudo apt update && sudo apt install pass golang-docker-credential-helpers -y

# GPG 키 생성 (대화형 실행)
gpg --generate-key

# Pass 초기화 (생성한 이메일 주소 사용)
pass init "your-email@example.com"

# Docker 설정 반영
mkdir -p ~/.docker
vi ~/.docker/config.json
```

```json
{
  "credsStore": "pass"
}
```

### 4.2 cloud-init 호스트 정보 고정

```bash
sudo vi /etc/cloud/templates/hosts.ubuntu.tmpl
```

```yaml
# 파일 최하단에 수동 도메인 추가 (초기화 방지)
127.0.0.1 api.kosa.kr hub.kosa.kr
```
