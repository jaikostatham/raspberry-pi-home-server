# 🔄 Update Policy

This document defines the safe and controlled process for updating services within the Home Server environment.

---

## 🎯 Objective

Ensure that every update is:

- Controlled
- Reproducible
- Verifiable
- Reversible

Without compromising system stability or data integrity.

---

## 🧠 Core Principles

- Containers are **disposable**
- Data is **persistent**
- `docker-compose` is the **source of truth**
- Updates must **never be performed without a valid backup**
- Every update must be **validated**

---

## 📦 Scope

This policy applies to all services running in the system, including:

- Pi-hole
- WireGuard
- Portainer
- DuckDNS
- Any Docker-based service deployed in the stack

---

## ⚠️ Mandatory Pre-check

Before starting any update:

```bash
docker ps
```

Verify that:

- All containers are in **Up** state
- No critical errors are present in logs
- The system is stable

---

## 💾 Step 1 — Mandatory Backup

```bash
scripts/backup/backup.sh
```

Validate:

- Backup file is created successfully
- File size is consistent
- Stored in `/backups`

❌ Do not proceed without a valid backup

---

## 🔄 Step 2 — Update per Service

For each service:

```bash
docker compose pull
docker compose up -d --force-recreate
```

---

### 📌 Recommended Order

1. DuckDNS
2. Portainer
3. WireGuard
4. Pi-hole

---

## ⚠️ Rules During Update

- Do not update all services simultaneously
- Do not modify configuration during the process
- Do not use `docker run`
- Do not manually remove containers
- Do not use `docker system prune`

---

## 🧪 Step 3 — Technical Validation

```bash
docker ps
```

Check:

- Containers are recreated
- Status is **Up**
- No continuous restarts

Logs:

```bash
docker logs <service> --tail 30
```

---

## 🧪 Step 4 — Functional Validation

### Pi-hole

- DNS resolution is working correctly

---

### WireGuard

- Successful handshake
- Remote access operational

---

### Portainer

- Web UI accessible
- Endpoints visible

---

### DuckDNS

- IP update successful
- No errors in logs

---

## 🔁 Step 5 — Rollback Procedure

In case of failure:

```bash
tar -xzf backups/docker_backup_*.tar.gz
docker compose up -d
```

Immediately validate after restoration.

---

## ⛔ Prohibited Actions

Do NOT execute:

```bash
docker system prune -a
docker volume prune
docker network prune
```

Do NOT:

- Delete persistent data manually
- Mix OS updates with container updates
- Update the system while unstable

---

## ⏱️ Recommended Frequency

- Containers: monthly
- Operating system: monthly (separate window)
- Backups: daily

---

## 🧠 Operational Model

```
Image       → replaceable
Container   → disposable
Data        → persistent
Compose     → source of truth
Backup      → recovery point
```

---

## 🔮 Future Improvements

- Automated update workflows
- Version monitoring
- Post-update automated validation
- CI/CD integration

---
