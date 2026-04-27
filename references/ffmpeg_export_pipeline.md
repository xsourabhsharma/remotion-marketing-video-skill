# FFmpeg Export & Processing Pipeline

After rendering a video with Remotion, use FFmpeg to ensure the output meets the technical specifications required for high-quality web distribution (X/Twitter, LinkedIn, YouTube).

## 1. Encoding Baseline
All major SaaS ads target these specifications:
- **Resolution:** 1920x1080 (16:9 Landscape) or 1080x1920 (9:16 Portrait).
- **Frame Rate:** 25 fps progressive (or 30 fps depending on Remotion config).
- **Video Codec:** H.264 (libx264).
- **Audio Codec:** AAC stereo.
- **Bitrate:** ~1.2 Mbps to ~2.1 Mbps video, 128 kbps audio.
- **Container:** MP4.

## 2. Useful FFmpeg Commands

### Structural Inspection (QA)
Use `ffprobe` to verify the resolution, codec, and bitrate of the rendered video:
```bash
ffprobe -v quiet -print_format json -show_format -show_streams out/demo.mp4
```

### Thumbnail Extraction
Extract keyframes to use as YouTube/social thumbnails or for documentation:
```bash
# Extract a frame at the 5-second mark
ffmpeg -ss 5 -i out/demo.mp4 -frames:v 1 thumb_005s.png
```

### Re-encoding to Target Spec
If Remotion's default output is too large (e.g., ProRes) or needs strict bitrate control for web delivery, re-encode it:
```bash
ffmpeg -i out/demo.mp4 -c:v libx264 -profile:v high -level 4.0 -pix_fmt yuv420p -r 25 -b:v 2000k -c:a aac -b:a 128k -ar 44100 final_web_ad.mp4
```

## 3. Automation Script
You can automate this pipeline using a Node.js script or PowerShell script that takes the Remotion output, runs the `ffprobe` inspection, extracts a thumbnail at a key moment (like the product reveal), and re-encodes if necessary.
