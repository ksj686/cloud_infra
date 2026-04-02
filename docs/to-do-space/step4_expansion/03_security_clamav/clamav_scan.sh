#!/bin/bash
# ==============================================================================
# Script Name: security_scan_wrapper.sh (Advanced Security Interface)
# Description: 추상화된 보안 스캔 인터페이스 (탐지, 격리, 알림 통합)
# Engine: ClamAV (상시 교체 가능하도록 설계)
# Author: Gemini CLI
# ==============================================================================

# --- [1] 환경 설정 (Configuration) ---
SCAN_TARGET="/home"
QUARANTINE_PATH="/var/quarantine"
LOG_PATH="/var/log/security/scan_$(date +%Y%m%d).log"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/REPLACE_WITH_YOUR_URL"

# --- [2] 보조 함수 (Helper Functions) ---
log_event() {
    local level=$1
    local msg=$2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $msg" >> "$LOG_PATH"
}

send_alert() {
    local msg=$1
    if [[ "$SLACK_WEBHOOK_URL" != *"REPLACE"* ]]; then
        curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"🚨 *보안 위협 탐지 알림*\n$msg\"}" \
        "$SLACK_WEBHOOK_URL" > /dev/null 2>&1
    fi
}

# --- [3] 스캔 엔진 실행 (Security Engine Execution) ---
# 추후 타 솔루션 도입 시 이 섹션의 명령어만 교체하여 추상화 유지
run_security_scan() {
    log_event "INFO" "보안 스캔 시작 (Target: $SCAN_TARGET)"
    
    # ClamAV 기반 스캔 및 자동 격리 (--move)
    # --move 옵션을 통해 위협 요소를 QUARANTINE_PATH로 즉시 분리
    clamscan -r --move="$QUARANTINE_PATH" "$SCAN_TARGET" >> "$LOG_PATH" 2>&1
    
    return $?
}

# --- [4] 결과 처리 및 사후 대응 (Post-Processing) ---
mkdir -p "$QUARANTINE_PATH" "$(dirname "$LOG_PATH")"

run_security_scan
SCAN_RESULT=$?

# ClamAV Exit Codes: 0=Clean, 1=Virus Found, 2=Error
if [ $SCAN_RESULT -eq 0 ]; then
    log_event "INFO" "보안 위협 미검출 (Clean)"
elif [ $SCAN_RESULT -eq 1 ]; then
    DETECTED_COUNT=$(grep "Infected files:" "$LOG_PATH" | tail -1 | awk '{print $3}')
    ALERT_MSG="[위험] 서버 내 보안 위협 탐지 및 격리 완료 (탐지 수: $DETECTED_COUNT). 로그 파일($LOG_PATH)을 확인하시오."
    
    log_event "WARN" "$ALERT_MSG"
    send_alert "$ALERT_MSG"
else
    ERROR_MSG="[오류] 보안 스캔 엔진 실행 중 문제 발생 (Exit Code: $SCAN_RESULT)."
    log_event "ERROR" "$ERROR_MSG"
    send_alert "$ERROR_MSG"
fi

log_event "INFO" "보안 스캔 종료"
echo "----------------------------------------" >> "$LOG_PATH"
