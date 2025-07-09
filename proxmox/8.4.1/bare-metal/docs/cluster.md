# Proxmox VE 8.4.1 — Cluster Setup

> Ensure that networking and `/etc/hosts` are configured correctly on all nodes before proceeding.

---

## Step 1: Create the Cluster on ve1

Run the following command on **ve1** to initialize the cluster:

```bash
pvecm create vesta-lab --link0 address=10.10.0.11,priority=1
```

This command sets up the cluster named `vesta-lab` and defines the primary communication interface (link0) using the management network.

---

## Step 2: Join ve2 and ve3 to the Cluster

On **ve2** and **ve3**, run:

```bash
pvecm add 10.10.0.11 --nodeid <ID>
```

Replace `<ID>` with a unique node ID (e.g., 2 for ve2, 3 for ve3). Make sure that node IDs are not duplicated.

If you mistakenly created a local cluster on ve2/ve3, reset it before joining:

```bash
systemctl stop corosync pve-cluster
rm -rf /etc/corosync/* /var/lib/pve-cluster/*
systemctl start pve-cluster
```

![Proxmox Cluster Nodes](/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-cluster-nodes.png)


---

## Step 3: Regenerate Certificates (Optional)

After all nodes are joined and accessible, regenerate certificates from **ve1** to ensure consistency:

```bash
pvecm updatecerts --force
systemctl restart pveproxy pvedaemon
```

---

## Step 4: Validate Cluster Status

On any node, run:

```bash
pvecm status
```

Expected output:

```
Quorate: Yes
Nodes: 3
```

You should see a `Quorate: Yes` message indicating that quorum is established. If not, check the time sync (`timedatectl`), hostnames, and firewall settings.

![Proxmox Cluster Status](/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-cluster-status.png)


---

Cluster is now initialized and operational.
