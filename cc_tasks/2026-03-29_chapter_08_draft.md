# CC Task: Draft Chapter 8 — Evaluation by Design

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Target file:** `book/chapter-08.md`
**Type:** Full chapter draft (replaces placeholder)
**Session:** 7

---

## Organizing Framework Alignment

**Primary Working Principle:** If it cannot be explained, do not use it
**Primary Tenet:** Defensibility is required

## Pedagogical Pattern

- **Opening hook:** The benchmark illusion — frontier models score near-expert on isolated benchmarks but complete 2.5% of real freelance work (RLI). The gap isn't intelligence; it's the absence of designed evaluation for your actual context.
- **Core content:** Evaluation as architecture; the crosswalk as evaluation framework; building your own instruments; continuous evaluation vs. snapshot testing
- **Reflection prompts:** Distributed throughout (minimum 3)
- **Thought experiment:** At least one substantial scenario
- **Chapter bridge:** Forward to Ch 9 (State, Drift, Validity) — evaluation tells you how the system is performing *now*; Ch 9 asks what happens when the system changes under you

---

## Chapter Structure

### 8.1 Opening: The Benchmark Illusion

Hook: The Remote Labor Index tested frontier AI agents on 240 real freelance projects sourced from Upwork — spanning 23 work categories, representing over 6,000 hours of human labor. The best agent completed 2.5% at client-acceptable quality ({cite:p}`mazeika_2025`). The same models score near-expert on isolated task benchmarks. The gap is not model capability. The gap is that benchmarks provide all context, while real work requires you to bring your own.

This is the evaluation problem for AI-powered research workflows: **there is no benchmark for your pipeline.** No one has published a test suite for "correctly classifies survey harmonization potential across Census demographic surveys" or "accurately interprets ACS 1-year estimates for small geographies." If you wait for a standard benchmark to evaluate your system, you will wait forever.

State the chapter's thesis: **Evaluation is architecture, not afterthought. The system that produces data must also produce the evidence that the data is trustworthy.** This chapter shows how to design that evidence chain from the beginning, using existing quality frameworks as your scaffolding rather than inventing evaluation from scratch.

### 8.2 Two Frameworks, One Pipeline

The crosswalk between FCSM 20-04 and NIST AI RMF 1.0 provides the evaluation scaffolding ({cite:t}`webb_2026_crosswalk`). The key insight: when AI participates in federal statistical production, two evaluation regimes apply simultaneously — one for the data product's quality (FCSM), one for the AI system's trustworthiness (NIST). Neither references the other. Neither alone is sufficient.

**Why this matters for pipeline design:** Every design choice in your pipeline maps to quality concerns in both frameworks simultaneously. This is not compliance theater — it's a design discipline that forces you to ask the right questions before you build, not after.

Briefly present the five mapping types from the crosswalk:
- **Direct (4 pairs):** Same concern, different vocabulary. Existing practice covers both. No additional work.
- **Partial (1 pair):** Overlap but not full coverage. Requires scope judgment.
- **Split (2 pairs):** Both frameworks name it but package it differently. Requires decomposition.
- **Distributed (3 pairs):** One framework does the work without naming it. Requires assembly and naming.
- **FCSM-only (4 dimensions):** No NIST equivalent. Data fitness concerns that AI trustworthiness doesn't address.

**The practical value:** Where existing FCSM practices already address a NIST concern, agencies should not build a parallel evaluation process. The crosswalk identifies targeted additional work rather than wholesale duplication.

> **Reflection prompt:** Your agency has a mature data quality review process for its survey products. Someone proposes adding a separate "AI evaluation framework" for the new LLM-assisted processing step. What's wrong with this approach? What would you do instead?

### 8.3 Valid & Reliable Is a Gate, Not a Dial

The crosswalk's most important finding for pipeline designers: **Valid & Reliable is a binary gate.** If the AI system confabulates, nothing else matters. You cannot meaningfully evaluate safety, fairness, or explainability of a system that produces wrong outputs with high confidence.

NIST's own architecture shows Valid & Reliable as the foundation on which all other characteristics rest ({cite:p}`nist_ai_rmf_2023`). The crosswalk confirmed this operationally: in both the survey harmonization pipeline and the statistical consultation system, validity was the prerequisite that every other evaluation depended on ({cite:p}`webb_2026_crosswalk`).

**Design implication:** Your evaluation architecture must test validity *first* and *continuously*, not as one dimension among many. If validity fails, everything downstream is contaminated.

**The specification gap:** Both FCSM and NIST name the concern but neither specifies what confabulation detection looks like in a particular statistical domain. What counts as a confabulated survey classification? What guardrails catch semantic smearing in ACS consultation? This gap is one of specification, not detection — filling it requires both frameworks *plus* domain-specific validation methods that neither provides alone ({cite:p}`webb_2026_crosswalk`).

### 8.4 Building Your Own Evaluation Instruments

Since no off-the-shelf benchmark exists for your pipeline, you must build one. This is not a limitation — it's the design discipline. The benchmark is part of the instrument, not a pre-existing given.

**Golden test sets.** A curated set of inputs with known-correct outputs that your pipeline must handle correctly. Design properties:

- **Domain-representative.** The test set must cover the actual distribution of your inputs, including edge cases and known-ambiguous cases. A golden test set of only easy cases tells you nothing.
- **Version-controlled.** The test set is an artifact of the pipeline, tracked alongside model versions, prompt versions, and pipeline configuration. When it changes, the change is documented.
- **Living, not static.** As you discover new failure modes in production, add them to the golden test set. The test set grows with your understanding of the problem.
- **Include known-ambiguous cases.** For classification tasks, include cases where the "right" answer is genuinely debatable. The pipeline's behavior on ambiguous cases is diagnostic — does it express uncertainty, or does it confabulate confidence?

**Regression testing.** Run the golden test set every time the pipeline changes — model update, prompt revision, configuration change, framework version bump. This is the "evaluation trap" inverted: instead of spending months comparing models on generic benchmarks (producing obsolete conclusions), test *your* pipeline on *your* data after *every* change.

The Concept Mapper used this approach: golden questions that anchored evaluation across model updates. A chatbot team was advised to build the same — weekly regression, golden questions, catch drift early. They refused. This is the evaluation trap lived: the team that skips regression testing is the team that ships a pipeline they can't characterize.

**Multi-model agreement as evaluation.** When you run N models on the same input, the agreement rate *is* an evaluation metric. The Concept Mapper's inter-rater reliability statistics (Fleiss' κ = 0.537 pre-arbitration, κ = 0.843 post-arbitration) are not just accuracy measures — they're evidence of construct validity. If independently trained models converge on the same classification through a structured protocol, the task is well-defined ({cite:p}`webb_2026_concept_mapper`).

> **Reflection prompt:** You inherit a pipeline with no golden test set. How do you build one? What's your minimum viable test set — and what's the difference between "good enough to start" and "good enough to ship"?

### 8.5 The Tailored Crosswalk as Evaluation Design Tool

The crosswalk is not a checklist to fill out after you've built the system. It's a design tool you apply *before* you build, to identify what needs to be measured and why.

**How it works in practice:** For each design choice in your pipeline, ask: what FCSM quality dimension does this address? What NIST trustworthiness characteristic? If a design choice doesn't map to any quality concern, it's either unnecessary or you haven't identified the concern yet.

Present the two tailored crosswalks from the paper:

**Implementation A (Survey Harmonization — batch classification):**
- Multi-vendor rater agreement → Accuracy & Reliability + Coherence / Valid & Reliable
- Randomized presentation order → Accuracy & Reliability / Valid & Reliable
- Structured arbitration with written reasoning → Scientific Integrity + Transparency / Accountable & Transparent
- Public code, prompts, and data → Transparency + Accessibility / Accountable & Transparent

**Implementation B (Statistical Consultation — real-time):**
- Accuracy of data values → Accuracy & Reliability / Valid & Reliable
- Uncertainty communication → Accuracy & Reliability + Transparency / Accountable & Transparent + Explainable & Interpretable
- Fitness-for-use guidance → Relevance + Coherence / Explainable & Interpretable
- Grounding compliance (binary gate) → structural design property / Valid & Reliable

**The key difference:** Implementation A operates in batch with expert review after the fact — explainability requirements are low. Implementation B operates in real time with no independent verification — explainability is operationally critical. **The same crosswalk structure produces different emphasis patterns based on operational context.** This is exactly how evaluation frameworks should work: stable structure, contextual emphasis.

### 8.6 Continuous Evaluation, Not Snapshot Testing

Snapshot benchmarks test whether the system works *right now*. Production pipelines need to know whether the system *continues* to work over time.

**SWE-CI as cautionary tale.** {cite:t}`chen_2026_sweci` tested 18 AI coding models on 100 real codebases spanning an average of 233 days and 71 consecutive commits. 75% of models broke previously working code during long-term maintenance. An agent that passes all tests today can introduce regressions tomorrow. The EvoScore metric — weighting later iterations more heavily to catch degradation — captures exactly the concern that snapshot testing misses.

**The same principle applies to data pipelines.** A classification model that achieves κ = 0.843 today may drift as model updates change the underlying behavior. A consultation system that grounds correctly today may smear semantics after a model version change. Continuous evaluation means:

- **Scheduled regression runs.** Run the golden test set on a fixed cadence, not just when you think something changed. Model providers push silent updates.
- **Drift detection.** Monitor agreement rates, confidence distributions, and failure mode patterns over time. A gradual shift in agreement rate is a signal, not noise.
- **Model version logging.** Record which model version produced which output. When drift is detected, you need to identify *when* it started and *what changed*.
- **Change-triggered re-evaluation.** Any pipeline change — model update, prompt revision, schema change, dependency update — triggers a full regression run before deployment.

> **Reflection prompt:** Your pipeline has been running in production for six months. Agreement rates have been stable at 94%. This month they drop to 88%. Is this a problem? What's your decision process — and at what threshold would you halt the pipeline?

### 8.7 Evaluation Economics

Evaluation is not free. Design your evaluation budget alongside your inference budget.

**The Concept Mapper evaluation:** Under $100 in API costs for the full classification pipeline — 7,000 questions, three models, structured arbitration ({cite:p}`webb_2026_concept_mapper`). The evaluation was *built into* the pipeline — multi-model agreement, behavioral analysis, and arbitration protocols were not separate evaluation activities; they were the pipeline itself.

**The Pragmatics evaluation:** Approximately $15 in API costs for the three-stage evaluation pipeline — nine LLM judges from three vendors evaluating across five quality dimensions ({cite:p}`webb_2026_crosswalk`). Cost is not the barrier to evaluation. *Design* is the barrier.

**The evaluation trap economics:** Months of model comparison on generic benchmarks produces conclusions that are obsolete by publication. The cost is not API fees; it's researcher time spent on evaluation activities that don't produce actionable results for the specific pipeline. Design evaluation that tests *your system* on *your data*, and the economics improve dramatically.

### 8.8 What Evaluation Cannot Do

Be honest about limits:

1. **Evaluation cannot prove the absence of confabulation.** It can provide evidence that the system handles known cases correctly. It cannot guarantee behavior on unseen cases. This is why human-in-the-loop review remains necessary for high-stakes applications.

2. **Evaluation frameworks are not validation studies.** The crosswalk is an evaluation framework translation, not empirical validation. Practitioners applying it bring their own institutional context, and interpretations may reasonably differ ({cite:p}`webb_2026_crosswalk`).

3. **Multi-model agreement is not ground truth.** Models sharing training corpora are not statistically independent. High agreement may reflect correlated bias, not correctness. Behavioral analysis (showing genuinely different decision patterns across vendors) is evidence against — but not proof against — correlated failure.

4. **Evaluation is continuous, not complete.** There is no point at which you have "finished" evaluating. Models update, requirements change, edge cases emerge. Evaluation is an operating cost, not a one-time capital expenditure.

### 8.9 Thought Experiment: The Annual Quality Review

**Scenario:** Your agency has been running an LLM-assisted coding pipeline for 12 months. You're asked to present an annual quality review to the agency head. Consider:

1. What evidence would you present? (Hint: if you haven't been collecting it continuously, you don't have it.)
2. How do you characterize the pipeline's quality in terms your agency head understands — FCSM dimensions, not F1 scores?
3. The agency head asks: "How do we know this system isn't making confident mistakes we haven't caught?" What is your honest answer?
4. A colleague proposes switching to a newer, cheaper model that scores better on public benchmarks. What evaluation would you require before approving the switch? What evidence from the benchmarks would you *not* accept as sufficient?

### 8.10 Chapter Bridge

Evaluation tells you how the system is performing *right now*. But LLM-powered pipelines don't stand still. Models update silently. Context windows drift. Training cutoffs mean the system's knowledge of the world is always stale relative to the data it processes. Chapter 9 addresses what happens when the instrument changes under you — state, drift, and the validity framework (SFV) for reasoning about whether your pipeline is still measuring what you think it's measuring.

---

## New BibTeX Entries to Add to `book/references.bib`

The following citations are used in Ch 8. Most are already in `references.bib` (verified in session 7). New entries from the YouTube research routing (Mazeika et al., Chen et al.) should already be added by the prior CC task (`2026-03-29_register_youtube_research_routing.md`).

### Citations already in `references.bib`:
| Key | Used in Ch 8 |
|-----|-------------|
| `webb_2026_crosswalk` | Primary evaluation framework — crosswalk paper (Sections 8.2–8.5, 8.7–8.8) |
| `nist_ai_rmf_2023` | NIST AI RMF Valid & Reliable as foundational (Section 8.3) |
| `webb_2026_concept_mapper` | Golden test sets, multi-model agreement, evaluation economics (Sections 8.4, 8.7) |
| `nist_genai_2024` | AI 600-1 confabulation identification (Section 8.3) |

### Citations to be added by prior CC task:
| Key | Used in Ch 8 |
|-----|-------------|
| `mazeika_2025` | RLI benchmark, 2.5% completion rate (Section 8.1 opening hook) |
| `chen_2026_sweci` | SWE-CI, 75% regression rate, EvoScore (Section 8.6) |

### Citations to verify:
- [ ] Confirm `mazeika_2025` and `chen_2026_sweci` were added by the prior CC task execution
- [ ] Confirm `nist_genai_2024` key matches the existing bib entry for AI 600-1
- [ ] Verify all `{cite:t}` and `{cite:p}` role references resolve against the bib file

---

## CC Task Execution Instructions

### Step 1: Verify prerequisite BibTeX entries
Confirm that `mazeika_2025` and `chen_2026_sweci` are present in `book/references.bib` (should have been added by `2026-03-29_register_youtube_research_routing.md`). If missing, add them per the BibTeX entries in that CC task.

### Step 2: Replace chapter placeholder
Replace the entire contents of `book/chapter-08.md` with the full chapter draft. Apply the following conventions:

- All citations use `{cite:t}` (narrative) or `{cite:p}` (parenthetical) MyST roles
- Reflection prompts formatted as blockquotes (`>`) at natural pause points
- Thought experiment is a substantial scenario
- Chapter bridge connects forward to Ch 9
- `<!-- STATUS: Draft -->` comment at top
- `<!-- Primary Working Principle: If it cannot be explained, do not use it -->` comment
- `<!-- Primary Tenet: Defensibility is required -->` comment

### Step 3: Run `seldon verify`
After writing, verify artifact integrity.

---

## Open Questions for Author Review

1. **Crosswalk depth.** The chapter references the crosswalk paper extensively but doesn't reproduce the full mapping tables. Is the current level of detail sufficient, or should the tailored crosswalk tables (Tables 7 and 8 from the paper) be reproduced in full?

2. **FCSM 25-03 reference.** The crosswalk paper mentions FCSM 25-03 (AI-Ready Federal Statistical Data, 2025) as addressing one direction of the AI-statistics intersection. Should Ch 8 cite it directly? It's not currently in `references.bib`.

3. **The evaluation trap anecdote.** The chatbot team that refused golden questions is referenced but universalized. Confirm this framing is adequate — no identifying details needed.

4. **Pragmatics evaluation detail.** The three-stage evaluation pipeline from the crosswalk paper (nine LLM judges, three vendors, five dimensions) is described briefly. Should Ch 8 go deeper into the evaluation methodology, or leave that to the crosswalk paper and just cite it?

5. **Confabulation terminology.** The crosswalk paper uses "confabulation" (consistent with NIST AI 600-1) rather than "hallucination." Ch 8 follows this. Confirm consistency with the rest of the book — Ch 1 and Ch 2 may use "hallucination" in places.

6. **SFV connection.** The chapter bridge points to Ch 9 and SFV. Is there any SFV-specific vocabulary that should be introduced in Ch 8 to prepare the ground, or should Ch 9 handle all SFV introduction?

7. **RLI citation scope.** The RLI is used only as the opening hook. It could also appear in Ch 1 (thesis evidence) per the YouTube routing design note. Confirm: use in both, or reserve for one chapter?
