---
name: remotion-product-demo-video
description: This skill should be used when the user asks to create, edit, plan, preview, or render video with Remotion, including motion graphics, product demos, SaaS promos, UI walkthroughs, social ads, explainers, kinetic typography, captions, screen-recording edits, podcast clips, real-footage edits, trailers, 3D motion, audio/SFX, FFmpeg exports, or video QA.
version: 1.1.0
license: MIT
compatibility: Requires a local Node or Bun Remotion project. Use Remotion Studio/browser preview before final render and ffmpeg/ffprobe for QA.
metadata:
  author: xsourabhsharma
  repository: https://github.com/xsourabhsharma/claude-marketing-video-remotion
  tags: remotion, motion-graphics, video-editing, product-demo, social-video, captions, ffmpeg
---

# Remotion Video Production and Motion Design

Create, edit, and finish high-quality videos with Remotion and supporting media tools. Cover the full agent workflow: research, brief, asset inventory, storyboard, motion design, editing, captions, audio, localhost Studio preview, user review, revision, approved render, and export QA.

Optimize for clear story, strong visual hierarchy, deterministic frame-based animation, reusable design systems, licensed assets, and production-ready delivery. Do not bundle media assets with this skill; create visuals in code and use user-provided, generated, or licensed media only inside the target video project.

## Operating Rules

Start by identifying whether the request is for a product demo, SaaS ad, UI walkthrough, social short, explainer, motion graphics piece, kinetic typography edit, real-footage edit, podcast clip, tutorial, trailer, 3D/data visualization, captioning job, audio mix, render, or debugging task.

For new videos or significant edits, produce a researched creative plan before implementation. Include objective, audience, platform, duration, aspect ratio, story beats, asset needs, motion language, audio plan, risks, and acceptance checks.

Gather assets before building. Inventory user-provided screenshots, recordings, footage, logos, brand files, voiceover, music, SFX, captions, fonts, and copy. If required assets are missing and cannot be safely generated or sourced, ask the user for those assets with exact filenames and target folders.

Prefer code-first visuals: React layouts, SVG, CSS drawing, Canvas/WebGL, data-driven charts, cursor simulation, captions, and procedural backgrounds. Avoid adding local media files, stock assets, sample MP3s, sample MP4s, logos, fonts, or screenshots to the skill.

Animate only with Remotion time: `useCurrentFrame()`, `useVideoConfig()`, `interpolate()`, `Easing`, `spring()`, `Sequence`, `Series`, and `TransitionSeries`. Avoid CSS transitions, CSS keyframes, Tailwind animation classes, timers, random values without `random()`, or browser-only playback assumptions.

Respect the existing project. Inspect `package.json`, `src/Root.tsx`, existing components, renderer config, and package manager before scaffolding. Use one package manager per project. Install only the packages needed for the requested video.

Keep all `remotion` and `@remotion/*` packages on the exact same version. Prefer `npx remotion add <package>` because it aligns package versions. When manually installing, pin exact versions and remove `^` ranges.

Start Remotion Studio for substantial video work and open the localhost preview in a browser. Inspect representative frames and revise before final export. Draft stills and short range renders are allowed for QA; do not final-render the complete video until the user approves the preview and confirms the output path.

## Intake

Collect only the information needed to start:

- Product, subject, edit concept, or source footage
- Goal, audience, platform, and success metric
- Duration and aspect ratio
- Hook or opening idea
- Three to six story beats, edit beats, or feature moments
- Brand colors, typography, style references, and tone
- Existing assets: footage, screenshots, recordings, logos, voiceover, music, SFX, transcripts, captions, copy, and legal/licensing constraints
- Required CTA, export specs, and final deliverable path

Use sensible defaults when the user is unsure:

- Landscape SaaS/web demo: `1920x1080`, `30fps`, `25-45s`
- Vertical social short: `1080x1920`, `30fps`, `15-35s`
- Square feed clip: `1080x1080`, `30fps`, `10-30s`
- Podcast/interview clip: `1080x1920`, `30fps`, `30-90s`
- Explainer/motion graphics: `1920x1080`, `30fps`, `30-75s`
- Hook within first `2s`
- Scene changes every `2-5s`
- One primary idea per scene

If no product screenshots or recordings exist, build a realistic mock UI in React from the product description. Use domain-specific sample data, not lorem ipsum.

## Build Workflow

1. Research and brief.
   Verify current Remotion APIs, platform specs, and visual references when the request depends on current best practices or exact specs. Write the creative plan before coding.

2. Define the scene graph.
   Write a beat sheet with `id`, `startFrame`, `durationInFrames`, `narrativeGoal`, `visual`, `motion`, and optional `audio`.

3. Establish a design system.
   Create `src/theme.ts` or `src/tokens.ts` with canvas size, colors, type scale, spacing, radii, shadows, z-index layers, and motion curves. Keep visual decisions centralized.

4. Prepare assets.
   Place user-approved media in the target project's `public/` folder, create transcript JSON or edit decision lists when needed, and keep provenance notes for externally sourced media.

5. Build static frames first.
   Make every scene look polished at representative frames before adding motion. Use `npx remotion still <composition> --frame=<n> --scale=0.25` for fast checks.

6. Add deterministic motion and editing.
   Use normalized progress values, clamp interpolation, reuse easing curves, and keep spring overshoot intentional. Give entrances, exits, camera movement, cursor actions, and text reveals their own named timing constants.

7. Add interaction language.
   Simulate cursor movement, taps, hover states, active controls, loading, typing, streaming, data updates, and result reveals. Motion must explain cause and effect.

8. Add captions/audio only when available or requested.
   Accept user-provided audio or generated voiceover outputs, but do not store media in this skill. Use code-generated captions from transcript JSON or word timing data.

9. Preview and revise.
   Start Remotion Studio, open the local preview in the browser, inspect representative frames and playback, collect user feedback, and make requested tweaks.

10. Render after approval.
   After the user approves the preview and output path, render the final video. Probe with `npx remotion ffprobe` or `ffprobe`. Check dimensions, codec, frame rate, duration, audio presence, and file size.

## Reference Routing

Load the smallest relevant reference file:

- `references/production_workflow.md` - Research brief, intake, asset inventory, creative plan, and approval workflow.
- `references/video_editing_modes.md` - Motion graphics, real-footage edits, social clips, explainers, trailers, tutorials, podcast clips, and other video types.
- `references/preview_approval_loop.md` - Remotion Studio localhost preview, browser inspection, feedback loops, and final render approval.
- `references/project_setup.md` - Scaffolding, package alignment, folder structure, and environment setup.
- `references/scenes.md` - Story structures, scene graph patterns, and product-type adaptations.
- `references/animations.md` - Easing, springs, transitions, camera moves, and frame math.
- `references/saas_ui_kit.md` - Code-first UI shells, charts, counters, cards, dashboards, and responsive composition patterns.
- `references/cursor.md` - Cursor, tap, hover, click, and interaction simulation.
- `references/audio.md` - Audio, SFX, captions, transcript timing, and no-bundled-media rules.
- `references/ffmpeg_export_pipeline.md` - Rendering, encoding, platform outputs, and QA commands.
- `references/troubleshooting.md` - Blank frames, asset paths, media sync, slow renders, and version conflicts.
- `references/research_sources.md` - Current source-backed Remotion and platform notes.

Specialized references:

- `references/saas_narrative_templates.md` - High-conversion SaaS ad beat templates.
- `references/audio_mixing_pipeline.md` - Voiceover-driven timing and loudness workflow.
- `references/local_ai_integration.md` - Optional local transcription and voiceover workflow without bundling media.
- `references/anthropic_design.md` - Editorial minimal motion language for tasteful inspiration, not brand copying.

## Quality Gates

Before final delivery, confirm:

- No local media assets were added to the skill repository.
- `SKILL.md` remains lean and routes details to references.
- All referenced files exist.
- No mojibake, unfinished placeholder markers, or broken Markdown links remain.
- Creative plan, asset inventory, and acceptance criteria exist for new or significant videos.
- Remotion Studio preview was opened locally for substantial builds.
- User approved the preview and output path before the complete final render.
- Remotion packages are version-aligned.
- TypeScript compiles.
- At least one still render was inspected for layout.
- Final render command is documented and was run only after approval.
- Output is probed for dimensions, duration, codec, and frame rate.

Run the repository validator after editing this skill:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-skill.ps1
```
