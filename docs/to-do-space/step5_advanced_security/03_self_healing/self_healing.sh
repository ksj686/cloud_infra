#!/bin/bash

# [Service Health Check & Auto-restart Script]
# 서비스 중단 시 자동으로 재시작하고 로그를 기록함.

SERVICE_NAME="nginx"
LOG_FILE="/var/log/self_healing.log"
RESTART_CMD="sudo systemctl restart $SERVICE_NAME"

# 1. 서비스 상태 확인
if systemctl is-active --quiet $SERVICE_NAME; then
    # 정상 작동 중
    # echo "[$(date)] $SERVICE_NAME is running normally." >> $LOG_FILE
    exit 0
else
    # 서비스 중단 감지
    echo "[$(date)] ALERT: $SERVICE_NAME is down! Attempting to restart..." >> $LOG_FILE
    
    # 2. 서비스 재시작 시도
    $RESTART_CMD
    
    # 3. 재시작 결과 확인 및 알림 (필요 시)
    if systemctl is-active --quiet $SERVICE_NAME; then
        echo "[$(date)] SUCCESS: $SERVICE_NAME has been restarted." >> $LOG_FILE
    else
        echo "[$(date)] ERROR: Failed to restart $SERVICE_NAME. Manual intervention required!" >> $LOG_FILE
    fi
fi
