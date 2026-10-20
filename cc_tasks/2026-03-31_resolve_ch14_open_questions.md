# CC Task: Resolve Chapter 14 Open Questions

**Date:** 2026-03-31
**Target file:** `book/chapter-14.md`
**Task type:** Content insertion — resolve three `[OPEN QUESTION]` markers

---

## Context

Chapter 14 has three `[OPEN QUESTION]` markers, all requesting concrete cost data to make the counterfactual argument empirical. Author has provided the estimates. All three questions cluster in the same concept space: making the cost argument land with evidence, not hand-waving.

---

## Change 1: Manual Equivalent Cost Estimate

**Location:** The `[OPEN QUESTION]` marker after the worked example comparison table in the "The Counterfactual: Compared to What?" section.

**Action:** Replace the `[OPEN QUESTION: What would the manual equivalent have cost?...]` block with the following paragraph:

> The manual equivalent: a trained analyst classifying survey questions against the harmonized taxonomy. Assume 8 hours of training on the taxonomy and classification conventions, then a sustained rate of approximately 30 questions per hour — a reasonable estimate for a skilled analyst making judgment calls on semantic alignment. At 6,987 questions, that is 233 analyst-hours of classification work alone. At a fully loaded labor rate of $100 per hour, the manual equivalent costs approximately $24,100 per cycle (including training). The AI pipeline's $15 inference cost is not the full comparison — development cost was approximately $3,500 in engineering time (roughly 35 hours of pipeline construction, prompt design, evaluation framework development, and iterative debugging, drawing on prior experience with LLM pipeline patterns). But development cost is a one-time investment. The pipeline now runs each new survey wave for $15; the manual process costs $23,300 every time.

Also update the comparison table to include development cost. Replace the existing table with:

```
| | AI Pipeline | Manual Equivalent |
|---|---|---|
| Task | Map 6,987 survey questions to standardized concepts | Same task, same taxonomy |
| Development cost | ~$3,500 (one-time: pipeline, prompts, evaluation design) | ~$800 (one-time: analyst training) |
| Per-run cost | ~$15 (inference) | ~$23,300 (analyst labor) |
| Runtime | ~2 hours | ~233 analyst-hours |
| Accuracy | 99.5% (dual-model cross-validated) | Varies by analyst, estimated comparable |
| Evidence chain | Complete: model versions, confidence scores, agreement rates, disagreements logged | Notes, spreadsheets, institutional memory |
| Reproducibility | Re-run produces documented results with provenance | Re-assignment produces different results depending on analyst |
| Year 1 total | ~$3,515 | ~$24,100 |
| Year 2+ per cycle | ~$15 | ~$23,300 |
```

---

## Change 2: Cost Taxonomy Concrete Numbers

**Location:** The `[OPEN QUESTION: Do we have concrete numbers for any of these categories...]` marker after the cost taxonomy table.

**Action:** Replace the `[OPEN QUESTION]` block with:

> The Concept Mapper illustrates the typical distribution. Inference cost: $15. Development cost: approximately 35 hours of engineering time — pipeline construction, prompt design, evaluation framework, and iterative debugging. This was not a cold start; the developer brought prior experience with LLM pipeline patterns, which substantially compressed the timeline. A team building its first pipeline should expect development measured in person-weeks, not person-days. Operational costs are ongoing but modest for a batch pipeline: prompt updates when model behavior shifts, re-running the evaluation suite after model version changes, maintaining the orchestration code. The precise hours vary, but the pattern holds: inference is the smallest cost category, development dominates the initial investment, and operational costs are the long tail that organizations chronically underestimate.

---

## Change 3: Reframe "When Cheap Models Win" — Evaluation-Driven Sufficiency

**Location:** The `[OPEN QUESTION: Can we give a concrete example of a task where a cheap model matched a frontier model's accuracy?...]` marker in the "When Cheap Models Win" section.

**Action:** Replace the `[OPEN QUESTION]` block with:

> The question is not whether a cheap model matches a frontier model on benchmarks. It rarely will. The question is whether a cheaper model passes *your* quality gate on *your* task. Benchmarks tell you where to start looking; your evaluation harness (Chapter 8) tells you where to stop.
>
> Smaller models are not just cheaper — they are faster. A frontier reasoning model processing 50,000 classification records is a dump truck hauling a brick: you are paying for capability the task does not require, and the overhead is not just cost but latency. A mid-tier or small model that meets your accuracy threshold will process the same batch in a fraction of the time. For batch statistical workflows with no latency requirements, this matters less than for interactive use — but it still matters for pipeline throughput, retry budgets, and rate limit management. Faster models mean more room for multi-model consensus runs within the same time window and cost envelope.
>
> The Concept Mapper's dual-model design illustrates the selection principle: model selection was driven by inter-rater reliability on the actual classification task, not by benchmark rankings. The models that made the cut were the ones that produced defensible agreement scores on the agency's taxonomy — a domain-specific threshold that no public benchmark measures. Run your candidates against your golden test set. The cheapest one that passes is the right one. When new models release or pricing changes, re-run the evaluation and update the configuration. This is model selection as continuous cost optimization, not a one-time architectural bet.

---

## Verification

After applying all three changes:
1. Confirm zero `[OPEN QUESTION]` markers remain in `chapter-14.md` (search for the string `[OPEN QUESTION`)
2. Confirm the comparison table renders correctly in MyST markdown
3. Confirm no other `[OPEN QUESTION]`, `[NEEDS:]`, `[TBD]`, or `[PLACEHOLDER]` markers remain in the file
