#!/bin/bash

# User Audit Script
# This script identifies users with login shells or UID 0.

# 1. Identify users with root privileges (UID 0)
echo "--- USERS WITH UID 0 (Root Privileges) ---"
awk -F: '$3 == 0 { print $1 }' /etc/passwd

# 2. Identify users with a valid login shell (excluding system shells)
echo -e "\n--- USERS WITH LOGIN SHELLS ---"
grep -E '/bin/bash|/bin/sh|/bin/zsh' /etc/passwd | awk -F: '{ print $1 " -> " $7 }'

# 3. Identify files with suspicious permissions in /etc
echo -e "\n--- CHECKING SENSITIVE FILE PERMISSIONS ---"
ls -l /etc/passwd /etc/shadow /etc/group /etc/gshadow

# 4. List all members of the 'sudo' group
echo -e "\n--- MEMBERS OF THE SUDO GROUP ---"
grep '^sudo:' /etc/group | cut -d: -f4

echo -e "\nAudit complete."
