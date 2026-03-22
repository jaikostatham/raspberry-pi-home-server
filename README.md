# 🏠 Raspberry Pi Home Server (Docker-Based)

A self-hosted home server built on Raspberry Pi, designed with a focus on **security, modularity, and reproducibility**.

This project demonstrates a practical DevOps approach to running personal infrastructure using Docker, with secure remote access and automated maintenance workflows.

---

## 🚀 Overview

The system provides a fully containerized environment composed of:

- **Pi-hole** → Network-wide DNS + ad-blocking
- **WireGuard** → Secure remote access (VPN)
- **Portainer** → Container management UI
- **DuckDNS** → Dynamic DNS

All services are isolated and deployed independently using Docker Compose.

---

## 🧱 Architecture

```text
Internet
   │
   ▼
[ WireGuard VPN ]
   │
   ▼
──────── Internal Network ────────
│                                 │
│   Pi-hole     → DNS filtering   │
│   Portainer   → Management UI   │
│   DuckDNS     → DNS updater     │
│                                 │
─────────────────────────────────
```

---

## 🔐 Security Model

Security is a core design principle:

- 🔒 **VPN-only access** (WireGuard)
- 🚫 No services exposed directly to the internet
- 🧩 Container isolation via Docker
- 📂 Strict separation of:
  - Code (`docker/`, `scripts/`)
  - Configuration (`configs/`)
  - Data (runtime, not versioned)

- 🔑 No sensitive data stored in the repository

---

## ⚙️ Tech Stack

- **Hardware**: Raspberry Pi
- **Container Runtime**: Docker
- **Services**:
  - Pi-hole
  - WireGuard
  - Portainer
  - DuckDNS

- **Automation**:
  - Bash scripts
  - Cron jobs

- **Networking**:
  - Private network + VPN access

---

## 📂 Repository Structure

```text
.
├── docker/
│   ├── pihole/
│   ├── wireguard/
│   ├── portainer/
│   └── duckdns/
│
├── configs/
│   ├── pihole/
│   ├── wireguard/
│   └── system/
│
├── scripts/
│   ├── backup/
│   └── maintenance/
│
├── docs/
│   ├── architecture.md
│   ├── networking.md
│   ├── security.md
│   ├── operations.md
│   ├── MIGRATION_POLICY.md
│   └── UPDATE_POLICY.md
│
├── .env.example
└── README.md
```

---

## 🧩 Service Design

Each service is fully isolated and self-contained:

```text
docker/<service>/
├── docker-compose.yml
├── .env.example
└── data/ or config/
```

### Benefits

- Modular deployments
- Easy debugging and updates
- Independent lifecycle per service
- Clear separation of responsibilities

---

## 💾 Backup Strategy

The system implements a full backup workflow:

- Snapshot of the Docker environment
- Automatic service shutdown for consistency
- Automatic restart using `trap`
- Backup rotation (default: 15 days)
- Centralized logging

Script:

```bash
scripts/backup/backup.sh
```

---

## 🧹 Maintenance Strategy

Automated cleanup of Pi-hole database artifacts:

- Removes temporary SQLite files
- Removes legacy database files

Script:

```bash
scripts/maintenance/pihole-db-cleanup.sh
```

---

## 🔄 Operations & Policies

Detailed operational documentation:

- `docs/operations.md` → Backup & maintenance strategy
- `docs/MIGRATION_POLICY.md` → Migration & recovery
- `docs/UPDATE_POLICY.md` → Update & rollback procedures

---

## ⚡ Deployment

```bash
git clone <repository>
cd raspberry-pi-home-server
cp .env.example .env
docker compose up -d
```

---

## 🧠 Design Goals

- Reproducibility
- Minimal attack surface
- Infrastructure as code mindset
- Modular service design
- Fast recovery and migration

---
