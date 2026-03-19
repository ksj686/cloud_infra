# Automatic Backup and Rotation

This guide explains how to use `tar` and `find` for managing backups on Ubuntu/Debian.

## Backing up with `tar`

The `tar` command is used to create compressed archive files:

```bash
# Create a compressed tarball
tar -czf backup_$(date +%Y%m%d).tar.gz /path/to/source_dir
```

- `-c`: Create a new archive.
- `-z`: Filter through gzip.
- `-f`: Specify the filename.

## Managing Backup Rotation with `find`

To prevent backups from consuming all disk space, old backups should be deleted:

```bash
# Find and delete files older than 7 days
find /path/to/backups/ -type f -name "*.tar.gz" -mtime +7 -delete
```

- `-type f`: Look for files.
- `-name "*.tar.gz"`: Match specific backup files.
- `-mtime +7`: Files modified more than 7 days ago.
- `-delete`: Delete the matched files.

## Automation

Scheduled backups are typically handled by `cron`.
Example crontab entry for daily backup at 2 AM:
`0 2 * * * /path/to/backup.sh`
