#!/bin/bash
# Given a log file, copy it to an output file, first stripping
# out any lines where field 1 (1 based, and leading space-stripped) contains 
# the % symbol.
# The context for this is a Robocopy log file, where information about the 
# % processed of a given file can double the number of lines to read. I don't
# need that progress statement.
# The output file name is based on the name of the input file. For example, if the 
# input file is tiny.log.txt, the output filename will be generated as 
# tiny.log.stripped.txt


# Check if a filename has been passed
if [ -z "$1" ]; then
    echo "Error: No filename provided."
    echo "Usage: bash ./scriptname.sh input-filename"
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

# Only print the current line if the first field does NOT contain the % symbol
awk '!( $1 ~ /%/) {print}' "$input_file" > "$output_file"
