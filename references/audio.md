# Audio & Sound Design Reference — Remotion Product Demo

Sound design is what separates a "meh" demo from a professional one. Every visual beat needs audio.

---

## Audio File Checklist

Collect these before starting:
- `click.mp3` — short UI click (8–15ms) — download from freesound.org or zapsplat.com
- `whoosh.mp3` — scene transition swoosh (200–400ms)
- `pop.mp3` — element appearing (short, snappy)
- `success.mp3` — task complete / checkmark sound
- `ambient.mp3` — background music loop (lo-fi, electronic, or minimal piano)
- `keyboard.mp3` (optional) — typing sounds layered under typewriter effect

Free sources: **Freesound.org**, **Zapsplat.com**, **Pixabay audio**

---

## Basic Audio Usage in Remotion

```tsx
import { Audio, staticFile, Sequence } from 'remotion';

// Play ambient music throughout (loop not supported natively — use long file)
<Audio src={staticFile('audio/ambient.mp3')} volume={0.25} />

// Play SFX at specific frame using Sequence
<Sequence from={clickFrame} durationInFrames={24}>
  <Audio src={staticFile('audio/click.mp3')} volume={0.9} />
</Sequence>
```

---

## Sound Map Pattern

Create a sound map alongside your scene timing sheet:

```tsx
// soundMap.ts — define all sounds with their trigger frames
export const soundMap = [
  { frame: 8,   src: 'audio/pop.mp3',     volume: 0.8 },   // card appears
  { frame: 60,  src: 'audio/click.mp3',   volume: 1.0 },   // send button click
  { frame: 72,  src: 'audio/whoosh.mp3',  volume: 0.6 },   // scene transition
  { frame: 96,  src: 'audio/pop.mp3',     volume: 0.7 },   // UI panel appears
  { frame: 130, src: 'audio/click.mp3',   volume: 1.0 },   // sidebar click
  { frame: 168, src: 'audio/success.mp3', volume: 0.9 },   // feature complete
  { frame: 240, src: 'audio/whoosh.mp3',  volume: 0.6 },   // scene transition
];

// In your main video component:
{soundMap.map((sound, i) => (
  <Sequence key={i} from={sound.frame} durationInFrames={48}>
    <Audio src={staticFile(sound.src)} volume={sound.volume} />
  </Sequence>
))}
```

---

## Volume Fade In / Out for Music

```tsx
import { interpolate } from 'remotion';

const FADE_IN_FRAMES = 24;
const FADE_OUT_FRAMES = 48;
const totalFrames = 1440; // your total duration

const musicVolume = frame < FADE_IN_FRAMES
  ? interpolate(frame, [0, FADE_IN_FRAMES], [0, 0.25])
  : frame > totalFrames - FADE_OUT_FRAMES
  ? interpolate(frame, [totalFrames - FADE_OUT_FRAMES, totalFrames], [0.25, 0])
  : 0.25;

<Audio src={staticFile('audio/ambient.mp3')} volume={musicVolume} />
```

---

## Typing Sound (keyboard clicks while text types)

```tsx
// Play a soft click every few frames while typing is happening
const TYPING_START = 8;
const TYPING_END = 72;
const CLICK_INTERVAL = 3; // every 3 frames = ~8 clicks/second

{Array.from({ length: Math.floor((TYPING_END - TYPING_START) / CLICK_INTERVAL) }).map((_, i) => {
  const triggerFrame = TYPING_START + i * CLICK_INTERVAL;
  return (
    <Sequence key={i} from={triggerFrame} durationInFrames={6}>
      <Audio src={staticFile('audio/keyboard.mp3')} volume={0.15} />
    </Sequence>
  );
})}
```

---

## Audio Tips

- **Ambient music**: keep volume 20–30% (`volume={0.2}` to `volume={0.3}`)
- **Click SFX**: 80–100% volume — these should be crisp and audible
- **Whoosh transitions**: 50–70% volume
- **Never overlap two loud SFX** within 12 frames of each other
- **Sync SFX to the exact visual frame** — even 4 frames off feels wrong
- **Use short files** — Remotion loads each audio on every render frame; huge files slow preview
- **Mono SFX** render faster than stereo for short sounds

---

## Recommended Free Music Tracks for Demo Videos

Style to search on YouTube/Looperman/Pixabay:
- "minimal electronic ambient"
- "lo-fi tech background"
- "soft synth pad"
- "corporate modern background music"

Avoid anything with obvious melody — it distracts from the UI.
