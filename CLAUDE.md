# CLAUDE.md — AI Workflow Design for Official Statistics

## Project Overview

An open-source book on designing reliable AI/LLM workflows for statistical research and official statistics production. Companion/sequel to *AI for Official Statistics* (ai4stats). Where ai4stats teaches federal statisticians what AI is, this book teaches builders how to design AI-powered data processing pipelines that work reliably.

**Audience:** Data scientists, statisticians, and researchers in federal statistical agencies (Census, BLS, NCHS, BEA, NASS) and similar organizations who are building — not just evaluating — AI workflows.

**Thesis:** LLM-powered research workflows require the same architectural discipline that distributed systems have always required. The design patterns matter more than the model choice. Most people building these systems are learning by trial and error; this book codifies the patterns.

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

## Chapter Outline (Draft)

1. **Why Design Matters** — The Hadoop parallel. LLM systems as distributed systems with stochastic components. The systems engineering gap for researchers: statisticians and data scientists aren't trained in these methods, the tooling market isn't building for research workflows, and the community has to fill that gap or it won't get filled. Design discipline isn't optional.
2. **Classification & Coding Workflows** — Survey question mapping, occupation/industry coding, document classification. Ensemble agreement, confidence routing, human review escalation. Federal Survey Concept Mapper as anchor case study.
3. **Data Cleaning & Imputation Workflows** — LLMs for anomaly detection, inconsistency flagging, imputation proposals. Where LLMs complement traditional methods. Edit/imputation pipeline design.
4. **Detection & Extraction Workflows** — Entity extraction, pattern detection, disclosure review assistance. Recall vs precision tradeoffs in statistical contexts.
5. **The Ensemble & Multi-Model Playbook** — ABBA designs, judge loops, agreement scoring, model order switching. The cross-cutting "how" chapter.
6. **Parallel, Serial, and the Bottleneck** — What runs concurrently. Batch design. Rate limits and cost. The $15 vs $1500 lesson.
7. **Checkpoints, Failures, and Recovery** — Config-driven architecture. Retry logic. Idempotent operations. Picking up where you left off.
8. **Evaluation by Design** — Design systems that produce their own statistics. Metrics collection as architecture, not afterthought.
9. **State, Drift, and Validity** — SFV applied. Context window management. Training cutoff windows. When your instrument changes under you.
10. **State Management & Research Provenance** — Tracking what happened, what changed, and why across a research pipeline. Configuration control, artifact tracking, ontology management. Seldon as case study. Connection to SFV: state management is how you operationalize validity.
11. **Workflow Orchestration & the Tool Landscape** — Abstract treatment of orchestration approaches: tradeoffs between managed platforms, code-first, and CLI-native. MCP friction analysis as a worked example. Context windows and long-term memory. What to bet on vs wait on. Designed for updateability.
12. **Security, Supply Chain, and Model Provenance** — The information security chapter. Model provenance verification, dependency auditing, "offline isn't offline," data residency constraints, the security surface area of LLM workflows that security teams don't yet have playbooks for.
13. **Deploying in Institutional Environments** — Cloud parity gap, ATO timelines, governance-as-bottleneck vs governance-as-enabler, IT as partner not gatekeeper, continuous delivery culture shift, institutional friction, "enough governance and no more."
14. **Cost & Practicality** — Token budgets. Batch economics. When cheap models win. Making the case to your program office.

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

**Chapter-to-Principle Mapping:**

| Chapter | Primary Working Principle(s) | Primary Tenet(s) |
|---------|------------------------------|------------------|
| Ch 1: Why Design Matters | All (introduction) | All (introduction) |
| Ch 2: Classification & Coding | Adoption determines impact | Deliver capability quickly |
| Ch 3: Data Cleaning & Imputation | Reuse data before collecting more | Data precedes models |
| Ch 4: Detection & Extraction | If it cannot be explained, do not use it | Humans remain accountable |
| Ch 5: Ensemble & Multi-Model | Outputs require full provenance | Defensibility is required |
| Ch 6: Parallel, Serial, Bottleneck | Adoption determines impact | Deliver capability quickly |
| Ch 7: Checkpoints & Recovery | Build lineage before scale | Experiment under control |
| Ch 8: Evaluation by Design | If it cannot be explained, do not use it | Defensibility is required |
| Ch 9: State, Drift, Validity | Outputs require full provenance | Trust defines the mission |
| Ch 10: State Mgmt & Provenance | Build lineage before scale | Defensibility is required |
| Ch 11: Workflow Orchestration | Access defines capability | Infrastructure enables delivery |
| Ch 12: Security & Supply Chain | Security is a system property | Trust defines the mission |
| Ch 13: Institutional Deployment | Slow governance prevents delivery | Governance must enable execution |
| Ch 14: Cost & Practicality | Slow governance prevents delivery | Infrastructure enables delivery |

See `book/appendix-principles.md` for standalone reference page.

## Chapter Pedagogical Pattern

Every chapter follows this consistent structure (Feynman pedagogy operationalized):

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

- **Federal Survey Concept Mapper** (`/Users/brock/Documents/GitHub/federal-survey-concept-mapper/`) — Primary case study for ensemble/multi-model patterns. Dual-model cross-validation, confidence-based arbitration, 6,987 questions, 99.5% accuracy, ~$15.
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
