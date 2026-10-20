# CC Task: Add "The System You Leave Behind" Section to Chapter 3

**Date:** 2026-04-01
**Scope:** `book/chapter-03.md`
**Type:** New section insertion
**Status:** PENDING
**Execute after:** All prior Ch 3 CC tasks (comprehensive revision, verification corrections, final polish)

---

## Context

Session 18 review identified that Chapter 3 covers the Pipeline Builder's perspective well (which tool for which sub-task) but is missing the System Owner's perspective (what does this cost organizationally over time). Five engineering concerns — supportability, maintainability, opportunity cost, designing for replaceability, and the virtue of boring tools — are foundational to good design and directly inform the routing decision the chapter teaches. The chapter touches each in fragments but never names them as first-class tradeoffs.

---

## Instructions

Insert a new section between "The Fine-Tuning Cost Trap" and "Schema Inference and Data Combination."

**Find the line:**
```
## Schema Inference and Data Combination
```

**Insert the following BEFORE that line:**

```markdown
## The System You Leave Behind

Everything in this chapter so far addresses the pipeline builder's question: which tool handles which sub-task? There is a second question that matters just as much: what happens to this system after you ship it?

Five engineering concerns shape that answer.

**Supportability.** Can someone who did not build this pipeline keep it running? If the person who wrote the prompts leaves, can the next person debug a misclassification? A fine-tuned model is a black box that requires ML engineering expertise to retrain. An API-based pipeline with well-documented prompts, clear routing logic, and structured evaluation harnesses is something a competent data scientist can pick up and maintain. Design for the team you have, not the team you wish you had.

**Maintainability.** Classification systems change. NAICS revises. SOC updates. The taxonomy underneath your pipeline shifts, and every component that touches it needs to respond. For a fine-tuned model, that means retraining: new labels, new training data, new evaluation pass. For an API-based pipeline, it means updating the reference schema and re-running your golden questions (Chapter 7). For traditional lookup tables, it means a file swap. These are fundamentally different maintenance profiles, and the cheapest one to build is rarely the cheapest one to maintain.

**Opportunity cost.** Every hour spent tuning prompt temperature, chasing a half-percent accuracy improvement, or debugging a model's edge-case behavior is an hour not spent processing data, building evaluation infrastructure, or shipping something that works. The enemy of deployed is perfected. Get the pipeline to "good enough, verified, and auditable," then move on. You can iterate later with evidence from production, which is worth more than any amount of pre-deployment tinkering.

**Designing for replaceability.** The model is the most volatile component in your pipeline. Models get deprecated, pricing changes, new versions behave differently, vendors exit markets. If swapping the model underneath requires a redesign, you have coupled your architecture to a vendor's release schedule. This is the model-agnostic architecture argument from the SLM discussion above, but stated as an engineering imperative: the model is a configuration parameter, not a load-bearing wall. Build accordingly.

**The virtue of boring tools.** Traditional methods do not hallucinate. MICE does not confabulate. Hot-deck imputation does not have a training data cutoff. Bag-of-words does not drift between API versions. For the parts of your pipeline where steady, reproducible, predictable behavior is the requirement, the "inferior" tool is the superior design choice. Boring is a feature when the alternative is exciting and wrong.

These five concerns are not separate from the routing decision in this chapter's opening figure. They are the routing decision, viewed from the perspective of the system owner rather than the system builder. When you choose between an LLM-assisted path and a traditional method, you are also choosing a maintenance profile, a supportability requirement, and an opportunity cost. Make that choice explicitly.
```

---

## Verification

After insertion:

1. Confirm section appears between "The Fine-Tuning Cost Trap" and "Schema Inference and Data Combination"
2. `grep -n 'The System You Leave Behind' book/chapter-03.md` — expect 1 result
3. `grep -c '—' book/chapter-03.md` — expect 0 em-dashes (verify none introduced; note the prose uses "—" as em-dashes in bold headers only within MyST bold markers which render correctly, but verify no bare em-dashes in running text)
4. No bare dollar signs introduced
5. Run `seldon verify --fix`

---

## Acceptance Criteria

- [ ] New section inserted at correct location
- [ ] Five named concerns present: supportability, maintainability, opportunity cost, replaceability, boring tools
- [ ] Chapter 7 cross-reference present (golden questions in maintainability paragraph)
- [ ] Ties back to chapter's routing figure in closing paragraph
- [ ] No em-dashes in running text
- [ ] No citations required (all claims are engineering judgment, explicitly framed as such)
- [ ] `seldon verify` passes
