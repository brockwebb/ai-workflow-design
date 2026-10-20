# CC Task: Cross-Chapter Coherence Fixes — Naming, Labeling, Terminology, Recovery Pointer

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` — CC-2, CC-9, CC-10, and Ch 7 post-recovery pointer (Section 2C item 12)
**Scope:** Four targeted fixes across four files. Each is 1-3 sentences. No author judgment required — all decisions were made in the sweep synthesis or author decision record.

---

## Fix 1: Name the "specification-before-execution" pattern in Ch 10 (CC-2)

**File:** `book/chapter-10.md`
**Location:** Requirement 7 paragraph (begins "**Requirement 7: Change gating through specification documents.**")
**Issue:** The foreword, Ch 11, and the glossary all reference "specification-before-execution" as "Chapter 10's pattern." Ch 10 never names it. The term is orphaned.
**Action:** Add two sentences at the end of the Requirement 7 paragraph, formally naming the pattern.

**After the sentence ending** `...the specification is the auditable artifact, not the change itself.`

**Add:**
```
This is the specification-before-execution pattern: define what will change and why before making the change. The specification document is not bureaucracy; it is the artifact that makes the change auditable, reversible, and attributable to a deliberate decision rather than an ad-hoc edit.
```

**Note:** Match the existing paragraph's voice — direct, practitioner-facing, no throat-clearing. The first sentence names the pattern; the second sentence explains why it matters in one clause.

---

## Fix 2: Label the five degradation pathways in Ch 1 (CC-9)

**File:** `book/chapter-01.md`
**Location:** "The Iterative Refinement Trap" section, after the paragraph ending `...external evaluation prevents self-refinement degradation. Design accordingly.` (the paragraph about training-time collapse parallels, approximately line 50)
**Issue:** Ch 5 backward-references "Chapter 1 documented five degradation pathways." Ch 1 has the five pathways substantively but never enumerates or labels them. The Ch 5 claim is currently unverifiable by a reader flipping back to Ch 1.
**Action:** Add an explicit enumeration after the model collapse parallel paragraph, before the "## The Systems Engineering Gap" section.

**Insert:**

```
Five degradation pathways are now documented in the literature. *Diminishing returns*: self-refinement gains concentrate in the first iteration and plateau rapidly ({cite:p}`madaan_2023`). *Convergence ceiling*: a mathematical bound on achievable accuracy regardless of iteration count ({cite:p}`yang_2025`). *Self-bias amplification*: models systematically overrate their own output, and the bias grows with each iteration ({cite:p}`xu_2024`). *Reward hacking*: when generator and evaluator are the same model, the generator exploits the evaluator's preferences ({cite:p}`pan_2024`). *Recursive self-consumption*: the structural parallel to training-time model collapse, where iterative self-refinement degrades output diversity and quality ({cite:p}`shumailov_2024;alemohammad_2023`). All five pathways share one remedy: external signal.
```

**Note:** This is a summary enumeration, not new content. All five pathways and all citations are already present in the preceding paragraphs. This paragraph makes them findable. Keep it as a single dense paragraph — do not convert to a bulleted list (matches Ch 1's prose style).

---

## Fix 3: Stochastic tax → confabulation risk in Ch 4 (CC-10)

**File:** `book/chapter-04.md`
**Location:** Line ~78, the paragraph about metadata-only input pattern.
**Issue:** Ch 1 defines stochastic tax as the cost of invoking an LLM when a deterministic method would suffice. Ch 4 extends the meaning to "confabulation risk from unnecessary input fields" — a different concept. This is a term collision, not a valid extension.

**Find:** `This is stochastic tax reduction applied to extraction pipeline design.`

**Replace with:** `This is confabulation risk reduction applied to extraction pipeline design: fewer input dimensions mean fewer opportunities for the model to generate plausible-sounding wrong answers about fields it should never have seen.`

**Note:** The replacement preserves the design insight (less input surface = more reliable output) while using the correct term. The added clause makes the mechanism explicit for practitioners.

---

## Fix 4: Post-recovery equivalence validation pointer in Ch 7

**File:** `book/chapter-07.md`
**Location:** After the "Resume logic" paragraph (the one beginning "**Resume logic.** On startup, the pipeline checks for an existing checkpoint."), approximately line 111-113.
**Issue:** Ch 7 covers checkpoint recovery mechanics but never addresses how to validate that recovered runs produce equivalent output to uninterrupted runs. Ch 8's golden test set is the mechanism.
**Action:** Add 1-2 sentences after the resume logic paragraph.

**After the sentence ending** `...You resume from the last record in the results file, not from the beginning.` (end of the "When the checkpoint itself fails" paragraph, approximately line 113)

**Add:**

```
Recovery answers whether the pipeline resumes. It does not answer whether the resumed run produces equivalent output. A checkpoint restart changes the model's context state: the prompt history, the sequence of prior outputs, even the random seed path may differ from an uninterrupted run. Chapter 8's golden test set is the validation mechanism: run your recovered output against the same reference set you use for regression testing, and verify that the agreement metrics hold.
```

**Note:** This connects the Ch 7 recovery machinery to Ch 8's evaluation infrastructure. Keep it concrete — name the mechanism (golden test set), name the check (agreement metrics), keep it to 3-4 sentences max.

---

## Verification Checklist

After all edits:
- [ ] Grep Ch 10 for "specification-before-execution" — should appear at least once
- [ ] Grep Ch 1 for "Five degradation pathways" — should appear exactly once
- [ ] Grep Ch 4 for "stochastic tax reduction" — should return NO results (replaced by "confabulation risk reduction")
- [ ] Grep Ch 4 for "confabulation risk reduction" — should appear exactly once
- [ ] Grep Ch 7 for "golden test set" — should appear at least once
- [ ] Verify Ch 1 citations in the enumeration paragraph match citations already in references.bib (madaan_2023, yang_2025, xu_2024, pan_2024, shumailov_2024, alemohammad_2023) — all should already be present

## Files Modified

`book/chapter-10.md`, `book/chapter-01.md`, `book/chapter-04.md`, `book/chapter-07.md`

## Items Verified Clean (No Action Needed)

- Em-dash purge (foreword through Ch 2): already clean, no em-dashes found
- `\$` escaping (foreword through Ch 2): already properly escaped
- Back matter TOC reorder (bibliography before glossary): already in correct order in `myst.yml`
