# CC Task: Chapter 2 Draft — Classification & Coding Workflows

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Target file:** `book/chapter-02.md`
**Depends on:** Chapter 1 (stable), `book/references.bib`

---

## Task

Replace the placeholder content in `book/chapter-02.md` with a full chapter draft. This is the book's first domain workflow chapter — where the design principles from Ch 1 meet a real system.

## Chapter Thesis

Classification is the natural entry point for LLMs in statistical workflows because it maps to what they already do well — pattern matching against structured taxonomies. But "works in a demo" is not "reliable enough for production." The gap is entirely a design problem, and the design patterns that close it are borrowed from what statisticians already know about inter-rater reliability, not invented from scratch.

## Primary Case Study

The Federal Survey Concept Mapper: 6,954 survey questions classified into a 152-subtopic Census taxonomy using dual-model cross-validation (GPT-5-mini + Claude Haiku 4.5), with structured arbitration for disagreements. Topic-level agreement κ = 0.839. Total classification cost ~$15. Full pipeline including barrier rating and arbitration: ~$100. Public repo: `github.com/brockwebb/federal-survey-concept-mapper`.

## Organizing Framework

- **Primary tenet:** Deliver capability quickly (Tenet 3)
- **Primary working principle:** Adoption determines impact (WP 3)
- **Secondary connections:** If it cannot be explained, do not use it (WP 1); Outputs require full provenance (WP 8)

## Pedagogical Pattern (Feynman)

Follow the established chapter pattern: opening hook → core content with distributed reflection prompts → thought experiment → chapter bridge.

## Chapter Structure

### Opening Hook

You have 7,000 survey questions and need to classify them into 152 categories. A single model gets it right about 85% of the time. Is that good enough? (The answer depends entirely on what you do with the other 15% — and whether you can even identify which 15% it is.)

Set up the stakes: classification is the most common first use case for LLMs in statistical workflows. It's also the use case where single-model reliance creates the most invisible risk — because classification errors are silent. A wrong label doesn't throw an exception. It just sits there, propagating downstream.

### Section 1: Why Classification First

LLMs as pattern matchers against structured taxonomies. Classification tasks have ground truth (or at least expert consensus), making them evaluable — unlike open-ended generation where "correct" is ambiguous. This is where the "stochastic tax" concept from Ch 1 gets its first concrete application.

Key points:
- Classification maps to existing statistical workflows (occupation coding, industry coding, document categorization, survey question mapping)
- LLMs have a structural advantage over traditional NLP for classification: they can reason about hierarchical taxonomies, not just match tokens
- But: a single LLM call is a single opinion from a single rater. Statisticians would never accept a single human rater's judgment as definitive. Why would you accept a single model's?

**Brief aside: Try the cheap thing first.** Before using LLMs at all, the Concept Mapper project tested whether semantic embeddings (RoBERTa-large) could match questions to taxonomy labels through cosine similarity. Result: perfectly flat distributions. Every question was equally similar to every concept (0.64% each after normalization, σ = 0.000). Root cause: information asymmetry — comparing 100-word detailed questions to 2-word concept labels is like comparing a novel to the single word "mystery." The failure was empirically documented and provided clear justification for moving to LLMs. This is good engineering: try the cheaper approach, document why it fails, then move to the more capable (and more expensive) tool with evidence.

Add BibTeX entry for the Concept Mapper: `webb_2026_concept_mapper` — Webb, B. (2026). AI-Assisted Federal Survey Harmonization: Cross-Survey Integration Analysis of 47 Census Bureau Demographic Surveys. Draft working paper. Available at github.com/brockwebb/federal-survey-concept-mapper.

**Reflection prompt (after Section 1):** "Think about a classification task in your own work. How would you know if your model was getting it wrong? What would 'wrong' even mean — wrong category, wrong confidence, or wrong for a reason that matters downstream?"

### Section 2: The Single-Model Trap

One model, one call, one answer. What's wrong with this picture?

- No internal consistency check. You can't distinguish confident-correct from confident-wrong.
- No position bias detection. The order in which options are presented to the model affects the classification — and you'd never know.
- No systematic bias detection. A single model's training data and alignment create blind spots that are invisible from inside that model's outputs.
- The "algorithmic echo chamber" — when a single system's tendencies dominate results, the outputs feel polished but are predictably biased in ways you can't see without an external reference point.

The analogy: running a survey with a single interviewer and no inter-rater reliability checks. No methodologist would accept that design. The same logic applies to LLM-based classification.

Frame this NOT as "single-model is bad" but as "single-model gives you no way to measure your own uncertainty." The fix isn't more models for the sake of more models — it's designing your system to produce its own quality metrics.

### Section 3: Dual-Model Cross-Validation

The Concept Mapper pattern: two architecturally distinct models (different vendors, different training data, different alignment approaches) classify independently. Agreement analysis routes outputs through three paths:

- **Consensus (68.5%):** Both models agree on topic and subtopic. High confidence, auto-accept.
- **Auto dual-modal (11.8%):** Both models are highly confident (≥0.90) but assign different primary topics. The question genuinely spans two domains. Assign higher-confidence model's topic as primary, lower as secondary.
- **Arbitration (19.7%):** Models disagree and at least one has low confidence. Escalate to a more capable model (Claude Sonnet 4.5) with access to both prior judgments.

Key design insight: **disagreement is signal, not noise.** When two independently trained systems disagree, one of three things is true: (1) one is wrong and the other is right, (2) both are wrong, or (3) the question is genuinely ambiguous. All three are valuable information. Option (3) — genuine ambiguity — is something a single model would silently resolve by picking one answer, hiding the ambiguity from you entirely.

The independently-trained-neural-network analogy: LLMs are independently trained neural networks, just as human raters are independently trained neural networks (with very different architectures but the same fundamental property of independent training producing independent biases). The methods for managing variability across human raters — inter-rater reliability, agreement statistics, structured arbitration — apply directly. This isn't a novel insight; it's a transfer of existing statistical methodology to a new context. The gap is that most people building with LLMs come from software engineering (where determinism is the default) rather than from the statistical sciences (where managing variability is the core discipline).

Present Cohen's κ = 0.839 at topic level, 0.687 at subtopic level. Assume audience familiarity with κ interpretation — these are federal statisticians. Note that subtopic disagreement at finer granularity is expected and informative, not a failure.

**Reflection prompt (after Section 3):** "If both models agree on a wrong answer, what does that tell you about the taxonomy, not the models? When should you suspect that agreement is masking a shared blind spot?"

### Section 4: Confidence Routing and the Division of Labor

Not every classification needs the same treatment. The Concept Mapper implements confidence-based routing:

- **High agreement, high confidence → auto-accept.** The vast majority of classifications. No human attention needed.
- **High agreement, edge cases → flagged for batch review.** Periodic quality checks.
- **Disagreement → structured arbitration.** More capable model reviews with full context.
- **Persistent ambiguity → expert review queue.** The ~38 questions (0.5%) that all models struggled with go to human domain experts.

The result: out of 1,598 question pairs evaluated in the harmonization stage, only 142 candidate bridge variables needed expert review. The pipeline reduced expert workload by an order of magnitude — not by replacing expert judgment, but by directing it where it adds the most value.

This is the design principle: **AI handles volume, humans handle judgment.** The pipeline's job is to sort the easy cases from the hard cases and present experts with a curated review list, not a haystack.

Cost context: the dual-model classification of 6,954 questions cost ~$15 in API fees and ran in ~2 hours. The counterfactual — a research team manually classifying 7,000 questions into 152 categories — would take months. But state this honestly: the $15 API cost is real, and the human engineering cost to design, debug, and validate the pipeline dwarfs it. That ratio inverts as you build reusable patterns and gain experience — which is part of the point of this book. (Ch 14 addresses cost accounting in full.)

### Section 5: Order Effects and the ABBA Design

Position bias: the order in which options or question pairs are presented to a model affects its output. This is well-documented in survey methodology (primacy/recency effects) and equally present in LLM behavior.

The ABBA design: for every evaluation, randomize the presentation order. If the model's judgment changes when Question A is presented before Question B versus after, the judgment is unstable and shouldn't be trusted.

In the Concept Mapper's harmonization stage, all three rater models received question pairs with randomized A/B order, and all three arbitrator models received prior judgments in randomized order with blind masking (vendor identities removed). This prevents anchoring on whichever judgment appears first.

The practical takeaway: any time you're asking a model to compare, rank, or choose between options, randomize the presentation order and check whether the results are order-invariant. If they're not, you have a measurement problem, not a classification problem.

**Reflection prompt (after Section 5):** "What other sources of systematic bias could affect your classifications that order randomization won't catch? Think about the taxonomy itself, the prompt wording, and the training data."

### Section 6: Arbitration — When Models Disagree

What happens when the raters don't agree? The Concept Mapper uses a structured protocol:

1. **Three independent rater models** (one per vendor — OpenAI, Anthropic, Google) evaluate each pair on feasibility and barrier type.
2. **Initial agreement:** Fleiss' κ = 0.537 for feasibility, 0.611 for barrier classification. Moderate — which is expected at the rater stage.
3. **Three independent arbitrator models** (higher-capability models from the same three vendors) review all pairs with access to all prior judgments. Blind masking prevents anchoring. Order randomization prevents position bias.
4. **Post-arbitration agreement:** κ = 0.843 for feasibility, 0.796 for barrier classification. Almost perfect.

The pattern: moderate initial agreement converging to near-perfect after structured arbitration. This validates that the task is well-defined and that independent models can reach consensus when given a protocol for resolving ambiguity.

Design choice: **why three vendors, not three models from one vendor?** Because vendor diversity is a stronger independence guarantee than model diversity within a single vendor's family. Models from the same vendor share training pipelines, alignment approaches, and organizational biases. Cross-vendor agreement is harder to achieve and more meaningful when it occurs. This is the methodological equivalent of requiring independent expert raters from different institutions.

Design choice: **why not just take the majority vote?** Because majority vote discards reasoning. The arbitration protocol requires the arbitrator to select or synthesize a verdict and provide reasoning. That reasoning is a traceable artifact — you can audit why a particular classification was made. Majority vote gives you an answer; arbitration gives you an answer with a justification.

Note: the barrier taxonomy (F1/F2/F3 feasibility tiers, CC/TC/RS/PC/MC/PM barrier codes) used in the harmonization stage was adopted from existing survey harmonization frameworks — DataSHaPER (Fortier et al., 2011; 2017) and Wolf et al. (2016). This is itself a design pattern: **use established domain frameworks as your structured output schema rather than inventing your own.** When your LLM outputs map to categories that domain experts already recognize, validation is dramatically easier.

Add BibTeX entries:
- `fortier_2011` — Fortier, I., Doiron, D., Little, J., et al. (2011). Is rigorous retrospective harmonization possible? Application of the DataSHaPER approach across 53 large studies. International Journal of Epidemiology, 40(5), 1314–1328.
- `fortier_2017` — Fortier, I., Raina, P., van den Heuvel, E.R., et al. (2017). Maelstrom Research guidelines for rigorous retrospective data harmonization. International Journal of Epidemiology, 46(1), 103–115.
- `wolf_2016` — Wolf, C., Schneider, S.L., Behr, D., & Joye, D. (2016). Harmonizing survey questions between cultures and over time. In C. Wolf et al. (Eds.), The SAGE Handbook of Survey Methodology (pp. 502–524). SAGE.

### Section 7: Model Transience as a Design Constraint

The models you use today will not be the models you use in six months. They may be deprecated, superseded, or subtly changed through updates. Your prompts may stop working. Your benchmarks may shift.

This is not a surprise — it's a design constraint. Design for it:

- **Golden questions:** Maintain a small, human-validated set of classification examples with known correct answers. Run them through your pipeline on a regular schedule (weekly is cheap). Compare results to your baseline. If agreement degrades, investigate before the drift propagates.
- **Model-agnostic pipeline design:** Your pipeline should specify *roles* (rater, arbitrator), not specific model names. Swapping GPT-5-mini for Gemini Flash or Claude Haiku for a future model should be a configuration change, not a rewrite.
- **Version pinning with expiration dates:** Pin your model versions for reproducibility, but schedule regular reviews. A model version that's a year old may no longer be available — or may have been quietly updated.

The broader point: the design patterns in this chapter — dual-model cross-validation, confidence routing, structured arbitration — are model-independent. The specific models are interchangeable. The architecture is the durable asset.

Connect forward: Ch 9 (State, Drift, and Validity) treats model transience as a formal validity concern through the SFV framework. This section plants the practical seed.

### Section 8: Provenance — or, What Happens Six Months Later

Brief section (2-3 paragraphs, not a full treatment — Ch 10 handles that).

The Concept Mapper produced reliable results. Reconstructing *how* those results were produced — which model versions, which prompts, which arbitration decisions, which intermediate outputs — after the fact was a multi-day effort. The pipeline worked; the provenance wasn't baked in.

This is a common pattern in early LLM projects: the output quality and the process traceability are decoupled. You get great results and no audit trail. For a research project, that's recoverable (painfully). For a production system in a federal agency, it's a showstopper — because institutional trust requires not just correct results but demonstrable provenance of how those results were produced.

The lesson: build traceability from the start. Log your model versions, prompt templates, input hashes, and arbitration decisions as pipeline artifacts, not as afterthoughts. Ch 10 provides the full treatment.

### Thought Experiment

You're tasked with coding 500,000 job descriptions into Standard Occupation Classification (SOC) codes. You have budget for 10,000 human-coded training examples and access to two LLM APIs. Design the workflow:

- Which job descriptions get human-coded first? (Hint: not a random sample — think about taxonomy coverage and edge cases.)
- How do you route classifications: which go to auto-accept, which to human review?
- How do you detect when your system is degrading over time — and what triggers a recalibration?
- At what point does adding a third model help, and at what point is it just adding complexity?

This connects forward to Ch 8 (evaluation by design) and Ch 9 (drift detection).

### Chapter Bridge

Classification produces structured labels. Those labels are only as useful as what you do with them downstream. If you're cleaning data, the classifications tell you which records to route to which cleaning rules (Ch 3). If you're extracting entities, the classifications scope the extraction task (Ch 4). And the ensemble and arbitration patterns introduced here — dual-model, confidence routing, structured disagreement resolution — are cross-cutting designs that apply to every workflow in this book. Ch 5 generalizes them into the multi-model playbook.

But first: a classification label on a dirty record is a label on a dirty record. Ch 3 addresses what happens when the data itself needs repair.

## Tone and Style

- Write as a practitioner teaching practitioners. Not academic, not casual — direct.
- Use the Concept Mapper as illustration, not recapitulation. The reader doesn't need to understand survey harmonization — they need to see the design patterns and recognize how to apply them to their own classification tasks.
- Be honest about what was hard. The $15 API cost is real; the engineering hours to get there dwarfed it. Say so.
- The "LLMs as independently trained neural networks" frame should feel like a realization, not a lecture — "of course the same inter-rater reliability methods apply."
- Do not name any specific agency or individual in institutional friction examples. Frame these as universal patterns.

## Citations

Use `{cite:t}` for narrative citations, `{cite:p}` for parenthetical. All new citations get BibTeX entries in `references.bib`. Keys follow `firstauthor_year` convention.

New BibTeX entries to add:
- `webb_2026_concept_mapper` (working paper / repo)
- `fortier_2011` (DataSHaPER)
- `fortier_2017` (Maelstrom)
- `wolf_2016` (SAGE Handbook harmonization)
- `dell_acqua_2023` (Harvard study on AI and creativity — Dell'Acqua, F., et al. (2023). Navigating the Jagged Technological Frontier. Harvard Business School Working Paper No. 24-013.) — for the echo chamber / homogenization point if used

Existing entries to reference: `becker_2025`, `dora_2024`, `shumailov_2024` (if relevant for drift/degradation context)

## Length Target

Comparable to Ch 1 and Ch 12 — substantial but not sprawling. The chapter earns its length through concrete examples, not through exhaustive methodology. Target 20-30 pages rendered.

## What This Chapter Is NOT

- It is NOT a recapitulation of the Concept Mapper paper. The paper reports results; the chapter teaches design patterns using the paper as illustration.
- It is NOT a tutorial on Cohen's κ or Fleiss' κ. The audience knows inter-rater reliability.
- It is NOT an argument for multi-model over single-model as a religious position. It's an argument for designing systems that produce their own quality metrics — and multi-model happens to be the most practical way to do that.
- It is NOT a survey harmonization chapter. The barrier taxonomy is referenced as an example of structured output schema design, not taught as domain content.

## Files to Modify

1. `book/chapter-02.md` — replace placeholder with full draft
2. `book/references.bib` — add new BibTeX entries listed above

## Verification

After execution, verify:
- All `{cite:t}` and `{cite:p}` references resolve against `references.bib`
- No bare prose citations (all use MyST roles)
- No `[NEEDS:]` markers remain unless genuinely unresolved
- Chapter follows the pedagogical pattern (hook → content → reflection prompts → thought experiment → bridge)
- Concept Mapper statistics match the published paper (κ values, question counts, cost figures, agreement percentages)
