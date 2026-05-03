# Project Setup Reference

Use this file when scaffolding a Remotion project, installing packages, or aligning dependencies.

## Start From Existing Project

Inspect first:

```powershell
Get-ChildItem -Force
Get-Content package.json
Get-ChildItem src -Recurse -Filter Root.tsx
```

Use the existing package manager based on lockfiles:

- `bun.lockb` or `bun.lock` -> Bun
- `pnpm-lock.yaml` -> pnpm
- `yarn.lock` -> Yarn
- `package-lock.json` -> npm

## New Project

Prefer the user's package manager. For a clean local Remotion project:

```bash
npx create-video@latest --yes --blank my-product-demo
cd my-product-demo
npm i
npm run dev
```

Bun is supported by Remotion:

```bash
bun create video my-product-demo
cd my-product-demo
bun install
bun run dev
```

When prompted, choose TypeScript. Tailwind is optional; Remotion animations still need frame-based values rather than Tailwind animation classes.

## Preview Server

For substantial video work, start Remotion Studio and inspect the localhost preview before final render:

```bash
npx remotion studio --port=3000
```

Use a project script when it exists:

```bash
npm run dev
pnpm dev
bun run dev
```

If the port is busy, choose another port or let Remotion pick one. Open the Studio URL in the browser, select the target composition, check representative frames, and revise before asking for final render approval.

## Package Installation

Install packages only when the current video needs them:

```bash
npx remotion add @remotion/transitions
npx remotion add @remotion/media
npx remotion add @remotion/google-fonts
npx remotion add @remotion/motion-blur
npx remotion add @remotion/three
npx remotion add @remotion/preload
```

Do not install an "everything" bundle. It slows projects, increases version-conflict risk, and makes generated code harder to audit.

If manual installation is necessary, pin exact versions and keep all `remotion` and `@remotion/*` packages equal:

```bash
npm view remotion version
npm i --save-exact remotion@<version> @remotion/cli@<version> @remotion/transitions@<version>
```

## Recommended Structure

```text
src/
  Root.tsx
  index.ts
  ProductVideo.tsx
  beats.ts
  theme.ts
  scenes/
    HookScene.tsx
    ProductRevealScene.tsx
    FeatureScene.tsx
    ResultScene.tsx
    CtaScene.tsx
  components/
    BrowserShell.tsx
    AnimatedCursor.tsx
    Typewriter.tsx
    MetricCard.tsx
    CaptionLayer.tsx
  data/
    transcript.json
```

Media supplied by the user belongs in the target project's `public/` folder, never in this skill repository.

Recommended target project asset layout:

```text
public/
  audio/
  footage/
  logos/
  screens/
  stills/
src/
  data/
    beats.ts
    transcript.json
```

Keep a short asset inventory in the target project notes or README when licensing, provenance, or user-provided files matter.

## Root Composition

```tsx
import {Composition} from "remotion";
import {ProductVideo} from "./ProductVideo";
import {theme} from "./theme";

export const RemotionRoot = () => (
  <Composition
    id="ProductVideo"
    component={ProductVideo}
    durationInFrames={theme.durationInFrames}
    fps={theme.fps}
    width={theme.width}
    height={theme.height}
  />
);
```

Use `calculateMetadata()` when duration, dimensions, or props depend on external data.

## Approval Rule

Use still renders and short range renders for development QA. Do not run the complete final render until the user approves the Studio preview and confirms the output path.
