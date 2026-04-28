# [Step 5-1] auditd를 활용한 시스템 감사 설정

**목표:** 주요 시스템 파일의 변경 사항을 실시간 감시하고 감사 로그를 분석함.

### 1. auditd 설치 및 상태 확인

- **패키지 설치:** `sudo apt update && sudo apt install auditd -y`
- **상태 확인:** `sudo systemctl status auditd`

### 2. 감사 규칙(Rules) 설정

- `/etc/audit/rules.d/audit.rules` 파일에 다음 내용 추가하여 민감 파일 감시함.
  - `-w /etc/passwd -p wa -k user_modify`: 계정 정보 변경 감시
  - `-w /etc/shadow -p wa -k password_modify`: 비밀번호 파일 변경 감시
- **규칙 적용:** `sudo augenrules --load`

### 3. 로그 분석 (ausearch)

- **특정 키워드 검색:** `sudo ausearch -k user_modify`
- **최근 변경 기록 확인:** `sudo ausearch -f /etc/passwd`
- **가독성 있는 보고서 생성:** `sudo aureport -f`
