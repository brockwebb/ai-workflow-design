# Chapter 14: Cost & Practicality

<!-- STATUS: Draft -->
<!-- The spreadsheet chapter. Numbers, comparisons, frameworks. Not philosophy. -->
<!-- Primary Tenet: Infrastructure enables delivery -->
<!-- Primary Working Principle: Slow governance prevents delivery (governance costs are real costs) -->

## The Right Answer Is a Comparison

Your program office asks: "How much does this AI thing cost?" You answer "$15." They look skeptical. You explain it replaced a quarterly process that takes three people four weeks. Now they are interested. Then they ask: "What are the risks?" And you pull out the evidence chain, the evaluation metrics, the dual-model agreement scores. That is the difference between a cost conversation and a value conversation.

Every cost discussion in this chapter is framed as a comparison: AI pipeline cost versus the status quo alternative. The status quo has costs too. They are just already in the budget, and therefore invisible.

## The Counterfactual: Compared to What?

The cost of an AI pipeline is meaningless without the cost of the alternative.

Manual processes have real costs: FTE hours, calendar time, error rates, rework cycles, and the opportunity cost of what those people could be doing instead. Those costs are usually invisible because they are already budgeted as headcount. Nobody asks "what does it cost to have three people spend four weeks on manual classification?" because the salaries are already approved. But the cost is real, and it is the denominator in any honest cost comparison.

AI does not eliminate human effort. It reallocates it. Low-judgment repetitive work (classifying thousands of records against a taxonomy, checking thousands of files for formatting errors, extracting entities from thousands of documents) moves to the pipeline. High-judgment review and validation (adjudicating disagreements, verifying edge cases, interpreting results, making domain-specific decisions) stays with humans. The pipeline handles the volume. The human handles the exceptions.

The real comparison is total cost of the AI pipeline, including development, operation, and human review, versus total cost of the current process, including the opportunity cost of what those people could be doing instead.

**Worked example: the Federal Survey Concept Mapper.**

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

The manual equivalent: a trained analyst classifying survey questions against the harmonized taxonomy. Assume 8 hours of training on the taxonomy and classification conventions, then a sustained rate of approximately 30 questions per hour (a reasonable estimate for a skilled analyst making judgment calls on semantic alignment). At 6,987 questions, that is 233 analyst-hours of classification work alone. At a fully loaded labor rate of $100 per hour, the manual equivalent costs approximately $24,100 per cycle (including training). The AI pipeline's $15 inference cost is not the full comparison; development cost was approximately $3,500 in engineering time (roughly 35 hours of pipeline construction, prompt design, evaluation framework development, and iterative debugging, drawing on prior experience with LLM pipeline patterns). But development cost is a one-time investment. The pipeline now runs each new survey wave for $15; the manual process costs $23,300 every time.

The $15 is the inference cost. The development cost (building the pipeline, designing prompts, creating the evaluation framework) was higher. But it was a one-time investment. The pipeline now runs on each new survey wave for $15, not for three FTEs over four weeks.

## The Cost Taxonomy

People conflate four different cost categories when they talk about "AI costs." Separating them changes the conversation.

| Cost Category | What It Includes | Who Cares |
|---|---|---|
| **Inference costs** | API calls, tokens, compute time per run | Technical leads, budget analysts |
| **Development costs** | Pipeline construction, prompt engineering, evaluation design, testing | Project managers, technical leads |
| **Operational costs** | Monitoring, maintenance, prompt updates, model swaps, re-evaluation | Operations teams, IT |
| **Opportunity costs** | What you are NOT doing while people do repetitive work, or while waiting for procurement and governance | Leadership, program offices |

Most conversations about "AI costs" address only inference costs. That is often the smallest category. Development costs dominate for complex workflows: the time to build the pipeline, design the evaluation framework, test against ground truth, and iterate on prompts is measured in person-weeks, not API dollars. Operational costs are ongoing and often underestimated: models change, prompts need updating, evaluation metrics need re-running. Opportunity costs are the largest but hardest to quantify: what is the cost of three senior researchers spending 60% of their time on data wrangling that a well-designed pipeline could handle?

The Concept Mapper illustrates the typical distribution. Inference cost: $15. Development cost: approximately 35 hours of engineering time: pipeline construction, prompt design, evaluation framework, and iterative debugging. This was not a cold start; the developer brought prior experience with LLM pipeline patterns, which substantially compressed the timeline. A team building its first pipeline should expect development measured in person-weeks, not person-days. Operational costs are ongoing but modest for a batch pipeline: prompt updates when model behavior shifts, re-running the evaluation suite after model version changes, maintaining the orchestration code. The precise hours vary, but the pattern holds: inference is the smallest cost category, development dominates the initial investment, and operational costs are the long tail that organizations chronically underestimate.

## Batch Economics

Statistical workflows are naturally cost-advantaged for AI processing. Most statistical work is batch processing: classify 50,000 records, not answer one question in real time. Batch processing has fundamentally different cost characteristics than interactive use.

**No latency requirements.** Interactive chatbot use demands sub-second response times, which constrains model choice and infrastructure. Batch classification of survey records can take hours. You can use cheaper, slower endpoints and queue-based processing.

**Predictable volume.** You know before you start how many records you have. You can estimate costs before running: average tokens per input, multiplied by number of records, multiplied by price per token, equals estimated cost. Include output tokens (often forgotten in estimates) and a retry budget (assume some percentage of calls will fail and need re-processing).

**Retry-tolerant.** A failed API call in a batch job retries automatically. A failed API call in a real-time conversation requires the user to wait. Batch architectures tolerate transient failures without human intervention.

**Off-peak scheduling.** Some providers offer lower rates or dedicated capacity for batch workloads. Even without explicit discounts, running large jobs during off-peak hours avoids rate limit contention.

**Cost comparison across model tiers** for a batch classification task (50,000 records, average 500 input tokens + 100 output tokens per record):

| Model Tier | Relative Cost per Token | Est. Cost for 50K Records | When to Use |
|---|---|---|---|
| Frontier (large reasoning) | 1x (baseline) | Highest | Complex reasoning, ambiguous cases, evaluation ground truth |
| Mid-tier (standard) | 0.1x - 0.3x | Moderate | Most classification, coding, extraction tasks |
| Small/fast | 0.01x - 0.05x | Lowest | Simple classification, high-volume filtering, pre-screening |

Specific pricing changes constantly. The ratios are more durable: frontier models typically cost 10-30x more per token than mid-tier models, and 50-100x more than small models. Check current pricing before estimating any specific job, but use the ratios for architectural planning.

The design implication: your evaluation harness (Chapter 8) determines which tier meets your accuracy threshold for each task. Then you use the cheapest tier that passes. This is evaluation-driven model selection, not brand-driven model selection.

## When Cheap Models Win

The question is not "which model is smartest?" It is: which model meets the accuracy threshold for this specific task at the lowest cost?

For many classification, coding, and extraction tasks, mid-tier or small models meet the threshold. The evaluation harness from Chapter 8 makes this determination possible: run your task on multiple models, compare accuracy against your ground truth, pick the cheapest one that passes. Model selection becomes a continuous cost optimization, not a one-time architectural decision.

**The $15 vs. $1,500 pipeline.** Same task, same data, same accuracy requirement. The difference is design, not capability.

The $1,500 version: frontier model for every call (paying for reasoning capability the task does not require), no batching (individual API calls with latency overhead), no prompt optimization (verbose prompts consuming unnecessary tokens), retry-heavy (poor error handling causing redundant calls), no caching (identical patterns reprocessed every time).

The $15 version: right-sized model (mid-tier model that meets the accuracy threshold), batch-optimized (queued processing with efficient token use), cached repeated patterns (common inputs processed once), designed prompts (minimal tokens for maximum signal), and the evaluation framework that proved the cheaper model was sufficient.

The difference is the design discipline this book teaches. Every chapter contributes to it: ensemble patterns that validate cheaply (Chapter 5), evaluation infrastructure that proves which model suffices (Chapter 8), checkpoint design that prevents expensive reprocessing (Chapter 7), configuration-driven model selection that makes swapping a config change, not a rewrite.

The question is not whether a cheap model matches a frontier model on benchmarks. It rarely will. The question is whether a cheaper model passes *your* quality gate on *your* task. Benchmarks tell you where to start looking; your evaluation harness (Chapter 8) tells you where to stop.

Smaller models are not just cheaper; they are faster. A frontier reasoning model processing 50,000 classification records is a dump truck hauling a brick: you are paying for capability the task does not require, and the overhead is not just cost but latency. A mid-tier or small model that meets your accuracy threshold will process the same batch in a fraction of the time. For batch statistical workflows with no latency requirements, this matters less than for interactive use, but it still matters for pipeline throughput, retry budgets, and rate limit management. Faster models mean more room for multi-model consensus runs within the same time window and cost envelope.

The Concept Mapper's dual-model design illustrates the selection principle: model selection was driven by inter-rater reliability on the actual classification task, not by benchmark rankings. The models that made the cut were the ones that produced defensible agreement scores on the agency's taxonomy, a domain-specific threshold that no public benchmark measures. Run your candidates against your golden test set. The cheapest one that passes is the right one. When new models release or pricing changes, re-run the evaluation and update the configuration. This is model selection as continuous cost optimization, not a one-time architectural bet.

**Configuration-driven model selection.** Design the pipeline so that swapping models is a configuration change, not a code rewrite. Then model selection becomes continuous: as new models release or pricing changes, you re-run your evaluation suite, update the config, and the pipeline uses the new optimal model. This is cost optimization as architecture, not as a one-time decision.

## Making the Case

Federal program offices think in FTEs, labor hours, and budget cycles, not tokens and API calls. The pitch is not "AI is cheap." The pitch is "AI reallocates human effort from low-judgment work to high-judgment work, with documented quality metrics and a defensible evidence chain."

Frame the value in terms budget authority understands:

- **FTE-equivalent reallocation:** "These three people now do X instead of Y."
- **Time-to-delivery improvement:** "Quarterly process now takes 6 hours."
- **Error rate reduction:** "Manual process had N% error rate; AI pipeline has M%, with evidence from evaluation."
- **Respondent burden reduction (if applicable):** "We don't need to collect X because we can derive it."

**Cost justification template** (adapt to your organization's budget process):

```
CURRENT PROCESS
  Personnel: [N] FTEs × [M] weeks per cycle = [labor hours]
  Estimated labor cost: [hours × blended rate]
  Error rate: [X]% (if known)
  Delivery timeline: [Y] weeks/months per cycle
  Cycles per year: [Z]
  Annual cost: [total]

PROPOSED AI PIPELINE
  Development cost (one-time): [estimate]
  Per-run inference cost: [estimate]
  Human review time per run: [estimate]
  Error rate: [X]% (with evaluation evidence)
  Delivery timeline: [Y] hours/days per cycle
  Annual operating cost: [inference + review + maintenance]

NET IMPACT
  FTE time reallocated: [N] hours per cycle
  Annual cost comparison: [current] vs [proposed]
  Quality: [comparison with evidence]
  Speed: [comparison]
  Evidence chain: [available / not available for current process]
```

The evidence chain line matters. The current manual process probably does not have one. The AI pipeline, if designed per the patterns in this book, does. That is a quality improvement that does not show up in the cost comparison but matters enormously for defensibility and trust.

## The Cost of Not Doing It

Opportunity cost is the invisible line item.

What does it cost to have three FTEs spending four weeks each quarter on manual classification? Not just the labor hours, but the work they are not doing during those four weeks. What does it cost when your senior researchers spend 60% of their time on data wrangling that a well-designed pipeline could handle? What is the dollar value of the research that does not get done, the analyses that do not get run, the questions that do not get answered?

What does it cost when a six-month procurement cycle delays capability deployment while the model landscape shifts (Chapter 13)? What does it cost when governance review takes longer than the project it is reviewing?

These are real costs. They are on no one's spreadsheet. But they compound.

The strongest version of this argument: we are already paying for this work. The question is whether we pay with human hours on repetitive tasks, or with API calls that free those hours for work only humans can do.

*Pick one recurring task in your workflow that takes significant human effort. Estimate its true cost: not just the labor hours, but the calendar time, the error rate, the rework, and what those people could be doing instead. Now estimate what an AI pipeline for that task would cost to develop and run. Is the comparison closer than you expected, or further apart?*

### Thought Experiment

You have a $50,000 annual budget for AI tools and services. Design a portfolio of AI workflows that maximizes mission impact within that budget. What do you build first? What model tiers do you use for which tasks? Where do you invest in development versus where do you use off-the-shelf? How much of the budget goes to inference costs versus evaluation infrastructure versus training your team? What is the expected return in FTE-hours reallocated?

---

This is the final chapter. The design discipline this book teaches is what separates the $15 pipeline from the $1,500 pipeline, the defensible workflow from the fragile one, the team that ships from the team still in governance review. The patterns in these chapters are the prework. The cost of the prework is real. The cost of skipping it is higher.

The first chapter opened with a claim: LLM-powered research workflows require the same architectural discipline that distributed systems have always required. Fourteen chapters later, you have the patterns, the principles, and the evidence infrastructure to build them. The rest is practice.
