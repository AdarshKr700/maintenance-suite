#!/usr/bin/env bash
# Shared helpers for maintenance scripts
set -o nounset
set -o pipefail

# non-fatal errors won't stop the script unless explicitly checked. For critical scripts you may uncomment errexit:
# set -o errexit

# default config values (overridden by config file)
LOGFILE="./logs/maintenance-suite.log"
RETENTION_DAYS=30
KEEP_DAYS=14

timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

log() {
  local level="${1:-INFO}"; shift || true
  local msg="$*"
  local ts
  ts="$(timestamp)"
  echo "$ts [$level] $msg" | tee -a "$LOGFILE"
}

die() {
  log "ERROR" "$*"
  exit 1
}

safe_run() {
  "$@"
  local rc=$?
  if [[ $rc -ne 0 ]]; then
    log "ERROR" "Command failed ($rc): $*"
    return $rc
  fi
  return 0
}

load_config() {
  local cfg
  cfg="$(dirname "$0")/../config/maintenance.conf"
  if [[ -f "$cfg" ]]; then
    # shellcheck disable=SC1090
    source "$cfg"
  fi
}

ensure_dir() {
  local d="$1"
  if [[ ! -d "$d" ]]; then
    mkdir -p "$d" || die "Failed to create directory $d"
  fi
}

ensure_root_or_warn() {
  if [[ "$(id -u)" -ne 0 ]]; then
    log "WARN" "Not running as root (UID $(id -u)). Some operations may require sudo."
  fi
}
