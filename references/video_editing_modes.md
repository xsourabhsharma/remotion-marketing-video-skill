# Video Editing Modes Reference

Use this file when adapting the workflow to different kinds of video. Pick the relevant mode and load other references only as needed.

## Motion Graphics Explainer

Use for abstract ideas, workflows, systems, data, AI, finance, infrastructure, or product concepts without real footage.

Plan:

- Define a visual metaphor: chaos to order, bottleneck to flow, raw input to polished output, manual steps to automation.
- Build procedural shapes, grids, text masks, SVG paths, charts, particles, and 3D only when it helps understanding.
- Keep copy sparse and legible.
- Use transitions that carry meaning: merge, split, reveal, scan, trace, zoom, connect.

Quality checks:

- Every abstract motion has narrative purpose.
- Main text stays readable for at least `1.2-2s`.
- Fast particles, flashes, or camera shakes do not strobe.

## Product Demo or SaaS Promo

Use for software, websites, apps, AI tools, dashboards, and launch videos.

Plan:

- Show the user problem or desired outcome in the first `2s`.
- Reveal the product by `3-6s`.
- Demonstrate cause and effect with cursor/tap interaction.
- Show proof: result screen, before/after, metric, saved time, or user-ready output.
- End with product name and CTA.

Use code-first UI when assets are missing; use real screenshots or recordings when the user provides them.

## Screen Recording Edit

Use for tutorials, app walkthroughs, course clips, and demos made from captured UI.

Plan:

- Ask for source recordings and target trim points.
- Clean the timeline: remove dead time, speed up waits, zoom into key controls, add callouts, hide sensitive content.
- Use captions and chapter labels for clarity.
- Add cursor highlights only where the real cursor is hard to follow.

Use Remotion for overlays, zooms, captions, and compositing. Use FFmpeg for rough trimming or extraction when faster.

## Social Short or Ad

Use for TikTok, Reels, Shorts, X, LinkedIn, and paid social.

Plan:

- Hook in the first `1-2s`.
- One idea per scene.
- Large typography, safe areas, and high contrast.
- Captions for muted playback.
- Rhythm every `1-3s`: cut, zoom, text reveal, result change, or sound hit.
- CTA matched to platform: follow, try, install, book, save, comment, or watch.

Check mobile legibility by still-rendering dense caption frames and previewing at reduced size.

## Kinetic Typography

Use for quote videos, voiceover-led explainers, manifesto videos, lyric-style typography without copyrighted lyric reproduction, and announcement clips.

Plan:

- Time text to voiceover or beat markers.
- Break script into short phrase groups.
- Use hierarchy: anchor word, support phrase, micro label.
- Keep layout stable enough to read.
- Use masks, tracking, scale, and camera moves with restraint.

Avoid showing too much text at once. Transcribe voiceover when timestamps are missing.

## Real-Footage or Cinematic Edit

Use for footage-based promos, event recaps, interviews, testimonials, tutorials, and b-roll edits.

Plan:

- Build an edit decision list from source clips.
- Choose pacing: montage, narrative, interview-led, tutorial, or teaser.
- Trim dead air.
- Stabilize story with lower thirds, captions, labels, and scene cards.
- Use color correction or LUTs in FFmpeg or the source editor when needed.
- Keep audio continuity stronger than visual novelty.

Remotion is strongest for graphics, overlays, captions, layout, compositing, and programmatic variants. Use FFmpeg for media extraction, conversion, loudness, and final compatibility passes.

## Podcast, Interview, or Talking-Head Clip

Use for repurposing long audio/video into short clips.

Plan:

- Identify the strongest hook sentence.
- Use transcript-driven cuts.
- Add speaker labels only when needed.
- Use active-word captions and subtle emphasis.
- Reframe to vertical with face-safe crop if allowed by source framing.
- Add b-roll or motion graphics only when it clarifies the point.

## 3D, Data, and Technical Visualization

Use when spatial understanding, product architecture, data flow, or premium motion language matters.

Plan:

- Use `@remotion/three`, SVG, or Canvas for deterministic visuals.
- Keep camera motion purposeful.
- Use labels and callouts so the viewer understands the model.
- Avoid decorative 3D that competes with the message.

## Captioning and Localization

Use for subtitle-only jobs, accessibility, social clips, and translated versions.

Plan:

- Generate or import word timings.
- Keep captions inside safe areas.
- Split long lines.
- Avoid covering faces, UI controls, or legal text.
- Still-check crowded frames.

## Render or Debug Task

Use when the user only needs export, broken preview, package mismatch, media loading, or render troubleshooting.

Plan:

- Reproduce the issue.
- Check package versions and composition IDs.
- Render stills before full renders.
- Use short frame ranges for diagnostics.
- Probe final output metadata.

