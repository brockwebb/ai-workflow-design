# CC Task: Draft Chapter 3 — Data Wrangling & Standardization Workflows

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## Context

Chapter 3 was previously titled "Data Cleaning & Imputation Workflows" and contained only placeholder working notes. The chapter has been redesigned. The old title was misleading — LLMs are not the right tool for statistical imputation (distributional preservation, survey design effects, etc.). Traditional methods (MICE, hot-deck, Fellegi-Holt) own that space.

What LLMs ARE good at in the data quality pipeline is **semantic reasoning over messy human input**: correcting bad codes, standardizing formats, combining disparate sources, extracting structured data from unstructured input, and analyzing open-ended responses. That's what this chapter covers.

**New title:** "Data Wrangling & Standardization Workflows"

**Relationship to other chapters:**
- Ch 2 (Classification & Coding) covers clean-input classification against fixed taxonomies. Ch 3 covers dirty-input wrangling where the data itself is the problem.
- Ch 5 (Multi-Model) patterns apply here — dual-model verification for code corrections.
- Ch 7 (Checkpoints) config-driven architecture applies to schema inference pipelines.
- Ch 8 (Evaluation) — how do you evaluate code corrections when ground truth is partial?
- Ch 12 (Security) and Ch 13 (Institutional Deployment) — the fine-tuning vs. API cost tradeoff connects directly to access constraints and institutional friction.
- Ch 14 (Cost) — the total cost of ownership argument for fine-tuning vs. API access.

**Key citation already in `references.bib`:**
- `tian_2025` — LLM imputation for survey data (Tian et al., AAPOR 2025). Use as evidence for where LLMs CAN help with categorical data but are 40x slower. This is supporting evidence, not the chapter's centerpiece.

---

## Chapter Structure

### Title and Header

```markdown
# Chapter 3: Data Wrangling & Standardization Workflows

<!-- STATUS: Draft -->
<!-- Primary Working Principle: Outputs require full provenance -->
<!-- Primary Tenet: Data precedes models -->
```

### Opening Hook

**"The Code Says 999999"**

A respondent self-reported their NAICS code as 999999. Their free-text business description says "I fix toilets and sinks in people's houses." A human coder would read the description, look up the plumbing contractor code (238220), and fix it. An LLM can do the same thing. But you have 200,000 records with bad codes, and you need to verify 200,000 corrections.

This is not classification in the Chapter 2 sense. In Chapter 2, the input was well-formed (clear survey questions) and the task was mapping to a taxonomy. Here, the input itself is the problem: wrong codes, ambiguous descriptions, inconsistent formats, data arriving in five different file formats. The LLM's job is not to classify clean input — it's to interpret messy human input and map it to structured output.

The design challenge is verification at scale. An LLM that proposes a "corrected" NAICS code with high confidence is performing what Chapter 4 will call confidence laundering if there's no evidence chain for why that correction is right. The dual-model patterns from Chapter 2 apply, but the error modes are different because the input quality is worse.

### Section: Response Code Correction

The core use case. Respondents self-report codes (NAICS, SOC, NAPCS, etc.) and get them wrong — sometimes wildly wrong, sometimes plausibly wrong. LLMs can read the free-text description alongside the reported code and propose corrections.

Key design points:
- This IS classification (Ch 2 patterns apply) but with dirty input. The error modes are different: the respondent's description might itself be ambiguous, incomplete, or wrong.
- Dual-model cross-validation matters even more here because the input noise makes single-model confidence less reliable.
- Confidence routing: high-confidence corrections auto-accept, low-confidence corrections go to human review queue. Same pattern as Ch 2 but the thresholds may need to be different because input quality is worse.
- Position in the pipeline: code correction happens AFTER initial data receipt and BEFORE downstream analysis. Getting this wrong propagates silently.

### Section: The Fine-Tuning Cost Trap

Some agencies are fine-tuning HuggingFace models (small language models) for NAICS/NAPCS coding. Address this directly and honestly.

**The cost comparison most teams don't do:**
- Fine-tuning requires: training data curation, compute for training, evaluation harness, retraining when the classification system updates (NAICS revisions), model hosting, MLOps overhead, staff expertise for all of the above.
- API approach requires: prompt engineering, dual-model verification pipeline (Ch 2 patterns), API costs per call.
- For most use cases, the total cost of ownership for fine-tuning exceeds the API approach — often by a large margin — because people account for the API cost but not the human engineering cost of the fine-tuning pipeline.

**When fine-tuning IS the right call (be honest about this):**
- Data sensitivity that genuinely prohibits cloud API access (Title 13, CIPSEA-protected data)
- Latency requirements for real-time coding at production scale
- Offline deployment requirements
- BUT: even in these cases, the institutional deployment tax from Ch 13 applies — finding money, security hoops, installation, priority queue for infrastructure, setup and learning, quality benchmarking. This can take 6–18 months before you process a single production record.

**The uncomfortable truth:** If institutional constraints block API access AND the fine-tuning/local deployment path takes 18 months, practitioners are stuck with traditional NLP (bag of words, regex, rule-based systems) that everyone knows is inferior. The design discipline here is making the cost and timeline comparison explicit so leadership can make an informed access decision. Connect to Ch 12 (security controls as enabling) and Ch 13 (institutional deployment).

**Note on SLMs:** Small language models are improving rapidly. The cost-performance tradeoff for local deployment may shift substantially in the next 1-2 years. But right now, for most use cases, the maintenance overhead of a fine-tuned SLM exceeds the API cost of a frontier model with good prompts. State this as a current assessment, not a permanent judgment. This is one of the fastest-changing areas in the book.

### Section: Schema Inference and Data Combination

LLM reads disparate data files (CSV with different headers, Excel with different column names, databases with different schemas) and:
- Auto-generates a target schema
- Proposes join keys / crosswalks between fields
- Identifies semantic equivalences ("household_income" in one file = "hh_inc" in another)

Design considerations:
- The schema proposal is a DRAFT, not a final product. Human review of the proposed schema is essential — semantic equivalences can be wrong (e.g., "income" could mean gross or net, pre-tax or post-tax, individual or household).
- Provenance: log the schema mapping decisions. When someone asks six months later why Field A was joined to Field B, the evidence chain exists.
- This is a high-value, low-risk LLM application: the LLM proposes, the human reviews, the cost of the proposal is trivial, the cost of getting it wrong is caught at review.

### Section: Format Extraction and Standardization

The "data arrived in five different formats" problem:
- Responses in Excel, Notepad, Word documents
- Different layouts, conventions, structures
- LLM extracts information and maps into a target schema

This is the universal parser use case. LLMs handle format diversity better than any rule-based system because they can interpret structure from context rather than requiring explicit parsing rules for each format.

Design considerations:
- Define the target schema FIRST (config-driven, Ch 7 pattern). The LLM maps TO the schema, it doesn't invent one.
- Verification: spot-check extraction against source documents. Extraction errors on structured data (wrong field mapping) are different from extraction errors on unstructured data (misinterpretation).
- Scale: this is typically a one-time or periodic task (ingesting a new data source), not a continuous production pipeline. Different cost/speed tradeoffs than the code correction use case.

### Section: Semantic Analysis of Open-Ended Responses

Public comments, free-text survey fields, open-ended response data. Not classification into a fixed taxonomy (Ch 2) but interpretation, summarization, theme extraction.

Design considerations:
- This is where LLMs have the clearest advantage over any prior method. No traditional NLP approach handles open-ended semantic analysis at this quality level.
- But: theme extraction is inherently subjective. Two models may extract different themes from the same corpus. This is the dual-model disagreement signal from Ch 2 — disagreement on themes is information about the ambiguity of the input, not error.
- Provenance matters: which responses contributed to which themes? Can you trace a summary back to the source responses that generated it?
- The evaluation trap from Ch 8 applies: how do you evaluate whether theme extraction is "correct" when there's no ground truth?

### Section: Where Traditional Methods Still Win

Be explicit about the boundary. This is design discipline — knowing where NOT to use LLMs:

- **Imputation of missing values:** MICE, hot-deck, Fellegi-Holt preserve distributional properties, respect survey design effects (weights, clustering, stratification), and are theoretically well-understood. LLMs don't maintain distributional properties and have no concept of survey design.
- **Continuous variable correction:** When the value is numeric and the correction needs to preserve distributional properties, traditional methods are superior.
- **Reference:** Tian et al. (2025) {cite:p}`tian_2025` showed LLM imputation outperforming MICE on categorical variables (F1 0.65 vs 0.50) in a real election survey, but at 40x the computational cost. Even in the best case, the cost-performance tradeoff is narrow. Use as evidence that the boundary is real, not as endorsement of LLM imputation.

The thesis: LLMs handle the *semantic reasoning* parts of the data quality pipeline. Traditional methods handle the *statistical* parts. The design discipline is routing each sub-task to the right tool.

### Thought Experiment

You receive a dataset of 500,000 business registrations with self-reported NAICS codes and free-text business descriptions. Quality audit of a sample suggests ~25% of NAICS codes are wrong. Design the correction pipeline:

- How do you use the free-text descriptions to propose corrections? What about records with no description?
- How do you decide which corrections to auto-accept vs. route to human review?
- How do you evaluate whether your correction pipeline is actually improving data quality, given that you don't have ground truth for most records?
- At what scale does the API cost argument change? Is there a volume threshold where fine-tuning becomes cost-effective?
- How would your design change if the data is Title 13 protected and cannot leave the agency network?

### Bridge to Chapter 4

Chapter 3 addressed the problem of fixing and standardizing data you already have. Chapter 4 addresses extracting structured data from unstructured sources — entity extraction, pattern detection, disclosure review — where the design challenge shifts from "correct the record" to "find the signal." The confidence laundering risk previewed in this chapter gets its full treatment there.

---

## Voice and Style

- Same voice as Ch 1 and Ch 2: direct, no hedging, no filler.
- Concrete examples grounded in federal statistical operations (NAICS, SOC, NAPCS codes; Census/BLS/BEA contexts).
- The fine-tuning cost trap section should be direct and opinionated — this is a design argument, not a neutral survey of options. State the conclusion, then support it.
- The "where traditional methods still win" section is equally important to the "where LLMs help" sections. Knowing the boundary IS the design discipline.
- Length: comparable to Ch 2 (~3000-4000 words). Not the longest chapter in the book — the use cases are well-defined and don't need extensive setup.

## Files Modified

| File | Action |
|------|--------|
| `book/chapter-03.md` | **OVERWRITE** — full draft replacing placeholder |

No other files modified. No new citations required — `tian_2025` is already in `references.bib`. If additional citations are needed for NAICS/NAPCS classification systems, add them to `references.bib` with `[NEEDS: verification]` markers.

---

## Verification

After execution:
1. `book/chapter-03.md` should have `<!-- STATUS: Draft -->` header
2. Title should be "Data Wrangling & Standardization Workflows"
3. Should contain all sections listed above
4. Should reference Ch 2 patterns (dual-model, confidence routing) without re-explaining them
5. Should cite `tian_2025` in the traditional methods section
6. Bridge to Ch 4 should be present
7. Thought experiment should be present
8. No content from the old placeholder working notes needs to be preserved — it was bullet points only
