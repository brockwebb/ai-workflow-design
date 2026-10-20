# CC Task: Batch G DG-3 -- Ch 14 API vs. Fine-Tuning TCO Section

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` DG-3, CC-5, item 2
**Scope:** One new section in Ch 14, half-page to one page. Fulfills the forward reference from Ch 3 line 41: "Chapter 14 provides a cost accounting framework that makes this comparison rigorous."

---

## Prerequisites

- Read `book/chapter-03.md` lines 37-47 (The Fine-Tuning Cost Trap) to understand what Ch 3 already covers. The new section must NOT duplicate Ch 3's qualitative analysis. Ch 3 covers when fine-tuning is the right call, institutional deployment timelines, the \$50k threshold heuristic, and the engineering concerns. Ch 14's job is the cost accounting framework: the quantitative comparison structure.
- Read `book/chapter-14.md` in full to understand the cost taxonomy already established.

## Style Rules

- No em-dashes anywhere
- Currency values escaped as `\$` (MyST requirement)
- No throat-clearing or academic filler
- Practitioner voice: direct, specific, actionable
- No new bib entries needed

## Edit: Add "The Fine-Tuning Crossover" Section

**File:** `book/chapter-14.md`
**Location:** AFTER the "## When Cheap Models Win" section (after the paragraph ending "...not a one-time architectural bet.") and BEFORE the "## Making the Case" heading.
**Action:** Add a new H2 section.

**Content to add:**

```
## The Fine-Tuning Crossover

Chapter 3 introduced the qualitative tradeoffs between API access and fine-tuning. This section provides the cost accounting framework to make that comparison rigorous.

**API cost scales linearly.** Every call costs tokens. Double the volume, double the cost. The Concept Mapper's \$15 inference run scales predictably: 10x the questions costs roughly 10x the tokens. There is no economy of scale on per-call pricing (though negotiated enterprise rates and batch API discounts can reduce the per-token rate at high volume). The advantage is zero upfront investment, no infrastructure to maintain, and operational simplicity. The disadvantage is that you pay the full per-token rate on every run, forever.

**Fine-tuning cost has a different shape.** The upfront investment is substantial: training data curation (who labels the training set, and how do you verify label quality?), compute for training runs (GPU hours, whether cloud or on-premises), evaluation harness development to prove the fine-tuned model outperforms the baseline, and MLOps infrastructure to serve the model. After that upfront cost, per-call inference on a self-hosted fine-tuned model is dramatically cheaper than API calls to a frontier provider. The cost curve starts high and flattens. API cost starts low and climbs linearly.

**The crossover point depends on four variables:**

1. **Annual inference volume.** How many tokens per year does your workload consume? Low-volume workloads (a few thousand records per quarter) rarely justify fine-tuning. High-volume workloads (millions of records per year across multiple survey products) shift the math.

2. **Workload stability.** Fine-tuning amortizes well when the task is stable. If your classification taxonomy revises annually (NAICS, SOC), each revision triggers retraining: new training data, new evaluation pass, new deployment. Frequent revisions erode the cost advantage because the upfront investment partially resets.

3. **MLOps maturity.** Does your agency already operate GPU infrastructure, manage model deployments, and maintain ML pipelines? If yes, the marginal cost of adding a fine-tuned model is lower. If no, the infrastructure buildout cost, including staff expertise, is part of the fine-tuning price tag. Chapter 3 covers this in detail.

4. **Federal infrastructure overhead.** Self-hosted models require an Authority to Operate (ATO) or equivalent security authorization. New authorizations typically take 12 months or longer. Even if the cost crossover favors fine-tuning on paper, the 12-month delay before processing a single production record is a real cost: the opportunity cost of the work not done during that year, plus the risk that the model landscape shifts before your deployment is operational.

**A rough framework for the comparison:**

| Cost Category | API Path | Fine-Tuning Path |
|:--|:--|:--|
| Development (one-time) | Prompt engineering, evaluation harness, pipeline construction | All of API path PLUS training data curation, model training, serving infrastructure |
| Per-run inference | Provider token pricing x volume | Self-hosted compute (amortized GPU + electricity + maintenance) |
| Maintenance (annual) | Prompt updates, re-evaluation on model changes, API cost monitoring | All of API path PLUS retraining on taxonomy changes, infrastructure maintenance, MLOps staffing |
| Institutional overhead | Minimal (API access under existing cloud agreements) | ATO/security review, hardware procurement, staff training, infrastructure queue priority |
| Timeline to first production run | Weeks to low months | 6-18 months (Chapter 3) |

The table makes visible what intuition often misses: the fine-tuning path includes every cost the API path has, plus additional costs at every level. Fine-tuning does not replace prompt engineering or evaluation infrastructure. You still need both. Fine-tuning adds training data management, compute infrastructure, and MLOps on top of the baseline pipeline engineering.

For most federal statistical workloads at current pricing, the API path is the correct starting point. Build the pipeline, prove the method, establish the evaluation framework, and run in production via API. If and when annual API costs grow large enough to justify the infrastructure investment, the pipeline you built is the same pipeline you deploy on a fine-tuned model. The architecture does not change; only the model endpoint does. This is why Chapter 6's design-for-change principle matters: if your pipeline is model-agnostic, the API-to-fine-tuning migration is a configuration change, not a rewrite.
```

**Rationale:** Ch 3 explicitly promises this framework ("Chapter 14 provides a cost accounting framework that makes this comparison rigorous"). Ch 14 currently has batch economics and model tier comparison but never addresses the API vs. fine-tuning TCO question. This section provides the quantitative comparison structure without duplicating Ch 3's qualitative analysis. It also closes CC-5 (the broken forward reference).

---

## Post-Edit Verification

After edit, run:
```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
grep -n '—' book/chapter-14.md  # zero em-dashes expected
grep -n '[^\\]\$[0-9]' book/chapter-14.md  # zero unescaped dollar signs before numbers
grep -c "Fine-Tuning Crossover" book/chapter-14.md  # should be 1
myst build --html 2>&1 | grep -i error  # no build errors
```

## Verification Checklist

- [ ] New section is between "When Cheap Models Win" and "Making the Case"
- [ ] No em-dashes
- [ ] All `$` before numbers are escaped as `\$`
- [ ] No new bib entries required (all citations reference existing entries)
- [ ] Section heading is `##` level (same as other main sections in Ch 14)
- [ ] Forward reference from Ch 3 ("Chapter 14 provides a cost accounting framework...") is now fulfilled
- [ ] `myst build --html` completes without errors
