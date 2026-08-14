#!/bin/bash

# 1. OPTIMIZE VIDEOS (MP4 -> WebM + Poster)
echo "--- Starting Video Optimization ---"

# Find all .mp4 files recursively
find . -type f -name "*.mp4" | while read -r video; do
    # Get the file name without extension (e.g., "video" instead of "video.mp4")
    base_name="${video%.*}"
    webm_output="${base_name}.webm"
    poster_output="${base_name}_poster.jpg"

    # Only run if the WebM doesn't exist yet
    if [ ! -f "$webm_output" ]; then
        echo "Processing: $video"

        # 1. Create WebM (Compressed, No Audio, Resized to 720p)
        # -nostdin is crucial in loops to prevent FFmpeg from swallowing input
        ffmpeg -nostdin -y -i "$video" -c:v libvpx-vp9 -b:v 0 -crf 30 -an -vf "scale=1280:-2" "$webm_output" -loglevel error
        # ffmpeg -nostdin -y -i "$video" -c:v libvpx-vp9 -b:v 0 -crf 30 -vf "scale=1280:-2" "$webm_output" -loglevel error
        echo "  [OK] WebM created"

        # 2. Create Poster Image (First Frame)
        ffmpeg -nostdin -y -i "$video" -vframes 1 -q:v 2 "$poster_output" -loglevel error
        echo "  [OK] Poster created"
    else
        echo "Skipping: $video (Already optimized)"
    fi
done


# 2. OPTIMIZE IMAGES (JPG/PNG -> WebP)
echo -e "\n--- Starting Image Optimization ---"

# Find all jpg, jpeg, and png files recursively
find . -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) | while read -r img; do
    
    # Skip the poster images we just created to avoid double processing
    if [[ "$img" == *"_poster.jpg" ]]; then
        continue
    fi

    base_name="${img%.*}"
    webp_output="${base_name}.webp"

    # Only run if WebP doesn't exist yet
    if [ ! -f "$webp_output" ]; then
        echo "Processing: $img"

        # Convert to WebP (Quality 75, Resize max width to 1920px)
        ffmpeg -nostdin -y -i "$img" -c:v libwebp -q:v 75 -compression_level 6 -vf "scale='min(1920,iw)':-1" "$webp_output" -loglevel error
        echo "  [OK] Converted to WebP"
    fi
done

echo -e "\nDone! All assets are optimized."
