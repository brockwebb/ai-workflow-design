# CC Task: Draft Chapter 6 — Parallel, Serial, and the Bottleneck

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Target file:** `book/chapter-06.md`
**Type:** Full chapter draft (replace placeholder content)
**Session:** 9

---

## Overview

Draft Chapter 6 as a complete chapter following the project's pedagogical pattern (opening hook, core content, distributed reflection prompts, thought experiment, chapter bridge). This chapter is about pipeline mechanics — parallelization, batch design, bottleneck identification, and model selection as an engineering discipline. The primary case study is the Federal Survey Concept Mapper batch pipeline.

**Primary Working Principle:** Adoption determines impact
**Primary Tenet:** Deliver capability quickly

---

## Chapter Architecture

### 1. Opening Hook: Force Multipliers Don't Care

**Theme:** LLMs have accelerated the speed at which you can create messes by orders of magnitude. These tools are force multipliers — they multiply good design and bad design equally. You can prototype a pipeline in a day. You can also scale a broken pipeline in a day. Parallelization, batching, and automation are amplifiers. The chapter's job is teaching readers how to tell the difference between amplifying a solution and amplifying a problem before they've scaled their mistakes.

**Tone:** Direct, concrete, no hypothetical dollar comparisons. Ground in the observable reality that bad pipeline design creates cascading confusion, rework, and delay — and that LLM tooling has compressed the timeline for creating those messes from months to hours.

**Do NOT use** the "$15 vs $1,500" framing anywhere in this chapter. That comparison is retired. The Concept Mapper's ~$15 API cost can be mentioned as a data point where relevant (batch processing cost), but never as an anchor for a cost comparison story. If referencing the cost, note it honestly as Ch 2 does: the API cost was ~$15; the engineering cost to design, debug, and validate the pipeline was substantially higher. Ch 14 handles full cost accounting.

### 2. The LLM as Bottleneck Node

In any processing pipeline, something is the constraint. In LLM workflows, it's usually the API call: rate limits (requests per minute, tokens per minute), latency per call, and context window size. Everything else — file I/O, JSON parsing, result aggregation — is fast by comparison.

Design around the bottleneck, not through it. This is the fundamental insight: you cannot make the LLM call faster (you don't control the provider's infrastructure), so you design the pipeline to maximize useful work within the constraints the provider imposes.

Introduce the parallel vs. serial decision as an engineering choice driven by **task independence**: Can each item be processed without knowledge of any other item's result? If yes, parallelize. If items depend on prior results, serialize. Most classification, coding, and extraction tasks are embarrassingly parallel. Generator-critic loops and multi-turn refinement are inherently serial. Know which shape your task has before designing the pipeline.

### 3. Batch Design and Parallel Architecture

Draw from the Concept Mapper bone drop. Key design properties:

**Clean process separation.** Each parallel worker processes its own batch. No shared context, no state bleeding between processes. This isn't just a performance optimization — it's a correctness guarantee. LLM context windows are per-call; parallel workers cannot contaminate each other's context. Frame this as a property that distributed systems engineers recognize immediately: embarrassingly parallel workloads are the easiest to get right, and LLM classification is naturally embarrassingly parallel.

**Rate limiting and exponential backoff.** Required infrastructure, not optional. The Concept Mapper used exponential backoff (1s, 2s, 4s, 8s, 16s) per worker. Without this, API rate limits cause cascading failures — workers hammer the rate limit, get rejected, retry immediately, get rejected again. Exponential backoff with jitter is the standard solution from distributed systems; it applies identically here.

**Checkpoint/resume architecture.** Long-running batch jobs fail. Network drops, API outages, process crashes, laptop lids closing. The pipeline must be resumable from the last successful checkpoint, not from the beginning. The Concept Mapper saved progress every 10 questions with transaction-safe file writes. Brief treatment here — state the requirement and the Concept Mapper's approach, then bridge to Ch 7 which owns the full checkpoint/recovery architecture.

**Worker count as a two-constraint optimization.** The number of parallel workers is determined by (1) available local compute (cores/processes), and (2) API rate limits from the provider. The Concept Mapper used 6 parallel workers — the practical ceiling given both constraints. This is a concrete engineering decision, not a guess. Check your provider's rate limits, check your machine's capacity, take the minimum.

**Reflection prompt (after this section):** *You're processing 50,000 records through an LLM pipeline. Your provider allows 60 requests per minute. How many parallel workers can you run? What happens when one worker's batch fails at record 3,000 — does the whole pipeline restart, or just that worker's batch?*

### 4. Model Selection as Engineering Decision, Not Research Project

This is a critical section. The argument:

**Simpler models earn their place by default.** A smaller, cheaper model is faster to process, has better (higher) rate limits because it's less resource-intensive on the provider side, and costs less per call. Unless the task demonstrably requires frontier capability — and you should need evidence, not intuition, to make that claim — the simpler model wins on every operational dimension that matters for batch processing.

**The bike-shedding trap.** People spend weeks running comparison experiments over fractional accuracy differences (2-3 percentage points) or marginal cost differences (10-15%). The engineering time burned on those experiments costs more than the difference between the models ever would at production scale. Use available benchmarks and cost tables for a quick tradeoff analysis. Make a decision. Move on.

**Connection to the evaluation trap (Ch 1).** The rate of model advancement is so fast that extended comparison experiments produce obsolete conclusions. Models update silently — baseline changes, version bumps, deprecations. New contenders enter the market. If you spend six months testing five models, those models have already changed by the time you publish results. You do not have six months. Make engineering decisions with available information and design the system to absorb change.

**The ensemble reframe kills bike-shedding.** If two models are close in performance, the correct engineering answer isn't "run more experiments to find the winner." It's "use both." Now you have disagreement detection, bias discovery, and higher composite confidence — which is worth more than the marginal performance difference you were trying to measure. Connect back to Ch 5's thesis: multi-model is the baseline, single-model needs justification. Without the second model, you're flying blind and don't know it. Weird biases, systematic blind spots — these only surface in disagreement patterns.

**Reflection prompt (after this section):** *Two models score 91% and 89% on your classification benchmark. You estimate it would take three weeks of testing to determine if the difference is meaningful. What's the engineering decision?*

### 5. Design for Change, Not for the Current Model

The model is a replaceable component. The architecture is the durable investment.

**Swap-ready interfaces.** The pipeline should call models through an abstraction layer — configuration-driven model selection, not hardcoded model names in source code. When (not if) you need to swap a model, it's a config change, not a code rewrite.

**Versioned configurations.** Every pipeline run records which model, which version, which parameters were used. This is provenance (connects to Ch 10) and it's also practical: when results change between runs, you need to know whether you changed something or the provider did.

**Design for model turnover as a normal operating condition.** This is the steady state, not an exception. Models deprecate. APIs change. New options appear. If your pipeline breaks when the model changes, you designed for a moment, not for a system.

### 6. Pike's Rules Applied to Pipeline Design

Rob Pike's five rules from *Notes on Programming in C* (1989) {cite:p}`pike_1989` map directly to LLM pipeline engineering:

1. **Bottlenecks surprise you.** Profile your pipeline before optimizing. The bottleneck may be JSON parsing, file I/O, or rate-limit backoff sleep time — not the LLM inference itself. Don't assume.

2. **Measure before tuning.** Instrument first, optimize second. This connects to Ch 8's evaluation-by-design thesis: if you aren't measuring, you're guessing.

3. **Fancy algorithms are slow when N is small — but design as if N will be large.** For federal statistics, invert Pike's caution. If the method works, it will be applied at scale. The Concept Mapper processed ~7,000 questions as a proof of concept, but nothing in the pipeline is hardcoded to 7,000. The architecture holds at 70,000 or 700,000.

4. **Fancy algorithms are buggier than simple ones.** Use simple data structures. Config-driven pipelines with flat JSON schemas over clever object hierarchies. Complexity is where bugs hide.

5. **Data dominates.** Get your schemas right and the pipeline design follows. This connects directly to Ch 2's argument for adopting existing domain frameworks (DataSHaPER, Wolf et al.) as structured output schemas rather than inventing your own.

Keep this section tight. State each rule, give the pipeline application in 2-3 sentences, move on. Pike's rules are engineering wisdom, not a lecture.

### 7. Design for Scale from Day One

**The "onesie-twosie" trap.** People who design for their current small dataset build systems that only work small. When the method proves itself and leadership says "do this for all surveys" or "do this cross-agency," the pipeline collapses because batch sizes were hardcoded, schemas were survey-specific, and the worker pool was tuned to one machine.

Design the pipeline as a machine, not a one-off script:
- No hardcoded batch sizes or dataset-specific logic
- Worker counts, schemas, model selections as configuration parameters
- Checkpoint/resume that works at any scale
- The architecture should be indifferent to whether N is 100 or 100,000

**The compounding loop.** Better pipeline infrastructure → more productive development → more time to improve infrastructure → compounding returns. Investing in reusable, well-designed batch processing infrastructure pays dividends on every subsequent workflow. The alternative — rebuilding rate limiting, backoff, checkpointing, and parallel dispatch for every new project — is a tax on every new initiative.

### 8. The Infrastructure Reinvention Problem (Brief — Bridge to Ch 7)

Every new workflow in the Concept Mapper required rebuilding the same infrastructure: rate limiting, backoff, checkpointing, parallel dispatch. The AI coding partner would rebuild from scratch despite being given reference implementations — ignoring config files, inventing nonexistent model names, rewriting debugged infrastructure with its own patterns.

This is stochastic tax applied to the development process, not just the inference process. Reusable pipeline infrastructure is an asset; rebuilding it per-workflow is waste. The solution — config-driven, importable infrastructure modules — is the subject of Ch 7.

Keep this section short (3-4 paragraphs). It introduces the problem. Ch 7 provides the architectural solution. Ch 11 zooms out to the meta-level (your development tool is itself stochastic).

### 9. Thought Experiment

Design a classification pipeline that must survive three model swaps in 18 months without architectural rework. Your provider deprecates Model A six months after launch. A new market entrant offers Model B at half the cost with comparable accuracy. Your agency's security review clears Model C but not Model B. At each transition: what changes? What doesn't? What would break in a pipeline designed around a specific model rather than around a model interface?

### 10. Chapter Bridge

Parallel pipelines create throughput. But throughput creates a new problem: what happens when something fails at record 30,000 of 50,000? Do you restart from zero? The next chapter treats checkpoints, failures, and recovery — the engineering discipline that makes long-running pipelines survivable.

---

## BibTeX Entries to Add to `book/references.bib`

```bibtex
@misc{pike_1989,
  author       = {Pike, Rob},
  title        = {Notes on Programming in {C}},
  year         = {1989},
  howpublished = {Bell Labs internal document},
  url          = {https://www.lysator.liu.se/c/pikestyle.html},
  note         = {Five rules of programming. Pike co-created Go, Plan 9, and UTF-8 with Ken Thompson.}
}
```

**Citation verification status:** URL verified in YouTube research routing doc (Session 7). Pike attribution verified — Bell Labs, co-creator of Go, Plan 9, UTF-8.

---

## Cross-References Required

- `{cite:p}`webb_2026_concept_mapper`` — Federal Survey Concept Mapper (already in references.bib)
- `{cite:p}`pike_1989`` — Pike's rules (add per above)
- Forward references to Ch 7 (checkpoint/recovery), Ch 8 (evaluation by design / measurement), Ch 9 (drift / model turnover as validity concern), Ch 10 (provenance / versioned configs), Ch 14 (cost accounting)
- Back reference to Ch 1 (evaluation trap, stochastic tax), Ch 2 (Concept Mapper case study, structured output schemas), Ch 5 (ensemble as baseline)

---

## What This Chapter Does NOT Cover

- **Full checkpoint/recovery architecture** → Ch 7
- **Cost accounting and budget justification** → Ch 14
- **Evaluation metrics and measurement infrastructure** → Ch 8
- **State management and provenance tracking** → Ch 10
- **AI coding assistant stochasticity (meta-level)** → Ch 11
- **Model drift and validity over time** → Ch 9
- **Ensemble design patterns (topology details)** → Ch 5

---

## Style and Tone Notes

- Follow the pedagogical pattern established in Ch 2: concrete opening, no appeals to authority, reflection prompts distributed inline (not boxed at end), thought experiment as provocation.
- Direct, practitioner voice. No hedging, no "it depends" without saying what it depends on.
- The audience is federal statisticians and data scientists who are building systems. They know statistics. They may not know distributed systems engineering. Meet them where they are.
- No fabricated cost comparisons. Real numbers from the Concept Mapper where available, honest caveats about what those numbers include and exclude.
- Pike's rules are stated concisely. Don't over-explain — the applications to pipeline design should be self-evident once stated.

---

## Execution Notes

1. Replace all content in `book/chapter-06.md` (current content is a placeholder with working notes and a relocation comment).
2. Add `pike_1989` BibTeX entry to `book/references.bib`.
3. All citations use `{cite:t}` (narrative) or `{cite:p}` (parenthetical) roles — no bare prose citations.
4. Run `seldon verify --fix` after execution.
