# 사용자 감사 가이드

**목표:** Ubuntu/Debian 시스템 사용자 및 그룹 감사 수행

## 사용자 데이터베이스 이해
- `/etc/passwd`: 전체 사용자 계정 나열
- `/etc/group`: 전체 사용자 그룹 나열

### `/etc/passwd` 형식
- `username:password:UID:GID:comment:home_directory:login_shell`
- 예시: `kosa:x:1000:1000:KOSA User:/home/kosa:/bin/bash`

### 감사 포인트
- **UID 0 확인**: `root` 계정 외 UID 0 할당 여부 점검 (시스템 전권 부여 방지)
- **로그인 쉘 확인**: 시스템 계정 로그인 방지를 위한 `/usr/sbin/nologin` 또는 `/bin/false` 설정 점검
- **휴면 계정 관리**: 장기간 미사용 계정 비활성화 및 제거
- **파일 권한 점검**: 민감한 설정 파일 권한 준수 확인
    - `/etc/passwd`: 644 (root:root)
    - `/etc/shadow`: 600 또는 640 (root:shadow)
