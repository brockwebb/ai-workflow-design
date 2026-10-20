# Handoff: Session 23 — Ch 8 AD-020 Review + Figure Audit + Cost Reconciliation

**Date:** 2026-04-04
**Session scope:** Ch 8 AD-020 pipeline CC task (calibration run 006), figure debt audit, cost figure reconciliation, Perplexity verification integration, revision CC task
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Ch 8 AD-020 Pipeline CC Task (Calibration Run 006)

CC task written (`cc_tasks/2026-04-03_ch08_ad020_review_pipeline.md`) and registered. Executed by Claude Code in a separate session. All 7 output files produced:
- `audits/chapter-08_content_audit.yaml`
- `audits/chapter-08_perplexity_queries.md`
- `audits/chapter-08_practitioner_stress_test.yaml`
- `audits/chapter-08_bloom_depth_check.yaml`
- `audits/chapter-08_secondary_sweep.yaml`
- `audits/chapter-08_review_synthesis.yaml` (8 clusters + unclustered)
- `audits/chapter-08_cascade_results.yaml` (7 cascades: 3 confirmed, 4 clear)

Key synthesis findings:
- **Cluster 1 (conv 4):** Visual absence — zero figures in a methodology chapter with table-ready content (mapping types, tailored crosswalks). Fifth consecutive zero-figure data point.
- **Cluster 2 (conv 3):** 7,000 vs 6,954 question count inconsistency. Ch 8 is the only chapter using the rounded figure.
- **Cluster 3 (conv 3):** Cost scope discrepancy — $100 (Ch 8) vs $15 (Ch 5, Ch 14) for Concept Mapper. **Resolved:** different scopes, both correct. See cost reconciliation below.
- **Cluster 4 (conv 3):** Tailored crosswalk section at Understand, not Apply. Reader sees worked examples but isn't scaffolded to create their own crosswalk.
- **Cluster 5 (conv 2):** Confabulation detection specification gap identified but not filled. Appropriate — intentionally out of scope for Ch 8.
- **Cluster 6 (conv 2):** Narrative tension dissipates after Remote Labor Index hook.
- **Cluster 7 (conv 2):** FCSM 20-04 document number verified correct but not formally cited via BibTeX.
- **Cluster 8 (conv 1):** SWE-CI "18 models" — verified correct (18 models from 8 providers).

Bloom: Non-monotonic with valley. Ceiling at Evaluate (Gate Not Dial, What Evaluation Cannot Do). Valley at Understand (Tailored Crosswalk, Evaluation Economics). Scaffolding dips in the middle sections.

Cascades: 7 total, 3 confirmed, 4 clear. Confirmed issues: (1) cost scope inconsistency $100 vs $15 across chapters, (2) chen_2026_sweci "18 models" additive detail in Ch 8 not in Ch 7, (3) 7,000 vs 6,954 count.

Practitioner stress test: 5 fully answerable, 5 partial, 0 not answerable. Gaps cluster around implementation scaffolding (how to build evaluation architecture from scratch, confabulation detection, golden test set sizing).

### Perplexity Verification — Chapter 8

All claims resolved:
- **FCSM 20-04:** Correct document number. "A Framework for Data Quality."
- **Concept Mapper $100:** Crosswalk paper says "<$100 API" for classification pipeline — this is total across all models/arbitration, not per-run inference.
- **Crosswalk mapping counts (4/1/2/3/4):** Verified match paper.
- **SWE-CI 18 models:** Confirmed (18 models from 8 providers).
- **NIST valid-and-reliable as foundation:** Accurate as interpretive characterization, not direct NIST quote.
- **Remote Labor Index 2.5%:** Confirmed.
- **Multi-model independence concern:** Supported — overlapping training corpora makes statistical independence questionable.

### Cost Figure Reconciliation (Cross-Chapter)

Resolved by checking source papers directly:

| Figure | Scope | Source | Chapters using it |
|--------|-------|--------|-------------------|
| $15 | Concept Mapper per-run inference (one model pass) | Ch 14 breakdown | Ch 5, Ch 14, intro |
| <$100 | Concept Mapper total API (all models + arbitration + evaluation) | Crosswalk paper Table 6.1 | Ch 8 |
| ~$15 | Pragmatics evaluation pipeline (judges × queries × orderings) | Crosswalk paper Table 6.1 | Ch 8 |
| $4.42 | Pragmatics 39-query runtime (Stage 1 only) | Pragmatics paper §5.6 | (not in book) |

All numbers correct. The problem is inconsistent scope labeling across chapters, not wrong numbers. Ch 8's attributions match the crosswalk paper exactly. Ch 5/14's $15 is the per-run inference cost. The revision CC task adds scope labels.

### Figure Debt Audit

Comprehensive audit of figure state across the book:

**Rendered (3):** cover art, fig-01-01a (naive), fig-01-01b (designed) — all Ch 1, rendered via PaperBanana 2026-03-29/31.

**Specs written but not rendered (14):**
- Ch 2: 1 (fig-02-01)
- Ch 3: 1 (fig-03-01)
- Ch 4: 1 (fig-04-01)
- Ch 5: 4 (fig-05-01 through fig-05-04)
- Ch 6: 3 (fig-06-01 through fig-06-03)
- Ch 7: 3 (fig-07-01 through fig-07-03)

**Build-breaking:** Ch 7 has two `::::{figure}` directives (lines 73 and 95) pointing at PNGs that don't exist. MyST build will fail.

**No directives in chapter text:** Ch 2-6 have specs but no figure directives inserted into the chapters yet.

**`assets/images/` is empty.** No rendered figures placed there. Convention from Ch 7 directives points to `assets/diagrams/paperbanana/`.

**Zero Figure artifacts in Seldon graph.**

### CC Tasks Written This Session

| CC Task | File | Status |
|---------|------|--------|
| Ch 8 AD-020 pipeline | `cc_tasks/2026-04-03_ch08_ad020_review_pipeline.md` | ✅ Completed |
| Batch figure render + insertion | `cc_tasks/2026-04-03_batch_figure_render_and_insertion.md` | Proposed |
| Figure addendum (tables as MyST) | `cc_tasks/2026-04-03_batch_figure_render_addendum_tables.md` | Proposed |
| Ch 8 revision + cost purge | `cc_tasks/2026-04-04_ch08_revision_and_cost_purge.md` | Proposed |

### "$15 vs $1,500" Purge

The "$15 vs $1,500" framing remains in Ch 14 (lines 87, 89, 163) despite multiple prior removal attempts. The revision CC task includes explicit removal instructions with a grep verification step. The $1,500 figure was always hypothetical with no empirical basis. Only in Ch 14 — no other chapters.

### Design Decision: Tables as Native MyST Markup

fig-07-01 (Error Classification Table) should be a native `:::{table}` directive in MyST markdown, not a PaperBanana-rendered image. Tables rendered as images are worse for accessibility, searchability, and build simplicity. The addendum CC task specifies the conversion and flags fig-05-04 (Topology Comparison Table) for the same assessment.

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Ch 8 AD-020 pipeline run (calibration 006) | ✅ |
| Ch 8 Perplexity verification (all claims) | Resolved ✅ |
| Cost figure reconciliation (source papers verified) | Resolved ✅ |
| Figure debt audit (full inventory) | ✅ |

---

## Outstanding Items — Execution Queue

Execute in this order:

| # | CC Task | Path | Priority |
|---|---------|------|----------|
| 1 | Ch 8 revision + $1,500 purge | `cc_tasks/2026-04-04_ch08_revision_and_cost_purge.md` | **HIGH** — factual fixes, zombie purge |
| 2 | Batch figure render (read with #3) | `cc_tasks/2026-04-03_batch_figure_render_and_insertion.md` | **HIGH** — Ch 7 build break |
| 3 | Figure addendum (tables) | `cc_tasks/2026-04-03_batch_figure_render_addendum_tables.md` | HIGH — modifies #2 |

### Other outstanding (carried forward)

| Item | Priority | Notes |
|------|----------|-------|
| Em-dash purge + `\$` escaping (foreword–Ch 2) | Medium | Session 17 leftover |
| Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| arXiv:2502.01534 metadata verification | Low | Different paper from li_d_2024 |
| Session 17 flagged citations (15 total) | Low | Check how many resolved by Ch 3-8 passes |
| Ch 9 AD-020 pipeline run | **Next after queue** | Calibration run 007 |

---

## Key Design Decisions

1. **Cost figures are all correct — scope labeling is the fix.** $15 (inference), <$100 (full pipeline), ~$15 (Pragmatics evaluation), $4.42 (Pragmatics runtime) are all verified from source papers. The revision adds explicit scope labels to prevent reader confusion.

2. **"$15 vs $1,500" is permanently removed.** The $1,500 is fabricated. The design discipline argument is stronger without it. The revision CC task includes grep verification to ensure complete removal.

3. **Tables should be native MyST markup, not rendered images.** fig-07-01 (Error Classification Table) and potentially fig-05-04 (Topology Comparison Table) are better as `:::{table}` directives. PaperBanana is for diagrams and flow charts.

4. **Tailored crosswalk section needs a practitioner exercise to reach Apply.** The chapter's centerpiece methodology section stays at Understand without one. A simple "map your own design choice to both frameworks" exercise pushes it to Apply/Analyze.

---

## Pipeline Calibration Notes (AD-020 Run 006 vs Runs 002-005)

- **Non-monotonic Bloom scaffolding** — first chapter with a significant cognitive valley. Prior chapters were monotonic (Ch 7) or had minor dips. The Tailored Crosswalk section dropping to Understand in a methodology chapter is structurally different from engineering chapters plateauing at Apply.
- **Visual gap persists** — 5th consecutive zero-figure chapter. Now definitively a systematic pattern. The methodology chapter visual gap is arguably worse than engineering chapters: crosswalk mapping types and tailored crosswalk comparisons are screaming for tables.
- **Heavy self-citation produced useful signal** — `webb_2026_crosswalk` × 7 is appropriate when the chapter operationalizes that paper. Tier 1 correctly flagged the scope confusion between $15/$100 rather than the citation density itself.
- **Cost figure cascade is the highest-severity cross-chapter finding since the 6,987→6,954 correction.** Multiple chapters, multiple scopes, no scope labels. Resolved by going to source papers.
- **Cascade checking caught the "$15 vs $1,500" zombie** still in Ch 14 despite prior removal attempts.
- **Practitioner stress test for methodology chapters** produces different gaps: "how do I assemble these components?" rather than "how do I survive failures?" (Ch 7) or "how do I build this?" (Ch 6).

---

## Nothing Modified Outside Scope

- No chapter files edited directly by this session (all edits via CC task execution)
- No existing CC tasks modified (addendum written for figure task)
- No Seldon code changes
