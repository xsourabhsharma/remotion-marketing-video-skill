# Local AI Powerups for Remotion

This playbook contains the integration rules for using free, local open-source models to handle high-volume video automation (transcription and voice cloning).

---

## 1. Local Transcription (Faster-Whisper)
Use this to get free, unlimited word-level timestamps without API costs.

### Installation
```bash
pip install faster-whisper
```

### Automation Script (Python)
Save as `transcribe_to_frames.py`:
```python
import json
from faster_whisper import WhisperModel

model = WhisperModel("small", device="cpu", compute_type="int8")
segments, info = model.transcribe("public/video.mp4", task="translate", word_timestamps=True)

words_data = []
for segment in segments:
    for word in segment.words:
        words_data.append({
            "word": word.word.strip(),
            "startFrame": round(word.start * 30), # Assuming 30fps
            "endFrame": round(word.end * 30)
        })

with open("src/transcript.json", "w") as f:
    json.dump(words_data, f, indent=2)
```

---

## 2. Local Voice Cloning (Chatterbox)
Use this for high-end, zero-shot voice cloning (cloning a voice from 5s of audio).

### Installation
```bash
git clone https://github.com/resemble-ai/chatterbox
pip install chatterbox-tts
```

### Usage
Run the local server:
```bash
python chatterbox/gradio_tts_turbo_app.py
```
Then use the Gradio API or Web UI to generate `.wav` files and drop them into your Remotion `public/` folder.

---

## 3. High-Readability Subtitle Engine
Use this React component for a modern "Shorts/Reels" style subtitle engine that builds up context.

```tsx
export const CinematicSubtitle = ({ words }) => {
  const frame = useCurrentFrame();
  const LINGER_FRAMES = 45; // keep words on screen for 1.5s after spoken

  return (
    <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'center' }}>
      {words.map((w, i) => {
        if (frame < w.startFrame || frame > w.endFrame + LINGER_FRAMES) return null;
        const isActive = frame >= w.startFrame && frame <= w.endFrame;

        return (
          <span style={{
            fontSize: '46px',
            fontWeight: 900,
            textTransform: 'uppercase',
            color: isActive ? '#000' : 'rgba(0,0,0,0.6)',
            backgroundColor: isActive ? '#FFF' : 'transparent',
            padding: '4px 16px',
            borderRadius: '12px',
            textShadow: isActive ? 'none' : '0 0 2px #FFF, 0 0 4px #FFF'
          }}>
            {w.word}
          </span>
        );
      })}
    </div>
  );
};
```
