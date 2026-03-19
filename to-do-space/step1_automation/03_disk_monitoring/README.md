# Disk Usage Monitoring

This guide explains how to monitor disk usage and set thresholds for alerting.

## Analyzing `df -h`

The `df -h` command displays disk space usage in human-readable format.

To parse it for a specific partition (e.g., the root partition `/`):

```bash
# Get usage percentage for the root partition
df / | grep / | awk '{ print $5 }' | sed 's/%//g'
```

- `df /`: Get disk info for root.
- `grep /`: Match the line containing the mount point.
- `awk '{ print $5 }'`: Extract the 5th column (Usage %).
- `sed 's/%//g'`: Remove the `%` character.

## Setting Thresholds

It's common practice to set a threshold (e.g., 90%) after which a warning is triggered.

```bash
THRESHOLD=90
CURRENT=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

if [ "$CURRENT" -gt "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is over $THRESHOLD%!"
fi
```
