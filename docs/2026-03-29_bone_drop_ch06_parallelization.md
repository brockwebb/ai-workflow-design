# CC Task: Bone Drop — Ch 6 Parallelization Design Notes

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Target chapter:** `book/chapter-06.md` (Parallel, Serial, and the Bottleneck)
**Type:** Design notes for future drafting — not a chapter draft

---

## Notes to Incorporate

### Parallelization as Natural Batch Design

From the Concept Mapper pipeline: LLM API rate limits and token-per-minute caps make serial processing of large classification tasks impractically slow. The solution is parallel workers farming batches independently through the API.

Key design properties:
- **Clean process separation.** Each worker processes its own batch. No shared context, no bleeding between processes. This isn't just a performance optimization — it's a correctness guarantee. LLM context windows are per-call; parallel workers can't contaminate each other's context.
- **Rate limiting and exponential backoff.** Required infrastructure. The Concept Mapper used exponential backoff (1s, 2s, 4s, 8s, 16s) per worker. Without this, API rate limits cause cascading failures.
- **Checkpoint/resume architecture.** Long-running batch jobs fail. Network drops, API outages, process crashes. The pipeline must be resumable from the last successful checkpoint, not from the beginning. The Concept Mapper saved progress every 10 questions with transaction-safe file writes.
- **Worker count determined by two constraints:** (1) available cores/processes on the local machine, and (2) API rate limits from the provider. The Concept Mapper used 6 parallel workers — the practical ceiling given both constraints.

### The $15 vs $1,500 Pipeline Story (relocated from Ch 1 Hadoop aside)

This chapter gets the full engineering treatment of the cost comparison. Ch 14 handles the cost *accounting*; Ch 6 handles the engineering *decisions* that produce the cost difference. Batch design, parallel processing, and rate-limit-aware architecture are what make the $15 pipeline possible.

### Infrastructure Reinvention Problem

Every new workflow in the Concept Mapper required rebuilding the same infrastructure: rate limiting, backoff, checkpointing, parallel dispatch. The AI coding partner (Claude Code) would try to build everything from scratch each time despite being given reference implementations. It would ignore configuration files, invent model names that didn't exist, and rewrite debugged infrastructure with its own patterns. This is a real operational cost and a Ch 6/Ch 7 concern: **reusable pipeline infrastructure is an asset; rebuilding it per-workflow is the stochastic tax applied to your development process, not just your inference process.**

---

## Source Material

- `federal-survey-concept-mapper/docs/project/pipeline_documentation.md` — Appendix B (Technical Specifications), Appendix C (Key Decision Rationale)
- `federal-survey-concept-mapper/src/core/llm_categorization.py` — parallel worker implementation
- `federal-survey-concept-mapper/src/pipelines/` — pipeline orchestration code
- Session 6 conversation notes (parallelization discussion, AI partner fighting patterns)

---

## Additional Material (Session 7)

### Rob Pike's Five Rules Applied to Pipeline Design

Rob Pike's five rules from *Notes on Programming in C* (1989) map directly to LLM pipeline engineering decisions:

1. **Bottlenecks surprise you** — profile your pipeline before optimizing. The bottleneck in an LLM batch pipeline is often not where you expect (it may be JSON parsing, file I/O, or rate-limit backoff sleep time, not the LLM inference itself).
2. **Measure before tuning** — instrument first, optimize second. Matches Ch 8's evaluation-by-design thesis.
3. **Fancy algorithms are slow when N is small** — but invert for federal stats: *design as if N will be large, even when proving it small.* If the method works, N will be large. The Concept Mapper processed 7,000 questions but nothing in the pipeline is hardcoded to 7,000.
4. **Fancy = buggy** — use simple data structures. Config-driven pipelines with flat JSON schemas over clever object hierarchies.
5. **Data dominates** — get your schemas right, and the pipeline design follows. Directly connects to Ch 2's argument for adopting existing domain frameworks (DataSHaPER, Wolf et al.) as structured output schemas.

**Source:** {cite:p}`pike_1989`

### Design for Scale from Day One

The Concept Mapper was designed for N, not for 7,000. The $15 API cost scales linearly — extend to all Census demographic surveys, all federal surveys, cross-agency. The architecture holds because:
- No hardcoded batch sizes or survey-specific logic
- Parallel worker count is a configuration parameter
- Schema definitions are external to the processing code
- Checkpoint/resume works at any scale

The "onesie-twosie" trap: people who design for small problems build systems that only work small. The technology now exists to solve problems at previously infeasible scales — but only if you design the pipeline as a machine, not a one-off script.

**Source:** Author experience, Federal Survey Concept Mapper.
