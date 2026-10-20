# CC Task: Chapter 1 Audit Fixes (Non-Figure Items)

**Date:** 2026-03-31
**Session:** 15
**Status:** PENDING
**Scope:** `book/chapter-01.md`, `book/references.bib`
**Depends on:** None (independent of fig-01-01 rendering task)

---

## Context

Session 15 substantive audit of Chapter 1 identified prose issues independent of the figure rendering. These can be executed while PaperBanana runs. Citation verification completed via independent Perplexity search.

---

## Fixes

### Fix 1: §What This Book Covers, paragraph 2 — stale Chapter 3 name

**Current text:**
> classification and coding (with the Federal Survey Concept Mapper as anchor case study), data cleaning and imputation, and detection and extraction.

**Problem:** Chapter 3 was redesigned from "Data Cleaning & Imputation" to "Data Wrangling & Standardization" in Session 10. This reference was never updated. The chapter explicitly argues LLMs are NOT imputation tools — the old name contradicts the chapter's own thesis.

**Replace with:**
> classification and coding (with the Federal Survey Concept Mapper as anchor case study), data wrangling and standardization, and detection and extraction.

---

### Fix 2: §The Systems Engineering Gap, paragraph 2 — overbroad claim

**Current text:**
> The tools researchers need are not being built because the market that would pay for them is too small to attract commercial investment.

**Problem:** Slightly overbroad. Open-source research tools (Jupyter, R, etc.) exist precisely because communities built them outside market incentives. The claim is true for LLM-specific research orchestration tooling, which is what Chapter 11 defends. Tighten the scope.

**Replace with:**
> The LLM-specific tools researchers need — orchestration with research-grade provenance, evaluation infrastructure for stochastic pipelines, state management for mutable instruments — are not being built because the market that would pay for them is too small to attract commercial investment.

---

### Fix 3: §Levels — METR perception gap precision

**Verification status:** All METR figures independently confirmed via Perplexity against arXiv:2507.09089 and METR blog post.

**Current text:**
> The developers estimated AI made them 24% *faster*. They were wrong about both direction and magnitude.

**Problem:** The 24% is the pre-study forecast (before doing tasks). After completing the study and actually experiencing the 19% slowdown, developers still estimated a 20% speedup. The chapter collapses two different numbers — the pre-study forecast and the post-study estimate — into one. The persistence of the misperception despite experience is the stronger finding.

**Replace with:**
> Before starting, developers forecasted AI would make them 24% faster. After completing the study — having actually been slowed down — they still estimated AI had helped by 20%. They were wrong about both direction and magnitude, and direct experience did not correct the error.

**Also update `references.bib`** — add the verified figures to the `becker_2025` note field:

**Current note:**
> Published by METR (Model Evaluation and Threat Research). RCT with 16 developers, 246 tasks, February--June 2025. Tools: Cursor Pro with Claude 3.5/3.7 Sonnet.

**Replace with:**
> Published by METR (Model Evaluation and Threat Research). RCT with 16 developers, 246 tasks, February--June 2025. Tools: Cursor Pro with Claude 3.5/3.7 Sonnet. AI tools increased completion time by 19\%. Pre-study forecast: 24\% speedup. Post-study estimate: 20\% speedup. Both wrong about direction and magnitude.

---

### Fix 4: §Levels — DORA respondent count [FLAGGED — REQUIRES RESOLUTION]

**Verification status:** Independent Perplexity search flagged a mismatch. The "39,000+ respondents" figure is NOT confirmed from the original DORA 2024 report. Secondary sources indicate approximately 3,000 respondents, not 39,000+. The 75%, 1.5%, and 7.2% figures ARE confirmed.

**Current chapter text:**
> The 2024 Accelerate State of DevOps Report {cite:p}`dora_2024`, surveying over 39,000 professionals globally, found the same pattern at scale

**Current `references.bib` note:**
> 39,000+ respondents globally. AI chapter uses causal inference methods.

**Action — DO NOT auto-fix.** This requires author verification. Options:

(a) If the actual DORA 2024 sample is ~3,000: update chapter text and bib note to "approximately 3,000 professionals" — this is still a large-sample observational study but the "at scale" framing needs softening.

(b) If 39,000+ is correct (e.g., from a different section of the report or the full DORA dataset across years): confirm and document the source.

(c) If the number cannot be confirmed: remove the specific count and write "a large-scale global survey" instead.

**The CC executor should flag this for Brock's decision, NOT auto-resolve.** The 39,000 figure may have come from a prior year's DORA report or from accumulated multi-year data. This needs human judgment.

---

## Verification

After applying fixes 1-3, run `seldon verify --fix`. Fix 4 requires author decision before execution.

---

## Notes

- Fix 1 is a straightforward text replacement.
- Fix 2 tightens scope without changing the argument.
- Fix 3 sharpens the METR citation — all numbers independently verified.
- Fix 4 is a flagged issue requiring author resolution. The specific respondent count is unconfirmed. The analytical findings (75%, 1.5%, 7.2%) are confirmed.
- These fixes are independent of the PaperBanana figure rendering CC task.
