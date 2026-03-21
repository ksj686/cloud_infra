# 신규 직원 대상 SSH 온보딩 프로세스

## 1. 개요
- **목적:** 신규 입사자의 서버 액세스 권한 부여 및 키 기반 보안 인증 체계 수립
- **보안 원칙:** 패스워드 인증 배제, SSH 키 페어 기반 인증 생활화

## 2. 작업 절차

### 단계 1: 로컬 장비 SSH 키 페어 생성
- 대상: 신규 직원 개인 노트북/PC
- 명령: `ssh-keygen -t ed25519 -C "user@domain.com"` (권장)
- 생성 파일: `id_ed25519` (개인키), `id_ed25519.pub` (공개키)

### 단계 2: 서버로 공개키 업로드
- **방법 1 (간편):** `ssh-copy-id user@server_host` 활용
- **방법 2 (수동):** 공개키(`*.pub`) 내용을 `~/.ssh/authorized_keys` 파일에 추가

### 단계 3: 서버 측 파일/디렉터리 권한 조정
- SSH 디렉터리 권한: `chmod 700 ~/.ssh` (본인 전용)
- 공개키 목록 파일 권한: `chmod 600 ~/.ssh/authorized_keys` (읽기/쓰기 제한)

### 단계 4: SSH 설정 최적화 및 보안 강화 (선택 사항)
- `/etc/ssh/sshd_config` 내 `PasswordAuthentication no` 설정 확인
- `AllowUsers` 목록에 신규 사용자 ID 추가

### 단계 5: 연결 테스트 및 권한 확인
- 신규 직원의 로컬 장비에서 `ssh user@server_host` 접속 시도
- 패스워드 입력 없이 접속 성공 여부 검토
- `sudo` 권한 필요 시 `/etc/sudoers` 등록 또는 `sudo` 그룹 지정
