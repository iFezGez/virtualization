#!/bin/bash
# install_docker.sh – Installs Docker 28.3.3 on Debian 12.11

set -e

echo "[+] Updating apt..."
apt update && apt upgrade -y

echo "[+] Installing dependencies..."
apt install -y ca-certificates curl gnupg lsb-release

echo "[+] Adding Docker GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "[+] Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[+] Installing Docker 28.3.3..."
apt update
apt install -y docker-ce=5:28.3.3~debian.12~bookworm docker-ce-cli=5:28.3.3~debian.12~bookworm containerd.io docker-buildx-plugin docker-compose-plugin

echo "[+] Enabling Docker..."
systemctl enable docker
systemctl start docker

echo "[✓] Docker installed successfully."
