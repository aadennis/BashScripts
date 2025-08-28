# Git Utilities

## Stuff for making GitLife easier

### Get Git activity

#### `get_git_activity.sh`

Running this script:

```
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
```

returns this, as an example:

```/BashScripts/git_utilities (main)
$ ./get_git_activity.sh 
== swift ==
== github.io ==
== aadennis.github.io ==
== WebDevNoFramework ==
== VbaSandbox ==
== RSandboxv2 ==
== RSandbox ==
== PythonSandboxAA ==
== PowerShell ==
== GoogleApps ==
== BashScripts.wiki ==
== BashScripts ==
== Automation ==
== AndroidSandbox ==
== AWS ==
2025-08-27 PythonSandboxAA MockPlay
2025-08-26 PythonSandboxAA MockPlay
2025-08-25 VbaSandbox PowerPointVba
2025-08-25 PythonSandboxAA MusicHandling
2025-08-24 VbaSandbox PowerPointVba
2025-08-23 VbaSandbox PowerPointVba
2025-08-23 PythonSandboxAA MusicHandling
2025-08-22 VbaSandbox PowerPointVba
2025-08-21 swift notes
2025-08-21 swift MyCLI
```

