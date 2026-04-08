# LVM 볼륨 축소(Reduction) 가이드

파일 시스템 및 논리 볼륨(LV) 축소 절차 기술. 데이터 손실 위험이 있으므로 정밀한 단계별 수행 필요.

## 전제 조건

- 가동 중인 LVM 환경 구축 완료.
- 중요 데이터 사전 백업 실시.

## 단계별 가이드

### 1. 볼륨 마운트 해제

- 안전한 축소를 위해 대상 파일 시스템 언마운트 수행.
  ```bash
  sudo umount /mnt/lvm_data
  ```

### 2. 파일 시스템 점검

- 변경 전 파일 시스템 오류 유무 확인 및 무결성 검증.
  ```bash
  sudo e2fsck -f /dev/myVG/myLV
  ```

### 3. 파일 시스템 크기 조정

- 파일 시스템 크기를 목표치로 우선 축소(예: 500MB).
  ```bash
  sudo resize2fs /dev/myVG/myLV 500M
  ```

### 4. 논리 볼륨(LV) 축소

- 파일 시스템 크기에 맞춰 LV 크기 감축.
  ```bash
  sudo lvreduce -L 500M /dev/myVG/myLV
  ```
- **주의:** 경고 메시지 확인 후 'y' 입력.

### 5. LV 최적화 확장 (권장)

- 파일 시스템이 LV 공간을 완전히 활용하도록 재조정.
  ```bash
  sudo resize2fs /dev/myVG/myLV
  ```

### 6. 마운트 및 최종 확인

- 볼륨 재마운트 후 적용 크기 및 데이터 상태 확인.
  ```bash
  sudo mount /dev/myVG/myLV /mnt/lvm_data
  df -h /mnt/lvm_data
  ```

---

_주의: 데이터 유실 방지를 위해 설정 크기 재차 확인 필수._
