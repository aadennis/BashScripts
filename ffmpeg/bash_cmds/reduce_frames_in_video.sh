#!/bin/bash

# Usage: ./extract_nth_frames.sh <source_folder> <source_file> [nth_frame]
# Example: ./extract_nth_frames.sh "/mnt/c/Videos" "abc.avi" 60

# --- Argument parsing ---
SOURCE_FOLDER="$1"
SOURCE_FILE="$2"
NTH_FRAME="${3:-60}"  # Default to 60 if not provided

# --- Path setup ---
BASENAME="${SOURCE_FILE%.*}"
EXT="${SOURCE_FILE##*.}"
RAND_INT=$((RANDOM % 9000 + 1000))
OUTPUT_FILE="${BASENAME}_${RAND_INT}.${EXT}"
TEMP_DIR="${SOURCE_FOLDER}/frames_${RAND_INT}"

mkdir -p "$TEMP_DIR"

# --- Step 1: Extract every nth frame ---
ffmpeg -i "${SOURCE_FOLDER}/${SOURCE_FILE}" \
  -vf "select='not(mod(n\,${NTH_FRAME}))'" \
  -vsync vfr \
  "${TEMP_DIR}/frame_%04d.png"

# --- Step 2: Rebuild video from frames ---
ffmpeg -framerate 25 \
  -i "${TEMP_DIR}/frame_%04d.png" \
  -c:v libx264 \
  -r 25 \
  -pix_fmt yuv420p \
  "${SOURCE_FOLDER}/${OUTPUT_FILE}"

# --- Optional cleanup ---
rm -rf "$TEMP_DIR"

echo "✅ Output saved to: ${SOURCE_FOLDER}/${OUTPUT_FILE}"
