---
name: remotion-marketing-video
description: "Create premium marketing videos using Remotion and React, including product demos, SaaS promos, UI walkthroughs, and social ads."
---

# Remotion Marketing Video

Create premium Remotion-based marketing videos with React, code-first animation, and deterministic frame timing. Use this skill to plan, build, preview, revise, and render product demos, SaaS promos, UI walkthroughs, launch videos, social ads, explainers, captioned clips, and motion graphics for software products.

The skill focuses on video production workflow, story structure, scene choreography, visual design systems, asset handling, browser/Studio preview, and render QA. Keep media assets in the target Remotion project, not in this skill repository.

## When To Use This Skill

Use this skill when the user asks to:

- Create a Remotion marketing video, product demo, SaaS promo, launch video, app showcase, or UI walkthrough.
- Turn screenshots, screen recordings, product copy, a landing page, or a Figma/app concept into a scripted video.
- Build motion graphics, kinetic typography, captions, cursor animations, social ads, or explainer scenes with React.
- Improve or debug an existing Remotion video, including timing, composition, preview, rendering, or export quality.
- Plan video structure before implementation, including hooks, beats, transitions, aspect ratios, and asset requirements.

Do not use this skill for unrelated video editing tasks that do not involve Remotion, React, code-generated graphics, or marketing/product storytelling.

## Core Workflow

1. Clarify the video goal.
   Identify product, audience, platform, duration, aspect ratio, CTA, available assets, missing assets, brand style, and final output path.

2. Produce a short creative brief before coding.
   Include objective, target viewer, hook, story beats, visual style, motion language, asset inventory, audio/caption plan, risks, and acceptance criteria.

3. Plan the scene graph.
   Define each scene as data with `id`, `startFrame`, `durationInFrames`, `narrativeGoal`, `visual`, `motion`, `audio`, and `assetRefs`. Generate timings from beat durations instead of scattering hard-coded frame offsets.

4. Build a design system.
   Centralize canvas size, fps, colors, typography, spacing, radii, shadows, z-index layers, and motion curves in `src/theme.ts` or `src/tokens.ts` inside the target Remotion project.

5. Create static frames first.
   Make representative frames visually polished before adding motion. Use Remotion still renders for fast layout checks.

6. Add deterministic animation.
   Drive visible changes from `useCurrentFrame()`, `useVideoConfig()`, `interpolate()`, `Easing`, `spring()`, `Sequence`, `Series`, and `TransitionSeries`. Avoid CSS transitions, CSS keyframes, timers, and unseeded randomness.

7. Add interaction and editing language.
   Use cursor movement, tap rings, hover states, typing effects, generated states, timeline edits, zooms, captions, callouts, and result reveals to make cause and effect clear.

8. Preview before final render.
   Start Remotion Studio, open the localhost preview in a browser, inspect representative frames/playback, gather feedback, and revise. Draft stills and short range renders are allowed for QA.

9. Render only after approval.
   Do not render the complete final video until the user approves the preview and confirms the output path. After rendering, probe the output for dimensions, codec, frame rate, duration, audio stream, and file size.

## Script And Scene Structure

For most marketing videos, use this default arc:

1. Hook: show the problem, desired outcome, or surprising product value in the first `1-2s`.
2. Reveal: show the product, UI, workflow, or generated visual system by `3-6s`.
3. Mechanism: demonstrate two or three concrete actions or transformations.
4. Proof: show result, before/after, metric, generated output, saved time, or quality lift.
5. CTA: end with product name, tagline, and one action.

Keep one main idea per scene. Make scene changes every `2-5s` unless the request is intentionally slow, cinematic, or voiceover-led. Ensure every cursor/tap action causes a visible result within a few frames.

## Visual And Motion Guidelines

- Prefer code-first visuals: React UI shells, SVG, CSS drawing, Canvas/WebGL, charts, captions, diagrams, procedural backgrounds, cursor/tap simulation, and animated data.
- Use real product screenshots or recordings when the user provides them. If they are missing, build a realistic mock UI from the product description and clearly treat it as a mock.
- Keep text readable at the target platform size. Use short headlines, large captions for vertical social, and safe-area-aware placement.
- Use motion to explain hierarchy and causality. Move the object that owns attention first; stagger secondary elements by a few frames.
- Keep Remotion packages version-aligned. Prefer `npx remotion add <package>` when adding official Remotion packages.
- Keep all media in the target project `public/` folder and reference it with `staticFile()`.

## Reference Files

Load only the smallest relevant file:

- `references/production_workflow.md` - Research brief, intake, asset inventory, creative plan, and approval workflow.
- `references/video_editing_modes.md` - Motion graphics, real-footage edits, social clips, explainers, tutorials, podcast clips, and other video types.
- `references/preview_approval_loop.md` - Remotion Studio localhost preview, browser inspection, feedback loops, and final render approval.
- `references/project_setup.md` - Scaffolding, package alignment, folder structure, and environment setup.
- `references/scenes.md` - Story structures, scene graph patterns, and product-type adaptations.
- `references/animations.md` - Easing, springs, transitions, camera moves, and frame math.
- `references/saas_ui_kit.md` - Code-first UI shells, dashboards, charts, counters, cards, and responsive composition patterns.
- `references/cursor.md` - Cursor, tap, hover, click, and interaction simulation.
- `references/audio.md` - Audio, SFX, captions, transcript timing, and no-bundled-media rules.
- `references/ffmpeg_export_pipeline.md` - Rendering, encoding, platform outputs, and QA commands.
- `references/troubleshooting.md` - Blank frames, asset paths, media sync, slow renders, and version conflicts.
- `references/research_sources.md` - Source-backed Remotion, skills.sh, Agent Skills, and platform notes.

## Useful Commands

Run commands from the target Remotion project, not from this skill repository:

```bash
npx remotion studio --port=3000
npx remotion still ProductVideo --frame=90 --scale=0.25
npx remotion render src/index.ts ProductVideo out/check.mp4 --frames=0-180 --scale=0.5 --codec=h264
npx remotion render src/index.ts ProductVideo out/final.mp4 --codec=h264
npx remotion ffprobe -v quiet -print_format json -show_format -show_streams out/final.mp4
```

Run this repository's validator after editing the skill:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-skill.ps1
```
