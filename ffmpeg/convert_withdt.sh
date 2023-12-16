#!/bin/zsh
# Given an image file, extract its exif datetime info.
# Display that info on a copy of the input file, and
# save to a new file.

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <absolute_path_to_image_file>"
    exit 1
fi
image_file="$1"

if [ ! -f "$image_file" ]; then
    echo "Error: Image file '$image_file' not found."
    exit 1
fi


# Assign the argument to a variable
datetime=$(exiftool -s3 -d "%Y%m%d_%H%M%S" -DateTimeOriginal "$image_file")
new_filename="../test_output/${image_file}_with_datetime.jpg"
drawtext_action="drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:fontsize=24:fontcolor=white:x=10:y=h-text_h-10:text='$datetime'"
ffmpeg -i "$image_file" -vf $drawtext_action "$new_filename"
