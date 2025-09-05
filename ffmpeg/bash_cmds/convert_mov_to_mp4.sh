f="test_artifacts/temp_assets/x_8263.MOV"

ffmpeg -i "$f" "${f%.*}_$((RANDOM+RANDOM)).mp4"

