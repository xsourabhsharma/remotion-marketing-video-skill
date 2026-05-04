# Remotion Marketing Video Skill

[![skills.sh](https://skills.sh/b/xsourabhsharma/remotion-marketing-video-skill)](https://skills.sh/xsourabhsharma/remotion-marketing-video-skill)

An Agent Skill for creating premium Remotion-based marketing videos with React and code-first animation. It helps agents plan, build, preview, revise, and render product demos, SaaS promos, UI walkthroughs, social ads, explainers, captioned clips, and motion graphics for software products.

Use this skill when an agent needs a structured video-production workflow: research and brief, asset inventory, scene planning, design tokens, deterministic Remotion animation, browser/Studio preview, user approval, and final render QA.

## Install

Install the skill with the open `skills` CLI:

```bash
npx skills add xsourabhsharma/remotion-marketing-video-skill
```

To install globally or target a specific agent, use the standard skills CLI flags:

```bash
npx skills add xsourabhsharma/remotion-marketing-video-skill -g
npx skills add xsourabhsharma/remotion-marketing-video-skill -a claude-code
npx skills add xsourabhsharma/remotion-marketing-video-skill -a codex
```

## Use In Claude Code And Other Agents

After installation, check the agent's skill list. In Claude Code or compatible agent UIs, use `/skills` if supported, or run:

```bash
npx skills list
```

Then ask for a Remotion marketing video. The root skill is:

```text
remotion-marketing-video
```

## Example Prompts

```text
Use the remotion-marketing-video skill to create a 30-second SaaS product demo for my AI analytics app.
```

```text
Build a vertical social ad in Remotion from these product screenshots, with captions, cursor motion, and a final CTA.
```

```text
Plan and implement a premium UI walkthrough video for my web app, then start Remotion Studio for review before rendering.
```

```text
Turn this landing page copy into a code-first motion graphics explainer with Remotion and React.
```

```text
Improve my existing Remotion promo: tighten the hook, fix timing, add captions, preview locally, and prepare the render command.
```

## What The Skill Includes

- One root-level `SKILL.md` following the Agent Skills specification.
- Focused reference playbooks under `references/`.
- A PowerShell validator under `scripts/validate-skill.ps1`.
- No bundled media assets, credentials, fonts, screenshots, audio, or video.

## Repository Structure

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

## Validate

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-skill.ps1
```

The validator checks the root `SKILL.md` frontmatter, Agent Skills naming rules, single-skill structure, referenced files, accidental bundled media, and common text-quality issues.

## Discoverability

For skills.sh and `npx skills` discovery, this repository should remain:

- Public on GitHub.
- Tagged with the GitHub topic `agent-skills`.
- Focused on one root skill: `remotion-marketing-video`.
- Released or tagged with a version such as `v1.1.0`.

## Contributing

To extend the skill:

- Keep one root-level `SKILL.md`; do not add nested `SKILL.md` files unless intentionally turning the repo into a multi-skill collection.
- Keep the main `SKILL.md` concise and route detailed guidance to `references/`.
- Add new templates as focused reference files, such as `references/youtube_launch_ads.md` or `references/mobile_app_promos.md`.
- Do not commit generated media, user assets, API keys, `.env` files, fonts, screenshots, videos, or audio.
- Run the validator before opening a PR or publishing a release.
