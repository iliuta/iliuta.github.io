#!/bin/bash

# App Store Connect Video Processing Script
# Converts and resizes videos for App Store with proper audio handling
# Usage: ./process_appstore_video.sh <input.mov> <width> <height> [output_basename]

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print error and exit
error() {
    echo -e "${RED}ERROR: $1${NC}" >&2
    exit 1
}

# Function to print info
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

# Function to print warning
warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Check arguments
if [[ $# -lt 3 ]]; then
    echo "App Store Connect Video Processor"
    echo ""
    echo "Usage: $0 <input_file> <width> <height> [output_basename]"
    echo ""
    echo "Examples:"
    echo "  $0 rowertrain-demo-iphone.mov 1920 886 rowertrain-demo-iphone-1920x886"
    echo "  $0 rowertrain-demo-ipad.mov 1200 1600 rowertrain-demo-ipad-1200x1600"
    echo ""
    echo "Presets:"
    echo "  iPhone:  1920x886"
    echo "  iPad:    1200x1600"
    exit 1
fi

INPUT_FILE="$1"
WIDTH="$2"
HEIGHT="$3"
OUTPUT_BASENAME="${4:-${INPUT_FILE%.*}-${WIDTH}x${HEIGHT}}"

# Verify input file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    error "Input file not found: $INPUT_FILE"
fi

# Verify ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    error "ffmpeg is not installed. Please install it first."
fi

info "Processing video: $INPUT_FILE"
info "Target resolution: ${WIDTH}x${HEIGHT}"
info "Output basename: $OUTPUT_BASENAME"

# Create MOV version without audio
info "Creating MOV version (no audio)..."
OUTPUT_MOV="${OUTPUT_BASENAME}.mov"
ffmpeg -i "$INPUT_FILE" \
    -vf "scale=${WIDTH}:${HEIGHT}" \
    -c:v libx264 \
    -preset medium \
    -crf 23 \
    -movflags +faststart \
    -pix_fmt yuv420p \
    -an \
    "$OUTPUT_MOV"

if [[ $? -eq 0 ]]; then
    info "✓ Created: $OUTPUT_MOV"
else
    error "Failed to create MOV version"
fi

# Create MP4 version with silent audio (for App Store Connect)
info "Creating MP4 version (with silent audio for App Store)..."
OUTPUT_MP4="${OUTPUT_BASENAME}-with-audio.mp4"
ffmpeg -i "$INPUT_FILE" \
    -f lavfi -i anullsrc=r=48000:cl=mono \
    -c:v libx264 \
    -preset medium \
    -crf 23 \
    -c:a aac \
    -b:a 96k \
    -shortest \
    -vf "scale=${WIDTH}:${HEIGHT}" \
    "$OUTPUT_MP4"

if [[ $? -eq 0 ]]; then
    info "✓ Created: $OUTPUT_MP4"
else
    error "Failed to create MP4 version"
fi

# Print summary
echo ""
echo "=========================================="
echo -e "${GREEN}Processing Complete!${NC}"
echo "=========================================="
echo ""
echo "Files created:"
echo "  MOV (no audio):  $OUTPUT_MOV"
echo "  MP4 (App Store): $OUTPUT_MP4"
echo ""
echo "Recommended for App Store Connect:"
echo "  Upload: $OUTPUT_MP4"
echo ""
echo "Video Specifications:"
echo "  Resolution: ${WIDTH}x${HEIGHT}"
echo "  Codec: H.264"
echo "  Audio (MP4): Silent AAC (48kHz, mono, 96kbps)"
echo "=========================================="
