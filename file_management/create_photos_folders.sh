#!/bin/bash

# Path to the main folder
main_folder="D:/onedrive/photos"

# Loop through each year folder
for year_folder in "$main_folder"/*; do
    # Check if the item is a directory
    if [ -d "$year_folder" ]; then
        # Loop through each month subfolder
        for month_folder in "$year_folder"/*; do
            # Check if the item is a directory
            if [ -d "$month_folder" ]; then
                # Extract the year and month from the folder name
                folder_name=$(basename "$month_folder")
                year=$(echo "$folder_name" | cut -d '_' -f 1)
                month=$(echo "$folder_name" | cut -d '_' -f 2)
                
                # Create the _Photos subfolder if it doesn't exist
                if [ ! -d "$month_folder/_Photos" ]; then
                    mkdir "$month_folder/_Photos"
                    echo "Created _Photos folder in $folder_name"
                else
                    echo "_Photos folder already exists in $folder_name"
                fi
            fi
        done
    fi
done
