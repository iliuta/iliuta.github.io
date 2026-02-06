#!/bin/bash

# Script to remove alpha channels and transparency from PNG images in a directory
# Usage: ./remove_alpha.sh <directory>

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    echo "Example: $0 /path/to/images"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: $DIR is not a directory"
    exit 1
fi

echo "Processing PNG files in $DIR..."

cd "$DIR"

count=0
for file in *.png; do
    if [ -f "$file" ]; then
        echo "Removing alpha from $file"
        magick "$file" -alpha off "$file"
        count=$((count + 1))
    fi
done

echo "Processed $count PNG files. Alpha channels removed."

if [ $count -eq 0 ]; then
    echo "No PNG files found in $DIR"
fi