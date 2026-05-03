# Research Sources and Current Notes

Use this file to understand why the skill recommends its current workflow. Verify current versions again before making architecture-sensitive package decisions.

## Current Checks

- Checked on `2026-05-03`: `npm view remotion version` returned `4.0.456`.
- Checked on `2026-05-03`: `@remotion/transitions`, `@remotion/preload`, `@remotion/media-utils`, `@remotion/motion-blur`, `@remotion/light-leaks`, `@remotion/sfx`, `@remotion/animated-emoji`, and `@remotion/tailwind-v4` also returned `4.0.456`.

## Remotion Sources

- Remotion installation docs: https://www.remotion.dev/docs/
  - `npx create-video@latest --yes --blank my-video`
  - `bun create video` is supported.
  - Official docs were last updated May 1, 2026 when checked.

- Remotion Studio CLI: https://www.remotion.dev/docs/cli/studio
  - `npx remotion studio` starts the Studio.
  - `npx remotion preview` is an alias.
  - `--port` sets the local HTTP server port.
  - `--no-open` prevents automatic browser opening.

- Remotion fundamentals: https://www.remotion.dev/docs/the-fundamentals
  - Video metadata is width, height, fps, and duration.
  - Frame numbers start at `0`.
  - `useVideoConfig()` exposes composition metadata.

- Remotion animation docs: https://www.remotion.dev/docs/animating-properties
  - Use `useCurrentFrame()`, `interpolate()`, and `spring()`.
  - Avoid CSS transitions/animations because rendering is frame-based.

- `Sequence` docs: https://www.remotion.dev/docs/sequence
  - `Sequence` shifts child frame time.
  - `durationInFrames` unmounts children after the range.
  - `layout="none"` is needed for inline or special contexts such as Three.

- `staticFile()` docs: https://www.remotion.dev/docs/staticfile
  - Use `staticFile()` for files in the target project's `public/` folder.
  - The `public/` folder belongs beside the Remotion `package.json`.

- `<OffthreadVideo>` docs: https://www.remotion.dev/docs/offthreadvideo
  - Uses FFmpeg to extract exact frames outside the browser during rendering.
  - Not supported in client-side rendering; use `Video` from `@remotion/media` for web renderer use cases.

- Remotion render CLI: https://www.remotion.dev/docs/cli/render
  - `npx remotion render <entry-point> <composition-id> <output-location>`.
  - Windows shells should use a props JSON file rather than inline JSON.
  - Concurrency supports integer or percentage values.
  - `--frames` can render a still or frame range for draft checks.

- Remotion still CLI: https://www.remotion.dev/docs/cli/still
  - `npx remotion still <entry-point> <composition-id> <output-location>` renders one frame.
  - `--frame` chooses the frame; negative values such as `-1` are allowed for the last frame in current docs.

- Remotion encoding guide: https://www.remotion.dev/docs/encoding
  - H.264 is the default and usually the safest social/web codec.
  - CRF controls quality for common codecs.
  - Hardware acceleration exists from Remotion `4.0.228`.

- Remotion package docs: https://www.remotion.dev/docs/transitions
  - Official package docs recommend keeping `remotion` and `@remotion/*` versions equal and removing `^` ranges.
  - `@remotion/transitions` provides `TransitionSeries`.

- Official Remotion Agent Skills: https://www.remotion.dev/docs/ai/skills and https://github.com/remotion-dev/skills
  - Remotion maintains an official skills repository for AI agents.
  - The official skill routes advanced topics into rule files.

## Platform and Motion Sources

- YouTube Shorts policy: https://support.google.com/youtube/answer/15424877
  - Square or vertical videos up to three minutes can be categorized as Shorts, with date-specific rules.

- YouTube upload encoding settings: https://support.google.com/youtube/answer/1722171
  - MP4 container, H.264 video, progressive scan, 4:2:0 chroma, AAC/Opus/Eclipsa audio, same frame rate as source, and `8 Mbps` for 1080p standard frame rate SDR uploads.

- LinkedIn video ad specs: https://www.linkedin.com/help/linkedin/answer/a424737
  - Landscape `16:9` recommends `1920x1080`.
  - Vertical `9:16` maxes at `1080x1920`.
  - Vertical `4:5` maxes at `1080x1350`.

- Material motion guidance: https://m1.material.io/motion/duration-easing.html
  - Motion should be fast enough not to create waiting, slow enough to understand.
  - Durations should vary by distance and complexity.
  - Natural motion uses smooth acceleration and deceleration.

- Apple motion guidance: https://developer.apple.com/design/human-interface-guidelines/motion
  - Motion should be purposeful, support understanding, and not become gratuitous or physically uncomfortable.

## Skill Design Sources

- Skill development best practice applied locally:
  - Keep `SKILL.md` lean.
  - Move details into `references/`.
  - Use strong trigger phrases.
  - Add validation scripts for repeatable checks.

- Agent Skills specification: https://agentskills.io/specification
  - `name` and `description` are required.
  - Names use lowercase letters, numbers, and hyphens.
  - Description should include concrete trigger keywords.
  - Keep main `SKILL.md` concise and route detailed material to references.

- GitHub CLI skill publishing docs: https://cli.github.com/manual/gh_skill_publish
  - `gh skill publish --dry-run` validates without publishing.
  - `gh skill publish --tag vX.Y.Z` publishes with a version tag.
  - The `agent-skills` repository topic helps discovery.
