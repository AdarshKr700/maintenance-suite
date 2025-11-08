#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/lib.sh"
load_config
ensure_root_or_warn

log "INFO" "Starting system update and cleanup"

if command -v apt-get >/dev/null 2>&1; then
  safe_run apt-get update
  safe_run DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
  safe_run apt-get -y autoremove
  safe_run apt-get -y autoclean
  log "INFO" "Apt update complete"
elif command -v dnf >/dev/null 2>&1; then
  safe_run dnf -y upgrade
  safe_run dnf -y autoremove
  log "INFO" "Dnf update complete"
elif command -v yum >/dev/null 2>&1; then
  safe_run yum -y update
  safe_run yum -y autoremove
  log "INFO" "Yum update complete"
elif command -v pacman >/dev/null 2>&1; then
  safe_run pacman -Syu --noconfirm
  log "INFO" "Pacman update complete"
else
  die "No supported package manager found"
fi

log "INFO" "System update and cleanup done"
