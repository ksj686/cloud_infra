#!/bin/bash

# RAID 1 Recovery Commands

# 1. Simulate failure of /dev/sdc1 in RAID array /dev/md0
echo "Simulating disk failure..."
sudo mdadm --fail /dev/md0 /dev/sdc1

# 2. Check RAID status
echo "Checking RAID status after failure..."
cat /proc/mdstat

# 3. Remove the failed disk
echo "Removing failed disk from RAID..."
sudo mdadm --remove /dev/md0 /dev/sdc1

# 4. Add a replacement disk (/dev/sdd1)
echo "Adding replacement disk to RAID..."
sudo mdadm --add /dev/md0 /dev/sdd1

# 5. Monitor rebuilding progress
echo "Monitoring rebuild... (Ctrl+C to stop watching)"
watch -n 1 cat /proc/mdstat

# 6. Verify final RAID status
echo "Verifying RAID health..."
sudo mdadm --detail /dev/md0
