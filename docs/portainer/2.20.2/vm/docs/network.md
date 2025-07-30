# Portainer Network Configuration

## Introduction

This document describes network interfaces and required firewall rules to access Portainer deployed on Docker VMs.

## Quick‑view topology / matrix

| Component        | VLAN / Subnet     | Role             | Notes                              |
|------------------|-------------------|------------------|-------------------------------------|
| ens18 (dock1)    | 10.20.0.20/24     | VM network iface | Direct access to Portainer         |
| ens18 (dock2)    | 10.20.0.21/24     | VM network iface | Secondary instance or HA option    |
| docker0          | 172.17.0.1/16     | Docker bridge    | Default bridge                     |
| Portainer (dock1)| 9443 (HTTPS)      | Web UI           | Exposed via Docker bind            |

## Prerequisites

- Docker installed and functional
- Host firewall open to port `9443`
- SSH or web access to dock1/dock2

## Step 1 – Verify interface

```bash
ip a show ens18
```

Ensure it's assigned and reachable from LAN.

## Step 2 – Allow firewall access

```bash
ufw allow 9443/tcp
```

or via iptables:

```bash
iptables -A INPUT -p tcp --dport 9443 -j ACCEPT
```

## Validation and tests

- Access `https://10.20.0.20:9443` from browser
- Confirm HTTPS prompt and admin setup page
- Run `curl -k https://localhost:9443` locally

## Common Issues

| Symptom           | Cause           | Fix                            |
|------------------|------------------|--------------------------------|
| Page not loading | Port closed      | Check ufw/iptables             |
| Connection reset | Docker not started | Restart Docker service       |

## Next steps

Proceed to [configuration.md](configuration.md) to finalize UI settings and security.
