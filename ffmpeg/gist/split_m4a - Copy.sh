#!/bin/bash
# Split a sound file of a given type, into n parts of the same type 
# For example, m4a, mp3, etc.
# Example usage
# ./split_m4a.sh /mnt/c/temp/Lesson_6/Lesson_6.m4a

# Input file
input_file="$1"
file_type="$2" # include the dot for now, e.g. .m4a
number_of_parts="$3"

# Extract the base name (without extension) from the input file
base_name=$(basename "$input_file" "$file_type")

# Get the total duration of the file in seconds
duration=$(ffmpeg -i "$input_file" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d , | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')

# Calculate the duration of each part (divide by 4)
part_duration=$(echo "$duration / 4" | bc)

# Loop to create $number_of_parts (see above) parts
for i in {0..$number_of_parts}; do
  start_time=$(echo "$i * $part_duration" | bc)
  
  # Zero-padded index for the file name
  part_num=$(printf "%02d" $(($i + 1)))
  
  # Output file name
  output_file="${base_name}_${part_num}${file_type}"
  
  ffmpeg -i "$input_file" -ss "$start_time" -t "$part_duration" -c copy "$output_file"
done

echo "Splitting complete!"

