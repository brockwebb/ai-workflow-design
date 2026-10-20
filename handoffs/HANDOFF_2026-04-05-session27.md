# Handoff: Session 27 — Graph Cleanup, Ch 11 AD-020 + Revision, Ch 12 AD-020, Research Notes, Security Appendix Decision

**Date:** 2026-04-05
**Session scope:** Graph task deduplication, Ch 11 AD-020 calibration run 009, Ch 11 revision (stochastic tax fix, LangChain/rhetoric reframing, SWE-CI fix, vocabulary bridging table, Meta-Harness citation, figure spec), Ch 12 AD-020 calibration run 010, Ch 12 revision task written, Meta-Harness + OMNI-SIMPLEMEM research notes filed, security appendix decision gate closed
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Graph Task Deduplication

Three stale proposed tasks closed — all completed via CC tasks in Session 26 but original manually-created graph tasks never transitioned:
- `c7fb788a` — Ch 6 KG seed (done in Session 26)
- `c344d858` — Ch 10 KG treatment (done in Session 26)
- `bfda3b09` — Ch 10 Hogan bib entry (done in Session 26)

No orphan ghost tasks found — pre-bug-fix cleanup already handled.

### Ch 11 AD-020 Pipeline (Calibration Run 009)

CC task written (`cc_tasks/2026-04-05_ch11_ad020_review_pipeline.md`), executed by Claude Code. Verdict: `conditionally_ready`. 8 clusters, 1 hard error (stochastic tax attribution — "Chapter 9's" should be "Chapter 1's"), 5 confirmed cascades, 1 broken.

New gates introduced:
- **Dateability check** — most productive new gate for landscape chapters
- **Vocabulary bridging check** — independently confirmed design note's diagnosis

Key finding: Ch 11 has the most appropriate citation profile (3 citations, deliberately sparse to avoid dating) and first-ever 1/9/0 practitioner score for a framework chapter.

Perplexity verification completed for all 6 queries (PQ1–PQ6). Results: SWE-CI paper confirmed, "frontier models" wording not in paper, LangChain migration docs support general coupling claim, 90/10 rule has no canonical scholarly attribution, landscape volatility claims need softening.

### Ch 11 Revision

CC task written (`cc_tasks/2026-04-05_ch11_revision.md`), executed by Claude Code. Six-part revision:

| Part | Content |
|------|---------|
| A | Stochastic tax: "Chapter 9's" → "Chapter 1's" |
| B | LangChain author-experience framing + 90/10 attribution + landscape rhetoric softening |
| C | SWE-CI: "frontier models" → "models tested (18 models from 8 providers)" |
| D | Vocabulary bridging table (5 rows from design note) in "What to Bet On" section |
| E | Meta-Harness bib entry (`lee_2026_metaharness`) + 3–5 sentence passage in recursive stochasticity |
| F | Evaluation framework scoring template figure spec (PaperBanana method file) |

### Ch 12 AD-020 Pipeline (Calibration Run 010)

CC task written (`cc_tasks/2026-04-05_ch12_ad020_review_pipeline.md`), executed by Claude Code. Verdict: `conditionally_ready`. 8 clusters. Cleanest cascade record in the series (5/5 confirmed, 0 broken). Best narrative arc (hook reconnected 3 times). Flattest Bloom scaffolding (Apply plateau).

New gates introduced:
- **Dual audience check** — found moderate Persona A/B asymmetry (3/2/0 security vs 1/4/0 practitioner)
- **Agentic security gap check** — convergence 4, strongest cluster. Gap confirmed: chapter treats all AI workflows as predefined pipelines
- **Regulatory accuracy check** — caught Five Safes legislative adoption claim

Key finding: Agentic security gap is confirmed and specific.

Perplexity verification completed for PQ1–PQ4. Results: Five Safes legislative claim needs softening ("reflected in" not "embedded in"), LLM memorization defensible with Carlini citation, consumer/enterprise ToS needs hedging, international adoption claims supported.

### Ch 12 Revision Task Written (NOT EXECUTED)

CC task written (`cc_tasks/2026-04-05_ch12_revision.md`) and registered (`8ffe2e93`). Parts A–D are textual corrections (safe to execute now). Part E was the security appendix decision — now resolved (see below).

**Status: NOT EXECUTED.** Task is `proposed` in graph. Parts A–D can be executed immediately.

### Security Appendix Decision Gate — CLOSED

Decision gate `1826188c` closed. **Author decision: standalone appendix.**

Agentic AI security material (OWASP ASI taxonomy, NCCoE agent identity, NIST CAISI RFI, NIST Cyber AI Profile, NIST Agent Standards Initiative) becomes a focused appendix. Ch 12's Five Safes structure stays intact. Ch 12 revision Part E becomes: add one sentence in Ch 12 pointing to the appendix.

New task created (`1f6c25b1`): write the appendix. Covers tool invocation authorization, agent identity/authentication, prompt injection via tool outputs, MCP server attack surfaces, runtime boundary enforcement. Framing: mission enablement for CISO conversation, shared vocabulary, not security engineering. Appendix gets its own AD-020 pass after draft.

### Research Notes Filed

**Meta-Harness (Lee et al. 2026):** `docs/research_note_meta_harness_lee_2026.md`. Task `edcdc3d1` in graph. Two citation targets: Ch 11 (done — integrated in revision Part E) and SFV (deferred — separate project scope). BibTeX added to references.bib during Ch 11 revision.

**OMNI-SIMPLEMEM (Liu et al. 2026):** `docs/research_note_omnisimplemem_liu_2026.md`. No graph task created (not targeted for book insertion). Architecture reference for Wintermute only. SFV citation deferred — Meta-Harness provides stronger evidence for the instrument instability argument.

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Graph task deduplication (3 stale tasks closed) | Done |
| Ch 11 AD-020 audit (calibration run 009) | Done |
| Ch 11 Perplexity verification (PQ1–PQ6) | Done |
| Ch 11 revision (Parts A–F) | Done |
| Ch 12 AD-020 audit (calibration run 010) | Done |
| Ch 12 Perplexity verification (PQ1–PQ4) | Done |
| Security appendix decision gate (`1826188c`) | **Closed — standalone appendix** |
| Meta-Harness research note | Done |
| OMNI-SIMPLEMEM research note | Done |
| `lee_2026_metaharness` added to references.bib | Done |

---

## Outstanding Items — Execution Queue

### Immediate (before Ch 13 AD-020):

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 1 | **Ch 12 revision (Parts A–D)** | HIGH | CC task written, registered (`8ffe2e93`), NOT executed. Parts A–D are straightforward textual corrections. Part E: add one sentence pointing to the new appendix. |
| 2 | **Ch 12 revision Part E update** | HIGH | The CC task Part E says "AUTHOR DECISION REQUIRED." Decision is now made: standalone appendix. Update Part E instructions or write an addendum specifying the one-sentence appendix pointer for Ch 12. |

### Ch 13 AD-020 pipeline:

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 3 | **Ch 13 AD-020 audit** (calibration run 011) | **NEXT** | Write CC task, run pipeline. Ch 13 is "Institutional Deployment" — new chapter type. |

### Agentic security appendix:

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 4 | **Write agentic AI security appendix** (`1f6c25b1`) | Medium | Sources: `docs/security_sources/review_summary.md`. Draft first, then AD-020 pass. Not blocking Ch 13. |

### Carried forward:

| # | Item | Priority | Notes |
|---|------|----------|-------|
| 5 | Em-dash purge + `\$` escaping (foreword-Ch 2) | Medium | Session 17 leftover |
| 6 | Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| 7 | Batch figure render + insertion | Verify | Was marked completed in graph (Session 24 reconciliation) — verify PNGs exist |
| 8 | arXiv:2502.01534 metadata verification | Low | Carried from Session 17 |
| 9 | Ch 9 optional Groves 2009 citation (`d9fbc94f`) | Low | Task in graph. Evaluate on next Ch 9 pass. |
| 10 | Meta-Harness SFV citation | Low | Deferred to SFV paper writeup. Research note filed. |

---

## Key Design Decisions

1. **OMNI-SIMPLEMEM not cited in book.** Meta-Harness covers the "harness matters" argument more cleanly. OMNI-SIMPLEMEM's prompt positioning +188% result is on one category of one benchmark — too thin for a book citation. Filed as Wintermute architecture reference only.

2. **Meta-Harness integrated into Ch 11 recursive stochasticity section, not a separate section.** The evidence (4.7 pts cross-model, 7.7 pts text classification) supports the existing argument. The 6× claim attributed to Tian et al. 2026 (source paper), not to Meta-Harness.

3. **Security appendix decision: standalone appendix.** Ch 12's Five Safes structure stays clean and complete for pipeline workflows. Agentic security material gets the depth it deserves in a dedicated appendix. Ch 12 gets one sentence pointing to it. Appendix gets its own AD-020 pass.

4. **Dual-persona stress test validated as a pipeline gate.** Ch 12's dual audience produced a 3/2/0 vs 1/4/0 asymmetry that single-persona tests cannot detect. Carry forward for any chapter with declared dual audience.

5. **Ch 12 is the best-constructed chapter in the audit series** by narrative arc (hook reconnected 3 times), Bloom scaffolding (flattest Apply plateau), and cascade integrity (5/5 confirmed). Revision scope is minimal.

---

## New Artifacts Created This Session

| File | Type | Content |
|------|------|---------|
| `cc_tasks/2026-04-05_ch11_ad020_review_pipeline.md` | CC task | Ch 11 AD-020 audit |
| `cc_tasks/2026-04-05_ch11_revision.md` | CC task | Ch 11 revision (6 parts) |
| `cc_tasks/2026-04-05_ch12_ad020_review_pipeline.md` | CC task | Ch 12 AD-020 audit |
| `cc_tasks/2026-04-05_ch12_revision.md` | CC task | Ch 12 revision (5 parts, NOT EXECUTED) |
| `docs/research_note_meta_harness_lee_2026.md` | Research note | Meta-Harness relevance assessment |
| `docs/research_note_omnisimplemem_liu_2026.md` | Research note | OMNI-SIMPLEMEM relevance assessment |

## Files Modified This Session

| File | Changes |
|------|---------|
| `book/chapter-11.md` | Full revision: stochastic tax fix, LangChain/rhetoric reframing, SWE-CI fix, vocab table, Meta-Harness passage, figure spec |
| `book/references.bib` | Added: `lee_2026_metaharness` |

## Audit Files Created This Session

| File | Content |
|------|---------|
| `audits/chapter-11_content_audit.yaml` | Ch 11 Tier 1 |
| `audits/chapter-11_perplexity_queries.md` | Ch 11 verification queries |
| `audits/chapter-11_practitioner_stress_test.yaml` | Ch 11 Tier 2a |
| `audits/chapter-11_bloom_depth_check.yaml` | Ch 11 Tier 2b |
| `audits/chapter-11_secondary_sweep.yaml` | Ch 11 Tier 3 |
| `audits/chapter-11_review_synthesis.yaml` | Ch 11 synthesis |
| `audits/chapter-11_cascade_results.yaml` | Ch 11 cascades |
| `seldon/docs/design/AD-020_calibration_009_ch11.md` | Ch 11 calibration |
| `audits/chapter-12_content_audit.yaml` | Ch 12 Tier 1 |
| `audits/chapter-12_perplexity_queries.md` | Ch 12 verification queries |
| `audits/chapter-12_practitioner_stress_test.yaml` | Ch 12 Tier 2a (dual persona) |
| `audits/chapter-12_bloom_depth_check.yaml` | Ch 12 Tier 2b |
| `audits/chapter-12_secondary_sweep.yaml` | Ch 12 Tier 3 |
| `audits/chapter-12_review_synthesis.yaml` | Ch 12 synthesis |
| `audits/chapter-12_cascade_results.yaml` | Ch 12 cascades |
| `seldon/docs/design/AD-020_calibration_010_ch12.md` | Ch 12 calibration |

---

## Nothing Modified Outside Scope

- No chapter files other than `book/chapter-11.md` edited
- `book/chapter-12.md` NOT modified (revision task not executed)
- No existing CC tasks modified
- Audit outputs written to `audits/`
- Research notes written to `docs/`
- Calibration data written to `seldon/docs/design/`
