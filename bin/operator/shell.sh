#!/bin/bash

die() { echo "$@"; exit 1; }
cd "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")" || die "Unable to find the script dir"

while true; do
    clear
    R="$((cd ops ; ls -1) | TERM=xterm-256color smenu -d -c -n -q -d)"
    CMD="ops/$R"
    [[ -f "$CMD" && -x "$CMD" ]] || exit
    "$CMD"
    #read -p "Press Enter to continue... "
done

