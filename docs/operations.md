# ⚙️ Operations & Maintenance

This document describes the operational strategy of the home server, including backup and maintenance processes.

---

## 🧠 Design Principles

The system follows these operational principles:

- **Data integrity first** (consistent backups)
- **Minimal downtime**
- **Separation of concerns (code vs data)**
- **Automation over manual intervention**
- **Reproducibility**

---

## 💾 Backup Strategy

### Overview

A full backup of the Docker environment is performed using a custom script:

```
scripts/backup/backup.sh
```

### Key Features

- Full snapshot of the Docker directory
- Automatic service shutdown (Pi-hole, Portainer) to ensure data consistency
- Automatic restart via `trap` mechanism
- Backup rotation (default: 15 days)
- Centralized logging

### Storage

Backups are stored in:

```
/backups
```

### Naming Convention

```
docker_backup_YYYY-MM-DD_HH-MM-SS.tar.gz
```

---

## 🧹 Maintenance Strategy

### Pi-hole Database Cleanup

Script:

```
scripts/maintenance/pihole-db-cleanup.sh
```

### Purpose

Removes unnecessary SQLite artifacts generated during Pi-hole operations:

- Temporary files (`gravity.db_temp-*`)
- Legacy database (`gravity_old.db`)

### Why this matters

These files can accumulate over time and:

- Waste disk space
- Indicate interrupted operations
- Reduce system cleanliness

---

## 📂 Data vs Code Separation

The system strictly separates:

| Type    | Location   |
| ------- | ---------- |
| Code    | `/docker`  |
| Data    | `/data`    |
| Backups | `/backups` |

### Benefits

- Improved security (no sensitive data in repo)
- Easier migration between environments
- Clear operational boundaries

---

## 🔐 Safety Considerations

- No sensitive data is stored in the repository
- `.env` files are excluded
- Scripts are designed to avoid destructive operations
- Cleanup scripts do not modify active databases

---

## 🚀 Future Improvements

- Scheduled execution via cron
- Remote backup replication
- Monitoring integration
- Backup verification

---
