# Playbook: auditd 기반 시스템 보안 감사 (Security Auditing)

## 📌 개요
- 커널 레벨 시스템 호출(System Call) 및 파일 접근 행위 감시
- 중요 설정 파일 변조 및 비인가 권한 상승 시도 추적성 확보

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
- **설정 경로:** `/etc/audit/rules.d/audit.rules`
- **주요 감시 대상 (Watch)**
    - `-w [경로] -p [권한] -k [키워드]` 형식 사용
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
    # sudo 명령어 실행 및 비인가 UID 변경 감시
    -a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k elevated_privs
    ```

## 🛠️ 2단계: 규칙 적용 및 검증
- **규칙 로드**
    ```bash
    sudo augenrules --load
    ```
- **적용 규칙 리스트 확인**
    ```bash
    sudo auditctl -l
    ```

## 🛠️ 3단계: 로그 분석 및 가시성 확보
- **키워드 기반 검색 (`ausearch`)**
    ```bash
    # 사용자 변경 관련 로그 필터링
    sudo ausearch -k user_modify
    ```
- **보안 요약 리포트 생성 (`aureport`)**
    ```bash
    # 전체 파일 접근 요약 출력
    sudo aureport -f -i
    ```

## 💡 기술 가이드 (Guidance)
- **로그 보존 정책:** `/etc/audit/auditd.conf` 내 `max_log_file` 및 `num_logs` 설정을 통한 디스크 용량 관리
- **성능 최적화:** 모든 시스템 호출 감시 지양, 보안 임계 지점 위주 규칙 최소화 운영
- **중앙 로그 통합:** 대규모 환경 시 `audisp-remote` 활용 중앙 로그 서버 실시간 전송 권장
