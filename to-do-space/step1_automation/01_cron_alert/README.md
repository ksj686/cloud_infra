# Cron Alert System

This guide explains how to log cron results and send alerts in an Ubuntu/Debian environment.

## Logging Cron Results

To log the output of a cron job, you can redirect stdout and stderr to a log file:

```bash
* * * * * /path/to/script.sh >> /var/log/cron_tasks.log 2>&1
```

- `>>`: Appends stdout to the log file.
- `2>&1`: Redirects stderr to stdout, so both are captured in the log.

## Sending Alerts

You can send alerts using the `mail` command (part of `mailutils`).

```bash
# Install mailutils if not present
sudo apt update && sudo apt install -y mailutils

# Send an alert
echo "Task failed on $(hostname)" | mail -s "CRON ALERT: Task Failure" admin@example.com
```

## Implementation

The `cron_task.sh` script provides a template for:
1. Performing a task.
2. Logging the result with timestamps.
3. Sending an alert if the task fails.
