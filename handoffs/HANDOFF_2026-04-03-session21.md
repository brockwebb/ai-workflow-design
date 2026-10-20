# Handoff: Session 21 — Ch 6 AD-020 Pipeline + Perplexity Verification + Revision + Graph Cleanup

**Date:** 2026-04-03
**Session scope:** Ch 6 AD-020 calibration run 004, Perplexity verification (PQ-01 through PQ-04), Ch 6 revision (7 fixes), cross-chapter 6,987→6,954 fix (Ch 4, Ch 14), graph cleanup of stale "$15 vs $1,500" and "6,987" data
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### AD-020 Pipeline — Chapter 6 (Calibration Run 004)

CC task written (`cc_tasks/2026-04-03_ch06_ad020_review_pipeline.md`) and executed. All 7 output files produced:
- `audits/chapter-06_content_audit.yaml`
- `audits/chapter-06_perplexity_queries.md` (4 queries)
- `audits/chapter-06_practitioner_stress_test.yaml`
- `audits/chapter-06_bloom_depth_check.yaml`
- `audits/chapter-06_secondary_sweep.yaml`
- `audits/chapter-06_review_synthesis.yaml` (7 clusters + unclustered)
- `audits/chapter-06_cascade_results.yaml` (2 confirmed issues, 5 clear)
- Calibration data: `seldon/docs/design/AD-020_calibration_004_ch06.md`

Key synthesis findings:
- **Cluster 1 (conv 4):** Zero figures — third consecutive chapter with no diagrams. Systematic pattern confirmed.
- **Cluster 2 (conv 3):** 6,954 vs 6,987 cross-chapter inconsistency. Resolved: 6,954 is canonical.
- **Cluster 3 (conv 3):** "$15 vs $1,500" broken bridge from Ch 5. **MOOT** — bridge was already rewritten Session 20. Cascade checker used stale graph data.
- **Cluster 4 (conv 3):** Design for Scale section plateaus at Understand. Needs reflection prompt.
- **Cluster 5 (conv 2):** Operational gaps (batch sizing, shared resources, dynamic rate limits).
- **Cluster 6 (conv 2):** Pike's Rules unanchored in concrete examples.
- **Cluster 7 (conv 2):** No time estimation formula for pipeline duration planning.

Bloom: Ceiling at Create (thought experiment). Floor met (Apply). One cognitive valley at Design for Scale (Understand). Pike's Rules confirmed as substantive (Analyze), not decorative.

Cascade: Ch 7 and Ch 11 forward references verified clean. Ch 8 reference clean. Ch 5 bridge (post-Session 20 rewrite) matches Ch 6 content.

### Perplexity Verification — Chapter 6 (4 queries)

All resolved during this session (not via Perplexity tool — verified from source materials):
- **PQ-01 (Concept Mapper count):** Resolved from source paper (`FedSurveyHarmonization.pdf`). Canonical: 6,954 analyzable survey questions after dedup/dual-topic cleanup from ~7,000 raw. The number 6,987 has no basis in any pipeline stage.
- **PQ-02 (Pike's Rules):** Verified. Five rules confirmed from "Notes on Programming in C" (1989). Paraphrases are fair.
- **PQ-03 (Exponential backoff with jitter):** Verified. AWS Builders' Library is canonical reference. No citation added (well-known pattern), but available if needed.
- **PQ-04 ($15 vs $1,500 bridge):** Moot. Ch 5 bridge already rewritten Session 20. No "$15 vs $1,500" reference remains.

### Chapter 6 Revision

CC task written (`cc_tasks/2026-04-03_ch06_revision.md`) and executed. 7 fixes:
1. **Cross-chapter number fix:** 6,987→6,954 in Ch 4 (line 133) and Ch 14 (lines 28, 38). Downstream arithmetic in Ch 14 adjusted (232 hours, $23,200).
2. **Design for Scale:** Added reflection prompt and concrete failure example. Pushes from Understand to Apply.
3. **Time estimation formula:** Added inline prose estimation paragraph in Batch Design section.
4. **Pike's Rules grounding:** Added concrete one-sentence examples for Rules 1 and 2.
5. **Checkpoint granularity:** Added design decision paragraph for checkpoint interval selection.
6. **Minor fixes:** Ch 14 forward reference in Model Selection, Ch 1 back-reference for stochastic tax, transition sentence between Pike's Rules and Design for Scale.
7. **Figure specs (3):** `fig-06-01_parallel_batch_architecture`, `fig-06-02_model_abstraction_layer`, `fig-06-03_pike_rules_pipeline_mapping` in `assets/diagrams/paperbanana/`.

### Graph Cleanup

CC task written (`cc_tasks/2026-04-03_graph_cleanup_stale_values.md`) and executed. Stale "$15 vs $1,500" and "6,987" data purged from Seldon graph and CLAUDE.md. Root cause of repeated false cascade checker findings eliminated.

**Critical lesson:** The "$15 vs $1,500" framing was resolved in Session 20 (Ch 5 bridge rewrite) but the graph retained stale data referencing it, which caused the cascade checker in run 004 to generate a false "broken bridge" finding (Cluster 3). Memory edits don't fix graph data. The graph is the source of truth — when it's stale, everything downstream is contaminated.

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Ch 6 AD-020 pipeline run (calibration 004) | ✅ |
| Ch 6 Perplexity queries (all 4) | Resolved ✅ |
| Ch 6 revision (7 fixes) | Executed ✅ |
| Cross-chapter 6,987→6,954 fix (Ch 4, Ch 14) | Executed ✅ |
| Graph cleanup (stale $15/$1,500 and 6,987) | Executed ✅ |
| AD-020 calibration 004 data capture | Written ✅ |
| Ch 6 figure specs (3) | Written ✅ |

---

## Outstanding Items

| Item | Priority | Notes |
|------|----------|-------|
| Ch 7 AD-020 pipeline run | **Next** | Write CC task from Ch 5 template, calibration run 005 |
| Em-dash purge + `\$` escaping (foreword–Ch 2) | Medium | Session 17 leftover |
| Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| arXiv:2502.01534 metadata verification | Low | Different paper from li_d_2024 |
| Session 17 flagged citations (15 total) | Low | Check how many resolved by Ch 3/4/5/6 passes |

---

## Artifacts Created This Session

| File | Location | Type |
|------|----------|------|
| Ch 6 AD-020 pipeline CC task | `cc_tasks/2026-04-03_ch06_ad020_review_pipeline.md` | CC task |
| Ch 6 revision CC task | `cc_tasks/2026-04-03_ch06_revision.md` | CC task |
| Graph cleanup CC task | `cc_tasks/2026-04-03_graph_cleanup_stale_values.md` | CC task |
| Ch 6 audit files (7) | `audits/chapter-06_*` | Audit artifacts |
| Ch 6 figure specs (3) | `assets/diagrams/paperbanana/fig-06-0[1-3]*` | Figure specs |
| AD-020 calibration 004 | `seldon/docs/design/AD-020_calibration_004_ch06.md` | Calibration data |

---

## Key Design Decisions

1. **6,954 is canonical.** The source paper (`FedSurveyHarmonization.pdf`) says "6,954 analyzable questions." The ~7,000 raw questions were reduced to 6,954 after deduplication and dual-topic cleanup. The number 6,987 never corresponded to any pipeline stage and has been purged from all chapters and the graph.

2. **"$15 vs $1,500" is dead.** Lives in Ch 14 ONLY. The Ch 5 bridge was already rewritten in Session 20 to not reference it. Graph data referencing it has been cleaned. Memory edit added to prevent future sessions from resurrecting it. DO NOT re-audit, re-discuss, or re-introduce this framing in any chapter other than Ch 14.

3. **Cluster 3 (broken bridge) was a false finding** caused by stale graph data — not a real content issue. This validates the decision to add the graph cleanup CC task as a separate prerequisite step.

---

## Pipeline Calibration Notes (AD-020 Run 004 vs Runs 002/003)

- Visual gap pattern confirmed across 3 chapters (Ch 4, 5, 6) — all convergence 4. This is a systematic authoring pattern, not a per-chapter finding.
- Engineering chapter (Ch 6) produced different practitioner stress test signal than pattern chapter (Ch 5): more operational gaps (batch sizing, shared resources) vs. design choice gaps.
- Bloom gate correctly identified Design for Scale as the weak section (Understand in an Apply-floor chapter). Gate added genuine value.
- Cascade checker generated one false finding (Cluster 3) from stale graph data. Graph hygiene is a prerequisite for reliable cascade checking.
- Pike's Rules section was correctly assessed as Analyze level by Bloom gate — substantive, not decorative. The gates got this right.

---

## Nothing Modified Outside Scope

- No chapter files edited directly by this session (all edits via CC task execution)
- No existing CC tasks modified
- No Seldon code changes
