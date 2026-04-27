# Cursor Animation Reference — Remotion Product Demo

The animated cursor is the most important "demo feel" element. It makes screen recordings look intentional and professional.

---

## AnimatedCursor Component

```tsx
// components/AnimatedCursor.tsx
import { useCurrentFrame } from 'remotion';
import { interpolate } from 'remotion';

interface Waypoint {
  frame: number;
  x: number;
  y: number;
  click?: boolean;  // set true to trigger click animation at this frame
}

interface Props {
  waypoints: Waypoint[];
  color?: string;
  size?: number;
}

export const AnimatedCursor: React.FC<Props> = ({
  waypoints,
  color = '#ffffff',
  size = 28,
}) => {
  const frame = useCurrentFrame();

  // Extract frame/x/y arrays for interpolation
  const frames = waypoints.map(w => w.frame);
  const xs = waypoints.map(w => w.x);
  const ys = waypoints.map(w => w.y);

  const x = interpolate(frame, frames, xs, { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' });
  const y = interpolate(frame, frames, ys, { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' });

  // Detect nearest click waypoint
  const clickWaypoint = waypoints.find(w => w.click && Math.abs(frame - w.frame) < 8);
  const clickProgress = clickWaypoint
    ? Math.min(1, Math.max(0, (frame - clickWaypoint.frame) / 6))
    : 0;

  // Click animation: cursor shrinks then springs back
  const clickScale = clickWaypoint
    ? 1 - Math.sin(clickProgress * Math.PI) * 0.3
    : 1;

  // Ripple effect on click
  const rippleOpacity = clickWaypoint
    ? Math.max(0, 1 - clickProgress)
    : 0;
  const rippleScale = clickWaypoint ? 1 + clickProgress * 2 : 1;

  return (
    <div
      style={{
        position: 'absolute',
        left: x,
        top: y,
        pointerEvents: 'none',
        zIndex: 9999,
        transform: `translate(-4px, -4px)`, // offset to cursor tip
      }}
    >
      {/* Ripple on click */}
      {rippleOpacity > 0 && (
        <div
          style={{
            position: 'absolute',
            width: size * 2,
            height: size * 2,
            borderRadius: '50%',
            border: `2px solid ${color}`,
            opacity: rippleOpacity * 0.5,
            transform: `scale(${rippleScale}) translate(-50%, -50%)`,
            left: size / 2,
            top: size / 2,
          }}
        />
      )}

      {/* Cursor SVG */}
      <svg
        width={size}
        height={size}
        viewBox="0 0 24 24"
        style={{ transform: `scale(${clickScale})`, filter: `drop-shadow(0 2px 8px rgba(0,0,0,0.5))` }}
      >
        <path
          d="M4 2L20 10L12 12L10 20L4 2Z"
          fill={color}
          stroke="#000"
          strokeWidth="1"
          strokeLinejoin="round"
        />
      </svg>
    </div>
  );
};
```

---

## Defining Waypoints

Plan cursor movement as a storyboard. Each waypoint = position at a specific frame.

```tsx
// In your ProductDemo.tsx or scene file
const cursorWaypoints = [
  { frame: 0,   x: 200,  y: 800 },           // start off-center
  { frame: 20,  x: 500,  y: 500 },           // move to input box
  { frame: 30,  x: 500,  y: 500 },           // hover (pause here while typing)
  { frame: 60,  x: 900,  y: 540, click: true }, // move to Send button, click
  { frame: 80,  x: 600,  y: 300 },           // move up to watch result
  { frame: 120, x: 300,  y: 600 },           // move to sidebar
  { frame: 130, x: 300,  y: 620, click: true }, // click sidebar item
  { frame: 160, x: 1200, y: 400 },           // move to feature panel
];
```

**Tips for natural cursor movement:**
- Always pause (repeat same x,y for 8–12 frames) before clicking — it feels human
- Move diagonally, not straight horizontal/vertical
- Slow down near targets (add an intermediate waypoint 20px before target)
- After clicking, move cursor slightly away (1–2 pixels "recoil" waypoint)

---

## Cursor with Highlight Ring (spotlight effect)

```tsx
// Add a soft highlight ring around cursor for dark UIs
<div
  style={{
    position: 'absolute',
    width: 60,
    height: 60,
    borderRadius: '50%',
    background: 'radial-gradient(circle, rgba(255,255,255,0.08) 0%, transparent 70%)',
    transform: 'translate(-50%, -50%)',
    left: x,
    top: y,
    pointerEvents: 'none',
    zIndex: 9998,
  }}
/>
```

---

## Click Sound Sync

```tsx
// In your main video component, sync audio to click frames
{cursorWaypoints.filter(w => w.click).map((w, i) => (
  <Audio
    key={i}
    src={staticFile('audio/click.mp3')}
    startFrom={0}
    // Only play at the click frame
    volume={frame >= w.frame && frame < w.frame + 24 ? 1 : 0}
  />
))}
```

Better approach — use Sequence:
```tsx
{cursorWaypoints.filter(w => w.click).map((w, i) => (
  <Sequence key={i} from={w.frame} durationInFrames={24}>
    <Audio src={staticFile('audio/click.mp3')} volume={0.8} />
  </Sequence>
))}
```

---

## Hover State Simulation

When cursor is near a button, make the button change state:

```tsx
const isHovering = (
  Math.abs(cursorX - buttonX) < 40 &&
  Math.abs(cursorY - buttonY) < 20
);

<button style={{
  background: isHovering ? '#4f46e5' : '#3730a3',
  transform: isHovering ? 'scale(1.02)' : 'scale(1)',
  transition: 'none', // NO CSS transitions in Remotion
}}>
  Send
</button>
```

Replace with frame check:
```tsx
const hoverStartFrame = 28;
const hoverEndFrame = 60;
const isHovering = frame >= hoverStartFrame && frame <= hoverEndFrame;
```
