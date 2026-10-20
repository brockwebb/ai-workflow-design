# CC Task: Model Mix Pattern (Ch 14) and Format Sanitization (Ch 6)

**Date:** 2026-04-07
**Scope:** Two bounded insertions from practitioner design patterns

---

## Context

Two patterns that the book discusses around the edges but never states as explicit design principles:

1. **Model mix by pipeline stage** (Ch 14): The book covers evaluation-driven model selection (pick the cheapest tier that passes your quality gate) but treats model selection as a per-pipeline decision. In practice, different pipeline *stages* have different complexity profiles and should use different model tiers. This is the difference between "use a cheap model" and "use cheap models for cheap tasks and expensive models for expensive tasks, within the same pipeline."

2. **Format normalization as infrastructure** (Ch 6): The book covers dirty data (Ch 3) and schema design (Ch 6), but never states the principle that raw document formats (PDF, DOCX, HTML) should be converted to a canonical text format at the pipeline entry point, before any LLM touches the content. Preprocessing is infrastructure, not a prompt concern.

---

## Edit 1: Model Mix Pattern -- Ch 14, "When Cheap Models Win" section

**Insertion point:** After the paragraph ending "This is cost optimization as architecture, not as a one-time decision." (the "Configuration-driven model selection" paragraph, currently line 105) and before "## The Fine-Tuning Crossover" (currently line 107).

**Insert this content:**

```
**Model mix across pipeline stages.** The evaluation-driven selection principle extends further: different stages of the same pipeline can use different model tiers. A multi-stage workflow might use a frontier reasoning model for the hardest step (resolving ambiguous classifications that require genuine inference), a mid-tier model for the bulk processing stage (classification against a well-defined taxonomy where the task is straightforward), and a small model for post-processing (formatting, validation, and cleanup where the task is mechanical). The Concept Mapper's dual-model design used models of comparable capability because the task was uniform classification across all records. But a pipeline with heterogeneous stages, extraction followed by classification followed by quality review, should match model capability to stage complexity. The evaluation harness (Chapter 8) determines the minimum viable tier for each stage independently. The configuration-driven model interface (earlier in this section) makes this practical: each stage specifies its own model in the config, and the abstraction layer routes accordingly. The cost reduction from right-sizing each stage compounds: if three stages each drop one tier, the aggregate savings can be substantial without any capability loss on the tasks that matter.
```

**Rationale:** This fills the gap between "pick the cheapest model" (which the book covers well) and "pick the cheapest model *per stage*" (which the book implies but never states). The insertion connects to the existing config-driven model selection pattern and the evaluation harness, keeping it grounded in book concepts rather than introducing new frameworks.

---

## Edit 2: Format Normalization as Infrastructure -- Ch 6, after "Data dominates"

**Insertion point:** After the "Data dominates" paragraph (currently line 111: "Data dominates. Get your schemas right and the pipeline design follows...") and before the fig-06-03 figure directive (currently line 113).

**Insert this content:**

```
**Normalize formats at the gate.** Raw document formats, PDF, DOCX, HTML, scanned images, are unfit for direct LLM consumption. A pipeline that feeds raw PDF bytes into a prompt is conflating two problems: format interpretation and content analysis. Separate them. The first stage of any pipeline that ingests documents should convert everything to a canonical text format (clean Markdown or plain text with preserved structure) before any LLM processes the content. This is infrastructure, not a prompt concern. The LLM's token budget should be spent on reasoning about content, not on parsing layout artifacts, decoding table structures from positional whitespace, or interpreting OCR noise. Format normalization also makes your pipeline format-agnostic downstream: once everything is canonical text, the classification, extraction, or analysis stages do not need to know whether the source was a PDF, a spreadsheet, or a web page. The conversion step is deterministic (or nearly so), testable independently of the LLM, and cacheable. Build it once, validate it against your specific document types, and every downstream stage benefits.
```

**Rationale:** This makes explicit a principle the book implies but never states. It connects to Pike's "Data dominates" rule (the immediately preceding paragraph) and to the format diversity discussion in Ch 3 (lines 87-97). It is infrastructure guidance, not a prompt engineering tip.

---

## Verification

After execution:
- `grep "Model mix across pipeline stages" book/chapter-14.md` should return one line
- `grep "Normalize formats at the gate" book/chapter-06.md` should return one line
- Both insertions should be single paragraphs with no structural changes to surrounding content
- Build: `cd book && myst build --html` should complete cleanly
