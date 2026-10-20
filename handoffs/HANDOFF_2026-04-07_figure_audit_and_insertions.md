# Session Handoff: Figure Audit, Model Mix, Format Normalization, Accuracy Fix

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Prior handoff:** `handoffs/HANDOFF_2026-04-07_batch_h_and_dg3.md`

---

## What Was Accomplished This Session

### 1. Complete PaperBanana Figure Audit
Full audit of all PaperBanana method files, rendered PNGs, `book/images/` deployments, and chapter figure references. Every figure traced end-to-end.

**Findings:**
- 15 figures deployed and correctly referenced in chapter text. All clean.
- **fig-05-04** (topology comparison table): Rendered PNG existed but was orphaned. Never inserted into chapter text because Ch 5 already has the same content as a MyST text table (`tbl-05-04`). **Author decision: delete.** A table is the right format for a table, not a figure.
- **fig-07-01** (error classification table): Same situation. Method file existed but Ch 7 already has the content as MyST table (`tbl-07-01`). **Author decision: delete.**
- **ch13_governance_models**: Naming mismatch — source PNG in PaperBanana dir used `ch13_` prefix while deployed copy used `fig-13-01_` prefix. Renamed to `fig-13-01_` convention.
- **ch14_cost_trajectory**: Method file existed but never rendered or inserted. Renamed to `fig-14-01_` convention, rendered via PaperBanana, inserted into Ch 14.

### 2. Figure Cleanup and Ch 14 Insert (`f7c9a983`) -- COMPLETE
- Deleted `fig-05-04_topology_comparison_table_method.txt` and rendered PNG
- Deleted `fig-07-01_error_classification_table.md`
- Renamed `ch13_governance_models.*` to `fig-13-01_governance_models.*`
- Renamed `ch14_cost_trajectory.md` to `fig-14-01_cost_trajectory.md`
- Rendered fig-14-01 via PaperBanana and deployed to `book/images/`
- Inserted figure directive into Ch 14 (after cost comparison paragraph, before "The Cost Taxonomy")
- Updated `book/figure-registry.md` (deleted fig-07-01 row, updated fig-13-01 and fig-14-01 entries)

### 3. Model Mix and Format Normalization (`15e052e4`) -- COMPLETE
Two paragraph insertions from practitioner design patterns:

- **Ch 14:** "Model mix across pipeline stages" paragraph. Inserted after "Configuration-driven model selection" paragraph, before "The Fine-Tuning Crossover" heading. Fills the gap between "pick the cheapest model" (already covered) and "pick the cheapest model per stage" (implied but never stated). Connects config-driven model interface to the idea that different stages have different complexity profiles.
- **Ch 6:** "Normalize formats at the gate" paragraph. Inserted after Pike's "Data dominates" rule, before fig-06-03. States the principle that raw document formats (PDF, DOCX, HTML) should be converted to canonical text at the pipeline entry point. Preprocessing is infrastructure, not a prompt concern.

### 4. Fix "99.5% Accuracy" Mislabel (`61cc3d1b`) -- COMPLETE
Ch 14 cost comparison table labeled 99.5% as "Accuracy." This is actually the **automated resolution rate** (percentage of questions classified without routing to human review), not an accuracy measurement. Accuracy would require ground truth evaluation. The actual quality metric is Cohen's kappa = 0.839 (reported correctly in Ch 2).

- Changed table row from `| Accuracy | 99.5% (dual-model cross-validated) |` to `| Automated resolution | 99.5% classified without human review; kappa = 0.839 topic-level agreement |`
- Updated CLAUDE.md Key Source Material to match
- Resolves CC-7 (carried forward since Session 3)

### 5. Decision Record (`4fa7345e`) -- CLOSED
Tracked and closed the author decision to delete fig-05-04 and fig-07-01 PaperBanana specs. Rationale: tables rendered as PNGs lose searchability, accessibility, and maintainability. MyST text tables are the correct format.

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
| G | Cross-chapter coherence set 2 (gated decisions) | **Complete** |
| H | Structural short additions | **Complete** |
| I | Structural scope decisions | Not started |
| J | Visual elements production | **Complete** (all figures now deployed or intentionally deleted) |
| K | Pre-publication verification | Not started |

### Known Graph Bug
`cc_register` created `61cc3d1b` in `completed` state instead of `proposed`. Same known bug as before — `cc_complete` short-circuits. Add to the list of affected IDs: `f28ae7df`, `88d209ea`, `599413e0`, `1826188c`, `f563fff6`, `61cc3d1b`.

---

## Execution Order for Next Session

### Priority options:
1. **Batch F remainder** -- Author-experience reframing across Ch 2, 4, 6, 7, 9, 11. Pattern: where design observations or operational experiences are stated as field-established facts, add "in the author's experience/observation." Broader effort, touches many files.
2. **Batch I** -- Structural scope decisions (author session). Items requiring author judgment on whether to add content or scope explicitly.
3. **Batch K** -- Pre-publication verification.

### PaperBanana figures -- RESOLVED
All figures are now either deployed or intentionally deleted. No outstanding renders needed. Batch J is complete.

### Seldon repo tasks (carried forward)
- `7e862893` (proposed): `outlined` state gate for PaperSection
- `84c880a8` (proposed): Build artifact tracking for AD-018
- (unregistered): Enforce run directory convention in auditor agent

---

## Items NOT to Re-flag
All items from prior handoff, plus:
- fig-05-04 topology comparison table (deleted -- MyST table is correct format)
- fig-07-01 error classification table (deleted -- same reason)
- ch13 PaperBanana naming mismatch (standardized to fig-13-01 convention)
- CC-7 / 99.5% accuracy mislabel (fixed -- now "Automated resolution")
- Model mix per pipeline stage (inserted in Ch 14)
- Format normalization as infrastructure (inserted in Ch 6)

---

## CC Tasks Completed This Session

| File | ID | Status |
|------|-----|--------|
| `cc_tasks/2026-04-07_figure_cleanup_and_ch14_insert.md` | `f7c9a983` | Completed |
| `cc_tasks/2026-04-07_model_mix_and_format_normalization.md` | `15e052e4` | Completed |
| `cc_tasks/2026-04-07_fix_accuracy_mislabel.md` | `61cc3d1b` | Completed |

## Files Modified by CC Execution This Session

| File | Changes |
|------|---------|
| `book/chapter-06.md` | "Normalize formats at the gate" paragraph |
| `book/chapter-14.md` | fig-14-01 figure directive; "Model mix across pipeline stages" paragraph; 99.5% accuracy → automated resolution fix |
| `book/figure-registry.md` | Deleted fig-07-01 row; updated fig-13-01 and fig-14-01 entries |
| `CLAUDE.md` | Updated 99.5% accuracy → automated resolution rate in Key Source Material |
| `assets/diagrams/paperbanana/` | Deleted fig-05-04 files, deleted fig-07-01 file, renamed ch13→fig-13-01, renamed ch14→fig-14-01 |
| `book/images/fig-14-01_cost_trajectory.png` | New file (PaperBanana render deployed) |
