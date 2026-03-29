# Handoff: AI Workflow Design — Session 2

**Date:** 2026-03-28
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### 14-Chapter Structure Finalized

Expanded from 12 to 14 chapters. The old Ch 11 ("Workflow Orchestration & the Tool Landscape") was carrying two distinct scopes — tool evaluation/orchestration AND operational realities (security, institutional deployment). These were split into separate chapters because security and IT people need to see themselves in the table of contents.

**Title conflict resolved:** "Operating in the Real World" was used in the brainstorm addendum and principles addendum but never existed as a chapter title on disk. Eliminated entirely. Replaced by two dedicated chapters with clear scopes.

### CC Tasks Written and Executed (2 files)

1. **`2026-03-28_addendum_14_chapter_structure.md`** — EXECUTED
   - Split old Ch 11 into: Ch 11 (Orchestration, unchanged), Ch 12 (Security), Ch 13 (Institutional)
   - Renumbered Cost & Practicality to Ch 14
   - Updated CLAUDE.md, appendix-principles.md, principle mapping table
   - Reassigned brainstorm material: #8 → Ch 12, #9 → Ch 13, #11 → Ch 13
   - Created chapter-12.md, chapter-13.md, chapter-14.md placeholders

2. **`2026-03-28_addendum_figure_registry_and_brainstorm.md`** — EXECUTED
   - Created `book/figure-registry.md` — figure and table tracking
   - Created `assets/diagrams/fig-01-01_naive_vs_designed.md` — first figure concept
   - Slotted voice transcript brainstorm material into Ch 4, 5, 8, 9, 12
   - Seldon has native `Figure` artifact type — all future figures should use it
   - fig-01-01 registered as Figure (d19f1cf8), registry as DataFile (2e8ef2b5)

### Brainstorm Material Slotted (from voice transcript)

Material from a brainstorming conversation about validation architecture, knowledge graph fidelity, and model selection was distributed:

| Material | Chapter |
|----------|---------|
| KG extraction as fidelity bottleneck, "confidence laundering machine" | Ch 4 |
| Four-layer validation architecture (selection → inference → evidence → decision) | Ch 5 |
| Model independence debate (correlated but not identical failure modes) | Ch 5 |
| Federal constraint: Western frontier models only | Ch 5, Ch 12 |
| Two-vs-three models, reprocessing advantage | Ch 5 |
| Benchmark-as-instrument critique ("what's the benchmark for ACS B19013_001E?") | Ch 8 |
| SFV sub-dimensions mapped to knowledge graphs | Ch 9 |
| Model selection logic as drift surface | Ch 9 |
| Constrained model pool as trust/security decision | Ch 12 |

### Figure Concept Captured: fig-01-01

**"Naive vs Designed Single Stage"** — Two-panel horizontal figure for Chapter 1.
- Left panel: Input → Model → Output (annotated with all hidden problems)
- Right panel: Same I/O with visible internals (model selection, parallel inference, agreement scoring, decision logic, evidence accumulation)
- Punchline: "The simple version isn't simpler — it just hides the complexity."
- Design spec at `assets/diagrams/fig-01-01_naive_vs_designed.md`
- Rendering method TBD (depends on build system decision)

### Key Decisions

- **14 chapters is the structure.** "Things should be whatever they are."
- **Security gets its own visible chapter** (Ch 12) so security/IT people see themselves in the TOC
- **Institutional deployment gets its own chapter** (Ch 13) so IT operations/governance people see themselves
- **Prompt engineering chapter rejected** — low value, the market is drowning in that content. Prompts are implementation details inside the patterns already covered in domain chapters.
- **Seldon has native Figure type** — use it for all future figures, don't reinvent tracking
- **Neo4j MCP hits Arnold database, not Seldon** — don't use neo4j-mcp for Seldon queries. Use CC tasks.

## Chapter Outline (Final, 14 Chapters)

1. **Why Design Matters** — The Hadoop parallel. LLM systems as distributed systems. The systems engineering gap. Design discipline isn't optional.
2. **Classification & Coding Workflows** — Concept mapper case study. Ensemble agreement, confidence routing, human review escalation.
3. **Data Cleaning & Imputation Workflows** — LLMs complementing traditional methods. Edit/imputation pipeline design.
4. **Detection & Extraction Workflows** — Entity extraction, pattern detection. KG fidelity critique. Recall vs precision.
5. **The Ensemble & Multi-Model Playbook** — ABBA, judge loops, agreement scoring. Four-layer validation architecture. Model independence.
6. **Parallel, Serial, and the Bottleneck** — Batch design. Rate limits. The $15 vs $1500 lesson.
7. **Checkpoints, Failures, and Recovery** — Config-driven architecture. Retry logic. Idempotent operations.
8. **Evaluation by Design** — Systems that produce their own statistics. Benchmark-as-instrument. Unit tests as TEVV.
9. **State, Drift, and Validity** — SFV applied. Context window management. SFV-to-KG mapping.
10. **State Management & Research Provenance** — Seldon case study. CC task discipline. Artifact tracking.
11. **Workflow Orchestration & the Tool Landscape** — Tool evaluation frameworks. MCP friction. CLI-first. What to bet on vs wait on.
12. **Security, Supply Chain, and Model Provenance** — Security surface area of LLM workflows. "Offline isn't offline." Model provenance. Constrained model pool.
13. **Deploying in Institutional Environments** — Cloud parity gap. ATO. Governance vs delivery. IT as partner.
14. **Cost & Practicality** — Token budgets. Batch economics. Making the case to your program office.

## What's Next

1. **Start writing Chapter 1** — Most material queued (maturity model, principles, workflow decomposition thesis, fig-01-01)
2. **Build system decision** — Jupyter Book vs Quarto vs something else. Prototype with Ch 1.
3. **Render fig-01-01** — Method depends on build system. PaperBanana, Mermaid, or manual.
4. **Gather source material** — Pull from concept mapper, ai4stats, AI Agents 101, Medium article

## Open Questions (carried forward + new)

- Build system decision (Jupyter Book vs Quarto)
- License (likely CC BY 4.0)
- Code examples vs prose-only
- Medium article location
- fig-01-01 rendering method

## Artifacts on Disk

| File | Status |
|------|--------|
| `book/chapter-01.md` through `chapter-14.md` | Placeholders with working notes |
| `book/appendix-principles.md` | Tenets, principles, 14-chapter mapping |
| `book/bibliography.md` | Empty placeholder |
| `book/figure-registry.md` | Created, fig-01-01 entry |
| `assets/diagrams/fig-01-01_naive_vs_designed.md` | Figure concept spec |
| `CLAUDE.md` | Updated with 14-chapter outline |
| `cc_tasks/` | 6 CC task files (all executed) |

## Session Notes

- `str_replace` does not work on Brock's filesystem. Read → modify → write pattern required.
- `bash_tool` runs on Claude's container, not Brock's machine.
- `github:create_or_update_file` prohibited on Seldon-managed repos.
- Neo4j MCP → Arnold database only. Don't use for Seldon graph queries.
- Brock executes CC tasks as produced, not queued.
