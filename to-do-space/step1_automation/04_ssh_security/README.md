# SSH Hardening Guide

This guide covers essential steps to secure your SSH server on Ubuntu/Debian.

## 1. Change the Default Port

Changing the port from the default `22` helps reduce the noise from automated scripts:

```bash
# In /etc/ssh/sshd_config
Port 2222
```

## 2. Disable Root Login

Allowing `root` to login directly is a security risk. Disable it:

```bash
# In /etc/ssh/sshd_config
PermitRootLogin no
```

## 3. Key-based Authentication Only

Disable password-based authentication once your SSH keys are set up:

```bash
# In /etc/ssh/sshd_config
PasswordAuthentication no
```

## 4. Allow Specific Users Only

Limit who can access the server:

```bash
# In /etc/ssh/sshd_config
AllowUsers kosa myuser
```

## Applying Changes

After modifying `/etc/ssh/sshd_config`, always test the configuration and restart the service:

```bash
# Test config
sudo sshd -t

# Restart SSH service
sudo systemctl restart ssh
```
