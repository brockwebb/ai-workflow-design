# Handoff: AD-020 Chapter 4 Review + Pipeline Calibration

**Date:** 2026-04-03
**Session scope:** AD-020 multi-lens review pipeline calibration run 002 (Chapter 4), claim verification, revision task authoring
**Projects touched:** ai-workflow-design (primary), seldon (calibration data, design notes)

---

## What Was Done

### AD-020 Pipeline Run on Chapter 4
- CC task written: `cc_tasks/2026-04-02_ch04_ad020_review_pipeline.md`
- Pipeline executed by Claude Code (~11 min). All 7 output files in `audits/`:
  - `chapter-04_content_audit.yaml` (Tier 1)
  - `chapter-04_perplexity_queries.md` (Tier 1)
  - `chapter-04_practitioner_stress_test.yaml` (Tier 2a)
  - `chapter-04_bloom_depth_check.yaml` (Tier 2b)
  - `chapter-04_secondary_sweep.yaml` (Tier 3)
  - `chapter-04_review_synthesis.yaml` (Synthesis)
  - `chapter-04_cascade_results.yaml` (Cascade)
- Calibration data written: `seldon/docs/design/AD-020_calibration_002_ch04.md`

### Pipeline Results Summary
- 8 clusters, 0 unclustered, 0 false positives
- Top 3 by convergence:
  1. **Implementation Guidance Gap** (conv: 4) — 0/9 practitioner questions fully answerable. Chapter tells what to build, not how.
  2. **Visual Representation Absent** (conv: 3) — Zero figures in a pipeline architecture chapter.
  3. **Citation Density Below Claim Density** (conv: 2) — 2 citations for 48 assertions.
- Bloom: Non-monotonic. Thought experiment (Create) buried mid-chapter; synthesis section drops to Apply.
- Cascade: 2 confirmed. SFV sub-dimensions (CF, TC, SP) used in Ch 4 but never defined in Ch 9. ABBA cross-reference to Ch 5 slightly imprecise.

### Author Review + Claim Verification
Three claims deep-dived via web search + Perplexity:

1. **Absolute vs. comparative judgment:** Chapter's blanket claim ("LLMs are poorly calibrated for absolute judgments" / "Comparative judgments are more reliable") is **wrong**. Tripathi et al. (2025, arXiv:2504.14716) found pairwise is MORE vulnerable to distractor features (35% flip rate vs 9% for absolute). Both methods have failure modes; choice depends on task design. Author's own pragmatics lab notes independently found the same verbosity/confidence bias in pairwise mode.

2. **NotebookLM mind maps ≠ knowledge graphs:** Confirmed. Google calls them "Mind Maps." Hierarchical concept extraction, no ontology, no typed relations, no queryable substrate. The distinction is well-established in the literature (mind map = tree, knowledge graph = typed entity-relation graph with schema).

3. **Model performance variation in extraction:** Strongly supported. PMC study of 18 LLMs found accuracy from 0.995 to below baseline. McGregor found 4B parameter inflection point. Embedding model interactions can break otherwise-performing models.

### CC Tasks Written
- `cc_tasks/2026-04-03_ch04_revision.md` — 13 revision instructions with evidence package (E1-E4), BibTeX entries, sequencing notes, verification checklist. Covers: restructure around confidence laundering, fix absolute/comparative claim, add model-matters principle, add concept-map-vs-knowledge-graph example, entity resolution techniques, cost profile, Bloom fix, SFV forward reference, sdcMicro→Ch12 forward reference, Bradley-Terry explanation, figures, citations, ABBA cross-reference fix.
- `cc_tasks/2026-04-03_ch04_revision_addendum_A.md` — Two addenda: (A) extraction tool adoption evaluation heuristic (5 questions teaching how-to-think, not what-to-think), (B) "confidence laundering" confirmed as novel terminology (not in existing literature; closest terms are AI-washing, automation bias, epistemic opacity — all adjacent but distinct). Term to be explicitly defined in chapter and added to glossary.

### Key Design Insight: "What to Think" vs "How to Think"
Author identified that Ch 4's weakness is teaching *what to think* (here are cool things, here's why they're cool) instead of *how to think* (here's how to evaluate any extraction tool, here's how to reason about these tradeoffs). The evaluation heuristic in Addendum A addresses this for tool adoption. The restructure around confidence laundering addresses it for the chapter's organizing concept. But this is a broader pedagogical concern:

**The AD-020 pipeline's Bloom gate detects the symptom (section stops at Apply) but doesn't diagnose the cause (the section teaches knowledge instead of judgment).** A "Feynman pedagogy" lens — does the chapter develop the reader's ability to reason about the domain independently? — would catch this more precisely. See open question below.

---

## Open Questions for Next Session

1. **Feynman pedagogy gate for AD-020:** Should the pipeline get a dedicated gate (or a Bloom gate enhancement) that checks whether a chapter teaches *how to think* about a domain vs. merely presenting information about it? The Bloom gate catches sections that stop at Apply. But it doesn't distinguish "stops at Apply because the section is a reference table" (acceptable) from "stops at Apply because the section lectures instead of developing judgment" (a pedagogical failure). This might be a Tier 2 gate addition, or it might be a calibration of the existing Bloom gate with Feynman-specific criteria. Design note needed in Seldon.

2. **Perplexity queries for Ch 4:** The audit generated `audits/chapter-04_perplexity_queries.md` — these haven't been run yet. Remaining citation gaps: "LLMs are excellent at extraction and poor at citation," "knowledge graph hype cycle," Bradley-Terry (1952) standard reference. Should run before or during the revision CC task execution.

3. **Ch 4 revision execution:** The CC task + addendum are ready. Executor needs `references.bib` and the evidence package. Sequencing: restructure first → content additions → figures → citations.

4. **Next chapter for AD-020:** The calibration plan calls for testing on more chapters to stabilize the `book_chapter` gate profile. Ch 4 was thin (97 lines). A more developed chapter would test whether the gates correctly identify completeness as well as gaps.

---

## Artifacts Created This Session

| File | Location | Type |
|------|----------|------|
| AD-020 review CC task | `ai-workflow-design/cc_tasks/2026-04-02_ch04_ad020_review_pipeline.md` | CC task |
| Ch 4 revision CC task | `ai-workflow-design/cc_tasks/2026-04-03_ch04_revision.md` | CC task |
| Ch 4 revision addendum A | `ai-workflow-design/cc_tasks/2026-04-03_ch04_revision_addendum_A.md` | CC task addendum |
| AD-020 calibration 002 | `seldon/docs/design/AD-020_calibration_002_ch04.md` | Calibration data |
| 7 audit output files | `ai-workflow-design/audits/chapter-04_*` | Audit artifacts |

---

## Nothing Modified

- No chapter files edited
- No existing CC tasks modified (addendum written as separate file per immutability rule)
- No Seldon code changes
