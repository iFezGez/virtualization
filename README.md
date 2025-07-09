# Virtualization Repo

This repository contains reference implementations of hypervisor & container platforms for Vesta Lab.  
Each service lives inside **`<service>/<version>/<install_type>/`** so multiple versions can coexist.

| Service | Version | Install type | Docs entry |
|---------|---------|--------------|------------|
| **Proxmox VE** | 8.4.1 | bare‑metal | [`proxmox/8.4.1/bare-metal/docs/`](proxmox/8.4.1/bare-metal/docs)
/docs/) |
| VMware ESXi | *TBD* | bare‑metal | _placeholder_ |
| Docker / Portainer | *TBD* | VM | _placeholder_ |

## Structure
```
virtualization/
├── proxmox/8.4.1/bare-metal/
│   ├─ assets/
│   ├─ docs/
│   ├─ exports/
│   ├─ scripts/
│   └─ templates/
├── vmware/
├── docker/
├─ mkdocs.yml
└─ LICENSE
```
## Live Documentation

The entire lab is published online with MkDocs:  
- [https://ifezgez.github.io/virtualization/](https://ifezgez.github.io/virtualization/)

## Maintainer

**Ignacio Fernandez**  
CEO @ Vesta Security LATAM  
[https://vestasec.com](https://vestasec.com)

---

Built as a real production-ready lab to demonstrate expertise in:
- Proxmox VE - Clusters - Ceph
- VMware ESXi
- Docker - Docker Compose - Portainer
- KVM 
---

This repository is public and reusable as a technical reference for clients and collaborators.
