#!/bin/bash

# Download and register a Debian 12 cloud‑init ready template in Proxmox
#
# This script downloads the official Debian generic cloud image and imports it
# into Proxmox as a VM template.  Adjust TEMPLATE_STORAGE and network settings
# to match your environment.

set -e

TEMPLATE_STORAGE="local"
TEMPLATE_NAME="debian-12-cloudinit"
URL="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"

echo "Downloading Debian 12 cloud image..."
wget -O /var/lib/vz/template/qcow2/${TEMPLATE_NAME}.qcow2 "$URL"

echo "Creating VM template..."
qm create 9000 --name "$TEMPLATE_NAME" --memory 2048 --net0 virtio,bridge=vmbr0
qm importdisk 9000 /var/lib/vz/template/qcow2/${TEMPLATE_NAME}.qcow2 $TEMPLATE_STORAGE
qm set 9000 --scsihw virtio-scsi-pci --scsi0 $TEMPLATE_STORAGE:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --ide2 $TEMPLATE_STORAGE:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm template 9000

echo "Template created successfully as VM ID 9000"