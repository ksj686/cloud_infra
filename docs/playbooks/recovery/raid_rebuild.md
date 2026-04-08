# Playbook: RAID 1 장애 발생 시 긴급 복구 절차

## 1. 개요

- **목적:** RAID 1(미러링) 환경 내 디스크 장애 시 데이터 보호 및 어레이 정상화
- **징후:** 시스템 알림, `cat /proc/mdstat` 내 `(F)` 표시 발생

## 2. 작업 절차

### 1단계: 장애 상태 파악 및 결함 식별

- 시스템 로그(`dmesg`) 및 `/var/log/syslog` 내 I/O 오류 확인
- RAID 어레이 상태 조회: `cat /proc/mdstat`
- 실패(Fail) 장치 파티션(예: `/dev/sdb1`) 식별

### 2단계: 결함 디스크 강제 해제 및 논리적 제거

- `mdadm --fail` 명령을 통한 결함 디스크 상태 확정
  ```bash
  sudo mdadm --fail /dev/md0 /dev/sdb1
  ```
- 어레이 구성에서 결함 장치 제거
  ```bash
  sudo mdadm --remove /dev/md0 /dev/sdb1
  ```

### 3단계: 신규 디스크 파티션 구성 및 편입

- 물리 디스크 교체 (필요 시 서버 전원 차단 후 작업)
- 파티션 구성: 원본 디스크와 동일한 규격 및 타입 설정
- 어레이 내 신규 디스크 추가
  ```bash
  sudo mdadm --add /dev/md0 /dev/sdd1
  ```

### 4단계: 재동기화(Resync) 프로세스 모니터링

- 데이터 복제 자동 시작 여부 검증
- 진행률 실시간 감시 (100% 완료 시까지)
  ```bash
  watch -n 1 cat /proc/mdstat
  ```

### 5단계: 최종 무결성 검증 및 마무리

- 어레이 세부 상세 점검: `sudo mdadm --detail /dev/md0`
- 모든 디바이스의 'active sync' 상태 여부 최종 확인

## 3. 기술 가이드 (Guidance)

- **데이터 백업:** RAID 작업 착수 전 최우선 데이터 백업 권장
- **동일 규격:** 교체용 디스크는 기존 디스크와 동일하거나 더 큰 용량 사용 필수
- **부트로더:** 시스템 부팅 디스크 장애 시 `grub` 등 부트로더 재설치 고려
