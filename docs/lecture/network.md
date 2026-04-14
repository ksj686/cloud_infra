# `/etc/network/interfaces` 와 `/etc/netplan/50-*.yaml` 차이점

`/etc/network/interfaces` 와 `/etc/netplan/50-*.yaml` 파일은 **네트워크 설정을 관리하는 방식이 서로 다른 시스템**에서 사용됩니다. 핵심 차이는 **사용하는 네트워크 관리 프레임워크**입니다.

---

# 1️⃣ `/etc/network/interfaces`

이 파일은 **전통적인 네트워크 설정 방식**에서 사용됩니다.

- 사용 도구: ifupdown
- 주요 명령: `ifup`, `ifdown`
- 사용 배포판: 예전 **Ubuntu**, **Debian**

### 특징

- 인터페이스별로 직접 설정
- 텍스트 기반 단순 구조
- `ifup` / `ifdown`이 직접 읽음

### 예

```
auto eth0
iface eth0 inet static
    address 192.168.1.10
    netmask 255.255.255.0
    gateway 192.168.1.1
```

동작 흐름

```
ifup/ifdown
   ↓
/etc/network/interfaces 읽음
   ↓
인터페이스 제어
```

---

# 2️⃣ `/etc/netplan/50-*.yaml`

이 파일은 **현대 Ubuntu에서 사용하는 네트워크 설정 방식**입니다.

- 사용 도구: Netplan
- 내부적으로 호출:
  - systemd-networkd
  - NetworkManager

### 특징

- YAML 형식
- 실제 네트워크 서비스 설정을 **생성(generate)** 하는 역할
- `netplan apply` 명령으로 적용

### 예

```
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
```

동작 흐름

```
netplan apply
   ↓
/etc/netplan/*.yaml 읽음
   ↓
systemd-networkd 또는 NetworkManager 설정 생성
   ↓
인터페이스 설정 적용
```

---

# 3️⃣ 핵심 차이 비교

| 구분      | /etc/network/interfaces | /etc/netplan/\*.yaml      |
| --------- | ----------------------- | ------------------------- |
| 방식      | 전통 방식               | 최신 방식                 |
| 관리 도구 | ifupdown                | Netplan                   |
| 설정 형식 | 일반 텍스트             | YAML                      |
| 적용 명령 | ifup / ifdown           | netplan apply             |
| 내부 엔진 | 직접 인터페이스 제어    | networkd / NetworkManager |
| 사용 환경 | Debian, 구버전 Ubuntu   | Ubuntu 17.10 이후         |

---

# 4️⃣ 중요한 포인트

**둘을 동시에 사용하는 경우는 거의 없습니다.**

Ubuntu에서:

- **16.04 이하** → `/etc/network/interfaces`
- **18.04 이상** → `/etc/netplan/*.yaml`

---

✅ 한 줄 정리

- `/etc/network/interfaces` → **ifupdown 방식 (구형)**
- `/etc/netplan/*.yaml` → **Netplan 기반 네트워크 관리 (신형)**

---

원하시면 추가로 **`ifdown`이 netplan 환경에서 왜 제대로 동작하지 않는지 (서버 트러블슈팅에서 자주 나오는 문제)**도 설명해 드리겠습니다.
