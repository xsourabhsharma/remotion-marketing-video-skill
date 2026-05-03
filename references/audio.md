# Audio, SFX, and Captions Reference

Use this file when adding voiceover, sound effects, music beds, subtitles, or transcript-timed captions. This skill must not include bundled media files. Accept user-provided or generated audio in the target Remotion project only when requested.

## Audio Strategy

Choose one of three modes:

- Silent motion graphic: rely on strong visual rhythm and captions.
- SFX-only demo: add minimal click, switch, whoosh, and success sounds at interaction frames.
- Voiceover-led video: drive scene timing from transcript or word timings.

Avoid unlicensed music and stock audio. Keep all media in the user's Remotion project, not in this skill.

## Remotion Audio

Use `@remotion/media` for media tags in modern projects:

```tsx
import {Audio} from "@remotion/media";
import {Sequence, staticFile} from "remotion";

export const ClickSound = ({frame}: {frame: number}) => (
  <Sequence from={frame} durationInFrames={18}>
    <Audio src={staticFile("audio/click.mp3")} volume={0.75} />
  </Sequence>
);
```

When no local audio is available and the user approves remote sound effects, `@remotion/sfx` can reference hosted SFX without adding files to the repo.

## Sound Map

Keep audio triggers in data:

```ts
export const soundMap = [
  {id: "panel-in", frame: 18, kind: "soft-pop", volume: 0.35},
  {id: "generate-click", frame: 76, kind: "click", volume: 0.8},
  {id: "result", frame: 142, kind: "success", volume: 0.45},
];
```

Rules:

- Align SFX to the exact visual frame.
- Avoid stacking loud sounds within `10-12` frames.
- Keep UI SFX short.
- Fade music in over `12-30` frames and out over `24-60` frames.
- Duck music beneath voiceover.

## Voiceover-Led Timing

Create beat data from the transcript:

```ts
export type VoiceBeat = {
  id: string;
  startFrame: number;
  endFrame: number;
  text: string;
};

export const secondsToFrame = (seconds: number, fps: number) =>
  Math.round(seconds * fps);
```

Build scenes from audio timing instead of guessing durations. If voiceover has no timestamps, transcribe it first or estimate, then refine against the waveform.

## Captions

Use captions for social video, accessibility, and muted playback. Use high-contrast placement and keep captions inside platform-safe areas.

```tsx
export type WordTiming = {
  word: string;
  startFrame: number;
  endFrame: number;
};

export const ActiveCaptions = ({words}: {words: WordTiming[]}) => {
  const frame = useCurrentFrame();
  const visible = words.filter(
    (word) => frame >= word.startFrame - 4 && frame <= word.endFrame + 24,
  );

  return (
    <div
      style={{
        position: "absolute",
        left: "10%",
        right: "10%",
        bottom: "9%",
        display: "flex",
        justifyContent: "center",
        flexWrap: "wrap",
        gap: 10,
      }}
    >
      {visible.map((word, index) => {
        const active = frame >= word.startFrame && frame <= word.endFrame;
        return (
          <span
            key={`${word.word}-${index}`}
            style={{
              padding: "6px 12px",
              borderRadius: 10,
              background: active ? "#fff" : "rgba(0,0,0,0.55)",
              color: active ? "#050505" : "#fff",
              fontWeight: 900,
              fontSize: 42,
              lineHeight: 1,
              textTransform: "uppercase",
            }}
          >
            {word.word}
          </span>
        );
      })}
    </div>
  );
};
```

## Loudness Targets

Use these practical targets when post-processing:

- Voiceover: around `-16 LUFS`
- Music under voice: roughly `-24` to `-20 LUFS`
- Final social/web mix: avoid clipping; target true peak below `-1 dBTP`
- YouTube upload audio: AAC, stereo, `48kHz` when possible

Use `npx remotion ffmpeg` or system `ffmpeg` for loudness normalization in the target project. Do not store processed media in this skill repository.
