tell application "Finder"
	activate
	make new folder at disk "MARKTEST" with properties {name:"untitled folder"}
	set name of folder "untitled folder" of disk "MARKTEST" to "DennisPhotos"
end tell
