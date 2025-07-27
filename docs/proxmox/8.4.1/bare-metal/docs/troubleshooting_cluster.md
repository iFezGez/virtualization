# Proxmox VE 8.4.1 – Cluster Troubleshooting

This page collects common issues encountered when forming or operating a Proxmox cluster, along with recommended fixes.  Work through the symptoms below to diagnose problems before posting to the forums.

| Symptom | Cause | Fix |
|--------|-------|-----|
| **Node is already part of another cluster** | The node was previously initialized or joined to a different cluster.  Corosync and cluster metadata remain on disk. | Stop the cluster services, remove the Corosync and PVE cluster configuration, then restart:
`systemctl stop corosync pve-cluster`
`rm -rf /etc/corosync/* /var/lib/pve-cluster/*`
`systemctl start pve-cluster`
After cleaning, run `pvecm add <ve1-ip>` to join the correct cluster. |
| **Corosync log shows “Token has not been received”** | Packet loss on the cluster network or mismatched MTU settings prevents nodes from exchanging heartbeats. | Verify that VLAN 30 is reachable from all nodes (e.g. `ping 10.30.0.3`).  Ensure jumbo frames are consistent across interfaces; set the MTU to 1500 or 9000 on both the NIC and switch:
`ip link set dev vmbr0 mtu 1500` |
| **Host key verification failed when opening console** | SSL certificates across nodes are out of sync, often after rebuilding a node or restoring from backup. | Regenerate cluster certificates from ve1 and restart services:
`pvecm updatecerts --force`
`systemctl restart pveproxy pvedaemon` |

## Usage notes

- Always check `pvecm status` and `/var/log/syslog` for additional clues when troubleshooting cluster issues.
- When resetting a node, ensure that the node ID you assign is not already in use in the cluster.

Return to [Cluster Setup](cluster.md) once issues have been resolved.