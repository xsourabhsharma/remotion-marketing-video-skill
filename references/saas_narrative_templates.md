# AI SaaS Ad Narrative Templates

When asked to create a premium SaaS ad (like Lovio, LangEase, or Teamble), use these specialized narrative structures. These templates define the exact timing and sequence of scenes for Remotion.

## 1. Problem → Solution → Outcome (Lovio Style)
*Duration: ~70-75 seconds | ~8-12 distinct beats*
This structure is perfect for high-level brand intros or major feature launches.

**Structure:**
1. **Hook (2–3s):** Start with a problem-first hook ("You don't start with a product. You start with a problem.").
2. **Reveal (4–5s):** Introduce the product with a simple phrase ("Meet [Product].").
3. **Mechanism (12–15s):** 2–3 beats explaining how it works in simple steps. Show UI panels sliding in from the sides or bottom.
4. **Outcome (4–6s):** Language about speed, scale, or quality ("Generate structure instantly", "See it working").
5. **CTA (3–5s):** Invite to start, try, or sign up.

**Remotion Implementation (`Scene` Graph):**
```typescript
export type SceneType = 'ProblemHook' | 'Reveal' | 'Mechanism' | 'Outcome' | 'CTA';

export interface Scene {
  id: string;
  startFrame: number;
  durationInFrames: number; // Target: 72 frames for 3s (at 24fps)
  type: SceneType;
  props: any;
}
```

## 2. Mini-Tutorial (LangEase Style)
*Duration: ~20-30 seconds | 3-5 distinct beats*
Best for showing a quick "aha" moment or feature snippet.

**Structure:**
1. **Time Promise (2-3s):** "I'll show you how in under 30 seconds."
2. **Step 1 (Input) (4-5s):** "Drop in any document, video, or audio."
3. **Step 2 (AI Transformation) (4-5s):** "AI translates into multiple languages instantly."
4. **Step 3 (Extra Value) (4-5s):** "Need subtitles or voiceover? We've got that."
5. **Outcome & CTA (3-5s):** "Try it now."

## 3. Workflow Transformation (Teamble / Bud Style)
*Duration: ~90-100 seconds | Many micro-beats (2-4s each) driven by UI steps*
Best for data-heavy apps, dashboards, or complex workflows that involve AI analysis.

**Structure:**
1. **Current Behavior (4s):** Show raw text / poor feedback / manual process.
2. **AI Analysis (10s):** Scores, labels (Specificity, Tone, Actionability), insights popping up.
3. **AI Suggestions (10s):** Re-written text, generated assets, dashboards sliding over.
4. **Impact (4s):** Better scores (e.g., Number ticker animating from 9/100 to 92/100), automated output.

**Beat Timing Guidelines:**
- **Hook:** 2-3 seconds.
- **Each Step:** 4-6 seconds.
- **Visual Transformations:** At most every 3-4 seconds to keep attention.
