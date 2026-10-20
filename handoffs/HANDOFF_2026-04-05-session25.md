# Handoff: Session 25 — Ch 9 AD-020 Audit, Revision, Knowledge Graph Design, Perplexity Verification

**Date:** 2026-04-05
**Session scope:** Ch 9 AD-020 calibration run 007, Ch 9 revision, knowledge graph design note, Perplexity verification (KG sources + Ch 9 citations), article evaluations (Iantosca, Lanham), chapter word count analysis
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Ch 9 AD-020 Pipeline (Calibration Run 007)

CC task written (`cc_tasks/2026-04-05_ch09_ad020_review_pipeline.md`), executed by Claude Code. Full audit outputs:

| File | Content |
|------|---------|
| `audits/chapter-09_content_audit.yaml` | Tier 1 correctness |
| `audits/chapter-09_practitioner_stress_test.yaml` | Tier 2a: 0 fully / 7 partially / 3 not answerable |
| `audits/chapter-09_bloom_depth_check.yaml` | Tier 2b: ceiling Evaluate, floor Remember |
| `audits/chapter-09_secondary_sweep.yaml` | Tier 3 blended |
| `audits/chapter-09_review_synthesis.yaml` | 8 clusters, verdict: revise_before_use |
| `audits/chapter-09_cascade_results.yaml` | 5 checks: 3 confirmed, 1 confirmed_with_issue, 1 clear |

Key findings: SFV definition truncated vs canonical baseline, five sub-dimensions absent, confabulated "Chapter 20" reference (ai4stats has 15 chapters), golden test set attributed to Ch 7 (belongs to Ch 8), 100% self-citation rate, zero figures, one reflection prompt in 2,160 words.

A pre-audit calibration analysis was also written by the desktop session to `seldon/docs/design/AD-020_calibration_007_ch09.md` before the CC task ran. The pipeline's independent findings largely confirmed the pre-audit analysis. The pipeline additionally caught: the golden test set attribution error, the SFV-to-classical-validity crosswalk table absence, and operationalization metrics from the canonical baseline.

### Ch 9 Revision

CC task written (`cc_tasks/2026-04-05_ch09_revision.md`), executed by Claude Code. Changes:

**Correctness fixes:**
- "Chapter 20" → "Chapter 15" (confabulated reference to nonexistent chapter)
- SFV definition restored to canonical baseline (full parenthetical and trailing clause)
- NIST confabulation wording tightened to match AI 600-1 actual definition
- "Personality problem" reframed as author's observation with concrete causes (thread resets, memory influences, system instruction updates, model/environment variance)
- Golden test set attribution moved from Ch 7 to Ch 8

**Structural additions:**
- Five sub-dimensions section with table (TC, SP, CF, SC, SCoh)
- SFV-to-classical-validity crosswalk table (T1→Construct, T2→Internal, T3→Statistical Conclusion, T4→Internal, T5→External)
- Two additional reflection prompts at Apply level
- "Where Prior Chapters" restructured with countermeasure table and gap identification
- Training cutoff and model selection framed explicitly as T4 case studies
- State externalization paragraph seeding Ch 10 knowledge graph treatment

**External literature added:**
- Widmer & Kubat (1996) — concept drift foundations
- Gama et al. (2014) — concept drift survey
- Simmhan et al. (2005) — provenance in scientific workflows
- All three added to `references.bib`

### Knowledge Graph Design Note

Written at `docs/design_note_knowledge_graphs_as_pipeline_state.md`. Captures the insight that Seldon's graph-based state management IS the pattern the book argues pipelines need. Threading across three chapters:

- **Ch 6:** Seed — graph vs relational as design choice for pipeline state (some state is tabular, some is graph-shaped)
- **Ch 9:** Connect — graph-based state externalization as SFV countermeasure (T1, T2, T4, T5)
- **Ch 10:** Full treatment — infrastructure, Seldon case study, Pragmatics case study, relational-to-graph path

### Perplexity Verification

**KG & state management sources** (`docs/perplexity_results_knowledge_graph_sources.md`):

| Source | Verified? |
|--------|-----------|
| Hogan et al. 2021 (Knowledge Graphs, ACM Computing Surveys) | Yes — DOI 10.1145/3447772 |
| Simmhan et al. 2005 (provenance survey) | Yes — DOI 10.1145/1084805.1084812 |
| Widmer & Kubat 1996 (concept drift) | Yes — DOI 10.1023/A:1007301508029 |
| Gama et al. 2014 (concept drift survey) | Yes |
| Groves et al. 2009 (Survey Methodology) | Yes — ISBN 978-0-470-46546-2 |
| Ji 2025 (Manus architecture post) | Partially — post exists, 100:1 ratio not confirmed in primary |
| Manus $100M ARR | Not verified (secondary sources only) |
| Meta acquisition of Manus | Partially (reported, not confirmed) |

**Ch 9 citations** (`docs/perplexity_results_ch09_citations.md`):

| Claim | Verified? | Action taken |
|-------|-----------|--------------|
| NIST AI 600-1 "confabulation" | Yes | Wording tightened in revision |
| "Personality problem" in opencensus-mcp | Not in source | Reframed as author's observation |
| ai4stats Chapter 20 SFV treatment | Wrong — book has 15 chapters | Fixed to Chapter 15 |

### Article Evaluations

Two Medium articles evaluated for book relevance:

1. **Iantosca, "Ontologies and Knowledge Graphs — The case for Technical Documentation"** — Good on what ontologies provide (explicit facts, auditability, logical consistency) but applies to documentation, not research pipelines. The core insight (deterministic graph lookups > probabilistic retrieval) matches the Pragmatics finding. Not citable (Medium post) but the underlying concept feeds into the KG design note.

2. **Lanham, "The Markdown File That Beat a $50M Vector Database"** — Clickbait title, solid analysis underneath. Convergent evolution of Manus/OpenClaw/Claude Code toward file-based memory is real signal. Useful as a counterpoint in Ch 10: files work for single-agent coding workflows, but research pipelines need typed relationships and provenance chains. Manus cache economics potentially relevant to Ch 6 throughput section if verified from primary source. Not citable (Medium post).

### Chapter Word Count Analysis

All 14 chapters measured:

| Chapter | Words |
|---------|-------|
| Ch 01 | 4,472 |
| Ch 03 | 3,938 |
| Ch 02 | 3,355 |
| Ch 05 | 3,255 |
| Ch 11 | 3,189 |
| Ch 10 | 3,146 |
| Ch 04 | 3,069 |
| Ch 06 | 2,984 |
| Ch 12 | 2,856 |
| Ch 14 | 2,667 |
| Ch 07 | 2,654 |
| Ch 13 | 2,575 |
| Ch 08 | 2,276 |
| Ch 09 | 2,162 |

Most chapters cluster 2,500–3,200. Ch 9 post-revision will be in the middle of the pack. Word count is not a standalone concern — structural completeness is what matters.

### Seldon cc_complete Bug Fix Confirmed Working

The bug fix from the parallel Seldon thread is confirmed working. The Ch 9 revision task transitioned `accepted → in_progress → completed` when `cc_complete` was called. Pre-existing orphan tasks from before the fix still need cleanup (see Outstanding Items).

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Ch 9 AD-020 audit (calibration run 007) | Done |
| Ch 9 revision (all Parts A-D) | Done |
| Knowledge graph design note | Done |
| Perplexity verification (KG sources) | Done |
| Perplexity verification (Ch 9 citations) | Done |
| Word count analysis (all 14 chapters) | Done |
| Seldon cc_complete bug fix verification | Confirmed working |

---

## Outstanding Items — Execution Queue

### Immediate (before Ch 10 AD-020):

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 1 | **Ch 6 knowledge graph seed** | HIGH | 1-2 paragraphs, graph vs relational design choice. Task in graph (c7fb788a). Blocks Ch 10. |
| 2 | **Graph task deduplication** | LOW | Items 3/5 and 4/6 in proposed tasks are duplicates. Clean up in Seldon thread. |

### Ch 10 AD-020 pipeline:

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 3 | **Ch 10 AD-020 audit** (calibration run 008) | **NEXT** | Write CC task, run pipeline |
| 4 | **Ch 10 KG full treatment** | After audit | Task in graph (5e20b17a). Execute during revision pass. |
| 5 | **Ch 10 bib entry — Hogan 2021** | With #4 | Task in graph (bfda3b09). |

### Carried forward:

| # | Item | Priority | Notes |
|---|------|----------|-------|
| 6 | Em-dash purge + `\$` escaping (foreword-Ch 2) | Medium | Session 17 leftover |
| 7 | Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| 8 | Batch figure render + insertion | Verify | Was marked completed in graph (Session 24 reconciliation) — verify PNGs exist |
| 9 | Security appendix decision gate | Low | After Ch 12 AD-020. Task in graph (1826188c). |
| 10 | arXiv:2502.01534 metadata verification | Low | Carried from Session 17 |
| 11 | Ch 9 optional Groves 2009 citation | Low | Task in graph (d9fbc94f). Evaluate on next Ch 9 pass. |
| 12 | Orphan proposed tasks (date-only descriptions) | Low | Pre-bug-fix ghost tasks. Cleanup in Seldon thread. |

---

## Key Design Decisions

1. **Knowledge graphs thread across Ch 6 → Ch 9 → Ch 10.** Ch 6 seeds the design choice (graph vs relational for state shape). Ch 9 connects graph-based state externalization to SFV countermeasures. Ch 10 provides the full practical treatment with Seldon and Pragmatics as case studies.

2. **SFV definition must be canonical.** The truncated definition was a Tier 1 correctness error in the chapter that defines the canonical framework. Restored to exact baseline wording.

3. **"Personality problem" is author's experiential observation, not a defined term.** Reframed in Ch 9 to describe the phenomenon with concrete causes rather than implying a named concept in the cited source.

4. **ai4stats Chapter 20 was a confabulated reference.** The published book has 15 chapters. SFV formal treatment is in Chapter 15. Fixed. This is a live T2 example — the LLM that drafted Ch 9 "remembered" a pre-publication draft structure.

5. **Word count is not a metric.** Chapter completeness is measured by structural components (sub-dimensions, tables, reflection prompts, external anchoring), not word count. The revision adds missing components; the count lands where it lands.

6. **Manus architecture claims require caveats.** The primary blog post by Ji (2025) is verified, but specific claims (100:1 token ratio, KV-cache economics) are not confirmed in the primary source text. If cited in Ch 6 or Ch 10, use caveats.

7. **No LLM pipeline state drift literature exists.** Perplexity found no papers extending concept drift specifically to LLM pipeline accumulated state (as opposed to model prediction drift). SFV may be the first framework addressing this. Worth noting in the book.

---

## Nothing Modified Outside Scope

- No chapter files other than `book/chapter-09.md` edited
- No existing CC tasks modified
- `book/references.bib` updated with three new entries (widmer_kubat_1996, gama_2014, simmhan_2005)
- Design note written to `docs/`
- Perplexity results written to `docs/`
- Pre-audit calibration analysis written to `seldon/docs/design/`
- Audit outputs written to `audits/`
