# Playbook: 신규 사용자 SSH 온보딩 프로세스

## 1. 개요
- **목적:** 신규 인력 대상 서버 액세스 권한 부여 및 보안 인증 체계 수립
- **보안 원칙:** 패스워드 인증 배제, SSH 키 페어 기반 인증 필수화

## 2. 작업 절차

### 1단계: 로컬 장비 SSH 키 페어 생성
- **대상:** 신규 사용자 로컬 단말기
- **권장 방식:** `ssh-keygen -t ed25519 -C "user@domain.com"`
- **결과물:** `id_ed25519`(개인키), `id_ed25519.pub`(공개키)

### 2단계: 서버 내 공개키 등록
- **자동 등록:** `ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server_host`
- **수동 등록:** 공개키 내용을 서버 측 `~/.ssh/authorized_keys` 파일에 추가

### 3단계: 파일 시스템 및 디렉터리 권한 조정
- **SSH 디렉터리:** `chmod 700 ~/.ssh` (사용자 전용)
- **공개키 파일:** `chmod 600 ~/.ssh/authorized_keys` (읽기/쓰기 제한)

### 4단계: SSH 보안 설정 최적화 및 사용자 허용
- `/etc/ssh/sshd_config` 내 `PasswordAuthentication no` 설정 검증
- `AllowUsers` 목록에 신규 사용자 ID 추가 및 서비스 재로드(`sudo systemctl reload ssh`)

### 5단계: 연결 검증 및 권한 확인
- 신규 사용자 로컬 장비에서의 SSH 접속 테스트
- 패스워드 없는 키 기반 접속 성공 여부 판단
- 관리자 권한 필요 시 `sudo` 그룹 지정 및 `/etc/sudoers` 등록 검토

## 3. 기술 가이드 (Guidance)
- **개인키 보안:** `id_ed25519` 파일의 외부 유출 금지 및 로컬 시스템 내 권한 보호 필수
- **ED25519 권장:** RSA 대비 보안성 및 성능이 뛰어난 ED25519 알고리즘 사용 권장
- **감사:** 정기적인 `authorized_keys` 파일 검수를 통한 퇴사자 및 불필요 공개키 제거
