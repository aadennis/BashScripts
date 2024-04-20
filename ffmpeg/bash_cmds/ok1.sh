# Concat a set of existing mp4s to a single mp4.
# -safe 0 : allow relative paths
# -f concat : action to take
# -r 8 seems to mean fit it all into no. of vids / 8
# that is 4/8 = 0.5 seconds for each video
# and -r .5 says no. of vids / .5 = 4/.5 = 8 seconds per video
required_duration_per_video=2
no_of_videos=$(wc -l < ./inst_vid.txt)
r_arg=$((no_of_videos / required_duration_per_video))
echo "no_of_videos: $no_of_videos"
echo "required_duration_per_video: $required_duration_per_video"
echo "r_arg = no_of_videos / required_duration_per_video = $r_arg"

ffmpeg -safe 0 -f concat -r $r_arg -i ./inst_vid.txt outputy.mp4