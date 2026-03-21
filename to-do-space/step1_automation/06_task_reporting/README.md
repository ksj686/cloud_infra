# 실무 시나리오: 전체 태스크 현황 리포트 자동화

**목표:** 시스템 실행/예약 작업 현황 종합 리포트 생성 및 외부(Slack) 자동 발송

## 1. 개요
- 정기 실행(`crontab`), 일시 예약(`at`), 주요 프로세스(`ps`) 현황 파악 필수
- 자동화 기반 일일 리포트 발송을 통한 시스템 가시성 확보

## 2. 모니터링 대상
- **예약 작업 (Scheduled Jobs)**
    - Crontab (`crontab -l`): 주기적 반복 작업 리스트 확인
    - At Jobs (`atq`): 특정 시간 1회성 예약 작업 확인
- **현재 실행 프로세스 (Active Processes)**
    - ps (`ps aux`): 시스템 전체 프로세스 확인
    - 핵심 서비스(백업, DB, 웹 서버 등) 위주 `grep` 필터링 수집

## 3. Slack 연동 (Webhook 사용)
- Incoming Webhooks 활용 정보 전송
- `curl` 명령 기반 JSON 데이터 전송 예시:
    - `curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"메시지\"}" [Webhook_URL]`

## 4. 보안 및 운영 이점
- **미인가 작업 탐지**: 관리자 미설정 작업 등록 여부 정기 점검 및 침해 사고 조기 발견
- **리소스 최적화**: 장기 실행 프로세스 및 중복 태스크 파악을 통한 자원 낭비 방지
- **작업 수행 확인**: 필수 작업(백업, 로그 정리 등) 예약 정상 여부 매일 체크

## 5. 실습 스크립트 (`daily_report.sh`)
- Slack Webhook URL 수정 후 실행 및 결과 확인
