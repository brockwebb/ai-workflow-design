# CC Task: Chapter 3 Perplexity Verification Fixes

**Date:** 2026-04-03
**Project:** ai-workflow-design
**Source:** Perplexity verification of `audits/chapter-03_perplexity_queries.md` (Queries 2, 4, 5)
**Target:** `book/chapter-03.md`, `book/references.bib`

---

## Context

Perplexity verification of 11 factual claims in Chapter 3 found 8 verified, 3 requiring wording adjustments. The adjustments are surgical — no structural changes, no section moves. Each fix tightens a claim to match what the evidence actually supports.

---

## Fix 1: Self-Reported Coding Error Framing (Query 2, paragraph 25)

**Current text (line 25):**
"This is the core use case. Respondents self-report codes (NAICS, SOC, NAPCS, and others) and get them wrong."

**Problem:** "Get them wrong" implies respondents directly assign classification codes and fail at it. In practice, respondents provide raw job titles or business descriptions that are then coded into classification systems by automated or manual processes. The error occurs in the coding step, not in the self-report step. A peer-reviewed SOC autocoding study (PMC6579607) found only modest agreement between automated and manual 6-digit SOC coding, confirming that classification error is real and documented — but the mechanism is coding imperfection, not respondent misreporting of codes.

**Revised text:**
"This is the core use case. Respondents provide business descriptions and job titles that must be classified into NAICS, SOC, NAPCS, and other coding systems. The resulting codes are often wrong — sometimes wildly wrong: a restaurant coded as a hospital. Sometimes plausibly wrong: a general contractor coded as a specialty trade contractor. Classification error is well-documented, especially at detailed coding levels where agreement between independent coding methods drops substantially ({cite:p}`ferraro_2019`). LLMs can read the free-text description alongside the assigned code and propose corrections."

**Note:** This merges the current lines 25 and the first part of line 27's examples into a single tighter paragraph. The "Sometimes wildly wrong" / "Sometimes plausibly wrong" examples currently at line 25 move into the revised paragraph.

**BibTeX entry to add to `references.bib`:**

```bibtex
@article{ferraro_2019,
  title={Standardized Occupation Coding: Comparing Performance of Automated and Manual Methods},
  author={Ferraro, David and others},
  journal={BMC Medical Research Methodology},
  volume={19},
  number={1},
  pages={159},
  year={2019},
  doi={10.1186/s12874-019-0794-7},
  note={PMC6579607}
}
```

**Verification note:** Confirm exact author list and page numbers against PMC6579607 before adding. The BibTeX key `ferraro_2019` is provisional — adjust to match the actual first author if different.

---

## Fix 2: Agencies "Fine-Tuning" Framing (Query 4, paragraph 39)

**Current text (line 39):**
"Some agencies are fine-tuning language models for NAICS, NAPCS, and occupation coding."

**Problem:** Perplexity found no public evidence that federal agencies are specifically "fine-tuning" language models for this purpose. The documented approaches are machine learning classifiers (Census BEACON system) and search/retrieval-based tools (SINCT for NAPCS). The rest of the paragraph already cites SINCT and the ACS modernization effort correctly — but the opening sentence overstates "fine-tuning" as the method.

**Revised text:**
"Some agencies are using machine learning and language model techniques for NAICS, NAPCS, and occupation coding."

**Rationale:** This is accurate to what the cited sources describe. The SINCT citation (census_fedcasic_2024) documents a search-based system. The reveal_2025 citation documents LLM embeddings and fine-tuning for ACS. The opening sentence should cover both approaches without implying all agencies are fine-tuning. The rest of the paragraph (which discusses fine-tuning costs and tradeoffs) remains correct as written because it is conditional: "Fine-tuning is a legitimate approach, and in specific circumstances it is the right one. But teams that go down this path frequently underestimate the total cost..."

---

## Fix 3: TCO Component List Framing (Query 5, paragraph 41)

**Current text (line 41, opening):**
"**The comparison most teams skip.** Fine-tuning requires training data curation (who labels the training set, and how do you know the labels are right?), compute for training (GPU time, cloud or on-premises), an evaluation harness..."

**Problem:** Minor. The component list is accurate but is presented without attribution. Perplexity confirmed all components are documented in Census BEACON and NBER papers on agency ML systems, but no single source provides a formal "TCO checklist." The current framing is fine as practitioner guidance — but the parenthetical questions ("who labels the training set, and how do you know the labels are right?") are the chapter's strongest contribution here and should not be cut.

**Action:** No text change required. The framing as practitioner guidance ("The comparison most teams skip") is already appropriately scoped — it does not claim to cite a formal TCO framework. The component list is well-supported by the Census and NBER sources Perplexity surfaced. Leave as-is.

---

## Sequencing

1. Fix 1 first (paragraph restructure)
2. Fix 2 second (single sentence replacement)
3. Fix 3: no action needed
4. Add BibTeX entry last

---

## Verification Checklist

- [ ] Line 25 no longer says respondents "get them wrong" — reframed as coding error
- [ ] Ferraro et al. citation added with `{cite:p}` markup
- [ ] Line 39 says "machine learning and language model techniques" not "fine-tuning language models"
- [ ] BibTeX entry for ferraro_2019 in references.bib with correct metadata from PMC6579607
- [ ] No other paragraphs modified
- [ ] `seldon verify` passes after edits

---

## Do NOT

- Restructure any sections — these are surgical text fixes only
- Modify any other chapter files
- Remove or modify the SINCT or reveal_2025 citations — those are correct
- Remove the fine-tuning cost discussion — it is well-supported; only the opening sentence overstates
