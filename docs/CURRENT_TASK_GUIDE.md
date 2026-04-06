# Current Active Task Execution Guide

본 문서는 `to-do-list.md`의 첫 번째 실습인 'Step 1-1: 크론탭 실행 결과 알림 시스템 구축'을 위한 단계별 상세 실행 매뉴얼

---

## 🏗️ 1단계: 실습 환경 및 가이드 확인
실무 시나리오 파악 및 소스 코드 위치 확인

- **가이드 위치:** `docs/to-do-space/step1_automation/01_cron_alert/README.md`
- **핵심 소스:** `docs/to-do-space/step1_automation/01_cron_alert/cron_task.sh`
- **목표:** 주기적 작업의 성공/실패 여부를 로그로 남기고, 실패 시 관리자에게 알림 발송 체계 구축

---

## 🚀 2단계: 실습 수행 절차 (Execution)

### 2.1 알림용 패키지 설치
메일 발송 기능을 테스트하기 위한 필수 도구 설치 (Ubuntu 기준)
```bash
sudo apt update && sudo apt install -y mailutils
```

### 2.2 실습 스크립트 분석 및 수정
- **파일명:** `cron_task.sh`
- **수정 사항:** 
    - `LOG_FILE` 경로 확인 및 권한 체크
    - `ADMIN_EMAIL` 변수를 본인의 테스트 이메일 주소로 수정
- **수동 실행 테스트:**
    ```bash
    chmod +x docs/to-do-space/step1_automation/01_cron_alert/cron_task.sh
    ./docs/to-do-space/step1_automation/01_cron_alert/cron_task.sh
    ```

### 2.3 크론탭(Crontab) 등록
시스템 스케줄러에 작업 등록 및 로그 리다이렉션 설정
```bash
# 크론탭 편집기 실행
crontab -e

# 아래 내용 추가 (매 분마다 실행 예시)
* * * * * /abs/path/to/cron_task.sh >> /var/log/cron_tasks.log 2>&1
```

---

## 🔍 3단계: 결과 검증 (Validation)
1. **로그 확인:** `/var/log/cron_task.log` 파일에 타임스탬프와 함께 성공 메시지가 기록되는지 확인
2. **실패 시뮬레이션:** 스크립트 내의 명령어를 의도적으로 틀리게 수정 후 알림(Mail 등)이 오는지 확인
3. **웹 포털 연동:** 실습 결과 리포트를 작성하여 웹 사이트에 업데이트

---

## 🌿 4단계: 실습 완료 처리 (Finalize)
- **로드맵 업데이트:** `docs/to-do-list.md` 내 해당 항목 `[x]` 표시
- **Git 커밋 제안:** `test: Step 1-1 크론탭 알림 시스템 구축 실습 완료`
