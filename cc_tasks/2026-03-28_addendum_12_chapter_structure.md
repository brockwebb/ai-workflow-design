# CC Task Addendum: Updated Chapter Structure (12 Chapters)

**Date:** 2026-03-28
**Amends:** `cc_tasks/2026-03-27_project_initialization.md`
**Reason:** Chapter outline expanded from 10 to 12 chapters based on design discussion

---

## Changes to Chapter Outline

The original 10-chapter outline is superseded by this 12-chapter structure. The original chapters 1-9 are unchanged in content. The original chapter 10 (Cost & Practicality) moves to chapter 12. Two new chapters are inserted.

### Updated Full Outline

1. **Why Design Matters** — The Hadoop parallel. LLM systems as distributed systems with stochastic components. *Added emphasis:* the systems engineering gap for researchers — statisticians and data scientists aren't trained in these methods, the tooling market isn't building for research workflows, and the community has to fill that gap or it won't get filled. The market is solving software development problems, not research documentation and scientific practice problems.
2. **Classification & Coding Workflows** — Survey question mapping, occupation/industry coding, document classification. Ensemble agreement, confidence routing, human review escalation. Federal Survey Concept Mapper as anchor case study.
3. **Data Cleaning & Imputation Workflows** — LLMs for anomaly detection, inconsistency flagging, imputation proposals. Where LLMs complement traditional methods. Edit/imputation pipeline design.
4. **Detection & Extraction Workflows** — Entity extraction, pattern detection, disclosure review assistance. Recall vs precision tradeoffs in statistical contexts.
5. **The Ensemble & Multi-Model Playbook** — ABBA designs, judge loops, agreement scoring, model order switching. The cross-cutting "how" chapter.
6. **Parallel, Serial, and the Bottleneck** — What runs concurrently. Batch design. Rate limits and cost. The $15 vs $1500 lesson.
7. **Checkpoints, Failures, and Recovery** — Config-driven architecture. Retry logic. Idempotent operations. Picking up where you left off.
8. **Evaluation by Design** — Design systems that produce their own statistics. Metrics collection as architecture, not afterthought.
9. **State, Drift, and Validity** — SFV applied. Context window management. Training cutoff windows. When your instrument changes under you.
10. **State Management & Research Provenance** *(NEW)* — The problem of tracking what happened, what changed, and why across a research pipeline. Configuration control, artifact tracking, ontology management. Seldon as case study / existence proof. Foreshadow to the SFV SSRN paper. Frame as "the problem Seldon solves," not "how to use Seldon." Chapter must stand alone without the paper.
11. **Workflow Orchestration & the Tool Landscape** *(NEW)* — Abstract treatment of orchestration approaches: LangChain, n8n, MCP, CLI-first, custom code. Tradeoffs: friction vs capability, coupling vs flexibility, visual vs programmatic, researcher accessibility vs engineering power. Context windows and long-term memory — current state, trajectory, what to bet on vs wait on. MCP friction analysis as a worked example of evaluating tools for research contexts. Agent workflow management patterns. Keep abstract — specific tools are illustrative examples, not prescriptions. This chapter will age fastest; design it to be updateable.
12. **Cost & Practicality** *(moved from 10)* — Token budgets. Batch economics. When cheap models win. Making the case to your program office.

### New Chapter Placeholder Files to Create

**book/chapter-10.md:** (replaces the old chapter-10 which was Cost & Practicality)
```markdown
# Chapter 10: State Management & Research Provenance

<!-- STATUS: Placeholder -->
<!-- Case study: Seldon artifact tracking system -->
<!-- Foreshadow to SFV SSRN paper (in production) -->
<!-- SHARED ONTOLOGY: Terms from seldon/ontology/validity/VALIDITY_VOCABULARY.md -->

## Working Notes

- The problem: tracking what happened, what changed, and why across a research pipeline
- Configuration control for research — not the same as software version control
- Artifact tracking: inputs, outputs, intermediate products, decisions
- Ontology management: shared vocabulary across projects (AD-017 pattern)
- Why git alone isn't enough for research provenance
- Seldon as case study — frame as "the problem" not "the product"
- CC task discipline as a design pattern, not a Seldon feature
- Handoff documents as state serialization
- Connection to SFV: state management is how you operationalize validity
- Foreshadow the SSRN paper without depending on it
```

**book/chapter-11.md:**
```markdown
# Chapter 11: Workflow Orchestration & the Tool Landscape

<!-- STATUS: Placeholder -->
<!-- Design for updateability — this chapter ages fastest -->

## Working Notes

- Abstract framework for evaluating orchestration approaches
- Categories: managed platforms (n8n, Zapier) vs code-first (LangChain, LlamaIndex) vs CLI-native vs custom
- Tradeoffs:
  - Friction vs capability (MCP example: powerful but high friction for researchers)
  - Tight coupling vs loose coupling (LangChain lock-in risk)
  - Visual workflows vs code workflows (who is the user?)
  - Researcher accessibility vs engineering power
- CLI-first argument: closer to how researchers already work, less infrastructure overhead
- MCP: current state, limitations, friction analysis as worked example of tool evaluation
- Agent workflow management: how agentic systems are orchestrated today
- Context windows: current constraints, long-term memory solutions in development
- What to bet on vs what to wait on — a framework for technology timing decisions
- The market gap: tools are built for software development, not research documentation
- Keep specific tool references as illustrative examples in callout boxes — easy to update
```

**book/chapter-12.md:**
```markdown
# Chapter 12: Cost & Practicality

<!-- STATUS: Placeholder -->
<!-- Was originally chapter 10 — content unchanged, just renumbered -->

## Working Notes

- Token budgets: estimating cost before running
- Batch economics: cost per item at scale
- When cheap models win (and when they don't)
- Making the case to your program office / budget authority
- The hidden costs: developer time, review time, error correction
- Cost comparison frameworks: LLM pipeline vs manual process vs traditional automation
- Configuration-driven model selection: swap models without rewriting code
```

### Files to Update

**CLAUDE.md:** Update the chapter outline section to reflect 12 chapters. Add chapters 10-11 descriptions, renumber old chapter 10 to 12.

**book/chapter-10.md:** The existing file contains the old "Cost & Practicality" content. It needs to be:
1. Renamed/moved to `book/chapter-12.md` (new cost chapter)
2. Replaced with the new "State Management & Research Provenance" placeholder above

### Execution Order

1. Read existing `book/chapter-10.md` content
2. Write that content to `book/chapter-12.md`
3. Overwrite `book/chapter-10.md` with the new State Management placeholder
4. Create `book/chapter-11.md` with the Workflow Orchestration placeholder
5. Update CLAUDE.md chapter outline to reflect 12-chapter structure
6. Register new artifacts with Seldon (chapter-10 updated, chapter-11 new, chapter-12 new)

---

## Key Design Principles for New Chapters

### Chapter 10 (State Management)
- Frame around the *problem*, not the *tool*
- Seldon is the case study, same way the concept mapper is the case study for chapter 2
- Must stand alone even if the reader never sees the SFV paper
- Connection to chapter 9: chapter 9 is "why state matters (validity)," chapter 10 is "how to manage state (engineering)"

### Chapter 11 (Tool Landscape)
- Design for updateability: specific tools are examples, not prescriptions
- Use callout boxes or sidebars for tool-specific details — easy to revise without rewriting the chapter
- The abstract tradeoff framework is the durable content; the tool examples are perishable
- Include the "market isn't building for researchers" argument — this is why researchers need design literacy, not just tool tutorials
- Honest about what's immature: long-term memory, persistent context, agent orchestration are all pre-convergence
