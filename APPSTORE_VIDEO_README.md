# App Store Connect Video Processing Scripts

Scripts to convert and resize videos for App Store Connect with proper audio handling.

## Requirements

- `ffmpeg` (with H.264 and AAC encoding support)

## Scripts

### 1. `appstore_video.sh` (Recommended - Easiest to use)

Quick wrapper with iPhone/iPad presets.

#### Usage

```bash
./appstore_video.sh <preset> <input_file> [output_basename]
```

#### Examples

```bash
# iPhone video (1920x886)
./appstore_video.sh iphone rowertrain-demo-iphone.mov

# iPad video (1200x1600)  
./appstore_video.sh ipad rowertrain-demo-ipad.mov

# Custom output name
./appstore_video.sh iphone myapp-iphone.mov custom-output-name
```

### 2. `process_appstore_video.sh` (Advanced - Custom dimensions)

Flexible script for any resolution.

#### Usage

```bash
./process_appstore_video.sh <input_file> <width> <height> [output_basename]
```

#### Examples

```bash
./process_appstore_video.sh rowertrain-demo-iphone.mov 1920 886 rowertrain-demo-iphone-1920x886
./process_appstore_video.sh rowertrain-demo-ipad.mov 1200 1600 rowertrain-demo-ipad-1200x1600
```

## Output

Both scripts create **two files** per input:

1. **`{basename}.mov`** - MOV format (no audio)
   - For reference/archival
   - H.264 codec, medium preset, CRF 23

2. **`{basename}-with-audio.mp4`** - MP4 format (silent audio)
   - **Recommended for App Store Connect**
   - H.264 codec
   - Silent AAC audio track (48kHz, mono, 96kbps)
   - Better for App Store validation

## App Store Connect Specifications

### iPhone Preset
- **Resolution:** 1920x886px (16:9 aspect ratio)
- **Use:** App Store preview video or demo
- **Output:** `rowertrain-demo-iphone-1920x886-with-audio.mp4`

### iPad Preset
- **Resolution:** 1200x1600px (3:4 aspect ratio)
- **Use:** iPad app preview or demo
- **Output:** `rowertrain-demo-ipad-1200x1600-with-audio.mp4`

## Technical Details

### Video Codec
- **Codec:** H.264 (AVC)
- **Profile:** High
- **Level:** 4.0-4.2
- **Preset:** Medium (balance between speed and compression)
- **CRF:** 23 (good quality)
- **Pixel Format:** yuv420p

### Audio Track (MP4 only)
- **Codec:** AAC
- **Sample Rate:** 48 kHz
- **Channels:** Mono
- **Bitrate:** 96 kbps
- **Type:** Silent/null source (anullsrc)

## Troubleshooting

### "ffmpeg not found"
Install ffmpeg:
```bash
# macOS with Homebrew
brew install ffmpeg

# Or download from https://ffmpeg.org/download.html
```

### Video upload rejected by App Store
Try uploading the MP4 version (with audio) instead of MOV. The silent audio track often resolves validation issues.

### "Input file not found"
Make sure the input file path is correct and the file exists in the current directory or use absolute path.

## Common Presets

| Device | resolution | Aspect Ratio | Preset |
|--------|-----------|--------------|--------|
| iPhone | 1920×886 | 16:9 | `iphone` |
| iPad | 1200×1600 | 3:4 | `ipad` |

## Notes

- Scripts process videos sequentially; multiple concurrent runs may compete for CPU resources
- Encoding times depend on video length and source resolution
- Output files will have the same frame rate as the input
- Audio track (in MP4) contains pure silence to satisfy App Store requirements
