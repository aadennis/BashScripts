#!/bin/bash

# Script: get_git_activity.sh
# Description:
# This script summarizes Git activity across all repositories in the parent directory.
# It lists the commits made within a specified number of months, grouped by repository.
#
# Usage:
# - Ensure the script has executable permissions: chmod +x ./get_git_activity.sh
# 1. Default behavior (last 3 months):
#    ./get_git_activity.sh
#
# 2. Specify the number of months:
#    ./get_git_activity.sh <months>
#    Example: ./get_git_activity.sh 5
#    This will return Git activity for the last 5 months.
#
# Output:
# - The output is a sorted list of unique file modifications, showing the date, repository name, and file path.
# - The list is sorted in reverse chronological order.
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

# Loop through all sibling directories containing a .git folder
for d in ../../*/.git; do
    # Extract the repository name from the directory path
    repo=$(basename "$(dirname "$d")")
    echo "== $repo =="

    # Retrieve the Git log for the last 7 months, showing the date and modified files
    git -C "$(dirname "$d")" log --since="7 months ago" --date=short \
        --pretty="%ad" --name-only \
    | awk -v r="$repo" -F/ '
        # If the line starts with a date, store it in the "day" variable
        /^[0-9]/ {day=$1; next}
        # If the line contains a file path, print the date, repository name, and file path
        NF>1 {print day, r, $1}
    '
done | sort -u | sort -r  # Remove duplicates and sort the output in reverse order
