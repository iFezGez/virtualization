# Proxmox VE 8.4.1 — Ceph Storage

> All commands can be issued from **any** node. Replace device names as needed.

---

## Step 1: Install Ceph on Every Node

Install the Ceph packages using the no-subscription repository:

```bash
pveceph install --repository no-subscription
```

---

## Step 2: Initialize the Ceph Cluster

Run once on one node (e.g., ve1):

```bash
pveceph init --network 10.30.0.0/24
```

Then create the Monitor and Manager daemons on each node:

```bash
pveceph mon create
pveceph mgr create
```

![Proxmox Ceph Status](/docs/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-ceph-status.png)

---

## Step 3: Create OSDs

Prepare and assign disks on each node.

| Node | Disk         | Class |
|------|--------------|-------|
| ve1  | /dev/sda     | ssd   |
| ve2  | /dev/vme0n1  | ssd   |
| ve3  | /dev/sda     | hdd   |

For each disk:

```bash
sgdisk --zap-all /dev/sda
wipefs -a /dev/sda
pveceph osd create /dev/sda --crush-device-class ssd
```

Repeat for each disk across all nodes, changing the device accordingly.

![Proxmox Ceph Osds](/docs/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-ceph-osds.png)

---

## Step 4: Create Pools

Create different pools for VM storage and backups:

```bash
pveceph pool create ceph-pool --application rbd
ceph osd pool set ceph-pool size 2
```

![Proxmox Ceph Pools](/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-ceph-pools.png)

---

## Step 5: Add CephFS for ISO and Templates

Create a CephFS volume and add it to Proxmox storage:

```bash
pveceph fs create cephfs --data-pool cephfs_data --metadata-pool cephfs_metadata
```

Then add it to Proxmox using:

```bash
pvesm add ceph-fs cephfs-store   --monhost 10.30.0.2 10.30.0.3 10.30.0.4   --content iso,vztmpl,backup   --mountpoint /mnt/pve/ceph-fs
```

![Proxmox Cephfs Storage](/docs/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-cephfs-storage.png)

---

## Step 6: Validate the Setup

Check the Ceph cluster health:

```bash
ceph -s
pvesm status
```

You should see `HEALTH_OK` and the `cephfs-store` mounted correctly.

---

Ceph is now configured and integrated with Proxmox VE.






