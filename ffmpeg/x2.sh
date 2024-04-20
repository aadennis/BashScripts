#!/bin/bash

# Define input files
input_files="IMG_0001.mp4 IMG_0002.mp4 IMG_0003.mp4 IMG_0004.mp4 IMG_3093.mp4"

# Output file
output_file="output.mp4"

# Concatenate the input files
ffmpeg_command="ffmpeg"
for file in $input_files; do
    ffmpeg_command+=" -i \"$file\""
done

# Add the filter complex and output options
ffmpeg_command+=" -filter_complex \"concat=n=$(echo $input_files | wc -w):v=1:a=0[v]\" -map \"[v]\" -c:v libx264 -movflags +faststart \"$output_file\""

# Execute the ffmpeg command
eval "$ffmpeg_command"

