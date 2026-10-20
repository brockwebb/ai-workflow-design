# CC Task: Batch K -- Pre-Publication Verification Pass

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Reference:** Sweep synthesis Batch K; `docs/2026-04-06_sweep_synthesis_run004.md`
**Batch:** K (final pre-publication verification)
**Prerequisites:** Batches A-J complete

---

## Context

Final verification pass before publication. Items are low-severity residuals from the sweep synthesis that convert `conditionally_ready` chapters to `ready`. Organized by type: formatting consistency, figure verification, content verification, and registry cleanup.

---

## Part 1 — Formatting Consistency: Horizontal Rules Before Thought Experiments

**Action:** Add `---` on a blank line before every `### Thought Experiment` heading, matching the pattern already present in Ch 8.

**Chapters requiring the addition:**
- `book/chapter-01.md` — before line ~212
- `book/chapter-02.md` — before line ~140
- `book/chapter-03.md` — before line ~123
- `book/chapter-04.md` — before line ~137
- `book/chapter-05.md` — before line ~166
- `book/chapter-06.md` — before line ~143
- `book/chapter-07.md` — before line ~131
- `book/chapter-09.md` — before line ~165
- `book/chapter-10.md` — before line ~169
- `book/chapter-11.md` — before line ~124
- `book/chapter-12.md` — before line ~163
- `book/chapter-13.md` — before line ~155
- `book/chapter-14.md` — before line ~198

**Ch 8 already has `---` at line 129. Do not duplicate.**

Pattern:
```
[preceding paragraph text]

---

### Thought Experiment
```

Ensure blank line before `---` and blank line between `---` and heading.

---

## Part 2 — Figure 14-01: Render and Deploy

**STATUS: BLOCKING.** The prior handoff (HANDOFF_2026-04-07_figure_audit_and_insertions.md) claimed fig-14-01 was rendered and deployed. Verification shows:
- `assets/diagrams/paperbanana/fig-14-01_cost_trajectory.md` — method file EXISTS
- `assets/diagrams/paperbanana/fig-14-01_cost_trajectory.png` — DOES NOT EXIST (never rendered)
- `book/images/fig-14-01_cost_trajectory.png` — DOES NOT EXIST (never deployed)
- `book/chapter-14.md` — NO `{figure}` directive for fig-14-01 (never inserted or was overwritten)

**Action (requires PaperBanana on author's machine — not a CC task):**
1. Render fig-14-01 via PaperBanana using method file `assets/diagrams/paperbanana/fig-14-01_cost_trajectory.md`
   - Remember CLI overrides: `--vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview`
   - Critic rubber-stamps (JSON parse bug) — human visual QA required
2. Copy rendered PNG to `book/images/fig-14-01_cost_trajectory.png`

**Action (CC task after render is complete):**
3. Insert `{figure}` directive into `book/chapter-14.md` after the cost comparison paragraph (around line 38, after the manual-vs-pipeline cost discussion, before `## The Cost Taxonomy`).

Figure directive:
```
::::{figure} images/fig-14-01_cost_trajectory.png
:name: fig-14-01
:alt: Cost trajectory comparison showing one-time development investment versus recurring manual processing costs over multiple survey waves
:width: 100%

Cost trajectory: AI pipeline versus manual processing. Development cost is a one-time investment; the pipeline runs each subsequent wave at marginal inference cost while manual processing incurs full labor cost every cycle.
::::
```

4. Update `book/figure-registry.md` — change fig-14-01 row status from "Method only — needs PaperBanana render" to "Deployed".

---

## Part 3 — Cost Taxonomy Count Update

**File:** `book/chapter-14.md`
**Issue:** Batch I added a 5th cost category (institutional overhead) and was supposed to update "four-category" to "five-category" at line ~79. Verify this was done. If the text still says "four-category cost taxonomy", change to "five-category cost taxonomy."

---

## Part 4 — Content Verification Queries (Perplexity)

These items require independent verification via Perplexity. The claims are probably correct but have not been independently confirmed. Author runs Perplexity queries externally; results feed back before CC execution.

### PQ-K1: NIST AI 600-1 "confabulation" terminology (CG-X1)
**Chapter:** 9, line 77
**Claim:** NIST AI 600-1 uses "confabulation" as the preferred/precise term over "hallucination"
**Query:** Does NIST AI 600-1 (Artificial Intelligence Risk Management Framework: Generative AI Profile) use "confabulation" as a formal term? What is the exact terminology used?
**If wrong:** Reframe the sentence to remove the NIST attribution for the term preference while keeping the citation for the concept.

### PQ-K2: webb_2025_opencensus_mcp behavioral drift characterization (CG-X2)
**Chapter:** 9, line 79
**Claim:** Open Census MCP project experienced "thread resets to default behavior, memory-influenced context, and system instruction updates outside user control"
**Query:** N/A — this is the author's own project. Author self-verification.
**Status:** Author can confirm or correct from memory. No Perplexity needed.

### PQ-K3: lee_2026_metaharness numbers (CG-X3)
**Chapter:** 11, line 96
**Claims:** "4.7 points on average across five models" on IMO problems; "7.7 points" on text classification; "four times fewer context tokens"
**Query:** lee_2026_metaharness (Meta-Harness) arXiv preprint — verify the specific numbers: 4.7 point improvement on IMO problems, 7.7 point improvement on text classification, 4x token reduction. Check publication status.
**If wrong:** Correct the numbers to match the source.

### PQ-K4: FCSM dimension count (CG-X5)
**Chapter:** 8, line 31
**Claim:** "FCSM-only (4 of the framework's 11 dimensions)"
**Status:** RESOLVED on audit. The text says 4 and lists 4 items (relevance, timeliness, accessibility, coherence). "Data fitness concerns" is a category label, not a 5th item. The original audit miscounted. **No action needed.**

---

## Part 5 — Items Verified and Closed (No Action)

| Item | Status | Why |
|---|---|---|
| **simmhan_2005 orphaned bib** | RESOLVED | Cited in Ch 9 line 33. Not orphaned. Synthesis was wrong. |
| **CG-F6 pricing ratios** | RESOLVED | Ch 14 line 77 already has "as of early 2026" date-anchor + disclaimer. |
| **CG-T4 knowledge graph definition** | RESOLVED | Ch 4 lines 27-33 have detailed technical distinction with formal requirements. |
| **CG-T5 chunking quality** | RESOLVED | Ch 4 line 43 has citation (chroma_2024_chunking). |
| **CG-X4 subgroup error** | RESOLVED | Ch 3 line 115 has citation (morris_2025_verasight). |
| **CG-X5 dimension count** | RESOLVED | Count is correct (4 stated, 4 listed). Audit miscounted. |
| **Author-experience reframes** | RESOLVED | Batch F completed all items. No stragglers found. |

---

## Verification

After execution:
1. Every chapter with a `### Thought Experiment` heading has `---` on the line two lines above it
2. `book/images/fig-14-01_cost_trajectory.png` exists (after PaperBanana render)
3. `book/chapter-14.md` contains a `{figure}` directive for fig-14-01
4. `book/figure-registry.md` shows fig-14-01 as "Deployed"
5. Ch 14 cost taxonomy references say "five-category" not "four-category"
6. `seldon verify` passes
7. `myst build --html` completes without errors (full build test)

---

## Execution Notes

- Part 2 (fig-14-01) is split: PaperBanana render is a manual author task, figure insertion and registry update are CC tasks. The CC portion should not execute until the PNG exists in `book/images/`.
- Part 4 (Perplexity queries) is optional for publication. PQ-K1 and PQ-K3 are the only ones that could require text changes. PQ-K2 is author self-verification. PQ-K4 is already resolved.
- Part 1 (horizontal rules) is the only purely mechanical CC task. It can execute immediately.

---

## Files Modified

| File | Change |
|------|--------|
| `book/chapter-01.md` through `book/chapter-14.md` (13 files) | Add `---` before Thought Experiment |
| `book/chapter-14.md` | fig-14-01 directive insertion (after render); verify "five-category" |
| `book/figure-registry.md` | Update fig-14-01 status to Deployed |
