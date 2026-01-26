#!/bin/bash

# Define how many videos to process at the same time
# For 20 cores, running 3-4 videos simultaneously is usually the sweet spot 
# because each individual ffmpeg process will also use multiple threads.
MAX_JOBS=4

echo "--- Utilizing 20 Cores: Maximum Throughput Mode ---"

# Function to handle the conversion
convert_video() {
    video=$1
    base_name="${video%.*}"
    webm_output="${base_name}.webm"

    if [ ! -f "$webm_output" ]; then
        echo "Starting: $video"

        # -threads 8: Limits each process slightly so they don't fight each other
        # -row-mt 1: Critical for VP9 multi-threading
        # -crf 18: High Quality
        ffmpeg -nostdin -y -i "$video" \
            -c:v libvpx-vp9 -b:v 0 -crf 18 \
            -threads 8 \
            -row-mt 1 \
            -deadline realtime \
            -cpu-used 4 \
            -c:a libopus -b:a 128k \
            -reserve_index_space 100k \
            -vf "scale=1280:-2" \
            "$webm_output" -loglevel error
        
        echo "  [DONE] $video -> $webm_output"
    fi
}

# Export the function so subshells can see it
export -f convert_video

# Find videos and run them through 'xargs' to manage parallel jobs
find . -type f -name "*.mp4" | xargs -I {} -P "$MAX_JOBS" bash -c 'convert_video "{}"'

echo -e "\nAll tasks complete. Your 20-core CPU just saved you a lot of time!"
