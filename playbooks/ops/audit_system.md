# Playbook: auditd를 활용한 시스템 보안 감사 (Security Auditing)

## 📌 개요
- 커널 레벨에서 시스템 호출(System Call) 및 파일 접근 행위 감시함.
- 중요 설정 파일 변조 및 비인가 권한 상승 시도에 대한 추적성 확보함.

## ✅ 사전 준비 (Prerequisites)
- **패키지 설치**
    ```bash
    sudo apt update && sudo apt install -y auditd audispd-plugins
    ```
- **서비스 상태 확인**
    ```bash
    sudo systemctl status auditd
    ```

## 🛠️ 1단계: 감사 규칙 설정 (Audit Rules)
- **설정 파일 경로:** `/etc/audit/rules.d/audit.rules`
- **중요 파일 감시 규칙 (Watch)**
    - `-w [경로] -p [권한] -k [키워드]` 형식 사용함.
    - 권한(p): r(읽기), w(쓰기), x(실행), a(속성 변경)
    ```bash
    # 계정 정보 및 비밀번호 파일 감시
    -w /etc/passwd -p wa -k user_modify
    -w /etc/shadow -p wa -k password_modify
    
    # SSH 설정 파일 감시
    -w /etc/ssh/sshd_config -p wa -k ssh_config_change
    ```
- **권한 상승 행위 감시 (Syscall)**
    ```bash
    # sudo 명령어 실행 감시
    -a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k elevated_privs
    ```

## 🛠️ 2단계: 규칙 적용 및 확인
- **규칙 로드**
    ```bash
    sudo augenrules --load
    ```
- **현재 적용된 규칙 확인**
    ```bash
    sudo auditctl -l
    ```

## 🛠️ 3단계: 로그 분석 및 리포팅
- **특정 키워드로 로그 검색 (`ausearch`)**
    - `-k` 옵션으로 설정한 키워드 기반 필터링함.
    ```bash
    # 사용자 변경 관련 로그 검색
    sudo ausearch -k user_modify
    ```
- **보안 감사 요약 리포트 생성 (`aureport`)**
    ```bash
    # 요약 리포트 출력
    sudo aureport -f -i
    ```

## 💡 전문적 조언 (Advice)
- **로그 보존 정책:** `/etc/audit/auditd.conf`에서 `max_log_file` 및 `num_logs` 설정을 통해 디스크 용량 관리 및 로그 보존 기간 설정 필수임.
- **성능 고려:** 모든 시스템 호출을 감시하면 성능 저하가 발생하므로, 보안상 크리티컬한 파일 및 행위 위주로 규칙을 최소화하여 운영함.
- **원격 로그 전송:** 대규모 환경에서는 `audisp-remote`를 사용하여 중앙 로그 서버로 실시간 전송하는 것을 권장함.
