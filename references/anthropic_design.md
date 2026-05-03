# Editorial Minimal Motion Reference

Use this file for tasteful, premium, text-led motion inspired by high-end AI and technology launch videos. Treat brand-specific aesthetics as inspiration only. Do not copy another company's logo, palette, typography, or protected identity.

## Visual Direction

- Warm neutral or deep neutral backgrounds.
- Large restrained typography.
- Generous negative space.
- Abstract data structures instead of literal stock imagery.
- Slow camera push or parallax.
- Blur-to-sharp reveals.
- Minimal color accents.
- No gratuitous decoration.

## Blur Fade Word Reveal

```tsx
import {Easing, interpolate, useCurrentFrame} from "remotion";

export const BlurFadeWords = ({
  text,
  start,
}: {
  text: string;
  start: number;
}) => {
  const frame = useCurrentFrame();
  const words = text.split(" ");

  return (
    <span>
      {words.map((word, index) => {
        const wordStart = start + index * 4;
        const p = interpolate(frame, [wordStart, wordStart + 24], [0, 1], {
          easing: Easing.bezier(0.16, 1, 0.3, 1),
          extrapolateLeft: "clamp",
          extrapolateRight: "clamp",
        });
        return (
          <span
            key={`${word}-${index}`}
            style={{
              display: "inline-block",
              marginRight: "0.28em",
              opacity: p,
              filter: `blur(${interpolate(p, [0, 1], [14, 0])}px)`,
              transform: `translateY(${interpolate(p, [0, 1], [14, 0])}px)`,
            }}
          >
            {word}
          </span>
        );
      })}
    </span>
  );
};
```

## Abstract Data Morph

Represent "messy to clear" transformation without media:

```tsx
const rows = Array.from({length: 18}, (_, index) => ({
  id: index,
  startWidth: 80 + ((index * 37) % 240),
  endWidth: 220 + (index % 4) * 70,
  y: index * 22,
}));
```

Animate each row's `x`, `width`, `opacity`, and `borderRadius` from scattered lines into a stable grid.

## Restraint Rules

- Prefer one strong animation over five weak ones.
- Let premium typography breathe for at least `1.5-2s`.
- Avoid bouncy springs unless the brand is playful.
- Keep color accents purposeful.
- Use blur as a reveal, not as a crutch for unfinished layout.
