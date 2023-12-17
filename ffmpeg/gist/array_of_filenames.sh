#!/bin/zsh
# How to iterate through an array of filenames

workdir="/Users/den/git/BashScripts/ffmpeg/openai"

# next is same as 
# for i in 1 2 3 4; do
for i in {1..4}; do
    echo "file$i content" > $workdir/file$i.txt
done

file_list=($(find $workdir -iname "*.txt" | sort))
echo "${file_list[@]}"
for i in "${file_list[@]}"; do
    if [ -f "$i" ]; then
        cat "$i"
    else
        echo "File not found: $i"
    fi
done

