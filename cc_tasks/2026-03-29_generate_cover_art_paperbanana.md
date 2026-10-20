# CC Task: Generate Book Cover Art via PaperBanana

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Executor:** Claude Code

---

## Context

Generate book cover art using PaperBanana. The cover should be an abstract risograph-style illustration depicting workflow/pipeline patterns — branching paths, decision diamonds, convergence points — in steel blue, dark terracotta, and black on a cream background. This is decorative art, not a technical diagram, so the method.txt is adapted accordingly.

PaperBanana reference instructions at `/Users/brock/Documents/GitHub/central_library/paperbanana_cc_instruct.md`.

## Instructions

### 1. Create PaperBanana working directory

```
assets/diagrams/paperbanana/
```

### 2. Create `.env` in the working directory

Copy from the ai4stats PaperBanana setup:
```bash
cp /Users/brock/Documents/GitHub/ai4stats/assets/diagrams/paperbanana/.env \
   /Users/brock/Documents/GitHub/ai-workflow-design/assets/diagrams/paperbanana/.env
```

Verify it contains `GOOGLE_API_KEY` (not just `GEMINI_API_KEY`). If only `GEMINI_API_KEY` exists:
```bash
grep -q "^GOOGLE_API_KEY" .env || grep GEMINI_API_KEY .env | sed 's/GEMINI_API_KEY/GOOGLE_API_KEY/' >> .env
```

### 3. Create method file: `cover_art_method.txt`

Create `assets/diagrams/paperbanana/cover_art_method.txt` with the following content:

```
# Book Cover Art: AI Workflow Design for Official Statistics

## Overview

This is an abstract decorative book cover illustration, NOT a technical diagram. It should evoke the concepts of workflow design, parallel processing, and decision architecture without being literally readable as a flowchart. The aesthetic is risograph print art — textured, imperfect, and artistic.

## Composition

A vertically-oriented abstract composition (8.5 x 11 portrait aspect ratio) featuring:

- A central branching structure: a single vertical flow line that splits into 2-3 parallel paths, weaves through diamond-shaped nodes, and reconverges. The paths should cross and interweave, suggesting parallel processing and decision routing.
- Diamond shapes at intersection points suggesting decision nodes — varying sizes, not uniform.
- The overall composition should be ASYMMETRIC — weighted toward the upper-left, with open negative space in the lower-right quadrant for text overlay (title and author name will be placed there).
- Scattered small dots and faint grid lines as background texture, sparse and subtle.
- The composition fills roughly 60% of the canvas. The remaining 40% is intentional negative space.

## Color Palette (strictly limited)

- Steel blue (muted, not bright — approximately #4A7C8F)
- Dark terracotta/burnt sienna (approximately #C45D3E)
- Black (#1A1A1A)
- Background: warm cream/off-white (#F5F0E8)

NO other colors. Where blue and terracotta overlap, the overprint should darken naturally (not create a new hue like purple or green). Black is used for the main flow lines and smallest elements.

## Texture and Style

- Risograph print aesthetic: visible halftone dot grain across all colored areas
- Slight ink misregistration — colored fills are offset 1-2px from their outlines
- Paper texture visible throughout, including within colored shapes
- Imperfections: small ink spatter dots, uneven edges on shapes
- NO gradients, NO drop shadows, NO 3D/isometric perspective
- All elements are flat geometric forms
- Think: mid-century modern poster meets technical blueprint

## What This Is NOT

- NOT a readable flowchart or technical diagram — no labels, no text, no arrows with labels
- NOT symmetric or perfectly centered
- NOT clean/sterile/corporate — it should feel hand-printed
- NOT busy — fewer elements with more breathing room, not more elements
- NOT 3D or isometric — strictly flat/2D

## Accessibility Note

The three colors (steel blue, terracotta, black) must be distinguishable in grayscale. They have intentionally different luminance values: steel blue (medium-light), terracotta (medium), black (dark).
```

### 4. Run PaperBanana

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design/assets/diagrams/paperbanana

paperbanana generate \
  --input cover_art_method.txt \
  --caption "Book cover art for AI Workflow Design for Official Statistics" \
  --vlm-model gemini-3.1-pro-preview \
  --image-model gemini-3.1-flash-image-preview \
  --iterations 3
```

### 5. Review output

Output will be at:
```
assets/diagrams/paperbanana/outputs/run_YYYYMMDD_HHMMSS_xxxxxx/final_output.png
```

**CRITICAL: The PaperBanana critic rubber-stamps almost everything. Do visual QA manually.** Open the output and evaluate:
- Does it look like risograph art or a clean vector diagram?
- Is the color palette correct (blue, terracotta, black on cream)?
- Is there sufficient negative space for text overlay?
- Is it asymmetric or rigidly centered?

If the output looks too "diagrammatic" and not enough like art, this approach may not work for cover art and we revert to the DALL-E candidates.

### 6. If successful, deploy

```bash
cp assets/diagrams/paperbanana/outputs/<run_id>/final_output.png book/images/cover-art.png
```

### 7. Register with Seldon

- `assets/diagrams/paperbanana/cover_art_method.txt` — type: Document
- `book/images/cover-art.png` — type: Figure (only if output is accepted)

Record the PaperBanana run ID in the figure registry.

---

## Notes

- This is an experimental use of PaperBanana — it's designed for academic diagrams, not decorative art. Manage expectations.
- If Gemini produces something too clinical/diagrammatic, the DALL-E Image 2 candidate (blue/terracotta/black diamond grid with weaving lines) is the fallback.
- The cover image is cosmetic and does not block any book content work.
- Known PaperBanana config issue: `model_config.yaml` has `gemini-3.1-pro` which 404s. Always use `gemini-3.1-pro-preview` via the CLI flag.
