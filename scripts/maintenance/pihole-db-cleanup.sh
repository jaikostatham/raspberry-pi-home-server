#!/usr/bin/env bash
# --------------------------------------------------
# Pi-hole Database Cleanup (Portable)
# --------------------------------------------------

set -euo pipefail

PIHOLE_DATA_DIR="${PIHOLE_DATA_DIR:-./data/pihole}"
LOGFILE="${LOGFILE:-./backups/pihole-cleanup.log}"

log() {
  echo "[$(date '+%F %T')] $1" | tee -a "$LOGFILE"
}

mkdir -p "$(dirname "$LOGFILE")"

if [ ! -d "$PIHOLE_DATA_DIR" ]; then
  log "ERROR: Pi-hole data directory not found"
  exit 1
fi

log "Starting Pi-hole cleanup..."

mapfile -t TEMP_FILES < <(find "$PIHOLE_DATA_DIR" -type f -name "gravity.db_temp-*")

if [ "${#TEMP_FILES[@]}" -eq 0 ]; then
  log "No temporary files found"
else
  for FILE in "${TEMP_FILES[@]}"; do
    log "Removing $(basename "$FILE")"
    rm -f "$FILE"
  done
fi

if [ -f "$PIHOLE_DATA_DIR/gravity_old.db" ]; then
  log "Removing gravity_old.db"
  rm -f "$PIHOLE_DATA_DIR/gravity_old.db"
fi

log "Cleanup completed"