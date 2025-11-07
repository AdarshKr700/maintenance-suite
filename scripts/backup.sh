#!/usr/bin/env bash
# backup.sh - create compressed tar backups of configured sources
set -o errexit
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/lib.sh"
load_config

ensure_dir "$BACKUP_DEST"

ts=$(date +"%Y%m%d_%H%M%S")
archive="$BACKUP_DEST/backup_${ts}.tar.gz"

log "INFO" "Starting backup of: $BACKUP_SRC -> $archive"

# create archive (preserve permissions)
tar -czpf "$archive" $BACKUP_SRC
log "INFO" "Backup finished: $archive"

# cleanup old backups
find "$BACKUP_DEST" -type f -name "backup_*.tar.gz" -mtime +"$KEEP_DAYS" -print -delete || true
log "INFO" "Removed backups older than $KEEP_DAYS days (if any)"
