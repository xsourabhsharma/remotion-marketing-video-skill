# Cursor and Interaction Reference

Use this file when simulating cursor movement, taps, hover states, clicks, drag gestures, keyboard input, or UI interaction.

## Cursor Model

Define interaction as data. Keep cursor waypoints near the scene that owns the interaction.

```ts
export type CursorWaypoint = {
  frame: number;
  x: number;
  y: number;
  event?: "move" | "hover" | "click" | "drag-start" | "drag-end";
  label?: string;
};
```

## Animated Cursor

```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from "remotion";

export const AnimatedCursor: React.FC<{
  points: CursorWaypoint[];
  color?: string;
  size?: number;
}> = ({points, color = "#fff", size = 28}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();

  const frames = points.map((point) => point.frame);
  const xs = points.map((point) => point.x);
  const ys = points.map((point) => point.y);

  const x = interpolate(frame, frames, xs, {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });
  const y = interpolate(frame, frames, ys, {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const click = points.find(
    (point) => point.event === "click" && frame >= point.frame && frame < point.frame + 10,
  );
  const clickSpring = click
    ? spring({
        frame: frame - click.frame,
        fps,
        config: {damping: 12, stiffness: 320},
      })
    : 0;

  const press = click ? interpolate(clickSpring, [0, 0.4, 1], [1, 0.78, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  }) : 1;
  const ripple = click
    ? interpolate(frame - click.frame, [0, 10], [0, 1], {
        extrapolateLeft: "clamp",
        extrapolateRight: "clamp",
      })
    : 0;

  return (
    <div style={{position: "absolute", left: x, top: y, pointerEvents: "none", zIndex: 1000}}>
      {click ? (
        <div
          style={{
            position: "absolute",
            width: size * 1.8,
            height: size * 1.8,
            border: `2px solid ${color}`,
            borderRadius: "50%",
            opacity: 0.45 * (1 - ripple),
            transform: `translate(-50%, -50%) scale(${1 + ripple})`,
          }}
        />
      ) : null}
      <svg
        width={size}
        height={size}
        viewBox="0 0 24 24"
        style={{
          transform: `translate(-3px, -3px) scale(${press})`,
          filter: "drop-shadow(0 4px 10px rgba(0,0,0,0.45))",
        }}
      >
        <path
          d="M4 2L20 10.4L12.4 12.1L10.5 20L4 2Z"
          fill={color}
          stroke="rgba(0,0,0,0.75)"
          strokeWidth="1.2"
          strokeLinejoin="round"
        />
      </svg>
    </div>
  );
};
```

## Natural Movement Rules

- Pause `6-12` frames before a click.
- Use diagonals and small arcs, not robotic axis-aligned movement.
- Add one intermediate waypoint before the target for deceleration.
- Recoil by `1-4px` after a click.
- Hide the cursor during purely cinematic scenes.
- Keep cursor scale consistent with resolution.

## Hover and Click State

Use frame ranges, not pointer events:

```tsx
const isHovered = frame >= 42 && frame <= 68;
const isPressed = frame >= 62 && frame <= 66;

const buttonStyle = {
  background: isHovered ? theme.colors.accent : theme.colors.surface,
  transform: `scale(${isPressed ? 0.98 : isHovered ? 1.015 : 1})`,
};
```

## Tap Variant for Mobile

Use a ring and contact flash instead of an arrow cursor:

```tsx
export const TapRing = ({x, y, progress}: {x: number; y: number; progress: number}) => (
  <div
    style={{
      position: "absolute",
      left: x,
      top: y,
      width: 72,
      height: 72,
      borderRadius: "50%",
      border: "3px solid rgba(255,255,255,0.9)",
      opacity: 1 - progress,
      transform: `translate(-50%, -50%) scale(${0.65 + progress * 0.8})`,
    }}
  />
);
```

## Interaction QA

- Cursor target aligns with the visible UI control at the target frame.
- Hover state starts before the click and ends after the result begins.
- Click audio, if used, starts on the click frame.
- Result animation begins within `3-8` frames after the click.
- Cursor never covers important text for more than a beat.
