# Remotion Product Demo Video Skill

An agent skill for creating and editing premium Remotion videos: motion graphics, product demos, SaaS promos, UI walkthroughs, social ads, explainers, kinetic typography, screen-recording edits, podcast clips, captions, audio/SFX workflows, and export QA.

This repository intentionally contains no bundled media assets. The skill teaches agents to build visuals in code first, and to use user-provided screenshots, audio, recordings, logos, or generated files only inside the target Remotion project.

## What This Skill Improves

- Code-first motion graphics with React, SVG, CSS, data, and Remotion timing.
- Research-backed creative plans, asset inventories, and approval gates.
- Product demo and general video-editing structures for 15s, 30s, 60s, and longer videos.
- Deterministic animation rules using frames, not CSS transitions.
- Version-safe package guidance for `remotion` and `@remotion/*`.
- Cursor/tap simulation, captions, audio timing, localhost Studio preview, render approval, QA, and troubleshooting.
- Source-backed notes from current Remotion docs, official Remotion skills, npm package checks, and platform upload specs.

## Structure

```text
SKILL.md
references/
  production_workflow.md
  video_editing_modes.md
  preview_approval_loop.md
  project_setup.md
  scenes.md
  animations.md
  saas_ui_kit.md
  cursor.md
  audio.md
  audio_mixing_pipeline.md
  saas_narrative_templates.md
  ffmpeg_export_pipeline.md
  troubleshooting.md
  local_ai_integration.md
  anthropic_design.md
  research_sources.md
scripts/
  validate-skill.ps1
```

## Use

Copy or clone this folder into an agent skills directory, then ask for work such as:

```text
Use the remotion-product-demo-video skill to create a 30-second SaaS product demo.
```

The agent should load `SKILL.md`, then load only the reference files needed for the task.

## Validate

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-skill.ps1
```

The validator checks frontmatter, `SKILL.md` size, referenced files, mojibake, unfinished placeholder markers, and accidental bundled media files.

## Publish Readiness

For skills.sh/GitHub discovery, keep:

- A valid `SKILL.md` with clear `name` and `description`.
- A focused README with usage and validation.
- A license file.
- No bundled user media or credentials.
- GitHub topics such as `agent-skills`, `remotion`, `motion-graphics`, and `video-editing`.

Recommended local checks before publishing:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-skill.ps1
gh skill publish --dry-run  # requires a GitHub CLI build that includes gh skill
```

## Current Research Snapshot

As of May 3, 2026, `npm view remotion version` reported `4.0.456`, and checked `@remotion/*` companion packages matched that version. Always verify current versions before critical package edits.
