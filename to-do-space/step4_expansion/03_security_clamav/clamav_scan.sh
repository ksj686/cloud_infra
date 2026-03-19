#!/bin/bash
# Script for automated security scans using ClamAV

SCAN_DIR="/home"
QUARANTINE_DIR="/var/quarantine"
LOG_FILE="/var/log/clamav/scan_report.log"

# Create directories if they don't exist
mkdir -p "$QUARANTINE_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

echo "Starting ClamAV scan at $(date)..." >> "$LOG_FILE"

# Run the scan and log results
clamscan -r --move="$QUARANTINE_DIR" "$SCAN_DIR" >> "$LOG_FILE"

# Check the exit status
if [ $? -eq 0 ]; then
    echo "No threats found." >> "$LOG_FILE"
else
    echo "Scan complete. Threats found and moved to $QUARANTINE_DIR." >> "$LOG_FILE"
fi

echo "Scan finished at $(date)." >> "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"
