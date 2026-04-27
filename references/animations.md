# Animation Reference — Remotion Product Demo

All animations use these Remotion imports:
```tsx
import { useCurrentFrame, useVideoConfig, interpolate, spring } from 'remotion';
```

---

## Fade In

```tsx
export const fadeIn = (frame: number, startFrame = 0, durationFrames = 20) =>
  interpolate(frame - startFrame, [0, durationFrames], [0, 1], { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' });
```

Usage:
```tsx
const opacity = fadeIn(frame, 0, 16);
<div style={{ opacity }}>...</div>
```

---

## Slide Up + Fade In

```tsx
export const slideUp = (frame: number, startFrame = 0, distance = 40, durationFrames = 20) => ({
  opacity: interpolate(frame - startFrame, [0, durationFrames], [0, 1], { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' }),
  transform: `translateY(${interpolate(frame - startFrame, [0, durationFrames], [distance, 0], { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' })}px)`,
});
```

---

## Spring Pop (for UI elements, buttons, cards)

```tsx
export const popIn = (frame: number, startFrame = 0, fps = 24) => {
  const s = spring({ frame: frame - startFrame, fps, config: { damping: 12, stiffness: 200, mass: 0.8 } });
  return {
    transform: `scale(${interpolate(s, [0, 1], [0.7, 1])})`,
    opacity: interpolate(s, [0, 0.3], [0, 1], { extrapolateRight: 'clamp' }),
  };
};
```

---

## Stagger (for lists, checklists, bullet points)

```tsx
// Each child gets a delayed start
export const StaggeredList = ({ items, startFrame, fps }: Props) => {
  const frame = useCurrentFrame();
  return (
    <div>
      {items.map((item, i) => {
        const itemStart = startFrame + i * 8; // 8 frames between each
        const s = spring({ frame: frame - itemStart, fps, config: { damping: 14 } });
        return (
          <div
            key={i}
            style={{
              opacity: Math.min(1, s),
              transform: `translateX(${interpolate(s, [0, 1], [-20, 0])}px)`,
            }}
          >
            {item}
          </div>
        );
      })}
    </div>
  );
};
```

---

## Slow Zoom (Ken Burns — for background/product screenshots)

```tsx
export const slowZoom = (frame: number, totalFrames: number, startScale = 1, endScale = 1.08) => ({
  transform: `scale(${interpolate(frame, [0, totalFrames], [startScale, endScale])})`,
  transformOrigin: 'center center',
});
```

---

## Slide In From Right

```tsx
export const slideInRight = (frame: number, startFrame = 0, durationFrames = 24, distance = 100) => ({
  opacity: interpolate(frame - startFrame, [0, durationFrames], [0, 1], { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' }),
  transform: `translateX(${interpolate(frame - startFrame, [0, durationFrames], [distance, 0], { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' })}px)`,
});
```

---

## Word-by-Word Stagger (for headlines)

```tsx
export const WordStagger = ({ text, startFrame, fps }: Props) => {
  const frame = useCurrentFrame();
  const words = text.split(' ');
  return (
    <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.25em' }}>
      {words.map((word, i) => {
        const s = spring({ frame: frame - startFrame - i * 4, fps, config: { damping: 16 } });
        return (
          <span
            key={i}
            style={{
              opacity: Math.min(1, Math.max(0, s)),
              transform: `translateY(${interpolate(Math.min(1, Math.max(0, s)), [0, 1], [20, 0])}px)`,
              display: 'inline-block',
            }}
          >
            {word}
          </span>
        );
      })}
    </div>
  );
};
```

---

## Highlight / Glow Pulse (for accent elements)

```tsx
export const glowPulse = (frame: number, period = 48) => {
  const t = (frame % period) / period;
  const intensity = Math.sin(t * Math.PI * 2) * 0.5 + 0.5;
  return {
    boxShadow: `0 0 ${interpolate(intensity, [0, 1], [8, 24])}px rgba(99, 102, 241, ${interpolate(intensity, [0, 1], [0.3, 0.7])})`,
  };
};
```

---

## Progress Bar Fill

```tsx
export const ProgressBar = ({ startFrame, endFrame, color }: Props) => {
  const frame = useCurrentFrame();
  const progress = interpolate(frame, [startFrame, endFrame], [0, 100], { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' });
  return (
    <div style={{ background: '#2a2a2a', borderRadius: 4, height: 6, width: '100%' }}>
      <div style={{ background: color, width: `${progress}%`, height: '100%', borderRadius: 4, transition: 'none' }} />
    </div>
  );
};
```

---

## Fade Out (for scene exits)

```tsx
export const fadeOut = (frame: number, startFrame: number, durationFrames = 12) =>
  interpolate(frame - startFrame, [0, durationFrames], [1, 0], { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' });
```

---

## Scene Crossfade Wrapper

```tsx
// Wrap each scene in this for smooth overlapping transitions
export const CrossfadeScene = ({ children, durationInFrames }: Props) => {
  const frame = useCurrentFrame();
  const FADE = 12;
  const opacity =
    frame < FADE
      ? interpolate(frame, [0, FADE], [0, 1])
      : frame > durationInFrames - FADE
      ? interpolate(frame, [durationInFrames - FADE, durationInFrames], [1, 0])
      : 1;
  return <div style={{ opacity, width: '100%', height: '100%' }}>{children}</div>;
};
```

---

## Tips

- **Never use CSS transitions** inside Remotion — they fight with frame-based rendering. Always use `interpolate` or `spring`.
- **spring() stiffness guide**: 80–120 = slow/bouncy, 150–200 = medium, 250–400 = snappy/fast
- **spring() damping guide**: 8–10 = bouncy, 12–15 = normal, 20+ = no bounce
- **Always clamp** interpolate with `extrapolateLeft: 'clamp', extrapolateRight: 'clamp'` unless you want overflow.
- Use `Math.min(1, Math.max(0, spring(...)))` when spring overshoots would cause visual issues.
