# CC Task: Bone Drop — Ch 10 Seldon Origin and Provenance Motivation

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Target chapter:** `book/chapter-10.md` (State Management & Research Provenance)
**Type:** Design notes for future drafting — not a chapter draft

---

## Notes to Incorporate

### Seldon's Origin: Provenance as Pain Relief

Seldon was not built because configuration management is theoretically important. It was built because the cognitive overhead of manually managing pipeline state — model versions, prompt templates, arbitration histories, file provenance, intermediate outputs — was consuming intellectual capital that should have been spent on design work.

The author's experience building the Federal Survey Concept Mapper (Ch 2 case study) demonstrated the problem concretely: the pipeline produced reliable results ($15, κ = 0.843), but reconstructing how those results were produced after the fact took days of unwinding. A separate project (DAG-based workflow) had to be abandoned entirely — burned to the ground — because the provenance couldn't be recovered at all.

The pattern: **output quality and process traceability are decoupled in early LLM projects.** You get great results and no audit trail. For personal research, that's painful but survivable. For production systems in federal agencies, it's disqualifying.

### The Reference Librarian Tax

Before Seldon existed, the author served as the human reference librarian for every pipeline:
- Maintaining CLAUDE.md files and architectural docs so AI coding assistants would follow established patterns
- Catching and correcting hallucinated model names (documented in the Concept Mapper's `exterminate_hallucinated_model_names.md` and `model_name_contamination_cleanup_report.md`)
- Manually tracking which CC tasks were executed, which files were modified, which artifacts were stale
- Rebuilding session context after every new conversation because the AI partner's context window doesn't persist

This is Level 2 operation (Shapiro's levels, Ch 1): the human doing supervisory work that should be automated. Seldon automates the parts that can be automated — artifact tracking, provenance graphs, verification gates, session handoffs — so the human operates at Level 3+: specifying intent and verifying outcomes.

### Building Competence Outside the Perimeter

Important distinction for the book: the author built all early LLM pipeline experience using public data on personal hardware, with personal API keys and personal GitHub repos. This is NOT shadow IT. No agency data was involved. No security boundaries were crossed. When code or artifacts needed to come inside the agency perimeter, they entered as a black hole — customized from within, never exfiltrated back out.

This pattern — practitioners building competence on their own time with public resources — is common and legitimate. The book should acknowledge it without conflating it with shadow IT (which involves using unapproved tools on agency data). Both patterns exist in institutional environments, and both are responses to the access gap described in Ch 13, but they carry very different risk profiles.

### Design Principle for Ch 10

Provenance systems exist because humans shouldn't be provenance systems. The cognitive cost of manually tracking "what happened, in what order, with what configuration, producing what artifacts" across a multi-stage stochastic pipeline exceeds what any individual can sustain. The choice is: (1) build the tracking into the pipeline from the start, or (2) pay the reconstruction tax later — measured in days, not hours, and sometimes in abandoned projects.

---

## Source Material

- `federal-survey-concept-mapper/cc_tasks/exterminate_hallucinated_model_names.md`
- `federal-survey-concept-mapper/docs/model_name_contamination_cleanup_report.md`
- `federal-survey-concept-mapper/handoffs/` — the full handoff history showing manual session state management
- Session 6 conversation notes (Seldon origin, DAG project burned to ground, reference librarian tax, public data distinction)
- Seldon repo design docs (artifact tracking, verification gates, CC task workflow)
