# Production Workflow Reference

Use this file when the user asks for a new video, a major edit, a motion graphics piece, a marketing video, or an unclear "make this better" request. The goal is to make the agent behave like a producer, editor, and motion designer before it behaves like a renderer.

## First Move

Classify the job:

- New video from scratch
- Edit existing footage
- Product or UI demo
- Motion graphics explainer
- Social short or ad
- Captions/subtitles
- Audio mix or voiceover-led edit
- Render/debug/export task

Then decide what must be researched before building: current platform specs, Remotion package/API docs, brand/product context, examples in the user's niche, licensing needs, or video style references.

## Creative Brief

Write a compact brief before coding:

```md
Objective:
Audience:
Platform:
Duration:
Aspect ratio:
Core message:
Hook:
Story beats:
Visual style:
Motion language:
Audio plan:
Assets available:
Assets missing:
Risks:
Acceptance checks:
```

Use concrete defaults when the user is unsure, but mark assumptions clearly. Do not stall on preferences that can be adjusted in preview.

## Questions to Ask

Ask only for missing information that blocks a good result:

- What is the video for: ad, launch, tutorial, social clip, explainer, demo, presentation, or internal use?
- Who is watching, and what should they do after watching?
- What platform and aspect ratio should be targeted?
- What must appear on screen: product UI, person, logo, footage, captions, metrics, CTA, legal text?
- Are there brand colors, fonts, tone rules, or style references?
- Are there user-provided assets or should the agent generate/code placeholders?
- Is voiceover, music, SFX, or silent caption-first playback expected?
- Where should the final approved render be saved?

If the user has no assets, offer a code-first mock, generated imagery, or a clear asset request list. If the user's requested video depends on a real product, do not fake exact UI claims without labeling them as mock visuals.

## Asset Inventory

Create an inventory table:

| Asset | Status | Location | Notes |
| --- | --- | --- | --- |
| Logo | provided/missing/generated | `public/logo.svg` | transparent preferred |
| UI screenshot | provided/missing/mock | `public/screens/main.png` | 1920px wide minimum |
| Footage | provided/missing | `public/footage/source.mp4` | trim points needed |
| Voiceover | provided/generated/missing | `public/audio/voiceover.wav` | transcript needed |
| Music/SFX | provided/licensed/missing | `public/audio/` | license required |
| Captions | provided/generated | `src/data/transcript.json` | word timings preferred |

Store media only in the target Remotion project. Keep this skill repository text-only.

## Plan Before Editing

For motion graphics and product videos, write a beat sheet. For real footage, write an edit decision list.

Beat sheet fields:

- `id`
- `startFrame`
- `durationInFrames`
- `narrativeGoal`
- `visual`
- `motion`
- `audio`
- `assetRefs`

Edit decision list fields:

- source file
- in/out timestamps
- target scene
- transition
- crop/reframe
- caption text
- audio treatment

## Build Order

1. Set project structure and package versions.
2. Create design tokens and composition metadata.
3. Build still frames for each major beat.
4. Add motion choreography.
5. Add footage, captions, and audio.
6. Start Remotion Studio for localhost preview.
7. Inspect in browser and fix visible issues.
8. Ask the user for review.
9. Make revisions.
10. Render final only after explicit approval and output path confirmation.

## Approval Gate

Do not render the complete final video until the user approves the preview. It is acceptable to render stills or short ranges for QA. When ready for approval, give the user:

- Local Studio URL
- Composition name
- Frames or timestamps checked
- Known limitations
- Proposed final render path
- Exact render command that will be run after approval

