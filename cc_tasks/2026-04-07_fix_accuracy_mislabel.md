# CC Task: Fix "99.5% Accuracy" Mislabel in Ch 14

**Date:** 2026-04-07
**Scope:** Single table cell correction in chapter-14.md

---

## Context

The Concept Mapper cost comparison table in Ch 14 (line 32) labels 99.5% as "Accuracy." This is incorrect. The 99.5% figure represents the **automated resolution rate**: the percentage of questions the pipeline classified without routing to human review. It is not an accuracy measurement.

Accuracy would require evaluation against a ground truth (human-labeled gold standard). The actual quality metric for the Concept Mapper is inter-rater agreement: Cohen's kappa = 0.839 at topic level, 0.687 at subtopic level (reported in Ch 2, line 76). These measure consistency between independent models, not correctness against ground truth.

Labeling resolution rate as accuracy is precisely the kind of metric conflation the book warns against (confidence laundering, Ch 4). This was a confabulation that accumulated through drafting iterations, not an intentional claim.

---

## Edit 1: Fix table row in chapter-14.md

**File:** `book/chapter-14.md`
**Location:** Line 32 (inside the Concept Mapper worked example table)

**Current text:**
```
| Accuracy | 99.5% (dual-model cross-validated) | Varies by analyst, estimated comparable |
```

**Replace with:**
```
| Automated resolution | 99.5% classified without human review; kappa = 0.839 topic-level agreement | Varies by analyst, estimated comparable |
```

**No other instances of this claim exist in the book.** Ch 2 correctly reports kappa values.

---

## Edit 2: Update CLAUDE.md Key Source Material

**File:** `CLAUDE.md`
**Location:** Key Source Material section, Federal Survey Concept Mapper bullet

**Current text (substring):**
```
99.5% accuracy
```

**Replace with:**
```
99.5% automated resolution rate, kappa = 0.839
```

---

## Verification

- `grep "Accuracy.*99.5" book/chapter-14.md` should return nothing
- `grep "Automated resolution.*99.5" book/chapter-14.md` should return one line
- `grep "99.5.*accuracy" CLAUDE.md` should return nothing
- Build: `cd book && myst build --html` should complete cleanly
