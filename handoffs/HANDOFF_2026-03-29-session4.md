# Handoff: AI Workflow Design — Session 4

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Chapter 1 Design and Argument Development

Extended discussion refining the Chapter 1 argument. Key intellectual moves:

1. **Hadoop parallel demoted.** Brock questioned whether the Hadoop analogy was the right structural metaphor. Conclusion: it's a 2-3 paragraph aside, not the chapter frame. The real parallel is that physical constraints (data transport, compute time, memory) forced design discipline in the Hadoop era; token throughput, throttle rates, cost, and context window limits do the same now. But the analogy shouldn't carry the chapter.

2. **Stochastic nature as the core thesis.** LLMs are stochastic in a qualitatively different way from what statisticians already know (seeded PRNGs, Monte Carlo, bootstrap). LLMs are irreproducible across runs, operate over language not numbers, have uncharacterizable error distributions, and produce coherent-sounding wrong answers. Key concepts coined/adopted:
   - "Stochastic liabilities, not bugs" — a property you design around, not a defect you fix
   - "Stochastic tax" — every LLM invocation where a deterministic method would suffice is unnecessary variance, cost, and audit burden
   - Traditional reproducible research is *broken* by these systems, requiring new evidence chain approaches (→ SFV)

3. **Iterative refinement trap identified.** Agentic self-refinement loops show diminishing and eventually negative returns. Brock's observation: "machines can overthink problems too." Analogy to model collapse at inference time (training-time model collapse = training on own outputs; inference-time = system consuming its own output in quality loops). Flagged as potentially original comparison — needs literature check. Six citations verified and ready to use (Madaan 2023, Huang 2024, Yang 2025, Xu 2024, Pan 2024, Lee 2025).

4. **Dan Shapiro's Five Levels framework adopted.** Brock referenced the "levels of AI coding" — traced to Dan Shapiro (CEO Glowforge), published January 23, 2026. Brock had encountered it through Nate B. Jones's YouTube coverage but didn't know the original source. Citation corrected to Shapiro. Framework adapted for research workflows in the book:
   - Level 0-1: LLM as helper (VBA macro for Excel QA — real example from Census colleagues)
   - Level 2: LLM as junior analyst, human reviews everything (where 90% are stuck)
   - Level 3: Outcome-based, infrastructure-supported (Brock's current practice)
   - Level 4-5: Specification-driven research pipelines
   - Key insight: the infrastructure to operate safely at higher levels *doesn't exist yet* for research contexts. The tooling market builds for software developers. This book fills the gap.

5. **"Human in the loop" reframed.** Brock's public position: "My goal is to remove myself as much as possible and only keep myself in the loop where I provide the most value." Being in the loop everywhere is waste (Level 2 thinking). The design discipline is identifying where human judgment is irreplaceable and automating everything else. Level 3+ is *earned*, not assumed — you get there by doing the prework.

6. **3,000 Excel files example repositioned.** Originally considered as chapter opener. Brock felt uneasy about opening with someone else's unnamed example. Moved to internal calibration point within the maturity levels discussion. Chapter 1 now opens from the foreword's Feynman frame into the stochastic nature thesis.

### Foreword Conceived — Feynman Pedagogical Frame

Major session development: the book now has a foreword grounded in Feynman's first principles thinking.

**Core argument:** If you can't explain what your AI workflow is doing and why, you don't understand it well enough to trust it with official statistics.

**Key threads:**
- Feynman's "cargo cult science" applied to AI adoption — people calling APIs, getting fluent output, assuming it works
- "I learned very early the difference between knowing the name of something and knowing something" — the book closes this gap
- First principles, not recipes — tools change weekly, principles endure
- The book asks you to think, not follow instructions

**Outcome-focused validation (author's practice):**
- Learn to look for *signs* of correct output, not review every line
- Mental simulation of expectations beforehand; scrutinize both confirmations (check for confirmation bias) and violations (investigate why)
- Double-edged sword: can't be satisfied with any output whether expected or unexpected without understanding why
- This is what makes the process scalable — without it, stuck at Level 2

**"Find your edge":**
- Not a race — a self-guided tour
- Different readers have different strengths; the book helps them find where they synergize with AI
- Learning by doing and failing and taking things apart

**Self-deception thread (ties Feynman to technical content):**
- Feynman warned about fooling yourself → AI makes it easier than ever → design discipline is how you stop fooling yourself at scale

**Deep research report on Feynman method and learning models** collected and filed to `docs/research_notes/2026-03-29_feynman_method_learning_models.md`. Covers Feynman technique, Socratic method, Bloom's taxonomy, constructivism, deliberate practice, active learning, cognitive apprenticeship, retrieval practice, spaced repetition. Includes section on applying Feynman-style principles to GenAI systems in federal statistics with NIST/OMB alignment.

### Pedagogical Structure Formalized

**Decision:** Every chapter includes a consistent pedagogical pattern:
- Opening hook (concrete scenario)
- Core content
- Reflection prompts distributed throughout (inline, not boxed at end)
- At least one thought experiment per chapter
- Chapter bridge (connects forward)

This is Feynman pedagogy operationalized: study → explain/apply → find gaps → go back.

**Fig-01-01 reworked:** No longer a side-by-side comparison. Now a two-stage "what's wrong with this picture" exercise:
1. Present the naive workflow only
2. Ask the reader: What could go wrong? How would you know? Could you defend this?
3. Then present the designed workflow, with each component now motivated by the problems the reader identified

### Research Notes Infrastructure

Created `docs/research_notes/` as a gitignored staging area for raw research material. CC task written and executed to add gitignore entry, README, and the Feynman deep research report.

### Workflow Correction

Claude attempted to copy a file directly to the managed repo filesystem via bash. Brock corrected immediately. Rule restated: Seldon manages the repo. Only CC task files and handoffs are direct writes. Everything else goes through CC task execution via Claude Code. No exceptions.

## CC Tasks Written This Session (6 files)

All on disk, ready for execution in this order:

1. `2026-03-29_research_notes_infrastructure.md` — **EXECUTED.** Gitignore entry, research notes folder, Feynman report copy.
2. `2026-03-29_foreword_feynman_frame.md` — Foreword draft. Feynman first principles as pedagogical philosophy. TOC update.
3. `2026-03-29_addendum_foreword_outcome_focus.md` — Addendum to foreword: outcome-focused validation, finding your edge, self-deception thread.
4. `2026-03-29_chapter_01_draft.md` — Chapter 1 full draft spec. Argument flow, section structure, verified citations, writing guidance.
5. `2026-03-29_addendum_chapter_01_levels_and_maturity.md` — Addendum: Shapiro's levels adapted for research, VBA example placement, human-in-the-loop reframe.
6. `2026-03-29_addendum_chapter_01_pedagogy_and_fig_rework.md` — Addendum: fig-01-01 two-stage exercise, chapter pedagogical pattern, Excel example repositioned.

**Execution note:** Tasks 3 is addendum to 2; tasks 5-6 are addenda to 4. CC should read parent + addenda together before executing.

## Current State of the Repo

### Build Infrastructure (COMPLETE — no changes this session)

### Cover Art (COMPLETE — no changes this session)

### New This Session
| File | Status |
|------|--------|
| `docs/research_notes/` | Created, gitignored |
| `docs/research_notes/README.md` | Created |
| `docs/research_notes/2026-03-29_feynman_method_learning_models.md` | Deep research report, filed |

### Chapter Files (unchanged from Session 3)
| File | Status |
|------|--------|
| `book/chapter-01.md` through `chapter-14.md` | Placeholders with working notes |
| `book/appendix-principles.md` | Tenets, principles, 14-chapter mapping |
| `book/bibliography.md` | Empty placeholder |
| `book/figure-registry.md` | Created, fig-01-01 entry |
| `book/cover.md` | Cover page with image reference |
| `book/intro.md` | Placeholder intro |

### CC Tasks on Disk (17 files total)
Previously executed (11):
- `2026-03-27_project_initialization.md`
- `2026-03-28_addendum_12_chapter_structure.md`
- `2026-03-28_addendum_14_chapter_structure.md`
- `2026-03-28_addendum_brainstorm_material.md`
- `2026-03-28_addendum_figure_registry_and_brainstorm.md`
- `2026-03-28_addendum_principles_and_tenets.md`
- `2026-03-28_addendum_update_claudemd_build_system.md`
- `2026-03-28_scaffold_myst_build_system_v2.md`
- `2026-03-28_scaffold_pdf_build_pipeline.md`
- `2026-03-29_deploy_cover_art.md`
- `2026-03-29_generate_cover_art_paperbanana.md`

Executed this session (1):
- `2026-03-29_research_notes_infrastructure.md`

Ready to execute (5):
- `2026-03-29_foreword_feynman_frame.md`
- `2026-03-29_addendum_foreword_outcome_focus.md`
- `2026-03-29_chapter_01_draft.md`
- `2026-03-29_addendum_chapter_01_levels_and_maturity.md`
- `2026-03-29_addendum_chapter_01_pedagogy_and_fig_rework.md`

## What's Next

1. **Execute remaining 5 CC tasks** — Foreword draft, then Chapter 1 draft with all three addenda.
2. **Review foreword and Chapter 1 drafts** — Brock reviews, provides feedback, revision pass.
3. **Render fig-01-01** — Now two figures (01-01a naive, 01-01b designed) or sequential presentation. PaperBanana. Spec at `assets/diagrams/fig-01-01_naive_vs_designed.md` needs update to reflect two-stage approach.
4. **Document chapter pedagogical pattern** — Add to CLAUDE.md or a dedicated doc so it carries forward to all chapters.
5. **METR RCT full citation** — Verify: METR, July 2025, 16 developers, 246 tasks, 19% slower. Needed for Chapter 1.
6. **Model collapse at inference time analogy** — Literature check: has anyone explicitly made this comparison? If not, flag as original observation.
7. **Enable GitHub Pages** — Manual toggle in repo settings.

## Open Questions

- Code examples vs prose-only (carried from Session 3)
- Medium article location (carried from Session 3)
- Foreword length — spec says 3-5 pages, may need adjustment after draft
- How explicitly to reference ai4stats Chapter 15 in the Chapter 1 opening (self-contained but acknowledging the connection)
- Whether fig-01-01 becomes two separate figures or one figure presented sequentially

## Verified Citations (accumulated this session)

1. Madaan et al. (2023). "Self-Refine: Iterative Refinement with Self-Feedback." NeurIPS 2023.
2. Huang et al. (2024). "Large Language Models Cannot Self-Correct Reasoning Yet." ICLR 2024.
3. Yang et al. (2025). "A Probabilistic Inference Scaling Theory for LLM Self-Correction." EMNLP 2025.
4. Xu et al. (2024). "Pride and Prejudice: LLM Amplifies Self-Bias in Self-Refinement."
5. Pan et al. (2024). "Spontaneous Reward Hacking in Iterative Self-Refinement."
6. Lee et al. (2025). RefineBench.
7. Shapiro, Dan (2026). "The Five Levels: from Spicy Autocomplete to the Dark Factory." danshapiro.com, January 23, 2026.

## Session Notes

- `str_replace` does not work on Brock's filesystem. Read → modify → write pattern required.
- `bash_tool` runs on Claude's container, not Brock's machine.
- `github:create_or_update_file` prohibited on Seldon-managed repos.
- Claude writes ONLY CC task files and handoffs to `cc_tasks/` and `handoffs/`. Everything else through CC task execution via Claude Code.
- Claude was corrected this session for attempting a bash copy to the managed repo. Rule is absolute.
- Neo4j MCP → Arnold database only. Don't use for Seldon graph queries.
- Brock executes CC tasks as produced, not queued. Don't remind him about queued tasks.
- Dan Shapiro's Five Levels — cite Shapiro, not Nate B. Jones (who covered it on YouTube but didn't originate it).
- Feynman material is pedagogical philosophy for the foreword, not technical content for chapters.
- Brock thinks out loud in session — stories and analogies are conceptual exploration, not content commitments. Don't put the coaching/running story in the book.
