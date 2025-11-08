#!/usr/bin/env bash
set -o nounset
set -o pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/lib.sh"
load_config

LOG_TO_MONITOR="/var/log/syslog"
if [[ ! -f "$LOG_TO_MONITOR" ]]; then
  LOG_TO_MONITOR="/var/log/messages"
fi

PATTERN="(ERROR|CRITICAL|FAIL|segfault|panic)"
ALERT_EMAIL="${ALERT_EMAIL:-}"

log "INFO" "Scanning $LOG_TO_MONITOR for pattern: $PATTERN"
matches=$(grep -E "$PATTERN" "$LOG_TO_MONITOR" || true)

if [[ -n "$matches" ]]; then
  log "WARN" "Found matches in $LOG_TO_MONITOR"
  echo "$matches" | tee -a "$LOGFILE"
  if [[ -n "$ALERT_EMAIL" ]] && command -v mailx >/dev/null 2>&1; then
    echo "$matches" | mailx -s "Log monitor alert on $(hostname)" "$ALERT_EMAIL"
    log "INFO" "Alert emailed to $ALERT_EMAIL"
  else
    if [[ -n "$ALERT_EMAIL" ]]; then
      log "WARN" "mailx not installed. Install mailutils/mailx to send email alerts"
    fi
  fi
else
  log "INFO" "No matches found in $LOG_TO_MONITOR"
fi
