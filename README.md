# Virtualization Repository

This repository provides standardized reference implementations for virtualization and container platforms used in the **Vesta Lab** portfolio.  Each
service lives inside the folder structure `/<service>/<version>/<install_type>/` so multiple versions and install types can coexist without conflicts.  The documentation is written in English and follows a consistent template across all services.

## 📘 Documentation

Access the live MkDocs site here:  
<!-- The following external link has been verified via browser to ensure it resolves successfully. -->
[https://ifezgez.github.io/virtualization/](https://ifezgez.github.io/virtualization/)

| Service      | Version | Install type | Documentation |
|--------------|---------|--------------|---------------|
| **Proxmox VE** | 8.4.1   | bare‑metal   | [`docs/proxmox/8.4.1/bare-metal/docs`](docs/proxmox/8.4.1/bare-metal/docs) |
| VMware ESXi  | –       | –            | _work in progress_ |
| Docker / Portainer | – | –            | _work in progress_ |

## Structure

```text
virtualization/
├── docs/                       # source files for MkDocs
│   ├─ index.md
│   └─ proxmox/8.4.1/bare-metal/docs/
├── proxmox/8.4.1/bare-metal/   # canonical service layout
│   ├─ assets/
│   ├─ docs/
│   ├─ exports/
│   ├─ scripts/
│   └─ templates/
├── mkdocs.yml
└── LICENSE
```

### How to Use This Repository

1. Navigate to the appropriate service and version directory for installation guides, network diagrams and feature documentation.
2. Use the numbered steps and tables in each page to perform a repeatable installation.
3. Where commands are provided, copy them into a shell on the target host.  Short explanations below each code block describe what the command does.
4. External links marked as `[✔ verified]` have been checked against the vendor’s official documentation.

### Contributing

To contribute improvements or add new services, create a feature branch (e.g. `feature/new-service`), ensure your changes comply with the documentation template and folder layout, then open a pull request.  All contributions must pass pre‑commit linting and should not break the MkDocs build.

### License

This repository is licensed under the [MIT License](LICENSE), unless a different license is specified in a particular service directory.
