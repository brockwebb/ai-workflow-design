# Session Handoff: Batch H Completion + DG-3 Ch 14 TCO Section

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Prior handoff:** `handoffs/HANDOFF_2026-04-07_citation_sprints.md`

---

## What Was Accomplished This Session

### 1. Batch H Remainder (`66a049f1`) -- COMPLETE
Five bounded structural additions across four chapters. All executed by CC, verified, graph marked complete.

- **Ch 5 Edit 1:** Provenance minimum field specification. One paragraph after "Version everything" in Cross-Cutting Design Principles. Specifies minimum record fields (input ID, model version, prompt version, timestamp, raw output, final value, confidence flag, decision rule). Operationalizes the "full provenance" principle Ch 5 asserts but never defined.
- **Ch 5 Edit 2:** Arbitration strategy selection heuristic. One paragraph after topology composition discussion, before Cross-Cutting Design Principles. Three strategies (confidence-weighted, third-model tiebreaker, human review) with when-to-use guidance. References Concept Mapper's ~3% human review.
- **Ch 6 Edit 3:** Variable-length input design paragraph. Four sentences after runtime formula, before figure directive. Two adjustments: sort by token count before batching; estimate conservatively from longest records.
- **Ch 9 Edit 4:** Symptom-to-threat diagnostic table (`tbl-09-01`). Seven-row table mapping observable symptoms to T1-T5 threats with first investigation steps. Inserted where Ch 9 already said "no chapter provides a symptom-to-threat mapping."
- **Ch 10 Edit 5:** "Where to Start" section. Half-page, three-tier migration path (JSONL event log, per-record provenance, graph). Between Authority Model and Thought Experiment. Highest-leverage item: addresses Ch 10's `needs_revision` status.

### 2. Batch G DG-3: Ch 14 TCO Section (`03fbd967`) -- COMPLETE
New section "The Fine-Tuning Crossover" added between "When Cheap Models Win" and "Making the Case." Fulfills Ch 3's forward reference ("Chapter 14 provides a cost accounting framework that makes this comparison rigorous"). Closes CC-5 (broken forward reference).

Content covers: API linear cost scaling vs. fine-tuning front-loaded cost curve, four variables determining crossover (volume, workload stability, MLOps maturity, federal infrastructure overhead), comparison table across five cost categories, design-for-change callback to Ch 6. Does NOT duplicate Ch 3's qualitative analysis.

---

## Current State

### Graph
- **Zero proposed tasks.** All clear.
- **Zero open issues.**

### Sweep Synthesis Batch Status

| Batch | Description | Status |
|-------|-------------|--------|
| A | Author decision session (6 gates) | **Complete** |
| B | Mechanical fixes (19 edits) | **Complete** |
| C | Citation research sprint 1 (foundation claims) | **Complete** |
| D | Citation research sprint 2 (provenance/federal) | **Complete** |
| E | OWASP verification | **Complete** |
| F | Cross-chapter coherence set 1 (non-gated) | **Partially complete** (CC-8, CC-9, CC-10 done; author-experience reframing not started) |
| G | Cross-chapter coherence set 2 (gated decisions) | **Complete** (DG-1, DG-2, DG-4 done prior; DG-3 done this session) |
| H | Structural short additions | **Complete** |
| I | Structural scope decisions | Not started |
| J | Visual elements production | Not started (existing figures deployed) |
| K | Pre-publication verification | Not started |

---

## Execution Order for Next Session

### Priority options:
1. **Batch F remainder** -- Author-experience reframing across multiple chapters (Ch 2, 4, 6, 7, 9, 11). Pattern: where design observations or operational experiences are stated as field-established facts, add "in the author's experience/observation." Broader effort, touches many files.
2. **Batch I** -- Structural scope decisions (author session). Includes items requiring author judgment on whether to add content or scope explicitly.
3. **CC-7: Ch 14 99.5% accuracy figure** -- Still unresolved. Ch 2 reports kappa values, not percentage accuracy. Author must identify source or replace with kappa reference. Standalone fix, high defensibility value.
4. **Batch J** -- Visual elements production (PaperBanana figures).
5. **Batch K** -- Pre-publication verification.

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
All items from prior handoff, plus:
- Ch 3 → Ch 14 fine-tuning forward reference (CC-5 -- resolved, "The Fine-Tuning Crossover" section added)
- Ch 10 "Where to Start" (done)
- Ch 5 provenance fields (done)
- Ch 5 arbitration heuristic (done)
- Ch 6 variable-length input (done)
- Ch 9 diagnostic table (done)

---

## CC Tasks Completed This Session

| File | ID | Status |
|------|-----|--------|
| `cc_tasks/2026-04-07_batch_h_remainder.md` | `66a049f1` | Completed |
| `cc_tasks/2026-04-07_ch14_tco_section.md` | `03fbd967` | Completed |

## Files Modified by CC Execution This Session

| File | Changes |
|------|---------|
| `book/chapter-05.md` | Provenance field spec paragraph; arbitration heuristic paragraph |
| `book/chapter-06.md` | Variable-length input paragraph |
| `book/chapter-09.md` | Symptom-to-threat diagnostic table (tbl-09-01) |
| `book/chapter-10.md` | "Where to Start" section (half-page) |
| `book/chapter-14.md` | "The Fine-Tuning Crossover" section (API vs. fine-tuning TCO) |
