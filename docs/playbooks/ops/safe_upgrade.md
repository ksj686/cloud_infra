# Playbook: 안전한 인프라 업데이트 절차 (Safe Upgrade)

## 📌 개요

- 시스템 안정성 유지 및 보안 패치 적용 표준 절차
- 무분별한 업데이트로 인한 서비스 중단 리스크 최소화

## ✅ 사전 준비 (Prerequisites)

- **스냅샷 및 백업 수행**
  - Proxmox VE 또는 하이퍼바이저 내 VM 스냅샷 생성
  - DB 및 중요 설정 파일 별도 백업 확인
- **활성 서비스 확인**
  - `systemctl list-units --type=service --state=running`

## 🛠️ 1단계: 정보 수집 및 리스트 갱신

- **패키지 정보 갱신**
  ```bash
  sudo apt update
  ```
- **업데이트 대상 식별**
  ```bash
  apt list --upgradable
  ```

## 🛠️ 2단계: 선별적 업데이트 및 보류 (Hold)

- **핵심 패키지 개별 업데이트**
  - 영향도가 큰 패키지(Nginx, 커널 등) 우선 업데이트 후 영향도 분석
  ```bash
  sudo apt install --only-upgrade <package_name>
  ```
- **버전 고정 (Hold)**
  - 특정 버전 유지가 필요한 경우 업데이트 대상 제외
  ```bash
  sudo apt-mark hold <package_name>
  ```

## 🛠️ 3단계: 서비스 검증 및 로그 모니터링

- **프로세스 재시작 필요 여부 확인**
  ```bash
  sudo needrestart
  ```
- **실시간 오류 확인**
  ```bash
  journalctl -f
  ```

## 🛠️ 4단계: 시스템 유지보수 (Cleanup)

- **아카이브 파일 정리: `apt clean`**
  - `/var/cache/apt/archives` 내 설치 파일 제거 및 디스크 공간 확보
  ```bash
  sudo apt clean
  ```
- **불필요한 의존성 제거: `apt autoremove`**
  - 시뮬레이션(`-s`) 후 삭제 목록 전수 확인 기반 제한적 수행
  ```bash
  sudo apt autoremove -s
  ```

## 💡 기술 가이드 (Guidance)

- **Staging 환경 검증:** 운영 서버 적용 전 테스트 VM 내 선행 수행 권장
- **변경 이력 분석:** 주요 패키지 업데이트 시 공식 Change Log 확인 필수
- **점진적 배포:** 서비스 노드별 순차적 업데이트를 통한 고가용성 유지
