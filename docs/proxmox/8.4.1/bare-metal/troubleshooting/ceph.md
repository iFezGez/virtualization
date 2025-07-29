# Ceph Troubleshooting

| Symptom                                      | Fix |
|----------------------------------------------|-----|
| `401 Unauthorized` when installing Ceph      | Use the no-subscription repo:<br>`echo 'deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription' > /etc/apt/sources.list.d/ceph.list` |
| `device is already in use` during OSD create | Run:<br>`ceph-volume lvm list`<br>Then remove with:<br>`sgdisk --zap-all /dev/sdX && wipefs -a /dev/sdX` |
| `too many PGs per OSD` warning               | Reduce PGs or use:<br>`ceph config set global mon_max_pg_per_osd 500` |
| CephFS mount fails at boot                   | Clean entry from `storage.cfg` or:<br>`systemctl mask mnt-pve-ceph-fs.mount` |

Always finish with:

```bash
ceph -s
```

Target: **HEALTH_OK**
