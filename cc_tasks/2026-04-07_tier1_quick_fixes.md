# CC Task: Tier 1 Quick Fixes -- Evaluation Trap in Ch 1, Intro Narrative Bridge

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` -- DG-4 (CC-3), Section 2C item 18
**Scope:** Two fixes across two files. One paragraph addition to Ch 1, two small text insertions in intro.md. No author judgment required -- all decisions were made in `docs/2026-04-06_author_decisions_run004.md`.

---

## Fix 1: Add "evaluation trap" as a named failure mode in Ch 1 (DG-4 / CC-3)

**File:** `book/chapter-01.md`
**Location:** After the "Five degradation pathways" enumeration paragraph (the one ending "All five pathways share one remedy: external signal."), before the `## The Systems Engineering Gap` heading.
**Issue:** Ch 6 (line 73) references "the evaluation trap from Chapter 1." Ch 8 (lines 61, 111) references "the evaluation trap" as a named concept originating in Ch 1. But Ch 1 never defines or names the evaluation trap. The five degradation pathways above are about self-refinement loops. The evaluation trap is a different failure mode: spending months comparing models on generic benchmarks, producing conclusions that are obsolete before publication. It belongs in Ch 1's failure mode taxonomy as a distinct item.
**Decision:** DG-4 resolved in author decision session -- add the evaluation trap to Ch 1.

**After the paragraph ending** `All five pathways share one remedy: external signal.`

**Insert:**

```
There is a sixth failure mode that operates at a different level. The *evaluation trap* is not about self-refinement loops but about how teams allocate evaluation effort. The pattern: a team spends months comparing five models on generic benchmarks, producing a detailed comparison report. By the time the report is ready, two of the models have been updated, one has been deprecated, and a new contender has entered the market. The conclusions are obsolete before publication. The cost is not API fees; it is researcher time consumed by evaluation activities that do not produce actionable results for the specific pipeline. Chapter 6 addresses this directly through model selection as an engineering decision, and Chapter 8 inverts it: instead of exhaustive comparison on generic benchmarks, build evaluation infrastructure that tests *your* pipeline on *your* data after every change.
```

**Note:** This paragraph must be consistent with Ch 6 line 73 ("This connects to the evaluation trap from Chapter 1. The rate of model advancement is so fast that extended comparison experiments produce obsolete conclusions.") and Ch 8 line 61 ("This is the evaluation trap from Chapter 1 inverted") and Ch 8 line 111 ("The evaluation trap economics: months of model comparison on generic benchmarks produces conclusions that are obsolete by publication."). The inserted paragraph establishes the concept that those references point back to. Match Ch 1's existing voice -- direct, no throat-clearing, practitioner-facing.

---

## Fix 2: Intro narrative bridge and closing sentence

**File:** `book/intro.md`

### Fix 2A: Transition from motivational to structural

**Location:** Between the end of "## Find Your Edge" section and the `## How This Book Is Organized` heading.
**Issue:** The intro moves from five motivational sections (A New Design Space, First Principles, The Hardest Part, Learning to See, Find Your Edge) directly into a structural chapter tour with no transition. The shift is abrupt.

**After the paragraph ending** `You will look back at what you were doing three months ago and it will seem impossibly slow. That is the trajectory.`

**Before** `## How This Book Is Organized`

**Insert:**

```
The chapters that follow are organized around the practical question of how to get there. Each one addresses a specific design challenge, from classification workflows and ensemble patterns to evaluation infrastructure and institutional deployment. The sequence is deliberate: the book builds from concrete pipeline problems to cross-cutting patterns to the validity and governance questions that determine whether your work survives contact with institutional reality.
```

### Fix 2B: Closing sentence

**Location:** End of intro.md, after the final paragraph of the "Where to Start" section (the one ending "No prerequisites required.").
**Issue:** The intro ends on the ai4stats bridge paragraph, which is useful but niche (only relevant to readers of the predecessor book). The intro should close by returning to the central premise -- the one established in "A New Design Space."

**After the sentence ending** `No prerequisites required.`

**Add a blank line and then:**

```
Whatever your starting point, the core premise is the same: these tools have opened a design space that rewards disciplined engineering. The rest of this book teaches you how to work in it.
```

---

## Verification Checklist

- [ ] Grep Ch 1 for "evaluation trap" -- should appear at least once (the new paragraph)
- [ ] Grep Ch 6 for "evaluation trap from Chapter 1" -- should still be present (no change to Ch 6)
- [ ] Grep Ch 8 for "evaluation trap" -- should appear at least twice (no change to Ch 8)
- [ ] Verify no em-dashes were introduced in any inserted text
- [ ] Verify the Ch 1 insertion appears after the "Five degradation pathways" paragraph and before `## The Systems Engineering Gap`
- [ ] Verify intro.md transition paragraph appears between "Find Your Edge" section and "How This Book Is Organized" heading
- [ ] Verify intro.md closing sentences are the last text in the file

## Files Modified

`book/chapter-01.md` (one paragraph addition)
`book/intro.md` (one transition paragraph, one closing sentence)
