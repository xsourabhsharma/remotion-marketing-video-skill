# Code-First UI Kit Reference

Use this file when building product visuals without bundled media assets.

## Theme Contract

Create a single theme file:

```ts
export const theme = {
  size: {width: 1920, height: 1080, fps: 30},
  color: {
    bg: "#07080b",
    surface: "#101319",
    surface2: "#171b23",
    line: "rgba(255,255,255,0.12)",
    text: "#f7f8fb",
    muted: "#9aa3b2",
    accent: "#6ee7b7",
    warning: "#f8c15c",
  },
  radius: {sm: 8, md: 12, lg: 20},
  shadow: {
    panel: "0 28px 90px rgba(0,0,0,0.45)",
    glow: "0 0 42px rgba(110,231,183,0.22)",
  },
  font: {
    sans: "Inter, system-ui, sans-serif",
    mono: "JetBrains Mono, ui-monospace, monospace",
  },
};
```

## Browser Shell

```tsx
export const BrowserShell: React.FC<{
  url?: string;
  children: React.ReactNode;
}> = ({url = "app.example.com", children}) => (
  <div
    style={{
      width: 1480,
      height: 840,
      overflow: "hidden",
      borderRadius: 18,
      background: theme.color.surface,
      border: `1px solid ${theme.color.line}`,
      boxShadow: theme.shadow.panel,
    }}
  >
    <div
      style={{
        height: 48,
        display: "flex",
        alignItems: "center",
        gap: 10,
        padding: "0 16px",
        borderBottom: `1px solid ${theme.color.line}`,
      }}
    >
      {["#ff5f57", "#febc2e", "#28c840"].map((color) => (
        <div key={color} style={{width: 12, height: 12, borderRadius: 999, background: color}} />
      ))}
      <div
        style={{
          marginLeft: 24,
          height: 28,
          minWidth: 420,
          borderRadius: 8,
          background: "rgba(255,255,255,0.06)",
          color: theme.color.muted,
          display: "flex",
          alignItems: "center",
          padding: "0 12px",
          font: `500 13px ${theme.font.sans}`,
        }}
      >
        {url}
      </div>
    </div>
    {children}
  </div>
);
```

## Dashboard Mock UI

Use real domain labels and realistic data. Avoid placeholder filler.

```tsx
const metrics = [
  {label: "Pipeline value", value: "$284K", delta: "+18%"},
  {label: "Tasks automated", value: "1,482", delta: "+41%"},
  {label: "Cycle time", value: "2.4h", delta: "-32%"},
];

export const DashboardMock = () => (
  <div style={{display: "grid", gridTemplateColumns: "260px 1fr", height: "100%"}}>
    <aside style={{padding: 24, borderRight: `1px solid ${theme.color.line}`}}>
      <div style={{font: `800 22px ${theme.font.sans}`, color: theme.color.text}}>ProductOS</div>
      {["Overview", "Automations", "Insights", "Settings"].map((item, index) => (
        <div
          key={item}
          style={{
            marginTop: index === 0 ? 34 : 10,
            padding: "12px 14px",
            borderRadius: 10,
            color: index === 1 ? theme.color.text : theme.color.muted,
            background: index === 1 ? "rgba(110,231,183,0.13)" : "transparent",
          }}
        >
          {item}
        </div>
      ))}
    </aside>
    <main style={{padding: 34}}>
      <div style={{font: `800 38px ${theme.font.sans}`, color: theme.color.text}}>
        Automations are running
      </div>
      <div style={{display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 18, marginTop: 28}}>
        {metrics.map((metric) => (
          <div key={metric.label} style={{padding: 22, borderRadius: 16, background: theme.color.surface2}}>
            <div style={{color: theme.color.muted, font: `600 14px ${theme.font.sans}`}}>{metric.label}</div>
            <div style={{color: theme.color.text, font: `800 34px ${theme.font.sans}`, marginTop: 12}}>
              {metric.value}
            </div>
            <div style={{color: theme.color.accent, font: `700 14px ${theme.font.sans}`, marginTop: 10}}>
              {metric.delta}
            </div>
          </div>
        ))}
      </div>
    </main>
  </div>
);
```

## Number Ticker

```tsx
import {interpolate, spring, useCurrentFrame, useVideoConfig} from "remotion";

export const NumberTicker = ({
  from,
  to,
  start,
  suffix = "",
}: {
  from: number;
  to: number;
  start: number;
  suffix?: string;
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const p = Math.min(1, spring({frame: frame - start, fps, config: {damping: 22, stiffness: 90}}));
  const value = Math.round(interpolate(p, [0, 1], [from, to]));
  return <>{value}{suffix}</>;
};
```

## Text Reveal Patterns

Use typewriter effects for prompts and command lines. Use word or line reveals for premium marketing copy.

```tsx
export const Typewriter = ({text, start, charsPerSecond = 22}: {
  text: string;
  start: number;
  charsPerSecond?: number;
}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const count = Math.floor(
    interpolate(frame - start, [0, (text.length / charsPerSecond) * fps], [0, text.length], {
      extrapolateLeft: "clamp",
      extrapolateRight: "clamp",
    }),
  );
  return <>{text.slice(0, count)}</>;
};
```

## 3D and Procedural Visuals

Use `@remotion/three`, `three`, and React Three Fiber for 3D only when it helps the message. Keep 3D scenes full-canvas or integrated into the composition, not trapped in decorative cards.

Use SVG and CSS gradients for:

- Data flows
- Radar sweeps
- Abstract grids
- Product architecture diagrams
- Progress rings
- Timeline paths

Do not add image, video, audio, or font assets to this skill repository.
