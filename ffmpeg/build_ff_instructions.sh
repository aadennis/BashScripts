#!/bin/bash

## USER INPUT PROMPTING

# Default folder containing the JPG files
default_folder="test_artifacts"
default_duration=3
# Output file
output_file="./instructions.txt"

read -p "Enter the folder containing the JPG files (press Enter for default '$default_folder'): " folder
# test for default
folder="${folder:-$default_folder}"

read -p "Enter the duration in seconds for each image (press Enter for default of 3 seconds): " duration
# test for default
duration="${duration:-$default_duration}"

# Clear the output file if it exists
> "$output_file"

# Loop through each JPG file in the folder
for file in "$folder"/*.jpg; do
    # Convert filename to lowercase for case-insensitive comparison
    lowercase_file=$(basename "$file" | tr '[:upper:]' '[:lower:]')
    
    # Write file line to instructions.txt
    echo "file '$file'" >> "$output_file"
    
    # Write duration line to instructions.txt
    echo "duration $duration" >> "$output_file"
done

cat $output_file

