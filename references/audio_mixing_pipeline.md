# Voiceover Mixing Pipeline

Use this file when a video is driven by narration or when audio quality matters.

## Workflow

1. Obtain or generate the voiceover in the target Remotion project.
2. Normalize the voiceover before timing visuals.
3. Transcribe or timestamp the voiceover.
4. Map transcript beats to scene frames.
5. Add music and SFX last.
6. Render and inspect audio sync.

## Beat Object

```ts
export type ScriptBeat = {
  id: string;
  startFrame: number;
  durationInFrames: number;
  text: string;
  visual: string;
  emphasis?: "low" | "medium" | "high";
  audioSrc?: string;
};
```

## Voiceover Track

```tsx
import {Audio} from "@remotion/media";
import {Sequence, staticFile} from "remotion";

export const VoiceoverTrack = ({beats}: {beats: ScriptBeat[]}) => (
  <>
    {beats
      .filter((beat) => beat.audioSrc)
      .map((beat) => (
        <Sequence key={beat.id} from={beat.startFrame} durationInFrames={beat.durationInFrames}>
          <Audio src={staticFile(beat.audioSrc!)} volume={1} />
        </Sequence>
      ))}
  </>
);
```

## Music Ducking

Use a volume callback when a music bed should duck under narration:

```tsx
const narrationRanges = beats.map((beat) => [
  beat.startFrame,
  beat.startFrame + beat.durationInFrames,
]);

const musicVolume = (frame: number) => {
  const underVoice = narrationRanges.some(([start, end]) => frame >= start - 8 && frame <= end + 8);
  return underVoice ? 0.12 : 0.26;
};
```

## FFmpeg Normalization Examples

Inspect loudness:

```bash
npx remotion ffmpeg -i input.wav -af loudnorm=I=-16:TP=-1.5:LRA=11 -f null -
```

Create a normalized file in the target project:

```bash
npx remotion ffmpeg -i input.wav -af loudnorm=I=-16:TP=-1.5:LRA=11 normalized.wav
```

Keep normalized outputs in the target video project only. Do not add audio files to this skill.
