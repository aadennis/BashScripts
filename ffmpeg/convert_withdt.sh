#!/bin/zsh

clear


image_folder="test_artifacts"
cd test_artifacts  # Change directory to where the images are located
pwd


# Find all JPG files in the specified folder
# find_result=find "$image_folder" -iname '*.jpg'
image_list=$(find "." -iname '*1.jpg')
# echo $image_list
echo "point 1"
read x

# in the next, xxxx only prints out on the first iteration?!
for image_file in $image_list; do
    x=$(echo "point 1:" $image_file)
    echo "$x"
done


ls -l
read dd

# Loop through each image file
for image_file in $image_list; do
   
    echo "point 2a"
    # Extract the creation date and time using exiftool
    # fp="/Users/den/git/BashScripts/ffmpeg/test_artifacts/IMG_0001.JPG"
    datetime=$(exiftool -s3 -d "%Y%m%d_%H%M%S" -DateTimeOriginal "$image_file")
    echo "point 2b"
    read line
    # Generate the new filename with datetime suffix
    new_filename="../test_output/${image_file%.*}_with_datetime.jpg"
    echo "about to create new file"
    # Use ffmpeg to copy the image and add a timestamp
    drawtext_action="drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:fontsize=24:fontcolor=white:x=10:y=h-text_h-10:text='$datetime'"
    ffmpeg -i "$image_file" -vf $drawtext_action "$new_filename"
done
