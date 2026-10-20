# CC Task: Remove Hadoop Aside from Chapter 1

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** None (can execute independently, but ideally after citation conversion task)

---

## Objective

Remove the "The Hadoop Aside" section from `book/chapter-01.md`. The constraint-aware design content (latency, throughput, rate limits forcing discipline) may be reused in Chapter 6 or Chapter 11 where it has concrete anchoring. In Chapter 1, it's an analogy without an anchor.

## Changes

### 1. Remove the Hadoop section

Delete the entire section starting with `## The Hadoop Aside` through to the end of the section (just before `## The Evaluation Trap`). This includes the heading and all three paragraphs:

```markdown
## The Hadoop Aside

There is a useful historical parallel in the Hadoop era. Fifteen years ago, the hard part of big data wasn't writing MapReduce jobs. It was knowing what to parallelize, where to checkpoint, and how to handle failures. The technology was accessible before the design patterns were codified. Physical constraints, data transport time, compute costs, cluster reliability, forced design discipline on practitioners who would have preferred to skip it.

LLM workflows face analogous constraints: token throughput, API rate limits, cost per call, context window limits, and training data cutoff dates. These are the physical realities that force design discipline. The $15 classification pipeline and the $1,500 classification pipeline that produce the same result differ not in the model they use but in whether someone designed around these constraints or ignored them.

[NEEDS: fact-check the Hadoop timeline and any specific claims before expanding. Do not assert specifics from memory.]
```

### 2. Preserve for later use

Add a note to `book/chapter-06.md` (or `book/chapter-11.md`, whichever has more relevant placeholder content) as a comment:

```markdown
<!-- RELOCATED from Chapter 1: The constraint-aware design parallel.
     Physical constraints (token throughput, rate limits, cost, context window limits)
     force design discipline, just as data transport time, compute costs, and cluster
     reliability forced design discipline in the Hadoop/MapReduce era. The $15 vs $1,500
     pipeline example belongs here where batch design and cost tradeoffs are concrete.
     See Session 4/5 handoffs for context. -->
```

## Verification

After execution:
1. `grep -c 'Hadoop' book/chapter-01.md` should return 0
2. The `[NEEDS: fact-check the Hadoop timeline]` placeholder is gone (this was the third NEEDS in Ch 1; removing it means only the two figure NEEDS remain)
3. The section flow goes directly from "What's Wrong With This Picture?" → "The Evaluation Trap"

## Notes

- The $15 vs $1,500 pipeline comparison is a strong concrete example. Don't lose it — relocate it to where cost and batch design are the actual topic.
- This removal also eliminates one `[NEEDS]` placeholder, which is a net improvement.
