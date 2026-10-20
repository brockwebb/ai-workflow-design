# CC Task: Draft Chapter 7 — Checkpoints, Failures, and Recovery

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Target file:** `book/chapter-07.md`
**Type:** Full chapter draft (replace placeholder content)
**Session:** 9

---

## Overview

Draft Chapter 7 as a complete chapter following the project's pedagogical pattern (opening hook, core content, distributed reflection prompts, thought experiment, chapter bridge). This chapter is about designing pipelines that survive failure — config-driven architecture, progressive test infrastructure, checkpoint/recovery, and the recursive problem of building with stochastic tools.

Ch 6 ends with the bridge: "what happens when something fails at record 30,000 of 50,000?" This chapter answers that question and broadens it.

**Primary Working Principle:** Build lineage before scale
**Primary Tenet:** Experiment under control

---

## Chapter Architecture

### 1. Opening Hook: Everything Fails

**Theme:** Your pipeline will fail. The network will drop. The API will return an error. The provider will update the model under you. Your coding assistant will ignore your config file and hardcode a parameter the target model doesn't accept, and the pipeline will fail silently. The question is never "will something go wrong?" The question is: "when something goes wrong, does the system recover gracefully, or do you start over from scratch?"

**Tone:** Practitioner voice, grounded in operational reality. The audience has experienced pipeline failures — connect to that immediately. No abstraction, no theory-first. Start from the break and work toward the engineering discipline that prevents the next one.

### 2. Config-Driven Architecture: You Already Know This

**Theme:** This is reproducible research discipline applied to LLM pipelines. The audience already knows the principle from modeling and simulation: save the random seed, never hardcode parameters, put all configurable values in a config file so settings are transparent, auditable, and modifiable without touching source code.

**Key points:**

**Never hardcode. Ever.** All parameters that can be configured belong in a configuration file: model names, API endpoints, temperature and other model-specific parameters, batch sizes, worker counts, retry limits, checkpoint intervals. The config file makes the settings visible, the ranges clear, and modifications trackable.

**The connection to reproducible research.** In modeling and simulation, saving the random number seed is standard practice. The same principle applies here, extended to every parameter that affects pipeline behavior. If you change a parameter and results change, you need to know what you changed. If results change and you didn't change anything, the config file is your first diagnostic tool — what was the setting, and did the provider change something on their end?

**Model parameters have a shelf life.** Different models expose different tunable parameters — temperature, top-p, frequency penalty, etc. Practitioners should understand what parameters are available for their chosen model and what they control. But those parameters can disappear between model versions. Example: temperature was a standard parameter in earlier GPT generations; when OpenAI moved to GPT-5, the temperature setting was removed. Practitioners who had invested time finding optimal temperature settings for specific tasks had that work invalidated by a model version change. The parameter interface itself has a shelf life.

**The temperature tradeoff as bias-variance.** Temperature (or "creativity" in some interfaces) controls output variance. High temperature produces more diverse outputs — potential for creative connections and useful leaps, but also higher error rates. Low temperature (or zero) produces more deterministic, conservative outputs — safer for structured research tasks, but potentially missing useful patterns. This is the Type I / Type II error tradeoff that statisticians already understand: you're trading sensitivity for specificity. The right setting depends on the task. The point is that this is a real engineering tradeoff, not a magic number — and it belongs in configuration where it's visible, adjustable, and documented.

**Training cutoff contamination is a distinct failure mode.** The AI coding assistant's knowledge of available models and APIs is frozen at its training cutoff. It suggests deprecated models, uses outdated API signatures, hallucinates model names that don't exist. You can use services (MCP, tool calls) to inject current context about what's available, but the model may still resist — it "doesn't know if this is going to work." Grounding a model past its training cutoff is genuinely hard. The config file becomes an enforcement mechanism, not a suggestion: you don't ask the model what to use, you tell it via configuration, and you validate that it actually used what you told it to use.

**The silent failure story.** The author experienced silent pipeline failures caused by the AI coding assistant hardcoding model parameters that conflicted with the configuration file. The coding assistant injected parameters the target model didn't accept, or substituted model names from its training data that didn't match the configured model. The API didn't throw a hard error — it silently misbehaved. Troubleshooting these failures required working backwards from unexpected results to find the parameter mismatch. A runtime validation check — "are the parameters I'm about to send actually accepted by this model? Does the model name match the config?" — would have caught it immediately.

**Config-driven as defense against development-time drift.** From the bone drop: config-driven architecture is a defense against both runtime failures AND development-time drift. If model names, endpoints, and pipeline parameters live in configuration, the AI coding partner can't hardcode them — or at least the hardcoding is immediately visible as a deviation from the config. Reference implementations need to be more than documentation — they need to be importable modules that the AI partner is directed to use, not "look at this example and do something similar."

**Reflection prompt (after this section):** *Look at a pipeline you've built or are building. How many parameters are hardcoded in the source? If a model name or API endpoint changed tomorrow, how many files would you need to edit?*

### 3. Progressive Test Infrastructure: Build the Test Bench as You Go

**Theme:** Testing is not a phase after development. It's infrastructure you build alongside the pipeline, incrementally. This is the NIST AI RMF's Test, Evaluation, Verification, and Validation (TEVV) {cite:p}`nist_ai_rmf_2023` operationalized — continuous, not a gate at the end.

**Define terms for the audience.** The audience is statisticians and data scientists, not software engineers. They need clear, brief definitions:

- **Unit test:** A small, isolated check that one specific thing works. "Does my JSON parser handle the model's output format correctly?" "Does the confidence score extractor return a float between 0 and 1?" One function, one check, pass or fail.

- **Smoke test:** A quick sanity check before committing to the full run. Run 10 API calls before launching 50,000. Does the model respond? Does the output format match what you expect? Are the parameters accepted? Think of it as "turn the key and see if the engine starts" before driving across the country.

- **Regression test:** An automated check that re-runs your test suite after any change to see if something broke. You had 47 passing tests yesterday, you changed the model config today, now 3 tests fail — something in the change broke something that was working. The regression test catches it before the broken pipeline processes 50,000 records.

**Concrete examples that earn their place:**
- Validate the model name against the config before any API calls fire
- Validate that parameters being sent are accepted by the target model (prevent the silent failure scenario from Section 2)
- Run a small batch (10 items) as a smoke test before launching the full run
- Compare smoke test output format against the expected schema
- Automated test suites that run on any config change to catch silent breakage

**The argument for automation.** If you're manually inspecting pipeline outputs, you're slow, inconsistent, and you'll miss things. If the checks are automated, they run the same way every time, and deviations surface immediately. You don't want to validate and inspect everything yourself — that takes enormous time and doesn't scale. Automating the process makes it consistent and gives you a better chance of catching drift in the system or system state.

**Connect forward:** Automated checks are how you catch drift — which is why you'll need tools that help you maintain system state or detect deviations. Ch 9 (State, Drift, Validity) and Ch 10 (State Management) treat this in depth.

**Don't go too deep.** Acknowledge that this is software engineering practice and the audience may not come from that background. They need just enough to understand why it matters and how to apply it. The goal is not to teach software testing methodology — it's to convince practitioners that a small investment in test infrastructure prevents large downstream failures, and to give them the vocabulary to work with software engineers who do know this domain.

**Reflection prompt (after this section):** *You update your pipeline's model configuration from Model A to Model B. What's the minimum set of checks you'd run before processing your full dataset? How long would those checks take versus the time you'd lose troubleshooting a silent failure at record 40,000?*

### 4. Error Classification and Retry Logic

**Theme:** Not all errors are the same. Your pipeline's response to a failure should depend on what kind of failure it is.

**Three categories:**

- **Transient errors — retry.** API rate limit hit, network timeout, temporary server error (HTTP 429, 503). These resolve themselves. Exponential backoff with jitter (introduced in Ch 6) is the standard response. Set a maximum retry count to avoid infinite loops.

- **Permanent errors — escalate.** Invalid API key, model deprecated, endpoint removed, malformed request that will never succeed. Retrying is pointless. Log the error with full context, stop the affected batch, alert the operator. Don't burn API credits retrying something that will never work.

- **Data errors — log and continue.** The input is malformed, the model returns an unparseable response, the structured output doesn't match the expected schema. Log the failure with the input that caused it, skip the record, continue processing. These are quality signals — they tell you something about your data or your prompt, not about the infrastructure. Review them in batch after the run completes.

**The key design decision:** The pipeline should classify each error and respond appropriately, not treat all failures the same way. A pipeline that retries permanent errors wastes resources. A pipeline that stops on data errors never finishes. A pipeline that ignores transient errors produces incomplete results.

**Idempotent operations.** An operation is idempotent if running it twice produces the same result as running it once. For LLM pipelines, this means: if a batch is retried after a transient failure, it should not produce duplicate results, corrupt state, or double-count records. Design your write operations (saving results, updating checkpoints) so that re-execution is safe.

### 5. Checkpoint/Recovery Architecture

**Theme:** Long-running batch jobs fail. The engineering question is whether they recover gracefully.

Ch 6 introduced the requirement — the Concept Mapper saved progress every 10 questions with transaction-safe file writes. This section provides the full architectural treatment.

**Checkpoint granularity.** How often do you save state? Every record is expensive (I/O overhead). Every 1,000 records means losing up to 999 records of work on failure. The right interval depends on how expensive each record is to process and how often failures occur. For the Concept Mapper's dual-model classification at ~$0.002 per question, losing 10 questions of work (2 cents) was acceptable. For a pipeline processing expensive documents at $0.50 each, checkpoint every record.

**What to checkpoint.** At minimum: which records have been successfully processed, the results for those records, and enough state to resume from the next unprocessed record. The checkpoint file is a recovery contract — it tells the pipeline exactly where to pick up.

**Transaction-safe writes.** Write the new checkpoint to a temporary file, then atomically rename it to the checkpoint file. If the process crashes mid-write, the old checkpoint is still intact. Never write directly to the checkpoint file — a crash during write corrupts it and you lose everything.

**Resume logic.** On startup, the pipeline checks for an existing checkpoint. If found: load it, determine what's already done, continue from where it stopped. If not found: start from the beginning. This should be automatic, not a manual decision.

**Connect back to Ch 6:** Parallel workers each maintain their own checkpoint. If one worker's batch fails, only that worker restarts — the other workers' completed work is preserved. This is the answer to Ch 6's reflection prompt: "does the whole pipeline restart, or just that worker's batch?"

### 6. The Recursive Problem: Your Development Tools Are Also Stochastic

**Theme:** You're designing systems to manage LLM stochasticity using tools that are themselves stochastic. The engineering discipline required to build reliable LLM pipelines is the same discipline required to work with LLM coding assistants. The book's thesis applies recursively.

**The meta-problem (from bone drop).** When using LLMs (Claude Code, Copilot, etc.) to build LLM pipelines:
- The coding assistant ignores configuration files and hardcodes values from its training data
- It reinvents debugged infrastructure from scratch, introducing bugs you already fixed
- Its knowledge is frozen at its training cutoff — suggesting deprecated models, outdated API signatures, nonexistent model names
- Each new session starts fresh; architectural decisions from previous sessions are lost (pattern drift across sessions)

**Empirical evidence: SWE-CI.** {cite:t}`chen_2026_sweci` evaluated AI coding agents on long-term codebase maintenance — 100 tasks, each spanning an average of 233 days and 71 consecutive commits in real Python repositories. Key finding: 75% of frontier models break previously working features during maintenance. The agents produce quick fixes early but create mounting technical debt. The EvoScore metric, which weights later iterations more heavily, exposes this pattern: initial pass rates look acceptable, but accumulated regressions degrade the codebase over time.

**The implication for this chapter.** Your pipeline's checkpoint/recovery architecture must survive not just runtime failures (API outages, rate limits) but also development-time regressions introduced by AI coding assistants. The config-driven architecture from Section 2, the progressive test infrastructure from Section 3, and the checkpoint/recovery patterns from Section 5 all apply to the development process, not just the production pipeline. Your regression tests catch breakage whether it's caused by a provider change or by your coding assistant rewriting something it shouldn't have touched.

**Keep this section focused.** State the problem, provide the SWE-CI evidence, draw the connection. Don't turn it into a separate chapter on AI-assisted development — Ch 11 owns the full treatment of the development toolchain as part of the workflow architecture.

### 7. Thought Experiment

Your pipeline has been running in production for four months, processing 5,000 records weekly. You get a Monday morning alert: the weekend batch produced 5,000 results, zero errors, but spot-checking reveals that 30% of classifications have shifted categories compared to the same records processed three months ago. Your config file hasn't changed. Your code hasn't changed. Your data format hasn't changed. What happened? Where do you start looking? What infrastructure from this chapter would have caught it earlier?

*(This connects forward to Ch 9 on drift and validity — the answer involves model updates, training data changes, or silent API behavior changes that your pipeline's current monitoring doesn't detect.)*

### 8. Chapter Bridge

Config-driven architecture, progressive testing, and checkpoint/recovery make pipelines survivable. But survivable is not the same as valid. A pipeline can recover perfectly from every failure and still produce results that drift quietly over time — because the model changed, because the data changed, or because the accumulation of small shifts has moved your outputs away from where they started. Designing systems that detect this drift — that know when their own instrument has changed — is the subject of Chapters 9 and 10.

---

## BibTeX Entries

All citations used in this chapter are already in `book/references.bib`:
- `nist_ai_rmf_2023` — NIST AI RMF 1.0 (TEVV framework)
- `chen_2026_sweci` — SWE-CI benchmark (75% regression rate)
- `pike_1989` — Referenced via back-reference to Ch 6, not directly cited again
- `webb_2026_concept_mapper` — Concept Mapper checkpoint/resume details

**No new BibTeX entries required.**

---

## Cross-References Required

- Back references to Ch 1 (stochastic tax, evaluation trap), Ch 2 (Concept Mapper case study details), Ch 5 (ensemble patterns), Ch 6 (parallel architecture, rate limiting, batch design — Ch 7 continues directly from Ch 6's bridge)
- Forward references to Ch 8 (evaluation by design — measurement infrastructure), Ch 9 (state, drift, validity — the thought experiment bridges directly here), Ch 10 (state management and provenance), Ch 11 (development toolchain as part of workflow architecture — the recursive stochasticity problem gets full treatment there)

---

## What This Chapter Does NOT Cover

- **Parallel architecture and batch design** → Ch 6 (already covered)
- **Evaluation metrics and measurement** → Ch 8
- **Drift detection and validity** → Ch 9
- **State management and provenance tracking** → Ch 10
- **Development toolchain as workflow architecture** → Ch 11 (recursive stochasticity gets full treatment)
- **Cost accounting** → Ch 14
- **Software testing methodology in depth** → out of scope for this book. Provide just enough for the practitioner audience.

---

## Style and Tone Notes

- Follow the pedagogical pattern established in Ch 2 and continued in Ch 6.
- Direct, practitioner voice. This chapter is about operational discipline.
- Define software engineering terms (unit test, smoke test, regression test) briefly and clearly. The audience knows statistics; they may not know software engineering vocabulary.
- Connect to what the audience already knows: reproducible research, random seeds, parameter documentation. This isn't new — it's the same discipline applied to a new context.
- The silent failure story and the SWE-CI evidence are the two strongest motivators. Use them to ground the argument in real consequences, not abstract principles.
- Don't over-lecture on software engineering. The audience needs just enough to understand why these practices matter and to work productively with software engineers who have deeper expertise.

---

## Execution Notes

1. Replace all content in `book/chapter-07.md` (current content is a placeholder with working notes).
2. No new BibTeX entries required — all citations are already in `book/references.bib`.
3. All citations use `{cite:t}` (narrative) or `{cite:p}` (parenthetical) roles — no bare prose citations.
4. Run `seldon verify --fix` after execution.
