#!/usr/bin/env bash

# ==========================================================
# Author: https://github.com/sevaho
# Repo: https://github.com/sevaho/scripts
#
# ==========================================================

NAME=PRTSCR-$(date '+%Y%m%d-%H%M%S')-$(cat /proc/sys/kernel/random/uuid).png
FILELOC=~/Pictures/screenshots/$NAME
maim -s -u --format=png $FILELOC
cat $FILELOC | xclip -selection clipboard -t image/png -i
notify-send "PRTSC saved to $NAME" -i $FILELOC
