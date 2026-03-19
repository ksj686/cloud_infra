#!/bin/bash
# Simple symlink update script for zero-downtime swaps

APP_LINK="/opt/my-app"
NEW_VERSION_DIR=$1 # e.g., /opt/app-v2.0.0

if [ -z "$NEW_VERSION_DIR" ]; then
    echo "Usage: $0 <new_version_directory>"
    exit 1
fi

if [ ! -d "$NEW_VERSION_DIR" ]; then
    echo "Error: Directory '$NEW_VERSION_DIR' does not exist."
    exit 1
fi

echo "Updating symlink '$APP_LINK' to point to '$NEW_VERSION_DIR'..."
ln -sfn "$NEW_VERSION_DIR" "$APP_LINK"

if [ $? -eq 0 ]; then
    echo "Symlink updated successfully."
    ls -l "$APP_LINK"
else
    echo "Failed to update symlink."
    exit 1
fi
