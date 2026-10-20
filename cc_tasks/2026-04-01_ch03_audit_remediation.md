# CC Task: Chapter 3 Audit Remediation — Full Prose Revision

**Date:** 2026-04-01
**Scope:** `book/chapter-03.md`, `book/references.bib`
**Type:** Prose revision + citation additions (evidence-backed)
**Status:** PENDING
**Supersedes:** `2026-04-01_ch03_audit_prose_fixes.md`, `2026-04-01_ch03_perplexity_verification.md`

---

## Context

Full content audit of Chapter 3 (Session 18) combined with two rounds of Perplexity verification produced 24 classified assertions, 7 citation gaps, 3 unsupported claims, and 2 thin sections. All findings now have evidence-backed resolutions. This CC task implements all fixes in a single pass.

**Sources for new citations (bib entries below):**
- Census Bureau FedCASIC 2024: SINCT for NAPCS coding, 78% fewer write-ins in 2022 Economic Census
- Reveal 2025: ACS autocoder modernization using LLM embeddings + fine-tuning for occupation/industry coding
- OMB M-25-21 (April 2025): AI acquisition memo, 180-day compliance window
- PDF parser benchmark 2026: 1,554 human ratings on 518 table pairs, LLM judges outperform rule-based metrics
- Verasight LLM imputation study: mean absolute subgroup errors >10 percentage points, distributional distortion
- Comparative topic modeling study: LLMs vary in diversity vs. relevance for topic extraction

---

## Fix 1: Fine-tuning section — add evidence for federal coding use case

**File:** `book/chapter-03.md`
**Section:** "The Fine-Tuning Cost Trap", first paragraph

**Find:**
```
Some agencies are fine-tuning small language models for NAICS and NAPCS coding. This is a legitimate approach, and in specific circumstances it is the right one. But most teams that go down this path do not do the cost comparison honestly.
```

**Replace with:**
```
Some agencies are fine-tuning language models for NAICS, NAPCS, and occupation coding. The Census Bureau's SINCT system for NAPCS coding reduced write-in responses by 78% in the 2022 Economic Census ({cite:p}`census_fedcasic_2024`), and a 2025 modernization effort applied LLM embeddings and fine-tuning to improve ACS occupation and industry autocoding ({cite:p}`reveal_2025`). Fine-tuning is a legitimate approach, and in specific circumstances it is the right one. But teams that go down this path frequently underestimate the total cost relative to the API alternative.
```

**Rationale:** Replaces unsourced "some agencies" with two specific, citable federal examples. Reframes "most teams do not do the cost comparison honestly" (judgment stated as fact) to "teams frequently underestimate" (softer, defensible framing).

---

## Fix 2: Fine-tuning cost comparison — rewrite as conditional framework

**File:** `book/chapter-03.md`
**Section:** "The comparison most teams skip" paragraph

**Find:**
```
For most use cases, the total cost of ownership for fine-tuning exceeds the API approach, often by a large margin, because people account for the API cost but not for the human engineering cost of the fine-tuning pipeline.
```

**Replace with:**
```
The cost comparison is conditional. At lower or moderate utilization, API access is operationally simpler and usually cheaper. Fine-tuning and self-hosting become cost-effective only when throughput is high, the workload is stable enough to absorb GPU and MLOps overhead, and the use case is mature enough to justify the engineering investment. The mistake most teams make is accounting for the per-call API cost while ignoring the human engineering cost of the fine-tuning pipeline: training data curation, evaluation harness development, retraining when classification systems update, model hosting, and staff expertise to manage the lifecycle.
```

**Rationale:** Replaces blanket claim with conditional framework supported by practitioner evidence. Stronger argument because it becomes a design decision tool, not a one-sided recommendation.

---

## Fix 3: Add Chapter 14 cross-reference

**File:** `book/chapter-03.md`
**Section:** End of "The comparison most teams skip" paragraph (after the replacement text from Fix 2)

**Append to end of that paragraph:**
```
 Chapter 14 provides a cost accounting framework that makes this comparison explicit.
```

---

## Fix 4: Title 13 / CIPSEA — soften legal characterization

**File:** `book/chapter-03.md`
**Section:** "When fine-tuning is the right call" paragraph

**Find:**
```
Data sensitivity that genuinely prohibits cloud API access: Title 13 data, CIPSEA-protected microdata, data with legal restrictions on transmission to external services.
```

**Replace with:**
```
Data sensitivity that creates significant legal barriers to cloud API access: Title 13 data, CIPSEA-protected microdata, and other data with legal restrictions on transmission to parties outside the agency's authorized workforce.
```

**Rationale:** CIPSEA restricts disclosure to authorized agents; whether a cloud API provider qualifies as an agent is a legal determination, not a blanket prohibition. "Creates significant legal barriers" is accurate without overstating.

---

## Fix 5: Deployment timeline — frame as judgment, cite OMB memo

**File:** `book/chapter-03.md`
**Section:** "When fine-tuning is the right call" paragraph

**Find:**
```
But even in these cases, the institutional deployment tax from Chapter 13 applies: finding the budget, navigating security review, procuring and installing hardware, getting priority in the infrastructure queue, setup and staff learning, quality benchmarking against the existing process. This can take 6 to 18 months before you process a single production record.
```

**Replace with:**
```
But even in these cases, the institutional deployment tax from Chapter 13 applies: finding the budget, navigating security review, procuring and installing hardware, getting priority in the infrastructure queue, setup and staff learning, quality benchmarking against the existing process. In practice, this takes 6 to 18 months before you process a single production record. Even the policy compliance path alone has multi-month lead times: OMB's 2025 AI acquisition memo ({cite:p}`omb_ai_procurement_2025`) establishes a 180-day compliance window for new contracts, with agencies required to update internal acquisition procedures within approximately eight months of issuance.
```

**Rationale:** Frames "6 to 18 months" as practitioner experience ("in practice"), then provides a concrete policy floor via the OMB memo. The OMB timeline covers only the acquisition compliance window, not the full deployment path, which makes the 6-18 month range more credible, not less.

---

## Fix 6: Remove "6 to 18 months" repetition

**File:** `book/chapter-03.md`
**Section:** "If you are going down the local deployment path" paragraph

**Find:**
```
Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt. The procurement and security process takes 6 to 18 months. That is 6 to 18 months of pipeline development, evaluation design, and benchmark construction you can do in parallel, if you plan for it.
```

**Replace with:**
```
Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt. That procurement and security timeline is pipeline development time you can use in parallel, if you plan for it.
```

---

## Fix 7: Format Extraction — add nuance on LLM vs rule-based

**File:** `book/chapter-03.md`
**Section:** "Format Extraction and Standardization", second paragraph

**Find:**
```
This is the universal parser use case. LLMs handle format diversity better than any rule-based system because they can interpret structure from context rather than requiring explicit parsing rules for each format. A rule-based parser needs a new rule for every variation. An LLM reads the document and maps what it finds to the schema you defined.
```

**Replace with:**
```
This is the universal parser use case, but the advantage is conditional. LLMs handle format diversity better than rule-based systems when documents vary widely in structure, because they interpret structure from context rather than requiring explicit parsing rules for each format. Recent benchmarking of document extraction methods confirms that LLM-based evaluation correlates better with human judgment than rule-based similarity metrics for semantically complex tables ({cite:p}`pdf_parser_benchmark_2026`). But rule-based and zonal OCR parsers remain superior for fixed, repetitive layouts where deterministic throughput matters more than semantic flexibility. The design pattern is hybrid: rule-based extraction for stable templates, LLM-assisted extraction for heterogeneous or high-variance documents.
```

**Rationale:** Replaces blanket "better than any rule-based system" with evidence-backed conditional framework. Cites the 2026 PDF parser benchmark. Adds the hybrid design pattern, which is a stronger and more honest recommendation.

---

## Fix 8: Semantic Analysis — rewrite "no traditional NLP" claim

**File:** `book/chapter-03.md`
**Section:** "Semantic Analysis of Open-Ended Responses", second paragraph

**Find:**
```
This is where LLMs have the clearest advantage over any prior method. No traditional NLP approach handles open-ended semantic analysis at this quality level. Topic models, keyword extraction, and sentiment analysis are crude approximations compared to what a language model can produce from the same input.
```

**Replace with:**
```
This is where LLMs have a genuine advantage, but the boundary is more nuanced than it first appears. LLMs are stronger for keyword extraction and topic naming when you want semantic grouping from short, messy, or highly varied responses, because the model can infer latent meaning rather than just count repeated terms. Traditional topic models remain better when you need reproducible, corpus-level structure and simpler interpretability, or when you need a fixed coding scheme tracked consistently over time. Comparative studies show that different LLMs vary substantially in diversity versus relevance of extracted topics, which matters when your survey analysis needs stable categories rather than creative labels. In practice, the most effective pattern is often hybrid: LLMs generate candidate keywords or topic labels, then a human or rule layer consolidates them for downstream analysis.
```

**Rationale:** Replaces absolute claim with evidence-backed conditional comparison. Acknowledges topic model strengths. Adds the hybrid pattern. Much more defensible.

---

## Fix 9: "Where Traditional Methods Still Win" — strengthen with imputation evidence

**File:** `book/chapter-03.md`
**Section:** "Imputation of missing values" paragraph

**Find:**
```
LLMs do not maintain distributional properties and have no concept of survey design. They will impute a plausible-looking value that has no relationship to the distribution of the variable in the population.
```

**Replace with:**
```
LLMs do not maintain distributional properties and have no concept of survey design. They will impute a plausible-looking value that has no relationship to the distribution of the variable in the population. Empirical evidence confirms this: LLM-based imputation can approximate highly polarized toplines but struggles with less polarized questions and subgroup estimates, with mean absolute subgroup errors exceeding 10 percentage points in one study. Adding extra anchors or chain-of-thought prompting did not reliably improve population totals. Survey weights do not solve the core problem, because weighted estimates still depend on the model's ability to represent the missing-data mechanism and the joint distribution of responses.
```

**Rationale:** Adds concrete empirical evidence for the LLM imputation limitation claim. Strengthens the argument with specific numbers rather than relying on theoretical assertion alone.

---

## Fix 10: Pragmatics orphan reference — replace with citation

**File:** `book/chapter-03.md`
**Section:** "Schema Inference and Data Combination"

**Find:**
```
the metadata that Chapter 8's evaluation framework and the Pragmatics system's expert judgment layer are designed to provide
```

**Replace with:**
```
the metadata that Chapter 8's evaluation framework addresses, or the kind of structured expert judgment that can be delivered through system-level context ({cite:p}`webb_2026_pragmatics`)
```

---

## Fix 11: Add MICE and Fellegi-Holt inline citations

**File:** `book/chapter-03.md`
**Section:** "Where Traditional Methods Still Win"

**Find:**
```
MICE, hot-deck, Fellegi-Holt, and other established imputation methods
```

**Replace with:**
```
MICE ({cite:p}`van_buuren_2011`), hot-deck, Fellegi-Holt ({cite:p}`fellegi_1976`), and other established imputation methods
```

---

## Fix 12: Add new bib entries to references.bib

**File:** `book/references.bib`

Add the following entries, maintaining alphabetical order by key. Do NOT modify any existing entries.

```bibtex
@misc{census_fedcasic_2024,
  author       = {{U.S. Census Bureau}},
  title        = {Machine Learning for In-Instrument Product Code Search: {SINCT} for {NAPCS} Coding},
  year         = {2024},
  howpublished = {FedCASIC 2024 Conference Presentation},
  note         = {SINCT system for NAPCS coding resulted in approximately 78\% fewer write-in responses in the 2022 Economic Census compared to prior methods.}
}

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

@techreport{omb_ai_procurement_2025,
  author       = {{Office of Management and Budget}},
  title        = {Responsible Procurement of Artificial Intelligence in Government},
  year         = {2025},
  month        = {4},
  institution  = {Executive Office of the President},
  note         = {Establishes AI acquisition rules for federal contracts. Compliance required for contracts awarded or renewed 180 days after issuance (approximately October 2025). Agencies must update internal acquisition procedures by December 2025.}
}

@article{pdf_parser_benchmark_2026,
  author    = {{TBD — verify authors from arxiv}},
  title     = {{TBD — PDF} Parser Benchmarking with {LLM}-Based Evaluation},
  year      = {2026},
  journal   = {arXiv preprint},
  note      = {1,554 human ratings on 518 table pairs. LLM-based evaluation correlates better with human judgment than rule-based similarity measures (TEDS, GriTS) for semantic quality assessment of table extraction.}
}

@misc{reveal_2025,
  author       = {{Reveal Global Consulting}},
  title        = {{ACS} Autocoder Modernization: {LLM} Embeddings and Fine-Tuning for Occupation and Industry Coding},
  year         = {2025},
  howpublished = {Technical report},
  note         = {Modernization of American Community Survey autocoding using LLM embeddings, semantic search, and fine-tuning. Goal: reduce clerical coding volume and improve performance for occupation and industry classification.}
}

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

**Note:** Two bib entries have TBD fields:
- `pdf_parser_benchmark_2026`: Need to verify full author list and title from arxiv source
- `reveal_2025`: Verify exact publication venue and authorship

---

## Verification

After all edits:

1. `grep -c 'cite:' book/chapter-03.md` — expect at least 8 citation directives (was 1)
2. `grep -n 'Pragmatics system' book/chapter-03.md` — expect 0 results
3. `grep -n 'Chapter 14' book/chapter-03.md` — expect at least 1 result
4. `grep -c '—' book/chapter-03.md` — expect 0 em-dashes (do not introduce any)
5. `grep -n 'genuinely prohibits' book/chapter-03.md` — expect 0 results
6. `grep -c '6 to 18 months' book/chapter-03.md` — expect exactly 1 occurrence
7. Verify `references.bib` remains in alphabetical order by key
8. Run `seldon verify --fix` after edits

---

## What This Task Does NOT Address (Deferred)

- **Thin sections (Schema Inference, Format Extraction):** These remain outline-grade. A design session is needed to decide whether to expand with worked examples or scope explicitly as secondary. This task improves the claims within them but does not add substantive content.
- **Additional reflection prompts:** The chapter has only 1 distributed reflection prompt (the blockquote in Response Code Correction). The pedagogical pattern calls for more. Deferred to a design session.
- **Chapter figure:** Still zero figures. Needs PaperBanana treatment. Deferred.
- **TBD bib entries:** Two entries need field verification from original sources.
- **tian_2025 independent verification:** The F1 and computational cost numbers in the bib note could not be independently verified via search (AAPOR conference paper not publicly available). Author confirmed source. Numbers retained.

---

## Acceptance Criteria

- [ ] All 12 fixes applied
- [ ] 6 new bib entries added in alphabetical order
- [ ] No existing bib entries modified
- [ ] Citation count in chapter increased from 1 to 8+
- [ ] No em-dashes introduced
- [ ] No bare dollar signs introduced
- [ ] "6 to 18 months" appears exactly once
- [ ] No company names in body text
- [ ] `seldon verify` passes
