# Proxmox VE 8.4.1 – Bare-Metal Cluster

This sub-folder contains the complete, reproducible deployment of a **three-node Proxmox VE 8.4.1 cluster** running directly on bare-metal hardware.  
All pages follow the Vesta Lab documentation template.

| Section | Purpose |
|---------|---------|
| `docs/` | Step-by-step guides (installation, networking, Ceph, HA, troubleshooting) |
| `assets/` | Screenshots & diagrams referenced by the docs |
| `scripts/` | Utility scripts (e.g. create Debian 12 cloud-init template) |
| `templates/` | Cloud-init YAMLs & other config stubs |

## Quick links

- **Installation guide** ➜ [`docs/installation.md`](docs/installation.md)  
- **Networking (VLAN & bridges)** ➜ [`docs/network.md`](docs/network.md)  
- **Cluster setup** ➜ [`docs/cluster.md`](docs/cluster.md)  
- **Ceph storage** ➜ [`docs/ceph.md`](docs/ceph.md)  
- **High Availability** ➜ [`docs/ha.md`](docs/ha.md)  
- **Troubleshooting** ➜  
  - Cluster issues → [`troubleshooting/cluster.md`](troubleshooting/cluster.md)  
  - Ceph OSD recovery → [`troubleshooting/ceph.md`](troubleshooting/ceph.md)
