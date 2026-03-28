# CLAUDE.md — AI Workflow Design for Official Statistics

## Project Overview

An open-source book on designing reliable AI/LLM workflows for statistical research and official statistics production. Companion/sequel to *AI for Official Statistics* (ai4stats). Where ai4stats teaches federal statisticians what AI is, this book teaches builders how to design AI-powered data processing pipelines that work reliably.

**Audience:** Data scientists, statisticians, and researchers in federal statistical agencies (Census, BLS, NCHS, BEA, NASS) and similar organizations who are building — not just evaluating — AI workflows.

**Thesis:** LLM-powered research workflows require the same architectural discipline that distributed systems have always required. The design patterns matter more than the model choice. Most people building these systems are learning by trial and error; this book codifies the patterns.

**Repo:** `brockwebb/ai-workflow-design`
**Author:** Brock Webb
**License:** TBD (likely CC BY 4.0, matching ai4stats)

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

1. **Why Design Matters** — The Hadoop parallel. LLM systems as distributed systems with stochastic components. Design discipline isn't optional.
2. **Classification & Coding Workflows** — Survey question mapping, occupation/industry coding, document classification. Ensemble agreement, confidence routing, human review escalation. Federal Survey Concept Mapper as anchor case study.
3. **Data Cleaning & Imputation Workflows** — LLMs for anomaly detection, inconsistency flagging, imputation proposals. Where LLMs complement traditional methods. Edit/imputation pipeline design.
4. **Detection & Extraction Workflows** — Entity extraction, pattern detection, disclosure review assistance. Recall vs precision tradeoffs in statistical contexts.
5. **The Ensemble & Multi-Model Playbook** — ABBA designs, judge loops, agreement scoring, model order switching. The cross-cutting "how" chapter.
6. **Parallel, Serial, and the Bottleneck** — What runs concurrently. Batch design. Rate limits and cost. The $15 vs $1500 lesson.
7. **Checkpoints, Failures, and Recovery** — Config-driven architecture. Retry logic. Idempotent operations. Picking up where you left off.
8. **Evaluation by Design** — Design systems that produce their own statistics. Metrics collection as architecture, not afterthought.
9. **State, Drift, and Validity** — SFV applied. Context window management. Training cutoff windows. When your instrument changes under you.
10. **Cost & Practicality** — Token budgets. Batch economics. When cheap models win. Making the case to your program office.

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

TBD — will prototype PDF pipeline early (lesson from ai4stats). Likely Jupyter Book or Quarto. Decision deferred until chapter 1 draft exists.

## Related Projects

- **ai4stats** (v1.0 published on Zenodo, DOI: 10.5281/zenodo.19206379) — predecessor, conceptual foundation
- **SFV framework** — feeds into Chapter 9
- **Seldon** — artifact tracking, used for this project's own configuration management
