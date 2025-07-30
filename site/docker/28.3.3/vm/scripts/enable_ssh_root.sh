#!/bin/bash
# enable_ssh_root.sh – Enables root SSH access on Debian

set -e

echo "[+] Enabling root SSH access..."
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart ssh

echo "[✓] SSH access for root is now enabled."
