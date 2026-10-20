# Handoff: Session 20 — Ch 3/4/5 Perplexity Verification + Ch 5 AD-020 Review + Revision Execution

**Date:** 2026-04-03
**Session scope:** Perplexity verification for Ch 3 (Q1-Q11) and Ch 4 (CG-1 through CG-6, UC-1), Ch 5 AD-020 pipeline review, Ch 3 and Ch 5 revision CC task authoring and execution
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Perplexity Verification — Chapter 3 (11 queries)
All 11 queries from `audits/chapter-03_perplexity_queries.md` run through Perplexity and resolved:
- 8 verified, no changes needed (Q1, Q3, Q6, Q7, Q8, Q9, Q10, Q11)
- 2 required wording fixes (Q2: self-reported coding error framing; Q4: "fine-tuning" → "ML and language model techniques")
- 1 evaluated, no change needed (Q5: TCO component list framing already appropriately scoped as practitioner guidance)

### Perplexity Verification — Chapter 4 (7 queries)
All 7 queries from `audits/chapter-04_perplexity_queries.md` run through Perplexity and resolved:
- CG-1: LLM extraction vs citation accuracy — verified (GPT-4 NER F1 0.95+, citation accuracy 50-66%). Claim no longer exists as standalone sentence post-revision; moot.
- CG-2/CG-3: Absolute vs comparative judgment — already resolved by Tripathi et al. in Session 19 revision.
- CG-4: Bradley-Terry (1952) — verified, standard reference.
- CG-5/CG-6: KG extraction quality + provenance gaps — verified, supports confidence laundering framing.
- UC-1: Multi-model extraction necessity — verified, ensembles improve agreement.

**Ch 4 Perplexity status: fully resolved. No outstanding queries.**

### Chapter 3 Revision
- CC task written: `cc_tasks/2026-04-03_ch03_perplexity_fixes.md`
- Two surgical fixes: (1) "get them wrong" → coding error at detailed levels with ferraro_2019 citation, (2) "fine-tuning language models" → "machine learning and language model techniques"
- Executed and pushed.

### Chapter 5 AD-020 Pipeline Review
- AD-020 pipeline (calibration run 003) had already been executed — found outputs in `audits/chapter-05_*`
- Reviewed synthesis (8 clusters, 0 false positives), cascade results, Bloom depth check
- Key findings:
  - **Cluster 1** (conv: 4): Zero figures in a topology chapter. Highest-value gap.
  - **Cluster 2** (conv: 3): Ch 1 content overlap — six degradation papers re-cited at similar depth.
  - **Cluster 3** (conv: 2): Two unsupported core claims (bias diversity, iteration threshold).
  - **Cluster 5** (conv: 2): Broken bridge to Ch 6 — "$15 vs $1,500" doesn't exist in Ch 6.
  - Bloom: Strong. Sustained Evaluate, Create at end. One minor Apply dip in Cross-Cutting Principles.
  - Cascade: Ch 1 overlap confirmed, Ch 6 bridge broken, Ch 2 and Ch 9 refs clean.

### Perplexity Verification — Chapter 5 (9 queries)
All priority queries resolved:
- Self-Refine ~20%: confirmed as aggregate average, caveat added
- TWIX 520x/3,786x: exact match confirmed
- Cross-model independence: partially supported — "different agreement patterns" defensible, "meaningfully different bias profiles" too strong
- **Iteration threshold: NOT SUPPORTED.** RefineBench shows flattening/degradation, no 2-3 round optimum. Claim corrected to trajectory-based termination.
- Self-consistency wording: current text already uses better framing
- Preference leakage: confirmed in literature (arXiv:2502.01534)
- ABBA counterbalancing: standard experimental design, confirmed
- Goodhart's Law: confirmed in LLM evaluation lit

### Chapter 5 Revision
- CC task written: `cc_tasks/2026-04-03_ch05_revision.md` — 14 fixes
- Key fixes: cross-model independence claim softened (Fix 1), iteration threshold reframed as trajectory-based rule (Fix 2), Ch 6 bridge rewritten (Fix 4), degradation paragraph compressed with Ch 1 back-reference (Fix 5), topology composition guidance added (Fix 7), reflection prompt added (Fix 8), minimum viable multi-model paragraph added (Fix 9), 4 figure specs written (Fix 14)
- Executed and pushed. All verification checklist items confirmed.
- Fix 11 (arXiv:2502.01534 as separate paper from li_d_2024): flagged for follow-up, skipped this session — no verified metadata.
- Calibration data: `seldon/docs/design/AD-020_calibration_003_ch05.md` written.

---

## Confirmed Complete (Previously Pending)

| Item | Status |
|------|--------|
| Ch 4 revision (`2026-04-03_ch04_revision.md`, 13 instructions) | Executed in prior session ✅ |
| Ch 4 revision addendum A (eval heuristic + confidence laundering def) | Executed in prior session ✅ |
| Ch 4 Perplexity queries (all 7) | Resolved this session ✅ |
| Ch 3 Perplexity queries (all 11) | Resolved this session ✅ |
| Ch 5 AD-020 pipeline run | Executed prior to this session ✅ |
| Ch 5 Perplexity queries (all 9) | Resolved this session ✅ |
| Ch 3 revision | Executed + pushed ✅ |
| Ch 5 revision (14 fixes) | Executed + pushed ✅ |
| AD-020 calibration 003 data capture | Written ✅ |

---

## Outstanding Items

| Item | Priority | Notes |
|------|----------|-------|
| Ch 6 AD-020 pipeline run | **Next** | CC task exists: `cc_tasks/2026-04-03_ch05_ad020_review_pipeline.md` needs equivalent for Ch 6 |
| Em-dash purge + `\$` escaping (foreword–Ch 2) | Medium | Session 17 leftover, register in Seldon task tracker |
| Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding vs. what Perplexity fixes covered |
| arXiv:2502.01534 metadata verification | Low | Different paper from li_d_2024 — needs BibTeX if worth citing |
| Session 17 flagged citations (15 total) | Low | Check how many resolved by Ch 3/4/5 Perplexity passes |

---

## Artifacts Created This Session

| File | Location | Type |
|------|----------|------|
| Ch 3 Perplexity fixes CC task | `cc_tasks/2026-04-03_ch03_perplexity_fixes.md` | CC task |
| Ch 5 revision CC task | `cc_tasks/2026-04-03_ch05_revision.md` | CC task |
| Ch 5 figure specs (4) | `assets/diagrams/paperbanana/fig-05-0[1-4]*` | Figure specs |
| AD-020 calibration 003 | `seldon/docs/design/AD-020_calibration_003_ch05.md` | Calibration data |

---

## Key Design Decisions

1. **Ch 5 bridge to Ch 6:** Rewrote to match what Ch 6 actually delivers (force multipliers, batch design, infrastructure reinvention) rather than adding "$15 vs $1,500" to Ch 6. Cost framework lives in Ch 14.

2. **Iteration threshold:** Removed "2-3 rounds" magic number entirely. Replaced with trajectory-based termination rule. RefineBench evidence does not support any specific iteration count as universal optimum.

3. **Cross-model independence:** Softened from "meaningfully different bias profiles" to "different agreement patterns and failure behavior." Evidence supports the narrower claim.

---

## Pipeline Calibration Notes (AD-020 runs 002 vs 003)

- Ch 5 (run 003, ~137 lines) produced cleaner signal than Ch 4 (run 002, ~97 lines). More developed content gives gates more to work with.
- Bloom gate added genuine value on Ch 5 — identified the Cross-Cutting Principles Apply dip, which was a real pedagogical gap distinct from the practitioner stress test findings.
- Practitioner stress test on a "how to choose" chapter produced topology composition gap (Cluster 4) that other gates missed.
- Cascade checker on a cross-cutting chapter found the Ch 1 overlap and Ch 6 broken bridge — both high-value findings.
- Visual gap cluster hit convergence 4 (highest) — consistent with Ch 4's visual gap finding. This is a systematic pattern across chapters.

---

## Nothing Modified Outside Scope

- No chapter files edited directly by this session (all edits via CC task execution)
- No existing CC tasks modified
- No Seldon code changes
