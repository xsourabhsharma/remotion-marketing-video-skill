# Shared Brain

## Project

This repository is a no-bundled-media agent skill for creating high-quality motion graphics and product demo videos with Remotion.

## Structure

- `SKILL.md` is the lean trigger and operating guide.
- `references/` contains detailed playbooks loaded only when relevant.
- `scripts/validate-skill.ps1` verifies structure and no-media constraints.
- No `assets/` directory is allowed.

## Rules

- Keep one `SKILL.md` at repository root.
- Keep detailed implementation guidance in `references/`, not in `SKILL.md`.
- Do not add media files: images, videos, audio, fonts, Lottie/Rive files, or stock assets.
- Do not create duplicate package manifests in this skill repository.
- Use ASCII text unless a file already requires another encoding.
- Prefer source-backed, current Remotion guidance for package and API recommendations.
- Run `scripts/validate-skill.ps1` after edits.
