#!/bin/bash

# ==============================================================================
# Script Name: daily_report.sh
# Description: 시스템 내 전체 태스크(Cron, At, Active Processes) 현황 리포트 자동 생성 및 Slack 전송
# Author: Gemini CLI
# ==============================================================================

# Slack Webhook URL (사용자의 환경에 맞게 수정 필요)
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

# 현재 날짜 및 시간
DATE=$(date "+%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)

# 리포트 시작 메시지
REPORT="[ $DATE ] $HOSTNAME 전체 태스크 현황 리포트\n\n"

# 1. 예약된 정기 작업 (Crontab) 수집
REPORT+="### 1. Crontab (정기 예약 작업)\n"
CRON_LIST=$(crontab -l 2>/dev/null)
if [ -z "$CRON_LIST" ]; then
    REPORT+=" - 현재 등록된 Crontab 작업이 없습니다.\n"
else
    REPORT+="$(echo "$CRON_LIST" | sed 's/^/  / ')\n"
fi
REPORT+="\n"

# 2. 1회성 예약 작업 (At Jobs) 수집
REPORT+="### 2. At Jobs (1회성 예약 작업)\n"
AT_LIST=$(atq 2>/dev/null)
if [ -z "$AT_LIST" ]; then
    REPORT+=" - 예약된 At 작업이 없습니다.\n"
else
    REPORT+="$(echo "$AT_LIST" | sed 's/^/  / ')\n"
fi
REPORT+="\n"

# 3. 현재 실행 중인 주요 프로세스 (Active Processes)
# 예: python, backup, nginx 등 주요 키워드로 필터링하여 수집
REPORT+="### 3. 주요 활성 프로세스 (백업, 스크립트 등)\n"
# 현재 실행 중인 스크립트(.sh, .py) 및 백업 관련 프로세스 조회
# grep -v grep은 grep 명령어 자체를 결과에서 제외함
ACTIVE_PROCS=$(ps aux | grep -E ".sh|.py|backup|nginx" | grep -v grep | head -n 10)
if [ -z "$ACTIVE_PROCS" ]; then
    REPORT+=" - 현재 실행 중인 주요 프로세스가 없습니다.\n"
else
    REPORT+="$(echo "$ACTIVE_PROCS" | awk '{print "  PID: "$2", USER: "$1", CMD: "$11" "$12}')\n"
    REPORT+="   (상위 10개 항목만 표시됨)\n"
fi
REPORT+="\n"

# 최종 리포트 출력 (터미널)
echo -e "$REPORT"

# Slack 전송 (Webhook URL이 설정된 경우에만 실행)
if [[ "$SLACK_WEBHOOK_URL" != *"YOUR/WEBHOOK/URL"* ]]; then
    echo "Sending report to Slack..."
    # JSON 형식으로 메시지 구성 (이스케이프 처리 주의)
    # 쉘 변수의 내용을 JSON 문자열로 안전하게 전달하기 위해 공백이나 줄바꿈 처리 필요
    MESSAGE=$(echo -e "$REPORT" | sed 's/\"/\\\"/g')
    curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" \
    "$SLACK_WEBHOOK_URL"
else
    echo "Slack Webhook URL이 설정되지 않았습니다. daily_report.sh 파일을 수정해 주세요."
fi
