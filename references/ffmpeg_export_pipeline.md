# Rendering, Encoding, and QA Reference

Use this file when exporting, inspecting, compressing, or preparing videos for platforms.

## Remotion Render

Basic render:

```bash
npx remotion render src/index.ts ProductDemo out/product-demo.mp4 --codec=h264
```

Only run the complete final render after the user approves the local preview and confirms the output path. Before approval, use stills and short frame ranges only.

Fast still check:

```bash
npx remotion still ProductDemo --frame=90 --scale=0.25
```

Short range check:

```bash
npx remotion render src/index.ts ProductDemo out/check.mp4 --frames=0-180 --codec=h264 --scale=0.5
```

Use JSON props from a file on Windows:

```bash
npx remotion render src/index.ts ProductDemo out/demo.mp4 --props=./props.json
```

## Output Presets

| Target | Size | FPS | Notes |
| --- | --- | --- | --- |
| Web/SaaS landing | `1920x1080` | `30` | Default product demo format |
| LinkedIn landscape | `1920x1080` | `30` | Strong for B2B feed and ads |
| LinkedIn vertical | `1080x1350` or `1080x1920` | `30` | `4:5` often works well in feed; `9:16` for vertical |
| YouTube standard | `1920x1080` | `24/30/60` | H.264 MP4, progressive |
| YouTube Shorts | `1080x1920` or square | `30/60` | Square or vertical up to three minutes is categorized as Shorts |
| Reels/Shorts/TikTok style | `1080x1920` | `30` | Keep important text away from app UI overlays |

## Encoding Guidance

Remotion's default H.264 MP4 is usually enough. For web/social delivery, prefer:

- Container: MP4
- Video codec: H.264
- Pixel format: `yuv420p`
- Audio codec: AAC
- Audio sample rate: `48kHz` where possible
- Color: SDR/BT.709 unless HDR is intentional

For YouTube 1080p SDR uploads, YouTube recommends H.264, progressive scan, 4:2:0 chroma subsampling, same frame rate as source, and roughly `8 Mbps` for standard frame rate 1080p.

## Probe Output

```bash
npx remotion ffprobe -v quiet -print_format json -show_format -show_streams out/product-demo.mp4
```

Check:

- Width and height
- Frame rate
- Duration
- Codec
- Audio stream presence
- File size
- Pixel format

## Editing Helpers

Use FFmpeg for practical editing support around a Remotion composition:

```bash
# Extract a clip for the target project
ffmpeg -ss 00:00:12 -to 00:00:27 -i source.mp4 -c copy public/footage/clip-01.mp4

# Extract audio for transcription
ffmpeg -i source.mp4 -vn -ac 1 -ar 16000 public/audio/dialogue.wav

# Create thumbnails for planning
ffmpeg -i source.mp4 -vf fps=1 public/stills/frame-%04d.jpg
```

Keep extracted media in the target video project, not in this skill repository.

## Optional Re-encode

Use only when a platform requires stricter compatibility or smaller files:

```bash
npx remotion ffmpeg -i out/product-demo.mp4 -c:v libx264 -profile:v high -pix_fmt yuv420p -movflags +faststart -c:a aac -ar 48000 -b:a 192k out/product-demo-web.mp4
```

## Visual QA Checklist

- No blank frames at scene boundaries.
- No text overlap at target aspect ratio.
- Captions stay in safe areas.
- Cursor does not cover critical labels.
- Fast effects do not flicker or strobe.
- UI remains readable at mobile preview size for vertical output.
- Rendered file opens in a normal video player.
