# Session Handoff: Batch B Execution, Figure Deployment, Batch E, Cross-Chapter Fixes

**Date:** 2026-04-07
**Project:** ai-workflow-design (primary)
**Prior handoff:** `seldon/handoffs/2026-04-07_decision_gates_batch_b.md`

---

## What Was Accomplished This Session

### 1. Batch B Executed and Verified
- CC task `cc_tasks/2026-04-07_batch_b_mechanical_fixes.md` registered, executed by Claude Code, completed in graph (`46fe58f0`)
- All 19 mechanical fixes applied across 11 files
- DG-1 structural changes (four clusters → five phases in Ch 1, intro phase headings reorganized)
- DG-2 kappa clarification in Ch 8
- Acronym expansions (MCMC, MAD, CIPSEA, MICE)
- Citation markup additions, cross-reference corrections, terminology alignment
- MAD confirmed as "Model Autophagy Disorder" from context (not Median Absolute Deviation)

### 2. Figure Deployment — JPEG→PNG Bug Found and Fixed
- **Root cause identified:** Every PaperBanana output is JPEG image data with a `.png` file extension. `file` command reports "JPEG image data, JFIF standard 1.01" for all paperbanana PNGs. This caused rendering failures in chapters pointing to the paperbanana source files.
- The 5 figures already in `book/images/` (Ch 1-4) were real PNGs — someone converted them in a prior session. Ch 5-7 figures were pointing directly at the mislabeled JPEG sources.
- CC task `cc_tasks/2026-04-07_figure_deployment.md` registered, executed, completed (`b441d79d`). Five parts:
  - **Part A:** 10 JPEG→PNG conversions to `book/images/`, 5 existing verified clean
  - **Part B:** 8 `{figure}` directive paths normalized from `../assets/diagrams/paperbanana/` to `images/` in Ch 5, 6, 7
  - **Part C:** New `{figure}` directives added to Ch 11 (fig-11-01, evaluation framework template) and Ch 13 (fig-13-01, governance models, renamed from ch13_governance_models.png)
  - **Part D:** Figure registry (`book/figure-registry.md`) rewritten — 15 deployed + 2 method-only entries
  - **Part E:** 32 stale `run_*` directories deleted (5 from `book/images/`, 27 from `assets/diagrams/paperbanana/`)
- **fig-05-04 (topology comparison table):** Deliberately skipped — redundant with Ch 5's existing MyST table

### 3. Batch E — OWASP ASI Code Verification
- All five OWASP ASI codes in appendix-security verified against published OWASP Top 10 for Agentic Applications 2026 (December 9, 2025 release):
  - ASI01: Agent Goal Hijack ✅
  - ASI02: Tool Misuse and Exploitation ✅
  - ASI03: Identity and Privilege Abuse ✅
  - ASI08: Cascading Failures ✅
  - ASI09: Human-Agent Trust Exploitation ✅
- Sweep synthesis concern that ASI08 and ASI03 "may be wrong" was a **false positive**
- **One finding:** Memory/context poisoning described on line 29 without its ASI code (ASI06). All other threats get "(ASI0X)" treatment. Inconsistency, not a style choice.
- CC task `cc_tasks/2026-04-07_batch_e_owasp_verification.md` registered (`76f3b062`), **not yet executed** — one-line fix: add "(ASI06;" and capitalize to match pattern

### 4. Cross-Chapter Coherence Fixes
- CC task `cc_tasks/2026-04-07_cross_chapter_coherence_fixes.md` registered, executed, completed (`ca6e17fe`). Four fixes:
  - **CC-2:** "specification-before-execution" pattern formally named in Ch 10 Requirement 7 (2 sentences)
  - **CC-9:** Five degradation pathways explicitly enumerated in Ch 1 (1 summary paragraph with all 6 existing citations)
  - **CC-10:** "stochastic tax reduction" → "confabulation risk reduction" in Ch 4 (term collision resolved)
  - **Fix 4:** Post-recovery equivalence validation pointer added to Ch 7 (points to Ch 8 golden test set)

### 5. Items Verified Already Clean
- Em-dash purge (foreword through Ch 2): no em-dashes found, already clean
- `\$` escaping (foreword through Ch 2): already properly escaped
- Back matter TOC reorder: `myst.yml` already has bibliography before glossary before index

---

## Current State

### Graph
- **One proposed task remaining:** `76f3b062` (Batch E OWASP — ASI06 one-line fix). Ready to execute.
- All other tasks completed.

### CC Tasks Queued

| Task | Location | Status |
|------|----------|--------|
| Batch E OWASP ASI06 fix | `cc_tasks/2026-04-07_batch_e_owasp_verification.md` | Registered, not executed |
| Auditor agent run-directory enforcement (Seldon) | `seldon/cc_tasks/2026-04-06_enforce_run_directory_convention.md` | Written, not executed |

---

## Sweep Synthesis Batch Status

| Batch | Description | Status |
|-------|-------------|--------|
| A | Author decision session (6 gates) | **Complete** |
| B | Mechanical fixes (19 edits) | **Complete** |
| C | Citation research sprint 1 (foundation claims) | Not started |
| D | Citation research sprint 2 (provenance/federal) | Not started |
| E | OWASP verification | **Verified, 1-line fix queued** |
| F | Cross-chapter coherence set 1 (non-gated) | **Partially complete** (CC-9, CC-10 done; remainder not started) |
| G | Cross-chapter coherence set 2 (gated decisions) | Not started (DG-3 Ch 14 TCO, DG-4 evaluation trap in Ch 1) |
| H | Structural short additions | **Partially complete** (spec-before-execution done, Ch 7 pointer done; Ch 10 "Where to Start", Ch 5 provenance fields not started) |
| I | Structural scope decisions | Not started |
| J | Visual elements production | Not started (but figure deployment covers existing renders) |
| K | Pre-publication verification | Not started |

---

## Execution Order for Next Session

### 1. Execute Batch E one-liner
- `cc_tasks/2026-04-07_batch_e_owasp_verification.md` — add ASI06 code to memory/context poisoning in appendix-security. Trivial.

### 2. Choose next batch
Priority options:
- **Batch C/D (citation research sprints)** — Perplexity-driven. ~30 citation gaps. Highest-impact unblocked work. These two can run in parallel.
- **Batch G (cross-chapter coherence, gated)** — DG-3 (Ch 14 TCO section or Ch 3 promise revision), DG-4 (evaluation trap — add to Ch 1). These were resolved in Batch A decisions but the content hasn't been written yet.
- **Batch H remainder** — Ch 10 "Where to Start" section (DG-6), Ch 5 provenance minimum field spec. High leverage for converting `needs_revision` chapters.
- **Batch F remainder** — CC-8 already done via Batch B (throughput ladder). Remaining: author-experience reframing across multiple chapters, SWE-CI "frontier" verification, silent model updates citation (needs Perplexity — overlaps with Batch C).

### 3. Unrendered PaperBanana figures
Two method files exist without rendered PNGs:
- `fig-07-01_error_classification_table.md` (Ch 7)
- `ch14_cost_trajectory.md` (Ch 14)
These need PaperBanana runs on Brock's machine. Not blocking but tracked in figure registry as "Method only."

---

## Items NOT to Re-flag
- $15/$50/$100 cost framing (DG-5 — resolved, numbers correct)
- Fleiss'/Cohen's κ correctness (DG-2 — no error, clarification sentence in Ch 8)
- OWASP ASI codes (all verified correct, ASI06 fix queued)
- Em-dashes in foreword-Ch 2 (already clean)
- `\$` escaping in foreword-Ch 2 (already clean)
- Back matter TOC order (already correct)

---

## Open Tasks — ai-workflow-design

| ID prefix | State | Description |
|-----------|-------|-------------|
| `76f3b062` | proposed | Batch E OWASP ASI06 one-line fix |

## Open Tasks — Seldon

| ID prefix | State | Description |
|-----------|-------|-------------|
| `7e862893` | proposed | `outlined` state gate for PaperSection |
| `84c880a8` | proposed | Build artifact tracking for AD-018 |
| (unregistered) | written | Enforce run directory convention in auditor agent |

---

## Files Created This Session

### ai-workflow-design repo
| File | Type | Status |
|------|------|--------|
| `cc_tasks/2026-04-07_batch_b_mechanical_fixes.md` | CC task | Completed (prior session wrote, this session executed) |
| `cc_tasks/2026-04-07_figure_deployment.md` | CC task | Completed |
| `cc_tasks/2026-04-07_batch_e_owasp_verification.md` | CC task | Registered, not executed |
| `cc_tasks/2026-04-07_cross_chapter_coherence_fixes.md` | CC task | Completed |

### Files Modified by CC Execution
| File | Changes |
|------|---------|
| `book/intro.md` | Phase headings, Ch 11 placement, Where to Start refs, maturity levels label (Batch B) |
| `book/chapter-01.md` | Five phases, MCMC/MAD expansions (Batch B); five degradation pathways labeled (coherence) |
| `book/chapter-02.md` | ABBA attribution sentence (Batch B) |
| `book/chapter-03.md` | Golden test set correction, CIPSEA/MICE expansions (Batch B) |
| `book/chapter-04.md` | Bradley-Terry citation, multi-model reframe (Batch B); confabulation risk term fix (coherence) |
| `book/chapter-05.md` | Throughput Ladder term, figure paths normalized (Batch B + figures) |
| `book/chapter-06.md` | Figure paths normalized (figures) |
| `book/chapter-07.md` | Ch 8 bridge addition (Batch B); figure paths normalized (figures); post-recovery pointer (coherence) |
| `book/chapter-08.md` | Thought experiment separator, kappa clarification (Batch B) |
| `book/chapter-10.md` | State machine parenthetical (Batch B); spec-before-execution naming (coherence) |
| `book/chapter-11.md` | fig-11-01 directive added (figures) |
| `book/chapter-13.md` | NIST citation, DLP expansion (Batch B); fig-13-01 directive added (figures) |
| `book/chapter-14.md` | Throughput Ladder term (Batch B) |
| `book/images/` | 10 new PNG files (converted from JPEG) |
| `book/figure-registry.md` | Complete rewrite — 15 deployed + 2 method-only |
