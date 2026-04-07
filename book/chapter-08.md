# Chapter 8: Evaluation by Design

<!-- STATUS: Draft -->
<!-- Primary Working Principle: If it cannot be explained, do not use it -->
<!-- Primary Tenet: Defensibility is required -->

## The Benchmark Illusion

The Remote Labor Index tested frontier AI agents on 240 real freelance projects sourced from Upwork, spanning 23 work categories, representing over 6,000 hours of human labor {cite:p}`mazeika_2025`. The best agent completed 2.5% at client-acceptable quality. The same models score near-expert on isolated task benchmarks. The gap is not model capability. The gap is that benchmarks provide all context, while real work requires you to bring your own.

This is the evaluation problem for AI-powered research workflows. There is no benchmark for your pipeline. No one has published a test suite for "correctly classifies survey harmonization potential across Census demographic surveys" or "accurately interprets ACS 1-year estimates for small geographies." If you wait for a standard benchmark to evaluate your system, you will wait forever.

Evaluation is architecture, not afterthought. The system that produces data must also produce the evidence that the data is trustworthy. This chapter shows how to design that evidence chain from the beginning, using existing quality frameworks as your scaffolding rather than inventing evaluation from scratch.

## Two Frameworks, One Pipeline

When AI participates in federal statistical production, two evaluation regimes apply simultaneously: one for the data product's quality, one for the AI system's trustworthiness. The crosswalk between FCSM 20-04 {cite:p}`fcsm_2020_data_quality` (federal statistical quality standards) and NIST AI RMF 1.0 (AI risk management framework) provides the evaluation scaffolding {cite:p}`webb_2026_crosswalk`. Neither framework references the other. Neither alone is sufficient.

This matters for pipeline design because every design choice maps to quality concerns in both frameworks simultaneously. The multi-model agreement architecture from Chapter 5 addresses accuracy and reliability (FCSM) and valid and reliable (NIST) at the same time. The structured arbitration protocol addresses scientific integrity (FCSM) and accountable and transparent (NIST). Recognizing these dual mappings is not compliance theater. It is a design discipline that forces you to ask the right questions before you build, not after.

The crosswalk identifies five types of mappings between the two frameworks:

*Direct (4 pairs):* Same concern, different vocabulary. Existing practice covers both. No additional work required.

*Partial (1 pair):* Overlap but not full coverage. Requires scope judgment about what is covered and what is not.

*Split (2 pairs):* Both frameworks name the concern but package it differently. Requires decomposition to see where they align and where they diverge.

*Distributed (3 pairs):* One framework does the work without naming it explicitly. Requires assembly: collecting scattered practices and naming them as a coherent evaluation activity.

*FCSM-only (4 of the framework's 11 dimensions):* No NIST equivalent. Data fitness concerns, relevance, timeliness, accessibility, coherence, that AI trustworthiness frameworks do not address.

The practical value: where existing statistical quality practices already address an AI trustworthiness concern, agencies should not build a parallel evaluation process. The crosswalk identifies targeted additional work rather than wholesale duplication.

> *Your agency has a mature data quality review process for its survey products. Someone proposes adding a separate "AI evaluation framework" for the new LLM-assisted processing step. What is wrong with this approach? What would you do instead?*

## Valid and Reliable Is a Gate, Not a Dial

The crosswalk's most important finding for pipeline designers: valid and reliable is a binary gate, not one dimension among many {cite:p}`nist_ai_rmf_2023`. If the AI system confabulates, nothing else matters. You cannot meaningfully evaluate safety, fairness, or explainability of a system that produces wrong outputs with high confidence.

NIST's framework positions valid and reliable as foundational — the characteristic on which all other trustworthiness assessments depend. The crosswalk confirmed this operationally: in both the survey harmonization pipeline and the statistical consultation system, validity was the prerequisite that every other evaluation depended on {cite:p}`webb_2026_crosswalk`.

The design implication: your evaluation architecture must test validity first and continuously, not as one dimension among many. If validity fails, everything downstream is contaminated.

There is a specification gap. Both FCSM and NIST name the concern, but neither specifies what confabulation detection looks like in a particular statistical domain. What counts as a confabulated survey classification? What guardrails catch semantic smearing in statistical consultation? This gap is one of specification, not detection. Filling it requires both frameworks plus domain-specific validation methods that neither provides alone {cite:p}`webb_2026_crosswalk`.

## Building Your Own Evaluation Instruments

Since no off-the-shelf benchmark exists for your pipeline, you must build one. This is not a limitation. It is the design discipline. The benchmark is part of the instrument, not a pre-existing given.

**Golden test sets.** A curated set of inputs with known-correct outputs that your pipeline must handle correctly. Design properties:

*Domain-representative.* The test set must cover the actual distribution of your inputs, including edge cases and known-ambiguous cases. A golden test set of only easy cases tells you nothing useful.

*Version-controlled.* The test set is an artifact of the pipeline, tracked alongside model versions, prompt versions, and pipeline configuration. When it changes, the change is documented.

*Living, not static.* As you discover new failure modes in production, add them to the golden test set. The test set grows with your understanding of the problem.

*Include known-ambiguous cases.* For classification tasks, include cases where the "right" answer is genuinely debatable. The pipeline's behavior on ambiguous cases is diagnostic: does it express uncertainty, or does it confabulate confidence?

**Regression testing.** Run the golden test set every time the pipeline changes: model update, prompt revision, configuration change, framework version bump. This is the evaluation trap from Chapter 1 inverted: instead of spending months comparing models on generic benchmarks (producing obsolete conclusions), test *your* pipeline on *your* data after *every* change.

The Concept Mapper used this approach: golden questions that anchored evaluation across model updates {cite:p}`webb_2026_concept_mapper`. The principle is general: any production pipeline needs a regression suite that runs automatically when the pipeline changes and that produces a go/no-go signal before deployment.

**Multi-model agreement as evaluation.** When you run N models on the same input, the agreement rate is an evaluation metric. The Concept Mapper's inter-rater reliability statistics (Fleiss' κ = 0.537 pre-arbitration, κ = 0.843 post-arbitration) are not just accuracy measures. They are evidence of construct validity. If independently trained models converge on the same classification through a structured protocol, the task is well-defined {cite:p}`webb_2026_concept_mapper`. These Fleiss' κ values come from the three-rater harmonization stage, where three independent rater models from three vendors evaluated question pairs; they are distinct from the two-model classification stage that produced Cohen's κ = 0.839 for topic-level agreement.

> *You inherit a pipeline with no golden test set. How do you build one? What is your minimum viable test set, and what is the difference between "good enough to start" and "good enough to ship"?*

## The Tailored Crosswalk as Evaluation Design Tool

The crosswalk is not a checklist to fill out after you have built the system. It is a design tool you apply before you build, to identify what needs to be measured and why {cite:p}`webb_2026_crosswalk`.

In practice: for each design choice in your pipeline, ask what FCSM quality dimension it addresses and what NIST trustworthiness characteristic it satisfies. If a design choice does not map to any quality concern, it is either unnecessary or you have not identified the concern yet.

The two tailored crosswalks from the paper illustrate how the same framework structure produces different emphasis patterns based on operational context:

**Batch classification (survey harmonization).** Multi-vendor rater agreement maps to accuracy and reliability (FCSM) and valid and reliable (NIST). Randomized presentation order maps to accuracy and reliability and valid and reliable. Structured arbitration with written reasoning maps to scientific integrity and transparency (FCSM) and accountable and transparent (NIST). Public code, prompts, and data map to transparency and accessibility (FCSM) and accountable and transparent (NIST).

**Real-time consultation (statistical query system).** Accuracy of data values maps to accuracy and reliability and valid and reliable. Uncertainty communication maps to accuracy and reliability plus transparency (FCSM) and accountable and transparent plus explainable and interpretable (NIST). Fitness-for-use guidance maps to relevance and coherence (FCSM) and explainable and interpretable (NIST). Grounding compliance is a binary structural design property mapping to valid and reliable.

The key difference: the batch system operates with expert review after the fact, so explainability requirements are low. The real-time system operates with no independent verification, so explainability is operationally critical. The same crosswalk structure, different emphasis. This is exactly how evaluation frameworks should work: stable structure, contextual emphasis.

> *For your own pipeline, take one design choice and map it: what FCSM quality dimension does it address? What NIST trustworthiness characteristic does it satisfy? If a design choice maps to neither, it is either unnecessary or you have not identified the concern yet. Start with your most consequential design choice — the one that, if wrong, would most undermine trust in the output.*

## Continuous Evaluation, Not Snapshot Testing

Snapshot benchmarks test whether the system works right now. Production pipelines need to know whether the system continues to work over time.

{cite:t}`chen_2026_sweci` tested 18 AI coding models on 100 real codebases spanning an average of 233 days and 71 consecutive commits. 75% of models broke previously working code during long-term maintenance. An agent that passes all tests today can introduce regressions tomorrow. The EvoScore metric, which weights later iterations more heavily to catch agents that produce quick fixes early but create mounting technical debt, captures exactly the concern that snapshot testing misses.

The same principle applies to data pipelines. A classification model that achieves κ = 0.843 today may drift as model updates change the underlying behavior. A consultation system that grounds correctly today may smear semantics after a model version change. Continuous evaluation means:

*Scheduled regression runs.* Run the golden test set on a fixed cadence, not just when you think something changed. Model providers push silent updates {cite:p}`liu_2024_chatgpt_behavior`.

*Drift detection.* Monitor agreement rates, confidence distributions, and failure mode patterns over time. A gradual shift in agreement rate is a signal, not noise.

*Model version logging.* Record which model version produced which output. When drift is detected, you need to identify when it started and what changed.

*Change-triggered re-evaluation.* Any pipeline change, whether model update, prompt revision, schema change, or dependency update, triggers a full regression run before deployment.

> *Your pipeline has been running in production for six months. Agreement rates have been stable at 94%. This month they drop to 88%. Is this a problem? What is your decision process, and at what threshold would you halt the pipeline?*

A note on calibrating those thresholds: traditional statistical process control assumes stationary processes. LLM pipelines are not stationary. The instrument changes through provider updates, context drift, and model deprecation. Classical SPC control limits do not transfer directly to this setting, and there is no established standard for "how much evaluation is enough" in stochastic research pipelines. The golden test set described above is the practical mechanism available now: it gives you directionality. You know when confidence is degrading and in which direction. The question of at what threshold you halt is a risk-managed judgment call that depends on the downstream consequence of error in your specific application -- a 6% drop in agreement that affects a low-stakes exploratory analysis is different from the same drop in a pipeline producing official statistical releases. Think of it as the soup spoon principle: you do not need to evaluate every output, you need to sample intelligently enough to detect the direction of drift. The golden test set is that spoonful. For context, surveys have known response error rates; manual coding has known disagreement rates. The question is not "is this pipeline perfect?" but "at what point do I lose confidence in the direction of results?" Calibrating the threshold for your specific pipeline and risk tolerance is an open problem. This book provides the infrastructure; the thresholds require practitioner judgment.

## Evaluation Economics

Evaluation is not free. Design your evaluation budget alongside your inference budget.

The Concept Mapper evaluation cost under $100 in API fees for the full classification pipeline: 6,954 questions, three models, structured arbitration {cite:p}`webb_2026_concept_mapper`. The per-run inference cost for classification alone was approximately \$15; the full pipeline total reflects three models, structured arbitration, and evaluation across the complete question set. The evaluation was built into the pipeline. Multi-model agreement, behavioral analysis, and arbitration protocols were not separate evaluation activities; they were the pipeline itself.

The Pragmatics evaluation from the crosswalk paper cost approximately \$15 in API fees for a three-stage evaluation pipeline: nine LLM judges from three vendors evaluating across five quality dimensions {cite:p}`webb_2026_crosswalk`. Cost is not the barrier to evaluation. Design is the barrier.

The evaluation trap economics: months of model comparison on generic benchmarks produces conclusions that are obsolete by publication. The cost is not API fees; it is researcher time spent on evaluation activities that do not produce actionable results for the specific pipeline. Design evaluation that tests your system on your data, and the economics improve dramatically.

The same agents that scored near-expert on benchmarks achieved 2.5% on real freelance work. Your evaluation infrastructure is what ensures your pipeline is not the statistical production equivalent of that gap.

## What Evaluation Cannot Do

Be honest about limits.

Evaluation cannot prove the absence of confabulation. It can provide evidence that the system handles known cases correctly. It cannot guarantee behavior on unseen cases. This is why human-in-the-loop review remains necessary for high-stakes applications.

Evaluation frameworks are not validation studies. The crosswalk is an evaluation framework translation, not empirical validation. Practitioners applying it bring their own institutional context, and interpretations may reasonably differ {cite:p}`webb_2026_crosswalk`.

Multi-model agreement is not ground truth. Models sharing training corpora are not statistically independent. High agreement may reflect correlated bias, not correctness. Behavioral analysis showing genuinely different decision patterns across vendors is evidence against, but not proof against, correlated failure.

Evaluation is continuous, not complete. There is no point at which you have "finished" evaluating. Models update, requirements change, edge cases emerge. Evaluation is an operating cost, not a one-time capital expenditure.

---

### Thought Experiment

Your agency has been running an LLM-assisted coding pipeline for 12 months. You are asked to present an annual quality review to the agency head. Consider:

1. What evidence would you present? If you have not been collecting it continuously, you do not have it.
2. How do you characterize the pipeline's quality in terms your agency head understands: FCSM dimensions, not F1 scores?
3. The agency head asks: "How do we know this system is not making confident mistakes we have not caught?" What is your honest answer?
4. A colleague proposes switching to a newer, cheaper model that scores better on public benchmarks. What evaluation would you require before approving the switch? What evidence from the benchmarks would you *not* accept as sufficient?

---

Evaluation tells you how the system is performing right now. But LLM-powered pipelines do not stand still. Models update silently. Context windows drift. Training cutoffs mean the system's knowledge of the world is always stale relative to the data it processes. Chapter 9 addresses what happens when the instrument changes under you: state, drift, and the validity framework for reasoning about whether your pipeline is still measuring what you think it is measuring.
