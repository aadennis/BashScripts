#!/bin/bash

# Input file
input_file="$1"

# Extract the base name (without extension) from the input file
base_name=$(basename "$input_file" .m4a)

# Get the total duration of the file in seconds
duration=$(ffmpeg -i "$input_file" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d , | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')

# Calculate the duration of each part (divide by 4)
part_duration=$(echo "$duration / 4" | bc)

# Loop to create 4 parts
for i in {0..3}; do
  start_time=$(echo "$i * $part_duration" | bc)
  
  # Zero-padded index for the file name
  part_num=$(printf "%02d" $(($i + 1)))
  
  # Output file name
  output_file="${base_name}_${part_num}.m4a"
  
  ffmpeg -i "$input_file" -ss "$start_time" -t "$part_duration" -c copy "$output_file"
done

echo "Splitting complete!"

