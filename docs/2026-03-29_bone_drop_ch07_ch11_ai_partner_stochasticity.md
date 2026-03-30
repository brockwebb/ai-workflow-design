# CC Task: Bone Drop — Ch 7 & Ch 11 AI Partner Fighting Your Patterns

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Target chapters:** `book/chapter-07.md` (Checkpoints, Failures, and Recovery), `book/chapter-11.md` (Workflow Orchestration & the Tool Landscape)
**Type:** Design notes for future drafting — not a chapter draft

---

## Notes to Incorporate

### The Meta-Problem: Your AI Development Partner Is Also Stochastic

When using LLMs (Claude Code, Copilot, etc.) to build LLM pipelines, you encounter a recursive version of the stochastic management problem:

- **Ignores configuration files.** You tell it to use a config file for model names and API endpoints. It hardcodes model names in the source instead — sometimes model names that don't exist (hallucinated model identifiers).
- **Reinvents debugged infrastructure.** You provide a reference implementation of rate limiting, exponential backoff, and checkpoint/resume. It writes its own version from scratch, introducing bugs you already fixed.
- **Training cutoff contamination.** The AI partner's knowledge of available models and APIs is frozen at its training cutoff. It suggests models that have been deprecated, uses outdated API signatures, and doesn't know about newer, cheaper, or better options unless you explicitly tell it.
- **Pattern drift across sessions.** Each new coding session starts fresh. The AI partner doesn't remember the architectural decisions from previous sessions. You end up maintaining a reference library (CLAUDE.md, architectural docs) and still babysitting.

### Design Implications

**For Ch 7 (Checkpoints and Recovery):**
- Config-driven architecture is a defense against both runtime failures AND development-time drift. If model names, endpoints, and pipeline parameters live in configuration, the AI partner can't hardcode them — or at least the hardcoding is immediately visible as a deviation from the config.
- Reference implementations need to be more than documentation — they need to be importable modules that the AI partner is directed to use, not "look at this example and do something similar."

**For Ch 11 (Tool Landscape):**
- The development toolchain is part of the workflow architecture, not separate from it. When your development tool (the AI coding assistant) is itself stochastic, your development process needs the same quality controls as your inference pipeline: checkpoints, validation, regression tests.
- Context window limits in the development tool create their own state management problems. Long sessions drift. Compactions lose architectural context. This is SFV applied to the development process, not just the data processing pipeline.
- The Seldon/CC-task workflow is itself an answer to this problem: immutable task specs that survive context loss, verification gates before commit, handoff documents that restore session state.

### The Irony

You're designing systems to manage LLM stochasticity using tools that are themselves stochastic. The engineering discipline required to build reliable LLM pipelines is the same discipline required to work with LLM coding assistants. The book's thesis applies recursively.

---

## Source Material

- Session 6 conversation notes (AI partner reinventing infrastructure, ignoring config, hallucinating model names)
- `federal-survey-concept-mapper/cc_tasks/exterminate_hallucinated_model_names.md` — evidence of the model name contamination problem
- `federal-survey-concept-mapper/docs/model_name_contamination_cleanup_report.md` — cleanup documentation
- Seldon workflow design (CC tasks, CLAUDE.md, verification gates) as the operational answer
