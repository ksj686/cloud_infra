# 커널 설정(Configuration) 가이드

`make menuconfig` 활용 사용자 정의 Linux 커널 최적화 및 설정 모범 사례 기술.

## 전제 조건
- Linux 커널 소스 코드 다운로드 완료.
- 빌드 도구 설치 필수 (`build-essential`, `libncurses-dev`, `bison`, `flex`, `libssl-dev`, `libelf-dev`).

## `make menuconfig` 주요 설정 가이드

### 1. 기존 설정 기반 시작
- 시스템 안정성 확보를 위해 현재 구동 중인 커널 설정 복사 활용.
  ```bash
  cp /boot/config-$(uname -r) .config
  make menuconfig
  ```

### 2. 서버 최적화 주요 영역

#### Networking Support -> Networking Options
- **특정 프로토콜 활성화:** 복잡한 네트워크 환경(SCTP, BGP 등) 대응 시 필요 옵션 선택.
- **방화벽 지원:** `ufw`, `iptables` 정상 작동을 위한 `Netfilter` 프레임워크 활성화 확인.

#### Device Drivers
- **스토리지 컨트롤러:** RAID 컨트롤러(PERC, LSI 등) 전용 드라이버 활성화.
- **네트워크 인터페이스(NIC):** 고성능 서버 NIC(Intel `igb`, `ixgbe` 등) 드라이버 활성화.
- **보안 강화:** 운영 환경 불필요 USB 지원 비활성화로 공격 표면 축소 및 커널 경량화.

#### File Systems
- 주요 파일 시스템(`ext4`, `xfs`, `btrfs` 등)을 부트 파티션 지원 위해 내장(Built-in) 방식으로 빌드.

### 3. 최신 커널 보안 수정 (6.x 이상)
- 인증서 문제 방지를 위해 특정 보안 키 옵션 비활성화 처리.
- 대상 옵션: `CONFIG_SYSTEM_TRUSTED_KEYS`, `CONFIG_SYSTEM_REVOCATION_KEYS`.
- 자동화 명령어 활용:
  ```bash
  scripts/config --disable SYSTEM_TRUSTED_KEYS
  scripts/config --disable SYSTEM_REVOCATION_KEYS
  ```

---
*참고: 커널 경량화는 성능/보안에 유리하나 하드웨어 호환성 주의 필요.*
