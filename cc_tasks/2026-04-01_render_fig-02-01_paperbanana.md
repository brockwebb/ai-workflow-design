# CC Task: Render Classification Routing Flowchart — Chapter 2

**Date:** 2026-04-01
**Session:** 16
**Status:** PENDING

---

## Context

Chapter 2 (Classification & Coding Workflows) is the most case-study-dense chapter in the book and has zero figures. The three-path classification routing logic (consensus / dual-modal / arbitration) with empirical percentages is the central design pattern of the chapter and needs a visual.

## Deliverables

### 1. PaperBanana Method File

**File:** `assets/diagrams/paperbanana/fig-02-01_classification_routing_method.txt`

Write the following content:

```
# fig-02-01: Classification Routing Flowchart

## Diagram Type
Technical flowchart. Clean, minimal, professional. Matches fig-01-01a/b style.

## Layout
Top-down flow. Single entry point branches into three routing paths.

## Elements

### Entry
1. Rectangle at top: "Dual-Model Classification" — both models classify independently

### Decision Node
2. Diamond or rounded decision node: "Models Agree?"

### Three Routing Paths

**Left Path — Consensus (68.5%)**
3. Arrow labeled "Yes, same topic + subtopic" pointing down-left
4. Rectangle: "Auto-Accept"
5. Small text below: "High confidence, no review needed"

**Center Path — Dual-Modal (11.8%)**
6. Arrow labeled "Both confident (≥0.90), different topics" pointing straight down
7. Rectangle: "Assign Primary + Secondary"
8. Small text below: "Higher confidence → primary topic"

**Right Path — Arbitration (19.7%)**
9. Arrow labeled "Disagree, low confidence" pointing down-right
10. Rectangle: "Escalate to Arbitrator"
11. Small text below: "More capable model reviews both judgments"

### Output
12. All three paths converge to a single output rectangle at bottom: "Classified Output with Evidence Chain"

## Visual Style
- Clean, sparse, professional — matches Chapter 1 figure style
- Muted colors: light gray fills, dark gray outlines and text
- No decorative elements, no gradients, no shadows
- Percentages in parentheses on the path labels are important — they show the empirical distribution
- Sans-serif font (e.g., Inter, Helvetica, or similar clean typeface)
- Generous whitespace around all elements
- Arrows are simple, thin, with small arrowheads
- The three paths should be visually balanced, with the center path (smallest percentage) narrower

## Color Palette
- Background: white or very light warm gray (#F8F7F5)
- Box fill: light gray (#E8E8E8)
- Decision node fill: slightly darker gray (#D8D8D8)
- Box outline: dark gray (#333333)
- Text: black (#1A1A1A)
- Arrows: dark gray (#333333)
- Percentage labels: medium gray (#666666)

## Dimensions
- Portrait orientation, roughly 2:3 aspect ratio (taller than wide)
- Suitable for 70% page width in a book layout

## What This Is NOT
- Not a UML diagram
- Not colorful or decorative
- No icons or symbols inside boxes
- No vendor names or model names — architecture only
- Not cluttered — three clear paths from one decision point

## Caption
"Classification routing in the dual-model pattern. Independent models classify each item; routing is determined by agreement level and confidence scores."
```

### 2. Render the Figure

Run PaperBanana to render the method file:

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
paperbanana render assets/diagrams/paperbanana/fig-02-01_classification_routing_method.txt \
  --output book/images/fig-02-01_classification_routing.png \
  --vlm-model gemini-3.1-pro-preview \
  --image-model gemini-3.1-flash-image-preview
```

### 3. Add Figure Reference to Chapter 2

In `book/chapter-02.md`, insert the figure after the "Arbitration (19.7%)" paragraph in the §Dual-Model Cross-Validation section (after the line ending "...hide the ambiguity from you entirely."):

```markdown
```{figure} images/fig-02-01_classification_routing.png
:name: fig-02-01
:alt: Classification routing flowchart showing three paths: consensus (68.5%), dual-modal assignment (11.8%), and arbitration (19.7%)
:width: 70%

Classification routing in the dual-model pattern. Independent models classify each item; routing is determined by agreement level and confidence scores.
```​
```

## Verification

- Confirm method file exists at `assets/diagrams/paperbanana/fig-02-01_classification_routing_method.txt`
- Confirm rendered image exists at `book/images/fig-02-01_classification_routing.png`
- Confirm figure directive is properly inserted in `book/chapter-02.md`
- Visual check: three clear paths, percentages visible, no vendor names
- Run `seldon verify`
