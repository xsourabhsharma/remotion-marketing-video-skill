# Motion System Reference

Use this file when implementing animation timing, transitions, scene rhythm, or camera movement.

## Core Principles

- Drive every visible change from `useCurrentFrame()` and `useVideoConfig()`.
- Use `interpolate()` for deterministic timing and `Easing.bezier()` for art-directed curves.
- Use `spring()` for physical UI pops, not for every move.
- Clamp most interpolations with `extrapolateLeft: "clamp"` and `extrapolateRight: "clamp"`.
- Derive multiple CSS properties from one normalized progress value.
- Avoid CSS transitions, CSS animations, wall-clock timers, and random values that change per render.

## Timing Presets

At `30fps`:

- Micro feedback: `5-8` frames
- Card or panel entrance: `10-16` frames
- Major scene move: `18-30` frames
- Camera push: `60-180` frames
- Text word stagger: `2-5` frames per word
- Hard cut with polish overlay: `6-12` frames

Use these curves:

```ts
import {Easing, interpolate} from "remotion";

export const curves = {
  enter: Easing.bezier(0.16, 1, 0.3, 1),
  exit: Easing.in(Easing.cubic),
  standard: Easing.bezier(0.4, 0, 0.2, 1),
  editorial: Easing.bezier(0.45, 0, 0.55, 1),
  accentPop: Easing.bezier(0.34, 1.56, 0.64, 1),
};

export const progress = (
  frame: number,
  start: number,
  duration: number,
  easing = curves.enter,
) =>
  interpolate(frame, [start, start + duration], [0, 1], {
    easing,
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });
```

## Reusable Animation Helpers

```ts
import {Easing, interpolate, spring} from "remotion";

export const fade = (p: number) => ({opacity: p});

export const rise = (p: number, distance = 28) => ({
  opacity: p,
  transform: `translateY(${interpolate(p, [0, 1], [distance, 0])}px)`,
});

export const scaleIn = (p: number, from = 0.96) => ({
  opacity: p,
  transform: `scale(${interpolate(p, [0, 1], [from, 1])})`,
});

export const cameraPush = (frame: number, duration: number, amount = 0.04) => ({
  transform: `scale(${interpolate(frame, [0, duration], [1, 1 + amount], {
    easing: Easing.inOut(Easing.cubic),
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  })})`,
});

export const springProgress = (frame: number, fps: number, start: number) =>
  Math.min(
    1,
    Math.max(
      0,
      spring({
        frame: frame - start,
        fps,
        config: {damping: 18, stiffness: 180, mass: 0.8},
      }),
    ),
  );
```

## Scene Transitions

Prefer simple transitions: fade, slide, wipe, or camera-match cuts. Use `@remotion/transitions` when the transition is part of scene structure.

```tsx
import {TransitionSeries, linearTiming} from "@remotion/transitions";
import {fade} from "@remotion/transitions/fade";

export const Scenes = () => (
  <TransitionSeries>
    <TransitionSeries.Sequence durationInFrames={90}>
      <HookScene />
    </TransitionSeries.Sequence>
    <TransitionSeries.Transition
      presentation={fade()}
      timing={linearTiming({durationInFrames: 12})}
    />
    <TransitionSeries.Sequence durationInFrames={120}>
      <ProductScene />
    </TransitionSeries.Sequence>
  </TransitionSeries>
);
```

Remember: transition duration overlaps adjacent scenes and shortens total duration. Calculate composition duration from scene durations minus transition durations.

## Choreography Rules

- Move the object that owns attention first; secondary elements follow by `2-6` frames.
- Enter faster than exit for UI elements; use stronger ease-out on entry and ease-in on exit.
- Keep exits shorter than entrances unless the exit is a narrative moment.
- Avoid animating too many large elements at once.
- Keep important text still long enough to read: at least `1.2s` for short labels and `2s+` for headline copy.
- Maintain spatial logic: if a panel slides in from the right, dismiss or transform it along a related path.

## Motion Blur and Texture

Use `@remotion/motion-blur` only for fast camera or object moves. Avoid global blur on text-heavy scenes because it reduces readability.

Use procedural texture with CSS gradients, SVG noise, `@remotion/noise`, or small generated primitives. Do not add raster texture assets to the skill.
