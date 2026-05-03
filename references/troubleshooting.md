# Troubleshooting Reference

Use this file when preview, render, media, timing, or package behavior fails.

## Blank or White Preview

Check:

- `src/index.ts` calls `registerRoot(RemotionRoot)`.
- `Root.tsx` exports the same root used by `index.ts`.
- Composition `id` matches the render command.
- Component returns visible content at frame `0`.
- Browser console has no React/runtime error.
- Imported JSON and props match expected shapes.

## Animations Flicker or Differ Between Preview and Render

Cause:

- CSS transitions/keyframes, timers, `Date.now()`, `Math.random()`, or browser playback state.

Fix:

- Drive all values from frame number.
- Use Remotion `random(seed)` for deterministic variation.
- Replace CSS transitions with `interpolate()` or `spring()`.

## Version Conflict

Symptoms:

- Package import exists but fails at runtime.
- Remotion package warns about mismatched versions.
- Render breaks after adding a package.

Fix:

```bash
npm view remotion version
npm ls remotion
npm ls @remotion/transitions
```

Align every `remotion` and `@remotion/*` package to the same exact version. Prefer `npx remotion add <package>`.

## Media Not Loading

Check:

- File is in the target project's `public/` folder, beside the `package.json` containing Remotion.
- Path casing matches exactly.
- `staticFile("path/from/public.ext")` is used.
- No local media files were added to this skill repository.

Use `<OffthreadVideo>` for frame-accurate server-side video rendering when not targeting client-side web renderer. Use `Video` from `@remotion/media` for client-side rendering scenarios.

## Audio Out of Sync

Fix:

- Wrap audio in `Sequence from={frame}` for global timing.
- Drive scene timings from transcript/voiceover beats.
- Avoid guessing long VO durations.
- Render a short range around the sync point.

## Text Overflows

Fix:

- Use shorter copy.
- Define max widths and stable layout dimensions.
- Use a text-fitting helper for dynamic user input.
- Still-render frames where the longest text appears.
- Verify vertical and square variants separately.

## Slow Render

Fix:

- Render at `--scale=0.5` for drafts.
- Render short frame ranges while iterating.
- Remove unnecessary packages and heavy effects.
- Avoid giant shadows, blur filters, and full-canvas 3D unless needed.
- Preload media for Studio playback with `@remotion/preload` when preview stutters.

## Final QA Command Set

```bash
npx remotion still ProductVideo --frame=0 --scale=0.25
npx remotion still ProductVideo --frame=90 --scale=0.25
npx remotion render src/index.ts ProductVideo out/check.mp4 --frames=0-180 --scale=0.5
npx remotion render src/index.ts ProductVideo out/final.mp4 --codec=h264
npx remotion ffprobe -v quiet -print_format json -show_format -show_streams out/final.mp4
```
