# Proxmox VE 8.4.1 — Network and VLAN Configuration

This guide documents how to configure bridge interfaces and VLANs in Proxmox VE for clustered and virtualized environments.

## VLAN Architecture

| VLAN ID | Name      | Purpose                  | CIDR           |
|---------|-----------|--------------------------|----------------|
| 10      | mgmt      | Management and Web GUI   | 10.10.0.0/24   |
| 20      | services  | Container/VM services    | 10.20.0.0/24   |
| 30      | cluster   | Ceph / Corosync traffic  | 10.30.0.0/24   |
| 40      | iot       | IoT devices (optional)   | 10.40.0.0/24   |
| 50      | guest     | Guest access VLAN        | 10.50.0.0/24   |

## vmbr0 - Main VLAN-aware Bridge

In `/etc/network/interfaces`:

```bash
auto lo
iface lo inet loopback

auto eno1
iface eno1 inet manual

auto vmbr0
iface vmbr0 inet manual
        bridge-ports eno1
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-4094
```

![Proxmox Ve1 Network Interfaces](/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-ve1-network-interfaces.png)

## VLAN-tagged Subinterfaces 

> Replace `10.30.0.11` with the node-specific management IP (e.g., ve1: `.11`, ve2: `.12`).

```bash
auto vmbr0.10
iface vmbr0.10 inet static
        address 10.30.0.11/24
        gateway 10.30.0.1
        dns-servers 10.0.0.102 1.1.1.1
        vlan-raw-device vmbr0
```

![Proxmox Ve1 Network Vmbr0](/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-ve1-network-vmbr0.png)

## Notes

- `bridge-vlan-aware yes` is preferred for modern setups.
- Ensure all trunk ports on the physical switch pass the required VLANs.
- For Ceph and Corosync, use VLAN 30 with MTU 1500 or 9000 (depending on hardware).
- Verify connectivity with `ping` and `ip link`.


## Screenshots

![Proxmox Network Vlan Tags](/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-network-vlan-tags.png)

![Proxmox Network Vlan Ping](/proxmox/8.4.1/bare-metal/assets/screenshots/proxmox-network-vlan-ping.png)
