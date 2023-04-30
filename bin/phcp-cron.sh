#!/bin/bash

# systemctl restart crond
# systemctl restart synoscheduler
# rsync -aL -u --exclude=.DS_Store --ignore-existing -v Photos/* 192.168.188.99:/volume1/photo/Photos/

SRC=/volume1/photo_upload
DST=/volume1/photo/Photos
[[ -n "$(
  find "$SRC" -mindepth 1 -maxdepth 1 -cnewer $(
    ls -1t "$SRC"/*.log 2>/dev/null | head -1
  ) 2>/dev/null || ls -1 "$SRC"/
)" && -z "$(
  lsof | fgrep "$SRC" | fgrep -v '@eaDir'
)" ]] && phcp.pl -mv "$DST" "$SRC" >& `date +%F_%H%M%S`.log && find "$SRC"/'@eaDir' -delete
