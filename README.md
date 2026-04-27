<div align="center">
  <img src="https://raw.githubusercontent.com/remotion-dev/logo/main/with-name/remotion-logo-with-name-white.svg" alt="Remotion" width="300" />
  <h1>🎥 Remotion Product Demo Video Skill</h1>
  <p><strong>The ultimate Agent Skill for autonomously generating high-end, cinematic product demo videos.</strong></p>

  <p>
    <a href="https://github.com/remotion-dev/remotion">Remotion</a> •
    <a href="#features">Features</a> •
    <a href="#how-to-use">How to Use</a> •
    <a href="#reference-playbooks">Playbooks</a>
  </p>
</div>

---

## 🌟 Overview

The **Remotion Product Demo Video Skill** is a specialized instruction set (Agent Skill) designed for autonomous AI agents (like Claude, Gemini, or custom code buddies). When activated, it teaches the AI exactly how to architect, design, animate, and export premium product demo videos using [Remotion](https://www.remotion.dev/).

Whether you're showcasing a SaaS dashboard, a mobile app, or a sleek new AI tool, this skill gives your AI the knowledge to build "billion-dollar" motion graphics from scratch, using code.

## ✨ Premium Features

- **🎬 Universal Scene Architectures:** Pre-defined narrative structures (Hook, Reveal, Feature, Interaction, CTA).
- **🚀 AI SaaS Templates:** Exact beat-timings and motion parameters to recreate high-converting ads (inspired by industry leaders like Lovio, LangEase, and Teamble).
- **🪄 Spring-Based Physics:** Strict rules for using Remotion's `spring()` and `interpolate()` functions to create snappy, modern UI animations.
- **🖱️ Autonomous Cursor Simulation:** Built-in formulas for animating a realistic, floating cursor with hover and click states.
- **🎛️ Audio Mixing Standards:** Integrated `-16 LUFS` normalization rules and ducking pipelines for professional Voiceover syncing.
- **💻 Data-Driven UIs:** Playbooks for generating fake data and feeding it into animated React components (charts, number tickers, feedback cards).

## 📂 Repository Structure

The intelligence is distributed across the core `SKILL.md` file and specialized reference playbooks:

```bash
remotion-video-skill/
├── SKILL.md                          # The core instruction prompt for the Agent
├── README.md                         # This file
├── LICENSE                           # MIT License
└── references/                       # Premium Knowledge Playbooks
    ├── animations.md                 # Easing, springs, and sequence examples
    ├── audio_mixing_pipeline.md      # VO syncing and loudness normalization
    ├── cursor.md                     # SVG Cursor animation math
    ├── ffmpeg_export_pipeline.md     # Encoding specs for web delivery
    ├── saas_narrative_templates.md   # Script timing for premium SaaS ads
    ├── saas_ui_kit.md                # React code for data-driven UI components
    └── scenes.md                     # Full implementation of standard scenes
```

## 🚀 How to Use

### 1. Install the Skill
Simply clone or download this directory into your agent's skills folder (e.g., `~/.agents/skills/remotion-video-skill/`).

### 2. Activate the Skill
When interacting with your AI agent, activate the skill and provide your intent:
> *"Hey, activate the `remotion-product-demo-video` skill. I want to build a 30-second LangEase-style mini-tutorial video for my new AI PDF summarizer."*

### 3. Provide Your Assets
The agent will execute its intake protocol, asking you for:
- Product name and hook
- Brand colors (Hex codes)
- Font preference (e.g., Inter, Space Grotesk)
- Basic screenshots or screen recordings (to be placed in `public/`)

### 4. Watch it Build
The agent will autonomously scaffold a Remotion project, write the React components, sync the audio, and provide you with the final `npm run build` command to render your masterpiece.

---

<div align="center">
  <i>Built with precision for the modern AI workforce.</i>
</div>
