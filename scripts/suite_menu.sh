#!/usr/bin/env bash
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"

show_menu() {
  echo "Maintenance Suite - choose an option:"
  echo "1) Backup"
  echo "2) Update & Cleanup"
  echo "3) Log Monitor"
  echo "4) Exit"
  read -rp "Enter choice [1-4]: " choice
  case "$choice" in
    1) "$HERE/backup.sh" ;;
    2) "$HERE/update_and_cleanup.sh" ;;
    3) "$HERE/log_monitor.sh" ;;
    4) exit 0 ;;
    *) echo "Invalid choice";;
  esac
}

if [[ $# -ge 1 ]]; then
  cmd="$1"
  case "$cmd" in
    backup) "$HERE/backup.sh" ;;
    update) "$HERE/update_and_cleanup.sh" ;;
    monitor) "$HERE/log_monitor.sh" ;;
    *) echo "Usage: $0 {backup|update|monitor|menu}" ;;
  esac
  exit 0
fi

while true; do
  show_menu
done
