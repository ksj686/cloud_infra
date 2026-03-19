# Netplan and Firewall (UFW/Iptables) Configuration

## Netplan Overview
Netplan is the default network configuration tool for modern Ubuntu systems. It uses YAML files located in `/etc/netplan/`.

### Common Commands
- **Apply configuration**: `sudo netplan apply`
- **Try configuration (with auto-revert if it fails)**: `sudo netplan try`

### Sample Configuration
Refer to `netplan_config_sample.yaml` for a static IP configuration example.

## Firewall Management with UFW
UFW (Uncomplicated Firewall) is a user-friendly interface for managing `iptables`.

### Basic Usage
1. **Enable UFW**: `sudo ufw enable`
2. **Allow a service (e.g., SSH)**: `sudo ufw allow 22/tcp` or `sudo ufw allow ssh`
3. **Deny a specific subnet**: `sudo ufw deny from 192.168.1.0/24`
4. **Port Forwarding**: This is typically handled by modifying `/etc/default/ufw` and `/etc/ufw/before.rules`.

### Iptables for Complex Rules
For advanced users, `iptables` provides direct control over network packets.
- **List rules**: `sudo iptables -L -n -v`
- **Block an IP**: `sudo iptables -A INPUT -s 1.2.3.4 -j DROP`
