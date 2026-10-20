# CC Task: Chapter 3 Audit Prose Fixes

**Date:** 2026-04-01
**Scope:** `book/chapter-03.md`, `book/references.bib`
**Type:** Prose fix + citation additions
**Status:** PENDING
**Depends on:** `2026-04-01_ch03_perplexity_verification.md` (for V2, V3, V4 results — apply those fixes after Perplexity results are in)

---

## Context

Chapter 3 audit (Session 17) identified prose fixes that can proceed independent of Perplexity verification. Perplexity-dependent fixes (LLM vs NLP claim, fine-tuning TCO citation, deployment timeline citation) are handled separately after verification results are in.

---

## Fix 1: Pragmatics reference — replace orphan system name with proper citation

**File:** `book/chapter-03.md`
**Line 49**

**Find:** `the metadata that Chapter 8's evaluation framework and the Pragmatics system's expert judgment layer are designed to provide`

**Replace with:** `the metadata that Chapter 8's evaluation framework addresses, or the kind of structured expert judgment that can be delivered through system-level context ({cite:p}\`webb_2026_pragmatics\`)`

**Rationale:** "The Pragmatics system" reads as an orphan reference to an unexplained product. The citation exists in references.bib as `webb_2026_pragmatics`. Reframe as the methodology, not a product name.

---

## Fix 2: Chapter header WP comment — flag discrepancy, do not fix yet

**File:** `book/chapter-03.md`
**Line 3**

**Current:** `<!-- Primary Working Principle: Outputs require full provenance -->`

**CLAUDE.md says:** "Reuse data before collecting more"

**Action:** Do NOT change either file. Add a comment noting the discrepancy:

```
<!-- Primary Working Principle: DISCREPANCY — file says "Outputs require full provenance", CLAUDE.md mapping says "Reuse data before collecting more". Verify against Seldon graph before resolving. -->
```

**Rationale:** The graph is the source of truth, not CLAUDE.md. Cannot verify graph mapping in current session. Flag for resolution when graph is accessible.

---

## Fix 3: Add Fellegi-Holt citation to references.bib

**File:** `book/references.bib`

**Add entry (maintain alphabetical order by key — insert after any 'e' entries and before any 'f' entries that follow):**

```bibtex
@article{fellegi_1976,
  author    = {Fellegi, Ivan P. and Holt, D. Tim},
  title     = {A Systematic Approach to Automatic Edit and Imputation},
  journal   = {Journal of the American Statistical Association},
  year      = {1976},
  volume    = {71},
  number    = {353},
  pages     = {17--35},
  note      = {Foundational framework for automated survey data editing. Minimum-change principle: correct fewest possible fields to satisfy all edit constraints.}
}
```

**Pending Perplexity confirmation of full citation details (V5).**

---

## Fix 4: Add MICE (van Buuren) citation to references.bib

**File:** `book/references.bib`

**Add entry (maintain alphabetical order — insert in 'v' section):**

```bibtex
@article{van_buuren_2011,
  author    = {van Buuren, Stef and Groothuis-Oudshoorn, Karin},
  title     = {mice: Multivariate Imputation by Chained Equations in {R}},
  journal   = {Journal of Statistical Software},
  year      = {2011},
  volume    = {45},
  number    = {3},
  pages     = {1--67},
  note      = {Reference implementation of MICE algorithm for multiple imputation.}
}
```

**Pending Perplexity confirmation of full citation details (V5).**

---

## Fix 5: Add citations in chapter text for Fellegi-Holt and MICE

**File:** `book/chapter-03.md`
**Line 81 (Where Traditional Methods Still Win section)**

**Find:** `MICE, hot-deck, Fellegi-Holt, and other established imputation methods`

**Replace with:** `MICE ({cite:p}\`van_buuren_2011\`), hot-deck, Fellegi-Holt ({cite:p}\`fellegi_1976\`), and other established imputation methods`

---

## Fix 6: Add Chapter 14 cross-reference in fine-tuning cost section

**File:** `book/chapter-03.md`
**Line 33 (end of the "comparison most teams skip" paragraph)**

The paragraph currently ends with: `...because people account for the API cost but not for the human engineering cost of the fine-tuning pipeline.`

**Append:** ` Chapter 14 provides a cost accounting framework that makes this comparison explicit.`

---

## Fix 7: Remove "6 to 18 months" repetition

**File:** `book/chapter-03.md`
**Line 39 (second occurrence)**

**Find:** `Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt. The procurement and security process takes 6 to 18 months. That is 6 to 18 months of pipeline development, evaluation design, and benchmark construction you can do in parallel, if you plan for it.`

**Replace with:** `Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt. That procurement and security timeline is pipeline development time you can use in parallel, if you plan for it.`

---

## Verification

After all edits:

1. Run `grep -n 'Pragmatics system' book/chapter-03.md` — expect 0 results
2. Run `grep -n 'cite:' book/chapter-03.md` — expect pragmatics, fellegi, and van_buuren citations present
3. Run `grep -n 'Chapter 14' book/chapter-03.md` — expect at least one reference
4. Verify `references.bib` remains in alphabetical order by key
5. Run `seldon verify --fix` after edits

---

## Acceptance Criteria

- [ ] Pragmatics reference uses proper citation, not product name
- [ ] Chapter header WP discrepancy flagged (not resolved — awaiting graph verification)
- [ ] Fellegi-Holt and MICE bib entries added
- [ ] Citations added in chapter text
- [ ] Ch 14 cross-reference added to fine-tuning section
- [ ] "6 to 18 months" repetition cleaned up
- [ ] No new em-dashes introduced
- [ ] `seldon verify` passes
