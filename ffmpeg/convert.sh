#!/bin/bash
# Given an input wildcard, being the set of image files to be converted
# to a video, save that video in the location "output_wildcard"
# Example call
# ./convert.sh 'test_artifacts/*.JPG' 'test_artifacts/output.mp4' 'Bowling Green' 3

#!/bin/bash


if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <input_wildcard> <output_location> <opening_title> <output_duration>"
    exit 1
fi

opening_title="$3"
duration_per_image="$4"


# Generate opening credits video with the provided title
credits_outfile='test_artifacts/opening_credits.mp4'
ffmpeg -f lavfi -i color=size=3456x2304:duration=3:rate=25:color=blue -vf "drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:fontsize=100:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text=$opening_title" $credits_outfile

# Create a video from images
images_outfile='test_artifacts/images.mp4'
ffmpeg -framerate 1/3 -pattern_type glob -i "$1" -c:v libx264 -r 30 -pix_fmt yuv420p $images_outfile

combined_outfile='test_artifacts/outty.mp4'
ffmpeg -f concat -i filelist.txt -c copy $combined_outfile


# Clean up temporary files
rm $credits_outfile $images_outfile
