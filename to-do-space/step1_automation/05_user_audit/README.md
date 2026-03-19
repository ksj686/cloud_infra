# User Audit Guide

This guide explains how to audit users and groups on an Ubuntu/Debian system.

## Understanding User Databases

The two main files for managing users and groups are:

1. `/etc/passwd`: Lists all user accounts.
2. `/etc/group`: Lists all user groups.

### Format of `/etc/passwd`

`username:password:UID:GID:comment:home_directory:login_shell`

For example:
`kosa:x:1000:1000:KOSA User:/home/kosa:/bin/bash`

### Audit Points

- **UID 0 Check**: Only `root` should have UID 0. Any other account with UID 0 has full system access.
- **Login Shell Check**: Many system accounts should have `/usr/sbin/nologin` or `/bin/false` as their shell to prevent them from logging in.
- **Dormant Accounts**: Accounts that haven't been used for a long time should be disabled or removed.
- **Permissions**: Sensitive files should have strict permissions:
    - `/etc/passwd` should be 644 (root:root)
    - `/etc/shadow` should be 600 or 640 (root:shadow)
