# Concat a set of existing mp4s to a single mp4.
# -safe 0 : allow relative paths
# -f concat : action to take
# -r : what rate do you want the video played at?
# So if you have 5 videos, each of 10 seconds, total of 50 seconds.
# Say you use -r 0.5 (see rate below), then the single video would play for 50 * 0.5
# seconds = 25 seconds.
# Therefore the issue needs fixing upstream, so that the individual
# videos only play for say 1 second. After all, they are just an image.
no_of_videos=$(wc -l < ./inst_vid.txt)
echo "no_of_videos: $no_of_videos"
rate=0.5
ffmpeg -safe 0 -f concat -r "$rate" -i ./inst_vid.txt outputy.mp4