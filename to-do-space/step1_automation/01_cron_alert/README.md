# 크론(Cron) 알림 시스템

**목표:** Ubuntu/Debian 환경 크론 작업 결과 기록 및 알림 자동화

## 크론 결과 로깅
- 표준 출력(stdout) 및 표준 에러(stderr) 리다이렉션 기반 로그 기록
- 설정 예시: `* * * * * /path/to/script.sh >> /var/log/cron_tasks.log 2>&1`
    - `>>`: 표준 출력 로그 파일 추가(append)
    - `2>&1`: 표준 에러를 표준 출력으로 리다이렉션하여 통합 기록

## 알림 전송
- `mail` 명령(`mailutils` 패키지) 활용 알림 발송
- 설치 및 실행:
    - `sudo apt update && sudo apt install -y mailutils`: 패키지 설치
    - `echo "메시지" | mail -s "제목" admin@example.com`: 알림 전송

## 구현 사항 (`cron_task.sh`)
1. 작업 수행 및 결과 기록
2. 타임스탬프 기반 로깅
3. 작업 실패 시 알림 전송 로직 포함
