#!/bin/bash
# Create a "timelapse" video from a provided video file.
# This version is for frames as input types, not clips.
# A single frame is extracted every $interval seconds from the input video, which then 
# lasts 1/$frame_rate seconds in the output video. So if $frame_rate = 0.5, the frame will
# last 2 seconds in the output video.
# other examples for ease (to do - provide a function for this):
# frame_rate : frame duration
# 0.5 : 2 seconds
# 0.25 : 4 seconds

interval=1 # gap between grabbing frames
frame_rate=0.5  # One frame lasts 2 seconds

# Check if video file was provided
if [ $# -eq 0 ]; then
    echo "No video file provided. Usage: ./script.sh <video_file>"
    exit 1
fi

# Get the input video file path
input_video_path="$1"

# Get the directory and base name of the input video file
input_dir=$(dirname "$input_video_path")
input_base=$(basename "$input_video_path" .mp4)

# Set the output video file path
output_video_path="$input_dir/$input_base.frames.mp4"



# Get the duration of the video in seconds
duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_video_path")
duration=${duration%.*}

# Loop over the video at the specified interval
for (( i=0; i<duration; i+=interval )); do
  # Use ffmpeg to extract a single frame at the current timestamp and repeat it to last for 2 seconds
  ffmpeg -ss $i -i "$input_video_path" -vf "fps=$frame_rate" -t 2 "$input_dir/frame$i.mp4"
done

# Concatenate all the frames into the final output video
ffmpeg -f concat -safe 0 -i <(for f in "$input_dir"/frame*.mp4; do echo "file '$PWD/$f'"; done) -c copy "$output_video_path"

# Remove the temporary frame files
rm "$input_dir"/frame*.mp4
