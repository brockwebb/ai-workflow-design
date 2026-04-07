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

State Fidelity Validity (SFV) is the degree to which an AI-assisted research or analytic pipeline preserves the accuracy and integrity of its accumulated internal state (decisions, terminology, methodology, and intermediate findings) across sequential operations, such that inferences at step N remain warranted by the actual history of steps 1 through N-1, rather than by degraded, distorted, confabulated, or selectively retained versions of that history {cite:p}`webb_2026_ai4stats`.

The key insight is that this is a validity failure, not a reliability failure. A pipeline can reliably produce the same corrupted provenance. Reliably wrong is still wrong. State degradation does not just add noise, which would be a reliability concern. It structurally alters what is being measured. The pipeline is no longer measuring or analyzing the original construct. The outputs look the same. The provenance chain says they came from the same process. But the process itself has quietly changed.

The instrument, to repeat, is fixed weights plus mutable context window. The context window is part of the instrument. Its content determines what the pipeline "knows" and how it operates. When state degrades, the instrument has changed, and all downstream inferences are made by a different instrument than the one you validated.

SFV is a precondition for other validity claims. If the operative history is corrupted, neither construct, internal, external, nor statistical conclusion validity claims are defensible. SFV is not one more validity type to add to a checklist. It is the precondition for all the others in any stateful AI pipeline.

The full formal treatment, including the relationship to Total Survey Error and classical validity theory, is in {cite:t}`webb_2026_ai4stats`, Chapter 15. What follows here is the practitioner's application: the five sub-dimensions, the five threats, how they manifest in pipeline design, and how the engineering practices from prior chapters serve as countermeasures.

State degradation in computational systems is not a new phenomenon. Concept drift, the change in statistical properties of a target variable over time, has been studied in machine learning for decades {cite:p}`widmer_kubat_1996`. Surveys of machine learning systems under distribution shift document systematic degradation in model behavior that no single design choice eliminates {cite:p}`gama_2014`. Data provenance tracking addresses a related problem: how to maintain traceable lineage for data transformations in scientific workflows {cite:p}`simmhan_2005`. SFV extends these concepts from model predictions and data lineage to the full pipeline state: the accumulated decisions, terminology, and intermediate findings that determine how the instrument operates at any given moment. Prior frameworks address what the model outputs or what data was transformed. SFV addresses what the pipeline believes about its own history.

## The Five Sub-dimensions

The SFV framework has two structures: five threats (what can go wrong) and five sub-dimensions (what to check). The sub-dimensions provide the operational vocabulary for assessing and monitoring pipeline state.

| Sub-dimension | Shorthand | What It Checks |
|---------------|-----------|----------------|
| Terminological Consistency | TC | Vocabulary remains stable and matches externally defined terms across the full execution |
| State Provenance | SP | Outputs are traceable to actual prior steps; no invented history |
| Compression Fidelity | CF | Summarization and compaction do not distort meaning of prior decisions |
| Session Continuity | SC | Information survives thread/session boundaries intact |
| State Coherence | SCoh | Accumulated state is internally consistent at any given point |

Each sub-dimension maps primarily to one or two threats. TC is the check for T1: if terminology is drifting, terminological consistency will catch it. SP is the check for T2: if the pipeline is confabulating history, provenance tracing will surface the fabrication. CF is the check for T3: if compaction is losing nuance, compression fidelity audits will detect the divergence. SC is the check for T5: session continuity measures whether information survived the boundary. SCoh crosscuts all five threats: accumulated state can be internally inconsistent as a consequence of any of them, and consistency auditing catches compound failures that individual sub-dimension checks might miss.

The threats describe failure modes. The sub-dimensions describe what to monitor. When you suspect a state problem, the sub-dimensions are your diagnostic vocabulary: "Is this a terminological consistency issue (T1) or a provenance issue (T2)?" gives you a more actionable diagnostic question than "Is something wrong with my SFV?"

Each active SFV threat compromises a corresponding classical validity claim:

| SFV Threat Active | Classical Validity Compromised | Why |
|---|---|---|
| T1: Semantic Drift | Construct validity | Terminology mutation means the pipeline may no longer be measuring the intended construct |
| T2: False State Injection | Internal validity | Causal inferences rest on fabricated premises about what decisions were actually made |
| T3: Compression Distortion | Statistical conclusion validity | Analytic decisions based on lossy summaries of prior methodology |
| T4: State Supersession Failure | Internal validity | Conclusions drawn from state the pipeline "knows" has been superseded |
| T5: State Discontinuity | External validity | Findings cannot generalize if the pipeline's operative history is incomplete |

SFV is the precondition the classical validity types assume but do not state {cite:p}`groves_2009`. Each classical type assumes the instrument is stable. SFV guards that assumption directly. When it fails, the other validity claims are no longer warranted regardless of how well the pipeline performs on any given batch.

> *Before reading the five threats, think about a multi-session pipeline you have built or used. Which of the five sub-dimensions would be hardest to verify in that pipeline? Why?*

## The Five Threats

### T1: Semantic Drift

Terminology mutates across turns or sessions without explicit redefinition. The pipeline starts calling a variable "household income" and by session 3 is using "family earnings." Same concept, different term, different downstream behavior if any processing depends on exact string matching or if the taxonomy has both as distinct categories.

Semantic drift is insidious because it looks like natural language variation. The model is not making an error in the traditional sense. It is doing what language models do: generating contextually appropriate language. But in a research pipeline where terminology must be precise and consistent, contextually appropriate synonyms are a validity threat.

### T2: False State Injection

The system confabulates "memory" of decisions or agreements never established. The pipeline "remembers" that the team agreed to exclude records below a threshold, but that agreement never happened. The exclusion criterion was injected by the model from its training data or from a prior, unrelated context.

The colloquial term for this is "hallucination." The precise term, following NIST AI 600-1 {cite:p}`nist_genai_2024`, is confabulation: the production of confidently stated but erroneous or false content, colloquially called hallucination. In the context of state management, confabulated state is particularly dangerous because it masquerades as institutional memory. The model presents a fabricated decision with the same confidence and formatting as a real one.

A related variant observed in multi-session LLM systems is emergent behavioral drift: the system developing rhetorical habits, excessive caution, or editorial preferences not specified in any prompt or configuration. In the Open Census MCP project {cite:p}`webb_2025_opencensus_mcp`, thread resets to default behavior, memory-influenced context, and system instruction updates outside user control all contributed to behavioral variance across sessions that no single design choice could eliminate. These emergent behaviors are false state: they did not come from the pipeline's design, but they influence its output.

### T3: Compression Distortion

Context window management, compaction, summarization, truncation, silently strips nuance or alters meaning. A long pipeline session gets compacted; the compacted summary drops the caveat "excluding imputed records" from a methodological decision. All subsequent analysis includes imputed records, changing the results, and there is no trace that the exclusion was ever specified.

Compression distortion is a direct consequence of context window limits. Every LLM has a finite context window. When the accumulated state exceeds it, something must be dropped or compressed. The question is what gets lost, and whether anyone notices.

You will hear the argument that intermediate monitoring should collapse into a single evaluative gate at the end of the pipeline. This argument fails when applied to SFV. SFV's central insight is that the instrument changes during use; a final gate evaluates the output of whatever instrument existed at the end of processing, but it cannot assess whether that instrument was the same instrument throughout. By the time a final gate runs, T1, T2, and T3 have already done their damage: terminology has drifted, state has been confabulated, and compaction has silently stripped nuance from the methodology. The gate can assess the output. It cannot assess the instrument that produced it. Intermediate monitoring exists because the failure mode is silent: if you only check at the end, you are checking the wrong thing.

### T4: State Supersession Failure

Outdated information persists and influences output despite being explicitly superseded. You correct a classification rule in session 4, but the model continues applying the session 2 version because the correction did not fully override the earlier state. The old rule is still "there" in the context, competing with the new one.

State supersession failure is common in multi-session workflows where accumulated context from earlier sessions carries forward. The model does not have a clean "update" operation. It has a context window where old and new information coexist, and the model's attention mechanism determines which one wins on any given query.

### T5: State Discontinuity

Session boundary loss drops accumulated context. You end a session, start a new one, and the handoff document does not capture a critical methodological decision. The new session operates on partial history. The pipeline does not know what it does not know.

State discontinuity is the most visible of the five threats because it manifests as obvious gaps: the pipeline does not know about a decision, a constraint, a prior result. But the visibility depends on the operator noticing the gap, which requires knowing what should be there. If nobody remembers the missing decision, nobody notices its absence. Handoff documents (Chapter 7) and state management infrastructure (Chapter 10) are the engineering countermeasures.

> *Think about a multi-session analysis you have done, even a non-AI one. Have you ever discovered that a decision from an earlier session was lost, misremembered, or silently overridden? How did you find out?*

## Where Prior Chapters Were Already Fighting SFV Threats

The engineering practices from Chapters 1 through 8 are SFV countermeasures. They were not framed that way when you learned them. Now you can see what they address, and what they leave exposed.

| Practice | Chapter | Addresses | Mechanism |
|----------|---------|-----------|-----------|
| Config-driven architecture | 7 | T1, T4 | Critical state externalized to versioned files; cannot drift or persist undetected |
| Progressive test infrastructure | 7 | T2, T3 | Smoke tests and regression checks catch confabulated or compressed state before propagation |
| Checkpoint and recovery | 7 | T5 | Transaction-safe state saves bridge session boundaries |
| Ensemble patterns | 5 | T2 | Multi-model disagreement surfaces confabulated reasoning a single model would present as fact |
| Golden test set | 8 | T1, T2 | Periodic benchmark detects drift and confabulation over time |
| Evaluation by design | 8 | All | Continuous quality metrics surface state degradation as metric movement |
| Design for change | 6 | T4 | Swap-ready interfaces make model-version changes trackable and reversible |

The table shows what is covered. Two gaps remain. First, active state auditing: no chapter teaches you how to inspect accumulated state for coherence at a point in time. The practices above prevent degradation or detect it after the fact; none of them walk you through auditing the current state of a live pipeline against its intended history. Second, threat triage: no chapter provides a symptom-to-threat mapping for diagnosis. When your pipeline is producing unexpected results, distinguishing T1 (semantic drift) from T4 (persisting outdated state) from T2 (confabulated history) requires a diagnostic approach this book has not yet provided.

The second gap, symptom-to-threat mapping, can be partially addressed with a diagnostic starting point. When pipeline behavior changes unexpectedly, these observable symptoms suggest which threats to investigate first:

:::{table} Symptom-to-threat diagnostic guide. Observable pipeline symptoms mapped to the SFV threats most likely responsible and initial investigation steps.
:name: tbl-09-01

| Observable Symptom | Most Likely Threat(s) | First Investigation Step |
|:--|:--|:--|
| Output vocabulary shifts (new terms, changed phrasing patterns) | T1 (Semantic Drift) | Compare golden test set results before and after the change window |
| Pipeline produces confident but factually wrong outputs | T2 (False State Injection) | Check whether the model is citing information not present in its input or configuration |
| Nuance or qualifications disappearing from outputs | T3 (Compression Distortion) | Compare full expert judgment text against what the pipeline actually delivered to the model |
| Known-fixed issue reappears | T4 (State Supersession Failure) | Verify config file versions; check whether a session reset loaded stale defaults |
| Results differ between identical reruns | T5 (State Discontinuity) | Check temperature settings, API version pinning, and whether context window carried state from a prior run |
| "Other" or default category volume increases | T1 or T4 | Run golden test set; compare model version against last validated version |
| Disagreement rate between models changes sharply | T1, T2, or T4 | Isolate which model changed behavior; check provider release notes |
:::

This table is a starting point, not a decision tree. Multiple threats can produce similar symptoms, and real failures often involve compound causes. The value is in narrowing the investigation: instead of checking everything, start with the most probable threat and follow the evidence.

State externalization is the common principle across these countermeasures: moving critical state out of the mutable context window into durable, queryable infrastructure. Config files externalize parameters. Test suites externalize expected behavior. Handoff documents externalize session history. When the state being externalized has typed relationships between entities, artifacts that depend on other artifacts, decisions that supersede prior decisions, evidence chains connecting claims to sources, the natural representation is a graph, not a table. Chapter 10 provides the infrastructure for this pattern.

> *Which of the countermeasure practices above is weakest in your current pipeline design? What would it take to strengthen it?*

## Deterministic Retrieval as Stochastic Tax Reduction

The Pragmatics system {cite:p}`webb_2026_pragmatics` achieved 91.2% pipeline fidelity versus 74.6% for RAG. A key architectural choice was deterministic retrieval: SQLite lookups instead of embedding-based similarity search. Every query to the same concept returns the same expert judgment item, every time. No embedding variance, no similarity threshold ambiguity, no retrieval drift.

Deterministic retrieval eliminates an entire class of state variability. When retrieval is stochastic (embedding similarity with arbitrary thresholds), the pipeline's behavior changes based on factors the designer does not control: embedding model updates, chunk boundary shifts, similarity score distributions. Each source of stochasticity is a potential SFV threat surface. Reducing unnecessary stochastic components, the "stochastic tax" from Chapter 1, directly reduces the pipeline's exposure to state degradation.

The design principle: do not use an LLM where a lookup table will do. Do not use embedding search where a deterministic query will do. Every stochastic component you can replace with a deterministic one is one less thing that can drift.

## The Training Cutoff as a Validity Boundary

The model's training cutoff date is the most pervasive instance of T4 in practice: a permanent state supersession failure embedded in the instrument itself. The model "knows" things from before the cutoff and confabulates things from after it. This is not a bug. It is a fundamental property of how these systems work.

Model parameters disappear between versions (Chapter 7's temperature example). The model does not know they have disappeared. API signatures change. The model suggests deprecated methods from its training data. New models enter the market. The model does not know they exist. Benchmarks and performance characteristics shift. The model's self-assessment of capability is frozen at training time.

Everything the model "knows" about available models, APIs, and best practices is from before the cutoff and has been partially superseded by reality. Config-driven architecture (Chapter 7) is the primary countermeasure: do not let the model decide what is current. Tell it via external state. Validate that it used what you told it.

## Model Selection Drift

Model selection drift is a T4 variant at the system level: the instrument has changed, but the validation claims have not been updated to reflect the change. The optimal model blend shifts as models update. A model that was the best choice six months ago may have degraded through silent baseline updates {cite:p}`liu_2024_chatgpt_behavior`, been deprecated, or been surpassed by a new entrant. Selection criteria need versioning: not just "which model" but "why this model, evaluated when, against what criteria."

Model selection drift is a validity concern because the instrument itself has changed. If your evaluation results were generated with Model A v2.3 and you are now running Model A v2.7, you do not know whether your evaluation still holds. The model version is part of the instrument specification. Changing it without re-evaluation is running a different instrument and claiming the old validation applies.

The countermeasure: version your model selections in configuration. Record the selection rationale. Schedule periodic re-evaluation using the golden test set pattern from Chapter 8. When results shift, you have a trail to investigate.

### Thought Experiment

You are running a quarterly survey processing pipeline. It has been stable for three quarters. In Q4, you notice that the "Other" category for occupation coding has grown from 3% to 12% of records. Nothing in your config, code, or input data format has changed. The provider released a model update two weeks before the Q4 run. You did not re-run your golden test set because the update was described as "minor performance improvements."

What happened? How would you have caught it sooner? Which SFV threats are active? Trace the failure back through the countermeasures from this chapter and identify which ones, if implemented, would have detected the drift before the Q4 results were published.

---

State Fidelity Validity names the problem: the instrument changes during use, and the changes are silent. The countermeasures from prior chapters, config-driven architecture, progressive testing, ensemble patterns, evaluation by design, are the engineering response. But countermeasures require infrastructure: tools that track state, detect deviations, and maintain provenance across sessions and pipeline runs. That infrastructure, state management and research provenance, is the subject of Chapter 10.
