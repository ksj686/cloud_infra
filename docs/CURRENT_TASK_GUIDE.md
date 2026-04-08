# Current Task Guide: 실무 실습 및 MkDocs 고도화

본 문서는 `to-do-list.md`의 첫 번째 실습인 'Step 1-1: 크론탭 실행 결과 알림 시스템 구축'을 위한 초정밀 단계별 실행 매뉴얼과 완료된 인프라 고도화 작업 현황을 관리함.

---

## 📅 [진행 중] Step 1-1: 크론탭 알림 시스템 구축 (2026-04-06)

- **상태:** 🏗️ 진행 중
- **목표:** 주기적 작업의 성공/실패 여부를 로그에 남기고, 실패 시 관리자에게 알림을 보내는 체계 구축
- **가이드 위치:** `docs/to-do-space/step1_automation/01_cron_alert/README.md`
- **핵심 소스:** `docs/to-do-space/step1_automation/01_cron_alert/cron_task.sh`

### 🏗️ 1단계: 실습 환경 및 가이드 확인

실무 시나리오 파악 및 패키지 설치를 통한 환경 준비

- **핵심 패키지 설치:**
  ```bash
  sudo apt update && sudo apt install -y mailutils
  ```

### 🚀 2단계: 실습 수행 절차 (Execution)

스크립트 분석, 권한 부여 및 시스템 스케줄러 등록

- **스크립트 권한 부여 및 수동 테스트:**
  ```bash
  chmod +x docs/to-do-space/step1_automation/01_cron_alert/cron_task.sh
  ./docs/to-do-space/step1_automation/01_cron_alert/cron_task.sh
  ```
- **스크립트 체크리스트:**
  - `LOG_FILE` 경로 확인 (`/var/log/cron_tasks.log` 등 권한 확인)
  - `ADMIN_EMAIL` 변수를 본인 테스트용 이메일 주소로 수정
- **크론탭(Crontab) 등록:**
  - 명령어: `crontab -e`
  - 아래 내용 추가 (매 분마다 실행 예시):
  ```bash
  * * * * * /절대경로/to/cron_task.sh >> /var/log/cron_tasks.log 2>&1
  ```

### 🔍 3단계: 결과 검증 (Validation)

작업 결과의 기록성 및 알림 시스템의 정상 동작 확인

1. **로그 확인:** `/var/log/cron_tasks.log` 파일에 타임스탬프와 함께 성공 메시지가 기록되는지 확인
2. **실패 시뮬레이션:** 스크립트 내 명령어를 의도적으로 틀리게 수정 후 알림(Mail 등)이 오는지 확인
3. **웹 포털 연동:** 실습 결과 리포트를 작성하여 웹 사이트에 업데이트

### 🌿 4단계: 실습 완료 처리 (Finalize)

로드맵 동기화 및 형상 관리 기록

- **로드맵 업데이트:** `docs/to-do-list.md` 내 해당 항목 `[ ]` -> `[x]` 표시
- **Git 커밋 제안:** `test: Step 1-1 크론탭 알림 시스템 구축 실습 완료`

---

## ✅ [완료] MkDocs 포털 고도화 및 UI 개선

- **핵심 성과:** Material 테마 최신 기능 적용 및 메인 페이지 그리드 UI 도입 완료

### 수행 결과 요약

1.  **UI/UX 강화:** `navigation.footer`, `content.code.annotate`, `content.tabs.link` 등 최신 기능 활성화.
2.  **메인 시각화:** `index.md` 내 인프라 구축 단계를 카드 그리드 UI로 재구성.
3.  **오류 수정:** 앵커 링크(#phase-n) 불일치 및 아이콘 렌더링 깨짐 문제 해결.

### 🔍 확인 포인트 (Checklist)

- [x] 메인 페이지 Phase별 카드 그리드 UI 정상 노출
- [x] 문서 하단 이전/다음 페이지 네비게이션 동작
- [x] `project_outline.md`로의 앵커 링크 연결 정상화
- [x] 모든 변경 사항 `CHANGELOG.md` 및 `ENVIRONMENT_SETUP.md` 기록 완료
