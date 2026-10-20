# CC Task: Draft Chapter 14 — Cost & Practicality

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** `2026-03-29_citation_infrastructure_and_bibliography.md` (for citation roles)

---

## Objective

Replace the placeholder `book/chapter-14.md` with a full chapter draft. This is the practical capstone — concrete, numbers-oriented, actionable. No philosophical arguments. Tables, comparisons, worked examples. Shorter than Chs 12-13: target 8-12 pages.

## Thesis

AI workflow costs are meaningless without a counterfactual. The question is never "how much does the AI pipeline cost?" — it's "how much does it cost compared to what we're doing now, and what do we get for the difference?" This chapter teaches practitioners to think about costs correctly, make the business case in language budget authority understands, and design architectures that keep costs under control as requirements change.

## Tone and Scope

Practical. Numbers where we have them, frameworks where we don't. Tables over prose where possible. This chapter should feel like the reference a practitioner pulls out when their program office asks "what does this cost and why should we pay for it?"

No philosophical arguments about AI's value — that case was made in Chs 1-13. This is the spreadsheet chapter.

## Chapter Structure

### Opening (short — half page)

You've designed the workflow, secured it, navigated the institutional landscape. Now someone asks: "What does it cost?" The wrong answer is a number. The right answer is a comparison.

Every cost discussion in this chapter is framed as: AI pipeline cost vs. the status quo alternative. The status quo has costs too — they're just already in the budget and therefore invisible.

### Section 1: The Counterfactual — Compared to What?

The cost of an AI pipeline is meaningless without the cost of the alternative.

Key points:
- Manual processes have real costs: FTEs, labor hours, calendar time, error rates, rework cycles
- Those costs are usually invisible because they're already budgeted as headcount
- AI doesn't eliminate human effort — it reallocates it from low-judgment repetitive work to high-judgment review and validation
- The real comparison: total cost of the AI pipeline (including development, operation, human review) vs. total cost of the current process (including the opportunity cost of what those people could be doing instead)

Worked example using the Federal Survey Concept Mapper:
- Task: Map 6,987 survey questions to standardized concepts
- AI pipeline: ~$15 in API costs, ~2 hours runtime, 99.5% accuracy
- [OPEN QUESTION: What would the manual equivalent have cost? Brock to provide estimate — FTEs, weeks, approximate labor cost. Even a rough "this would have taken N people M weeks" is sufficient for the comparison.]

### Section 2: The Cost Taxonomy

People conflate four different cost categories. Separate them.

| Cost Category | What It Includes | Who Cares |
|---|---|---|
| **Inference costs** | API calls, tokens, compute time | Technical leads, budget analysts |
| **Development costs** | Building the pipeline, prompt engineering, evaluation design, testing | Project managers, technical leads |
| **Operational costs** | Running, monitoring, maintaining, updating prompts, model swaps | Operations teams, IT |
| **Opportunity costs** | What you're NOT doing while waiting for procurement/governance/approval | Leadership, program offices |

Key insight: most conversations about "AI costs" only address inference costs. That's often the smallest category. Development and operational costs dominate for complex workflows. Opportunity costs are the largest but hardest to quantify.

[OPEN QUESTION: Do we have concrete numbers for any of these categories from the Concept Mapper or other projects? Even approximate breakdown of hours spent on development vs. inference cost would make this section concrete rather than abstract.]

### Section 3: Batch Economics

Why statistical workflows are naturally cost-advantaged for AI.

Key points:
- Most statistical work is batch processing — classify 50,000 records, not answer one question in real time
- Batch processing has fundamentally different cost characteristics than interactive use:
  - No latency requirements → can use cheaper, slower endpoints
  - Predictable volume → can estimate costs before running
  - Retry-tolerant → failures don't require immediate human intervention
  - Off-peak scheduling → some providers offer lower rates
- Token budget estimation: how to estimate cost before running a batch job
  - Average tokens per input × number of records × price per token = estimated cost
  - Include output tokens (often forgotten)
  - Include retry budget (assume N% failure rate)

Table: Cost comparison across model tiers for a batch classification task

| Model Tier | Cost per 1K input tokens | Cost per 1K output tokens | Est. cost for 50K records | Notes |
|---|---|---|---|---|
| Frontier (e.g., large reasoning model) | [PLACEHOLDER] | [PLACEHOLDER] | [PLACEHOLDER] | Highest accuracy, highest cost |
| Mid-tier (e.g., standard model) | [PLACEHOLDER] | [PLACEHOLDER] | [PLACEHOLDER] | Often sufficient for classification |
| Small/cheap (e.g., fast model) | [PLACEHOLDER] | [PLACEHOLDER] | [PLACEHOLDER] | May meet threshold for simpler tasks |

[OPEN QUESTION: Should we use real current pricing, or keep it generic with ratios? Real pricing goes stale immediately. Ratios (e.g., "frontier models cost 10-30x more per token than small models") may be more durable. Recommend ratios with a note that practitioners should check current pricing.]

### Section 4: When Cheap Models Win

Evaluation-driven model selection, not brand-driven.

Key points:
- The question isn't "which model is smartest?" — it's "which model meets the accuracy threshold for this specific task at the lowest cost?"
- For many classification, coding, and extraction tasks, mid-tier or small models meet the threshold
- The evaluation harness (Ch 8) is what makes this determination possible — run your task on multiple models, compare accuracy against your ground truth, pick the cheapest one that passes
- Configuration-driven model selection: design the pipeline so swapping models is a config change, not a rewrite. Then model selection becomes a continuous cost optimization, not a one-time architectural decision.

The $15 vs $1,500 pipeline:
- Same task, same data, same accuracy requirement
- $1,500 version: frontier model, no batching, no prompt optimization, retry-heavy, no caching
- $15 version: right-sized model, batch-optimized, cached repeated patterns, designed prompts
- The difference is design, not capability

[NOTE: The $15 vs $1,500 comparison was relocated from the Hadoop aside in Ch 1 per CC task `2026-03-29_remove_hadoop_aside_chapter01.md`. The concrete example lives here now. Expand with specifics if available.]

[OPEN QUESTION: Can we give a concrete example of a task where a cheap model matched a frontier model's accuracy? The Concept Mapper used dual models — was there a cost differential between them? Any cases where a single cheaper model would have sufficed?]

### Section 5: Making the Case

Translating API costs into language budget authority understands.

Key points:
- Federal program offices think in FTEs, labor hours, and budget cycles — not tokens and API calls
- The pitch isn't "AI is cheap" — it's "AI reallocates human effort from low-judgment work to high-judgment work"
- Frame it as:
  - FTE-equivalent savings (or reallocation — "these three people now do X instead of Y")
  - Time-to-delivery improvement ("quarterly process now takes 6 hours")
  - Error rate reduction ("manual process had N% error rate, AI pipeline has M%")
  - Respondent burden reduction (if applicable — "we don't need to collect X because we can derive it")

Template for a one-page cost justification:

```
Current Process:
  - [N] FTEs × [M] weeks = [labor cost estimate]
  - Error rate: [X]%
  - Delivery timeline: [Y] weeks/months

Proposed AI Pipeline:
  - Development cost (one-time): [estimate]
  - Per-run inference cost: [estimate]
  - Human review time per run: [estimate]
  - Error rate: [X]% (with evidence from evaluation)
  - Delivery timeline: [Y] hours/days

Net Impact:
  - FTE time reallocated: [N] hours per [cycle]
  - Cost per run: [comparison]
  - Quality impact: [comparison]
  - Time saved: [comparison]
```

[OPEN QUESTION: Should this template be more detailed? Or is a skeleton sufficient that practitioners fill in for their own context? Recommend skeleton — if it's too prescriptive it won't match anyone's actual budget process.]

### Section 6: The Cost of Not Doing It

Opportunity cost — the invisible line item.

Key points:
- What does it cost to have three FTEs spending four weeks each quarter on manual classification?
- What's the cost of a six-month procurement cycle while the landscape shifts?
- What's the cost of governance review taking longer than the project it's reviewing? (Ch 13 callback)
- What does it cost when your best researchers spend 60% of their time on data wrangling that an AI pipeline could handle?

This isn't a guilt trip. It's an accounting exercise. Opportunity costs are real costs — they're just not on anyone's spreadsheet.

The strongest version of this argument: "We're already paying for this work. The question is whether we pay with human hours on repetitive tasks, or with API calls that free those hours for work only humans can do."

### Closing / Chapter Bridge

This is the final chapter. The closing should tie back to Chapter 1's thesis: design discipline is what separates the $15 pipeline from the $1,500 pipeline, the defensible workflow from the fragile one, the team that ships from the team still in governance review. The patterns in this book are the prework. The cost of the prework is real. The cost of skipping it is higher.

### Pedagogical Elements

**Opening hook:** Your program office asks: "How much does this AI thing cost?" You answer "$15." They look skeptical. You explain it replaced a quarterly process that takes three people four weeks. Now they're interested. Then they ask: "What are the risks?" And you pull out the evidence chain, the evaluation metrics, the dual-model agreement scores. That's the difference between a cost conversation and a value conversation.

[OPEN QUESTION: Is there a better concrete hook? The $15 Concept Mapper example is strong but it's been used in Ch 2 as a case study. Repetition may be fine (it's the capstone tying things together) or it may feel like a broken record. Brock to decide.]

**Reflection prompt:** "Pick one recurring task in your workflow that takes significant human effort. Estimate its true cost — not just the labor hours, but the calendar time, the error rate, the rework, and what those people could be doing instead. Now estimate what an AI pipeline for that task would cost to develop and run. Is the comparison closer than you expected, or further apart?"

**Thought experiment:** You have a $50,000 annual budget for AI tools and services. Design a portfolio of AI workflows that maximizes mission impact within that budget. What do you build first? What model tiers do you use for which tasks? Where do you invest in development vs. where do you use off-the-shelf? How much of the budget goes to inference costs vs. evaluation infrastructure vs. training your team? What's the expected return in FTE-hours reallocated?

**Chapter bridge:** This is the final chapter. No forward bridge. Instead, a closing that connects back to Ch 1: the design discipline this book teaches is what makes AI workflows cost-effective, defensible, and trustworthy. The prework is the investment. The return is capability at speed, within trust constraints, at a cost you can defend.

## Writing Guidance

- **Primary Tenet:** "Infrastructure enables delivery" (cost infrastructure enables cost-effective delivery)
- **Primary Working Principle:** "Slow governance prevents delivery" (governance costs are real costs)
- **Secondary:** "Deliver capability quickly," "Adoption determines impact"
- Tables and concrete numbers wherever possible. This is the spreadsheet chapter, not the philosophy chapter.
- Use ratios and frameworks over specific dollar amounts that will go stale.
- The Federal Survey Concept Mapper ($15, 6,987 questions, 99.5%) is the anchor example. Reference it — it's the proof point from Ch 2 brought back for the cost discussion.
- The $15 vs $1,500 comparison from the relocated Hadoop aside gets its full treatment here.
- Keep it short. 8-12 pages. Every paragraph should contain either a number, a comparison, or an actionable framework. Cut anything that's just argument.
- Estimated length: 8-12 pages.

## Open Questions for Brock (collected)

1. **Concept Mapper manual cost counterfactual:** What would mapping 6,987 survey questions have cost manually? FTEs × weeks, even approximate.
2. **Cost taxonomy breakdown:** Any concrete numbers for development time vs. inference cost from the Concept Mapper or other projects?
3. **Cheap model vs. frontier model example:** Cases where a cheaper model matched accuracy on a specific task?
4. **Pricing approach:** Real current pricing (stale quickly) vs. ratios (durable)? Recommend ratios.
5. **Cost justification template:** Skeleton sufficient, or more detailed?
6. **Opening hook:** Reuse the $15 Concept Mapper example (ties everything together) or find a fresh one?
7. **The $15 vs $1,500 comparison:** Do we have specifics on what the $1,500 version would have looked like, or is this a constructed comparison for illustration?

## Files Modified

1. `book/chapter-14.md` — full replacement of placeholder

## Verification

1. `book/chapter-14.md` contains all six sections plus opening and closing
2. At least two tables present (cost taxonomy, batch economics comparison)
3. Cost justification template present
4. `[OPEN QUESTION]` markers present for items requiring Brock's input (these are NOT `[NEEDS]` — they are design questions, not missing citations)
5. Pedagogical elements present: opening hook, reflection prompt, thought experiment, closing tie-back to Ch 1
6. No specific vendor pricing that will go stale — use ratios and frameworks
7. Federal Survey Concept Mapper referenced as anchor cost example
