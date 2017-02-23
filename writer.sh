#!/bin/bash
# AUTHOR: Phil Porada - philporada@gmail.com
# WHAT: Runs all of the commands inside chapters.txt. Outputs status
#       to a separate file named status.log that you can tail.
rm -f status.log

while read LINE; do
    echo "[START]  - $(date) - ${LINE}" >> status.log
    eval "${LINE}"
    echo "[FINISH] - $(date) - ${LINE}" >> status.log
done < chapters.txt
