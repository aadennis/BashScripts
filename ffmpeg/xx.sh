#!/bin/bash

# Default folder containing the image files
default_folder="test_artifacts"
default_duration=3
output_file="./instructions.txt"

# Prompt the user to enter the folder containing the image files
read -p "Enter the folder containing the image files (press Enter for default '$default_folder'): " folder

# Use default folder if no input provided
folder="${folder:-$default_folder}"

echo $folder
blah=$pwd
echo $blah
folder="$PWD/$folder"
echo $folder
read -p "above is what I have 2"

# Output file
output_file="output.mp4"

# Prompt the user to enter the duration for each image
read -p "Enter the duration in seconds for each image (press Enter for default of 3 seconds): " duration

# Use default duration of 3 seconds if no input provided
duration="${duration:-3}"

# Clear the output file if it exists
> "$output_file"

# Loop through each image file in the folder
for file in "$folder"/*.JPG; do
    filename=$(basename "$file")
    ffmpeg -loop 1 -i "$file" -r 1 -vf "drawtext=text='$filename':x=(w-text_w)/2:y=(h-text_h)/2:fontsize=24:fontcolor=white" -t "$duration" -c:v libx264 -pix_fmt yuv420p -shortest -y "${filename%.*}.mp4"
done

echo $folder

read -p "above is what I have"

# Concatenate the resulting videos
ffmpeg -v debug -f concat -safe 0 -i <(for file in "$folder"/../*.mp4; do echo "file '$file'"; done) -c copy "/mnt/d/temp/$output_file"

# Clean up temporary video files
#rm "$folder"/*.mp4
