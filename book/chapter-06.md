# Chapter 6: Parallel, Serial, and the Bottleneck

<!-- STATUS: Draft -->
<!-- Primary Working Principle: Adoption determines impact -->
<!-- Primary Tenet: Deliver capability quickly -->

## Force Multipliers Don't Care

Large language models have accelerated the speed at which you can create messes by orders of magnitude. A pipeline that took months to prototype now takes a day. A classification system that required a team now takes one person with an API key. These tools are force multipliers, and force multipliers do not care what they multiply. They amplify good design and bad design equally.

You can prototype a pipeline in a day. You can also scale a broken pipeline in a day. Parallelization, batching, and automation are amplifiers. Before you reach for them, you need to know whether you are amplifying a solution or amplifying a problem. This chapter teaches the engineering discipline that makes the difference: how to design pipelines that run fast, fail gracefully, and survive the model changes that are coming whether you plan for them or not.

## The LLM as Bottleneck Node

In any processing pipeline, something is the constraint. In LLM workflows, it is almost always the API call: rate limits (requests per minute, tokens per minute), latency per call, and context window size. Everything else, file I/O, JSON parsing, result aggregation, is fast by comparison.

You cannot make the LLM call faster. You do not control the provider's infrastructure. You design the pipeline to maximize useful work within the constraints the provider imposes. This is the fundamental insight of this chapter: design around the bottleneck, not through it.

The first decision is whether your task is parallel or serial. The question is task independence: can each item be processed without knowledge of any other item's result?

If yes, parallelize. Most classification, coding, and extraction tasks are embarrassingly parallel. Each record is independent. The model does not need to know what it said about the previous record to classify the current one. Send them all at once, up to your rate limit.

If items depend on prior results, serialize. Generator-critic loops (Chapter 5) are inherently serial: the critic's output feeds back to the generator. Multi-turn refinement requires sequential processing. Arbitration that references prior judgments has ordering constraints.

Know which shape your task has before designing the pipeline. Getting this wrong in either direction costs you: parallelizing a serial task produces incorrect results; serializing a parallel task wastes time you did not need to spend.

## Batch Design and Parallel Architecture

The Federal Survey Concept Mapper {cite:p}`webb_2026_concept_mapper` classified 6,954 survey questions through a dual-model pipeline using parallel batch processing. The design properties that made this work are general.

**Clean process separation.** Each parallel worker processes its own batch. No shared context, no state bleeding between processes. This is not just a performance optimization; it is a correctness guarantee. LLM context windows are per-call. Parallel workers cannot contaminate each other's context. Distributed systems engineers recognize this immediately: embarrassingly parallel workloads are the easiest to get right, and LLM classification is naturally embarrassingly parallel.

**Rate limiting and exponential backoff.** This is required infrastructure, not optional. The Concept Mapper used exponential backoff (1s, 2s, 4s, 8s, 16s) per worker. Without it, API rate limits cause cascading failures: workers hammer the rate limit, get rejected, retry immediately, get rejected again, and the pipeline grinds to a halt. Exponential backoff with jitter is the standard solution from distributed systems engineering. It applies identically here.

**Checkpoint and resume architecture.** Long-running batch jobs fail. Network drops, API outages, process crashes, laptop lids closing. The pipeline must be resumable from the last successful checkpoint, not from the beginning. The Concept Mapper saved progress every 10 questions with transaction-safe file writes. This section states the requirement; Chapter 7 owns the full checkpoint and recovery architecture.

**Worker count as a two-constraint optimization.** The number of parallel workers is determined by two constraints: available local compute (cores and processes) and API rate limits from the provider. The Concept Mapper used 6 parallel workers, the practical ceiling given both constraints. This is a concrete engineering decision, not a guess. Check your provider's rate limits, check your machine's capacity, take the minimum.

> *You are processing 50,000 records through an LLM pipeline. Your provider allows 60 requests per minute. How many parallel workers can you run? What happens when one worker's batch fails at record 3,000: does the whole pipeline restart, or just that worker's batch?*

## Model Selection as Engineering Decision

People spend weeks running comparison experiments over fractional accuracy differences between models. This is the bike-shedding trap applied to AI: burning engineering time on decisions that matter less than the time spent making them.

**Simpler models earn their place by default.** A smaller, cheaper model is faster to process, has higher rate limits (less resource-intensive on the provider side), and costs less per call. Unless the task demonstrably requires frontier capability, and you should need evidence rather than intuition to make that claim, the simpler model wins on every operational dimension that matters for batch processing.

The engineering time burned on marginal comparison experiments (2-3 percentage points of accuracy, 10-15% cost differences) typically costs more than the difference between the models ever would at production scale. Use available benchmarks and cost tables for a quick tradeoff analysis. Make a decision. Move on.

This connects to the evaluation trap from Chapter 1. The rate of model advancement is so fast that extended comparison experiments produce obsolete conclusions. Models update silently. New contenders enter the market. If you spend six months testing five models, those models have already changed by the time you publish results. You do not have six months. Make engineering decisions with available information and design the system to absorb change.

**The ensemble reframe kills bike-shedding.** If two models are close in performance, the correct engineering answer is not "run more experiments to find the winner." It is "use both." Now you have disagreement detection, systematic bias discovery, and higher composite confidence, which is worth more than the marginal performance difference you were trying to measure. Without the second model, weird biases and systematic blind spots remain invisible. They only surface in disagreement patterns. This connects back to Chapter 5's thesis: multi-model is the baseline, single-model needs justification.

> *Two models score 91% and 89% on your classification benchmark. You estimate it would take three weeks of testing to determine if the difference is meaningful. What is the engineering decision?*

## Design for Change, Not for the Current Model

The model is a replaceable component. The architecture is the durable investment.

**Swap-ready interfaces.** The pipeline should call models through an abstraction layer: configuration-driven model selection, not hardcoded model names in source code. When you need to swap a model (and you will), it is a config change, not a code rewrite.

**Versioned configurations.** Every pipeline run records which model, which version, which parameters were used. This is provenance (connects to Chapter 10) and it is also practical: when results change between runs, you need to know whether you changed something or the provider did.

**Model turnover is the steady state.** Models deprecate. APIs change. New options appear. Pricing shifts. If your pipeline breaks when the model changes, you designed for a moment, not for a system. Design for model turnover as a normal operating condition, not as an exception.

## Pike's Rules Applied to Pipeline Design

Rob Pike's five rules from *Notes on Programming in C* {cite:p}`pike_1989` are engineering wisdom that maps directly to LLM pipeline design:

**Bottlenecks surprise you.** Profile your pipeline before optimizing. The bottleneck may be JSON parsing, file I/O, or rate-limit backoff sleep time, not the LLM inference itself. Do not assume.

**Measure before tuning.** Instrument first, optimize second. If you are not measuring, you are guessing. This connects to Chapter 8's evaluation-by-design thesis.

**Fancy algorithms are slow when N is small, but design as if N will be large.** For federal statistics, invert Pike's caution. If the method works, it will be applied at scale. The Concept Mapper processed approximately 7,000 questions as a proof of concept, but nothing in the pipeline is hardcoded to 7,000. The architecture holds at 70,000 or 700,000.

**Fancy algorithms are buggier than simple ones.** Use simple data structures. Config-driven pipelines with flat JSON schemas over clever object hierarchies. Complexity is where bugs hide.

**Data dominates.** Get your schemas right and the pipeline design follows. This connects directly to Chapter 2's argument for adopting existing domain frameworks {cite:p}`fortier_2011;wolf_2016` as structured output schemas rather than inventing your own.

## Design for Scale from Day One

People who design for their current small dataset build systems that only work small. When the method proves itself and leadership says "do this for all surveys" or "do this cross-agency," the pipeline collapses because batch sizes were hardcoded, schemas were dataset-specific, and the worker pool was tuned to one machine.

Design the pipeline as a machine, not a one-off script. No hardcoded batch sizes or dataset-specific logic. Worker counts, schemas, and model selections as configuration parameters. Checkpoint and resume that works at any scale. The architecture should be indifferent to whether N is 100 or 100,000.

**The compounding loop.** Better pipeline infrastructure produces more productive development, which frees time to improve infrastructure, which compounds. Investing in reusable, well-designed batch processing infrastructure pays dividends on every subsequent workflow. The alternative, rebuilding rate limiting, backoff, checkpointing, and parallel dispatch for every new project, is a tax on every new initiative.

## The Infrastructure Reinvention Problem

Every new workflow in the Concept Mapper required rebuilding the same infrastructure: rate limiting, backoff, checkpointing, parallel dispatch. The AI coding partner would rebuild from scratch despite being given reference implementations, ignoring configuration files, inventing nonexistent model names, rewriting debugged infrastructure with its own patterns.

This is the stochastic tax applied to the development process, not just the inference process. Your development tool is itself stochastic, and it introduces its own variance into the infrastructure it builds. Reusable pipeline infrastructure is an asset. Rebuilding it per-workflow is waste.

The solution is config-driven, importable infrastructure modules: rate limiting, backoff, checkpointing, and parallel dispatch as shared components, not as code that gets rewritten for every project. Chapter 7 provides the architectural pattern. Chapter 11 addresses the meta-level challenge: when your development tool is itself an LLM, the infrastructure reinvention problem is a structural feature of the development process, not a one-time mistake.

### Thought Experiment

Design a classification pipeline that must survive three model swaps in 18 months without architectural rework. Your provider deprecates Model A six months after launch. A new market entrant offers Model B at half the cost with comparable accuracy. Your agency's security review clears Model C but not Model B.

At each transition: what changes? What does not? What would break in a pipeline designed around a specific model rather than around a model interface?

---

Parallel pipelines create throughput. But throughput creates a new problem: what happens when something fails at record 30,000 of 50,000? Do you restart from zero? Chapter 7 treats checkpoints, failures, and recovery: the engineering discipline that makes long-running pipelines survivable.
