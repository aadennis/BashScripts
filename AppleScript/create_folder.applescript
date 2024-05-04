(*
This is a Block comment
*)
# This is an inline comment

set targetSD to "MARKTEST"
set targetPhotos to "DennisPhotos4"

tell application "Finder"
	activate
	make new folder at disk targetSD with properties {name:targetPhotos}
end tell

