#!/bin/bash
# enable_ip_forwarding.sh

echo "[+] Enabling IP forwarding..."
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

echo "[✓] IP forwarding enabled."
