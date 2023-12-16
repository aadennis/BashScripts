#!/bin/zsh
# Given a single image file, extract its exif datetime info.
# Display that info on a copy of the input file, and
# save the original image, plus the timestamp overlay, to
#  a new file. 
# This script must be executed in the folder ffmpeg, as
# it assumes a location for the output folder

if [ $# -eq 0 ]; then
    echo "Usage: $0 <absolute_path_to_image_file>"
    exit 1
fi
image_folder="$1"

if [ ! -d "$image_folder" ]; then
    echo "Error: Image folder '$image_folder' not found."
    exit 1
fi

pwd
#  declare -a arr=("*.jpg" "*.JPG") 
# unsetopt CASE_GLOB - set this in ZSH
# for ext in "${arr[@]}"; do
echo "STARTING AGIN.........."
 for ext in "*.jpg" "*.JPG"; do
 
 for ext in "*.jpg" "*.JPG"; do
    a="$image_folder/$ext"
    a=$(find $image_folder -iname $ext)

    echo $a
    echo "c"
    for image in $a; do
    echo "baked"
        echo "$image"
        echo "beans"
        ./convert_withdt.sh $image
    done
done

# https://unix.stackexchange.com/questions/489334/case-insensitive-list-files-in-directory-ending-in-jpg