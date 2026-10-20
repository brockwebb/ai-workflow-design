# Handoff: AI Workflow Design — Session 10

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Chapter 10: State Management & Research Provenance — Designed and Drafted

Full design session followed by CC task and execution. Key design decisions:

- **"Defensible by design" as the opening hook.** The IG scenario: your agency deployed an AI pipeline, the results are challenged, can you prove the chain from input to output? The stakes are defensibility under independent audit, not convenience or cost savings.
- **Three reasons provenance is not optional:** defensibility (survive an independent audit), entropy management (long-running projects accumulate silent drift), scientific rigor (humans introduce variance into record-keeping — provenance infrastructure is standardized procedure that strengthens claims).
- **Eight abstract requirements for research provenance** stated before any implementation details: typed artifacts, relationships, state machines, staleness propagation, state serialization, shared vocabulary with write protection, change gating through specification documents, automated integrity verification. These are what any provenance system must satisfy, independent of implementation.
- **The DOORS lesson.** IBM DOORS had the right requirements decades ago (typed artifacts, traceability matrices, relationship tracking). Adoption died because human cost was too high. AI partners change the cost equation — they absorb the bookkeeping friction that killed traceability systems. The requirements didn't change; the feasibility did. DOORS is the enabler argument, not the thesis.
- **Seldon as worked example, not product pitch.** Five concrete failure modes from direct experience (numbers drifting, tasks falling through cracks, reference librarian tax, context resets, files as islands). Dual-layer architecture (append-only event log + graph database) framed as "the audit trail needs to be immutable and portable; the provenance needs to be queryable — you need both for different reasons." Provenance chains, staleness propagation, state machines, domain configuration.
- **Authority model.** AI writes as `proposed`, auto-accepted. Human intervenes at decision points (state transitions to `published`, elevated risk situations). Operationalizes Tenet 5 (humans remain accountable) without creating a bottleneck.
- **Thought experiment extends Ch 9's occupation coding scenario** — same pipeline, now challenged by a reviewer/auditor six months later. Trace provenance backward from the audit questions.

**CC task:** `2026-03-30_draft_chapter_10.md` — **EXECUTED**

### Chapter 11: Workflow Orchestration & the Tool Landscape — Designed and Drafted

Design session built on Ch 10's bridge. Key design decisions:

- **"The tool that isn't there" opening.** The market gap: orchestration tools exist for software engineering, not research pipelines. Research needs reproducibility, provenance, human-in-the-loop. The tool researchers need largely doesn't exist as a product.
- **Four-dimension evaluation framework** for any orchestration approach: coupling (lock-in risk), friction (operational overhead), transparency (auditability), volatility (will it exist in two years?). Framework is the durable content; specific tools are illustrative examples.
- **Orchestration categories with summary table:** managed platforms, code-first frameworks, CLI-native/script-based, custom/homegrown. Each assessed against the four dimensions. Table provides visual break in dense prose for less technical readers.
- **90/10 rule and the last mile as related but distinct concepts.** 90/10 is about effort distribution in tool adoption (last 10% of capability consumes 90% of effort). Last mile is the gap between demo and production (authorized environments, data residency, audit requirements). They compound: the hardest 10% IS the last mile.
- **MCP reframed as tool design for observability, NOT orchestration.** MCP is a guardrailed agentic system where the agent builds/decides the workflow. The lesson: if your tools don't output measurement data by design, you won't get it. Pragmatics tools designed to output evaluation data as first-class output. Tool design IS your instrumentation strategy in agentic systems. Connects to Ch 8 (evaluation by design) and Ch 10 (provenance).
- **Context windows as working memory.** Finite, scarce, must be managed. Externalize durable state (config files, handoff docs). Plan for compaction. Config-driven architecture (Ch 7) is external memory that survives context resets.
- **Recursive stochasticity — full treatment.** Ch 7 introduced this and promised Ch 11 would deliver. Dev tools are stochastic. 75% of frontier models break previously working features during maintenance (SWE-CI). The book's thesis applies recursively: design discipline for building LLM pipelines = design discipline for working with LLM development tools.
- **"Bet on vs. wait on" framework.** Bet on patterns (durable). Wait on products (volatile). Build thin adaptation layers (config loaders, checkpoint managers, provenance hooks, verification gates) that survive framework transitions.
- **"Building competence outside the perimeter" excluded** — confirmed as Ch 13 material.

**CC task:** `2026-03-30_draft_chapter_11.md` — **EXECUTED**

---

## CC Tasks Written This Session (2 files)

1. `2026-03-30_draft_chapter_10.md` — **EXECUTED**
2. `2026-03-30_draft_chapter_11.md` — **EXECUTED**

---

## Current State of the Repo

### ALL 14 CHAPTERS DRAFTED

| Chapter | Status |
|---------|--------|
| Foreword | Drafted (Session 4), revised (Session 8). **Note: functions as an Introduction, not a Foreword. Needs structural reclassification.** |
| Ch 1: Why Design Matters | Drafted, citations converted (Sessions 4–5) |
| Ch 2: Classification & Coding | Drafted (Session 6) |
| Ch 3: Data Cleaning & Imputation | Drafted (Session ??) |
| Ch 4: Detection & Extraction | Drafted (Session ??) |
| Ch 5: Ensemble & Multi-Model Playbook | Drafted (Session 7) |
| Ch 6: Parallel, Serial, Bottleneck | Drafted (Session 9) |
| Ch 7: Checkpoints, Failures, Recovery | Drafted (Session 9) |
| Ch 8: Evaluation by Design | Drafted (Session 7) |
| Ch 9: State, Drift, Validity | Drafted (Session 9) |
| Ch 10: State Mgmt & Provenance | **Drafted (Session 10)** |
| Ch 11: Workflow Orchestration | **Drafted (Session 10)** |
| Ch 12: Security & Supply Chain | Drafted (Session 5) |
| Ch 13: Institutional Deployment | Drafted (Session 5) |
| Ch 14: Cost & Practicality | Drafted (Session 6) |

### Chapters Not Yet Drafted
**None.** First complete draft achieved.

### CC Tasks on Disk
Previously executed (Sessions 1–9): 34 files
Executed this session: 2 files
**Total executed: 36**

---

## Key Design Decisions This Session

1. **Defensibility is the primary driver for provenance, not cost reduction.** The IG audit scenario is the stakes. Entropy management and scientific rigor are the second and third arguments.
2. **DOORS as the enabler argument, not the thesis.** Same requirements, different cost model. AI partners absorb the friction that killed human-operated traceability systems.
3. **Eight abstract provenance requirements before any implementation.** The requirements are general; Seldon is one existence proof.
4. **MCP is NOT a workflow/orchestration tool.** It's a guardrailed agentic system. The lesson is about tool design for observability — if tools don't output measurement data by design, you won't get it.
5. **90/10 rule and last mile are related but distinct.** They compound: the hardest 10% of capability IS the last mile of deployment.
6. **Recursive stochasticity fully delivered.** Ch 7 introduced it, Ch 11 delivers the full treatment with SWE-CI evidence. The book's thesis applies recursively.
7. **Patterns are durable, products are volatile.** The "bet on vs. wait on" framework: invest in patterns and thin adaptation layers, not in framework-specific features.

---

## New Citations Added (Session 10)

No new citations. All references used in Ch 10 and Ch 11 were already in `book/references.bib`:
- `webb_2026_pragmatics`, `webb_2025_opencensus_mcp`, `webb_2026_concept_mapper`
- `chen_2026_sweci`, `nist_ai_rmf_2023`, `shapiro_2026`
- `fcsm_2025_aiready`

Potential DOORS citation (`ibm_doors`) noted in Ch 10 CC task but not required — referenced by name in prose without formal citation.

**Citation verification audit backlog: 15 (unchanged)**

---

## What's Next

### Immediate Priority: Foreword → Introduction Reclassification

The current `book/foreword.md` is functionally an **Introduction**, not a Foreword:
- It frames the problem ("a new design space")
- Establishes the book's philosophy ("first principles, not recipes")
- Orients the reader ("the hardest part," "learning to see," "find your edge")
- Connects to the predecessor book (ai4stats)
- Bridges to Chapter 1

This is Introduction work. A Foreword is typically written by someone other than the author, or is a brief personal note. The current content is the book's orientation chapter.

**Next session task:** Reclassify and potentially restructure. Options:
1. Rename `foreword.md` → `introduction.md` and revise for holistic synthesis now that all 14 chapters are drafted. The Introduction can now accurately preview the full arc because the arc exists.
2. Write a proper brief Foreword (personal note, motivation, acknowledgments) AND restructure the current foreword content as the Introduction.
3. Merge relevant foreword content into Ch 1 and eliminate the standalone foreword/introduction distinction.

This requires reading all 14 chapter openings and bridges to write a synthesis that accurately represents the book's arc. Context-heavy task — better suited to a fresh session with the full book structure loaded.

### Review Backlog (complete first draft — all chapters)
- All 14 chapters + foreword in review queue
- Open questions: Ch 5 (7 items), Ch 8 (7 items), Ch 14 (7 items)

### Citation Verification
- 15 citations still need verification (unchanged)

### Deferred
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content (confirmed as Ch 13 material, check if already present)

---

## Session Notes

- **All 14 chapters now have first drafts.** This is the complete first draft of the book.
- **Two chapters drafted in one session** — Ch 10 and Ch 11, following the Ch 9 → Ch 10 → Ch 11 arc (SFV framework → provenance infrastructure → orchestration and tooling).
- **The book's structural arc is complete:** domain workflows (Ch 2–4) → cross-cutting patterns (Ch 5–8) → validity and infrastructure (Ch 9–11) → institutional context (Ch 12–14).
- **Ch 10's DOORS argument** provides historical grounding that strengthens the book's thesis: the provenance requirements aren't new, but AI partners make them feasible for the first time outside aerospace/defense.
- **Ch 11's recursive stochasticity section** is a thesis-level payoff: the book's design discipline applies to the process of writing the book itself (and the reader's development process).
- Two CC tasks written and executed.
- No protocol violations this session.
