# Design Note: Chapter 3 Thin Section Expansions

**Date:** 2026-04-01
**Session:** 18
**Scope:** `book/chapter-03.md` — Schema Inference and Format Extraction sections
**Purpose:** Draft expanded prose for the two sections flagged as outline-grade in the content audit

---

## Rationale

Both sections currently read as lightly fleshed outlines: general statements about what LLMs can do, without concrete scenarios, worked examples, or specific failure modes. The rest of Chapter 3 (Response Code Correction, Fine-Tuning Cost Trap, Where Traditional Methods Still Win) is substantive, grounded in real use cases, and makes claims with evidence. These two sections need the same treatment.

The expansion strategy: add a concrete scenario that the reader can visualize, name the specific failure modes, and connect to the chapter's design discipline (verification, provenance, routing to the right tool). No new principles introduced; these sections apply patterns already established in the chapter.

---

## Perplexity Verification Results (2026-04-01)

**Schema matching claim — CONFIRMED.** The 2024 TaDA/VLDB study explicitly supports the framing: LLMs can bootstrap schema matching from names and descriptions, but performance depends on context scope, with N-to-M mappings consistently the weakest setting. The study notes that "matching quality suffers from a lack of context information, but also from providing too much context information." Frames LLMs as assisting data engineers, not replacing them. Safe to cite.

**Fortier 2017 taxonomy — UNVERIFIED.** The "complete / partial / impossible" taxonomy wording could not be confirmed from Perplexity results. The paper is in references.bib but the exact phrasing must be verified against the original paper text before use. **Action:** Either verify the original or use softer language ("categories of harmonizability" rather than the specific three-tier taxonomy names until confirmed).

**Harmonia (Santos et al. 2025) — CONFIRMED RELEVANT.** The paper describes an agentic data harmonization system combining LLM-based reasoning, interactive UI, and harmonization primitives with two-way human-agent interaction and provenance tracking. Directly exemplifies the "LLM proposes, human reviews" pattern. Safe to cite.

---

## Schema Inference and Data Combination — Proposed Replacement

```markdown
## Schema Inference and Data Combination

Data arrives from disparate sources with different structures. CSV files with different headers. Excel workbooks with different column names. Databases with different schemas. The task: combine them into a unified target schema.

Consider a concrete case. Three surveys measure household income. Survey A has a column called `household_income` containing annual pre-tax values in dollars. Survey B has `hh_inc` containing monthly post-tax values in cents. Survey C has `income_band` containing categorical ranges ("$25,000-\$49,999"). A human analyst looking at all three immediately spots three problems: the names differ, the units differ, and one source is categorical while the others are continuous. An LLM looking at the column names and a sample of values can spot the first two problems. It will likely miss the third, or worse, propose a mapping that silently converts categorical ranges to midpoint values without flagging the loss of information.

LLMs can read source schemas and propose mappings: auto-generate a target schema from the union of source fields, propose join keys and crosswalks between fields, identify semantic equivalences. Experimental evaluations of LLM-based schema matching confirm that models can identify semantic correspondences between columns, including cases where names are abbreviated or use domain-specific conventions. But performance depends strongly on the scope and context provided: N-to-M mappings are consistently the weakest case, and too much or too little schema context degrades matching quality. The framing from schema matching research is instructive: LLMs assist data engineers rather than replace them ({cite:p}`tada_vldb_2024`). Recent work on agentic data harmonization takes this further, combining LLM-based reasoning with interactive human review and reusable harmonization primitives, so the human can inspect, correct, and approve each proposed mapping before it propagates downstream ({cite:p}`santos_2025_harmonia`).

The schema proposal is a draft, not a final product. Human review of the proposed schema is essential, and the review must go deeper than checking whether the column names match. Semantic equivalences can be wrong in ways that are invisible at the schema level. "Income" in two different surveys may measure different constructs: gross versus net, individual versus household, annual versus monthly. The LLM is pattern-matching on field names and sample values, not reasoning about the construct definitions behind the data. This is exactly the kind of semantic gap that Chapter 8's evaluation framework addresses, or the kind of structured expert judgment that can be delivered through system-level context ({cite:p}`webb_2026_pragmatics`).

The data harmonization literature provides a useful framework for evaluating LLM-proposed mappings. Not all mappings are equal: some source variables map directly to a target variable, some require transformation that loses information, and some simply cannot support the target construct at all ({cite:p}`fortier_2017`). The LLM will propose a mapping for every field. It will not tell you which mappings lose information and which are impossible. That classification requires domain knowledge that the model does not have.

> *Two datasets both have a column called "employment_status." Survey A codes it as 1=employed, 2=unemployed, 3=not in labor force. Survey B codes it as full-time, part-time, unemployed, retired, student, disabled, other. An LLM proposes mapping both to a unified schema. What information is lost? What crosswalk assumptions are you making? How do you document those assumptions so that downstream analysts know what they are working with?*

Log the schema mapping decisions. When someone asks six months later why Field A was joined to Field B, the evidence chain exists (Chapter 10). This is a high-value, low-risk LLM application: the LLM proposes, the human reviews, the cost of the proposal is trivial, and the cost of getting it wrong is caught at review before it propagates.
```

### Changes from v1 of this design note:
- **TaDA/VLDB citation integrated:** "N-to-M mappings are consistently the weakest case" and "too much or too little schema context degrades matching quality" — both directly from the verified source.
- **Harmonia citation added:** Concrete example of the agentic harmonization pattern with human-in-the-loop review.
- **Fortier 2017 language softened:** No longer uses the specific "complete / partial / impossible" taxonomy names. Instead uses the safer framing: "some source variables map directly... some require transformation that loses information... some simply cannot support the target construct." This is the same idea without committing to unverified exact terminology. If the original paper confirms the three-tier names, they can be restored.
- **Dollar sign in "$25,000-\$49,999" escaped** for MyST rendering.

### New bib entries needed:

```bibtex
@inproceedings{tada_vldb_2024,
  author    = {{TBD — verify full author list}},
  title     = {Schema Matching with Large Language Models: An Experimental Study},
  booktitle = {VLDB 2024 Workshop: Tabular Data Analysis Workshop (TaDA)},
  year      = {2024},
  note      = {Benchmarked LLM schema matching across task scopes. N-to-M mappings consistently weakest. Matching quality degrades with both too little and too much context. Frames LLMs as assisting data engineers, not replacing them.}
}

@article{santos_2025_harmonia,
  author    = {Santos, Aecio and Garcia, Alex and Strubell, Emma and Rekatsinas, Theodoros and Li, Feifei Tu and Altman, Russ B.},
  title     = {Interactive Data Harmonization with {LLM} Agents: Opportunities and Challenges},
  journal   = {arXiv preprint arXiv:2502.07132},
  year      = {2025},
  url       = {https://arxiv.org/abs/2502.07132},
  note      = {Introduces Harmonia, an agentic data harmonization system combining LLM-based reasoning, interactive UI, and reusable harmonization primitives. Demonstrates human-agent interaction for schema matching and value mapping in clinical data harmonization.}
}
```

**TBD:** `tada_vldb_2024` author list needs verification from the original paper. The OpenReview/arxiv URL from the web search results should resolve this.

---

## Format Extraction and Standardization — Proposed Replacement

```markdown
## Format Extraction and Standardization

The "data arrived in five different formats" problem. A quarterly collection of establishment reports arrives as: three Excel workbooks with slightly different column orders, a batch of PDFs generated from a legacy system, and a folder of plain-text exports from a web form. The data content is similar, but the structure, layout, and encoding differ in every case. The task: extract the information and map it into a single target schema.

This is the universal parser use case, but the advantage is conditional. LLMs handle format diversity better than rule-based systems when documents vary widely in structure, because they interpret structure from context rather than requiring explicit parsing rules for each format. Recent benchmarking of document extraction methods confirms that LLM-based evaluation correlates better with human judgment than rule-based similarity metrics for semantically complex tables ({cite:p}`pdf_parser_benchmark_2026`). But rule-based and zonal OCR parsers remain superior for fixed, repetitive layouts where deterministic throughput matters more than semantic flexibility.

The design pattern is hybrid, and the routing decision matters. If you receive 10,000 PDFs that all use the same template (same field positions, same structure, same layout version), a rule-based parser with zonal OCR will be faster, cheaper, and more deterministic than an LLM. If you receive 10,000 PDFs generated by 47 different legacy systems with different layouts, column orders, and header conventions, an LLM-assisted extraction pipeline will handle the variance that a rule-based parser cannot. Most real collections fall somewhere in between: a core of stable templates with a long tail of variants. Design for both.

Define the target schema first. This is the config-driven pattern from Chapter 7: the LLM maps to the schema, it does not invent one. The schema is the contract. It lives in configuration. It is versioned. The LLM is a tool for mapping diverse inputs to that contract, not for deciding what the contract should be.

Extraction errors on structured data are different from extraction errors on unstructured data, and the detection methods differ accordingly. For structured data (tables, forms with labeled fields), automated schema validation catches most errors: did the extracted value land in the right column? Does it pass type and range checks? For unstructured data (narrative text, free-form descriptions), misinterpretation of content is the primary risk, and human review of a stratified sample is usually necessary. The stratification should oversample the long tail: the edge cases where format variance is highest are where extraction errors concentrate.

This is typically a one-time or periodic task (ingesting a new data source), not a continuous production pipeline. The cost and speed tradeoffs are different from the code correction use case: you optimize for correctness and completeness, not for throughput. When extraction is periodic, invest the review time upfront to validate the pipeline against the specific format variants you encounter. The validation pays for itself in every subsequent run.
```

### No changes from v1. Format Extraction section was not affected by the Perplexity verification round. It relies on the `pdf_parser_benchmark_2026` citation (already in remediation CC task, TBD fields need filling) and design guidance that doesn't require additional citation.

---

## Note on Reflection Prompts

The audit flagged that Chapter 3 has only one distributed reflection prompt (the blockquote in Response Code Correction). The Schema Inference expansion adds a second one (the employment_status crosswalk scenario). Combined with the existing thought experiment at chapter end, the chapter now has three reader-engagement points, which is reasonable for a chapter of this length. A third could be added to Format Extraction if desired, but I'd avoid over-prompting.

---

## Open Items Before CC Task

1. **Fortier 2017 exact taxonomy language:** Verify against original paper whether the three categories are literally called "complete / partial / impossible" or something else. Current draft uses softer paraphrase that is safe either way.
2. **TaDA/VLDB 2024 author list:** Need full author list for bib entry.
3. **Santos et al. 2025 author list:** Verify — the list in the bib entry above was extracted from the arxiv HTML page but may be incomplete or misordered.

---

## Next Step

If author approves these expansions, write a CC task that replaces the two sections in `book/chapter-03.md` and adds the two new bib entries. This design note captures the rationale; the CC task captures the exact text to insert.
