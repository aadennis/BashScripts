#! /bin/bash
# See remove_linefeed.awk for docs

cd /mnt/d/Sandbox/git/aadennis/BashScripts/Awk/src
cd /mnt/c/temp
awk -f remove_linefeed.awk gawk_man_manual.txt > gawk_man_no_lf.txt
