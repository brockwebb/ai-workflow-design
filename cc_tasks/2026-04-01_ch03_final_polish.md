# CC Task: Chapter 3 Final Polish — Cost Heuristic + Thought Experiment Fix

**Date:** 2026-04-01
**Scope:** `book/chapter-03.md`
**Type:** Addendum to `2026-04-01_ch03_comprehensive_revision.md` and `2026-04-01_ch03_verification_corrections.md`
**Status:** PENDING
**Execute after:** Both prior Ch 3 CC tasks

---

## Context

Two fixes identified during Session 18 review:

1. The thought experiment asks "At what scale does the API cost argument change?" but the chapter gives the reader zero tools to answer it. The Fine-Tuning Cost Trap section needs a practitioner heuristic as a breadcrumb so the question is answerable, with a pointer to Ch 14 for the full framework.

2. The thought experiment's Title 13 question uses narrower language than the chapter body, which already softened to the broader legal framing.

---

## Fix 1: Add cost heuristic breadcrumb to Fine-Tuning Cost Trap

**File:** `book/chapter-03.md`
**Section:** "The comparison most teams skip" paragraph

This fix targets the text as it will exist AFTER the comprehensive revision has been applied. Find the sentence that ends the cost comparison paragraph:

**Find:**
```
Chapter 14 provides a cost accounting framework that makes this comparison explicit.
```

**Replace with:**
```
As a rough starting point: practitioner analyses suggest that below approximately \$50,000 per year in projected API spend, the API path is almost always preferable. Above that threshold, the comparison becomes genuinely conditional on utilization stability, MLOps maturity, and whether the workload justifies dedicated infrastructure. Chapter 14 provides a cost accounting framework that makes this comparison rigorous.
```

**Rationale:** Gives the reader a concrete number to anchor their thinking. Framed as "practitioner analyses suggest" and "rough starting point," not as a peer-reviewed finding. The $50k threshold is from the Perplexity evidence round (practitioner/vendor consensus). The thought experiment question "At what scale does the API cost argument change?" is now answerable: start at $50k, then factor in the conditionals. Ch 14 reference retained and strengthened ("rigorous" instead of "explicit").

---

## Fix 2: Broaden Title 13 language in thought experiment

**File:** `book/chapter-03.md`
**Section:** Thought Experiment (near end of chapter)

**Find:**
```
- How would your design change if the data is Title 13 protected and cannot leave the agency network?
```

**Replace with:**
```
- How would your design change if the data are Title 13, CIPSEA, or otherwise restricted by policy or statutory requirement?
```

**Rationale:** Matches the broader legal framing already established in the Fine-Tuning Cost Trap section. Uses "data are" (plural, per statistical convention). Covers the full range of restrictions the reader might encounter, not just Title 13.

---

## Verification

After edits:

1. `grep -n '\$50,000' book/chapter-03.md` — expect 1 result (the heuristic)
2. `grep -n 'Chapter 14' book/chapter-03.md` — expect at least 1 result
3. `grep -n 'Title 13 protected and cannot leave' book/chapter-03.md` — expect 0 results (old language removed)
4. `grep -n 'CIPSEA' book/chapter-03.md` — expect at least 2 results (body text + thought experiment)
5. No em-dashes introduced
6. Dollar sign escaped as `\$`
7. Run `seldon verify --fix`

---

## Acceptance Criteria

- [ ] Cost heuristic ($50k threshold) added with practitioner framing
- [ ] Ch 14 reference preserved and strengthened
- [ ] Thought experiment Title 13 question broadened to include CIPSEA and policy/statutory restrictions
- [ ] Dollar sign properly escaped
- [ ] No em-dashes introduced
- [ ] `seldon verify` passes
