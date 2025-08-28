#!/bin/bash

# Script: get_git_activity.sh
# Description:
# This script summarizes Git activity across all repositories in the parent directory.
# It lists the commits made within a specified number of months, grouped by repository.
#
# Usage:
# 1. Default behavior (last 3 months):
#    ./get_git_activity.sh
#
# 2. Specify the number of months:
#    ./get_git_activity.sh <months>
#    Example: ./get_git_activity.sh 5
#    This will return Git activity for the last 5 months.
#
# Example Output:
# == VbaSandbox ==
# == PythonSandboxAA ==
# 2025-08-27 PythonSandboxAA MockPlay
# 2025-08-26 PythonSandboxAA MockPlay
# 2025-08-25 VbaSandbox PowerPointVba
# 2025-08-25 PythonSandboxAA MusicHandling
# (end of example output)
#
# Notes:
# - The script assumes repositories are located two levels up from the current directory.
# - The default number of months is set to 3 if no argument is provided.
# - Ensure the script has executable permissions using `chmod +x ./get_git_activity.sh`.

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

