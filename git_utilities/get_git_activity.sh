#!/bin/bash
# chmod +x ./get_git_activity.sh

for d in ../../*/.git; do
    repo=$(basename "$(dirname "$d")")
    echo "== $repo =="
    git -C "$(dirname "$d")" log --since="7 months ago" --date=short \
        --pretty="%ad" --name-only \
    | awk -v r="$repo" -F/ '
        /^[0-9]/ {day=$1; next}
        NF>1 {print day, r, $1}
    '
done | sort -u | sort -r

