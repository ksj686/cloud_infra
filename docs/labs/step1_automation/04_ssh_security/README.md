# SSH 보안 강화 가이드

**목표:** SSH 서버 보호 필수 단계 수행 (Ubuntu/Debian)

## 1. 기본 포트 변경

- 기본 포트(`22`) 변경을 통한 자동화 스크립트 노이즈 감소
- 설정: `/etc/ssh/sshd_config` 내 `Port 2222` 지정

## 2. 루트(root) 로그인 비활성화

- 보안 위험 방지를 위한 `root` 직접 로그인 차단
- 설정: `/etc/ssh/sshd_config` 내 `PermitRootLogin no` 지정

## 3. 키 기반 인증만 허용

- SSH 키 설정 완료 후 비밀번호 기반 인증 비활성화
- 설정: `/etc/ssh/sshd_config` 내 `PasswordAuthentication no` 지정

## 4. 특정 사용자만 허용

- 액세스 가능 사용자 명시적 제한
- 설정: `/etc/ssh/sshd_config` 내 `AllowUsers [사용자명]` 지정

## 변경 사항 적용

- `/etc/ssh/sshd_config` 수정 후 설정 테스트 및 서비스 재시작
- 실행 예시:
  - `sudo sshd -t`: 설정 구문 테스트
  - `sudo systemctl restart ssh`: SSH 서비스 재시작
