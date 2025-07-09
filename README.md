# Virtualization Repo

Reference implementations of hypervisor & container platforms for Vesta Lab.  
Each service lives inside **`<service>/<version>/<install_type>/`** so multiple versions can coexist.

| Service | Version | Install type | Docs entry |
|---------|---------|--------------|------------|
| **Proxmox VE** | 8.4.1 | bare‑metal | [`https://github.com/iFezGez/virtualization/tree/main/docs/proxmox/8.4.1/bare-metal`](proxmox/8.4.1/bare-metal/docs/) |
| VMware ESXi | *TBD* | bare‑metal | _placeholder_ |
| Docker / Portainer | *TBD* | VM | _placeholder_ |

```text
repo-root/
├─ proxmox/8.4.1/bare-metal/
│  ├─ assets/
│  ├─ docs/
│  ├─ exports/
│  ├─ scripts/
│  └─ templates/
├─ vmware/
├─ docker/
├─ mkdocs.yml
└─ LICENSE
```
