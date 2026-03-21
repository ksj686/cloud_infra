# RAID 1 장애 발생 시 긴급 복구 매뉴얼

## 1. 개요
- **목적:** RAID 1(미러링) 환경 내 디스크 장애 시 신속한 데이터 보호 및 어레이 정상화
- **징후:** 디스크 장애 알림, `cat /proc/mdstat` 내 `(F)` 표시 발생

## 2. 작업 절차

### 단계 1: 장애 상태 식별 및 데이터 보호
- 시스템 로그(`dmesg` 또는 `/var/log/syslog`) 내 디스크 입출력 오류 확인
- RAID 어레이 상태 조회: `cat /proc/mdstat`
- 실패(fail)로 간주되는 디스크 파티션(예: `/dev/sdb1`) 식별

### 단계 2: 결함 디스크 강제 해제 및 제거
- `mdadm --fail` 명령으로 결함 디스크 상태 명시적 확정
  ```bash
  sudo mdadm --fail /dev/md0 /dev/sdb1
  ```
- 어레이 구성에서 결함 장치 논리적 제거
  ```bash
  sudo mdadm --remove /dev/md0 /dev/sdb1
  ```

### 단계 3: 신규 디스크 파티션 구성 및 추가
- 물리 디스크 교체 (필요 시 서버 전원 차단 후 작업)
- 파티션 구성: 원본 디스크와 동일 규격으로 설정
- 어레이 신규 디스크 편입
  ```bash
  sudo mdadm --add /dev/md0 /dev/sdd1
  ```

### 단계 4: 재동기화(Resync) 프로세스 모니터링
- 자동 데이터 복제 시작 여부 확인
- 진행 상황 실시간 감시 (100% 완료 시까지)
  ```bash
  watch -n 1 cat /proc/mdstat
  ```

### 단계 5: 최종 건전성 확인 및 마무리
- 어레이 세부 상태 점검: `sudo mdadm --detail /dev/md0`
- 모든 디스크가 'active sync' 상태인지 최종 확인
