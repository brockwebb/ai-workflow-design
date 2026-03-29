# Handoff: AI Workflow Design — Session 1

**Date:** 2026-03-28
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened

### Project Created
- Title locked: **AI Workflow Design for Official Statistics**
- Repo directory created at `/Users/brock/Documents/GitHub/ai-workflow-design/`
- "Introduction to" prefix rejected — version/edition strategy instead
- Book is short, open-source, living document — add chapters as new case studies emerge

### CC Tasks Written (4 files)

1. **`2026-03-27_project_initialization.md`** — EXECUTED
   - Git init, GitHub repo (private), Seldon init, shared ontology (AD-017)
   - CLAUDE.md, README.md, chapter placeholders, bibliography.md
   - seldon.yaml with shared_ontology section

2. **`2026-03-28_addendum_12_chapter_structure.md`** — EXECUTED
   - Expanded from 10 to 12 chapters
   - Added: Ch 10 (State Management & Provenance), Ch 11 (Operating in the Real World)
   - Old Ch 10 (Cost) moved to Ch 12

3. **`2026-03-28_addendum_principles_and_tenets.md`** — EXECUTED
   - Working principles (8 items) and compressed tenets (10 items) integrated
   - Chapter-to-principle mapping table
   - Principles woven through chapters, not a standalone manifesto chapter

4. **`2026-03-28_addendum_brainstorm_material.md`** — NEEDS EXECUTION
   - 12 pieces of book-worthy material from brainstorming, assigned to chapters
   - Includes: dark factory maturity model, CRC/SFV analogy, HuggingFace callback story, schema harmonization pattern, cloud parity gap, operational friction, and more

### Files That Exist (written directly before CC task discipline was enforced)

These were created before the init CC task was written. They are tracked by Seldon now:
- `CLAUDE.md` — project context
- `README.md` — public-facing description
- `book/chapter-01.md` — first chapter placeholder

### Key Decisions

- **12 chapters** (not 10, not 13 — security/supply chain folded into "Operating in the Real World" chapter)
- **No separate principles chapter** — tenets and working principles live in Ch 1 and throughout
- **Seldon-managed from day one** — shared ontology inherited per AD-017
- **No specific companies/firms/providers named** — all examples framed generically
- **Audience is builders** — self-selects away from deliberation-focused readers
- **Version strategy over "Introduction to"** — preface states currency, plans for editions

## Chapter Outline (Final, 12 Chapters)

1. Why Design Matters (workflow decomposition as THE skill, maturity model, market gap)
2. Classification & Coding Workflows (concept mapper case study)
3. Data Cleaning & Imputation Workflows
4. Detection & Extraction Workflows
5. The Ensemble & Multi-Model Playbook (ABBA, judge loops, agreement scoring)
6. Parallel, Serial, and the Bottleneck
7. Checkpoints, Failures, and Recovery
8. Evaluation by Design (humans are unreliable too, unit tests as TEVV, bad abstraction)
9. State, Drift, and Validity (SFV, CRC analogy)
10. State Management & Research Provenance (Seldon case study, foreshadow SFV paper)
11. Operating in the Real World (security, supply chain, model provenance, cloud parity, institutional friction, IT as partner)
12. Cost & Practicality

## What's Next

1. **Execute the brainstorm material addendum** — Claude Code picks up the fourth CC task
2. **Start writing Chapter 1** — has the most material queued up (maturity model, principles, workflow decomposition thesis, "building tooling is the research investment")
3. **Gather source material** — pull from concept mapper repo, ai4stats, AI Agents 101, Medium article
4. **Decide on build system** — Jupyter Book or Quarto, prototype with Ch 1 before committing

## Source Material Inventory

| Source | Location | Relevant Chapters |
|--------|----------|-------------------|
| Federal Survey Concept Mapper | `/Users/brock/Documents/GitHub/federal-survey-concept-mapper/` | 2, 5, 6, 8 |
| ai4stats (SFV framework) | `/Users/brock/Documents/GitHub/ai4stats/docs/sfv/` | 9, 10 |
| AI Agents 101 | `/Users/brock/Documents/GitHub/ai-demos/ai_agents_101/` | 1, 5, 7 |
| Seldon | `/Users/brock/Documents/GitHub/seldon/` | 10 |
| Shared validity ontology | `/Users/brock/Documents/GitHub/seldon/ontology/validity/` | 9, 10 |
| Census AI tenets (docs in this session) | Captured in addendum | 1 |
| Medium article (AI automation hype) | Published on Medium | 1, 6 |
| Imputation conversations | Past chat history | 3 |

## Open Questions

- Build system decision deferred (Jupyter Book vs Quarto vs something else)
- License not finalized (likely CC BY 4.0)
- Whether to include code examples or keep prose-only (ai4stats was prose-first, this book may need more code)
- Medium article — need to locate and potentially reference or adapt content
