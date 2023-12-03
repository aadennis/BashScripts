#!/bin/bash
# Given an input wildcard, being the set of image files to be converted
# to a video, save that video in the location "output_wildcard"
# Example call
# ./convert.sh 'test_artifacts/*.JPG' 'test_artifacts/output3.mp4' 'I like black swans'
# ./convert.sh 'test_artifacts/*.JPG' 'test_artifacts/output.mp4' "A nice day on the Solent" 3

#!/bin/bash


if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <input_wildcard> <output_location> <opening_title> <output_duration>"
    exit 1
fi

opening_title="$3"
output_duration="$4"

# Generate opening credits video with the provided title
#ffmpeg -f lavfi -t "$output_duration" -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf "drawtext=text='${opening_title}':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=(h-text_h)/2" -c:v libx264 -r 30 -pix_fmt yuv420p -c:a null -an opening_credits.mp4
ffmpeg -f lavfi -i color=size=3456x2304:duration=10:rate=25:color=blue -vf "drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:fontsize=30:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='Bowling Green'" 'test_artifacts/opening_credits.mp4'

# Create a video from images
ffmpeg -framerate 1/3 -pattern_type glob -i "$1" -c:v libx264 -r 30 -pix_fmt yuv420p 'test_artifacts/images.mp4'

# Concatenate opening credits and images videos
#ffmpeg -i opening_credits.mp4 -i images.mp4 -filter_complex "[0:v] [1:v] concat=n=2:v=1 [v]" -map "[v]" -y "$2"

# Clean up temporary files
#rm opening_credits.mp4 images.mp4
