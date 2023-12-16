#!/bin/zsh
# Given an image file, extract its exif datetime info.
# Display that info on a copy of the input file, and
# save to a new file.
# This script must be executed in the folder ffmpeg, as
# it assumes a location for the output folder.
# An example of the pattern of the new file name is
# oldfile.jpg -> oldfile_with_datetime.jpg
# Example call:
# ./convert_withdt.sh path_to_image.jpg
# Dependencies: 
# brew install libheif


if [ $# -eq 0 ]; then
    echo "Usage: $0 <absolute_path_to_image_file>"
    exit 1
fi

image_file="$1"

if [ ! -f "$image_file" ]; then
    echo "Error: Image file '$image_file' not found."
    exit 1
fi

output_folder="test_output"
datetime=$(exiftool -s3 -d "%Y%m%d_%H%M%S" -DateTimeOriginal "$image_file")
rootname=$(basename "$image_file" | tr '[:upper:]' '[:lower:]' | sed 's/\.[^.]*$//')
new_filename="test_output/${rootname}_with_datetime.jpg"

# Convert HEIC to JPEG using libheif tools
heif-convert "$image_file" "$new_filename"

# Add the text overlay using ffmpeg
drawtext_action="drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:fontsize=24:fontcolor=white:x=10:y=h-text_h-10:text='$datetime'"
ffmpeg -i "$new_filename" -vf "$drawtext_action" -y "$new_filename"
