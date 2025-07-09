# Troubleshooting OSD Stuck / Undersized PGs

## Problem

You may see this:

```
HEALTH_WARN: Degraded data redundancy: 1 pg undersized
pg 3.3e is stuck undersized
```

## Diagnosis

1. Check if all OSDs are `up` and `in`:

```bash
ceph osd tree
ceph osd stat
```

2. If PG is stuck in `undersized+remapped`, use:

```bash
ceph pg repair <pgid>
```

3. Rebalance:

```bash
ceph osd reweight-by-utilization
```

## Fix

```bash
ceph osd in <osd.id>  # if previously out
ceph pg repair <pgid>
```

Check:

```bash
ceph -s
```

Until you see `HEALTH_OK`.
