#!/bin/bash
# Given a sample URL from Google Takeout, this script generates all URLs
# for the export files by incrementing the index `i` from 0 to 227.
# Sample URL format:
# https://takeout.google.com/download/export?format=zip&i=154&user=ABCDEF123456789
# Example usage:
# ./google_takeout.sh


sample='https://takeout.google.com/download/export?format=zip&i=154&user=ABCDEF123456789'
sample='https://takeout.google.com/takeout/download?j=a39af998-e2f5-4f8c-9408-a009f8e95a09&i=1&user=101930758947397193019&rapt=AEjHL4N9xepmDMvXABbe3SzWvnLxgAykYvoOFO9AbJ-jCPhuHMMMGgaVUED4KVFBVj5mNIeRc56-bWzZFAyb-ZhLMyXqV-Xh3GejuR2T-ffAhEGjShsbgM0'

# Parse the sample URL
prefix="${sample%%i=*}i="
number_and_suffix="${sample#*i=}"
number="${number_and_suffix%%&*}"
suffix="${number_and_suffix#${number}}"

# Output file
output="urls.txt"
> "$output"  # Clear or create the file

# Generate URLs and echo every 20th to screen
for i in $(seq 0 227); do
    url="${prefix}${i}${suffix}"
    echo "$url" >> "$output"
    
    if (( i % 20 == 0 )); then
        echo "[Progress] $url"
    fi
done

echo "Done. All URLs saved to $output."
