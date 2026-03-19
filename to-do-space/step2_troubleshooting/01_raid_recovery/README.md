# RAID 1 Recovery Tutorial

This tutorial explains how to simulate a disk failure in a RAID 1 (Mirroring) array and recover it using `mdadm`.

## Prerequisites
- A functional RAID 1 array (e.g., `/dev/md0`).
- A spare disk or partition to replace the failed one.

## Step-by-Step Guide

### 1. Simulate Disk Failure
To mark a disk as failed in the array:
```bash
sudo mdadm --fail /dev/md0 /dev/sdc1
```

### 2. Verify Failure Status
Check the status of the RAID array to see the failed disk:
```bash
cat /proc/mdstat
# or
sudo mdadm --detail /dev/md0
```
You should see `(F)` next to the failed device.

### 3. Remove the Failed Disk
Remove the failed device from the array:
```bash
sudo mdadm --remove /dev/md0 /dev/sdc1
```

### 4. Add a New Disk
Add the replacement disk to the array:
```bash
sudo mdadm --add /dev/md0 /dev/sdd1
```

### 5. Monitor Rebuilding Process
The RAID array will start rebuilding (resyncing) automatically. Monitor the progress:
```bash
watch -n 1 cat /proc/mdstat
```
Wait until the progress bar reaches 100%.

### 6. Final Confirmation
Ensure the array is healthy and all devices are active:
```bash
sudo mdadm --detail /dev/md0
```

---
*Note: Always ensure you have backups before performing RAID operations.*
