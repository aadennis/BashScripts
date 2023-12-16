#!/bin/zsh
# How to iterate through an array of filenames

echo "file 1 content" > /Users/den/git/BashScripts/ffmpeg/openai/file1.txt
echo "file 2 content" > /Users/den/git/BashScripts/ffmpeg/openai/file2.txt
echo "file 3 content" > /Users/den/git/BashScripts/ffmpeg/openai/file3.txt
echo "file 4 content" > /Users/den/git/BashScripts/ffmpeg/openai/file4.txt

file_list=($(find /Users/den/git/BashScripts/ffmpeg/openai -iname "*.txt" | sort))
echo "${file_list[@]}"
for i in "${file_list[@]}"; do
    if [ -f "$i" ]; then
        cat "$i"
    else
        echo "File not found: $i"
    fi
done

