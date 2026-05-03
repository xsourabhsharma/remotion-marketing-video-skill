# Architecture Log

## 2026-05-03 - Skill Restructure for Remotion Motion Graphics

Restructured the repository from one oversized trigger file into a lean `SKILL.md` plus focused reference playbooks. Added no-bundled-media constraints, Remotion package version-alignment guidance, current research notes, render QA guidance, and a validation script. This improves progressive disclosure, reduces context load when the skill triggers, and gives future agents deterministic checks before publishing changes.

## 2026-05-03 - Full Video Production Workflow Upgrade

Expanded the skill from product-demo-centric Remotion guidance into a broader video production workflow covering research, intake, asset inventory, motion graphics, real-footage edits, social clips, captions, audio, browser preview, user approval, and final render QA. Added dedicated references for production planning, video-editing modes, and the Remotion Studio preview approval loop so future agents can plan and revise before rendering.

## 2026-05-03 - skills.sh Root Skill Compliance

Renamed the public skill metadata to `remotion-marketing-video`, simplified `SKILL.md` frontmatter to the required `name` and `description` fields, updated README install/use instructions for `npx skills add`, and strengthened validation for single-root-skill structure. This aligns the repository with the current Agent Skills specification and skills.sh indexing expectations while preserving the Remotion marketing video purpose.
