# Handoff: AI Workflow Design — Session 6

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Chapter 14 CC Task Executed

`2026-03-29_chapter_14_draft.md` — executed by Brock at start of session. Ch 14 is now drafted.

### Chapter 2 Designed and CC Task Written

Full design session for Ch 2 (Classification & Coding Workflows). Anchored on the Federal Survey Concept Mapper as primary case study.

**Source material reviewed:**
- `FedSurveyHarmonization.pdf` — the published paper (distillation of 3 archived reports)
- `federal-survey-concept-mapper/docs/project/pipeline_documentation.md` — full technical architecture with decision rationale
- `federal-survey-concept-mapper/docs/project/lessons_learned_embedding_failure.md` — RoBERTa failed, pivoted to LLMs
- `federal-survey-concept-mapper/docs/project/STRATEGIC_REFRAME_enrichment_over_consolidation.md` — consolidation → enrichment pivot
- Two Medium articles by Brock: "Machine-Readable to Machine-Interpretable" and "Breaking Free from the AI Echo Chamber with Multi-Model Workflows"
- Concept Mapper repo tree scan (50+ CC tasks, 3 archived reports, slide decks, handoff history)

**Key intellectual content established for Ch 2:**
- LLMs as independently trained neural networks — inter-rater reliability methods apply directly (transfer of existing statistical methodology, not novel invention)
- "Try the cheap thing first" — RoBERTa embedding failure as worked example of good engineering judgment
- Disagreement is signal, not noise — dual-model cross-validation surfaces ambiguity that single-model silently hides
- Adopt existing domain frameworks (DataSHaPER, Wolf et al.) as structured output schemas rather than inventing your own
- Model transience as design constraint (golden questions, model-agnostic pipeline design, version pinning with expiration)
- Provenance reconstruction nightmare as motivation for building traceability from day one
- The $15 API cost is real; the human engineering cost dwarfs it — be honest about both
- Multi-model as the baseline, not the advanced technique — single-model is what needs justification

**CC task:** `2026-03-29_chapter_02_draft.md` — **EXECUTED**

### Bone Drop Design Notes Written

Four design notes capturing session conversation material for future chapters. These were initially written to `cc_tasks/` in error (protocol violation — design notes belong in `docs/`).

**Status:** Brock moved them to `docs/`. A CC task (`2026-03-29_register_bone_drop_design_notes.md`) was written to register them as Seldon artifacts.

| File (in docs/) | Target Chapter | Core Idea |
|-----------------|---------------|-----------|
| `bone_drop_ch06_parallelization.md` | Ch 6 | Parallel workers, rate limiting, checkpoint/resume, infrastructure reinvention tax |
| `bone_drop_ch13_shadow_it.md` | Ch 13 | Shadow IT as governance failure, access gap degrading competence, public data ≠ shadow IT |
| `bone_drop_ch07_ch11_ai_partner_stochasticity.md` | Ch 7 & 11 | Recursive stochasticity — building LLM pipelines with LLM tools, Seldon/CC-task as answer |
| `bone_drop_ch10_seldon_origin.md` | Ch 10 | Seldon origin story, provenance as pain relief, reference librarian tax, Level 2 → Level 3+ |

**CC task:** `2026-03-29_register_bone_drop_design_notes.md` — **EXECUTED**

### Key Design Decisions and Principles Captured

From extended conversation:

1. **Public data competence building is not shadow IT.** Brock built all early LLM pipeline experience using public data on personal hardware with personal API keys. No agency data involved. When artifacts entered the agency perimeter, they entered as a black hole — customized from within, never exfiltrated. This distinction must be maintained in the book.

2. **The Concept Mapper is both a success story and a cautionary tale.** The results held up ($15, κ = 0.843). The provenance reconstruction was brutal (days). The DAG project was worse — burned to the ground. These experiences directly motivated Seldon.

3. **Institutional friction examples are universalized.** No specific agency or individual named. Bikeshedding example (HTML vs PDF extraction debate) framed as universal pattern of what happens when teams lack hands-on access.

4. **The "evaluation trap" lived.** Brock's guidance to a chatbot team: build golden questions, run weekly regression, catch drift early. They fought him on it and never did it. This becomes a universalized design principle, not an anecdote about specific people.

5. **The strategic reframe (consolidation → enrichment)** from the Concept Mapper is noted but kept out of Ch 2. It's about interpreting results, not about designing classification pipelines. May surface in Ch 5 or later.

## CC Tasks Written This Session (3 files)

1. `2026-03-29_chapter_02_draft.md` — **EXECUTED**
2. `2026-03-29_register_bone_drop_design_notes.md` — **EXECUTED**
3. `docs/bone_drop_ch06_parallelization.md` (not a CC task — design note, moved to docs/)
4. `docs/bone_drop_ch13_shadow_it.md` (not a CC task — design note, moved to docs/)
5. `docs/bone_drop_ch07_ch11_ai_partner_stochasticity.md` (not a CC task — design note, moved to docs/)
6. `docs/bone_drop_ch10_seldon_origin.md` (not a CC task — design note, moved to docs/)

Also: `docs/bone_drop_ch06_parallelization.md` was partially duplicated to `docs/` during an aborted file move — Brock confirmed cleanup.

## Current State of the Repo

### Chapters Drafted
| Chapter | Status |
|---------|--------|
| Foreword | Drafted (Session 4) |
| Ch 1: Why Design Matters | Drafted, citations converted (Sessions 4-5) |
| Ch 2: Classification & Coding | Drafted (Session 6) |
| Ch 12: Security & Supply Chain | Drafted (Session 5) |
| Ch 13: Institutional Deployment | Drafted (Session 5) |
| Ch 14: Cost & Practicality | Drafted (Session 6) |

### Chapters Not Yet Drafted
Chs 3–11 (placeholder content only). Design notes now exist in `docs/` for Chs 6, 7, 10, 11, 13.

### CC Tasks on Disk
Previously executed (all from Sessions 1-5): 22 files
Executed this session: 3 files (Ch 2 draft, Ch 14 draft, bone drop registration)
**Total executed: 25**

## What's Next

### Immediate
1. **Review Ch 2 draft** — read, react, revision pass
2. **Review Ch 12 and Ch 13 drafts** — from Session 5, not yet reviewed
3. **Review foreword and Ch 1 drafts** — from Session 4, not yet reviewed
4. **Answer Ch 14 open questions** — 7 items flagged in the CC task

### Chapter Drafting Priority
- Ch 5 (Ensemble & Multi-Model Playbook) — high readiness, benefits from Ch 2 being drafted as concrete referent
- Ch 6 (Parallel, Serial, Bottleneck) — design notes now in `docs/`, $15 vs $1,500 engineering story
- Ch 3 (Data Cleaning & Imputation) — next domain workflow after classification
- Ch 9 (State, Drift, Validity) — SFV chapter, benefits from more domain chapters existing first

### Deferred
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Remaining open questions from Sessions 3-5

## New Citations Added (Session 6, in Ch 2 CC task)

| Key | Full Citation | Status |
|-----|--------------|--------|
| `webb_2026_concept_mapper` | Webb, B. (2026). AI-Assisted Federal Survey Harmonization. Draft working paper. | To be added by CC task |
| `fortier_2011` | Fortier, I., et al. (2011). DataSHaPER across 53 large studies. IJE, 40(5). | To be added by CC task |
| `fortier_2017` | Fortier, I., et al. (2017). Maelstrom Research guidelines. IJE, 46(1). | To be added by CC task |
| `wolf_2016` | Wolf, C., et al. (2016). Harmonizing survey questions. SAGE Handbook. | To be added by CC task |
| `dell_acqua_2023` | Dell'Acqua, F., et al. (2023). Navigating the Jagged Technological Frontier. HBS WP 24-013. | Optional, for echo chamber point |

## Session Notes

- Protocol violation caught and corrected: design notes initially written to `cc_tasks/` instead of `docs/`. Fixed by moving files and writing a registration CC task.
- The Concept Mapper repo contains extensive source material beyond the published paper: 3 archived reports, methodology docs, pipeline documentation, lessons learned, 50+ CC tasks, slide decks. All available for future chapter drafting.
- Brock's voice-to-text was active throughout — watch for phonetic substitutions in conversation transcripts.
- All workflow rules from previous sessions remain in effect.
