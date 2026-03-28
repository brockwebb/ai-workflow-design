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

## Key Points to Cover

- Why "just call the API" isn't a design methodology
- The false economy of skipping design (you'll rebuild it anyway)
- What changes when your processing node is stochastic
- The design methodology gap: nobody teaches this
- Relationship to ai4stats: that book is "what AI is," this book is "how to build with it"
