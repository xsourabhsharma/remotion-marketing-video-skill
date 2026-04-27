# SaaS Video UI Kit & Animation Patterns

Premium AI SaaS ads rely heavily on screen-space camera motion and stylized UI components rather than flat screen recordings. This document outlines the patterns and components you should build when creating a Remotion product demo.

## Core Animation Patterns
Motions should be fast but eased using `spring()` physics.
- **Small moves:** 8–16 frames.
- **Bigger transitions:** 16–24 frames.

### Common Visual Patterns
1. **Slide-in UI Panels:** From sides or bottom.
2. **Zoom-in:** On key components (cards, charts, scores).
3. **Highlighting:** Use subtle glows, outlines, or focus blur on surrounding elements.
4. **Number Increments:** Score from 9/100 to 92/100.
5. **Staggered Text:** Text appearing word-by-word or line-by-line.

## 1. Responsive Text Block
Used for large, bold headings ("Unlock actionable insights") and short, stacked phrases split over multiple lines ("Give / your team / superpowers").

```tsx
import { useCurrentFrame, interpolate, spring, useVideoConfig } from 'remotion';

export const AnimatedHeading = ({ text, startFrame }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  
  // Animate in from opacity 0 -> 1 with y-translation
  const progress = spring({
    frame: frame - startFrame,
    fps,
    config: { damping: 14, stiffness: 200 }
  });

  const translateY = interpolate(progress, [0, 1], [20, 0]);
  
  return (
    <h1 style={{
      opacity: progress,
      transform: `translateY(${translateY}px)`,
      fontFamily: 'Inter, sans-serif',
      fontWeight: 'bold',
      fontSize: '64px',
      color: '#FFFFFF'
    }}>
      {text}
    </h1>
  );
};
```

## 2. Number Ticker Component
Used for scores, percentages, and metrics.

```tsx
export const NumberTicker = ({ startValue, endValue, startFrame }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const progress = spring({
    frame: frame - startFrame,
    fps,
    config: { damping: 20, stiffness: 100 }
  });

  const currentValue = Math.floor(interpolate(progress, [0, 1], [startValue, endValue]));

  return (
    <span style={{ fontSize: '48px', fontWeight: 'bold' }}>
      {currentValue}%
    </span>
  );
};
```

## 3. Data-Driven UI Generators
Instead of static images, feed JSON data into components to generate fake cards, charts, and metrics. Use consistent spacing, corner radii, and shadows for a cohesive system look.

**Example Data Object:**
```json
{
  "score": 92,
  "labels": ["Tone: Constructive", "Specificity: High"],
  "suggestion": "Consider expanding on the strategic impact."
}
```
*Map this data to UI cards that slide in sequentially using Remotion `Sequence` components with staggered `from` values.*
