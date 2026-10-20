# Handoff: Session 26 — Ch 10 AD-020 Audit, Revision, SCORE Integration, KG Treatment, Industry Convergence

**Date:** 2026-04-05
**Session scope:** Ch 6 KG seed insertion, Ch 10 AD-020 calibration run 008, Ch 10 revision (SCORE, KG treatment, experiential reframing, DOORS fix, vocabulary fixes), SCORE Perplexity verification, industry vocabulary convergence design note, Ch 9/Ch 5 industry convergence CC task
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Ch 6 Knowledge Graph Seed

CC task written (`cc_tasks/2026-04-05_ch06_knowledge_graph_seed.md`), executed by Claude Code. One paragraph inserted between "Versioned configurations" and "Model turnover is the steady state" in the "Design for Change" section. Bold-lead style matching the section pattern. Introduces graph vs relational as a state-shape design choice. Forward-references Ch 10 only.

### Ch 10 AD-020 Pipeline (Calibration Run 008)

CC task written (`cc_tasks/2026-04-05_ch10_ad020_review_pipeline.md`), executed by Claude Code. Full audit outputs:

| File | Content |
|------|---------|
| `audits/chapter-10_content_audit.yaml` | Tier 1 correctness |
| `audits/chapter-10_practitioner_stress_test.yaml` | Tier 2a: 0 fully answerable / 10 questions |
| `audits/chapter-10_bloom_depth_check.yaml` | Tier 2b: ceiling Evaluate, best TE in book |
| `audits/chapter-10_secondary_sweep.yaml` | Tier 3 blended |
| `audits/chapter-10_review_synthesis.yaml` | 8 clusters, verdict: revise_before_use |
| `audits/chapter-10_cascade_results.yaml` | Cascade checker results |
| `audits/chapter-10_perplexity_queries.md` | 3 verification queries |
| `seldon/docs/design/AD-020_calibration_008_ch10.md` | Calibration data |

Key findings: 0/10 practitioner questions fully answerable (implementation gap), broken three-chapter forward reference cascade (Ch 6 → Ch 9 → Ch 10 KG treatment missing), zero figures, four undefined technical terms, two experiential claims framed as documented findings, DOORS historical assertions uncited, thought experiment best in book but not self-contained.

New gate introduced: **"tutorial vs. pattern" check** — for Seldon-specific sections, asks whether replacing "Seldon" with "my system" still produces useful guidance.

### Ch 10 Revision

CC task written (`cc_tasks/2026-04-05_ch10_revision.md`) with addendum (`cc_tasks/2026-04-05_ch10_revision_addendum_perplexity.md`), executed by Claude Code. Four-part revision:

**Part A — SCORE Integration:**
- SCORE project findings added to Defensibility paragraph
- Miske et al. 2026 cited: majority of papers lacked sufficient documentation, ~53% reproduced exactly
- Brodeur et al. 2026 cited: stronger data/code sharing norms → higher reproducibility
- Both added to `references.bib`

**Part B — Experiential Claims + DOORS Fix:**
- Concept Mapper provenance reconstruction reframed as author's experience
- Abandoned project claim reframed with explicit authorial voice
- DOORS framing tightened per Perplexity: "widely used in aerospace and defense, where traceability and regulatory compliance are critical"
- Bridge sentence added connecting DOORS → AI cost equation

**Part C — Knowledge Graph Treatment (new section):**
- New `## When Pipeline State Is Graph-Shaped` section added between "Graph-of-Artifacts" and "Shared Vocabulary"
- Covers: what makes state graph-shaped, Seldon as worked example (pattern-first), deterministic retrieval as graph pattern (Pragmatics), relational-to-graph migration path, practical tradeoffs
- Hogan et al. 2021 added to `references.bib`
- Resolves the broken three-chapter forward reference cascade (Ch 6 → Ch 9 → Ch 10)

**Part D — Technical Vocabulary + Scaffolding:**
- "append-only event log" defined inline
- "projection" defined inline
- "JSONL" expanded
- "CDN pattern" clarified with parenthetical
- Thought experiment made self-contained (standalone setup without Ch 9 dependency)

### SCORE Perplexity Verification

Prompt written (`docs/perplexity_verification_score_project.md`). Brock ran independently. Results captured (`docs/perplexity_results_score_project.md`).

| Paper | Key stats verified? |
|---|---|
| Miske et al. 2026 | Yes — 53% exact, ~72% approximate |
| Aczel et al. 2026 | Yes — 74% same conclusion, 2% opposite |
| Tyner et al. 2026 | Yes — 164 papers, 49.3% replication |
| Brodeur et al. 2026 | Partially — specific percentages not confirmed from snippets |

Addendum written to tighten Part A framing: Miske cited with specific numbers, Brodeur cited qualitatively only.

### Industry Vocabulary Convergence Analysis

Three YouTube video transcripts reviewed (via Wintermute/Gemini pipeline). Patterns extracted and assessed for book relevance. Design note written (`docs/design_note_industry_vocabulary_convergence.md`) capturing:

- **One-directional terminology mapping table:** Industry terms → book terms for 5 convergent patterns (agent contracts → model abstraction layer, second-look pattern → ensemble cross-validation, deterministic hardwiring → deterministic retrieval, decoupled workflow state → checkpoint + state serialization, typed streaming events → provenance chain)
- **Late-stage gate disambiguation:** SFV-native 2-sentence demolition of the industry argument for collapsing intermediate monitoring into a final gate
- **Convergent evidence sentence:** Multi-model pattern independently emerging in AI engineering from capability/safety argument while book derives it from measurement theory

CC task written (`cc_tasks/2026-04-05_ch09_ch05_industry_convergence.md`) for two insertions:
- Ch 9: Late-stage gate disambiguation paragraph (4-6 sentences)
- Ch 5: Convergent evidence sentence (1-2 sentences)

**Status: NOT EXECUTED.** Task is `proposed` in graph, not yet run by Claude Code.

### Perplexity Verification — Ch 10 Audit Queries

Results provided by Brock from the AD-020 audit queries:
- DOORS full name verified (IBM documentation confirms "Dynamic Object-Oriented Requirements System")
- Aerospace/defense adoption verified (multiple industry sources)
- "Days of reconstruction" and "abandoned project" confirmed as author's experiential observations, not documented findings — reframing applied in revision

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Ch 6 KG seed insertion | Done |
| Ch 10 AD-020 audit (calibration run 008) | Done |
| Ch 10 revision (Parts A-D) | Done |
| Ch 10 revision addendum (Perplexity SCORE results) | Done |
| SCORE Perplexity verification | Done |
| Ch 10 Perplexity verification (DOORS, experiential claims) | Done |
| Industry vocabulary convergence design note | Done |
| `references.bib` updated (miske_2026, brodeur_2026, hogan_2021) | Done |
| KG three-chapter forward reference cascade resolved (Ch 6 → Ch 9 → Ch 10) | Done |

---

## Outstanding Items — Execution Queue

### Immediate (before Ch 11 AD-020):

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 1 | **Ch 9 + Ch 5 industry convergence insertions** | HIGH | CC task written, registered, NOT executed. `cc_tasks/2026-04-05_ch09_ch05_industry_convergence.md`. Late-stage gate paragraph in Ch 9 + convergent evidence sentence in Ch 5. |
| 2 | **Graph task deduplication** | LOW | Three stale proposed tasks in graph that were completed via CC tasks but original manually-created tasks not closed: Ch 6 KG seed, Ch 10 KG treatment, Ch 10 Hogan bib entry. Plus the orphan tasks from pre-bug-fix era. |

### Ch 11 AD-020 pipeline:

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 3 | **Ch 11 AD-020 audit** (calibration run 009) | **NEXT** | Write CC task, run pipeline |
| 4 | **Ch 11 terminology mapping table** | After audit | Industry vocabulary convergence table from `docs/design_note_industry_vocabulary_convergence.md`. Integrate during revision pass. |

### Carried forward:

| # | Item | Priority | Notes |
|---|------|----------|-------|
| 5 | Em-dash purge + `\$` escaping (foreword-Ch 2) | Medium | Session 17 leftover |
| 6 | Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| 7 | Batch figure render + insertion | Verify | Was marked completed in graph (Session 24 reconciliation) — verify PNGs exist |
| 8 | Security appendix decision gate | Low | After Ch 12 AD-020. Task in graph. |
| 9 | arXiv:2502.01534 metadata verification | Low | Carried from Session 17 |
| 10 | Ch 9 optional Groves 2009 citation | Low | Task in graph. Evaluate on next Ch 9 pass. |
| 11 | Orphan proposed tasks (date-only descriptions) | Low | Pre-bug-fix ghost tasks. Cleanup in Seldon thread. |

---

## Key Design Decisions

1. **SCORE project provides empirical grounding for Ch 10's defensibility argument.** Miske et al. 2026 (76% of papers couldn't be attempted for reproduction) validates the "provenance is not optional" thesis. Brodeur et al. 2026 (better norms → better reproducibility) validates infrastructure investment. Cited in Ch 10 Defensibility paragraph only — not spread across chapters.

2. **Industry vocabulary mapping is one-directional.** "If you encounter X in the wild, the concept this book teaches as Y is the same design insight." Reader goes from their vocabulary to the book's. The book's terminology is authoritative, not accommodating. Table targets Ch 11 (orchestration), where the reader encounters industry tooling.

3. **Late-stage gate argument explicitly defeated using SFV.** The 2-sentence demolition: the instrument changes during use; a final gate evaluates the output of whatever instrument existed at the end, but cannot assess whether it was the same instrument throughout. Native to the book's own framework. Targets Ch 9.

4. **"Tutorial vs. pattern" check is a new gate for infrastructure chapters.** Every Seldon-specific detail in Ch 10's KG treatment section is preceded by or follows the transferable pattern. "This system does X. The pattern is Y. Your system needs Y regardless of implementation."

5. **Experiential claims get explicit authorial voice.** "In the author's experience" framing for the Concept Mapper reconstruction difficulty and the abandoned project. Not attributed to cited papers.

6. **SCORE citation scope is deliberately narrow.** Only Miske (reproducibility) and Brodeur (improvement with norms) cited in Ch 10. Aczel (analytical robustness) and Tyner (replicability) belong in Ch 8/Ch 9 if used at all. Not added in this session.

7. **Brodeur percentages cited qualitatively only.** Perplexity could not confirm exact figures from article snippets. Framed as "substantially higher reproducibility rates" rather than specific numbers.

---

## New Artifacts Created This Session

| File | Type | Content |
|------|------|---------|
| `cc_tasks/2026-04-05_ch06_knowledge_graph_seed.md` | CC task | Ch 6 KG seed insertion |
| `cc_tasks/2026-04-05_ch10_ad020_review_pipeline.md` | CC task | Ch 10 AD-020 audit |
| `cc_tasks/2026-04-05_ch10_revision.md` | CC task | Ch 10 revision (4 parts) |
| `cc_tasks/2026-04-05_ch10_revision_addendum_perplexity.md` | CC task addendum | SCORE Perplexity results for Part A |
| `cc_tasks/2026-04-05_ch09_ch05_industry_convergence.md` | CC task | Ch 9 + Ch 5 insertions (NOT EXECUTED) |
| `docs/design_note_industry_vocabulary_convergence.md` | Design note | Terminology mapping table + late-stage gate analysis |
| `docs/perplexity_verification_score_project.md` | Perplexity prompt | SCORE citation verification queries |
| `docs/perplexity_results_score_project.md` | Perplexity results | SCORE verification outcomes |

## Files Modified This Session

| File | Changes |
|------|---------|
| `book/chapter-06.md` | KG seed paragraph inserted |
| `book/chapter-10.md` | Full revision: SCORE, KG section, DOORS, vocabulary, experiential reframing, thought experiment |
| `book/references.bib` | Added: miske_2026, brodeur_2026, hogan_2021 |

---

## Nothing Modified Outside Scope

- No chapter files other than `book/chapter-06.md` and `book/chapter-10.md` edited
- No existing CC tasks modified (addendum written separately)
- `book/chapter-05.md` and `book/chapter-09.md` NOT modified (industry convergence task not executed)
- Audit outputs written to `audits/`
- Design notes written to `docs/`
- Perplexity results written to `docs/`
- Calibration data written to `seldon/docs/design/`
