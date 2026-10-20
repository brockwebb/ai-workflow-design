# CC Task: Create Chapter 3 Figure — Data Quality Pipeline Routing

**Date:** 2026-04-01
**Session:** 18
**Status:** PENDING

---

## Context

Chapter 3 (Data Wrangling & Standardization Workflows) has zero figures across ~3,500 words of prose covering five distinct data quality sub-tasks. The chapter's thesis is that the design discipline is routing each sub-task to the right tool: LLMs for semantic reasoning, traditional methods for statistical properties. A single figure showing this routing architecture ties the chapter together visually.

---

## Deliverables

### 1. PaperBanana Method File

**File:** `assets/diagrams/paperbanana/fig-03-01_data_quality_routing_method.txt`

Write the following content:

```
# fig-03-01: Data Quality Pipeline Routing

## Diagram Type
Technical flow diagram. Clean, minimal, professional. Matches fig-01-01 and fig-02-01 style.

## Layout
Left-to-right flow. Messy input on the left, clean output on the right. A central routing zone splits sub-tasks into two lanes: "Semantic Reasoning (LLM)" and "Statistical Methods (Traditional)." Verification checkpoints sit between the lanes and the output.

## Elements

### Input
1. Rectangle on far left, slightly rough/informal styling: "Messy Input"
   Small text below: "Wrong codes, inconsistent formats, missing values, open-ended text"

### Routing Zone (center, takes up most of the diagram width)

Two horizontal swim lanes, stacked vertically:

**Top Lane — "Semantic Reasoning (LLM-Assisted)"**
Contains four boxes arranged horizontally:
2. "Code Correction" — small text: "Dual-model verification"
3. "Schema Inference" — small text: "LLM proposes, human reviews"
4. "Format Extraction" — small text: "Heterogeneous documents"
5. "Theme Extraction" — small text: "Hybrid: LLM + consolidation"

**Bottom Lane — "Statistical Methods (Traditional)"**
Contains two boxes:
6. "Imputation" — small text: "MICE, Fellegi-Holt, hot-deck"
7. "Continuous Correction" — small text: "Bounds, ratios, distributions"

### Routing Arrows
8. From "Messy Input," arrows fan out to the appropriate boxes in each lane. The arrow splits at a decision-like fork point labeled "Task Type?"
   - Arrows to top lane boxes: solid lines
   - Arrows to bottom lane boxes: solid lines
   - The fork makes clear that routing is a design decision, not automatic

### Verification Checkpoint
9. A vertical dashed line between the routing zone and the output, labeled "Verification"
   Small annotations along this line:
   - Next to top lane: "Dual-model agreement, human review queue, provenance log"
   - Next to bottom lane: "Distributional checks, edit constraints"

### Output
10. Rectangle on far right, clean/formal styling: "Standardized Output"
    Small text below: "Verified, provenance-tracked, audit-ready"

### Design Principle Callout (optional, only if it fits without clutter)
11. A small text annotation below the diagram, italicized:
    "LLMs handle semantic reasoning. Traditional methods handle statistical properties. The design discipline is routing each sub-task to the right tool."

## Visual Style
- Clean, sparse, professional — matches Chapter 1 and 2 figure style
- Muted colors: light gray fills, dark gray outlines and text
- The two swim lanes should be visually distinct but not garish:
  - Top lane (LLM): very light blue-gray background (#EBF0F5)
  - Bottom lane (Traditional): very light warm gray (#F5F0EB)
- No decorative elements, no gradients, no shadows
- Sans-serif font (e.g., Inter, Helvetica, or similar clean typeface)
- Generous whitespace around all elements
- Arrows are simple, thin, with small arrowheads
- The dashed verification line should be visually prominent but not heavy

## Color Palette
- Background: white or very light warm gray (#F8F7F5)
- LLM lane background: light blue-gray (#EBF0F5)
- Traditional lane background: light warm gray (#F5F0EB)
- Box fill within lanes: white (#FFFFFF)
- Box outline: dark gray (#333333)
- Text: black (#1A1A1A)
- Small text / annotations: medium gray (#666666)
- Arrows: dark gray (#333333)
- Verification dashed line: medium gray (#888888)

## Dimensions
- Landscape orientation, roughly 3:2 aspect ratio (wider than tall)
- Suitable for full page width in a book layout

## What This Is NOT
- Not a UML diagram
- Not a decision tree (the routing is a design decision, not a runtime conditional)
- No vendor names or model names — architecture only
- No icons or clipart
- Not cluttered — the two lanes and the routing concept must be immediately legible
- The boxes inside the lanes are NOT sequential steps — they are parallel sub-tasks that each receive routed input

## Caption
"Data quality pipeline routing. Semantic reasoning tasks route to LLM-assisted methods with dual-model verification; statistical tasks route to traditional methods with distributional checks. The design discipline is matching each sub-task to the right tool."
```

### 2. Render the Figure

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
paperbanana render assets/diagrams/paperbanana/fig-03-01_data_quality_routing_method.txt \
  --output book/images/fig-03-01_data_quality_routing.png \
  --vlm-model gemini-3.1-pro-preview \
  --image-model gemini-3.1-flash-image-preview
```

### 3. Add Figure Reference to Chapter 3

In `book/chapter-03.md`, insert the figure at the end of the opening hook section ("The Code Says 999999"), after the paragraph ending "...single-model confidence is even less trustworthy than it was for clean classification." and before `## Response Code Correction`:

```markdown
```{figure} images/fig-03-01_data_quality_routing.png
:name: fig-03-01
:alt: Data quality pipeline routing diagram showing semantic reasoning tasks routed to LLM-assisted methods and statistical tasks routed to traditional methods, with verification checkpoints
:width: 100%

Data quality pipeline routing. Semantic reasoning tasks route to LLM-assisted methods with dual-model verification; statistical tasks route to traditional methods with distributional checks. The design discipline is matching each sub-task to the right tool.
```​
```

### 4. Register as Seldon Artifact

After render, register the figure:
```bash
seldon artifact create --type Figure --name "fig-03-01" --path "book/images/fig-03-01_data_quality_routing.png" --description "Data quality pipeline routing diagram for Chapter 3"
seldon link create --source fig-03-01 --target chapter-03 --type contains
```

---

## Verification

- Confirm method file exists at `assets/diagrams/paperbanana/fig-03-01_data_quality_routing_method.txt`
- Confirm rendered image exists at `book/images/fig-03-01_data_quality_routing.png`
- Confirm figure directive is properly inserted in `book/chapter-03.md`
- Visual check: two lanes clearly labeled, routing fork visible, verification checkpoint present, no vendor names
- Confirm no em-dashes introduced in the figure directive text
- Run `seldon verify --fix`

---

## Acceptance Criteria

- [ ] Method file written
- [ ] Figure rendered via PaperBanana
- [ ] Figure directive inserted in chapter-03.md at correct location
- [ ] Figure registered as Seldon artifact with `contains` edge to chapter-03
- [ ] Visual: two swim lanes (semantic vs statistical) clearly distinct
- [ ] Visual: routing fork from messy input is legible
- [ ] Visual: verification checkpoint visible between lanes and output
- [ ] No vendor names, no model names, no clutter
- [ ] `seldon verify` passes
