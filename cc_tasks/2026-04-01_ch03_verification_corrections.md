# CC Task: Chapter 3 Verification Corrections Addendum

**Date:** 2026-04-01
**Scope:** `book/chapter-03.md`, `book/references.bib`
**Type:** Addendum to `2026-04-01_ch03_comprehensive_revision.md`
**Status:** PENDING
**Execute after:** `2026-04-01_ch03_comprehensive_revision.md`

---

## Context

Perplexity verification and direct paper review (PDF of Tian et al. 2025 obtained and extracted) produced corrections to three areas: the tian_2025 bib entry (author names wrong, F1 ranges imprecise), the Fortier 2017 taxonomy (exact terms confirmed as "complete," "partial," "impossible"), and two TBD author lists now filled. This addendum applies on top of the comprehensive revision.

---

## Fix 1: Correct tian_2025 bib entry — author names and F1 ranges

**File:** `book/references.bib`

**Find the existing `tian_2025` entry and replace it entirely with:**

```bibtex
@inproceedings{tian_2025,
  author    = {Tian, Weiyushi (Sarah) and Lu, Yu-Shan (Angelina) and Ding, Yuchen and West, Brady T.},
  title     = {Comparing Large Language Models and Traditional Methods for Imputing Missing Survey Responses in a 2024 {U.S.} Presidential Election Survey},
  booktitle = {AAPOR 2025 Annual Conference},
  year      = {2025},
  note      = {Ipsos Reuters 2024 U.S. election survey, N=4,677, categorical responses with induced MNAR missingness. Llama 2 13B (few-shot) achieved mean F1 0.61--0.67 across three question sets, exceeding MICE (0.50--0.61) and KNN (0.41--0.55). LLM won on 2 of 3 datasets; tied MICE on believability questions (both F1 0.61). LLM ran approximately 40x slower than MICE (4h vs. 5 min per run).}
}
```

**Changes from current entry:**
- Author 1: "Wenshan" → "Weiyushi (Sarah)" (verified from paper title page)
- Author 2: "Yulei" → "Yu-Shan (Angelina)" (verified from paper title page)
- Author 3: "Yu" → "Yuchen" (verified from paper title page)
- F1 range: "0.65--0.66" → "0.61--0.67" (actual range across three datasets)
- MICE range: "0.50--0.58" → "0.50--0.61" (MICE scored 0.61 on believability dataset)
- KNN range: "0.29--0.55" → "0.41--0.55" (0.29 was accuracy, not F1)
- Added: N=4,677, MNAR design, Ipsos Reuters source, "won on 2 of 3 datasets; tied MICE on believability"
- Added: runtime detail "4h vs. 5 min per run"

---

## Fix 2: Correct chapter prose for tian_2025 citation

**File:** `book/chapter-03.md`
**Section:** "Where Traditional Methods Still Win"

**Find:**
```
{cite:t}`tian_2025` showed LLM imputation outperforming MICE on categorical variables (F1 0.65 versus 0.50) in a real 2024 election survey, but at 40 times the computational cost. Even in the best case for LLMs, the cost-performance tradeoff is narrow, and it only favors LLMs on categorical variables where the "imputation" is closer to classification (what category does this record belong to?) than to statistical estimation (what value should this variable have?). This is evidence that the boundary is real, not an endorsement of replacing established imputation methods with LLMs.
```

**Replace with:**
```
{cite:t}`tian_2025` compared LLM imputation against MICE and KNN on categorical variables in a real 2024 U.S. election survey with induced nonresponse. Llama 2 13B with few-shot prompting achieved mean F1 of 0.61 to 0.67 across three question sets, exceeding MICE (0.50 to 0.61) on two of three datasets and tying it on the third, at 40 times the computational cost. The advantage was strongest on polarized items where response patterns cluster clearly; on less polarized questions, the LLM's edge narrowed or disappeared. Even in the best case for LLMs, the cost-performance tradeoff is narrow, and it only favors LLMs on categorical variables where the "imputation" is closer to classification (what category does this record belong to?) than to statistical estimation (what value should this variable have?). This is evidence that the boundary is real, not an endorsement of replacing established imputation methods with LLMs.
```

**Changes:** Corrected F1 ranges to match paper. Added "2 of 3 datasets" nuance and the polarization-dependent performance pattern (verified from paper: "Models tend to have higher accuracy on imputing the Issue Importance for Voting questions: emotive terms like 'punished', 'jailed', and 'camps' produce polarized embeddings").

---

## Fix 3: Restore Fortier 2017 exact taxonomy terms

**File:** `book/chapter-03.md`
**Section:** "Schema Inference and Data Combination" (after the comprehensive revision has been applied)

**Find:**
```
Not all mappings are equal: some source variables map directly to a target variable, some require transformation that loses information, and some simply cannot support the target construct at all ({cite:p}`fortier_2017`).
```

**Replace with:**
```
Not all mappings are equal. The retrospective harmonization literature distinguishes complete harmonization (source maps directly to target), partial harmonization (mapping requires transformation that loses information), and impossible harmonization (source cannot support the target construct) ({cite:p}`fortier_2017`).
```

**Rationale:** Perplexity confirmed the exact three-level terms from the DataSHaPER/Fortier literature: "complete," "partial," "impossible." Safe to use the precise terminology.

---

## Fix 4: Fill TBD author lists in bib entries

**File:** `book/references.bib`

### 4a: pdf_parser_benchmark_2026

**Find:**
```
  author    = {{TBD -- verify from arXiv page}},
```

**Replace with:**
```
  author    = {Horn, Pius and Keuper, Janis},
```

### 4b: tada_vldb_2024

**Find:**
```
  author    = {{TBD -- verify full author list from paper}},
```

**Replace with:**
```
  author    = {Parciak, Marcel and Vandevoort, Brecht and Neven, Frank and Peeters, Liesbet M. and Vansummeren, Stijn},
```

---

## Verification

After all edits:

1. `grep 'Wenshan' book/references.bib` — expect 0 results (old author name removed)
2. `grep 'Weiyushi' book/references.bib` — expect 1 result (corrected author name)
3. `grep 'TBD' book/references.bib` — expect 0 results (all author lists filled)
4. `grep '0\.65 versus 0\.50' book/chapter-03.md` — expect 0 results (old numbers removed)
5. `grep 'complete harmonization' book/chapter-03.md` — expect 1 result
6. Verify `references.bib` remains in alphabetical order by key
7. Run `seldon verify --fix`

---

## Acceptance Criteria

- [ ] tian_2025 bib entry corrected (authors, F1 ranges, detail)
- [ ] Chapter prose for tian_2025 corrected (ranges, nuance, polarization pattern)
- [ ] Fortier 2017 exact taxonomy terms restored
- [ ] pdf_parser_benchmark_2026 author list filled (Horn, Keuper)
- [ ] tada_vldb_2024 author list filled (Parciak, Vandevoort, Neven, Peeters, Vansummeren)
- [ ] Zero TBD entries remain in references.bib
- [ ] No em-dashes introduced
- [ ] `seldon verify` passes
