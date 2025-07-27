# Proxmox VE 8.4.1 – Bare‑Metal Installation

## Quick‑view topology / matrix

| Component | VLAN / Subnet       | Role               | Notes |
|-----------|---------------------|--------------------|-------|
| **ve1**   | mgmt 10.10.0.11/24  | Proxmox node 1     | NVMe 250 GB + NVMe 480 GB |
| **ve2**   | mgmt 10.10.0.12/24  | Proxmox node 2     | SATA 240 GB + SSD 120 GB  |
| **ve3**   | mgmt 10.10.0.13/24  | Proxmox node 3     | NVMe 500 GB + HDD 1 TB    |

> The cluster network (VLAN 30) and additional service VLANs (e.g. 20 and 40) will be configured later.  IPs shown here are examples; adjust them according to your environment.

## Prerequisites

- **Hardware** – Three x86‑64 hosts with at least **2 CPU cores** and **8 GB of RAM** each.  Each node should provide two storage devices: one for the OS and one for Ceph/VM data.
- **Network** – Management VLAN (`10.10.0.0/24`) available on all nodes.  The switch ports should be configured as trunk ports to carry all required VLANs.
- **Software** – Download the **Proxmox VE 8.4.1 ISO** from the official download page [✔ verified https://www.virtualizationhowto.com/2025/04/proxmox-ve-8-4-released-new-features-and-download/#proxmox-ve-8-4-download].  Prepare a bootable USB drive using tools such as Balena Etcher.
- **Access** – Console or IPMI access to each node, and credentials for DNS/IP planning.

## Step 1 – Install Proxmox VE 8.4.1

1. **Boot from the ISO** on each host and choose *Install Proxmox VE*.
2. When prompted for the target disk, select a local disk.  For lab deployments a **ZFS (single disk)** layout works well; for production you may choose **ext4** or **LVM‑thin**.
3. Assign the **management IP address** (VLAN 10) and a hostname for each node (e.g. `ve1.vestasec.com`).
4. Set a strong root password and complete the installation wizard.

## Step 2 – Configure the APT Repositories

After the first boot, switch to the free repository and apply all updates.  Proxmox points to the enterprise repository by default; editing the sources avoids subscription warnings:

```bash
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-no-sub.list
apt update && apt full-upgrade -y
```

This configuration uses the *pve‑no‑subscription* repository so you can receive updates without a subscription [✔ verified https://www.virtualizationhowto.com/2022/08/proxmox-update-no-subscription-repository-configuration/#proxmox-8-and-higher].  If `/etc/apt/sources.list.d/pve-enterprise.list` exists, comment its single `deb` line to disable the enterprise repository:

```bash
sed -i 's/^deb/#deb/' /etc/apt/sources.list.d/pve-enterprise.list
```

## Step 3 – Enable Time Synchronisation

Consistent time is essential for clustering and Ceph.  Enable NTP on all nodes:

```bash
timedatectl set-ntp true
```

Verify the current time with `timedatectl status` and ensure all hosts show *NTP synchronized: yes*.

## Step 4 – Configure the Hosts File

Add all nodes to `/etc/hosts` on **every** server so that cluster services can resolve peer names:

```bash
10.10.0.11 ve1.vestasec.com ve1
10.10.0.12 ve2.vestasec.com ve2
10.10.0.13 ve3.vestasec.com ve3
```

After saving the file, verify name resolution with `ping ve2` and `ping ve3` from each node.

## Step 5 – Reboot and Validate

Reboot each node to apply kernel updates and network changes:

```bash
reboot
```

When all nodes are back online, log in to the web interface at `https://<node_ip>:8006/` and verify that you can authenticate as `root@pam`.  Use `ping` to confirm connectivity between nodes.

## Validation & Smoke Tests

- **Network Reachability** – Each node should respond to pings from the others on the management network.
- **Package Updates** – `apt update` should succeed without subscription warnings.
- **Web UI** – Access the Proxmox GUI on each node and confirm the dashboard loads.

## Troubleshooting

If a node cannot join the cluster or shows stale certificates later, refer to the *Cluster Troubleshooting* page for reset procedures.

## Next steps / Links

Proceed to the [Networking guide](network.md) to configure VLAN‑aware bridges, or jump directly to [Cluster Setup](cluster.md) once networking is complete.

For release notes and additional documentation, consult the official Proxmox documentation [✔ verified https://www.proxmox.com/en/downloads].