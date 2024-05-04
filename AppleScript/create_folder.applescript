(*
This is a Block comment
*)
# This is an inline comment

set targetSD to "MARKTEST"
set targetPhotos to "DennisPhotos"

# no edits below here
log targetSD + " " + targetPhotos

tell application "Finder"
	activate
	set targetDisk to disk targetSD
	make new folder at disk targetDisk with properties {name:targetPhotos}
end tell
