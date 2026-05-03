# Scene Architecture Reference

Use this file when planning story, scene order, composition duration, product type adaptations, or beat timing.

## Scene Graph Model

Represent the video as data before coding the visuals:

```ts
export type SceneKind =
  | "hook"
  | "problem"
  | "ui-reveal"
  | "feature"
  | "interaction"
  | "proof"
  | "result"
  | "cta";

export type SceneBeat = {
  id: string;
  kind: SceneKind;
  startFrame: number;
  durationInFrames: number;
  headline?: string;
  narration?: string;
  visualGoal: string;
  motionGoal: string;
};
```

Generate `startFrame` values from durations instead of hard-coding scattered offsets.

## Core Structures

### 15-Second Social Product Hit

- `0-2s` hook: problem or outcome promise.
- `2-5s` product reveal: show the interface or coded hero object.
- `5-10s` feature sequence: two fast interaction beats.
- `10-13s` proof/result: metric, generated output, before-after.
- `13-15s` CTA: product name and action.

### 30-Second Product Demo

- `0-3s` hook.
- `3-7s` UI reveal.
- `7-14s` workflow step 1.
- `14-21s` workflow step 2.
- `21-26s` result/proof.
- `26-30s` CTA.

### 60-Second SaaS Explainer

- `0-4s` problem.
- `4-8s` product positioning.
- `8-28s` three mechanism beats.
- `28-42s` outcome/proof.
- `42-54s` mini walkthrough or social proof.
- `54-60s` CTA.

## Product Type Adaptations

### Web App or SaaS Dashboard

Build a browser shell, sidebar, top nav, main canvas, cards, tables, charts, and command palette in React. Use screenshots only when the user provides real product media.

Motion language:

- Browser shell enters with `rise()` or `scaleIn()`.
- Cursor clicks one primary control.
- Cards and metrics update in staggered order.
- Camera pushes toward the result.

### AI or Prompt-Based Tool

Start with intent. Type or reveal a prompt, click generate, show streaming state, then transform into final output. Use string slicing for typewriter text and staggered lines for generated content.

### Mobile App

Create device frames in CSS. Use tap rings instead of arrow cursors. Keep text larger and touch targets obvious. Avoid tiny dashboard details inside portrait canvases.

### Developer Tool or CLI

Use monospace terminal panels, typed commands, log lines, diff highlights, and progress bars. Keep command output realistic for the domain.

### Abstract Motion Graphics

Use procedural shapes, grids, data streams, text masks, SVG paths, particles, and camera movement. Tie every abstract element to the story: chaos to order, latency to speed, scattered to organized, manual to automated.

## Composition Pattern

```tsx
import {AbsoluteFill, Sequence} from "remotion";
import {beats} from "./beats";

const sceneMap = {
  hook: HookScene,
  "ui-reveal": UIRevealScene,
  feature: FeatureScene,
  result: ResultScene,
  cta: CtaScene,
};

export const ProductVideo = () => (
  <AbsoluteFill style={{background: "#08090b"}}>
    {beats.map((beat) => {
      const Scene = sceneMap[beat.kind];
      return (
        <Sequence
          key={beat.id}
          name={beat.id}
          from={beat.startFrame}
          durationInFrames={beat.durationInFrames}
        >
          <Scene beat={beat} />
        </Sequence>
      );
    })}
  </AbsoluteFill>
);
```

## Copy Rules

- One message per scene.
- Short headline, shorter subline.
- Prefer concrete action verbs over vague claims.
- Keep UI labels legible at final platform size.
- Avoid paragraphs unless the scene is intentionally text-led.
- Make captions and on-screen copy complement each other instead of duplicating every word.

## Story Quality Checklist

- Hook states a problem, outcome, or visual surprise in the first `2s`.
- Every scene changes the viewer's understanding.
- Every cursor/tap action causes a visible result.
- Product name appears by the midpoint or earlier unless mystery is intentional.
- CTA fits the user's goal: try, book, watch, install, join, or learn.
