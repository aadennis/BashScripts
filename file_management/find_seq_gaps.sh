#!/bin/bash

# This script checks for missing sequence numbers in filenames of the format takeout-###.zip
# Usage: Place this script in the directory containing the takeout-###.zip files and run it.
# 1 228 is the range of sequence numbers to check - todo, should no

cd /path/to/your/folder || { echo "Error: Folder not found. Exiting."; exit 1; }

seq_list=$(ls takeout-*.zip 2>/dev/null | sed -n 's/.*-\([0-9]\{3\}\)\.zip$/\1/p' | sort -n | uniq)

missing=$(comm -23 <(seq -w 1 228) <(echo "$seq_list"))

if [ -z "$missing" ]; then
    echo "No missing sequence numbers."
else
    echo "Missing sequence numbers:"
    echo "$missing"
fi
