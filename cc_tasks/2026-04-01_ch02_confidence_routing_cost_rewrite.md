# CC Task: Chapter 2 — Confidence Routing Section Rewrite + Cost Paragraph Rewrite

**Date:** 2026-04-01
**Session:** 16
**Status:** PENDING
**Amends:** 2026-04-01_audit_ch02_prose_fixes.md

---

## Context

Two problems in §Confidence Routing and the Division of Labor:

1. The four routing tiers use bold-label fragments that should be a bulleted list. The style is choppy and violates the book's anti-bold formatting preference.
2. The cost paragraph reads like working session notes, not book prose. "But state this honestly" is author-to-author voice that leaked into chapter text. The whole paragraph needs a rewrite.

---

## Fix 1: Rewrite confidence routing tiers as a bulleted list in flowing prose

**File:** `book/chapter-02.md`

**Find:**
```
Not every classification needs the same treatment. The Concept Mapper implements confidence-based routing that directs attention where it adds the most value:

**High agreement, high confidence: auto-accept.** The vast majority of classifications. No human attention needed.

**High agreement, edge cases: flagged for batch review.** Periodic quality checks on a sample, not exhaustive review.

**Disagreement: structured arbitration.** A more capable model reviews with full context of both prior judgments.

**Persistent ambiguity: expert review queue.** The approximately 38 questions (0.55%) that all models struggled with go to human domain experts. Out of 1,598 question pairs evaluated in the harmonization stage, only 142 candidate bridge variables needed expert review. The pipeline reduced expert workload by an order of magnitude, not by replacing expert judgment but by directing it where it adds the most value.

This is the design principle: AI handles volume, humans handle judgment. The pipeline's job is to sort the easy cases from the hard cases and present experts with a curated review list, not a haystack.
```

**Replace with:**
```
Not every classification needs the same treatment. The Concept Mapper implements confidence-based routing that directs attention where it adds the most value. Items with high agreement and high confidence are auto-accepted — the vast majority of classifications require no human attention at all. Items with high agreement but borderline characteristics get flagged for periodic batch review, a sample-based quality check rather than exhaustive review. Where models disagree, a more capable model arbitrates with full context of both prior judgments. And for items where all models struggle — the approximately 38 questions (0.55%) that resisted automated resolution — the pipeline routes them to human domain experts.

Out of 1,598 question pairs evaluated in the harmonization stage, only 142 candidate bridge variables needed expert review. The pipeline reduced expert workload by an order of magnitude, not by replacing expert judgment but by directing it where it actually matters. AI handles volume. Humans handle judgment. The pipeline's job is to sort the easy cases from the hard cases and present experts with a curated review list, not a haystack.
```

**Rationale:** Flows as prose instead of choppy bold-label fragments. Same content, same structure, readable as continuous text. Preserves the key numbers and the design principle.

---

## Fix 2: Rewrite the cost paragraph

**File:** `book/chapter-02.md`

**Find:**
```
A note on costs. The dual-model classification of 6,954 questions cost approximately $15 in API fees and ran in about two hours. The full pipeline including barrier rating and arbitration cost under $100 in total API fees. The counterfactual, a research team manually classifying 7,000 questions into 152 categories, would take months of analyst time. But state this honestly: the $15 API cost is real, and the human engineering cost to design, debug, and validate the pipeline dwarfed it. That ratio inverts as you build reusable patterns and gain experience, which is part of the point of this book. Chapter 14 addresses cost accounting in full.
```

**Replace with:**
```
The dual-model classification of 6,954 questions cost approximately $15 in API fees and ran in about two hours. The full pipeline, including barrier rating and arbitration across three rater models and three arbitrator models, cost under $100 in total API fees. Manually classifying 7,000 questions into 152 categories would take months of analyst time. The API cost is real, but it is not the whole story — the human engineering cost to design, debug, and validate the pipeline dwarfed it by orders of magnitude. That ratio shifts as you build reusable patterns and accumulate experience, but the first pipeline is always the most expensive in engineering hours per dollar of API spend. Chapter 14 addresses cost accounting in full.
```

**Rationale:** Removes the "But state this honestly" session-note voice. Keeps the honest point about engineering cost dwarfing API cost but frames it as a practitioner insight rather than an aside to the author. Drops "A note on costs" throat-clearing opener. Adds specificity about what the full pipeline included (three raters + three arbitrators). The "first pipeline is always the most expensive" framing is more useful to practitioners than "that ratio inverts as you build reusable patterns."

---

## Verification

- Confirm no bold-label fragments remain in §Confidence Routing
- Confirm "A note on costs" is gone
- Confirm "But state this honestly" is gone
- Confirm all numbers preserved ($15, under $100, 38 questions, 0.55%, 1,598 pairs, 142 candidates)
- Run `seldon verify`
