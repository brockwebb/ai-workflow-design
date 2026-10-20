# Session Handoff: Batch F Completion, Batch I Scoped and Queued

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Prior handoff:** `handoffs/HANDOFF_2026-04-07_figure_audit_and_insertions.md`

---

## What Was Accomplished This Session

### 1. Batch F Remainder — Author-Experience Reframing (`e1f42233`) -- COMPLETE

Systematic audit of all chapters flagged for bare empirical assertions (sweep synthesis item 22 + item 21). Found 8 candidate passages across Ch 1, 2, 4, 6, 7, 9, 11. After analysis, 5 needed reframing; 3 were already done or didn't need changes.

**Edits specified (6 across 4 files):**

| Ch | Edit | Rationale |
|---|---|---|
| 1 | "In the author's assessment, the tooling market is not filling this gap." | Market characterization is judgment |
| 1 | "As of this writing, the tooling market is building Level 3+..." | Snapshot — signals datability |
| 2 | "likely share training pipelines" + "in the author's experience, more meaningful" | Inference hedge + judgment attribution |
| 6 | "In the Concept Mapper pipeline, 40% of runtime..." | Names whose pipeline |
| 9 | "In the author's experience, state supersession failure is common..." | Frequency claim needs attribution |

**Items reviewed and NOT changed (with rationale in CC task):**
- Ch 4 line 78 (stochastic tax principle) — logical argument, not empirical claim
- Ch 6 lines 137-141 (infrastructure reinvention) — already names Concept Mapper
- Ch 7 line 25 (temperature removal) — verifiable fact, not author opinion
- Ch 7 line 37 (silent failures) — already has "The author experienced" framing
- Ch 11 lines 22/30 (LangChain + landscape) — already reframed in prior CC task

CC task sent to execution during session. Graph shows `completed` state (known registration bug — may have skipped proposed→completed transition).

### 2. Batch I — Structural Scope Decisions Scoped (`935c3802`) -- PROPOSED

All 7 items scoped with author decisions. Three required substantive author judgment (I-1, I-2, I-3); four are bounded additions (I-4 through I-7). I-4 was revised twice and I-5 once based on author feedback during session.

**Author decisions:**

| Item | Chapter | Decision |
|---|---|---|
| I-1 | Ch 8 | Option B: scope note, not new section. Golden test set = directionality. "How much is enough?" is unsolved — name the gap honestly. Soup spoon principle. |
| I-2 | Ch 14 | Add 5th cost category: institutional overhead (ATO, FedRAMP). Direct costs, not opportunity costs. Security must function as mission enabler. |
| I-3 | Ch 13 | Pilot spec is relativistic, not prescriptive. Must solve real pain, use public data, ship fast. Speed differential is the political lever. Don't sanitize the frustration. |
| I-4 | Ch 4 | **REVERSED from synthesis.** Regex is yesterday's solution. Regex is NOT deterministic in practice — it's a bet against the input space with silent misses. Observable LLM stochasticity beats invisible regex bias. Default: use the LLM. |
| I-5 | Ch 1 | **EXPANDED.** Three reflection prompts (was one). After Iterative Refinement Trap, Evaluation Trap, Removing Yourself from the Loop. "Have you experienced this?" style. |
| I-6 | Ch 3 | Confirmed as written. Working principle connection sentence. |
| I-7 | Ch 2 | Confirmed as written. Fine-tuning cross-reference sentence. |

---

## Current State

### Graph
- **One proposed task:** `935c3802` (Batch I structural scope decisions)
- **Zero open issues.**

### Sweep Synthesis Batch Status

| Batch | Description | Status |
|-------|-------------|--------|
| A | Author decision session (6 gates) | **Complete** |
| B | Mechanical fixes (19 edits) | **Complete** |
| C | Citation research sprint 1 (foundation claims) | **Complete** |
| D | Citation research sprint 2 (provenance/federal) | **Complete** |
| E | OWASP verification | **Complete** |
| F | Cross-chapter coherence set 1 (non-gated) | **Complete** |
| G | Cross-chapter coherence set 2 (gated decisions) | **Complete** |
| H | Structural short additions | **Complete** |
| I | Structural scope decisions | **CC task written, ready to execute** |
| J | Visual elements production | **Complete** |
| K | Pre-publication verification | Not started |

### Known Graph Bug
`cc_register` / `cc_complete` short-circuit bug. Affected IDs: `f28ae7df`, `88d209ea`, `599413e0`, `1826188c`, `f563fff6`, `61cc3d1b`, `e1f42233`.

---

## Execution Order for Next Session

### 1. Execute Batch I CC task
`cc_tasks/2026-04-07_batch_i_structural_scope_decisions.md` — 7 edits across 7 files. All author decisions made. Ready for CC execution.

### 2. Spec and execute Batch K (pre-publication verification)
Final pass: bib verification, formatting consistency, figure file checks, remaining low-severity residuals from synthesis. Can be spec'd quickly — it's mechanical.

### After K: Publication readiness
With Batches A through K complete, the book moves to build verification and publication prep.

### Seldon repo tasks (carried forward)
- `7e862893` (proposed): `outlined` state gate for PaperSection
- `84c880a8` (proposed): Build artifact tracking for AD-018
- (unregistered): Enforce run directory convention in auditor agent

---

## Key Design Decision This Session: Regex as False Determinism

The I-4 discussion produced an argument worth tracking. The author's position: regex is not deterministic in practice. It's a probabilistic bet against the input space. Silent misses (no error, no flag, just incomplete results) are a worse failure mode than LLM stochasticity because LLM variance is observable and measurable while regex produces invisible systematic error. This connects to the book's broader thesis: stochastic instruments with evaluation infrastructure are more trustworthy than deterministic-looking processes with no monitoring.

This argument appears in the I-4 CC task content direction but is worth noting as a conceptual contribution that may deserve broader treatment in future revisions.

---

## Items NOT to Re-flag
All items from prior handoffs, plus:
- Author-experience reframing across Ch 1, 2, 6, 9 (Batch F complete)
- Ch 4 stochastic tax principle — not an empirical claim, no reframe needed
- Ch 7 temperature removal — verifiable fact, no reframe needed
- Ch 7 silent failures, Ch 11 LangChain — already reframed in prior CC tasks
- Ch 8 evaluation calibration — scoped as scope note, not new section (I-1 decided)
- Regex vs. LLM guidance — reversed from synthesis recommendation (I-4 decided)
- Ch 1 reflection prompt count — three, not one (I-5 decided)

---

## CC Tasks This Session

| File | ID | Status |
|------|-----|--------|
| `cc_tasks/2026-04-07_batch_f_author_experience_reframing.md` | `e1f42233` | Completed |
| `cc_tasks/2026-04-07_batch_i_structural_scope_decisions.md` | `935c3802` | Proposed (ready to execute) |
