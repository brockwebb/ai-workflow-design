# CC Task: Rewrite and Re-render fig-02-01 Classification Routing Flowchart

**Date:** 2026-04-01
**Session:** 16
**Status:** PENDING
**Supersedes:** 2026-04-01_render_fig-02-01_paperbanana.md (figure rendered but has labeling errors — path position names appeared as literal text in boxes)

---

## Context

The first render of fig-02-01 produced a diagram where structural labels like "Left Path (Consensus)" appeared as literal text in the rendered boxes. The method file needs to describe box *content* only, without structural position references that PaperBanana might render literally. Additionally, the diagram needs to clearly distinguish logic gates (deterministic routing decisions) from model invocations (the arbitrator).

## Deliverable

### 1. Overwrite PaperBanana Method File

**File:** `assets/diagrams/paperbanana/fig-02-01_classification_routing_method.txt`

Replace entire contents with:

```
# fig-02-01: Classification Routing Flowchart

## Diagram Type
Technical flowchart. Clean, minimal, professional. Matches fig-01-01a/b style.

## Layout
Top-down flow. A single entry point feeds into a decision diamond, which branches into three distinct output paths. All three paths converge at a single output box at the bottom.

## Elements (describe content only — do not include structural labels like "left path" or "center path")

### Top — Entry Box
Rectangle: "Two Models Classify Independently"
Subtitle or smaller text below: "Same question, same taxonomy, no knowledge of each other"

### Decision Diamond
Diamond shape: "Do both models agree on topic AND subtopic?"

### Branch 1 — Agreement Path (goes to the left or whichever side looks balanced)
Arrow from diamond labeled "Yes — both agree"
Rectangle: "Auto-Accept"
Small text below box: "68.5% of classifications"
This is a logic gate. No model involved.

### Branch 2 — Confident Divergence Path (center or wherever balanced)
Arrow from diamond labeled "No — but both highly confident (≥0.90), different topics"
Rectangle: "Accept Both as Dual-Modal"
Small text below box: "11.8% of classifications"
This is a logic gate. No model involved. Both topic assignments are preserved to broaden downstream matching.

### Branch 3 — Low Confidence Disagreement Path
Arrow from diamond labeled "No — low confidence + disagreement"
Rectangle: "Escalate to Arbitrator Model"
Small text below box: "19.7% of classifications"
This is the ONLY path that invokes a third model. The arbitrator reviews both prior judgments.

### Bottom — Convergence
All three paths converge with arrows pointing to a single rectangle at the bottom: "Classified Output with Evidence Chain"

## Critical Design Notes for the Renderer
- Do NOT include any structural position labels (e.g., "Left Path", "Center Path", "Right Path") anywhere in the diagram. Each box should contain ONLY its functional label and percentage.
- The three paths should be visually balanced and clearly separated.
- The decision diamond is the central routing element. All three branches emerge from it.
- Branches 1 and 2 are logic gates (deterministic). Branch 3 is a model invocation. If possible, visually distinguish Branch 3 (e.g., slightly different box outline or a small icon) to signal that it alone uses a model. If this is too complex for the renderer, skip the visual distinction — the labels are sufficient.

## Visual Style
- Clean, sparse, professional — matches Chapter 1 figure style
- Muted colors: light gray fills, dark gray outlines and text
- No decorative elements, no gradients, no shadows
- Percentages are important — they show empirical distribution
- Sans-serif font
- Generous whitespace
- Simple thin arrows with small arrowheads

## Color Palette
- Background: white or very light warm gray (#F8F7F5)
- Box fill: light gray (#E8E8E8)
- Decision diamond fill: slightly darker gray (#D8D8D8)
- Box outline: dark gray (#333333)
- Text: black (#1A1A1A)
- Arrows: dark gray (#333333)
- Percentage text: medium gray (#666666)

## Dimensions
- Portrait orientation, roughly 2:3 aspect ratio
- Suitable for 70% page width in a book layout

## What This Is NOT
- Not a UML diagram
- Not colorful or decorative
- No icons or symbols inside boxes (unless distinguishing logic gate vs model invocation as noted above)
- No vendor names or model names — architecture only
- No structural position labels — no "left path", "right path", "center path"

## Caption
"Classification routing in the dual-model pattern. Two independent models classify each item; deterministic logic gates route based on agreement and confidence. Only disagreements with low confidence escalate to a third arbitrator model."
```

### 2. Render the Figure

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
paperbanana render assets/diagrams/paperbanana/fig-02-01_classification_routing_method.txt \
  --output book/images/fig-02-01_classification_routing.png \
  --vlm-model gemini-3.1-pro-preview \
  --image-model gemini-3.1-flash-image-preview
```

**DO NOT change model names.** Use exactly the CLI arguments above. If the model names in `model_config.yaml` differ, the CLI flags override them.

### 3. Verify

- Visual check: no structural position labels ("Left Path", etc.) in rendered diagram
- Three clear branches from decision diamond
- Percentages visible (68.5%, 11.8%, 19.7%)
- No vendor names
- Caption matches method file

## Note on Chapter Prose

The chapter prose also needs improvement to explain the design rationale for the dual-modal path (why both topics are preserved, the fuzzy matching logic). That is handled in a separate addendum CC task, not this one.
