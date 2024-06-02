#!/bin/bash
#!/bin/bash

# Check if a filename has been passed
if [ -z "$1" ]; then
    echo "Error: No filename provided."
    echo "Usage: ./scriptname.sh filename"
    exit 1
fi

# Input file
input_file=$1

# Check if the file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Generate output file name
output_file="${input_file%.txt}.stripped.txt"

# Use awk to remove lines starting with a percentage
awk '!($1 ~ /^ {0,2}[0-9]+(\.[0-9])?%$/)' "$input_file" > "$output_file"
