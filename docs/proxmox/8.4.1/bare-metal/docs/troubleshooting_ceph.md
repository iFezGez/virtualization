# Proxmox VE 8.4.1 – Ceph Troubleshooting

Ceph is robust but occasionally returns warnings or errors during installation and operation.  Use the table below to diagnose common issues.

| Symptom | Cause | Fix |
|--------|-------|-----|
| **`401 Unauthorized` when installing Ceph** | The Ceph packages are pulled from the Proxmox enterprise repository, which requires a subscription. | Configure the no‑subscription Ceph repository:
`echo 'deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription' > /etc/apt/sources.list.d/ceph.list`
Then run `apt update` and repeat the installation. |
| **`device is already in use` during OSD creation** | The target disk contains existing partitions or Ceph metadata from previous setups. | List existing logical volumes with `ceph-volume lvm list`.  Remove all signatures, then recreate the OSD:
`sgdisk --zap-all /dev/sdX && wipefs -a /dev/sdX`
Replace `/dev/sdX` with the appropriate device. |
| **“too many PGs per OSD” warning** | The pool has more placement groups (PGs) than recommended for the number of OSDs, leading to over‑utilisation. | Reduce the number of PGs when creating pools or set a higher limit:
`ceph osd pool set <pool> pg_num <value>`
`ceph config set global mon_max_pg_per_osd 500` |
| **CephFS mount fails at boot** | The CephFS entry in `storage.cfg` or systemd mount unit is stale. | Remove the problematic entry from `/etc/pve/storage.cfg` or mask the mount unit:
`systemctl mask mnt-pve-ceph-fs.mount` |

## Validation

After applying a fix, always check the overall cluster health:

```bash
ceph -s
```

The output should indicate `HEALTH_OK`.  For pool‑related warnings, also run `ceph osd df tree` to inspect OSD utilisation.

## Additional resources

The [Proxmox Ceph documentation](https://pve.proxmox.com/pve-docs/chapter-pveceph.html) contains detailed explanations of Ceph components and advanced tuning.  Refer to [Ceph Storage](ceph.md) for installation and configuration steps.