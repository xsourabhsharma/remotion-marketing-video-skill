# Local AI Integration Reference

Use this file when transcription, subtitle timing, or generated voiceover is requested. Keep all generated media in the user's target video project, not in this skill repository.

## Local Transcription

Use `faster-whisper` for local word timings when a voiceover or screen recording already exists.

```bash
uv pip install faster-whisper
```

Example script for a target project:

```python
import json
from faster_whisper import WhisperModel

FPS = 30
INPUT = "public/audio/voiceover.wav"
OUTPUT = "src/data/transcript.json"

model = WhisperModel("small", device="cpu", compute_type="int8")
segments, _ = model.transcribe(INPUT, word_timestamps=True)

words = []
for segment in segments:
    for word in segment.words or []:
        words.append({
            "word": word.word.strip(),
            "startFrame": round(word.start * FPS),
            "endFrame": round(word.end * FPS),
        })

with open(OUTPUT, "w", encoding="utf-8") as handle:
    json.dump(words, handle, indent=2)
```

## Voiceover Generation

Use local or API TTS only when the user requests narration. Store generated files in the target project's `public/audio/` folder. Add attribution or licensing notes when required by the chosen tool.

## Caption Build Order

1. Generate or obtain voiceover.
2. Transcribe to word timings.
3. Import transcript JSON into Remotion.
4. Render captions from frame ranges.
5. Still-check crowded frames.
6. Render a short range around fast speech.

## Safety Notes

- Do not clone voices without permission.
- Do not add generated audio to this skill repository.
- Do not commit `.env` files or API keys.
- Keep transcripts free of sensitive information unless the user explicitly wants them stored.
