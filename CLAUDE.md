# CLAUDE.md — AI Workflow Design for Official Statistics

## Project Overview

An open-source book on designing reliable AI/LLM workflows for statistical research and official statistics production. Companion/sequel to *AI for Official Statistics* (ai4stats). Where ai4stats teaches federal statisticians what AI is, this book teaches builders how to design AI-powered data processing pipelines that work reliably.

**Audience:** Data scientists, statisticians, and researchers in federal statistical agencies (Census, BLS, NCHS, BEA, NASS) and similar organizations who are building — not just evaluating — AI workflows.

**Scope:** The book covers design patterns for LLM-powered data processing pipelines in official statistics environments. It emphasizes architectural discipline, evaluation infrastructure, and evidence chains over model selection. The content is practice-oriented, not theoretical.

**Repo:** `brockwebb/ai-workflow-design`
**Author:** Brock Webb
**License:** CC BY 4.0 (matching ai4stats)

## Project Structure

```
ai-workflow-design/
├── CLAUDE.md              # This file — project context for AI assistants
├── README.md              # Public-facing project description
├── book/                  # Chapter source files (markdown)
├── cc_tasks/              # Configuration-controlled task specifications
├── handoffs/              # Session handoff documents
├── assets/
│   ├── diagrams/          # Diagram source files
│   └── images/            # Rendered figures
├── docs/                  # Working documents, design notes
├── exports/               # Build outputs (PDF, combined markdown)
└── scripts/               # Build and utility scripts
```

## Chapter Outline

14 chapters. Run `seldon go` for current chapter list and structure. The chapter count and titles are tracked in the Seldon graph and in `book/myst.yml`.

## Organizing Framework

The book is structured around two paired layers that originate from Census AI program strategy work (March 2026) and are stated universally. Introduced in Chapter 1, referenced throughout.

**Compressed Tenets** (strategic — what matters):
1. Trust defines the mission
2. Data precedes models
3. Deliver capability quickly
4. Governance must enable execution
5. Humans remain accountable
6. Defensibility is required
7. Adapt continuously
8. Build internal capability
9. Experiment under control
10. Infrastructure enables delivery

**Working Principles** (practitioner — how to act):
1. If it cannot be explained, do not use it
2. Slow governance prevents delivery
3. Adoption determines impact
4. Build lineage before scale
5. Reuse data before collecting more
6. Access defines capability
7. Security is a system property
8. Outputs require full provenance

**Chapter-to-Principle Mapping:** Tracked in the Seldon graph. Run `seldon go` to see current mappings. Do not maintain a convenience copy here; it drifts.

## Chapter Pedagogical Pattern

Every chapter follows this consistent structure:

- **Opening hook:** A concrete scenario or problem that motivates the chapter's topic. Grounded, not abstract.
- **Core content:** Technical material, design patterns, principles.
- **Reflection prompts (distributed throughout):** "What could go wrong here?" / "How would you check this?" Inline, not boxed at the end. They interrupt reading at natural pause points to force active engagement.
- **Thought experiment (at least one per chapter):** A substantial scenario asking the reader to apply what they learned. Not homework; a provocation.
- **Chapter bridge:** Each chapter ends by connecting forward to what comes next and why it matters.

## Citation Conventions

- **BibTeX file:** `book/references.bib` — single source of truth for all citations.
- **Narrative (textual) citations:** `` {cite:t}`key` `` → renders as "Author et al. (Year)"
  - Example: `` {cite:t}`huang_2024` `` → Huang et al. (2024)
  - Use when the author is the grammatical subject: "Huang et al. (2024) demonstrated..."
- **Parenthetical citations:** `` {cite:p}`key` `` → renders as "(Author et al., Year)"
  - Example: `` {cite:p}`huang_2024` `` → (Huang et al., 2024)
  - Use at end of a claim: "LLMs cannot self-correct reasoning ({cite:p}`huang_2024`)."
- **Multiple citations:** `` {cite:p}`key1;key2` `` → (Author1, Year; Author2, Year)
- **Key convention:** `firstauthor_year` in lowercase with underscores.
- **Adding new citations:** Every CC task that introduces a source MUST add the BibTeX entry to `references.bib` AND use the proper `{cite:t}` or `{cite:p}` role in the chapter text.
- **No bare prose citations.** Do not write "Huang et al. (2024)" as plain text. Always use the role markup so both HTML and PDF builds resolve correctly.
- **PDF pipeline:** MyST → Pandoc → Typst. The `{cite:t}` and `{cite:p}` roles resolve through Pandoc's citeproc. The BibTeX file is the input for both build targets.

## Workflow Rules

- **Seldon-managed from day one.** All artifacts tracked. No direct file edits on tracked files — changes go through CC tasks.
- **CC tasks are immutable once written.** Corrections go in addendum files.
- **Citation verification required.** No citations from memory — verify before including.
- **Bibliography from chapter 1.** Learned from ai4stats: start the .bib file early, maintain it continuously.
- **Figures, not "artwork."**
- **File operations:** `str_replace` does not work on Brock's filesystem. Pattern: read full file → modify in memory → write full file back.
- **`github:create_or_update_file` is prohibited** on Seldon-tracked repos.
- **Shared ontology (AD-017):** SFV terminology and validity vocabulary are inherited from
  the main Seldon repo (`seldon/ontology/validity/VALIDITY_VOCABULARY.md`). This project
  does NOT maintain local copies of shared definitions. Chapter 9 references SFV; all terms
  must match the canonical vocabulary. Project-specific terms stay local until explicitly
  promoted via CC task.

## Key Source Material

- **Federal Survey Concept Mapper** (`/Users/brock/Documents/GitHub/federal-survey-concept-mapper/`) — Primary case study for ensemble/multi-model patterns. Dual-model cross-validation, confidence-based arbitration, 6,954 analyzable survey questions (~7,000 raw), 99.5% automated resolution rate, kappa = 0.839, ~$15.
- **ai4stats** (`/Users/brock/Documents/GitHub/ai4stats/`) — Predecessor book. SFV framework defined in `docs/sfv/SFV_TERMINOLOGY_BASELINE.md`.
- **AI Agents 101** (`/Users/brock/Documents/GitHub/ai-demos/ai_agents_101/`) — Design principles, failure modes, bounded agency.
- **Medium article** on AI automation hype — "adapter layer" insight.

## Build System

**MyST** (`mystmd`) — matching ai4stats.

- HTML site: `cd book && myst build --html` → `book/_build/html/`
- PDF export: Typst via `myst build --pdf` (template: `plain_typst_book`, output: `exports/ai-workflow-design.pdf`)
- GitHub Pages: `.github/workflows/deploy.yml` deploys on push to `main` (requires Pages source set to "GitHub Actions" in repo settings)
- Config: `book/myst.yml`
- License: CC BY 4.0

## Related Projects

- **ai4stats** (v1.0 published on Zenodo, DOI: 10.5281/zenodo.19206379) — predecessor, conceptual foundation
- **SFV framework** — feeds into Chapter 9
- **Seldon** — artifact tracking, used for this project's own configuration management
