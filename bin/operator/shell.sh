#!/bin/bash

die() { echo "$@"; read -p "Press Enter to exit. "; exit 1; }
cd "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")" || die "Unable to find the script dir"

[[ -z "$MENU" ]] && which fzf >& /dev/null && MENU="fzf --no-multi -i --layout=reverse-list"
[[ -z "$MENU" ]] && which smenu >& /dev/null && MENU="smenu -d -c -n -q -d"
[[ -z "$MENU" ]] && die "Please install either one of: fzf, smenu."

while true; do
    clear
    R="$((cd ops ; ls -1) | $MENU)"
    clear
    CMD="ops/$R"
    [[ -f "$CMD" && -x "$CMD" ]] || exit
    echo "$ $R"
    "$CMD"
    #read -p "Press Enter to continue... "
done

