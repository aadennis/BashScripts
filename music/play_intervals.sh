#!/bin/bash

# Directory containing the MP3 files
DIR="."

# Get list of mp3 files
FILES=(${DIR}/*.mp3)

# Play files in random order until script is stopped
while true; do
  # Pick a random file
  FILE=${FILES[RANDOM % ${#FILES[@]}]}
  
  # Play the file
  echo $FILE
  mpg123 "$FILE"
done

