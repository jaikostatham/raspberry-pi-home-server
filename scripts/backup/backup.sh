#!/usr/bin/env bash
# --------------------------------------------------
# Docker Services Backup Script (Portable)
# --------------------------------------------------

set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-./backups}"
SOURCE_DIR="${SOURCE_DIR:-./docker}"
RETENTION_DAYS="${RETENTION_DAYS:-15}"

DATE="$(date +%F_%H-%M-%S)"
FILENAME="docker_backup_${DATE}.tar.gz"
LOGFILE="${BACKUP_DIR}/backup.log"

COMPOSE_FILES=(
  "./docker/pihole/docker-compose.yml"
  "./docker/portainer/docker-compose.yml"
)

log() {
  echo "[$(date '+%F %T')] $1" | tee -a "$LOGFILE"
}

cleanup() {
  log "Restoring services..."
  for file in "${COMPOSE_FILES[@]}"; do
    [ -f "$file" ] && docker compose -f "$file" up -d || true
  done
}

trap cleanup EXIT

mkdir -p "$BACKUP_DIR"

command -v docker >/dev/null || { log "ERROR: docker not installed"; exit 1; }
command -v tar >/dev/null || { log "ERROR: tar not installed"; exit 1; }

[ -d "$SOURCE_DIR" ] || { log "ERROR: source dir not found"; exit 1; }

log "Stopping services..."

for file in "${COMPOSE_FILES[@]}"; do
  [ -f "$file" ] && docker compose -f "$file" down || true
done

log "Creating backup: $FILENAME"

tar -czf "${BACKUP_DIR}/${FILENAME}" \
  --exclude='*/gravity_backups/*' \
  --exclude='*/config_backups/*' \
  "$SOURCE_DIR"

log "Applying retention policy"

find "$BACKUP_DIR" -type f -name "docker_backup_*.tar.gz" -mtime +"$RETENTION_DAYS" -delete

log "Backup completed"