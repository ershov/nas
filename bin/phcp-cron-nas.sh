#!/bin/bash

# systemctl restart crond
# systemctl restart synoscheduler
# rsync -aL -u --exclude=.DS_Store --ignore-existing -v Photos/* 192.168.188.99:/volume1/photo/Photos/

SRC=/mnt/data/photo_upload/upload
DST=/mnt/data/photo/Photos/
LOG="$SRC/$(date +%F_%H%M%S).log"

[[ -n "$(
  find "$SRC" -type f -cnewer $(
    ls -1t "$SRC"/*.log 2>/dev/null | head -1
  ) 2>/dev/null || ls -1 "$SRC"/
)" && -z "$(
  lsof | fgrep "$SRC"
)" ]] && /home/ershov/nas/phcp.pl "$DST" "$SRC" >& "$LOG"
