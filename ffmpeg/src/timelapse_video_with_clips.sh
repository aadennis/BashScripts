#!/bin/bash
# Create a "timelapse" video from a provided video file

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

interval=3
clip_length=0.5

# Get the duration of the video in seconds
duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_video_path")
duration=${duration%.*}

# Loop over the video at the specified interval
for (( i=0; i<duration; i+=interval )); do
  # Use ffmpeg to extract a 2 second clip starting at the current timestamp
  ffmpeg -ss $i -i "$input_video_path" -t $clip_length -c copy "$input_dir/clip$i.mp4"
done

# Concatenate all the clips into the final output video
ffmpeg -f concat -safe 0 -i <(for f in "$input_dir"/clip*.mp4; do echo "file '$PWD/$f'"; done) -c copy "$output_video_path"

# Remove the temporary clip files
rm "$input_dir"/clip*.mp4
