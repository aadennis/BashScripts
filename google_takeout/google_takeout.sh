#!/bin/bash
# Given a sample URL from Google Takeout, this script generates all URLs
# for the export files by incrementing the index `i` from 0 to 227.
# Sample URL format:
# https://takeout.google.com/download/export?format=zip&i=154&user=ABCDEF123456789
# Example usage:
# ./google_takeout.sh

sample='https://takeout.google.com/download/export?format=zip&i=154&user=ABCDEF123456789'

# Use bash parameter expansion to extract parts around `i=`
prefix="${sample%%i=*}i="
number_and_suffix="${sample#*i=}"
number="${number_and_suffix%%&*}"
suffix="${number_and_suffix#${number}}"

# Generate all 228 URLs
for i in $(seq 0 227); do
    echo "${prefix}${i}${suffix}"
done > urls.txt
