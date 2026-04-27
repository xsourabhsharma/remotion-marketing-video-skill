# Scene Implementations Reference — Remotion Product Demo

Each scene is a self-contained React component. It uses `useCurrentFrame()` internally.
Scenes are composed in the main `ProductDemo.tsx` using `<Sequence>`.

---

## HookScene — Opening prompt / typewriter hook

```tsx
// scenes/HookScene.tsx
import { useCurrentFrame, useVideoConfig, interpolate } from 'remotion';
import { tokens } from '../tokens';

interface Props {
  prompt: string;           // The AI prompt text to type out
  subtext?: string;         // Optional subtitle below prompt
}

export const HookScene: React.FC<Props> = ({ prompt, subtext }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Card slides up
  const cardY = interpolate(frame, [0, 16], [40, 0], { extrapolateRight: 'clamp' });
  const cardOpacity = interpolate(frame, [0, 12], [0, 1], { extrapolateRight: 'clamp' });

  // Typing
  const charsPerSecond = 18;
  const typingDelay = 8; // wait 8 frames before typing starts
  const charsToShow = Math.floor(
    interpolate(frame - typingDelay, [0, (prompt.length / charsPerSecond) * fps], [0, prompt.length], {
      extrapolateLeft: 'clamp',
      extrapolateRight: 'clamp',
    })
  );
  const showCursor = Math.floor(frame / 8) % 2 === 0;

  return (
    <div style={{
      width: '100%', height: '100%',
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      background: tokens.bg,
    }}>
      {/* Prompt card */}
      <div style={{
        background: tokens.surface,
        border: `1px solid ${tokens.border}`,
        borderRadius: 20,
        padding: '32px 40px',
        width: 640,
        boxShadow: tokens.shadowCard,
        opacity: cardOpacity,
        transform: `translateY(${cardY}px)`,
      }}>
        {/* Prompt text */}
        <p style={{
          color: tokens.text,
          fontSize: 22,
          fontFamily: tokens.fontHeadline,
          lineHeight: 1.5,
          margin: 0,
          minHeight: 72,
        }}>
          {prompt.slice(0, charsToShow)}
          {showCursor && charsToShow < prompt.length && (
            <span style={{ color: tokens.accent, opacity: 0.8 }}>|</span>
          )}
        </p>

        {/* Toolbar row */}
        <div style={{
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          marginTop: 24, paddingTop: 16, borderTop: `1px solid ${tokens.border}`,
        }}>
          <div style={{ display: 'flex', gap: 12 }}>
            {['⚙️', '📎', '✏️'].map((icon, i) => (
              <div key={i} style={{
                width: 36, height: 36, borderRadius: 8,
                border: `1px solid ${tokens.border}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 16,
              }}>{icon}</div>
            ))}
            <div style={{ color: tokens.textMuted, fontSize: 14, display: 'flex', alignItems: 'center' }}>
              Import
            </div>
          </div>
          {/* Send button */}
          <div style={{
            background: tokens.accent,
            color: '#fff',
            padding: '10px 20px',
            borderRadius: 10,
            fontSize: 15,
            fontWeight: 600,
            fontFamily: tokens.fontHeadline,
            display: 'flex', alignItems: 'center', gap: 8,
          }}>
            ▷ Send
          </div>
        </div>
      </div>
    </div>
  );
};
```

---

## UIRevealScene — Product UI appears

```tsx
// scenes/UIRevealScene.tsx
import { useCurrentFrame, spring, useVideoConfig, interpolate, Img, staticFile } from 'remotion';
import { tokens } from '../tokens';
import { MockUI } from '../components/MockUI';

interface Props {
  screenshotSrc?: string;  // If using a screenshot instead of React UI
}

export const UIRevealScene: React.FC<Props> = ({ screenshotSrc }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Browser window slides up and fades in
  const s = spring({ frame, fps, config: { damping: 16, stiffness: 150 } });

  return (
    <div style={{
      width: '100%', height: '100%',
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      background: tokens.bg,
    }}>
      {/* Browser chrome wrapper */}
      <div style={{
        width: 1400,
        height: 860,
        borderRadius: 16,
        overflow: 'hidden',
        boxShadow: '0 32px 80px rgba(0,0,0,0.6)',
        opacity: Math.min(1, s),
        transform: `translateY(${interpolate(s, [0, 1], [60, 0])}px) scale(${interpolate(s, [0, 1], [0.95, 1])})`,
        border: '1px solid #333',
      }}>
        {/* Browser top bar */}
        <div style={{
          height: 44, background: '#1c1c1c',
          display: 'flex', alignItems: 'center', padding: '0 16px', gap: 8,
          borderBottom: '1px solid #333',
        }}>
          {['#ff5f57','#febc2e','#28c840'].map((c, i) => (
            <div key={i} style={{ width: 12, height: 12, borderRadius: '50%', background: c }} />
          ))}
          {/* URL bar */}
          <div style={{
            flex: 1, height: 28, background: '#2a2a2a',
            borderRadius: 6, margin: '0 80px',
            display: 'flex', alignItems: 'center',
            paddingLeft: 12, color: '#666', fontSize: 13,
          }}>
            app.yourproduct.com
          </div>
        </div>

        {/* Product UI */}
        {screenshotSrc
          ? <Img src={staticFile(screenshotSrc)} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
          : <MockUI />
        }
      </div>
    </div>
  );
};
```

---

## FeatureScene — Highlight one feature

```tsx
// scenes/FeatureScene.tsx
import { useCurrentFrame, spring, useVideoConfig, interpolate } from 'remotion';
import { tokens } from '../tokens';

interface Props {
  title: string;
  description: string;
  icon?: string;
  highlightArea?: { x: number; y: number; width: number; height: number };
}

export const FeatureScene: React.FC<Props> = ({ title, description, icon }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const labelSpring = spring({ frame: frame - 8, fps, config: { damping: 14 } });

  return (
    <div style={{
      position: 'absolute', bottom: 60, left: 60,
      display: 'flex', flexDirection: 'column', gap: 8,
    }}>
      {/* Feature badge */}
      <div style={{
        background: 'rgba(99,102,241,0.15)',
        border: '1px solid rgba(99,102,241,0.4)',
        borderRadius: 12,
        padding: '12px 20px',
        display: 'flex', alignItems: 'center', gap: 12,
        opacity: Math.min(1, labelSpring),
        transform: `translateY(${interpolate(Math.min(1, labelSpring), [0,1], [16, 0])}px)`,
        backdropFilter: 'blur(8px)',
      }}>
        {icon && <span style={{ fontSize: 24 }}>{icon}</span>}
        <div>
          <div style={{ color: '#fff', fontWeight: 700, fontSize: 18 }}>{title}</div>
          <div style={{ color: '#aaa', fontSize: 14, marginTop: 2 }}>{description}</div>
        </div>
      </div>
    </div>
  );
};
```

---

## CTAScene — Closing call to action

```tsx
// scenes/CTAScene.tsx
import { useCurrentFrame, spring, useVideoConfig, interpolate, Img, staticFile } from 'remotion';
import { tokens } from '../tokens';

interface Props {
  productName: string;
  tagline: string;
  cta: string;
  logoSrc?: string;
}

export const CTAScene: React.FC<Props> = ({ productName, tagline, cta, logoSrc }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const logoSpring = spring({ frame, fps, config: { damping: 16, stiffness: 180 } });
  const taglineSpring = spring({ frame: frame - 12, fps, config: { damping: 14 } });
  const ctaSpring = spring({ frame: frame - 24, fps, config: { damping: 12, stiffness: 160 } });

  return (
    <div style={{
      width: '100%', height: '100%',
      display: 'flex', flexDirection: 'column',
      alignItems: 'center', justifyContent: 'center',
      background: tokens.bg, gap: 24,
    }}>
      {/* Logo / Product name */}
      <div style={{
        opacity: Math.min(1, logoSpring),
        transform: `scale(${interpolate(Math.min(1, logoSpring), [0, 1], [0.8, 1])})`,
        textAlign: 'center',
      }}>
        {logoSrc
          ? <Img src={staticFile(logoSrc)} style={{ height: 64 }} />
          : <div style={{ fontSize: 48, fontWeight: 800, color: '#fff', fontFamily: tokens.fontHeadline }}>{productName}</div>
        }
      </div>

      {/* Tagline */}
      <div style={{
        fontSize: 28,
        color: tokens.textMuted,
        fontFamily: tokens.fontHeadline,
        opacity: Math.min(1, taglineSpring),
        transform: `translateY(${interpolate(Math.min(1, taglineSpring), [0,1], [20,0])}px)`,
        textAlign: 'center',
      }}>
        {tagline}
      </div>

      {/* CTA Button */}
      <div style={{
        background: tokens.accent,
        color: '#fff',
        padding: '16px 40px',
        borderRadius: 14,
        fontSize: 20,
        fontWeight: 700,
        fontFamily: tokens.fontHeadline,
        opacity: Math.min(1, ctaSpring),
        transform: `scale(${interpolate(Math.min(1, ctaSpring), [0,1], [0.9, 1])})`,
        boxShadow: `0 8px 32px rgba(99,102,241,0.4)`,
        marginTop: 8,
      }}>
        {cta} →
      </div>
    </div>
  );
};
```

---

## Scene Timing Reference Table

At 24fps:

| Seconds | Frames |
|---|---|
| 0.5s | 12 |
| 1s | 24 |
| 1.5s | 36 |
| 2s | 48 |
| 2.5s | 60 |
| 3s | 72 |
| 4s | 96 |
| 5s | 120 |
| 8s | 192 |
| 10s | 240 |
| 30s | 720 |
| 60s | 1440 |

---

## Adapting Scenes for Any Product

To make these universal, replace:
- `<MockUI />` → your product's React components or a `<Img>` screenshot
- `tokens.accent` → your brand color
- `prompt` text → your AI prompt or feature description
- `productName` / `tagline` → your product copy
- Cursor waypoints → x/y positions matching your UI layout

Everything else (spring configs, fade timings, card styles) stays the same.
