#!/bin/bash
# Create a video file consisting of a set of image files
# Example:
# ./convert.sh 'test_artifacts/*.JPG' 'test_artifacts/output.mp4' 'Bowling Green' 3
# More detail:
# filelist.txt is a fixed file that tells the script where
# to find the opening credits video, and the concatted set of images video.
# That set is fixed thus:
# file test_artifacts/opening_credits.mp4
# file test_artifacts/images.mp4


# files='test_artifacts/*.JPG' 'test_artifacts/output.mp4' 'Bowling Green' 3

# if [ "$#" -ne 4 ]; then
#     echo "Usage: $0 <input_wildcard> <output_location> <opening_title> <output_duration>"
#     exit 1
# fi

# files=$1
# opening_title="$3"
# duration_per_image="$4"

path='test_artifacts'
file_type = '*.JPG'
files='test_artifacts/*.JPG'
opening_title='Bowling Green'
duration_per_image="3"

opening_credit="RSPB Bowling Green Marsh
3 December 2023"

# Generate opening credits video with the provided title
credits_outfile='test_artifacts/opening_credits.mp4'
videolist_file=$(mktemp)
echo $credits_outfile > videolist_file
cat videolist_file
ls -l $videolist_file
# read -p "point 1: " myname
echo $myname
# read -p "point 2: " stuff
find "$path" -type f -iname "$files" -exec \ 
    bash -c 'echo "file '$0'" '{}' \; > images.txt exiftool -d %Y-%m-%d %H:%M:%S '{}' >> images.txt' {} \;

ffmpeg -f concat -i images.txt -i watermark.png -filter_complex "
overlay=W-w-10:H-h-10,
format=yuv420[v];
[v]drawtext=text='%{localtime\: %T\\n%Y-%m-%d}':
x=(W-w-10):y=H-h-10:
fontsize=24:fontcolor=white:box=1:boxcolor=black@0.5:boxborderw=5,
drawtext=text='%{filename}':
x=(W-w-10):y=H-h-30:fontsize=14:fontcolor=white:box=1:boxcolor=black@0.5:boxborderw=5" -c:v libx264 -c:a aac -strict experimental output.mp4

combined_outfile='test_artifacts/outty.mp4'
ffmpeg -f concat -i videolist_file -c copy "$combined_outfile"
