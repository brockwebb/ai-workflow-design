# Handoff: Session 22 — Ch 7 AD-020 Pipeline + Perplexity Verification + Revision

**Date:** 2026-04-03
**Session scope:** Ch 7 AD-020 calibration run 005, Perplexity verification (5 claims), Ch 7 revision (5 fixes + 2 figure specs)
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### AD-020 Pipeline — Chapter 7 (Calibration Run 005)

CC task written (`cc_tasks/2026-04-03_ch07_ad020_review_pipeline.md`) and executed. All 7 output files produced:
- `audits/chapter-07_content_audit.yaml`
- `audits/chapter-07_perplexity_queries.md`
- `audits/chapter-07_practitioner_stress_test.yaml`
- `audits/chapter-07_bloom_depth_check.yaml`
- `audits/chapter-07_secondary_sweep.yaml`
- `audits/chapter-07_review_synthesis.yaml` (8 clusters + unclustered)
- `audits/chapter-07_cascade_results.yaml` (6 cascades, all clean)

Key synthesis findings:
- **Cluster 1 (conv 3):** GPT-5 temperature claim factually wrong. **FIXED** — replaced with generic reasoning-model framing (no company/model names in body text).
- **Cluster 2 (conv 4):** Zero figures — fourth consecutive chapter with no diagrams. Systematic pattern confirmed across Ch 4, 5, 6, 7.
- **Cluster 3 (conv 3):** Config-Driven Architecture section overloaded (5 topics, no subsection structure). **FIXED** — 5 `###` headers added.
- **Cluster 4 (conv 3):** Thought experiment — strong Evaluate with clean Ch 9 callback. No action needed.
- **Cluster 5 (conv 2):** Recursive stochasticity section at Analyze, appropriate scoping. Optional Ch 11 preview sentence added.
- **Cluster 6 (conv 2):** Progressive Test Infrastructure — chapter's best audience-calibrated content. No action needed.
- **Cluster 7 (conv 2):** Prevention-failure recovery gap (what happens when checkpoints themselves fail). **FIXED** — paragraph added.
- **Cluster 8 (conv 2):** Sparse citation profile (3 citations). Appropriate for engineering chapter — no action needed.

Bloom: Ceiling at Evaluate (thought experiment). Floor met (Apply). Monotonically ascending scaffolding — cleanest of any chapter audited. No cognitive valleys. Recursive stochasticity section correctly at Analyze.

Cascades: **All 6 verified clean.** First calibration run with zero cascade issues. Ch 6 backward refs clean. Ch 9 thought experiment callback is the strongest cross-chapter linkage in any run — Ch 9 explicitly names and answers Ch 7's thought experiment, then maps Ch 7's three core sections to SFV threats. Ch 10 and Ch 11 forward refs both verified with explicit pickups.

Practitioner stress test: 5 fully answerable, 4 partial, 1 not answerable. Gaps cluster around edge cases (mid-run config changes, corrupted checkpoints, AI coding assistant protocols) that the chapter acknowledges but defers. Single unanswerable (runtime estimation) is Ch 6's domain.

### Perplexity Verification — Chapter 7 (5 claims)

All resolved:
- **GPT-5 temperature:** Factually wrong as stated. Temperature removed in o-series reasoning models and GPT-5 series, not a GPT-4→GPT-5 transition. **Chapter fixed** to use generic framing.
- **NIST TEVV:** "Continuous, not a gate at the end" characterization is accurate. TEVV integrated across all four framework functions.
- **SWE-CI (`chen_2026_sweci`):** All numbers check out — 100 tasks, 233 days avg, 71 commits avg, 75% breakage rate, EvoScore metric. Strong citation.
- **Crash-safe writes:** Standard pattern, accurately described. POSIX atomicity caveat noted but not needed in chapter.
- **Exponential backoff with jitter:** Standard practice, AWS and OpenAI both recommend. Already cited from Ch 6.

### Chapter 7 Revision

CC task written (`cc_tasks/2026-04-03_ch07_revision.md`) and executed. Committed as 86a9466. Fixes applied:
1. **GPT-5 temperature claim → generic reasoning-model framing** (HIGH — factual error corrected, no company/model names in body text)
2. **Config-Driven Architecture subsection headers** — 5 `###` headers added for the 5 topics
3. **Prevention-failure recovery paragraph** — added to Checkpoint section (what to do when checkpoints themselves fail)
4. **Ch 11 preview sentence** — added to Recursive Problem section closing
5. **Figure specs (2):** `fig-07-01_error_classification_table` and `fig-07-02_transaction_safe_checkpoint` written to `assets/diagrams/paperbanana/`
6. **Skipped:** TEVV expansion (Cluster 8) — synthesis explicitly said no changes needed to Progressive Test section

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Ch 7 AD-020 pipeline run (calibration 005) | ✅ |
| Ch 7 Perplexity verification (all 5) | Resolved ✅ |
| Ch 7 revision (5 fixes) | Executed ✅ (86a9466) |
| Ch 7 figure specs (2) | Written ✅ |

---

## Outstanding Items

| Item | Priority | Notes |
|------|----------|-------|
| Ch 8 AD-020 pipeline run | **Next** | Write CC task from Ch 7 template, calibration run 006 |
| Em-dash purge + `\$` escaping (foreword–Ch 2) | Medium | Session 17 leftover |
| Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| arXiv:2502.01534 metadata verification | Low | Different paper from li_d_2024 |
| Session 17 flagged citations (15 total) | Low | Check how many resolved by Ch 3/4/5/6/7 passes |

---

## Artifacts Created This Session

| File | Location | Type |
|------|----------|------|
| Ch 7 AD-020 pipeline CC task | `cc_tasks/2026-04-03_ch07_ad020_review_pipeline.md` | CC task |
| Ch 7 revision CC task | `cc_tasks/2026-04-03_ch07_revision.md` | CC task |
| Ch 7 audit files (7) | `audits/chapter-07_*` | Audit artifacts |
| Ch 7 figure specs (2) | `assets/diagrams/paperbanana/fig-07-0[1-2]*` | Figure specs |

---

## Key Design Decisions

1. **GPT-5 claim replaced with generic framing.** The original sentence named a specific model transition that was factually wrong. The fix uses "reasoning-focused model architectures" without naming companies or models, consistent with the book's no-specific-companies rule. The parameter shelf-life argument is preserved and strengthened by being accurate.

2. **Config-Driven Architecture gets subsection structure.** Five topics compressed into one `##` section was too dense. The `###` headers make each topic independently navigable without changing the section's content or flow.

3. **Prevention-failure recovery is scoped correctly.** The new paragraph addresses "what if checkpoints fail despite transaction-safe writes" without expanding into a full disaster recovery treatment. It names the recovery path (results file) and the design principle (write results independently of checkpoints).

---

## Pipeline Calibration Notes (AD-020 Run 005 vs Runs 002-004)

- **Zero cascade issues** — first clean cascade run. Ch 7's bridge position between construction (Ch 5-6) and validity (Ch 9-10) is well-connected in both directions.
- **Monotonic Bloom scaffolding** — cleanest of any chapter. Understand → Apply → Analyze → Evaluate with no valleys.
- **Visual gap persists** — 4th consecutive zero-figure chapter. This is definitively a systematic authoring pattern, not a per-chapter finding.
- **Sparse citations (3) produced useful signal** — Tier 1 caught the GPT-5 factual error, which was the highest-severity finding. Low citation count didn't reduce Tier 1 effectiveness.
- **Forward-heavy cascades all clean** — Ch 7 references 3 future chapters (9, 10, 11) and all three deliver on promises with explicit pickups. The Ch 9 thought experiment callback is the strongest cross-chapter linkage in any calibration run.
- **Defensive engineering chapters produce different practitioner signal** — gaps cluster around "what happens when prevention fails" rather than "how do I build this." Compare to Ch 6's implementation gaps (batch sizing, shared resources).
- **`chen_2026_sweci` is a strong anchor** — all numbers verified, EvoScore metric accurately described. The recursive stochasticity argument has solid empirical grounding.

---

## Nothing Modified Outside Scope

- No chapter files edited directly by this session (all edits via CC task execution)
- No existing CC tasks modified
- No Seldon code changes
