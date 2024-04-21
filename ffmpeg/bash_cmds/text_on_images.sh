#!/bin/bash
# Given a folder containing a set of image files,
# create a copy of those files (same name but different
# folder), only adding the filename of each file as an
# overlay on the images

input_folder="test_artifacts"

# Output folder - this is no created at 
# runtime, so it must exist
output_folder="test_output" 

for image in "$input_folder"/*.JPG; do
    # Extract filename with extension
    filename=$(basename -- "$image")
    # (for no extension use...)
    # filename_no_ext="${filename%.*}"

    # Overlay image with filename
    ffmpeg -i "$image" -vf "drawtext=text='$filename':x=100:y=100:fontsize=50:fontcolor=black" "$output_folder/$filename"

    echo "Overlay added to $filename"
done

