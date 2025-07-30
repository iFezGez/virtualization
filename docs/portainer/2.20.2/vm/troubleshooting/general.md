# Troubleshooting – Portainer General

## Problem: Portainer Web UI not loading
| Symptom | Cause | Fix |
|---------|-------|-----|
| Blank page or connection refused | Portainer container not running | Run `docker ps -a` and `docker start portainer` |
| UI loads but errors on dashboard | Backend not connected | Restart Portainer and verify Docker socket mapping |

## Problem: Cannot deploy stack
| Symptom | Cause | Fix |
|---------|-------|-----|
| "Permission denied" on volume mount | Incorrect host path permissions | Adjust path or use `chown` to grant access |

## Problem: Updates not reflected in container
| Symptom | Cause | Fix |
|---------|-------|-----|
| Stale data after redeploy | Old image used from cache | Use `docker pull portainer/portainer-ce:2.20.2` before restart |
