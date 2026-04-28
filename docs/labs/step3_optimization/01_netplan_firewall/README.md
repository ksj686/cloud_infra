# Netplan 및 방화벽(UFW/Iptables) 설정 가이드

## Netplan 네트워크 설정

- **개요:** Ubuntu 시스템 기본 네트워크 설정 도구. `/etc/netplan/` 내 YAML 파일 활용.
- **주요 명령어:**
  - 설정 적용: `sudo netplan apply`
  - 설정 시도 및 자동 복구: `sudo netplan try` (실패 대비 권장)
- **설정 예시:** `netplan_config_sample.yaml` 파일 참조.

## UFW 방화벽 관리

- **개요:** `iptables` 관리를 위한 사용자 친화적 인터페이스.
- **기본 사용법:**
  - UFW 활성화: `sudo ufw enable`
  - 서비스/포트 허용: `sudo ufw allow 22/tcp` 또는 `sudo ufw allow ssh`
  - 특정 서브넷 차단: `sudo ufw deny from 192.168.1.0/24`
  - 포트 포워딩: `/etc/default/ufw` 및 `/etc/ufw/before.rules` 수정.

## Iptables 고급 설정

- **개요:** 네트워크 패킷 직접 제어를 위한 로우 레벨 도구.
- **주요 명령어:**
  - 규칙 리스트 조회: `sudo iptables -L -n -v`
  - 특정 IP 차단: `sudo iptables -A INPUT -s 1.2.3.4 -j DROP`
