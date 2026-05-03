# Preview and Approval Loop Reference

Use this file whenever building or substantially changing a video. The agent must make preview review easy before final render.

## Studio Preview

Start Remotion Studio from the target project:

```bash
npx remotion studio --port=3000
```

If the port is busy, let Remotion choose a free port or set another one:

```bash
npx remotion studio --port=3001
```

Use the project package manager script when present:

```bash
npm run dev
pnpm dev
bun run dev
```

Open the localhost URL in the browser and inspect the selected composition. Prefer the in-app browser when available. Reload after code changes if hot reload misses an update.

## Browser Inspection

Check:

- Composition is visible in the sidebar.
- Canvas is not blank.
- Representative frames render without runtime errors.
- Layout fits the target aspect ratio.
- Text does not overlap or overflow.
- Captions stay inside safe areas.
- Cursor/tap targets align with visible UI.
- Audio controls and video media load when expected.
- Browser console has no blocking errors.

Use screenshots for visual confirmation when layout matters. Use console logs only to diagnose errors, not as the main quality signal.

## Fast Render Checks

Still renders are allowed before user approval:

```bash
npx remotion still ProductVideo --frame=0 --scale=0.25
npx remotion still ProductVideo --frame=90 --scale=0.25
npx remotion still ProductVideo --frame=-1 --scale=0.25
```

Short draft ranges are allowed for sync and motion QA:

```bash
npx remotion render src/index.ts ProductVideo out/check.mp4 --frames=0-180 --scale=0.5 --codec=h264
```

Label these as draft checks. Do not treat them as final delivery.

## User Review Message

When ready for review, report:

```md
Preview is running at: http://localhost:<port>
Composition: <composition-id>
Checked frames: <list>
Draft range checked: <timestamp range or none>
Remaining choices: <music/copy/export/path/etc.>
Final render path proposed: <path>
```

Ask for approval only when the next step is the complete final render, or when a missing asset blocks progress.

## Final Render Approval

Before final render, require:

- User approval of the preview.
- Confirmed output path.
- Confirmed export format or platform preset.
- Confirmation that any user-provided assets may be included in the render.

After approval, run the final render and probe the file:

```bash
npx remotion render src/index.ts ProductVideo out/final.mp4 --codec=h264
npx remotion ffprobe -v quiet -print_format json -show_format -show_streams out/final.mp4
```

If QA fails, fix and re-preview the affected section before replacing the approved final output.

