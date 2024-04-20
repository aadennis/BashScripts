#!/bin/bash

# Directory containing the images
dir="../ffmpeg/test_artifacts"
file_type="*.png"

# Create a text file with the image names and timestamps
find "$dir" -type f -iname "*.jPg" -exec bash -c '
echo "file '$0'" '{}' \; > images.txt
exiftool -d %Y-%m-%d_%s '{}' >> images.txt
' {} \;

cat ./images.txt

# Generate the video
ffmpeg -f concat -i images.txt -i watermark.png -filter_complex "
overlay=W-w-10:H-h-10,
format=yuv420[v];
[v]drawtext=text='%{localtime\: %T\\n%Y-%m-%d}':
x=(W-w-10):y=H-h-10:
fontsize=24:fontcolor=white:box=1:boxcolor=black@0.5:boxborderw=5,
drawtext=text='%{filename}':
x=(W-w-10):y=H-h-30:fontsize=14:fontcolor=white:box=1:boxcolor=black@0.5:boxborderw=5" -c:v libx264 -c:a aac -strict experimental output.mp4

#[concat @ 0x561737a935c0] Unsafe file name '/mnt/d/Sandbox/git/aadennis/BashScripts/nothing/leo_convertxxx.sh'
#images.txt: Operation not permitted