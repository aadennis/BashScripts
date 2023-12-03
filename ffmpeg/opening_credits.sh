#!/bin/bash

opening_title="This is a test"

# Generate opening credits video with the provided title
ffmpeg -f lavfi -t 3 -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf "drawtext=text='${opening_title}':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=(h-text_h)/2" opening_xcredits.mp4
#ffmpeg -f lavfi -t 3 -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf "drawtext=text='${opening_title}':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=(h-text_h)/2" -c:v libx264 -r 30 -pix_fmt yuv420p opening_credits.mp4