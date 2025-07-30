# Docker Features Overview

## Introduction
This page summarizes the key Docker capabilities enabled in this environment and provides links to advanced usage topics.

## Feature Matrix

| Feature           | Enabled | Notes                               |
|-------------------|---------|--------------------------------------|
| Docker CLI        | ✅       | Installed with version 28.3.3        |
| BuildKit support  | ✅       | Enabled by default in recent Docker |
| Systemd startup   | ✅       | Integrated with `systemctl`         |
| Rootless Docker   | ❌       | Not configured                      |
| Docker Compose v2 | ✅       | Installed via plugin                |
| Logging to journald | ✅     | Configured via `daemon.json`        |

## Optional Tools

- **Portainer:** UI for Docker [✔ verified https://www.portainer.io/]
- **Docker Compose:** `docker compose up -d`
- **Docker Registry:** Self-hosted image storage

## Next steps

Review [troubleshooting/](../../troubleshooting/) for known issues and fixes.
