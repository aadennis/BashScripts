#!/bin/bash
# convert a .mov file to .mp4
# the input file is read-only
# If the input file is say a.mov, then the output file is a.mp4, in the same folder as the input file.
# dependencies:
# sudo apt update
# sudo apt install ffmpeg
# usage example (from bash)
# ./convert_mov_to_mp4.sh ../test_artifacts/DevonCounty01.MOV
# todo
# lowercase just the extension

input_file_path=$1

# Convert the extension to lowercase
# Parameter expansion in Bash:
# ,, after the variable name converts all uppercase characters in the variable’s value to lowercase.
lowercase_name=${input_file_path,,}

# Get the directory and base name of the input file
dir=$(dirname "$input_file_path")
base_name=$(basename "$lowercase_name" .mov)

# Construct the output file path
output_file_path="$dir/$base_name.mp4"

# Print the input and output file paths
echo "Input file: $input_file_path"
echo "Output file: $output_file_path"

# Convert the file using ffmpeg
ffmpeg -i "$input_file_path" -vcodec copy -acodec copy "$output_file_path"
