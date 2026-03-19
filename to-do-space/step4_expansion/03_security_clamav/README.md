# Automating Security with ClamAV

## What is ClamAV?
ClamAV is an open-source antivirus engine for detecting trojans, viruses, malware & other malicious threats.

### Key Components
- **clamd**: The background daemon for faster scanning.
- **clamscan**: The command-line scanner.
- **freshclam**: The utility for updating virus definitions.

## Automating Security Scans
1. **Regular updates**: Run `freshclam` daily via `cron`.
2. **Scheduled scans**: Scan critical directories (like `/home` and `/var/www`) using a shell script.
3. **Automated Reporting**: Log scan results and send alerts if threats are found.

## Common Commands
- **Update virus database**: `sudo freshclam`
- **Scan a directory**: `clamscan -r /home`
- **Scan and move infected files**: `clamscan -r --move=/quarantine /home`
