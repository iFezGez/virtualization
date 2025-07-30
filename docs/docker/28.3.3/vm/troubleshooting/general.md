# Docker Troubleshooting (General)

## Introduction
This document lists common issues encountered when deploying Docker 28.3.3 on Debian 12.11 (VM-based) and how to resolve them efficiently.

## Problem – Docker not starting

| Symptom | Cause | Fix |
|--------|--------|-----|
| `docker.service failed` | Broken install or conflicting version | Run `apt purge docker* && apt install --reinstall docker-ce` |

---

## Problem – Container has no internet

| Symptom | Cause | Fix |
|--------|--------|-----|
| Ping fails from container | IP forwarding disabled | Add `net.ipv4.ip_forward=1` to `/etc/sysctl.conf` and run `sysctl -p` |

---

## Problem – Cannot pull image from Docker Hub

| Symptom | Cause | Fix |
|--------|--------|-----|
| TLS error / connection refused | No DNS or blocked outbound ports | Check `/etc/resolv.conf` or try `ping google.com` |

---

## Problem – SSH to root not allowed

| Symptom | Cause | Fix |
|--------|--------|-----|
| `Permission denied` when logging in | `PermitRootLogin` not set | Edit `/etc/ssh/sshd_config`, set `PermitRootLogin yes`, restart SSH |

---

## Problem – Docker Compose not found

| Symptom | Cause | Fix |
|--------|--------|-----|
| `docker-compose: command not found` | Plugin not installed | Make sure `docker-compose-plugin` is installed with Docker |

---

## Next steps / Links

- Proceed to [features.md](../docs/features.md)
- Docker docs [✔ verified https://docs.docker.com/engine/install/debian/]
