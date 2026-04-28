#!/bin/bash

# Disk Monitoring Script
# This script checks the usage of the root partition and alerts if it exceeds a threshold.

# --- CONFIGURATION ---
THRESHOLD=90
EMAIL="admin@example.com"
PARTITION="/"
# ---------------------

# Get current usage percentage for the specified partition
USAGE=$(df "$PARTITION" | grep "$PARTITION" | awk '{ print $5 }' | head -1 | sed 's/%//g')

echo "Current disk usage for $PARTITION: $USAGE%"

# Check if usage exceeds threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Disk usage on $(hostname) has reached $USAGE%!"

    # Send alert via mail
    # Note: requires 'mailutils' and configured MTA
    MESSAGE="CRITICAL: Disk usage on $(hostname) for partition '$PARTITION' has reached $USAGE% (Threshold: $THRESHOLD%). Please free up space immediately."
    echo "$MESSAGE" | mail -s "DISK ALERT: High Usage on $(hostname)" "$EMAIL"

    # Alternatively, you could log this to a system log
    # logger "Disk usage on $PARTITION is critical: $USAGE%"
fi
