# Audio & Voiceover Synchronization Pipeline

Premium SaaS ads use tight audio-visual synchronization to feel dynamic. Voiceover (VO) drives the timing, not the other way around.

## Sound Design Principles
1. **Music Bed:** Use a single music track (corporate, upbeat, minimal vocals) that runs the full duration. No abrupt cuts, just intro/outro fades.
2. **SFX Minimalism:** Rely primarily on the VO and music. Avoid heavy sound effects. UI clicks and subtle whooshes are acceptable but should not overpower.
3. **Loudness Normalization:**
   - **Voiceover:** Pre-normalize to **-16 LUFS** (consistent loudness).
   - **Music:** Duck the music underneath the VO, targeting **-24 to -20 LUFS** relative.

## Synchronization Workflow
In Remotion, timeline control must be explicit and data-driven based on the audio script.

### 1. Script Object Model
Create an array of beats that map exactly to visual changes.

```typescript
export const scriptBeats = [
  {
    id: "hook",
    startFrame: 0,
    durationInFrames: 72, // 3 seconds
    text: "You don't start with a product. You start with a problem.",
    voAudioFile: "audio/vo_hook.mp3"
  },
  {
    id: "reveal",
    startFrame: 72,
    durationInFrames: 120, // 5 seconds
    text: "Meet Lovio. Generate structure instantly.",
    voAudioFile: "audio/vo_reveal.mp3"
  }
];
```

### 2. Audio Mapping
Map transcript lines to timestamps, then map timestamps to frames (based on your FPS, typically 25 or 30).
Align the `Scene` component's `startFrame` to the VO timeline, rather than using hard-coded guesses.

```tsx
import { Audio, Sequence, staticFile } from 'remotion';

export const VoiceoverTrack = () => {
  return (
    <>
      {scriptBeats.map((beat) => (
        <Sequence key={beat.id} from={beat.startFrame} durationInFrames={beat.durationInFrames}>
          <Audio src={staticFile(beat.voAudioFile)} volume={1} />
        </Sequence>
      ))}
    </>
  );
};
```
