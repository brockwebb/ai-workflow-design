# CC Task: Draft Chapter 5 — The Ensemble & Multi-Model Playbook

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Target file:** `book/chapter-05.md`
**Type:** Full chapter draft (replaces placeholder)
**Session:** 7

---

## Organizing Framework Alignment

**Primary Working Principle:** Outputs require full provenance
**Primary Tenet:** Defensibility is required

## Pedagogical Pattern

- **Opening hook:** A scenario where a single-model classification pipeline silently miscategorizes records — nobody notices because there's nothing to disagree with. Contrast with what happens when you add a second model: the disagreements surface ambiguity that was always there.
- **Core content:** Three multi-model topologies, model selection framework, design decision matrix
- **Reflection prompts:** Distributed throughout (minimum 3)
- **Thought experiment:** At least one substantial scenario (specified below)
- **Chapter bridge:** Forward to Ch 6 (Parallel, Serial, and the Bottleneck) — once you know *which* topology, Ch 6 addresses *how* the pieces execute in practice

---

## Chapter Structure

### 5.1 Opening: The Silence of a Single Model

Hook: When a single model processes 10,000 records and returns 10,000 answers, the output *looks* clean. There are no disagreements, no flags, no ambiguity. But silence isn't the same as accuracy. The single-model pipeline doesn't surface what it doesn't know — it buries it in confident-sounding output. The first time you add a second model, you discover how much uncertainty was hidden.

Connect to Ch 2: The Federal Survey Concept Mapper ({cite:p}`webb_2026_concept_mapper`) found that dual-model disagreement surfaced genuine ambiguity in survey question semantics — cases where the "right" classification was legitimately debatable. That disagreement wasn't a bug; it was the most valuable output of the pipeline.

State the chapter's thesis: **Multi-model is the baseline, not the advanced technique. Single-model is what needs justification.** This chapter provides the design patterns for three fundamentally different multi-model topologies, plus a framework for choosing between them.

### 5.2 Topology 1: Parallel Consensus

This is the pattern covered in detail in Ch 2. Summarize briefly and generalize — do NOT re-teach the Concept Mapper case study. The reader has already seen it.

**Pattern:** N models receive the same input independently. Outputs are compared. Agreement indicates confidence; disagreement triggers escalation or adjudication.

**Key design elements (abstracted from Ch 2):**

1. **Model selection for diversity of failure modes.** The goal is not N copies of the same bias — it's N independently-trained systems with different architectural assumptions. Models sharing training corpora (Common Crawl, Wikipedia) aren't statistically independent, but different architectures, training objectives, RLHF tuning, and parameter configurations produce meaningfully different bias profiles — correlated but not identical failure modes.

2. **Quantitative agreement definition.** "Agreement" must be defined for the domain: token match, semantic similarity, structured output field comparison. The Concept Mapper used structured output comparison against a fixed schema (DataSHaPER categories) — the agreement metric was whether two models mapped a survey question to the same harmonized variable ({cite:p}`fortier_2011`; {cite:p}`wolf_2016`).

3. **Decision logic: N outputs → 1 decision.** Majority vote? Confidence-weighted arbitration? Human-in-the-loop above a disagreement threshold? The decision rule must be versioned and auditable.

4. **Inter-rater reliability as the native evaluation framework.** LLMs as independently trained neural networks are directly amenable to inter-rater reliability methods — Cohen's kappa, Fleiss' kappa, Krippendorff's alpha. This is a transfer of existing statistical methodology, not a novel invention ({cite:p}`webb_2026_concept_mapper`).

**ABBA design (position bias control):** Run Model A then Model B on the same input, then Model B then Model A. If results change based on order, you've detected position bias in your evaluation, not a real difference in model capability. This is standard counterbalancing from experimental design.

**The constrained pool reality:** Federal statistical agencies operate within a bounded set of Western frontier models where they have visibility into training methodology and corporate governance. You're optimizing within a constrained pool, not selecting from an infinite market. Two-vs-three models isn't the point — the point is: more than one look, stored comparisons, and a decision rule for disagreements.

> **Reflection prompt:** You're designing a classification pipeline and your two models agree on 97% of cases. Is that 3% disagreement rate a sign of success or failure? What would you need to know to decide?

### 5.3 Topology 2: Generator-Critic Loops (Iterative Refinement)

This is a fundamentally different shape from parallel consensus. In consensus, models perform the *same task* independently. In a generator-critic loop, models perform *different tasks* in sequence: one generates, another evaluates, and the evaluation feeds back to improve the generation.

**The canonical pattern: Self-Refine.** {cite:t}`madaan_2023` introduced the Self-Refine framework: a single LLM generates an initial output, then provides feedback on its own output, then uses that feedback to refine iteratively. Across seven tasks, Self-Refine improved task performance by approximately 20% over single-shot generation.

**The critical limitation: same-model self-refinement degrades.** This is where the chapter gets interesting for research workflows. {cite:t}`huang_2024` demonstrated that LLMs cannot reliably self-correct their own reasoning without external feedback. {cite:t}`xu_2024` showed that LLMs amplify their own biases during self-refinement (the "pride and prejudice" effect). {cite:t}`pan_2024` documented spontaneous reward hacking in iterative self-refinement — the model learns to game its own evaluation criteria. {cite:t}`yang_2025` provided a probabilistic inference framework showing why self-correction has theoretical limits. {cite:t}`lee_2025` benchmarked these degradation patterns empirically.

**The design implication for statistical production:** Same-model self-refinement is a trap for research workflows. The model's blind spots are *systematic* — asking it to critique its own output doesn't surface errors it can't see. The signal degrades, not improves, after the first few iterations.

**The cross-model variant:** The more robust design separates the generator from the critic:

- **Model A** generates structured output (e.g., extracts fields from administrative records into a target schema)
- **Model B** evaluates the output against schema constraints — not just "is this valid JSON" but "does this field value make semantic sense given the other fields?"
- **Feedback loop:** Model B rejects with specific reasons → Model A (or Model C) gets another pass with the rejection rationale appended to the prompt
- **Termination conditions:** Maximum iterations (hard cap), critic passes all checks, confidence threshold met, or escalation to human review

**Design questions unique to this topology:**

- *How many iterations before you bail?* The degradation literature suggests diminishing returns after 2–3 rounds for most tasks. Design your termination condition conservatively.
- *Does quality actually improve on retry, or does it oscillate?* Monitor the trajectory. If iteration 3 is worse than iteration 2, you have oscillation, not convergence. Stop.
- *What's the prompt architecture for feeding rejection reasons back?* The rejection must be specific and actionable, not "try again." Vague feedback produces vague revisions.
- *When does the critic become the bottleneck?* If the critic model is slower or more expensive than the generator, your loop economics invert. Cost the full cycle, not just the generation step.

**When this topology earns its place:** Complex extraction or generation tasks where the output must conform to a formal schema. Tasks where partial correctness is common (the model gets 8 of 10 fields right, but the remaining 2 need targeted revision). Tasks where the cost of a human review pass exceeds the cost of an automated critique loop.

> **Reflection prompt:** You design a generator-critic loop and notice that the critic approves 95% of outputs on the first pass. Is the critic too lenient, or is the generator that good? How would you calibrate?

### 5.4 Topology 3: LLM-as-Judge (Arbiter Patterns)

The judge pattern is architecturally distinct from both consensus and refinement. It's *delegation* — a model explicitly tasked with meta-evaluation of another model's output against defined criteria.

**The research landscape.** {cite:t}`gu_2024` provide a comprehensive survey of LLM-as-a-Judge systems, addressing how to build reliable LLM evaluators. {cite:t}`li_h_2024` offer a complementary survey structured around functionality, methodology, and applications of LLM-based evaluation. Both surveys identify core challenges: consistency, bias mitigation, and rubric design.

**Key design concern: preference leakage.** {cite:t}`li_d_2024` exposed a contamination problem: when the judge model is *related* to the generator model — same model, same family, or fine-tuned from the same base — the judge exhibits systematic bias toward that model's outputs. This directly reinforces the multi-model diversity argument. **Your judge should not be your generator's cousin.**

**Rubric design as the practitioner skill.** Unlike consensus (where agreement is the metric) or critic loops (where schema conformance is the check), judge patterns require *explicit evaluation criteria*. The rubric defines what "good" means. For statistical production, rubrics should be:

- **Domain-grounded.** Evaluation criteria drawn from existing quality frameworks (e.g., FCSM standards, agency style guides, subject-matter definitions)
- **Decomposed.** Multi-trait evaluation outperforms holistic scoring — break the judgment into separate dimensions (accuracy, completeness, format compliance, semantic coherence)
- **Versioned and auditable.** The rubric is part of the pipeline configuration. When it changes, the change is tracked.

**Judge pattern variants:**

1. **Tie-breaking arbiter.** Models A and B disagree; Model C adjudicates. Different from consensus because C is evaluating A and B's *outputs*, not performing the original task independently.
2. **Quality gate.** Every output passes through a judge before entering the production pipeline. The judge scores against the rubric; outputs below threshold are flagged for human review.
3. **Pairwise comparison.** The judge receives two candidate outputs and selects the better one against criteria. Useful for prompt optimization and model selection experiments.

**Failure modes specific to this topology:**

- *The judge lacks domain knowledge.* A general-purpose LLM evaluating domain-specific statistical output may not catch errors that a subject-matter expert would.
- *Rubric gaming.* Models optimized against a rubric will find shortcuts that satisfy the letter but not the spirit of the criteria — a form of Goodhart's Law applied to LLM evaluation.
- *Who judges the judge?* At some point, human calibration is required. Golden test sets, periodic human agreement checks, and rubric revision cycles are part of the operating cost.
- *Position bias in pairwise comparison.* The order in which candidates are presented affects the judge's preference. ABBA counterbalancing (from Section 5.2) applies here too.

> **Reflection prompt:** You deploy an LLM judge to quality-check extraction outputs. After a month, you notice the approval rate has climbed from 82% to 96%. Is the generator improving, or has the judge drifted? What data would you need to tell the difference?

### 5.5 The Design Decision: Choosing Your Topology

Not every problem needs a multi-model solution. Not every multi-model solution needs a complex topology. This section provides a decision framework.

**When parallel consensus fits:**
- Classification tasks with discrete output categories
- Tasks where you have an existing evaluation framework (inter-rater reliability)
- High-volume batch processing where you can afford 2–3x the API cost
- Cases where disagreement itself is the most valuable signal

**When generator-critic loops fit:**
- Complex generation or extraction tasks with schema constraints
- Tasks where partial correctness is the norm (most of the output is right, but specific fields need revision)
- Cases where the cost of a human review pass exceeds an automated critique cycle
- When you need a provenance trail of *why* the output changed between iterations

**When LLM-as-Judge fits:**
- Quality gating before production release
- Model selection and prompt optimization experiments
- Tasks requiring nuanced evaluation against multi-dimensional criteria
- When you need a scalable alternative to human quality review

**When the answer is "none of the above":**
Sometimes the smart design move is not throwing more models at the problem. {cite:t}`lin_2025` demonstrate this with TWIX, a structured data extraction tool that infers the underlying visual template from templatized documents (invoices, police records, tax forms) and then extracts data based on that template — 520× faster and 3,786× cheaper than GPT-4 Vision, with higher accuracy. TWIX uses LLMs sparingly for semantic disambiguation, not as the primary extractor. The lesson: **understand the structure of your problem before reaching for the model.** If the documents share a template, exploit the template. If the classification has a fixed taxonomy, a lookup table handles the easy cases. Multi-model designs earn their place when the task genuinely requires judgment under ambiguity — not when a cheaper, more deterministic approach would suffice.

This connects directly to Ch 2's "try the cheap thing first" principle: the Concept Mapper only moved to LLMs after RoBERTa embeddings failed on the semantic matching task. The LLM solution was the *second* approach, not the first.

### 5.6 Cross-Cutting Design Principles

Regardless of topology, these principles apply:

1. **Version everything.** Model identifiers, prompt versions, rubric versions, confidence thresholds, decision rules. When any component changes, the change is tracked and the pipeline can be rerun with the prior configuration for comparison.

2. **Store the disagreements, not just the resolutions.** The cases where models disagree are your most valuable data for understanding pipeline behavior. Discarding disagreement metadata is discarding your quality signal.

3. **Design for model transience.** Models are deprecated, updated, and replaced. Your pipeline must survive a model swap without architectural redesign. Golden test sets, model-agnostic interfaces, and version pinning with expiration dates are design requirements, not nice-to-haves ({cite:p}`webb_2026_concept_mapper`).

4. **Cost the full cycle, not just the inference call.** A multi-model pipeline's cost includes: API calls for all models, retry/refinement iterations, human review for escalated cases, and the engineering time to maintain the orchestration. The $15 API cost for the Concept Mapper was real — the human engineering cost dwarfed it.

5. **Reprocessing advantage.** Unlike manufacturing, reprocessing data costs electrons, not materials. If a model is updated or a rubric is revised, you can rerun the pipeline. Design around this advantage — store inputs, version everything, and build for reproducibility.

### 5.7 Thought Experiment: The Annual Report Pipeline

**Scenario:** Your agency produces an annual statistical report that requires extracting structured data from 5,000 administrative records (PDF forms from state agencies), classifying each record into one of 12 program categories, and flagging records with potential data quality issues.

You've been asked to design an LLM-powered pipeline. Consider:

1. Which topology (or combination) would you use for the extraction step? For the classification step? For the quality flagging step? Are they the same?
2. The forms come from 50 states with slightly different layouts. Does this change your extraction approach? (Consider: do you need an LLM at all for the structured extraction, or would a template-based approach serve better?)
3. Your budget allows for approximately $500 in API costs per annual run. How does this constrain your topology choices? What would you sacrifice first — the second model, the critic loop, or the judge gate?
4. The report is published once a year but the methodology must be defensible to Congress. How does this change your provenance and auditability requirements versus a pipeline that runs daily for internal use?

### 5.8 Chapter Bridge

You now have three topologies for combining models and a framework for choosing between them. But knowing *which* pattern doesn't tell you *how* the pieces execute. When you run two models on 10,000 records, do they run in parallel or in sequence? How do you handle rate limits? What happens when one model's API goes down mid-batch? Chapter 6 turns from the logical architecture to the physical execution: parallel vs serial processing, batch design, and the engineering gap between a working prototype and a production pipeline — the $15 vs $1,500 lesson.

---

## New BibTeX Entries to Add to `book/references.bib`

```bibtex
@article{gu_2024,
  author    = {Gu, Jiawei and Jiang, Xuhui and Shi, Zhichao and Guo, Jialiang and others},
  title     = {A Survey on {LLM}-as-a-Judge},
  journal   = {arXiv preprint arXiv:2411.15594},
  year      = {2024},
  url       = {https://arxiv.org/abs/2411.15594},
  note      = {Comprehensive survey addressing reliability of LLM-as-a-Judge systems: consistency, bias mitigation, rubric design. Updated through October 2025 (v6).}
}

@article{li_h_2024,
  author    = {Li, Haitao and others},
  title     = {{LLMs}-as-Judges: A Comprehensive Survey on {LLM}-based Evaluation Methods},
  journal   = {arXiv preprint arXiv:2412.05579},
  year      = {2024},
  url       = {https://arxiv.org/abs/2412.05579},
  note      = {Survey structured around functionality, methodology, applications, meta-evaluation, and limitations of LLM judges.}
}

@article{li_d_2024,
  author    = {Li, Dawei and Jiang, Bohan and Huang, Liangjie and Beigi, Alimohammad and Zhao, Chengshuai and Tan, Zhen and Bhattacharjee, Amrita and Jiang, Yuxuan and Chen, Canyu and Wu, Tianhao and Shu, Kai and Cheng, Lu and Liu, Huan},
  title     = {From Generation to Judgment: Opportunities and Challenges of {LLM}-as-a-Judge},
  journal   = {arXiv preprint arXiv:2411.16594},
  year      = {2024},
  url       = {https://arxiv.org/abs/2411.16594},
  note      = {Includes preference leakage analysis: contamination when judge and generator LLMs are related (same model, same family, or fine-tuned from same base).}
}

@article{wang_2022,
  author    = {Wang, Xuezhi and Wei, Jason and Schuurmans, Dale and Le, Quoc V. and Chi, Ed H. and Narang, Sharan and Chowdhery, Aakanksha and Zhou, Denny},
  title     = {Self-Consistency Improves Chain of Thought Reasoning in Language Models},
  journal   = {arXiv preprint arXiv:2203.11171},
  year      = {2022},
  url       = {https://arxiv.org/abs/2203.11171},
  note      = {Foundational paper on sampling multiple reasoning paths and selecting the most consistent answer. Basis for ensemble voting patterns.}
}

@inproceedings{lin_2025,
  author    = {Lin, Yiming and Hasan, Mawil and Kosalge, Rohan and Cheung, Alvin and Parameswaran, Aditya G.},
  title     = {{TWIX}: Automatically Reconstructing Structured Data from Templatized Documents},
  booktitle = {Proceedings of the ACM on Management of Data},
  year      = {2025},
  url       = {https://arxiv.org/abs/2501.06659},
  note      = {Template inference for structured extraction from documents. 520x faster and 3,786x cheaper than GPT-4 Vision. Demonstrates that exploiting document structure outperforms brute-force LLM extraction. Open source: github.com/ucbepic/TWIX.}
}
```

## Citations Status

### Already in `references.bib` (verified present):
| Key | Citation | Used in Ch 5 |
|-----|----------|-------------|
| `madaan_2023` | Madaan, A., et al. (2023). Self-Refine: Iterative refinement with self-feedback. *NeurIPS 2023*. | Section 5.3, generator-critic canonical reference |
| `huang_2024` | Huang, J., et al. (2024). Large language models cannot self-correct reasoning yet. *ICLR 2024*. | Section 5.3, self-refinement limitation |
| `xu_2024` | Xu, W., et al. (2024). Pride and prejudice: LLM amplifies self-bias in self-refinement. | Section 5.3, same-model bias amplification |
| `pan_2024` | Pan, L., et al. (2024). Spontaneous reward hacking in iterative self-refinement. | Section 5.3, reward hacking in loops |
| `yang_2025` | Yang, Z., et al. (2025). A probabilistic inference scaling theory for LLM self-correction. *EMNLP 2025*. | Section 5.3, theoretical limits |
| `lee_2025` | Lee, H., et al. (2025). RefineBench: Evaluating iterative self-refinement in LLMs. | Section 5.3, empirical benchmarking |
| `webb_2026_concept_mapper` | Webb, B. (2026). AI-assisted federal survey harmonization. Draft working paper. | Sections 5.1, 5.2, 5.5, 5.6 |
| `fortier_2011` | Fortier, I., et al. (2011). DataSHaPER across 53 large studies. *IJE*, 40(5). | Section 5.2, structured schema reference |
| `wolf_2016` | Wolf, C., et al. (2016). Harmonizing survey questions. *SAGE Handbook*. | Section 5.2, domain framework adoption |
| `dell_acqua_2023` | Dell'Acqua, F., et al. (2023). Navigating the jagged technological frontier. HBS WP 24-013. | [NEEDS: verify if used — may be optional] |

### New entries to add (listed above):
| Key | Citation | Used in Ch 5 |
|-----|----------|-------------|
| `gu_2024` | Gu, J., et al. (2024). A survey on LLM-as-a-Judge. *arXiv:2411.15594*. | Section 5.4, judge pattern survey |
| `li_h_2024` | Li, H., et al. (2024). LLMs-as-Judges: A comprehensive survey. *arXiv:2412.05579*. | Section 5.4, complementary survey |
| `li_d_2024` | Li, D., et al. (2024). From generation to judgment. *arXiv:2411.16594*. | Section 5.4, preference leakage |
| `wang_2022` | Wang, X., et al. (2022). Self-consistency improves chain of thought reasoning. *arXiv:2203.11171*. | Section 5.2, ensemble voting foundation |
| `lin_2025` | Lin, Y., et al. (2025). TWIX: Automatically reconstructing structured data. *PACMMOD*. | Section 5.5, "none of the above" counterexample |

### Citations to verify before final draft:
- [ ] `gu_2024` — Confirm full author list and publication venue (arXiv confirmed, journal submission status unclear)
- [ ] `li_h_2024` — Confirm full author list (only first author visible in search results)
- [ ] `li_d_2024` — Confirm this is the correct paper for the preference leakage finding (vs. a separate preprint by the same group)
- [ ] `wang_2022` — Confirm this is the original self-consistency paper (Google Brain / DeepMind, 2022; published ICLR 2023)
- [ ] `lin_2025` — Confirm publication venue (PACMMOD 2025 vs. arXiv only); confirm performance claims (520x faster, 3786x cheaper)
- [ ] `dell_acqua_2023` — Decide whether to include in Ch 5 or reserve for later chapter

---

## CC Task Execution Instructions

### Step 1: Add new BibTeX entries
Append the five new entries (listed above) to `book/references.bib`. Maintain alphabetical ordering by key.

### Step 2: Replace chapter placeholder
Replace the entire contents of `book/chapter-05.md` with the full chapter draft. Use the section structure above. Apply the following conventions:

- All citations use `{cite:t}` (narrative) or `{cite:p}` (parenthetical) MyST roles — no bare prose citations
- Reflection prompts are inline in the prose at natural pause points, formatted as blockquotes (`>`)
- The thought experiment is a substantial scenario, not a homework problem
- Chapter bridge connects forward to Ch 6
- No `[NEEDS:]` markers in the draft text — all empirical claims are grounded in cited sources listed above
- Maintain the `<!-- STATUS: Draft -->` comment at the top
- Include the organizing framework alignment as a comment: `<!-- Primary Working Principle: Outputs require full provenance -->`  `<!-- Primary Tenet: Defensibility is required -->`

### Step 3: Run `seldon verify`
After writing, verify artifact integrity.

---

## Open Questions for Author Review

1. **TWIX placement.** TWIX is used here as a "don't over-engineer" counterexample. It could also appear in Ch 4 (Detection & Extraction) as a primary reference. Decide where it earns its place, or use it in both with different emphasis.

2. **Self-consistency paper (Wang et al., 2022).** This is foundational for ensemble voting patterns but may be too deep in the ML weeds for the target audience. Consider whether to cite it or just describe the principle without the citation.

3. **Four-layer validation architecture.** The Ch 5 placeholder notes included a detailed four-layer architecture (Model Selection → Parallel Inference → Evidence Accumulation → Decision Logic). This has been subsumed into the parallel consensus section (5.2) rather than presented as a standalone framework. Confirm this is the right call, or break it back out as a separate section.

4. **Position bias and ABBA.** Currently mentioned in both 5.2 (parallel consensus) and 5.4 (judge patterns). Consider whether to consolidate into one section with cross-references.

5. **Practical constraints section.** The placeholder notes included material on the constrained pool of Western frontier models for federal statistics. This is currently woven into 5.2 rather than broken out. The audience may benefit from a more explicit "federal context" callout.

6. **Code/pseudocode.** Per author decision: no implementation code. Pseudocode only if the algorithm structure is the point. The generator-critic loop termination logic (Section 5.3) is a candidate for a short pseudocode block if the prose description feels insufficient.

7. **Model independence debate.** The placeholder included nuanced material on correlated-but-not-identical failure modes from shared training corpora. This is addressed briefly in 5.2 but could be expanded. Risk: gets too deep into ML theory for the practitioner audience.
