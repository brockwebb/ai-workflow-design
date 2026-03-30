# Chapter 6: Parallel, Serial, and the Bottleneck

<!-- STATUS: Placeholder -->
<!-- RELOCATED from Chapter 1: The constraint-aware design parallel.
     Physical constraints (token throughput, rate limits, cost, context window limits)
     force design discipline, just as data transport time, compute costs, and cluster
     reliability forced design discipline in the Hadoop/MapReduce era. The $15 vs $1,500
     pipeline example belongs here where batch design and cost tradeoffs are concrete.
     See Session 4/5 handoffs for context. -->

## Working Notes

- The Hadoop parallel: what's parallel, what's serial, where's the bottleneck
- LLM as the bottleneck node — designing around it
- Rate limits, latency, token throughput
- Batch design: chunk size, queue management, progress tracking
- The $15 vs $1500 lesson: design determines cost, not model choice
- When to parallelize API calls vs when serial is safer
