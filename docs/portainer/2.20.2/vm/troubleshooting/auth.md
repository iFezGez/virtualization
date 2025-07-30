# Troubleshooting – Authentication

## Problem: Cannot login after initial setup
| Symptom | Cause | Fix |
|---------|-------|-----|
| Login fails with correct password | Portainer internal DB corrupted | Stop container, delete `portainer_data`, redeploy with `--admin-password` |

## Problem: No admin password prompt on fresh install
| Symptom | Cause | Fix |
|---------|-------|-----|
| Setup page skipped | Volume already mounted | Clear or rename `portainer_data` volume |
