# Handoff: AI Workflow Design — Session 5

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Citation Infrastructure Established

Moved from hand-maintained markdown bibliography to BibTeX-based citation system:

1. **`2026-03-29_citation_infrastructure_and_bibliography.md`** — Created `book/references.bib` (14 entries), updated `myst.yml`, replaced `bibliography.md` with `{bibliography}` directive, added citation conventions to CLAUDE.md. Convention: `{cite:t}` narrative, `{cite:p}` parenthetical, keys as `firstauthor_year`.

2. **`2026-03-29_chapter01_citation_conversion_and_new_evidence.md`** — Converted all plain-prose Ch 1 citations to MyST roles. Added DORA 2024 evidence. Replaced model collapse and METR `[NEEDS]` placeholders with verified content.

### Research Verification

1. **METR RCT — VERIFIED.** Becker, Rush, Barnes, Rein. arXiv 2507.09089, July 10, 2025. 16 developers, 246 tasks, 19% slower. Developers predicted 24% faster, post-study estimated 20% faster. Full BibTeX entry as `becker_2025`.

2. **DORA 2024 — VERIFIED.** Google Cloud, October 21, 2024. 39,000+ respondents. 75% self-reported productivity gains; per 25% AI adoption increase: 1.5% delivery speed dip, 7.2% stability drop. Observational with causal inference methods, not RCT. BibTeX entry as `dora_2024`. Caveated in text as associations, not causal claims.

3. **Model collapse at inference time analogy — ORIGINAL.** Both web search and Perplexity confirmed: no paper explicitly draws the structural analogy between training-time model collapse and inference-time self-refinement degradation. Closest match: PAG self-correction paper uses "model collapse" language operationally in an inference context but doesn't develop the formal comparison. Recommendation: frame as observation, not theoretical claim. Acknowledge mechanism difference (weight updates vs. context pollution). Text written accordingly.

### Hadoop Aside Removed from Chapter 1

**`2026-03-29_remove_hadoop_aside_chapter01.md`** — Cut "The Hadoop Aside" section. $15 vs $1,500 pipeline example and constraint-aware design content relocated as a comment to Ch 6 for later use. Eliminates one `[NEEDS]` placeholder (Hadoop fact-check).

### Chapter 12 Designed and Drafted

**`2026-03-29_chapter_12_draft.md`** — Full chapter draft spec. Organized around the Five Safes framework (Desai, Ritchie, Welpton, 2016) applied to AI/LLM workflows.

Key design decisions:
- Five Safes is the international standard (ONS, ABS, Stats NZ, Eurostat). US agencies don't use it by name but already do the things — it maps to what every agency already does with minimal mental effort.
- Each safe gets a section with prose context and a Socratic question table ("Questions to ask about your AI project/people/settings/data/outputs").
- Opening frame positions IT and security as mission partners — this framing belongs in Ch 12, not Ch 13.
- Cross-cutting section on model provenance and supply chain.
- Brief NIST alignment closing — points to AI RMF, GenAI Profile, and the crosswalk paper without reproducing them.
- Three new BibTeX entries: `desai_2016`, `nist_ai_rmf_2023`, `nist_genai_2024`.

### Chapter 13 Designed and Drafted

**`2026-03-29_chapter_13_draft.md`** — Full chapter draft spec. The chapter where compressed tenets and working principles hit institutional reality.

Key design decisions:
- Ch 12 handles security and IT partnership. Ch 13 is purely organizational/procedural/cultural.
- Compressed tenets and working principles are the diagnostic lens — each section maps to which tenet/principle institutional friction violates.
- Six sections: Authorization/Procurement Gap, Cloud Parity Gap, Governance (Enough and No More), Building Organizational Capability, Earning Trust Incrementally, The Culture Shift.
- Governance framed as incentive problem, not people problem. "The system rewards permanence" not "people resist change."
- Source material from Census AI strategy brainstorm conversation (tenets, "flow or drown," governance inversion, transience as principle) adapted for universal framing — no specific agency named.

### Chapter 14 Designed and Drafted

**`2026-03-29_chapter_14_draft.md`** — Full chapter draft spec. The spreadsheet chapter — concrete, numbers-oriented, shorter (8-12 pages).

Key design decisions:
- Every cost framed as counterfactual (compared to what?)
- Four-category cost taxonomy: inference, development, operational, opportunity
- Batch economics section (statistical workflows are naturally cost-advantaged)
- $15 vs $1,500 pipeline comparison gets full treatment here (relocated from Ch 1 Hadoop aside)
- Cost justification template for program offices (FTE language, not token language)
- Seven open questions flagged for Brock to answer (marked `[OPEN QUESTION]` in the CC task)

### Keywords and Glossary

Created `docs/keywords_and_glossary.md` — working index of key terms by chapter with glossary terms needing definitions. Extracted from Chs 1, 12, 13, 14 and the tenets/principles framework. Sparse for Chs 2-11 (not yet drafted). SFV terminology defers to canonical baseline — no local redefinition.

## CC Tasks Written This Session (6 files)

All on disk. Execution status:

1. `2026-03-29_citation_infrastructure_and_bibliography.md` — **EXECUTED**
2. `2026-03-29_chapter01_citation_conversion_and_new_evidence.md` — **EXECUTED**
3. `2026-03-29_remove_hadoop_aside_chapter01.md` — **EXECUTED**
4. `2026-03-29_chapter_12_draft.md` — **EXECUTED**
5. `2026-03-29_chapter_13_draft.md` — **EXECUTED**
6. `2026-03-29_chapter_14_draft.md` — **READY TO EXECUTE**

## Current State of the Repo

### New This Session
| File | Status |
|------|--------|
| `book/references.bib` | Created, 14+ entries |
| `docs/keywords_and_glossary.md` | Created, working index |

### Modified This Session
| File | Change |
|------|--------|
| `book/myst.yml` | Added `bibliography` key |
| `book/bibliography.md` | Replaced with `{bibliography}` directive |
| `book/chapter-01.md` | Citations converted, DORA added, model collapse analogy added, METR resolved, Hadoop aside removed |
| `book/chapter-12.md` | Full draft (Five Safes frame) |
| `book/chapter-13.md` | Full draft (tenets/principles vs institutional reality) |
| `CLAUDE.md` | Citation conventions section added |

### CC Tasks on Disk (27 files total)
Previously executed (17 — from Sessions 1-4 plus 5 from Session 4 foreword/Ch1 batch):
- All 11 from Sessions 1-3
- `2026-03-29_research_notes_infrastructure.md`
- `2026-03-29_foreword_feynman_frame.md`
- `2026-03-29_addendum_foreword_outcome_focus.md`
- `2026-03-29_chapter_01_draft.md`
- `2026-03-29_addendum_chapter_01_levels_and_maturity.md`
- `2026-03-29_addendum_chapter_01_pedagogy_and_fig_rework.md`

Executed this session (5):
- `2026-03-29_citation_infrastructure_and_bibliography.md`
- `2026-03-29_chapter01_citation_conversion_and_new_evidence.md`
- `2026-03-29_remove_hadoop_aside_chapter01.md`
- `2026-03-29_chapter_12_draft.md`
- `2026-03-29_chapter_13_draft.md`

Ready to execute (1):
- `2026-03-29_chapter_14_draft.md`

## What's Next

### Immediate
1. **Execute Ch 14 CC task** — ready on disk
2. **Review Ch 12 and Ch 13 drafts** — read, react, revision pass
3. **Answer Ch 14 open questions** — 7 items flagged, particularly the Concept Mapper manual cost counterfactual

### Short-term
4. **Review foreword and Ch 1 drafts** — from Session 4 CC tasks
5. **Render fig-01-01** — two-stage exercise (01-01a naive, 01-01b designed). PaperBanana.
6. **Enable GitHub Pages** — manual toggle in repo settings
7. **Expand keywords/glossary** as chapters 2-11 get drafted

### Chapter drafting priority
- Ch 2 (Classification & Coding) — depends on Ch 1 framing being stable
- Chs 3-11 — domain workflows and engineering patterns, in order or as inspiration strikes
- Foreword revision — after Ch 1 is reviewed and stable

### Deferred
- SFV preprint (SSRN, 8-12 pages) — not started
- Index/glossary formalization — after chapter drafts settle
- APA CSL configuration — if default MyST citation rendering doesn't match closely enough
- `lee_2025` and `pan_2024` BibTeX entries still have incomplete author lists

## Open Questions (accumulated)

- Code examples vs prose-only (carried from Session 3)
- Medium article location (carried from Session 3)
- Foreword length adjustment after draft review
- How explicitly to reference ai4stats Ch 15 in Ch 1 opening
- Whether fig-01-01 becomes two separate figures or sequential presentation
- Ch 14 open questions (7 items — see CC task)

## Verified Citations (added this session)

| Key | Full Citation | Status |
|-----|--------------|--------|
| `becker_2025` | Becker, J., Rush, N., Barnes, E., & Rein, D. (2025). Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity. arXiv:2507.09089. | Complete |
| `dora_2024` | DORA Team, Google Cloud. (2024). Accelerate State of DevOps Report 2024. | Complete |
| `shumailov_2024` | Shumailov, I., et al. (2024). AI Models Collapse When Trained on Recursively Generated Data. Nature, 631(8022), 755-759. | Complete |
| `alemohammad_2023` | Alemohammad, S., et al. (2023). Self-Consuming Generative Models Go MAD. arXiv:2307.01850. | Complete |
| `desai_2016` | Desai, T., Ritchie, F., & Welpton, R. (2016). Five Safes: Designing Data Access for Research. UWE Bristol. | Complete |
| `nist_ai_rmf_2023` | NIST. (2023). AI Risk Management Framework (AI RMF 1.0). NIST AI 100-1. | Complete |
| `nist_genai_2024` | NIST. (2024). AI RMF: Generative AI Profile. NIST AI 600-1. | Complete |

## Session Notes

- All workflow rules from previous sessions remain in effect.
- Five Safes framing for Ch 12: US agencies don't use it by name but already do the things. Use it as common vocabulary, not a new requirement. Maps to what agencies already do.
- Model collapse at inference time: original observation. Frame as observation, not formal theoretical claim. Acknowledge mechanism difference.
- DORA 2024 statistics are observational (causal inference methods), not RCT. Caveated in text.
- Ch 13 draws from Census AI strategy brainstorm but is universalized — no agency named.
- Compressed tenets and working principles are load-bearing structure for Ch 13, not decoration.
- IT/security partnership framing belongs in Ch 12 opening, not Ch 13.
