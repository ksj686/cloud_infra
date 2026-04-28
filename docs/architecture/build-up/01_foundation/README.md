# [Phase 1] Foundation: 시스템 기초 및 OS 하드닝

`project_outline.md`의 Phase 1 설계를 바탕으로 한 운영체제(OS) 수준의 보안성 및 가용성 확보 절차 정리

---

## 1. 하이퍼바이저 준비 및 네트워크 기초 (Infrastructure)

물리 하드웨어 가상화 및 통합 관리망 구축을 위한 기초 인프라 준비

- **Proxmox VE 설치 및 관리망 구성:**
  - 물리 서버에 Proxmox VE 8.x 설치 및 초기 네트워크 인터페이스(NIC) 설정
  - **네트워크 할당 계획:** Gateway `192.168.100.1`, Proxmox UI 접속 주소 `https://192.168.100.10:8006`
- **표준 가상 머신(VM) 생성:**
  - Ubuntu Server 24.04 LTS 공식 템플릿 기반 게스트 OS 프로비저닝
  - **Cloud-init 자동화:** `timezone: Asia/Seoul` 설정 및 `qemu-guest-agent`, `curl` 등 필수 패키지 자동 설치 템플릿 정의
  - **권장 하드웨어 사양:**
    - CPU: 최소 2 Core (AES-NI 명령어 세트 지원 확인을 통한 암호화 성능 확보)
    - RAM: 최소 4GB (운영 안정성 고려)
    - Disk: 20GB 이상 (VirtIO SCSI 컨트롤러 기반 I/O 성능 최적화)
- **가상화 전략 수립:** 운영 환경은 Proxmox 중심, 로컬 샌드박스 및 프로토타입 검증은 VMware 워크스테이션 활용

## 2. OS 보안 하드닝 및 접근 제어 (System Hardening)

외부 침입 차단 및 시스템 안정성 극대화를 위한 보안 최적화 수행

- **SSH 보안 강화 (Secure Access):**
  - **패스워드 인증 배제:** `/etc/ssh/sshd_config` 내 `PasswordAuthentication no` 설정을 통한 무차별 대입 공격(Brute-force) 원천 봉쇄
  - **SSH 키 인증 강제:** ED25519 알고리즘 기반의 고강도 공개키 인증 체계 적용
  - **Root 직접 로그인 차단:** `PermitRootLogin no` 설정을 통한 보안 사각지대 제거
  - **비표준 포트 운용:** 기본 22번 포트를 `Port 2222` 등으로 변경하여 자동화된 공격 시도 회피
  - **접속 제한 파라미터:** `MaxAuthTries 3`, `LoginGraceTime 30` 설정으로 인증 단계 보안 강화
- **계정 및 sudo 권한 관리:**
  - 작업 전용 일반 사용자 계정 생성 및 `sudo` 그룹 배정을 통한 관리자 권한 분리 운영
  - `visudo`를 통한 특정 명령어 제한 및 권한 상승 이력 기록 체계 수립
- **보안 패치 유지보수 자동화:**
  - `unattended-upgrades` 패키지 도입을 통한 보안 업데이트 실시간 자동 적용
  - `/etc/apt/apt.conf.d/50unattended-upgrades` 내 배포처 설정을 통한 제로데이 취약점 노출 최소화
- **메모리 운영 무결성 (K8s 준비):**
  - **Swap 비활성화:** 스케줄링 예측 불가능성 제거를 위해 `sudo swapoff -a` 실행 및 `/etc/fstab` 내 swap 항목 영구 제거 필수
- **시스템 최적화:** `apt autoremove` 및 `apt clean` 정기 수행을 통한 디스크 잔여 데이터 정리 및 파일 시스템 안정성 유지

## 3. 시스템 감사 체계 구축 (Security Auditing)

커널 레벨의 실시간 행위 감시 및 무결성 검증을 위한 감사 시스템 가동

- **auditd 설치 및 활성화:** 커널 레벨 감사 패키지 설치 (`sudo apt install auditd`) 및 부팅 시 자동 시작 등록
- **초정밀 감사 규칙 (Audit Rules) 적용:**
  - **설정 경로:** `/etc/audit/rules.d/audit.rules`
  - **핵심 파일 무결성 감시:** `/etc/passwd`, `/etc/shadow` 등 계정 정보 파일 수정 행위 실시간 감시 (`-w /etc/passwd -p wa -k user_modify`)
  - **권한 상승 시도 추적:** `/etc/sudoers` 파일 변조 및 특권 획득 시도 추적 (`-w /etc/sudoers -p wa -k priv_esc`)
  - **명령어 실행 이력 전수 기록:** `execve` 시스템 호출(Syscall) 감시를 통한 모든 명령어 실행 이력 확보 (`-a always,exit -F arch=b64 -S execve -k cmd_history`)
- **보안 리포트 프로세스:** `aureport` 명령어를 활용하여 시스템 가동 시간, 실패한 프로세스, 보안 이벤트를 요약한 일일 보고서 검토 환경 마련

## 4. 서버 측 Docker 보안 및 편의 설정

인프라 노드 내 Docker 엔진 안정성 및 기밀성 확보

- **자격 증명 암호화 (Credential Helper):**
  - **목적:** `~/.docker/config.json` 내 비밀번호 평문(Base64) 저장에 따른 보안 경고 해결 및 암호화 보관
  - **설치 명령어:** `sudo apt update && sudo apt install pass golang-docker-credential-helpers -y`
  - **설정 절차:**
    1. GPG 키 생성: `gpg --generate-key` (이름/이메일 입력 후 ID 확인)
    2. Pass 초기화: `pass init <GPG-ID_또는_이메일>`
    3. Docker 연동: `~/.docker/config.json` 파일 내 `"credsStore": "pass"` 항목 추가
- **cloud-init 기반 호스트 정보 영구 고정:**
  - **대상:** Proxmox 클라우드 템플릿 기반으로 생성된 모든 인프라 노드
  - **해결:** cloud-init이 부팅 시 `/etc/hosts`를 초기화하는 현상 방지
  - **조치:** `/etc/cloud/templates/hosts.ubuntu.tmpl` 파일 최하단에 `127.0.0.1 api.kosa.kr hub.kosa.kr` 등 필요한 도메인 명시적 추가
