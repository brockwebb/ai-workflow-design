# CC Task: Draft Chapter 9 — State, Drift, and Validity

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Target file:** `book/chapter-09.md`
**Type:** Full chapter draft (replace placeholder content)
**Session:** 9

---

## Overview

Draft Chapter 9 as a complete chapter following the project's pedagogical pattern (opening hook, core content, distributed reflection prompts, thought experiment, chapter bridge). This chapter introduces State Fidelity Validity (SFV) as the framework for understanding why LLM pipeline outputs can drift, degrade, and silently invalidate themselves — and what to design against.

**This is the book's most important intellectual contribution.** SFV is the author's original framework. Handle with care. The terminology is canonical and locked — all terms must match `seldon/ontology/validity/VALIDITY_VOCABULARY.md` exactly. Do not invent synonyms, do not simplify names, do not redefine sub-dimensions or threats.

**This chapter is NOT a reprint of ai4stats Ch 20.** The ai4stats chapter introduced SFV as a formal validity argument. This chapter teaches practitioners how SFV applies to the workflow design decisions they've been learning throughout this book. It connects backwards to everything (config-driven architecture, evaluation by design, checkpoint/recovery, ensemble patterns) and forward to Ch 10 (state management as the operational answer).

**Primary Working Principle:** Outputs require full provenance
**Primary Tenet:** Trust defines the mission

---

## Critical Constraints

1. **SFV terminology is LOCKED.** "State Fidelity Validity" is the only canonical name. Sub-dimensions (TC, SP, CF, SC, SCoh), threats (T1–T5), and severity scale are defined in `seldon/ontology/validity/VALIDITY_VOCABULARY.md`. Use those definitions. Do not paraphrase, simplify, or rename them.

2. **Reference the canonical vocabulary, don't copy it.** This chapter applies SFV; it does not re-derive it. The formal definitions live in the vocabulary document and in {cite:t}`webb_2026_ai4stats` Chapter 20. This chapter should introduce terms with enough context for the reader to understand and apply them, then cite the canonical source for the full treatment.

3. **The prose voice matters.** The ai4stats SFV chapter was flagged as having the most distinctive voice in that book — measured, precise, with personality. This chapter should have that same quality: rigorous but not dry, with a clear sense of what's at stake.

4. **"Confabulation" not "hallucination."** Per the vocabulary and NIST AI 600-1. Use "confabulation" throughout. If "hallucination" is mentioned at all, it's only to note that it's the colloquial term being replaced.

---

## Chapter Architecture

### 1. Opening Hook: The Instrument That Changes Itself

**Theme:** In classical measurement, the instrument is stable. A thermometer doesn't redefine "degree" mid-measurement. A survey question doesn't rewrite itself between respondents. But in an LLM-powered pipeline, the instrument — the composite of fixed model weights and mutable context window — changes during use. The context window accumulates decisions, terminology, and intermediate results. When that accumulated state degrades, the instrument silently becomes a different instrument. Your pipeline can recover from every crash, pass every checkpoint, produce beautiful output files — and still be measuring the wrong thing.

**Connect to Ch 7's thought experiment:** This is the answer to "your config hasn't changed, your code hasn't changed, your data format hasn't changed — but 30% of classifications shifted." The model updated. Or the context drifted. Or accumulated state from earlier processing contaminated later processing. The instrument changed.

### 2. State Fidelity Validity: The Framework

**Introduce SFV concisely.** Don't reproduce the full formal derivation from ai4stats. State the core definition from the vocabulary:

> The degree to which an AI-assisted research or analytic pipeline preserves the accuracy and integrity of its accumulated internal state across sequential operations, such that inferences at step N remain warranted by the actual history of steps 1 through N-1.

**The key insight:** This is a validity failure, not a reliability failure. A pipeline can reliably produce the same corrupted provenance — reliably wrong is still wrong. State degradation doesn't just add noise (reliability); it structurally alters what's being measured (validity). The pipeline is no longer measuring or analyzing the original construct.

**The instrument is (fixed weights + mutable context window).** The context window IS part of the instrument. Its content determines what the pipeline "knows" and how it operates. When state degrades, the instrument has changed.

**SFV as precondition.** If the operative history is corrupted, neither construct, internal, external, nor statistical conclusion validity claims are defensible. SFV is not one more validity type to check — it's the precondition for all the others in stateful pipelines.

Cite {cite:t}`webb_2026_ai4stats` for the full formal treatment. This section establishes enough for the practitioner to understand what SFV is and why it matters.

### 3. The Five Threats

Introduce each threat with its canonical name and a concrete example from pipeline design. The threats are T1–T5 from the vocabulary. For each:

**T1: Semantic Drift.** Terminology mutates across turns or sessions without explicit redefinition. Example: the pipeline starts calling a variable "household income" and by session 3 is using "family earnings" — same concept, different term, different downstream behavior if any processing depends on exact string matching or if the taxonomy has both as distinct categories.

**T2: False State Injection (Confabulation).** The system confabulates "memory" of decisions or agreements never established. Example: the pipeline "remembers" that the team agreed to exclude records below a threshold — but that agreement never happened. The exclusion criterion was injected by the model from its training data or from a prior, unrelated context. Connect to the "personality problem" from the MCP lessons learned: the system developing behavioral patterns (excessive caution, editorial choices) that weren't specified in any prompt or config.

**T3: Compression Distortion.** Context window management (compaction, summarization) silently strips nuance or alters meaning. Example: a long pipeline session gets compacted; the compacted summary drops the caveat "excluding imputed records" from a methodological decision. All subsequent analysis includes imputed records, changing the results, and there's no trace that the exclusion was ever specified.

**T4: State Supersession Failure.** Outdated information persists and influences output despite being explicitly superseded. Example: you correct a classification rule in session 4, but the model continues applying the session 2 version because the correction didn't fully override the earlier state. The old rule is still "there" in the context, competing with the new one.

**T5: State Discontinuity.** Session boundary loss drops accumulated context. Example: you end a session, start a new one, and the handoff document doesn't capture a critical methodological decision. The new session operates on partial history. Connect to Ch 7's session continuity patterns — handoff documents are the engineering countermeasure to T5.

**Reflection prompt (after threats):** *Think about a multi-session analysis you've done — even a non-AI one. Have you ever discovered that a decision from an earlier session was lost, misremembered, or silently overridden? How did you find out?*

### 4. Where Prior Chapters Were Already Fighting SFV Threats

This section is critical — it shows the reader that the engineering practices from Ch 1–8 are SFV countermeasures, even though they weren't framed that way at the time.

**Config-driven architecture (Ch 7) addresses T1 and T4.** When parameters live in config files rather than context windows, they can't drift. The model can't gradually mutate a model name or parameter setting if that setting is enforced by external configuration. Config files are a form of state externalization — moving critical state out of the mutable context window into an immutable, versioned store.

**Progressive test infrastructure (Ch 7) addresses T2 and T3.** Smoke tests, regression tests, and parameter validation catch confabulated decisions and compression artifacts before they propagate. The "golden test set" pattern — running the same benchmark questions periodically to detect drift — is a direct T1/T2 detection mechanism.

**Checkpoint/recovery (Ch 7) addresses T5.** Transaction-safe state saves and explicit resume logic ensure that pipeline state survives interruptions. Handoff documents are the human-readable version of the same pattern.

**Ensemble patterns (Ch 5) address T2.** Multi-model disagreement surfaces confabulated reasoning that a single model would present as fact. If one model "remembers" a decision that never happened and the other doesn't, the disagreement flags the false state injection.

**Evaluation by design (Ch 8) addresses all threats.** If your pipeline produces its own quality metrics continuously, state degradation surfaces as metric movement. You don't discover the drift when the final output looks wrong — you detect it when the intermediate metrics shift.

**Design for change (Ch 6) addresses T4.** Swap-ready model interfaces and versioned configurations mean that when the model changes (introducing new state behaviors), the change is tracked and its effects are measurable.

Keep this section tight — one paragraph per chapter connection, showing the reader that they've already been building SFV countermeasures. The framework gives names and structure to practices they now recognize.

### 5. Deterministic Retrieval as Stochastic Tax Reduction

**From the Pragmatics paper** {cite:p}`webb_2026_pragmatics`: The Pragmatics system achieved 91.2% pipeline fidelity versus 74.6% for RAG. A key architectural choice was deterministic retrieval — SQLite lookups instead of embedding-based similarity search. Every query to the same concept returns the same expert judgment item, every time. No embedding variance, no similarity threshold ambiguity, no retrieval drift.

**Why this matters for SFV:** Deterministic retrieval eliminates an entire class of state variability. When retrieval is stochastic (embedding similarity with arbitrary thresholds), the pipeline's behavior changes based on factors the designer doesn't control — embedding model updates, chunk boundary shifts, similarity score distributions. Each source of stochasticity is a potential SFV threat surface. Reducing unnecessary stochastic components — the "stochastic tax" from Ch 1 — directly reduces the pipeline's exposure to state degradation.

**The design principle:** Don't use an LLM where a lookup table will do. Don't use embedding search where a deterministic query will do. Every stochastic component you can replace with a deterministic one is one less thing that can drift.

### 6. The Training Cutoff as a Validity Boundary

**Theme:** The model's training cutoff date creates a hard knowledge boundary that is itself a state property. The model "knows" things from before the cutoff and confabulates things from after it. This isn't a bug — it's a fundamental property of how these systems work.

**Design implications:**
- Model parameters disappear between versions (Ch 7's temperature example). The model doesn't know they've disappeared.
- API signatures change. The model suggests deprecated methods from its training data.
- New models enter the market. The model doesn't know they exist.
- Benchmarks and performance characteristics shift. The model's self-assessment of capability is frozen at training time.

**Connection to T4 (State Supersession Failure):** The training cutoff is a massive, permanent supersession failure. Everything the model "knows" about available models, APIs, and best practices is from before the cutoff and has been partially superseded by reality. Config-driven architecture (Ch 7) is the primary countermeasure: don't let the model decide what's current; tell it via external state.

### 7. Model Selection Drift

**From Ch 6's "design for change" section and the chapter placeholder working notes:** The optimal model blend shifts as models update. A model that was the best choice six months ago may have degraded (silent baseline updates), been deprecated, or been surpassed by a new entrant. Selection criteria need versioning — not just "which model" but "why this model, evaluated when, against what criteria."

**Connection to SFV:** Model selection drift is a validity concern because the instrument itself has changed. If your evaluation results were generated with Model A v2.3 and you're now running Model A v2.7, you don't know whether your evaluation still holds. The model version is part of the instrument specification. Changing it without re-evaluation is running a different instrument and claiming the old validation applies.

**The countermeasure:** Version your model selections in configuration. Record the selection rationale. Schedule periodic re-evaluation (the golden test set pattern from Ch 7). When results shift, you have a trail to investigate.

### 8. Thought Experiment

You're running a quarterly survey processing pipeline. It has been stable for three quarters. In Q4, you notice that the "Other" category for occupation coding has grown from 3% to 12% of records. Nothing in your config, code, or input data format has changed. The provider released a model update two weeks before the Q4 run. You didn't re-run your golden test set because the update was described as "minor performance improvements."

What happened? How would you have caught it sooner? Which SFV threats are active? Trace the failure back through the countermeasures from this chapter and identify which ones, if implemented, would have detected the drift before the Q4 results were published.

*(This thought experiment is designed to be realistic for the federal statistical audience — quarterly processing cycles, occupation coding, silent model updates.)*

### 9. Chapter Bridge

State Fidelity Validity names the problem: the instrument changes during use, and the changes are silent. The countermeasures from prior chapters — config-driven architecture, progressive testing, ensemble patterns, evaluation by design — are the engineering response. But countermeasures require infrastructure: tools that track state, detect deviations, and maintain provenance across sessions and pipeline runs. That infrastructure — state management and research provenance — is the subject of Chapter 10.

---

## BibTeX Entries

All citations used in this chapter should already be in `book/references.bib`:
- `webb_2026_ai4stats` — AI for Official Statistics (SFV formal treatment, Ch 20)
- `webb_2026_pragmatics` — Pragmatics paper (pipeline fidelity, deterministic retrieval)
- `webb_2025_opencensus_mcp` — MCP lessons learned (personality problem)
- `nist_ai_rmf_2023` — NIST AI RMF 1.0 (TEVV)
- `nist_genai_2024` — NIST AI 600-1 (confabulation terminology)

**Verify all are present before drafting. No new BibTeX entries should be needed.**

---

## Cross-References Required

- Back references to Ch 1 (stochastic tax, evaluation trap), Ch 2 (Concept Mapper golden test set), Ch 5 (ensemble as T2 countermeasure), Ch 6 (design for change, model selection as engineering), Ch 7 (config-driven architecture, progressive testing, checkpoint/recovery — direct thread from Ch 7's thought experiment), Ch 8 (evaluation by design as continuous SFV monitoring)
- Forward references to Ch 10 (state management infrastructure — the operational answer to SFV), Ch 12 (security as system property — model provenance as security concern)
- Citation of canonical vocabulary: {cite:t}`webb_2026_ai4stats` for formal SFV definitions

---

## What This Chapter Does NOT Cover

- **Full formal derivation of SFV** → {cite:t}`webb_2026_ai4stats` Ch 20. This chapter applies the framework; it doesn't re-derive it.
- **State management tooling and infrastructure** → Ch 10
- **Security implications of model provenance** → Ch 12
- **Cost implications of SFV countermeasures** → Ch 14
- **Detailed Seldon architecture** → Ch 10 (Seldon origin story)

---

## Style and Tone Notes

- The ai4stats SFV chapter had the most distinctive prose voice in that book — measured, precise, with personality and stakes. This chapter should match that register, adapted for the workflow design context.
- **Do not flatten into textbook prose.** This is the author's original contribution. It should read like an argument, not a catalog.
- Introduce SFV terms with enough context for the practitioner to understand and apply, then cite the canonical source. Don't reproduce the full formal treatment — the reader can go to ai4stats for that.
- The "where prior chapters were already fighting SFV threats" section is the connective tissue of the book. It should feel like a reveal — "you've been doing this all along; now you know what it's called."
- Concrete examples throughout. Every threat gets a realistic pipeline scenario, not an abstract description.
- The audience knows statistics and measurement theory. They will recognize the validity/reliability distinction, the instrument metaphor, and the TSE parallel. Meet them at that level.

---

## Execution Notes

1. Replace all content in `book/chapter-09.md` (current content is a placeholder with working notes and shared ontology comments).
2. Preserve the shared ontology comment at the top: `<!-- SHARED ONTOLOGY: All SFV terms from seldon/ontology/validity/VALIDITY_VOCABULARY.md -->`
3. No new BibTeX entries required — verify all citations are present in `book/references.bib`.
4. All citations use `{cite:t}` (narrative) or `{cite:p}` (parenthetical) roles — no bare prose citations.
5. Use "confabulation" throughout, never "hallucination" except to note the terminological replacement.
6. Run `seldon verify --fix` after execution.
