# Chapter 9: State, Drift, and Validity

<!-- STATUS: Draft -->
<!-- SHARED ONTOLOGY: All SFV terms from seldon/ontology/validity/VALIDITY_VOCABULARY.md -->
<!-- Do NOT define SFV terms locally — reference the canonical vocabulary -->
<!-- Primary Working Principle: Outputs require full provenance -->
<!-- Primary Tenet: Trust defines the mission -->

## The Instrument That Changes Itself

In classical measurement, the instrument is stable. A thermometer does not redefine "degree" mid-measurement. A survey question does not rewrite itself between respondents. The properties of the instrument are fixed, or at least change slowly enough that the change can be calibrated and documented.

In an LLM-powered pipeline, the instrument changes during use.

The instrument is not just the model weights. It is the composite of fixed model weights and mutable context window. The context window accumulates decisions, terminology, intermediate results, and conversational history. That accumulated state determines what the pipeline "knows" and how it operates at any given moment. When the accumulated state degrades, the instrument silently becomes a different instrument. Your pipeline can recover from every crash, pass every checkpoint, produce beautiful output files, and still be measuring the wrong thing.

This is the answer to Chapter 7's thought experiment: your config has not changed, your code has not changed, your data format has not changed, but 30% of classifications shifted. The model updated. Or the context drifted. Or accumulated state from earlier processing contaminated later processing. The instrument changed.

This chapter introduces the framework for understanding why this happens and what to design against. State Fidelity Validity is the author's original contribution to measurement theory for AI-assisted research. The terminology is canonical {cite:p}`webb_2026_ai4stats`. What follows applies it to the workflow design decisions you have been learning throughout this book.

## State Fidelity Validity

State Fidelity Validity (SFV) is the degree to which an AI-assisted research or analytic pipeline preserves the accuracy and integrity of its accumulated internal state across sequential operations, such that inferences at step N remain warranted by the actual history of steps 1 through N-1 {cite:p}`webb_2026_ai4stats`.

The key insight is that this is a validity failure, not a reliability failure. A pipeline can reliably produce the same corrupted provenance. Reliably wrong is still wrong. State degradation does not just add noise, which would be a reliability concern. It structurally alters what is being measured. The pipeline is no longer measuring or analyzing the original construct. The outputs look the same. The provenance chain says they came from the same process. But the process itself has quietly changed.

The instrument, to repeat, is fixed weights plus mutable context window. The context window is part of the instrument. Its content determines what the pipeline "knows" and how it operates. When state degrades, the instrument has changed, and all downstream inferences are made by a different instrument than the one you validated.

SFV is a precondition for other validity claims. If the operative history is corrupted, neither construct, internal, external, nor statistical conclusion validity claims are defensible. SFV is not one more validity type to add to a checklist. It is the precondition for all the others in any stateful AI pipeline.

The full formal treatment, including the relationship to Total Survey Error and classical validity theory, is in {cite:t}`webb_2026_ai4stats`, Chapter 20. What follows here is the practitioner's application: the five threats, how they manifest in pipeline design, and how the engineering practices from prior chapters serve as countermeasures.

## The Five Threats

### T1: Semantic Drift

Terminology mutates across turns or sessions without explicit redefinition. The pipeline starts calling a variable "household income" and by session 3 is using "family earnings." Same concept, different term, different downstream behavior if any processing depends on exact string matching or if the taxonomy has both as distinct categories.

Semantic drift is insidious because it looks like natural language variation. The model is not making an error in the traditional sense. It is doing what language models do: generating contextually appropriate language. But in a research pipeline where terminology must be precise and consistent, contextually appropriate synonyms are a validity threat.

### T2: False State Injection

The system confabulates "memory" of decisions or agreements never established. The pipeline "remembers" that the team agreed to exclude records below a threshold, but that agreement never happened. The exclusion criterion was injected by the model from its training data or from a prior, unrelated context.

The colloquial term for this is "hallucination." The precise term, following NIST AI 600-1 {cite:p}`nist_genai_2024`, is confabulation: the generation of content that is presented as factual but is not grounded in the pipeline's actual history. In the context of state management, confabulated state is particularly dangerous because it masquerades as institutional memory. The model presents a fabricated decision with the same confidence and formatting as a real one.

The "personality problem" documented in the MCP lessons learned {cite:p}`webb_2025_opencensus_mcp` is a variant: the system developing behavioral patterns, excessive caution, editorial choices, rhetorical habits, that were not specified in any prompt or configuration. These emergent behaviors are false state: they did not come from the pipeline's design, but they influence its output.

### T3: Compression Distortion

Context window management, compaction, summarization, truncation, silently strips nuance or alters meaning. A long pipeline session gets compacted; the compacted summary drops the caveat "excluding imputed records" from a methodological decision. All subsequent analysis includes imputed records, changing the results, and there is no trace that the exclusion was ever specified.

Compression distortion is a direct consequence of context window limits. Every LLM has a finite context window. When the accumulated state exceeds it, something must be dropped or compressed. The question is what gets lost, and whether anyone notices.

### T4: State Supersession Failure

Outdated information persists and influences output despite being explicitly superseded. You correct a classification rule in session 4, but the model continues applying the session 2 version because the correction did not fully override the earlier state. The old rule is still "there" in the context, competing with the new one.

State supersession failure is common in multi-session workflows where accumulated context from earlier sessions carries forward. The model does not have a clean "update" operation. It has a context window where old and new information coexist, and the model's attention mechanism determines which one wins on any given query.

### T5: State Discontinuity

Session boundary loss drops accumulated context. You end a session, start a new one, and the handoff document does not capture a critical methodological decision. The new session operates on partial history. The pipeline does not know what it does not know.

State discontinuity is the most visible of the five threats because it manifests as obvious gaps: the pipeline does not know about a decision, a constraint, a prior result. But the visibility depends on the operator noticing the gap, which requires knowing what should be there. If nobody remembers the missing decision, nobody notices its absence. Handoff documents (Chapter 7) and state management infrastructure (Chapter 10) are the engineering countermeasures.

> *Think about a multi-session analysis you have done, even a non-AI one. Have you ever discovered that a decision from an earlier session was lost, misremembered, or silently overridden? How did you find out?*

## Where Prior Chapters Were Already Fighting SFV Threats

The engineering practices from Chapters 1 through 8 are SFV countermeasures. They were not framed that way when you learned them. Now you know what they are called.

**Config-driven architecture (Chapter 7) addresses T1 and T4.** When parameters live in config files rather than context windows, they cannot drift. The model cannot gradually mutate a model name or parameter setting if that setting is enforced by external configuration. Config files are state externalization: moving critical state out of the mutable context window into an immutable, versioned store.

**Progressive test infrastructure (Chapter 7) addresses T2 and T3.** Smoke tests, regression tests, and parameter validation catch confabulated decisions and compression artifacts before they propagate. The golden test set pattern, running the same benchmark questions periodically to detect drift, is a direct T1/T2 detection mechanism.

**Checkpoint and recovery (Chapter 7) addresses T5.** Transaction-safe state saves and explicit resume logic ensure that pipeline state survives interruptions. Handoff documents are the human-readable version of the same pattern.

**Ensemble patterns (Chapter 5) address T2.** Multi-model disagreement surfaces confabulated reasoning that a single model would present as fact. If one model "remembers" a decision that never happened and the other does not, the disagreement flags the false state injection.

**Evaluation by design (Chapter 8) addresses all threats.** If your pipeline produces its own quality metrics continuously, state degradation surfaces as metric movement. You do not discover the drift when the final output looks wrong. You detect it when the intermediate metrics shift.

**Design for change (Chapter 6) addresses T4.** Swap-ready model interfaces and versioned configurations mean that when the model changes, introducing new state behaviors, the change is tracked and its effects are measurable.

## Deterministic Retrieval as Stochastic Tax Reduction

The Pragmatics system {cite:p}`webb_2026_pragmatics` achieved 91.2% pipeline fidelity versus 74.6% for RAG. A key architectural choice was deterministic retrieval: SQLite lookups instead of embedding-based similarity search. Every query to the same concept returns the same expert judgment item, every time. No embedding variance, no similarity threshold ambiguity, no retrieval drift.

Deterministic retrieval eliminates an entire class of state variability. When retrieval is stochastic (embedding similarity with arbitrary thresholds), the pipeline's behavior changes based on factors the designer does not control: embedding model updates, chunk boundary shifts, similarity score distributions. Each source of stochasticity is a potential SFV threat surface. Reducing unnecessary stochastic components, the "stochastic tax" from Chapter 1, directly reduces the pipeline's exposure to state degradation.

The design principle: do not use an LLM where a lookup table will do. Do not use embedding search where a deterministic query will do. Every stochastic component you can replace with a deterministic one is one less thing that can drift.

## The Training Cutoff as a Validity Boundary

The model's training cutoff date creates a hard knowledge boundary that is itself a state property. The model "knows" things from before the cutoff and confabulates things from after it. This is not a bug. It is a fundamental property of how these systems work.

Model parameters disappear between versions (Chapter 7's temperature example). The model does not know they have disappeared. API signatures change. The model suggests deprecated methods from its training data. New models enter the market. The model does not know they exist. Benchmarks and performance characteristics shift. The model's self-assessment of capability is frozen at training time.

The training cutoff is a massive, permanent instance of T4: State Supersession Failure. Everything the model "knows" about available models, APIs, and best practices is from before the cutoff and has been partially superseded by reality. Config-driven architecture (Chapter 7) is the primary countermeasure: do not let the model decide what is current. Tell it via external state. Validate that it used what you told it.

## Model Selection Drift

The optimal model blend shifts as models update. A model that was the best choice six months ago may have degraded through silent baseline updates, been deprecated, or been surpassed by a new entrant. Selection criteria need versioning: not just "which model" but "why this model, evaluated when, against what criteria."

Model selection drift is a validity concern because the instrument itself has changed. If your evaluation results were generated with Model A v2.3 and you are now running Model A v2.7, you do not know whether your evaluation still holds. The model version is part of the instrument specification. Changing it without re-evaluation is running a different instrument and claiming the old validation applies.

The countermeasure: version your model selections in configuration. Record the selection rationale. Schedule periodic re-evaluation using the golden test set pattern from Chapter 7. When results shift, you have a trail to investigate.

### Thought Experiment

You are running a quarterly survey processing pipeline. It has been stable for three quarters. In Q4, you notice that the "Other" category for occupation coding has grown from 3% to 12% of records. Nothing in your config, code, or input data format has changed. The provider released a model update two weeks before the Q4 run. You did not re-run your golden test set because the update was described as "minor performance improvements."

What happened? How would you have caught it sooner? Which SFV threats are active? Trace the failure back through the countermeasures from this chapter and identify which ones, if implemented, would have detected the drift before the Q4 results were published.

---

State Fidelity Validity names the problem: the instrument changes during use, and the changes are silent. The countermeasures from prior chapters, config-driven architecture, progressive testing, ensemble patterns, evaluation by design, are the engineering response. But countermeasures require infrastructure: tools that track state, detect deviations, and maintain provenance across sessions and pipeline runs. That infrastructure, state management and research provenance, is the subject of Chapter 10.
