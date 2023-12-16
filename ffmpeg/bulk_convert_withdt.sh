#!/bin/zsh
# Add a timestamp to be printed on each image of the
# passed folder.
# Al the detail happens in the called script.
# This script must be executed in the folder ffmpeg, as
# it assumes a location for the output folder
# Example call:
# ./bulk_convert_withdt.sh test_artifacts
# where test_artifacts is the folder containing the original images

if [ $# -eq 0 ]; then
    echo "Usage: $0 <absolute_path_to_image_folder>"
    exit 1
fi
image_folder="$1"

if [ ! -d "$image_folder" ]; then
    echo "Error: Image folder '$image_folder' not found."
    exit 1
fi

pwd
content=($(find $image_folder -iname "*.JPG"))

echo $content
for image in "${content[@]}"; do
    ./convert_withdt.sh $image
done

# https://unix.stackexchange.com/questions/489334/case-insensitive-list-files-in-directory-ending-in-jpg