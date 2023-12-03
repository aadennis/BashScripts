#!/bin/bash

opening_title="This is a test"

# Generate opening credits video with the provided title
#ffmpeg -f lavfi -t 3 -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf "drawtext=text='${opening_title}':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=(h-text_h)/2" opening_xcredits.mp4
#ffmpeg -f lavfi -t 3 -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf "drawtext=text='${opening_title}':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=(h-text_h)/2" -c:v libx264 -r 30 -pix_fmt yuv420p opening_scredits.mp4
#ffmpeg -f lavfi -t 3 -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf "drawtext=text='${opening_title}':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=(h-text_h)/2" -c:v libx264 -r 30 -pix_fmt yuv420p -an opening_pcredits.mp4
#ffmpeg -f lavfi -t 3 -i anullsrc=channel_layout=stereo:sample_rate=44100 -vf "drawtext=text='${opening_title}':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=(h-text_h)/2" -c:v libx264 -r 30 -pix_fmt yuv420p -c:a null -an popening_credits.mp4
 ffmpeg -f lavfi -i color=size=320x240:duration=10:rate=25:color=blue -vf "drawtext=fontfile=/path/to/font.ttf:fontsize=30:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2:text='Stack Overflow'" xxoutput.mp4