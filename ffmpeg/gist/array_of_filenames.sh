#!/bin/zsh
# How to iterate through an array of filenames

working_dir="/Users/den/git/BashScripts/ffmpeg/openai"
echo "file 1 content" > $working_dir/file1.txt
echo "file 2 content" > $working_dir/file2.txt
echo "file 3 content" > $working_dir/file3.txt
echo "file 4 content" > $working_dir/file4.txt

file_list=($(find $working_dir -iname "*.txt" | sort))
echo "${file_list[@]}"
for i in "${file_list[@]}"; do
    if [ -f "$i" ]; then
        cat "$i"
    else
        echo "File not found: $i"
    fi
done

