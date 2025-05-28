# DISCARD - TOO HARD TO GET AUTHENTICATION WORKING
#!/bin/bash
# Given a sample URL from Google Takeout, this script generates all URLs
# for the export files by incrementing the index `i` from 0 to 227.
# Sample URL format:
# https://takeout.google.com/download/export?format=zip&i=154&user=ABCDEF123456789
# Example usage:
# ./google_takeout.sh


sample='https://takeout.google.com/download/export?format=zip&i=154&user=ABCDEF123456789'
sample='https://takeout.google.com/takeout/download?j=a39af998-WvnLxgAykYvoOFO9AbJ-jCPhuHMMMGgaVUED4KVFBVh3GejuR2T-ffAhEGjShsbgM0'

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
