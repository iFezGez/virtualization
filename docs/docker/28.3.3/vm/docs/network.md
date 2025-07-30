# Docker Network Configuration

## Introduction
This page outlines the default network behavior of Docker and how to configure bridges, external interfaces, and firewall access on Debian 12.11 in a Proxmox VM context.

## Quick‑view topology / matrix

| Component     | VLAN / Subnet     | Role            | Notes                                 |
|---------------|-------------------|------------------|----------------------------------------|
| docker0       | 172.17.0.1/16     | NAT bridge       | Default bridge created by Docker       |
| ens18 (dock1) | 10.20.0.20/24     | VM main iface    | Connected to Proxmox bridge `vmbr0`    |
| ens18 (dock2) | 10.20.0.21/24     | VM main iface    | Same subnet, separate VM               |
| vmbr0 (host)  | 10.20.0.1/24      | Proxmox bridge   | Default gateway for VMs (forwarding)   |

## Prerequisites
- Docker installed and running
- Proxmox VM assigned to bridged NIC
- ufw or iptables available

## Step 1 – View existing Docker networks

```bash
docker network ls
```

Inspect the bridge:

```bash
docker network inspect bridge
```



![Output of `docker network ls`](../assets/docker_network_ls.png)

## Step 2 – Custom bridge network (optional)

```bash
docker network create --driver=bridge --subnet=10.10.0.0/24 --gateway=10.10.0.1 custom-bridge
```


## Step 3 – Firewall forwarding

Ensure traffic is allowed between VM interface and Docker bridge.

Example with ufw:

```bash
ufw allow in on docker0
ufw allow from 192.168.0.0/24 to any port 2375 proto tcp
```

## Validation and tests

- Ping containers from host and vice versa
- Use `tcpdump -i docker0` to trace network

## Common Issues

| Symptom | Cause | Fix |
|--------|--------|-----|
| No internet from container | IP forwarding disabled | Enable with `sysctl net.ipv4.ip_forward=1` |
| Cannot expose ports | Host firewall blocks | Check `ufw` or `iptables -L` |

## Next steps

Explore Docker Compose or Portainer via [features.md](features.md).
