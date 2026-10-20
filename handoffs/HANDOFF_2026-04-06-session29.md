# Handoff: Session 29 — Ch 14 AD-020 + Revision, CLAUDE.md Cleanup, Design Notes

**Date:** 2026-04-06
**Session scope:** Ch 14 AD-020 calibration run 012, Ch 14 Perplexity verification (PQ1-PQ6, author-provided), Ch 14 revision (10 parts), CLAUDE.md cleanup, GPU checkpoint research (held), appendix-principles framing design note, back matter TOC reorder noted
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Ch 14 AD-020 Pipeline (Calibration Run 012)

CC task written (`cc_tasks/2026-04-06_ch14_ad020_review_pipeline.md`), registered (`b331a2a7`), executed by Claude Code. Verdict: `conditionally_ready`. 5 clusters, 1 broken cascade.

New gates introduced:
- **Single example dependency check** — Concept Mapper is batch classification (cost-advantaged); chapter didn't acknowledge scope limitation
- **Redundancy check** — first explicit redundancy gate; caught $15/development cost stated twice
- **Capstone coherence check** — found broken attribution (CA9): capstone quotes CLAUDE.md thesis as Ch 1's opening
- **Template utility check** — template missing Year 1/Year 2+ distinction (the chapter's core cost insight)

Dual persona test:
| Persona | Fully | Partial | Not |
|---|---|---|---|
| A (Practitioner) | 5 | 0 | 0 |
| B (Budget Authority) | 3 | 2 | 0 |

Key findings:
- **C1 (convergence 4):** CA9 broken — capstone attributes "distributed systems" thesis to Ch 1's opening. Text matches CLAUDE.md, not Ch 1. Ch 1 opens with stochastic systems framing.
- **C2 (convergence 3):** Token pricing ratios (10-30x, 50-100x) unhedged and undated. PQ1 data shows 50-100x upper bound too high for some providers.
- **C3 (convergence 3):** Single-example dependency — entire economic argument rests on Concept Mapper (batch classification). No scope acknowledgment for other workflow types.
- **C4 (convergence 2):** Template missing Year 1 vs. Year 2+ rows.
- **C5 (convergence 2):** 30 questions/hour analyst rate — linchpin of $24K manual cost calculation, stated without grounding.

Perplexity verification completed for PQ1-PQ6 (author-provided from external Perplexity session):
- PQ1: Pricing ratios confirmed but need tightening. Actual range is 5x (Anthropic) to 40x (Google). "50-100x" too high; revised to "20-100x".
- PQ2: 30 questions/hour defensible as planning estimate, not citable as empirical fact. AAPOR/Pew support "few dozen per hour" for analogous coding work.
- PQ3: $100/hour confirmed. GS-12 DC locality ~$55/hr base × 1.7-2.0 multiplier = $90-110.
- PQ4: Batch API discounts confirmed. Anthropic and OpenAI both offer ~50% for async batch processing.
- PQ5: FTE reallocation framing confirmed. PMA Cross-Agency Priority goals explicitly frame as "shifting away from low-value work."
- PQ6: Designed vs. undesigned cost multiplier directionally supported by engineering blogs but no rigorous academic source.

### Ch 14 Revision

CC task written (`cc_tasks/2026-04-06_ch14_revision.md`), registered (`f6dd52db`), executed by Claude Code. Ten parts:

| Part | Content |
|------|---------|
| A | Capstone rewrite: forward-looking close. Dropped Ch 1 callback, dropped CLAUDE.md thesis sentence. Final line: "Design for that. The rest adapts around it." |
| B | Token pricing ratios: widened 50-100x → 20-100x, added "as of early 2026" hedge, added declining prices note |
| C | Single-example scope: batch classification caveat added, notes generative/retrieval/agentic differ |
| D | Template: added Year 1 total, Year 2+ per cycle, operational cost, break-even point rows |
| E | Analyst rate: reframed as planning estimate, added validation prompt for reader's own data |
| F | Labor rate: added parenthetical GS-12 DC locality grounding |
| G | Redundancy: removed duplicate $15/development cost paragraph from worked example section |
| H | Reflection prompt: added to Cost Taxonomy section |
| I | PaperBanana method file: `assets/diagrams/paperbanana/ch14_cost_trajectory.md` |
| J | CLAUDE.md cleanup: "Thesis" → "Scope" (neutral project description), removed "Feynman pedagogy operationalized" label |

### Author Decisions

1. **CA9 fix: forward-looking close, no arc closure.** Drop the Ch 1 callback entirely. No epilogue. The book's ending should look forward (what's durable: evidence chains, defensibility, human accountability; what's uncertain: everything else) rather than backward to a "thesis" that was never in the book.

2. **CLAUDE.md is not a source of quotable book text.** The "thesis" line was a project description written before Ch 1 was drafted. CC sessions treated it as canonical. Fixed at the source (CLAUDE.md) and downstream (Ch 14 capstone).

3. **No citations added to Ch 14.** The Perplexity results support hedging and reframing, not citation insertion. Ch 14's voice is practitioner-experiential, not academic.

### GPU Checkpoint Research (HELD)

LinkedIn post (Meg McNulty) about GPU failure costs ($307K/month in a 1024-GPU cluster) traced to source: Meta paper "Revisiting Reliability in Large-Scale Machine Learning Research Clusters" (arXiv:2410.21680). MTTF for 1024-GPU jobs is 7.9 hours. $307K figure derived by Clockwork.io's TorchPass blog applying Meta's MTTF data to cost model.

Relevant to Ch 7 (checkpoint design) and Ch 14 (cost of not designing). **Not filed as research note yet** — held for author decision on whether to incorporate. The Meta paper is the citable source if used.

### Appendix-Principles Framing Design Note

Filed: `docs/2026-04-06_appendix_principles_framing.md`. Captures author insight about the book's intended reader (interdisciplinary thinkers who design systems, not extreme-precision specialists who need exhaustive certainty before acting). Core framing: "I insert myself where I provide value, and when things break, I can trace it back and understand the failure." Not "I ship code I don't read."

Also notes back matter TOC reorder needed: bibliography should come before glossary, not after index.

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Ch 14 AD-020 audit (calibration run 012) | Done |
| Ch 14 Perplexity verification (PQ1-PQ6) | Done |
| Ch 14 revision (Parts A-J) | Done |
| CLAUDE.md cleanup (thesis→scope, Feynman label removed) | Done |
| PaperBanana method file (ch14_cost_trajectory.md) | Done |
| Appendix-principles framing design note | Filed |

---

## Outstanding Items — Execution Queue

### Next session:

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 1 | **Security appendix AD-020 audit** | **NEXT** | `book/appendix-security.md` (~1,800 words, 5 citations). Write CC task, run pipeline. Shorter than chapters — audit + revision in one session. |
| 2 | **Security appendix revision** | **NEXT** | Write based on AD-020 findings. Same session as audit. |
| 3 | **Appendix-principles revision** | NEXT (if runway) | Add framing paragraph (design note filed), TOC reorder (bibliography before glossary). Design note: `docs/2026-04-06_appendix_principles_framing.md` |

### Carried forward:

| # | Item | Priority | Notes |
|---|------|----------|-------|
| 4 | Back matter TOC reorder | Medium | `bibliography.md` before `glossary.md` before `index.md`. One-line swap in myst.yml. Include in appendix revision CC task. |
| 5 | Em-dash purge + `\$` escaping (foreword-Ch 2) | Medium | Session 17 leftover |
| 6 | Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| 7 | Batch figure render + insertion | Verify | PaperBanana method files now include ch13_governance_models.md and ch14_cost_trajectory.md. Verify which have been rendered. |
| 8 | GPU checkpoint research (Meta arXiv:2410.21680) | Low | Held — not filed as research note. Relevant to Ch 7 and Ch 14. Author decision on incorporation. |
| 9 | arXiv:2502.01534 metadata verification | Low | Carried from Session 17 |
| 10 | Ch 9 optional Groves 2009 citation (`d9fbc94f`) | Low | Only remaining proposed task in graph. |
| 11 | Meta-Harness SFV citation | Low | Deferred to SFV paper writeup. |

---

## AD-020 Pipeline Progress

| Run | Chapter | Type | Verdict | Key Finding |
|-----|---------|------|---------|-------------|
| 002 | Ch 4 | domain | conditionally_ready | — |
| 003 | Ch 5 | pattern | conditionally_ready | — |
| 004 | Ch 6 | eng/construction | conditionally_ready | — |
| 005 | Ch 7 | eng/defensive | conditionally_ready | — |
| 006 | Ch 8 | methodology/framework | conditionally_ready | — |
| 007 | Ch 9 | theoretical framework | conditionally_ready | — |
| 008 | Ch 10 | infrastructure guide | conditionally_ready | no MVP sequence |
| 009 | Ch 11 | evaluation/landscape | conditionally_ready | stochastic tax attribution |
| 010 | Ch 12 | governance/security | conditionally_ready | agentic security gap |
| 011 | Ch 13 | institutional deployment | conditionally_ready | zero citations + Feynman broken cascade |
| **012** | **Ch 14** | **economics** | **conditionally_ready** | **capstone misattribution (CLAUDE.md thesis ≠ Ch 1 opening)** |

**All 11 numbered chapter AD-020 runs complete (Ch 4-14).** Remaining: security appendix, then Chs 1-3 + foreword.

---

## New Artifacts Created This Session

| File | Type | Content |
|------|------|---------|
| `cc_tasks/2026-04-06_ch14_ad020_review_pipeline.md` | CC task | Ch 14 AD-020 audit |
| `cc_tasks/2026-04-06_ch14_revision.md` | CC task | Ch 14 revision (10 parts) |
| `docs/2026-04-06_appendix_principles_framing.md` | Design note | Appendix framing paragraph + back matter TOC reorder |
| `assets/diagrams/paperbanana/ch14_cost_trajectory.md` | PaperBanana method | Cost trajectory comparison figure |

## Files Modified This Session

| File | Changes |
|------|---------|
| `book/chapter-14.md` | Full revision: capstone rewrite, pricing hedge, scope caveat, template enhancement, rate reframing, redundancy removal, reflection prompt |
| `CLAUDE.md` | Thesis → Scope, Feynman label removed |

## Audit Files Created This Session

| File | Content |
|------|---------|
| `audits/chapter-14_content_audit.yaml` | Ch 14 Tier 1 |
| `audits/chapter-14_perplexity_queries.md` | Ch 14 verification queries |
| `audits/chapter-14_practitioner_stress_test.yaml` | Ch 14 Tier 2a (dual persona) |
| `audits/chapter-14_bloom_depth_check.yaml` | Ch 14 Tier 2b |
| `audits/chapter-14_secondary_sweep.yaml` | Ch 14 Tier 3 |
| `audits/chapter-14_review_synthesis.yaml` | Ch 14 synthesis |
| `audits/chapter-14_cascade_results.yaml` | Ch 14 cascades |
| `seldon/docs/design/AD-020_calibration_012_ch14.md` | Ch 14 calibration (includes series summary) |

---

## Nothing Modified Outside Scope

- No chapter files other than `book/chapter-14.md` edited
- `CLAUDE.md` modified (scoped cleanup — thesis→scope, Feynman label)
- No other chapter files touched
- No existing CC tasks modified
- Audit outputs written to `audits/`
- Calibration data written to `seldon/docs/design/`
