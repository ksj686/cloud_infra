# [Phase 1] Foundation: 시스템 기초 및 OS 하드닝

`project_outline.md`의 Phase 1 설계를 바탕으로 한 운영체제(OS) 수준의 보안 및 가용성 확보 절차 정리

---

## 1. 하이퍼바이저 준비 (Proxmox/VMware)

- **Proxmox 설치:** 물리 서버에 Proxmox VE 8.x 설치 및 초기 네트워크 구성
- **VM 생성:** Ubuntu Server 24.04 LTS 템플릿 기반 가상 머신 프로비저닝
- **리소스 할당:** 최소 CPU 2 Core, RAM 2GB, Disk 20GB 이상 확보

## 2. OS 보안 하드닝 (System Hardening)

- **SSH 보안 강화:**
  - 패스워드 인증 비활성화 및 SSH 키 기반 인증 강제화
  - Root 로그인 차단 및 비표준 포트(예: 2222) 사용 권장
- **권한 관리:** 일반 사용자 계정 생성 및 `sudo` 권한 부여를 통한 작업 이력 분리
- **자동 업데이트 설정:** `unattended-upgrades` 패키지 설치 및 보안 업데이트 자동화 적용

## 3. 시스템 감사 체계 구축 (Audit)

- **auditd 설치:** 커널 레벨 감사 시스템 가동 (`sudo apt install auditd`)
- **감사 규칙(Audit Rules) 적용:**
  - `/etc/passwd`, `/etc/shadow` 등 핵심 설정 파일 실시간 감시
  - `/etc/sudoers` 변조 시도 및 민감 명령어 실행 이력 추적 규칙 로드
- **정기 검검:** `aureport` 명령어를 통한 일일 보안 감사 리포트 검토 환경 마련
