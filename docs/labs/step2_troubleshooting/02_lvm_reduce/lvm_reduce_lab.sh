#!/bin/bash

# LVM Reduce Lab Script

# Define variables
VG_NAME="myVG"
LV_NAME="myLV"
MOUNT_POINT="/mnt/lvm_data"
TARGET_SIZE="500M"

echo "Starting LVM reduction process for $VG_NAME/$LV_NAME to $TARGET_SIZE..."

# 1. Unmount the volume
echo "Unmounting $MOUNT_POINT..."
sudo umount $MOUNT_POINT

# 2. Filesystem check
echo "Checking filesystem integrity..."
sudo e2fsck -f /dev/$VG_NAME/$LV_NAME

# 3. Shrink the filesystem
echo "Shrinking filesystem to $TARGET_SIZE..."
sudo resize2fs /dev/$VG_NAME/$LV_NAME $TARGET_SIZE

# 4. Shrink the Logical Volume
echo "Reducing Logical Volume to $TARGET_SIZE..."
# Use --force to skip confirmation if needed in automated scripts,
# but manual confirmation is safer.
sudo lvreduce -L $TARGET_SIZE /dev/$VG_NAME/$LV_NAME

# 5. Remount and check
echo "Remounting $MOUNT_POINT..."
sudo mount /dev/$VG_NAME/$LV_NAME $MOUNT_POINT

echo "LVM reduction completed."
df -h $MOUNT_POINT
