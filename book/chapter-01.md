# Chapter 1: Why Design Matters

<!-- STATUS: Placeholder -->
<!-- PRIORITY: Write first — sets the frame for everything -->

## Working Notes

- The Hadoop parallel: 15 years ago, the hard part wasn't writing MapReduce jobs — it was knowing what to parallelize, where to checkpoint, how to handle failures
- Same thing now with LLMs, different constraints: stochastic outputs, rate limits, token costs, training cutoffs, context window limits
- LLM systems aren't scripts — they're distributed systems with a probabilistic component
- Design discipline isn't optional, it's the difference between $15 and $1500 for the same result
- Most people building these systems are FAFO-ing their way through it
- This book codifies the patterns from that FAFO process
- The systems engineering gap: statisticians and data scientists aren't trained in these methods, the tooling market isn't building for research workflows, and the community has to fill that gap or it won't get filled. The market is solving software development problems, not research documentation and scientific practice problems.

## Key Points to Cover

- Why "just call the API" isn't a design methodology
- The false economy of skipping design (you'll rebuild it anyway)
- What changes when your processing node is stochastic
- The design methodology gap: nobody teaches this
- Relationship to ai4stats: that book is "what AI is," this book is "how to build with it"

## Tenets & Working Principles (introduce here)

This chapter introduces both layers of the book's organizing framework:

**Compressed Tenets** — "the principles this book operationalizes." Strategic alignment for what matters.

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

**Working Principles** — "the practitioner rules that guide design decisions." How to act.

1. If it cannot be explained, do not use it
2. Slow governance prevents delivery
3. Adoption determines impact
4. Build lineage before scale
5. Reuse data before collecting more
6. Access defines capability
7. Security is a system property
8. Outputs require full provenance

Frame the relationship: **tenets = what matters, principles = how to act.** These are not aspirational — they emerged from doing the work. Each subsequent chapter maps to the principles it operationalizes.
