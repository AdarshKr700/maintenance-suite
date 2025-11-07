#!/usr/bin/env bats

setup() {
  cd "${BATS_TEST_DIRNAME}/../" || exit 1
}

@test "scripts are executable" {
  run bash -c '[[ -x scripts/backup.sh && -x scripts/update_and_cleanup.sh && -x scripts/log_monitor.sh && -x scripts/suite_menu.sh ]] && echo ok || exit 1'
  [ "$status" -eq 0 ]
}
