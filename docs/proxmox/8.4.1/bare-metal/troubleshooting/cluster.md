# Cluster Troubleshooting

---

## Issue: Node Already Part of a Cluster

If a node was previously part of another cluster or initialized incorrectly, reset it:

```bash
systemctl stop corosync pve-cluster
rm -rf /etc/corosync/* /var/lib/pve-cluster/*
systemctl start pve-cluster
pvecm add 10.10.0.11
```

---

## Issue: Corosync “Token has not been received” Errors

- Verify VLAN 30 (cluster network) is reachable from all nodes:

```bash
ping 10.30.0.x
```

- Ensure the MTU is consistent across interfaces (e.g., all at `1500` or `9000`):

```bash
ip link set dev <interface> mtu 1500
```

Replace `<interface>` with the correct NIC (e.g., `vmbr1` or `eth1`).

---

## Issue: Host Key Verification Failed When Opening Console

This happens if certificates are mismatched. Run the following on each node:

```bash
pvecm updatecerts --force
systemctl restart pveproxy pvedaemon
```

This regenerates and synchronizes the cluster certificates.
