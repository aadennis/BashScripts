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
default_duration=3
instructions_file="./instructions.txt"

read -p "Enter the folder containing the JPG files (press Enter for default '$default_folder'): " folder
# test for default
folder="${folder:-$default_folder}"

read -p "Enter the duration in seconds for each image (press Enter for default of $default_duration seconds): " duration
# test for default
duration="${duration:-$default_duration}"

# Enable case-insensitive globbing
shopt -s nocaseglob
# Create or clear the output file
> "$instructions_file"

# Loop through each JPG file in the folder, writing filename and duration
find "$folder" -maxdepth 1 \( -iname '*.jpg' -o -iname '*.png' \) -print0 | while IFS= read -r -d '' file; do
    lowercase_file=$(basename "$file" | tr '[:upper:]' '[:lower:]')
    # Determine the format based on the file extension
    if [[ "$lowercase_file" == *.jpg ]]; then
        format="jpg"
    elif [[ "$lowercase_file" == *.png ]]; then
        format="png"
    else
        # Handle unsupported formats or other cases
        format="unknown"
    fi
    echo "file '$file'" >> "$instructions_file"
    #echo "format $format" >> "$instructions_file"
    echo "duration $duration" >> "$instructions_file"
done

cat $instructions_file

probe_size=50000000
ffmpeg -f concat -safe 0 -i "$instructions_file" -vf "fps=1/3,scale=1920:-2" ./output.mp4

