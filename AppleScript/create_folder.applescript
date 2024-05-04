# Create a set of folders in targetPhotos

set targetSD to "MARKTEST"
set targetPhotos to "DennisPhotos2"
set startYear to 2010
set endYear to 2026

tell application "Finder"
	activate
	make new folder at disk targetSD with properties {name:targetPhotos}
end tell

repeat with currentYear from startYear to endYear
	set yearFolder to targetPhotos & ":" & currentYear & ":"
	try
		do shell script "mkdir " & yearFolder
	end try
end repeat


