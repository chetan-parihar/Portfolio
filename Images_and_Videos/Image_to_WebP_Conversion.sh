#!/bin/bash

echo "--- Starting Portfolio Image Optimization ---"

# Using -iname to be case-insensitive and handling spaces with "read -r"
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r img; do

    # Skip the script itself if it matches the pattern
    if [[ "$img" == *"Image_to_WebP_Conversion.sh"* ]]; then
        continue
    fi

    # Extract name without extension
    base_name="${img%.*}"
    webp_output="${base_name}.webp"

    # Convert if WebP doesn't exist
    if [ ! -f "$webp_output" ]; then
        echo "Processing: $img"
        
        # We use " " around variables to handle the spaces in your screenshot names
        ffmpeg -nostdin -y -i "$img" -c:v libwebp -q:v 75 -compression_level 6 "$webp_output" -loglevel error
        
        echo "  [OK] Created: $(basename "$webp_output")"
    else
        echo "Skipping: $img (Already converted)"
    fi
done

echo -e "\nConversion Complete! You can now see the .webp files using 'ls'."
