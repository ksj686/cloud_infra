#!/bin/bash

# Cron Task Template with Alerting
# This script performs a task and sends an email alert on failure.

LOG_FILE="/var/log/cron_task.log"
ADMIN_EMAIL="admin@example.com"
TASK_NAME="Important Backup Task"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

log_message "Starting $TASK_NAME..."

# --- PERFORM THE TASK HERE ---
# Example: Try to list a directory that might not exist to simulate failure
if ls /non_existent_directory; then
    log_message "SUCCESS: $TASK_NAME completed successfully."
else
    log_message "ERROR: $TASK_NAME failed."

    # Send an alert via mail
    # Note: requires 'mailutils' and a configured MTA (like Postfix or Exim)
    SUBJECT="CRON ALERT: $TASK_NAME FAILED on $(hostname)"
    BODY="The scheduled task '$TASK_NAME' failed at $(date). Please check $LOG_FILE for details."

    echo "$BODY" | mail -s "$SUBJECT" "$ADMIN_EMAIL"

    # Alternatively, you could log to a specific error log or send to a webhook
    exit 1
fi
