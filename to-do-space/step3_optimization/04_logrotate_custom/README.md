# Customizing Logrotate

## Overview
`logrotate` is a system utility that manages the automatic rotation, compression, and removal of log files. This prevents log files from filling up the disk.

### How it works
`logrotate` is usually run daily by `cron.daily`. It looks at configurations in `/etc/logrotate.conf` and `/etc/logrotate.d/`.

## Key Configuration Options
- **daily/weekly/monthly**: How often to rotate.
- **rotate [number]**: How many old log files to keep.
- **compress**: Compress old log files (using gzip).
- **missingok**: Don't throw an error if the log file is missing.
- **notifempty**: Don't rotate the log file if it is empty.
- **postrotate**: Run a script after rotation (e.g., restart a service).

## Practical Usage
1. **Create a config file** for your application in `/etc/logrotate.d/my-app`.
2. **Test the configuration** without actually rotating files: `sudo logrotate -d /etc/logrotate.d/my-app`.
3. **Force rotation** (useful for testing): `sudo logrotate -f /etc/logrotate.d/my-app`.
