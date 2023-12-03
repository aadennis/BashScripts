#!/bin/bash
# Given an input wildcard, being the set of image files to be converted
# to a video, save that video in the location "output_wildcard"
# Example call
# ./convert.sh 'test_artifacts/*.JPG' 'test_artifacts/output3.mp4'


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_wildcard> <output_location>"
    exit 1
fi

ffmpeg -framerate 1/3 -pattern_type glob -i "$1" -c:v libx264 -r 30 -pix_fmt yuv420p "$2"