#!/bin/bash

# Automatic Backup and Rotation Script
# This script backs up a directory, compresses it, and deletes old backups.

# --- CONFIGURATION ---
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/var/backups/app_backup"
RETENTION_DAYS=7
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_$DATE.tar.gz"
# ---------------------

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Step 1 & 2: Create the backup and check success
echo "Starting backup of $SOURCE_DIR..."
if tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"; then
    echo "Backup completed successfully: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "ERROR: Backup failed."
    exit 1
fi


# Step 3: Remove backups older than $RETENTION_DAYS
echo "Deleting backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "Rotation complete."
