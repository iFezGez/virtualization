# Installing the Proxmox Nodes

| Node | mgmt (VLAN 10) | storage/cluster (VLAN 30) | Hardware (example)             |
|------|----------------|---------------------------|--------------------------------|
| ve1  | 10.10.0.11     | 10.30.0.2                 | NVMe 250 GB + NVMe 480 GB      |
| ve2  | 10.10.0.12     | 10.30.0.3                 | SATA 240 GB + SSD 120 GB       |
| ve3  | 10.10.0.13     | 10.30.0.4                 | NVMe 500 GB + HDD 1 TB         |

> VLAN 20 (services) and VLAN 40 (backups) exist but are not required during installation.

---

## Step 1: Install Proxmox VE 8

- Download the latest Proxmox VE ISO from the [official site](https://www.proxmox.com/en/downloads).
- Boot each host using the ISO.
- Choose **ZFS (single disk)** for lab setups or **ext4/LVM-thin** depending on your goals.
- Assign the **management IP** (VLAN 10) during the installer process.

## Step 2: Update and Configure APT Repositories

After the first boot, run:

```bash
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-no-sub.list
apt update && apt full-upgrade -y
```

Disable the enterprise repository if it's present:

```bash
sed -i 's/^deb/#deb/' /etc/apt/sources.list.d/pve-enterprise.list
```

## Step 3: Set Time Sync (NTP)

Ensure all nodes have time synchronized:

```bash
timedatectl set-ntp true
```

## Step 4: Configure Hosts File

Edit `/etc/hosts` on all nodes to include:

```bash
10.10.0.11 ve1.vestasec.com ve1
10.10.0.12 ve2.vestasec.com ve2
10.10.0.13 ve3.vestasec.com ve3
```

## Step 5: Reboot the Node

Once all settings are applied, reboot each node:

```bash
reboot
```

After reboot, verify connectivity using `ping` and ensure DNS resolution between nodes is working correctly.
