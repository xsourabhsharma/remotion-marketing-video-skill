# Anthropic Design Language for Remotion

This playbook contains the core mathematical and visual rules for recreating the highly abstract, sophisticated motion graphics seen in Anthropic (Claude) promotional videos.

---

## 1. Visual Tokens
- **Background:** `#F9F8F6` (Alabaster / Warm Paper)
- **Text:** `#1A1919` (Soft Black)
- **Accent:** `#D97757` (Claude Terracotta)
- **Secondary Accent:** `#E5A974` (Claude Peach)
- **Fonts:** Pair an elegant Serif (`Times New Roman`) for headlines with a clean Sans (`system-ui`) for UI.

---

## 2. The Blur-Fade Reveal (BlurFadeText)
Anthropic avoids "typing" effects. Instead, text blurs into existence.

```tsx
export const BlurFadeText: React.FC<{ text: string; startFrame: number }> = ({ text, startFrame }) => {
  const frame = useCurrentFrame();
  const words = text.split(' ');

  return (
    <span>
      {words.map((word, i) => {
        const wordStart = startFrame + i * 5;
        const progress = interpolate(frame, [wordStart, wordStart + 25], [0, 1], { 
          extrapolateLeft: 'clamp', 
          extrapolateRight: 'clamp',
          easing: (t) => 1 - Math.pow(1 - t, 4) // Quartic Ease Out
        });

        return (
          <span style={{ 
            display: 'inline-block', 
            opacity: progress,
            filter: `blur(${interpolate(progress, [0, 1], [15, 0])}px)`,
            transform: `translateY(${interpolate(progress, [0, 1], [10, 0])}px)`,
            marginRight: '0.25em'
          }}>
            {word}
          </span>
        );
      })}
    </span>
  );
};
```

---

## 3. The Claude Sparkle (SVG)
A 4-pointed star made of Bezier curves with a pulsing terracotta gradient.

```tsx
export const ClaudeSparkle = () => {
  const frame = useCurrentFrame();
  const rotation = (frame * 0.4) % 360;
  const pulse = Math.sin(frame / 25) * 0.1 + 1;

  return (
    <div style={{ transform: `rotate(${rotation}deg) scale(${pulse})` }}>
      <svg viewBox="0 0 100 100" width="100" height="100">
        <path d="M50 0 C50 40, 60 50, 100 50 C60 50, 50 60, 50 100 C50 60, 40 50, 0 50 C40 50, 50 40, 50 0 Z" fill="#D97757" />
      </svg>
    </div>
  );
};
```

---

## 4. Abstract Data Morphing
Instead of showing real PDFs, represent them as "Chaos to Order" data lines.

1. **Scene 1 (Chaos):** 20 lines of varying widths moving at different horizontal speeds.
2. **Scene 2 (Order):** Interpolate the width and positions so the lines snap into a clean, grid-like JSON or Document structure.

---

## 5. Animation Rules
- **No Bouncing:** Avoid high-stiffness springs. 
- **Quartic Easing:** Always use `(t) => 1 - Math.pow(1 - t, 4)` for a deliberate, cinematic feel.
- **Cinematic Pushing:** Apply a very slow constant scale (e.g., `1.0` to `1.05` over 5 seconds) to give the feeling of a moving camera.
