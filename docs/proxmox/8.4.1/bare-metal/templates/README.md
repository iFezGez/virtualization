# Creating Cloud-Init VM Templates in Proxmox

This guide explains how to create a reusable Debian 12 template with cloud-init support in Proxmox.

## Steps

1. Download the Debian 12 generic cloud image (QCOW2).
2. Create a new VM with ID 9000 and attach the downloaded disk.
3. Configure boot settings and add a cloud-init drive.
4. Mark the VM as a template.

## Script

The `create_debian12_template.sh` script automates this process:

```bash
./scripts/create_debian12_template.sh
```

Ensure the script has executable permissions and is run from the `proxmox/` directory.

## Output

Once executed, you’ll have a reusable cloud-init template with VM ID 9000 stored in your local Proxmox node.

# Creating Cloud-Init VM Templates in Proxmox

This guide explains how to create a reusable Debian 12 template with cloud-init support in Proxmox.

## Steps

1. Download the Debian 12 generic cloud image (QCOW2).
2. Create a new VM with ID 9000 and attach the downloaded disk.
3. Configure boot settings and add a cloud-init drive.
4. Mark the VM as a template.

## Script

The `create_debian12_template.sh` script automates this process:

```bash
./scripts/create_debian12_template.sh
```

Ensure the script has executable permissions and is run from the `proxmox/` directory.

## Output

Once executed, you’ll have a reusable cloud-init template with VM ID 9000 stored in your local Proxmox node.