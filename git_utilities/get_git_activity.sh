#!/bin/bash

# chmod +x ./get_git_activity.sh
# Usage 1:
# ./get_git_activity.sh
# This will return summary git activity across all my repos for the last [3] months
# 
# Usage 2:
# ./get_git_activity.sh 5
# This sets the number of months to return to [5]
#
# Example output (ignore leading '#')
# == VbaSandbox ==
# == PythonSandboxAA ==
# 2025-08-27 PythonSandboxAA MockPlay
# 2025-08-26 PythonSandboxAA MockPlay
# 2025-08-25 VbaSandbox PowerPointVba
# 2025-08-25 PythonSandboxAA MusicHandling
# (end of example output)
# ---------------
# Default value for months
months=${1:-3}

for d in ../../*/.git; do
    repo=$(basename "$(dirname "$d")")
    echo "== $repo =="
    git -C "$(dirname "$d")" log --since="$months months ago" --date=short \
        --pretty="%ad" --name-only \
    | awk -v r="$repo" -F/ '
        /^[0-9]/ {day=$1; next}
        NF>1 {print day, r, $1}
    '
done | sort -u | sort -r

