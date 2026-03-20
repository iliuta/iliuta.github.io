#!/bin/bash

# App Store Video Processor with Presets
# Quick wrapper with predefined iPhone/iPad dimensions

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROCESSOR="$SCRIPT_DIR/process_appstore_video.sh"

# Check if processor script exists
if [[ ! -f "$PROCESSOR" ]]; then
    echo "Error: process_appstore_video.sh not found in $SCRIPT_DIR"
    exit 1
fi

# Show usage if no arguments
if [[ $# -eq 0 ]]; then
    echo "App Store Video Processor - Quick Presets"
    echo ""
    echo "Usage: $0 <preset> <input_file> [output_basename]"
    echo ""
    echo "Presets:"
    echo "  iphone     1920x886"
    echo "  ipad       1200x1600"
    echo ""
    echo "Examples:"
    echo "  $0 iphone rowertrain-demo-iphone.mov"
    echo "  $0 ipad rowertrain-demo-ipad.mov rowertrain-demo-ipad-1200x1600"
    echo ""
    exit 0
fi

PRESET="$1"
INPUT_FILE="$2"
OUTPUT_BASENAME="$3"

case "$PRESET" in
    iphone)
        if [[ -z "$OUTPUT_BASENAME" ]]; then
            OUTPUT_BASENAME="${INPUT_FILE%.*}-1920x886"
        fi
        "$PROCESSOR" "$INPUT_FILE" 1920 886 "$OUTPUT_BASENAME"
        ;;
    ipad)
        if [[ -z "$OUTPUT_BASENAME" ]]; then
            OUTPUT_BASENAME="${INPUT_FILE%.*}-1200x1600"
        fi
        "$PROCESSOR" "$INPUT_FILE" 1200 1600 "$OUTPUT_BASENAME"
        ;;
    *)
        echo "Unknown preset: $PRESET"
        echo "Available presets: iphone, ipad"
        exit 1
        ;;
esac
