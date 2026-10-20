# Handoff: AI Workflow Design — Session 11

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Foreword → Introduction Reclassification — Designed and CC Task Written

Identified that `book/foreword.md` is functionally an Introduction (problem framing, philosophy, reader orientation) while `book/intro.md` was a two-sentence placeholder. The TOC in `myst.yml` already has both files in the correct order (`foreword.md` → `intro.md` → `chapter-01.md`), so no TOC change needed.

**Design decisions:**
- **New `foreword.md`**: Brief personal note + AI-assisted authoring statement + acknowledgments (ai4stats pattern). Half a page.
- **New `intro.md`**: Current foreword content restructured as Introduction, with a new **roadmap section** ("How This Book Is Organized") that:
  - Names the five-phase structural arc explicitly (Foundations → Domain Workflows → Cross-Cutting Patterns → Validity & Infrastructure → Institutional Context)
  - Gives each of all 14 chapters a 2–3 sentence preview using actual thesis/hooks from drafted content
  - Suggests entry points for four reader profiles (statisticians, software engineers, managers, experienced practitioners)
  - Includes predecessor book (ai4stats) relationship

**CC task:** `2026-03-30_foreword_and_introduction.md` — **NOT YET EXECUTED**

### Chapter 3 Redesigned and CC Task Written

The original Ch 3 concept ("Data Cleaning & Imputation Workflows") was critically assessed and found weak: LLMs are not the right tool for statistical imputation. Traditional methods (MICE, hot-deck, Fellegi-Holt) preserve distributional properties, respect survey design effects, and are theoretically well-understood.

**Key insight from discussion:** The real LLM value in the data quality pipeline is **semantic reasoning over messy human input** — not imputation. Brock identified concrete use cases from Census operations:
- Response code correction (NAICS, SOC, NAPCS — respondents self-code badly)
- Semantic analysis of open-ended responses (public comments, free-text fields)
- Schema inference and data combination (auto-generating schemas, figuring out how to join disparate files)
- Format extraction and standardization (data arriving in Excel, Notepad, Word — extract and stuff into a target schema)

**Chapter redesigned as:** "Data Wrangling & Standardization Workflows"

**Design decisions:**
- **Opening hook:** "The Code Says 999999" — respondent self-reported garbage NAICS code with a perfectly clear free-text description. 200,000 records need correction at scale.
- **Fine-tuning cost trap section:** Some agencies are fine-tuning HuggingFace SLMs for NAICS/NAPCS coding. The total cost of ownership (training data curation, compute, retraining on taxonomy updates, MLOps overhead) almost always exceeds API approach costs — but be honest about when fine-tuning IS the right call (data sensitivity, latency, offline requirements).
- **SLM addendum:** If forced down the local deployment path, don't wait for hardware — build pipeline and benchmarks against public/synthetic data in parallel with procurement. SLM landscape is evolving fast; design patterns (dual-model, confidence routing) are model-agnostic by construction.
- **Where traditional methods still win:** Explicit boundary — LLMs wrangle (semantic reasoning), traditional methods impute (statistical properties). The Tian 2025 paper cited as evidence that even the best case for LLM imputation is narrow (categorical only, 40x slower).
- **Relationship to Ch 2:** Ch 2 is clean-input classification against fixed taxonomies. Ch 3 is dirty-input wrangling where the data itself is the problem. Different problem shape, overlapping patterns.

**CC tasks:**
- `2026-03-30_draft_chapter_03.md` — **NOT YET EXECUTED**
- `2026-03-30_addendum_chapter_03_slm_guidance.md` — **NOT YET EXECUTED**

### Structural Audit Finding: Ch 3 and Ch 4 Were Placeholders

While building the roadmap, discovered that **Ch 3 and Ch 4 are placeholder working notes, not drafted prose**. The Session 10 handoff table listed them as "Drafted" — this was inaccurate. Ch 3 is now addressed (redesigned and CC task written). Ch 4 remains a placeholder.

### Book Title Discussion

Brock raised whether the title should say "GenAI" instead of "AI" since the book is specifically about LLM/generative AI workflows. Assessment: **keep "AI" in the title.** Three reasons: (1) federal policy/governance uses "AI" as the umbrella term (OMB, NIST, FCSM), (2) design principles apply broader than GenAI alone, (3) "GenAI" as a term may age poorly. The Introduction can include an explicit scope statement that the book focuses on generative AI / LLMs specifically.

---

## CC Tasks Written This Session (3 files)

1. `2026-03-30_foreword_and_introduction.md` — **NOT YET EXECUTED**
2. `2026-03-30_draft_chapter_03.md` — **NOT YET EXECUTED**
3. `2026-03-30_addendum_chapter_03_slm_guidance.md` — **NOT YET EXECUTED**

**Execution order:** Run 1 first (foreword/intro), then 2 and 3 together (Ch 3 draft + addendum).

---

## Current State of the Repo

### Chapter Status (Corrected)

| Chapter | Status |
|---------|--------|
| Foreword | CC task written for new brief foreword (personal note + acknowledgments) |
| Introduction | CC task written for full introduction with roadmap (from old foreword content) |
| Ch 1: Why Design Matters | Drafted (Session 4), citations converted (Session 5) |
| Ch 2: Classification & Coding | Drafted (Session 6) |
| Ch 3: Data Wrangling & Standardization | **CC task written, NOT YET EXECUTED** (redesigned from "Data Cleaning & Imputation") |
| Ch 4: Detection & Extraction | **PLACEHOLDER ONLY — needs design and drafting** |
| Ch 5: Ensemble & Multi-Model Playbook | Drafted (Session 7) |
| Ch 6: Parallel, Serial, Bottleneck | Drafted (Session 9) |
| Ch 7: Checkpoints, Failures, Recovery | Drafted (Session 9) |
| Ch 8: Evaluation by Design | Drafted (Session 7) |
| Ch 9: State, Drift, Validity | Drafted (Session 9) |
| Ch 10: State Mgmt & Provenance | Drafted (Session 10) |
| Ch 11: Workflow Orchestration | Drafted (Session 10) |
| Ch 12: Security & Supply Chain | Drafted (Session 5) |
| Ch 13: Institutional Deployment | Drafted (Session 5) |
| Ch 14: Cost & Practicality | Drafted (Session 6) |

### Chapters Not Yet Drafted
- **Ch 4: Detection & Extraction** — placeholder with working notes. Includes strong KG "confidence laundering" thesis. Needs design session.

### CC Tasks on Disk
Previously executed (Sessions 1–10): 36 files
Written this session (not yet executed): 3 files
**Total on disk: 39**

---

## Key Design Decisions This Session

1. **Foreword is personal note + acknowledgments; Introduction gets the intellectual orientation + roadmap.** TOC already correct.
2. **Ch 3 redesigned from "Data Cleaning & Imputation" to "Data Wrangling & Standardization."** LLMs are not imputation tools. They're semantic reasoning tools for dirty-input correction, schema inference, format extraction, and open-ended response analysis.
3. **Fine-tuning cost trap is a design argument, not an opinion.** Total cost of ownership for fine-tuned SLMs almost always exceeds API approach — but be honest about exceptions (data sensitivity, offline requirements).
4. **SLM practical advice:** Build pipeline and benchmarks on public/synthetic data in parallel with hardware procurement. Don't let procurement be a blocking dependency.
5. **Book title stays "AI" not "GenAI."** Federal ecosystem uses "AI" as umbrella term. Introduction can scope explicitly to GenAI/LLMs.
6. **Ch 3 and Ch 4 were placeholders, not drafts.** Session 10 handoff was inaccurate on this point. Corrected.

---

## What's Next

### Immediate: Execute CC Tasks (3 pending)

1. `2026-03-30_foreword_and_introduction.md`
2. `2026-03-30_draft_chapter_03.md`
3. `2026-03-30_addendum_chapter_03_slm_guidance.md`

### Then: Chapter 4 Design and Draft

Ch 4 (Detection & Extraction) remains a placeholder. Working notes include strong material:
- Entity extraction, pattern detection, disclosure review assistance
- Recall vs. precision tradeoffs in statistical contexts
- KG as "confidence laundering machine" — extraction pipelines that look authoritative and are structurally wrong
- SFV sub-dimensions applied to extraction: compression fidelity, terminological stability, state provenance

Needs a design session similar to what Ch 3 got this session.

### Review Backlog
- All drafted chapters in review queue
- Open questions: Ch 5 (7 items), Ch 8 (7 items), Ch 14 (7 items)

### Citation Verification
- 15 citations still need verification (unchanged)

### Deferred
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check

---

## Session Notes

- Ch 3 redesign was driven by honest assessment: if you can't articulate where LLMs reliably help in imputation, don't write a chapter pretending they do. The redesigned chapter covers where LLMs actually earn their place in data quality workflows.
- The fine-tuning vs. API cost argument is one of the most practical sections in the book for the target audience. Many agencies are being pitched SLM fine-tuning without doing the total cost of ownership comparison.
- Three CC tasks written, none yet executed. Next session should execute all three before moving to Ch 4 design.
