#!/bin/bash
# Extract frames from a provided video file.
# Save those frames as individual jpg files
# A single frame is extracted every $interval seconds from the input video.

interval=1 # gap between grabbing frames

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

# Get the duration of the video in seconds
duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_video_path")
duration=${duration%.*}

# Loop over the video at the specified interval
for (( i=0; i<duration; i+=interval )); do
  # Use ffmpeg to extract a single frame at the current timestamp and save it as a jpg file
  ffmpeg -ss $i -i "$input_video_path" -vframes 1 "$input_dir/frame$i.jpg"
done
