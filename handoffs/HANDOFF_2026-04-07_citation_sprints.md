# Session Handoff: Tier 1 Fixes, Ch 14 Escaping, Citation Sprints A+B

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Prior handoff:** `handoffs/HANDOFF_2026-04-07_batch_execution.md`

---

## What Was Accomplished This Session

### 1. Batch E Graph Cleanup
- `76f3b062` (OWASP ASI06 one-line fix) was already executed by CC but not recorded in graph. Marked complete. Graph now clean.

### 2. Tier 1 Quick Fixes (`d6ce0aa2`)
- **Ch 1:** "Evaluation trap" paragraph added after the five degradation pathways, before "The Systems Engineering Gap." Resolves DG-4/CC-3. Ch 6 and Ch 8 cross-references now have a valid target in Ch 1.
- **Intro:** Narrative bridge paragraph added between "Find Your Edge" and "How This Book Is Organized." Closing sentence added at end of intro returning to "design space" premise.

### 3. Ch 14 Dollar Escaping (`15dc3014`)
- 16 bare `$` signs escaped to `\$` across 8 lines. Root cause: MyST interprets unescaped `$` as LaTeX math delimiters, concatenating all text between them. The `\\$100` on line 38 was the only previously escaped instance.

### 4. Citation Sprint A (`f98f2223`)
- **10 new BibTeX entries** added to references.bib in alphabetical order:
  - `brodeur_2025_ssrp` (NBER WP 33753, economics reproducibility ~30%)
  - `chroma_2024_chunking` (chunking strategy affects retrieval quality)
  - `fedramp_20x_2025` (GSA FedRAMP 20x announcement)
  - `gotel_1994` (requirements traceability canonical reference)
  - `landis_1977` (kappa interpretation scale, Biometrics)
  - `li_2023_order_sensitivity` (LLM position bias in MCQ)
  - `liu_2024_chatgpt_behavior` (GPT-4 behavioral drift, HDSR)
  - `morris_2025_verasight` (LLM survey imputation, >10pp subgroup error)
  - `ouyang_2025_nondeterminism` (temperature=0 non-determinism, Eval4NLP)
  - `song_2025_correlated_errors` (ICML 2025, cross-model error correlation)
- **12 citation insertions** across Ch 1, 2, 3, 4, 5, 8, 9, 10, 13
- **Ch 10 precision fixes:** "majority" → "24% of 600 papers"; "about half" → "74% approx, 54% precise"; Brodeur 30% figure added
- **MetaHarness verified:** `lee_2026_metaharness` independently confirmed via arXiv 2603.28052 (March 30, 2026). `PERPLEXITY: verify` note removed from bib entry.

### 5. Citation Sprint B (`251dd207`)
- **Ch 7:** "temperature removed entirely" → "fixed at 1, not user-controllable" (CG-T2)
- **Ch 7:** "frontier models" → "18 models from 8 providers" for SWE-CI (CG-T3)
- **Ch 8:** "4 dimensions" → "4 of the framework's 11 dimensions" for FCSM (CG-X5)
- **Ch 3:** Deployment timeline qualified with authorization-type caveat (CG-F5)
- **3 items verified already correct, no change needed:** Ch 1 terminology drift framing, Ch 4 W3C boundary, Ch 11 SWE-CI language

### 6. Perplexity Verification Results (19 queries, 7 batches)
Full results processed. Key outcomes:
- **Confirmed with citations added:** CG-R1 (temp=0), CG-R2 (silent updates), CG-R3 (position bias), CG-M1/M2 (correlated errors), CG-S1 (Landis-Koch), CG-S3 (Self-Refine 20%), CG-S4 (TWIX 520x/3786x), CG-P1 (DOORS), CG-P2 (SCORE), CG-P3 (Brodeur), CG-F1 (FedRAMP 20x), CG-T2 (temperature), CG-T5 (chunking), CG-X1 (NIST confabulation)
- **Corrected from Perplexity false negatives:** CG-X3 (MetaHarness -- paper exists, published 1 week ago), CG-X4 (10pp subgroup error -- source is Morris/Verasight, not Tian)
- **Reframed as author observation:** CG-T1 (terminology drift -- no empirical study)
- **No standard threshold found:** CG-F4 ($50k fine-tuning -- reframed)
- **Already resolved in prior sessions:** CG-V1 (OWASP), CG-S2 (kappa), CG-F2/F3/F6 (Ch 14 PQ1-3)

---

## Current State

### Graph
- **Zero proposed tasks.** All clear.

### Sweep Synthesis Batch Status

| Batch | Description | Status |
|-------|-------------|--------|
| A | Author decision session (6 gates) | **Complete** |
| B | Mechanical fixes (19 edits) | **Complete** |
| C | Citation research sprint 1 (foundation claims) | **Complete** |
| D | Citation research sprint 2 (provenance/federal) | **Complete** |
| E | OWASP verification | **Complete** |
| F | Cross-chapter coherence set 1 (non-gated) | **Partially complete** (CC-8, CC-9, CC-10 done; author-experience reframing not started) |
| G | Cross-chapter coherence set 2 (gated decisions) | **Partially complete** (DG-1, DG-2, DG-4 done; DG-3 Ch 14 TCO section not started) |
| H | Structural short additions | **Partially complete** (spec-before-execution, Ch 7 pointer, evaluation trap done; Ch 10 "Where to Start", Ch 5 provenance fields, Ch 5 arbitration heuristic, Ch 6 variable-length input, Ch 9 diagnostic table not started) |
| I | Structural scope decisions | Not started |
| J | Visual elements production | Not started (existing figures deployed) |
| K | Pre-publication verification | Not started |

---

## Execution Order for Next Session

### Priority options:
1. **Batch H remainder** -- Ch 10 "Where to Start" (highest leverage: flips `needs_revision`), Ch 5 provenance field spec + arbitration heuristic, Ch 6 variable-length input. All bounded additions, no research needed.
2. **Batch G: DG-3** -- Ch 14 TCO section (API vs. fine-tuning). Half-page to one page of new content. Decision made, content not written.
3. **Batch F remainder** -- Author-experience reframing across multiple chapters. Broader effort.
4. **Batch I** -- Structural scope decisions (author session).

### Unrendered PaperBanana figures (carried forward)
- `fig-07-01_error_classification_table.md` (Ch 7)
- `ch14_cost_trajectory.md` (Ch 14)
Need PaperBanana runs on Brock's machine. Not blocking.

### Seldon repo tasks (carried forward)
- `7e862893` (proposed): `outlined` state gate for PaperSection
- `84c880a8` (proposed): Build artifact tracking for AD-018
- (unregistered): Enforce run directory convention in auditor agent

---

## Items NOT to Re-flag
- $15/$50/$100 cost framing (DG-5 -- resolved)
- Fleiss'/Cohen's kappa (DG-2 -- no error)
- OWASP ASI codes (all verified, ASI06 fixed)
- Em-dashes in foreword-Ch 2 (already clean)
- `\$` escaping in foreword-Ch 2 (already clean)
- Back matter TOC order (already correct)
- MetaHarness citation (verified valid, arXiv 2603.28052)
- FCSM "4 dimensions" in Ch 8 (correct in context -- 4 of 11 with no NIST equivalent)
- Ch 1 terminology drift framing (already an observation, not a literature claim)
- Ch 4 KG vs concept map (no W3C boundary claim present)
- Ch 11 SWE-CI language (already correct)

---

## CC Tasks Completed This Session

| File | ID | Status |
|------|-----|--------|
| `cc_tasks/2026-04-07_tier1_quick_fixes.md` | `d6ce0aa2` | Completed |
| `cc_tasks/2026-04-07_ch14_dollar_escaping.md` | `15dc3014` | Completed |
| `cc_tasks/2026-04-07_citation_sprint_a.md` | `f98f2223` | Completed |
| `cc_tasks/2026-04-07_citation_sprint_b.md` | `251dd207` | Completed |

## Files Modified by CC Execution This Session

| File | Changes |
|------|---------|
| `book/chapter-01.md` | Evaluation trap paragraph (tier 1); temperature=0 citation (sprint A) |
| `book/chapter-02.md` | Landis-Koch citation, position bias citation (sprint A) |
| `book/chapter-03.md` | Morris/Verasight citation for 10pp claim (sprint A); deployment timeline qualifier (sprint B) |
| `book/chapter-04.md` | Chunking citation (sprint A) |
| `book/chapter-05.md` | Correlated errors citation + independence softening (sprint A) |
| `book/chapter-07.md` | Temperature fix, frontier→18 models (sprint B) |
| `book/chapter-08.md` | Silent updates citation (sprint A); FCSM 4-of-11 clarification (sprint B) |
| `book/chapter-09.md` | Silent updates citation (sprint A) |
| `book/chapter-10.md` | SCORE precise figures, Brodeur 30%, DOORS citation (sprint A) |
| `book/chapter-13.md` | FedRAMP 20x citation (sprint A) |
| `book/chapter-14.md` | 16 dollar sign escapes (escaping task) |
| `book/intro.md` | Narrative bridge, closing sentence (tier 1) |
| `book/references.bib` | 10 new entries, 1 modified (MetaHarness note removal) |
