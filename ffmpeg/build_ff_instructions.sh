#!/bin/bash
# Build an "instruction" file for use by ffmpeg, when making a video consisting
# of a bunch of image files, with a user-specified duration, or default of 3
# seconds. The image file folder also supports a default.
# Usage: 
# ./build_instructions.sh
# , then the script prompts the user for the image folder and duration.
# To emphasise: this just builds the instruction file used downstream by ffmpeg
# ----------------------------------------------
# Example of the output file instructions.txt (which is written to the 
# current folder)
# file 'test_artifacts/IMG_0001.JPG'
# duration 3
# file 'test_artifacts/IMG_0002.JPG'
# duration 3
# file 'test_artifacts/my_image.pnG'
# duration 3
# (etc)
# --------------------------------------
## USER INPUT PROMPTING

default_folder="test_artifacts"
default_duration=1
output_file="./instructions.txt"

read -p "Enter the folder containing the JPG files (press Enter for default '$default_folder'): " folder
# test for default
folder="${folder:-$default_folder}"

read -p "Enter the duration in seconds for each image (press Enter for default of $default_duration seconds): " duration
# test for default
duration="${duration:-$default_duration}"

# Create or clear the output file
> "$output_file"

# Loop through each JPG file in the folder, writing filename and duration
# find "$folder" -maxdepth 1 \( -iname '*.jpg' \) -print0 | while IFS= read -r -d '' file; do
#     echo "file '$file'" >> "$output_file"
#     echo "duration $duration" >> "$output_file"
#     echo "metadata title='$file'" >> "$output_file"
# done

find "$folder" -maxdepth 1 \( -iname '*.jpg' \) -printf "file '%p'\nduration $duration\n" > instructions.txt


cat $output_file

#ffmpeg -f concat -safe 0 -i "$output_file" -vf "fps=1/3,drawtext=text='%{filename}':x=(w-text_w)/2:y=(h-text_h)/2:fontsize=24:fontcolor=white" -pix_fmt yuv420p ./output.mp4

#ffmpeg -f concat -safe 0 -i "./instructions.txt" -vf "fps=1/3,drawtext=text='%{filename}':x=(w-text_w)/2:y=(h-text_h)/2" output.mp4
#ffmpeg -f concat -safe 0 -i "./instructions.txt" -vf "fps=1/3,drawtext=text='%{filename}':x=(w-text_w)/2:y=(h-text_h)/2:fontsize=24:fontcolor=white" output.mp4
#ffmpeg -f concat -safe 0 -i "$output_file" -vf "fps=1/$duration,drawtext=text='%{metadata:title}':x=(w-text_w)/2:y=(h-text_h)/2:fontsize=24:fontcolor=white" output.mp4

ffmpeg -f concat -safe 0 -i instructions.txt -vf "fps=1/$duration,drawtext=text='%{filename}':x=(w-text_w)/2:y=(h-text_h)/2:fontsize=24:fontcolor=white" output.mp4


