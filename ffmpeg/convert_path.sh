#!/bin/bash
# Given a full path in Windows format, convert to the 
# equivalent unix path.
# To use the echoed value as a return value to the caller, 
# execute so:
# win_path="C:\temp"
# unix_path=$(./convert_path.sh $win_path)
# Expected result on wsl2 is: /mnt/c/temp


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <windows_path>"
    exit 1
fi

# Convert Windows path to WSL path
wsl_path=$(wslpath -u "$1")

echo "$wsl_path"


