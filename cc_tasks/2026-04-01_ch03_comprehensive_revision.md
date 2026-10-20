# CC Task: Chapter 3 Comprehensive Revision — Audit Remediation + Section Expansions

**Date:** 2026-04-01
**Scope:** `book/chapter-03.md`, `book/references.bib`
**Type:** Prose revision + section expansion + citation additions
**Status:** PENDING
**Supersedes:** `2026-04-01_ch03_audit_prose_fixes.md`, `2026-04-01_ch03_perplexity_verification.md`, `2026-04-01_ch03_audit_remediation.md`
**Design notes:** `docs/2026-04-01_ch03_thin_section_design.md`

---

## Context

Full content audit of Chapter 3 (Session 18) produced 24 classified assertions, 7 citation gaps, 3 unsupported claims, and 2 thin sections. Two rounds of Perplexity verification resolved all findings with evidence. This CC task integrates everything into a single execution pass: audit remediation fixes, thin section expansions, and all new bib entries.

**This is the only CC task that should be executed for Chapter 3. All prior Chapter 3 CC tasks from Session 17 are superseded.**

---

## Part A: Audit Remediation Fixes

### Fix A1: Fine-tuning section — add evidence for federal coding use case

**Section:** "The Fine-Tuning Cost Trap", first paragraph

**Find:**
```
Some agencies are fine-tuning small language models for NAICS and NAPCS coding. This is a legitimate approach, and in specific circumstances it is the right one. But most teams that go down this path do not do the cost comparison honestly.
```

**Replace with:**
```
Some agencies are fine-tuning language models for NAICS, NAPCS, and occupation coding. The Census Bureau's SINCT system for NAPCS coding reduced write-in responses by 78% in the 2022 Economic Census ({cite:p}`census_fedcasic_2024`), and a 2025 modernization effort applied LLM embeddings and fine-tuning to improve ACS occupation and industry autocoding ({cite:p}`reveal_2025`). Fine-tuning is a legitimate approach, and in specific circumstances it is the right one. But teams that go down this path frequently underestimate the total cost relative to the API alternative.
```

---

### Fix A2: Fine-tuning cost comparison — rewrite as conditional framework

**Find:**
```
For most use cases, the total cost of ownership for fine-tuning exceeds the API approach, often by a large margin, because people account for the API cost but not for the human engineering cost of the fine-tuning pipeline.
```

**Replace with:**
```
The cost comparison is conditional. At lower or moderate utilization, API access is operationally simpler and usually cheaper. Fine-tuning and self-hosting become cost-effective only when throughput is high, the workload is stable enough to absorb GPU and MLOps overhead, and the use case is mature enough to justify the engineering investment. The mistake most teams make is accounting for the per-call API cost while ignoring the human engineering cost of the fine-tuning pipeline: training data curation, evaluation harness development, retraining when classification systems update, model hosting, and staff expertise to manage the lifecycle. Chapter 14 provides a cost accounting framework that makes this comparison explicit.
```

---

### Fix A3: Title 13 / CIPSEA — soften legal characterization

**Find:**
```
Data sensitivity that genuinely prohibits cloud API access: Title 13 data, CIPSEA-protected microdata, data with legal restrictions on transmission to external services.
```

**Replace with:**
```
Data sensitivity that creates significant legal barriers to cloud API access: Title 13 data, CIPSEA-protected microdata, and other data with legal restrictions on transmission to parties outside the agency's authorized workforce.
```

---

### Fix A4: Deployment timeline — frame as judgment, cite OMB memo

**Find:**
```
But even in these cases, the institutional deployment tax from Chapter 13 applies: finding the budget, navigating security review, procuring and installing hardware, getting priority in the infrastructure queue, setup and staff learning, quality benchmarking against the existing process. This can take 6 to 18 months before you process a single production record.
```

**Replace with:**
```
But even in these cases, the institutional deployment tax from Chapter 13 applies: finding the budget, navigating security review, procuring and installing hardware, getting priority in the infrastructure queue, setup and staff learning, quality benchmarking against the existing process. In practice, this takes 6 to 18 months before you process a single production record. Even the policy compliance path alone has multi-month lead times: OMB's 2025 AI acquisition memo ({cite:p}`omb_ai_procurement_2025`) establishes a 180-day compliance window for new contracts, with agencies required to update internal acquisition procedures within approximately eight months of issuance.
```

---

### Fix A5: Remove "6 to 18 months" repetition

**Find:**
```
Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt. The procurement and security process takes 6 to 18 months. That is 6 to 18 months of pipeline development, evaluation design, and benchmark construction you can do in parallel, if you plan for it.
```

**Replace with:**
```
Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt. That procurement and security timeline is pipeline development time you can use in parallel, if you plan for it.
```

---

### Fix A6: Semantic Analysis — rewrite "no traditional NLP" claim

**Find:**
```
This is where LLMs have the clearest advantage over any prior method. No traditional NLP approach handles open-ended semantic analysis at this quality level. Topic models, keyword extraction, and sentiment analysis are crude approximations compared to what a language model can produce from the same input.
```

**Replace with:**
```
This is where LLMs have a genuine advantage, but the boundary is more nuanced than it first appears. LLMs are stronger for keyword extraction and topic naming when you want semantic grouping from short, messy, or highly varied responses, because the model can infer latent meaning rather than just count repeated terms. Traditional topic models remain better when you need reproducible, corpus-level structure and simpler interpretability, or when you need a fixed coding scheme tracked consistently over time. Comparative studies show that different LLMs vary substantially in diversity versus relevance of extracted topics, which matters when your survey analysis needs stable categories rather than creative labels. In practice, the most effective pattern is often hybrid: LLMs generate candidate keywords or topic labels, then a human or rule layer consolidates them for downstream analysis.
```

---

### Fix A7: Strengthen LLM imputation limitations with evidence

**Find:**
```
LLMs do not maintain distributional properties and have no concept of survey design. They will impute a plausible-looking value that has no relationship to the distribution of the variable in the population.
```

**Replace with:**
```
LLMs do not maintain distributional properties and have no concept of survey design. They will impute a plausible-looking value that has no relationship to the distribution of the variable in the population. Empirical evidence confirms this: LLM-based imputation can approximate highly polarized toplines but struggles with less polarized questions and subgroup estimates, with mean absolute subgroup errors exceeding 10 percentage points in one study. Adding extra anchors or chain-of-thought prompting did not reliably improve population totals. Survey weights do not solve the core problem, because weighted estimates still depend on the model's ability to represent the missing-data mechanism and the joint distribution of responses.
```

---

### Fix A8: Pragmatics orphan reference — replace with citation

**Find:**
```
the metadata that Chapter 8's evaluation framework and the Pragmatics system's expert judgment layer are designed to provide
```

**Replace with:**
```
the metadata that Chapter 8's evaluation framework addresses, or the kind of structured expert judgment that can be delivered through system-level context ({cite:p}`webb_2026_pragmatics`)
```

**NOTE:** This find string appears in the CURRENT file. If the section has already been replaced by Part B (Fix B1), this fix is already incorporated there. Skip if the old text is not found.

---

### Fix A9: Add MICE and Fellegi-Holt inline citations

**Find:**
```
MICE, hot-deck, Fellegi-Holt, and other established imputation methods
```

**Replace with:**
```
MICE ({cite:p}`van_buuren_2011`), hot-deck, Fellegi-Holt ({cite:p}`fellegi_1976`), and other established imputation methods
```

---

## Part B: Thin Section Expansions

### Fix B1: Replace Schema Inference and Data Combination section

**Find the entire section** from `## Schema Inference and Data Combination` up to (but not including) `## Format Extraction and Standardization`.

**Replace with:**

```markdown
## Schema Inference and Data Combination

Data arrives from disparate sources with different structures. CSV files with different headers. Excel workbooks with different column names. Databases with different schemas. The task: combine them into a unified target schema.

Consider a concrete case. Three surveys measure household income. Survey A has a column called `household_income` containing annual pre-tax values in dollars. Survey B has `hh_inc` containing monthly post-tax values in cents. Survey C has `income_band` containing categorical ranges ("\$25,000-\$49,999"). A human analyst looking at all three immediately spots three problems: the names differ, the units differ, and one source is categorical while the others are continuous. An LLM looking at the column names and a sample of values can spot the first two problems. It will likely miss the third, or worse, propose a mapping that silently converts categorical ranges to midpoint values without flagging the loss of information.

LLMs can read source schemas and propose mappings: auto-generate a target schema from the union of source fields, propose join keys and crosswalks between fields, identify semantic equivalences. Experimental evaluations of LLM-based schema matching confirm that models can identify semantic correspondences between columns, including cases where names are abbreviated or use domain-specific conventions. But performance depends strongly on the scope and context provided: N-to-M mappings are consistently the weakest case, and too much or too little schema context degrades matching quality. The framing from schema matching research is instructive: LLMs assist data engineers rather than replace them ({cite:p}`tada_vldb_2024`). Recent work on agentic data harmonization takes this further, combining LLM-based reasoning with interactive human review and reusable harmonization primitives, so the human can inspect, correct, and approve each proposed mapping before it propagates downstream ({cite:p}`santos_2025_harmonia`).

The schema proposal is a draft, not a final product. Human review of the proposed schema is essential, and the review must go deeper than checking whether the column names match. Semantic equivalences can be wrong in ways that are invisible at the schema level. "Income" in two different surveys may measure different constructs: gross versus net, individual versus household, annual versus monthly. The LLM is pattern-matching on field names and sample values, not reasoning about the construct definitions behind the data. This is exactly the kind of semantic gap that Chapter 8's evaluation framework addresses, or the kind of structured expert judgment that can be delivered through system-level context ({cite:p}`webb_2026_pragmatics`).

The data harmonization literature provides a useful framework for evaluating LLM-proposed mappings. Not all mappings are equal: some source variables map directly to a target variable, some require transformation that loses information, and some simply cannot support the target construct at all ({cite:p}`fortier_2017`). The LLM will propose a mapping for every field. It will not tell you which mappings lose information and which are impossible. That classification requires domain knowledge that the model does not have.

> *Two datasets both have a column called "employment_status." Survey A codes it as 1=employed, 2=unemployed, 3=not in labor force. Survey B codes it as full-time, part-time, unemployed, retired, student, disabled, other. An LLM proposes mapping both to a unified schema. What information is lost? What crosswalk assumptions are you making? How do you document those assumptions so that downstream analysts know what they are working with?*

Log the schema mapping decisions. When someone asks six months later why Field A was joined to Field B, the evidence chain exists (Chapter 10). This is a high-value, low-risk LLM application: the LLM proposes, the human reviews, the cost of the proposal is trivial, and the cost of getting it wrong is caught at review before it propagates.
```

---

### Fix B2: Replace Format Extraction and Standardization section

**Find the entire section** from `## Format Extraction and Standardization` up to (but not including) `## Semantic Analysis of Open-Ended Responses`.

**Replace with:**

```markdown
## Format Extraction and Standardization

The "data arrived in five different formats" problem. A quarterly collection of establishment reports arrives as: three Excel workbooks with slightly different column orders, a batch of PDFs generated from a legacy system, and a folder of plain-text exports from a web form. The data content is similar, but the structure, layout, and encoding differ in every case. The task: extract the information and map it into a single target schema.

This is the universal parser use case, but the advantage is conditional. LLMs handle format diversity better than rule-based systems when documents vary widely in structure, because they interpret structure from context rather than requiring explicit parsing rules for each format. Recent benchmarking of document extraction methods confirms that LLM-based evaluation correlates better with human judgment than rule-based similarity metrics for semantically complex tables ({cite:p}`pdf_parser_benchmark_2026`). But rule-based and zonal OCR parsers remain superior for fixed, repetitive layouts where deterministic throughput matters more than semantic flexibility.

The design pattern is hybrid, and the routing decision matters. If you receive 10,000 PDFs that all use the same template (same field positions, same structure, same layout version), a rule-based parser with zonal OCR will be faster, cheaper, and more deterministic than an LLM. If you receive 10,000 PDFs generated by 47 different legacy systems with different layouts, column orders, and header conventions, an LLM-assisted extraction pipeline will handle the variance that a rule-based parser cannot. Most real collections fall somewhere in between: a core of stable templates with a long tail of variants. Design for both.

Define the target schema first. This is the config-driven pattern from Chapter 7: the LLM maps to the schema, it does not invent one. The schema is the contract. It lives in configuration. It is versioned. The LLM is a tool for mapping diverse inputs to that contract, not for deciding what the contract should be.

Extraction errors on structured data are different from extraction errors on unstructured data, and the detection methods differ accordingly. For structured data (tables, forms with labeled fields), automated schema validation catches most errors: did the extracted value land in the right column? Does it pass type and range checks? For unstructured data (narrative text, free-form descriptions), misinterpretation of content is the primary risk, and human review of a stratified sample is usually necessary. The stratification should oversample the long tail: the edge cases where format variance is highest are where extraction errors concentrate.

This is typically a one-time or periodic task (ingesting a new data source), not a continuous production pipeline. The cost and speed tradeoffs are different from the code correction use case: you optimize for correctness and completeness, not for throughput. When extraction is periodic, invest the review time upfront to validate the pipeline against the specific format variants you encounter. The validation pays for itself in every subsequent run.
```

---

## Part C: All New Bib Entries

**File:** `book/references.bib`

Add all entries below, maintaining alphabetical order by key. Do NOT modify any existing entries.

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
  author    = {{TBD -- verify from arXiv page}},
  title     = {Benchmarking {PDF} Parsers on Table Extraction with {LLM}-based Semantic Evaluation},
  year      = {2026},
  journal   = {arXiv preprint},
  note      = {Benchmark using synthetic PDFs with exact LaTeX ground truth. LLM-based semantic evaluation achieved human correlation r=0.93 versus r=0.68 for TEDS and r=0.70 for GriTS. 1,554 human ratings on 518 table pairs.}
}

@misc{reveal_2025,
  author       = {{Reveal Global Consulting}},
  title        = {{ACS} Autocoder Modernization: {LLM} Embeddings and Fine-Tuning for Occupation and Industry Coding},
  year         = {2025},
  howpublished = {Technical report},
  note         = {Modernization of American Community Survey autocoding using LLM embeddings, semantic search, and fine-tuning. Goal: reduce clerical coding volume and improve performance for occupation and industry classification.}
}

@article{santos_2025_harmonia,
  author    = {Santos, Aecio and Garcia, Alex and Strubell, Emma and Rekatsinas, Theodoros and Li, Feifei Tu and Altman, Russ B.},
  title     = {Interactive Data Harmonization with {LLM} Agents: Opportunities and Challenges},
  journal   = {arXiv preprint arXiv:2502.07132},
  year      = {2025},
  url       = {https://arxiv.org/abs/2502.07132},
  note      = {Introduces Harmonia, an agentic data harmonization system combining LLM-based reasoning, interactive UI, and reusable harmonization primitives. Demonstrates human-agent interaction for schema matching and value mapping in clinical data harmonization.}
}

@inproceedings{tada_vldb_2024,
  author    = {{TBD -- verify full author list from paper}},
  title     = {Schema Matching with Large Language Models: An Experimental Study},
  booktitle = {VLDB 2024 Workshop: Tabular Data Analysis Workshop (TaDA)},
  year      = {2024},
  note      = {Benchmarked LLM schema matching across task scopes. N-to-M mappings consistently weakest. Matching quality degrades with both too little and too much context. Frames LLMs as assisting data engineers, not replacing them.}
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

**TBD entries requiring author verification before build:**
- `pdf_parser_benchmark_2026`: Author list. Title verified as "Benchmarking PDF Parsers on Table Extraction with LLM-based Semantic Evaluation."
- `tada_vldb_2024`: Author list. Title and venue verified.

---

## Execution Order

1. Apply Part C (bib entries) first — all citations must resolve before chapter edits
2. Apply Part A fixes (A1 through A9) in order
3. Apply Part B section replacements (B1, B2)
4. If Fix A8 find string is not present (already replaced by B1), skip A8

---

## Verification

After all edits:

1. `grep -c 'cite:' book/chapter-03.md` — expect 10+ citation directives (was 1)
2. `grep -n 'Pragmatics system' book/chapter-03.md` — expect 0 results
3. `grep -n 'Chapter 14' book/chapter-03.md` — expect at least 1 result
4. `grep -c '—' book/chapter-03.md` — expect 0 em-dashes (do not introduce any)
5. `grep -n 'genuinely prohibits' book/chapter-03.md` — expect 0 results
6. `grep -c '6 to 18 months' book/chapter-03.md` — expect exactly 1 occurrence
7. `grep -n 'No traditional NLP' book/chapter-03.md` — expect 0 results
8. `grep -n 'crude approximations' book/chapter-03.md` — expect 0 results
9. Verify `references.bib` remains in alphabetical order by key
10. Verify no bare `$` signs (all dollar amounts escaped as `\$`)
11. Run `seldon verify --fix` after edits

---

## What This Task Does NOT Address (Deferred)

- **Chapter 3 figure:** Still zero figures. Needs PaperBanana treatment.
- **TBD bib entries:** Two entries need author list verification from original papers.
- **Fortier 2017 exact taxonomy terms:** Current prose uses safe paraphrase. If exact terminology is confirmed, a follow-up task can restore the specific category names.
- **tian_2025 independent verification:** Numbers retained on author confirmation. AAPOR paper not publicly available.
- **Additional reflection prompts beyond the two now present:** The chapter will have the Response Code Correction blockquote + the Schema Inference employment_status prompt + the Thought Experiment. Three engagement points is sufficient.

---

## Acceptance Criteria

- [ ] All Part A fixes (A1-A9) applied
- [ ] Both Part B section replacements applied
- [ ] 8 new bib entries added in alphabetical order
- [ ] No existing bib entries modified
- [ ] Citation count in chapter increased from 1 to 10+
- [ ] No em-dashes introduced
- [ ] No bare dollar signs introduced
- [ ] "6 to 18 months" appears exactly once
- [ ] No company names in body text
- [ ] "No traditional NLP" and "crude approximations" removed
- [ ] "genuinely prohibits" removed
- [ ] "Pragmatics system" orphan removed
- [ ] Schema Inference section has concrete income example + reflection prompt
- [ ] Format Extraction section has concrete five-format scenario + hybrid routing framework
- [ ] `seldon verify` passes
