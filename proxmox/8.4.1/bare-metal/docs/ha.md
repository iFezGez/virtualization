# High Availability (HA) Setup in Proxmox VE

This guide explains how to configure HA in a 3-node Proxmox cluster to ensure critical VMs are automatically restarted on other nodes in case of failure.

---

## Requirements

- A Proxmox VE cluster with at least **3 nodes**.
- Shared or distributed storage (e.g., Ceph RBD or CephFS).
- Correct time synchronization across all nodes (`timedatectl`).
- Fencing or watchdog device recommended for production.

---

## Step 1: Check Cluster Status

Ensure all nodes are online and the cluster is quorate:

```bash
pvecm status
```

Expected output should include `Quorate: Yes`.

![Proxmox Ha Status](//proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-ha-status.png)

---

## Step 2: Enable HA Manager

Check the HA manager service:

```bash
systemctl status pve-ha-lrm
systemctl status pve-ha-crm
```

If not running, enable them:

```bash
systemctl enable --now pve-ha-lrm
systemctl enable --now pve-ha-crm
```

---

## Step 3: Mark VMs as HA-Managed

Use the web GUI or CLI to add a VM to HA:

```bash
ha-manager add vm:100
```

Replace `100` with the ID of your critical VM.

To list HA-managed services:

```bash
ha-manager status
```

---

## Step 4: Simulate Node Failure

You can test HA by rebooting a node or stopping `pve-cluster`:

```bash
systemctl stop pve-cluster
```

Check if the HA service automatically starts the VM on another node.

---

## Notes

- HA requires shared storage to allow VMs to be moved or restarted on another node.
- Ceph RBD is ideal for HA setups.
- Always test HA scenarios before going into production.



