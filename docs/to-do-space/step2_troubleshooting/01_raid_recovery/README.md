# RAID 1 복구 가이드

RAID 1(미러링) 어레이 디스크 장애 시뮬레이션 및 `mdadm` 활용 복구 절차 기술.

## 전제 조건
- 가동 중인 RAID 1 어레이(예: `/dev/md0`) 존재.
- 결함 디스크 교체용 예비 디스크 또는 파티션 확보.

## 단계별 가이드

### 1. 디스크 장애 시뮬레이션
- 어레이 내 특정 디스크를 실패(fail) 상태로 강제 설정.
  ```bash
  sudo mdadm --fail /dev/md0 /dev/sdc1
  ```

### 2. 장애 상태 확인
- RAID 어레이 상태 조회를 통한 실패 디스크 식별.
  ```bash
  cat /proc/mdstat
  # 또는
  sudo mdadm --detail /dev/md0
  ```
- 실패 장치 옆 `(F)` 표시 여부 확인.

### 3. 실패 디스크 제거
- 어레이에서 장애 발생 장치 물리적/논리적 제거.
  ```bash
  sudo mdadm --remove /dev/md0 /dev/sdc1
  ```

### 4. 새 디스크 추가
- 교체용 신규 디스크를 어레이에 편입.
  ```bash
  sudo mdadm --add /dev/md0 /dev/sdd1
  ```

### 5. 재구축(Rebuilding) 프로세스 모니터링
- RAID 어레이 자동 재구축(resyncing) 수행 및 진행 상황 감시.
  ```bash
  watch -n 1 cat /proc/mdstat
  ```
- 진행률 100% 도달 시까지 대기.

### 6. 최종 확인
- 어레이 정상 가동 및 모든 장치 활성 상태 검증.
  ```bash
  sudo mdadm --detail /dev/md0
  ```

---
*주의: RAID 작업 전 데이터 백업 필수 수행.*
