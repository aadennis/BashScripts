#!/bin/bash

# Define output files
output_file="/mnt/c/temp/mystuff.json"
index_file="/mnt/c/temp/music_index.json"

# Initialize or load existing index
declare -A folder_dict
if [[ -f "$index_file" ]]; then
    folder_dict=($(jq -r 'to_entries | map("\(.value)=\(.key)") | .[]' "$index_file"))
fi

counter=$(printf "%03d" $((${#folder_dict[@]} + 1)))

# Initialize JSON files
echo -n "{}" > "$index_file"
echo -n "[]" > "$output_file"

# Process mp3 files
find /mnt/d -type f -name "*.mp3" ! -name "\$*" 2>/dev/null | while read -r file; do
    folder_path=$(dirname "$file")
    file_name=$(basename "$file")

    # Assign a key if the folder is new
    if [[ -z "${folder_dict[$folder_path]}" ]]; then
        key=$(printf "%03d" $((10#$counter)))
        folder_dict["$folder_path"]=$key
        counter=$(printf "%03d" $((10#$counter + 1)))
        jq --arg key "$key" --arg path "$folder_path" '. + {($key): $path}' "$index_file" > tmp.json && mv tmp.json "$index_file"
    else
        key=${folder_dict[$folder_path]}
    fi

    # Append to output JSON
    jq --arg key "$key" --arg file "$file_name" '. + [{"key": $key, "file": $file}]' "$output_file" > tmp.json && mv tmp.json "$output_file"
<<<<<<< HEAD
done
=======
done
>>>>>>> b4816a7e1070c328364c7368c2fbb45c559d29e3
