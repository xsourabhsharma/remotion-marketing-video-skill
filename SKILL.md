---
name: remotion-product-demo-video
description: >
  Universal skill for creating polished product demo / showcase videos using Remotion (React-based video framework).
  Use this skill whenever the user wants to make a video showing a product, UI, app, website, SaaS tool, AI tool, or any software product.
  Triggers include: "make a video like this", "create a product demo video", "build a Remotion video", "animate my UI", "make a screen recording style video",
  "show my product in a video", "create a promo video for my app", or any reference to making motion/animated videos with Remotion or for product showcases.
  This skill covers the full pipeline: planning → Remotion project setup → scene components → animations → cursor simulation → sound → rendering.
  Always use this skill when video creation + Remotion is involved, even if the user just asks "how do I start".
---

# Remotion Product Demo Video — Universal Skill

This skill teaches how to build a **professional product demo video** using Remotion — the kind you see on X/Twitter for SaaS, AI tools, design tools, mobile apps, or any product. It is fully universal: swap the product visuals and it works for anything.

---

## 0. INTAKE FIRST — Ask the User These Questions Before Writing Any Code

**IMPORTANT: Never start coding without completing this intake. Ask the user for all of this upfront.**

When a user says "make a video for my product", you MUST gather the following before touching any code. If info is missing, ask clearly. If the user doesn't know, provide sensible defaults and state what you assumed.

---

### 0A. Product Info (Required)

Ask the user:

1. **What is your product called?** (e.g. "Notion", "Linear", "my SaaS app")
2. **What does it do?** (1–2 sentences — this becomes the hook text)
3. **What are the 2–4 key features you want to show?** (each becomes a scene)
4. **What is your brand/accent color?** (hex code, or describe it — e.g. "purple", "orange")
5. **What font does your product use?** (default: Inter — freely available on Google Fonts)

---

### 0B. Visual Assets (Required — tell user exactly what to collect)

Tell the user clearly:

> "Before I can build your video, you need to collect these files and put them in the `public/` folder of the Remotion project:"

| Asset | What it is | How to get it | Required? |
|---|---|---|---|
| **Screenshots** | PNG/JPG of your product UI (the actual app screens) | Take a screenshot of your app. Use 1920×1080 or 2560×1440 for sharpness. | ✅ YES |
| **Screen recording clips** | Short MP4 clips of the real UI being used | Record with OBS Studio (free) or Screen Studio (Mac). 5–15 sec each. | Optional but makes it much better |
| **Logo file** | Your product logo as SVG or PNG with transparent background | Export from Figma/Canva, or use your existing logo file | Recommended |
| **Brand colors** | Primary + secondary hex colors | Check your CSS, Figma, or brand guide | ✅ YES |
| **Font name** | The font your product uses | Check your CSS `font-family` | ✅ YES |
| **Audio files** | click.mp3, whoosh.mp3, ambient.mp3 | Download free from freesound.org or zapsplat.com | Recommended |

**If the user has NO screenshots yet:** tell them to take screenshots of their live product at 1920×1080 using browser fullscreen. If they have no product UI yet, you will build a `MockUI.tsx` from their description.

---

### 0C. Video Structure (Required)

Ask or decide:

1. **How long?** (recommended: 30–60 seconds)
2. **Aspect ratio?**
   - 1920×1080 = landscape (X/Twitter, YouTube, LinkedIn)
   - 1080×1920 = portrait (TikTok, Instagram Reels, YouTube Shorts)
3. **What's the story?** Fill in this template with the user:
   ```
   Hook:    "[User types a prompt / sees a problem]"
   Scene 1: "[Feature 1 — what it shows]"
   Scene 2: "[Feature 2 — what it shows]"
   Scene 3: "[Feature 3 — what it shows]"  (optional)
   CTA:     "[Product name] — [tagline] — [call to action]"
   ```

---

### 0D. What Claude Will Build (No Assets Needed)

These components are **built entirely in code** — the user does NOT need to supply them:

- ✅ Animated cursor (SVG, coded)
- ✅ Typing text effect (coded)
- ✅ Browser chrome wrapper (coded)
- ✅ Scene transitions, fades, springs (coded)
- ✅ MockUI layout (coded from screenshots or description)
- ✅ Checklist, sliders, floating panels (coded)
- ✅ CTA screen (coded)
- ✅ All timing and sequencing (coded)

The user only needs to supply: **screenshots/clips, brand colors, logo, audio files.**

---

### 0E. Intake Summary Template

Once you have all answers, confirm with this summary before coding:

```
📋 VIDEO BRIEF
Product: [name]
Tagline: [what it does]
Duration: [X seconds] at 24fps = [X*24] frames
Aspect ratio: [1920×1080 / 1080×1920]
Accent color: [hex]
Font: [name]

SCENES:
0:00–0:03  Hook — [description]
0:03–0:08  Scene 1 — [description]
0:08–0:14  Scene 2 — [description]
0:14–0:20  Scene 3 — [description]
0:20–0:25  CTA — [tagline + CTA text]

ASSETS NEEDED FROM USER:
- [ ] Screenshot of [screen name] → save as public/ui-main.png
- [ ] Screenshot of [screen name] → save as public/ui-feature1.png
- [ ] Logo → save as public/logo.svg
- [ ] click.mp3 → save as public/audio/click.mp3
- [ ] whoosh.mp3 → save as public/audio/whoosh.mp3
- [ ] ambient.mp3 → save as public/audio/ambient.mp3

BUILT IN CODE (no files needed):
- AnimatedCursor, TypingText, scene transitions, MockUI shell
```

Only proceed to Section 1 once the user confirms this brief.

---

## 1. Understanding the Video Style

The target style (from the reference video) is:
- **Dark background** (`#0a0a0a` or `#111111`)
- AI prompt → product UI appears workflow (or any "before → after" flow)
- **Animated cursor** that moves, clicks, hovers
- **Typing effect** for prompts / text inputs
- UI panels, checklists, sliders, modals appearing with spring animations
- 3D elements (optional: globe, graphs)
- Smooth scene transitions (fade, slide, zoom)
- Sound design: UI clicks, whooshes, ambient music
- Duration: 30–90 seconds, 24fps, 1920×1080 (landscape) or 1080×1920 (portrait/TikTok)

---

## 2. Project Setup

```bash
# Create project
npx create-video@latest my-product-demo
cd my-product-demo

# Choose: TypeScript + Tailwind (recommended)

# Install extra packages
npm install @remotion/player framer-motion
npm install @react-three/fiber @react-three/drei  # only if you need 3D
npm install remotion @remotion/cli
```

**Composition config** (in `src/Root.tsx`):
```tsx
export const RemotionRoot = () => (
  <>
    <Composition
      id="ProductDemo"
      component={ProductDemo}
      durationInFrames={24 * 60}  // 60 seconds at 24fps
      fps={24}
      width={1920}
      height={1080}
    />
  </>
);
```

---

## 3. Universal Folder Structure

```
src/
├── Root.tsx                  # Composition registry
├── ProductDemo.tsx           # Main video orchestrator
├── scenes/
│   ├── HookScene.tsx         # Opening hook (prompt typing)
│   ├── UIRevealScene.tsx     # Product UI appearing
│   ├── FeatureScene.tsx      # Feature highlight (repeat per feature)
│   ├── InteractionScene.tsx  # Cursor clicking through UI
│   └── CTAScene.tsx          # Closing CTA
├── components/
│   ├── AnimatedCursor.tsx    # SVG cursor with motion
│   ├── TypingText.tsx        # Typewriter effect
│   ├── MockUI.tsx            # Your product's UI (React components)
│   ├── ChecklistItem.tsx     # Animated checklist rows
│   └── FloatingPanel.tsx     # Animated floating card/panel
├── hooks/
│   └── useFrameRange.ts      # Helper: is current frame in range?
├── tokens.ts                 # Design tokens (colors, fonts, sizes)
└── audio/
    ├── click.mp3
    ├── whoosh.mp3
    └── ambient.mp3
```

---

## 4. Design Tokens (tokens.ts)

```ts
// tokens.ts — customize per product
export const tokens = {
  bg: '#0a0a0a',
  surface: '#1a1a1a',
  border: '#2a2a2a',
  accent: '#your-brand-color',   // e.g. '#6366f1' for purple
  text: '#ffffff',
  textMuted: '#888888',
  fontHeadline: 'Inter',         // or your brand font
  radius: '12px',
  shadowCard: '0 8px 32px rgba(0,0,0,0.4)',
};
```

---

## 5. Core Animation Patterns

**Read `references/animations.md` for full code examples.**

Key primitives:
- `useCurrentFrame()` → current frame number
- `interpolate(frame, [startF, endF], [startVal, endVal])` → linear mapping
- `spring({ frame, fps, config })` → physics-based spring (for snappy UI pops)
- `<Sequence from={N} durationInFrames={M}>` → scene timing
- `<Audio src={} startFrom={} />` → sync audio

### The Universal Scene Formula
```
Frames 0–8:    Element fades/rises in       interpolate opacity 0→1
Frames 8–20:   Key content scales/pops      spring() scale 0.8→1
Frames 20–50:  Main content visible         slow zoom or drift
Frames 50–60:  Exit animation               interpolate opacity 1→0
```
Keep every scene **48–72 frames (2–3 seconds) at 24fps.**

---

## 6. Scene Components

**Read `references/scenes.md` for full implementation of each scene.**

Scene list and purpose:
| Scene | Purpose | Typical duration |
|---|---|---|
| `HookScene` | Prompt typing, viewer hook | 2–3s |
| `UIRevealScene` | Product UI slides/fades in | 2–4s |
| `FeatureScene` | One feature, cursor interaction | 3–5s |
| `InteractionScene` | Cursor clicks through workflow | 4–8s |
| `ResultScene` | Output / result appears | 2–3s |
| `CTAScene` | Logo + tagline + call to action | 3–5s |

---

## 7. Cursor Animation (Critical for Demo Feel)

**Read `references/cursor.md` for full AnimatedCursor component.**

Key concept: cursor is an absolutely-positioned SVG that moves via `interpolate()` across keyframes:

```tsx
// Define waypoints: [frame, x, y]
const waypoints = [
  [0,   100, 200],   // start position
  [30,  500, 300],   // move to button
  [35,  500, 300],   // hover (pause)
  [40,  500, 300],   // click (trigger state change)
  [70,  800, 500],   // move away
];

const x = interpolate(frame, waypoints.map(w=>w[0]), waypoints.map(w=>w[1]), { extrapolateRight: 'clamp' });
const y = interpolate(frame, waypoints.map(w=>w[0]), waypoints.map(w=>w[2]), { extrapolateRight: 'clamp' });
```

Click effect: scale cursor down at click frame, spring back:
```tsx
const clickScale = spring({ frame: frame - clickFrame, fps, config: { damping: 8, stiffness: 300 } });
const scale = frame >= clickFrame ? Math.max(0.7, 1 - clickScale * 0.3) : 1;
```

---

## 8. Typing Effect Component

```tsx
// TypingText.tsx
export const TypingText = ({ text, startFrame, fps }: Props) => {
  const frame = useCurrentFrame();
  const charsPerSecond = 20;
  const charsToShow = Math.floor(
    interpolate(frame - startFrame, [0, (text.length / charsPerSecond) * fps], [0, text.length], { extrapolateRight: 'clamp' })
  );
  const showCursor = Math.floor((frame / 8)) % 2 === 0; // blink every 8 frames

  return (
    <span style={{ fontFamily: tokens.fontHeadline, color: tokens.text }}>
      {text.slice(0, charsToShow)}
      {showCursor && <span style={{ opacity: 0.7 }}>|</span>}
    </span>
  );
};
```

---

## 9. Main Orchestrator (ProductDemo.tsx)

```tsx
export const ProductDemo: React.FC = () => {
  return (
    <div style={{ background: tokens.bg, width: '100%', height: '100%', position: 'relative', overflow: 'hidden' }}>

      {/* Scene 1: Hook — frames 0-72 */}
      <Sequence from={0} durationInFrames={72}>
        <HookScene prompt="Let's build an interactive dark-themed dashboard" />
      </Sequence>

      {/* Scene 2: UI Reveal — frames 60-180 (overlap by 12 for crossfade) */}
      <Sequence from={60} durationInFrames={120}>
        <UIRevealScene />
      </Sequence>

      {/* Scene 3: Feature 1 — frames 168-288 */}
      <Sequence from={168} durationInFrames={120}>
        <FeatureScene title="Real-time sync" />
      </Sequence>

      {/* Add more scenes... */}

      {/* CTA — last 96 frames */}
      <Sequence from={totalFrames - 96} durationInFrames={96}>
        <CTAScene tagline="Ship faster." cta="Try it free" />
      </Sequence>

      {/* Global cursor — always on top */}
      <AnimatedCursor waypoints={cursorWaypoints} />

      {/* Audio */}
      <Audio src={staticFile('audio/ambient.mp3')} volume={0.3} />
    </div>
  );
};
```

---

## 10. Step-by-Step Build Order

Follow this order every time:

**Step 1 — Plan (30 min)**
- Write 4–6 scenes as sentences
- Define the product's key features to show
- Pick accent color, font, aspect ratio
- Collect screen recordings or UI screenshots

**Step 2 — Tokens + Static UI (1–2 hrs)**
- Set up `tokens.ts` with brand colors
- Build `MockUI.tsx` — static version of your product UI (no animation yet)
- Get it looking right in browser

**Step 3 — Scene Timing (1 hr)**
- Set up `ProductDemo.tsx` with `<Sequence>` blocks
- Placeholder text in each scene, no animation
- Get scene order right

**Step 4 — Animate (2–3 hrs)**
- Add `interpolate` / `spring` animations to each scene
- Add `AnimatedCursor` with waypoints
- Add `TypingText` for prompts

**Step 5 — Sound Design (1 hr)**
- Add click SFX at cursor click frames
- Add whoosh at scene transitions
- Add ambient music at 20–30% volume

**Step 6 — Polish + Export**
- Preview on actual screen (not just browser)
- Tighten any scenes that feel slow (cut 12–24 frames)
- `npx remotion render src/index.ts ProductDemo out/demo.mp4 --codec=h264`

---

## 11. Common Mistakes + Fixes

| Mistake | Fix |
|---|---|
| Too much text per scene | Max 1 sentence. Cut ruthlessly. |
| Cursor teleports | Always interpolate x,y — never jump |
| No sound on interactions | Add click SFX every time cursor clicks |
| Scenes too long | 2–3 seconds max per scene |
| Font/color inconsistency | Always use `tokens.ts`, never hardcode |
| Fancy transitions with no rhythm | Use only: fade, slide, zoom. Pick 2. |
| Weak hook | First scene must show product value in <2s |
| 3D globe freezing | Use `<OffthreadVideo>` not `<Video>` for heavy assets |

---

## 12. Product Type Adaptations

The video structure is universal, but the **UIRevealScene mockup** changes per product type. Detect what type of product the user has and adapt accordingly:

### Type A — Web App / SaaS Dashboard
- Show browser chrome wrapper (macOS-style traffic lights + URL bar)
- Screenshot fills the browser window
- Cursor moves around the dashboard UI
- Example: Notion, Linear, Figma, analytics tools
- Asset needed: `public/ui-main.png` = full-page screenshot at 1920×1080

### Type B — Mobile App
- Show iPhone/Android frame mockup (a div with border-radius: 44px, border: 8px solid #222)
- Screenshot fills the phone frame
- Optionally show 2 phones side by side (light + dark mode)
- Cursor becomes a **tap circle** (not arrow): `<div style={{ borderRadius: '50%', border: '2px solid white' }} />`
- Asset needed: `public/ui-mobile.png` = screenshot at 390×844 (iPhone size)

### Type C — AI / Prompt-Based Tool
- Start with prompt input card typing (HookScene)
- Show output being "generated" with a streaming text animation
- This is exactly the style in the reference video
- Works for: AI writing tools, AI image generators, AI coding assistants
- Asset needed: screenshot of the output/result screen

```tsx
// Streaming text effect for AI output:
const streamedText = outputText.slice(0, Math.floor(
  interpolate(frame, [startF, endF], [0, outputText.length], { extrapolateRight: 'clamp' })
));
```

### Type D — CLI / Developer Tool
- Show a terminal window (dark bg, monospace font, green/white text)
- Animate commands being typed line by line
- Show output lines appearing one by one with stagger

```tsx
<div style={{ background: '#1e1e1e', borderRadius: 12, fontFamily: 'monospace', padding: 24, color: '#00ff88' }}>
  <TypingText text="$ remotion render my-video.tsx" startFrame={0} fps={fps} />
</div>
```

### Type E — Chrome Extension / Browser Plugin
- Show a browser with extension panel open on the right side
- Cursor clicks the extension icon in the browser toolbar
- Panel slides in from right using `slideInRight` animation

### Type F — No Real UI Yet (User Has No Product Screenshots)
If the user cannot provide screenshots:
1. Ask them to describe the layout in words ("sidebar + main canvas + toolbar")
2. Build `MockUI.tsx` entirely in React from their description
3. Use realistic fake data (not "Lorem Ipsum" — use domain-relevant placeholder content)
4. Style with their brand colors from tokens.ts
5. This is totally fine — many polished demo videos use code-built UIs

### Type G — Premium AI SaaS Video Ad
- Use this when the user asks for a Lovio, LangEase, or Teamble style ad.
- Relies heavily on **screen-space camera motion** and data-driven UI components (cards, charts, metrics).
- Uses specific narrative structures (Problem→Solution, Mini-Tutorial, Workflow Transformation).
- Targets 25/30 fps with tight voiceover synchronization and `-16 LUFS` audio mixing.
- Asset needed: The script beats with corresponding VO audio files, and JSON data for the UI components.
- See `references/saas_narrative_templates.md` and `references/saas_ui_kit.md`.

---

## 13. Font Loading in Remotion

Fonts must be explicitly loaded — they don't auto-load from CSS.

**Step 1 — Install the font loader:**
```bash
npm install @remotion/google-fonts
```

**Step 2 — Load your font at the top of `Root.tsx`:**
```tsx
// For Inter (most common):
import { loadFont } from '@remotion/google-fonts/Inter';
const { fontFamily } = loadFont();

// For other Google Fonts:
import { loadFont } from '@remotion/google-fonts/Poppins';   // Poppins
import { loadFont } from '@remotion/google-fonts/Roboto';    // Roboto
import { loadFont } from '@remotion/google-fonts/Manrope';   // Manrope
```

**Step 3 — Update tokens.ts with the loaded fontFamily:**
```ts
import { loadFont } from '@remotion/google-fonts/Inter';
const { fontFamily } = loadFont();

export const tokens = {
  fontHeadline: fontFamily,  // ← use this, not a string like 'Inter'
  // ... rest of tokens
};
```

**Custom/brand font (not on Google Fonts):**
```tsx
// Place font file in public/fonts/YourFont.woff2
// In Root.tsx:
import { continueRender, delayRender } from 'remotion';

const waitForFont = delayRender();
const font = new FontFace('YourFont', 'url(/fonts/YourFont.woff2)');
font.load().then(() => {
  document.fonts.add(font);
  continueRender(waitForFont);
});
```

---

## 14. staticFile — How to Reference Public Assets

`staticFile()` is Remotion's way to safely reference files in the `public/` folder. Always use it — never hardcode paths.

```tsx
import { staticFile, Img, Audio, Video } from 'remotion';

// Images
<Img src={staticFile('ui-main.png')} />
<Img src={staticFile('logo.svg')} />

// Audio
<Audio src={staticFile('audio/click.mp3')} />

// Video clips
<Video src={staticFile('clips/feature1.mp4')} />
```

**File placement rule:**
```
public/
├── ui-main.png          → staticFile('ui-main.png')
├── logo.svg             → staticFile('logo.svg')
├── audio/
│   ├── click.mp3        → staticFile('audio/click.mp3')
│   ├── whoosh.mp3       → staticFile('audio/whoosh.mp3')
│   └── ambient.mp3      → staticFile('audio/ambient.mp3')
└── clips/
    ├── feature1.mp4     → staticFile('clips/feature1.mp4')
    └── feature2.mp4     → staticFile('clips/feature2.mp4')
```

---

## 15. useFrameRange Hook

Referenced in folder structure — here is the implementation:

```ts
// hooks/useFrameRange.ts
import { useCurrentFrame } from 'remotion';

/**
 * Returns true if the current frame is within [start, end] range.
 * Useful for toggling UI states at specific frames.
 */
export const useFrameRange = (start: number, end: number): boolean => {
  const frame = useCurrentFrame();
  return frame >= start && frame <= end;
};

/**
 * Returns a 0→1 progress value within a frame range.
 */
export const useFrameProgress = (start: number, end: number): number => {
  const frame = useCurrentFrame();
  if (frame <= start) return 0;
  if (frame >= end) return 1;
  return (frame - start) / (end - start);
};
```

Usage:
```tsx
import { useFrameRange, useFrameProgress } from '../hooks/useFrameRange';

// Is button hovered right now?
const isHovered = useFrameRange(28, 55);

// How far through the loading bar animation?
const progress = useFrameProgress(60, 120); // 0.0 → 1.0
```

---

## 16. Troubleshooting Common Problems

### Preview is blank / white screen
- Check browser console for errors (F12)
- Make sure `Root.tsx` exports `RemotionRoot` as default
- Verify `src/index.ts` registers the root: `registerRoot(RemotionRoot)`

### Font not showing in preview
- You must call `loadFont()` before the composition renders
- Call it at module level in `Root.tsx`, not inside a component
- Check `@remotion/google-fonts` is installed

### Image not loading (`staticFile` returns 404)
- File must be in `public/` folder, not `src/`
- Filename is case-sensitive: `ui-Main.png` ≠ `ui-main.png`
- Run `npx remotion preview` and open browser devtools Network tab

### Video clip stuttering in preview
- Use `<OffthreadVideo>` instead of `<Video>` for smoother frame-accurate playback
- Keep individual clips under 30 seconds for best performance

### `spring()` value overshooting / going above 1
- Add `Math.min(1, spring(...))` to clamp
- Or increase `damping` (try 18–20)

### Render is slow
- Normal: Remotion renders each frame individually
- Speed up: `npx remotion render ... --concurrency=4` (uses 4 CPU cores)
- For fast draft: `--scale=0.5` renders at half resolution

### Audio out of sync
- Always use `<Sequence from={N}>` to wrap audio, not `startFrom`
- The `from` on `<Sequence>` is the global frame to start playback

### `totalFrames` not defined in orchestrator
```tsx
// In ProductDemo.tsx, get it from useVideoConfig:
const { durationInFrames } = useVideoConfig();
// Then use durationInFrames instead of totalFrames
```

---

## 17. Render Command

```bash
# Standard HD export
npx remotion render src/index.ts ProductDemo out/demo.mp4 --codec=h264

# With progress
npx remotion render src/index.ts ProductDemo out/demo.mp4 --codec=h264 --log=verbose

# Portrait (TikTok/Reels) — change composition to 1080x1920
```

---

## 18. Reference Files

- `references/animations.md` — Full code for all animation helpers (fade, slide, spring, stagger, zoom)
- `references/scenes.md` — Full implementation of HookScene, UIRevealScene, FeatureScene, CTAScene
- `references/cursor.md` — Full AnimatedCursor component with click detection
- `references/audio.md` — Sound design patterns and timing tricks
- `references/saas_narrative_templates.md` — Scene timings for premium SaaS ads (Lovio, LangEase, Teamble)
- `references/saas_ui_kit.md` — Animation patterns and code for SaaS UI components
- `references/audio_mixing_pipeline.md` — Sound design rules and VO mapping for SaaS ads
- `references/ffmpeg_export_pipeline.md` — Target specs and encoding commands for high-quality web output

Read the relevant reference file when implementing that part of the video.
