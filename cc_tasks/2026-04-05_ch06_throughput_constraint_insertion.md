# CC Task: Ch 6 -- Throughput Constraint and Local vs. API Tradeoff

**Date:** 2026-04-05
**Chapter:** chapter-06.md
**Type:** Content insertion + cross-chapter pointers in Ch 5 and Ch 14
**Priority:** HIGH (blocking Ch 9 AD-020 progression)
**Depends on:** None
**Blocks:** Ch 9 AD-020 pipeline

---

## Constraint

**Zero em dashes anywhere in new content.** Use commas, semicolons, colons, parentheses, or separate sentences instead.

---

## Objective

Expand the "The LLM as Bottleneck Node" section in Ch 6 with the throughput constraint ladder and the local vs. API design tradeoff. Add brief cross-reference pointers in Ch 5 and Ch 14.

---

## Part 1: Ch 6 Insertion

### Insertion Point

In section "## The LLM as Bottleneck Node" (currently starting at line 13), insert new content **after** the existing paragraph ending:

> "Know which shape your task has before designing the pipeline. Getting this wrong in either direction costs you: parallelizing a serial task produces incorrect results; serializing a parallel task wastes time you did not need to spend."

And **before** the section "## Batch Design and Parallel Architecture" (currently starting at line 27).

### Content to Insert

Draft prose (refine for voice consistency with surrounding text):

---

### The Throughput Ladder

The bottleneck has layers. At the base: tokens per second, the raw speed at which the model processes input and generates output. Above that: rate limits, the provider's constraints on how many calls per hour or tokens per minute your account is allowed. Above that: cost, the financial constraint on total processing volume. Each layer constrains the one above it, and the binding constraint shifts depending on your deployment model.

On a frontier API (OpenAI, Anthropic, Google), tokens per second is fast. The binding constraint is almost always rate limits: requests per minute, tokens per minute, or concurrent connections. You design around rate limits by parallelizing across workers (covered in the next section), batching requests efficiently, and in some cases distributing load across multiple API keys or accounts. The cost constraint sits above rate limits: you can usually buy higher rate limits or use multiple accounts, but the total token cost accumulates. For most research workloads at federal statistical agencies, the API cost for a well-designed pipeline is modest. The Concept Mapper processed 6,954 questions through a dual-model pipeline for under $100 total API cost {cite:p}`webb_2026_concept_mapper`.

Running locally changes which constraint binds. If you run a quantized model on CPU, tokens per second drops by one to two orders of magnitude compared to a frontier API. A classification job that takes 30 minutes on an API might take 20 hours on local CPU inference. GPU inference narrows the gap but introduces hardware procurement, driver maintenance, and capacity planning overhead. Fine-tuned local models can match frontier quality on narrow tasks, but they require training infrastructure and ongoing maintenance as the task evolves.

The practical question is not "which is cheaper per token?" It is "which is cheaper per hour of the practitioner's time?" A $100 API run that completes in 30 minutes costs less than a free local run that takes 20 hours, because the practitioner's weekend has value and the 20-hour run still needs monitoring, error handling, and restart management. For a survey classification task at scale (10,000 to 100,000 entries), the frontier API is almost always the correct choice unless data sensitivity prohibits sending content to an external provider.

When data sensitivity is the binding constraint, the calculus changes. Some federal data cannot leave agency infrastructure under any circumstances. In those cases, local inference is not a cost optimization; it is a compliance requirement. The throughput penalty is real and must be planned for: longer runtimes, smaller batch sizes, and more aggressive checkpoint intervals (Chapter 7). The design discipline does not change; the timeline does.

The real engineering problem at scale is not choosing between local and API. It is maximizing throughput within whatever constraint binds. On an API, that means parallel workers up to the rate limit, efficient batching to minimize overhead per call, and retry logic that does not waste rate limit budget on avoidable failures. Locally, it means optimizing batch size for available memory, using the largest model that fits your hardware at acceptable speed, and accepting that some jobs will run overnight or over a weekend. In both cases, the pipeline architecture from the next section applies identically. Only the numbers change.

> *Your agency needs to classify 100,000 survey responses. On a frontier API with your current rate limits, the job takes 4 hours and costs $150. On your agency's internal GPU server running a quantized model, the job takes 36 hours and costs nothing in API fees but requires someone to monitor and restart on failures. A third option: negotiate higher API rate limits, which cuts the API job to 90 minutes but requires procurement approval. Which constraints are binding in each scenario, and how does the choice change if the survey data contains PII that cannot leave agency infrastructure?*

---

## Part 2: Ch 5 Cross-Reference

In Chapter 5 (chapter-05.md), find the section that discusses multi-model architecture choices or ensemble cost considerations. Insert a brief pointer (1-2 sentences):

**Search for:** Content discussing cost tradeoffs, model selection for ensembles, or computational overhead of running multiple models.

**Insert (adapt to surrounding context):**

> The throughput cost of a multi-model architecture is real: a dual-model pipeline with arbitration requires roughly twice the API calls of a single-model pipeline. Chapter 6 covers the throughput constraint ladder and the local-versus-API tradeoff that determines whether this overhead is acceptable at your scale.

If no natural insertion point exists in Ch 5, skip this part and note it for the Ch 5 AD-020 revision pass.

## Part 3: Ch 14 Cross-Reference

In Chapter 14 (chapter-14.md), find the section that discusses cost accounting or the economics of running LLM workflows. Insert a brief pointer (1-2 sentences):

**Search for:** Content discussing per-token costs, total cost of ownership, or the $15 per-run inference cost.

**Insert (adapt to surrounding context):**

> Token cost is not the only cost. The time cost of a 20-hour local inference run and the human attention cost of monitoring it are part of the total cost of ownership. Chapter 6 covers the throughput constraint ladder that determines when local inference is a false economy and when it is a compliance necessity.

If no natural insertion point exists in Ch 14, skip this part and note it for the Ch 14 AD-020 revision pass.

---

## Verification

After all edits, run:

```bash
grep -n '\-\-\|—' book/chapter-06.md | head -20
```

Confirm zero em dashes in new content. (Existing content may have em dashes from prior drafts; only verify the new insertion is clean.)

Also verify the reflection prompt is properly formatted as a blockquote with italics.

Run `seldon verify --fix` after all edits.

---

## Acceptance Criteria

1. New throughput ladder content inserted in Ch 6 at specified location
2. Reflection prompt included with the local/API/procurement scenario
3. Cross-reference pointer in Ch 5 (or noted as deferred)
4. Cross-reference pointer in Ch 14 (or noted as deferred)
5. Zero em dashes in new content
6. Voice consistent with surrounding Ch 6 prose (direct, concrete, engineering-focused)
7. `seldon verify --fix` passes
