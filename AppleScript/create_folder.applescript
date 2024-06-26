# Create a set of folders in targetPhotos, on the volume targetSD
# To execute from an iTerm2 window, go to the scripts folder, and run...
# osascript .create_folder.scpt

set targetSD to "MARKTEST"
set targetPhotos to "DennisPhotosx2"
set startYear to 2010
set endYear to 2026

# Do not edit below here

tell application "Finder"
	activate
	make new folder at disk targetSD with properties {name:targetPhotos}
end tell

set targetSD to "/Volumes/" & targetSD
repeat with currentYear from startYear to endYear
	set yearFolder to (targetSD & "/" & targetPhotos & "/" & currentYear & "")
	# display dialog yearFolder
	try
		do shell script "mkdir -p '" & yearFolder & "'"
		repeat with currentMonth from 1 to 12
			set monthFolderName to currentYear & "-" & text -2 thru -1 of ("0" & currentMonth)
			set monthFolder to (yearFolder & "/" & monthFolderName)
			try
				do shell script "mkdir -p '" & monthFolder & "'"
				display dialog "Created folder: " & monthFolder
				delay 0.05
			end try
		end repeat
	end try
end repeat

