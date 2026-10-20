# CC Task Addendum: Figure Registry and First Figure Concept

**Date:** 2026-03-28
**Amends:** `cc_tasks/2026-03-27_project_initialization.md`
**Reason:** The book needs a figure and table tracking system from the start (lesson learned from ai4stats). Additionally, capturing the first figure concept: a two-panel comparison of naive vs properly designed single-stage workflow.

---

## Part 1: Figure & Table Registry

### Check Seldon Capabilities

Before implementing, check whether Seldon already has artifact types for figures/tables:
1. Run `seldon artifact list` and check for any `type: figure` or `type: table` artifacts
2. Check the Seldon schema/docs for supported artifact types
3. If figure/table types exist natively, use them. If not, use generic artifact type with tags.

### Create Registry File

Create `book/figure-registry.md` — a simple tracking file that maps figure IDs to chapters, descriptions, and file locations. This is the human-readable source of truth; Seldon tracks the artifacts.

```markdown
# Figure & Table Registry

<!-- This file tracks all figures and tables across the book -->
<!-- Each entry maps to a Seldon-tracked artifact -->
<!-- Figure files live in assets/diagrams/ (source) and book/images/ (rendered) -->

## Figures

| Figure ID | Chapter | Title | Source File | Status |
|-----------|---------|-------|-------------|--------|
| fig-01-01 | Ch 1 | Naive vs Designed Single Stage | assets/diagrams/fig-01-01_naive_vs_designed.md | Concept |

## Tables

| Table ID | Chapter | Title | Status |
|----------|---------|-------|--------|
| (none yet) | — | — | — |
```

### Register with Seldon

Register `book/figure-registry.md` as a tracked artifact.

---

## Part 2: Figure Concept — fig-01-01: Naive vs Designed Single Stage

### Description

A two-panel horizontal figure showing the contrast between a naive single-stage LLM workflow and a properly designed one. This is the foundational visual for the entire book — "this is what we mean by design."

**Placement:** Chapter 1 (Why Design Matters). Referenced from Ch 5, Ch 8, Ch 9.

### Left Panel: "The Naive Stage"

A simple block diagram: **Input → Model → Output**

Annotate the hidden problems (callouts or red flags pointing to the arrow/blocks):
- No model selection rationale (why this model?)
- No version tracking (which model version? which prompt?)
- Bias accepted silently (single model, single opinion)
- No confidence score on output
- No comparison or second opinion
- No stored evidence (nothing auditable)
- No provenance chain (can't reproduce this result)
- Looks simple — actually hides complexity in unexamined assumptions

Label: *"Most people build this and call it done."*

### Right Panel: "The Designed Stage"

Same input, same output, but the internals are visible:

1. **Model Selection Layer** — Decision matrix showing why these models were chosen: capability (task-specific benchmarks, not just MMLU), cost, diversity of failure modes. Documented rationale, not vibes.

2. **Parallel Inference** — Input goes to Model A and Model B (minimum). Not just "run it twice" — deliberate selection of models with different architectures/tuning to surface different failure modes.

3. **Agreement & Confidence** — Quantitative comparison: What does "agreement" mean for this task? Token match? Semantic similarity? Structured output comparison? Confidence thresholds defined.

4. **Decision Logic** — How N outputs become one decision. Majority vote? Confidence-weighted? Human-in-the-loop above disagreement threshold? Explicit rule, not "pick one."

5. **Evidence Accumulation** — Everything stored: model versions, prompt versions, confidence scores, inter-model agreement rates, disagreement cases and adjudication. The audit trail. The provenance layer.

Label: *"Same input, same output — now you can defend it."*

### Design Notes

- Horizontal layout, left-right comparison
- Left panel should be visually sparse/simple (that's the point — it looks easy)
- Right panel should be visually rich but organized (complex but legible)
- Use the same input/output boxes on both sides to emphasize: same task, different design discipline
- Color coding: left panel in flat gray/muted, right panel with distinct layers
- No specific model names, company names, or product references
- This figure should work in grayscale (for print/PDF)

### Source File

Create `assets/diagrams/fig-01-01_naive_vs_designed.md` with this concept description. Actual rendering method TBD (PaperBanana, Mermaid, manual SVG, or design tool — decide when build system is chosen).

```markdown
# fig-01-01: Naive vs Designed Single Stage

## Concept
Two-panel horizontal comparison: naive single-stage LLM workflow (left) vs properly designed single-stage workflow (right). The foundational visual for the book's thesis.

## Left Panel: "The Naive Stage"
Input → Model → Output
- No model selection rationale
- No version tracking
- Bias accepted silently
- No confidence score
- No comparison
- No stored evidence
- No provenance chain
Label: "Most people build this and call it done."

## Right Panel: "The Designed Stage"  
Input → [Model Selection Layer → Parallel Inference (Model A, Model B) → Agreement & Confidence Scoring → Decision Logic → Evidence Accumulation] → Output

Layers:
1. Model Selection: documented rationale (capability, cost, failure mode diversity)
2. Parallel Inference: N models with different architectures/tuning
3. Agreement & Confidence: quantitative comparison with defined thresholds
4. Decision Logic: explicit rule for N outputs → 1 decision
5. Evidence Accumulation: stored scores, versions, disagreements, adjudication

Label: "Same input, same output — now you can defend it."

## Design Constraints
- Horizontal layout
- Left sparse, right rich-but-organized
- Same input/output boxes both sides
- Works in grayscale
- No company/product names

## Placement
- Primary: Chapter 1 (Why Design Matters)
- Referenced: Ch 5 (Ensemble), Ch 8 (Evaluation), Ch 9 (State/Validity)

## Rendering
TBD — method chosen when build system is decided
```

---

## Part 3: Slot Brainstorm Material from Voice Transcript

The following material from a brainstorming voice transcript (2026-03-28) should be appended to chapter working notes:

### Chapter 4: Detection & Extraction Workflows

Append to working notes:
```
- Knowledge graph extraction as fidelity case study: the KG hype crowd treats extraction as solved, but the extraction pipeline IS the fidelity bottleneck
- Garbage chunking, lazy entity resolution, no coreference handling, no validation against source → graph that looks authoritative and is structurally wrong
- KG as "confidence laundering machine" — worse than no graph because it creates false confidence
- SFV sub-dimensions applied to KG: compression fidelity (chunk boundary meaning loss), terminological stability ("household income" as 5 different nodes), state provenance (trace every edge/node to source passage, model version, prompt)
```

### Chapter 5: The Ensemble & Multi-Model Playbook

Append to working notes:
```
- Four-layer validation architecture (not just a design pattern):
  - Layer 1: Model Selection — decision matrix: capability (task-specific benchmarks), cost, diversity of failure modes. Document WHY these models, not just WHICH.
  - Layer 2: Parallel Inference with Controls — N models, same input. Define "agreement" quantitatively for your domain (token match? semantic similarity? structured output comparison?)
  - Layer 3: Evidence Accumulation — store everything: model versions, prompt versions, confidence scores, inter-model agreement rates, disagreement cases + adjudication
  - Layer 4: Decision Logic — N outputs → 1 decision. Majority vote? Confidence-weighted? Human-in-the-loop above threshold?
- Model independence debate: models sharing training corpora (Common Crawl, Wikipedia) aren't statistically independent, BUT different architectures, training objectives, RLHF tuning, parameter configs produce meaningfully different bias profiles — correlated but not identical failure modes
- Practical constraint for federal statistics: constrained pool of Western frontier models — optimizing within a bounded set where you have visibility into training methodology and corporate governance
- Two-vs-three models: the number isn't the point. The point is: more than one look, stored comparisons, decision rule for disagreements. Optimal blend shifts as models update — selection logic must be versioned and revisitable
- Reprocessing advantage over manufacturing: unlike physical goods (refurbishing costs), reprocessing data costs electrons — design around variability, run it again
```

### Chapter 8: Evaluation by Design

Append to working notes:
```
- Benchmark selection critique: "standard benchmarks appropriate for your use case" is where most people hand-wave. For Census-type work, what's the benchmark? There isn't one for "correctly interprets ACS variable B19013_001E in context." Task-specific evaluation sets are PART of the evidence chain, not upstream of it.
- The benchmark is part of the instrument, not a pre-existing given
```

### Chapter 9: State, Drift, and Validity

Append to working notes:
```
- SFV sub-dimensions applied to knowledge graphs as concrete example:
  - Compression fidelity: did chunking/extraction preserve meaning, or lose context at chunk boundaries?
  - Terminological stability: is "household income" the same node every time, or did extraction create 5 variants?
  - State provenance: can you trace every edge and node to source passage, model version, prompt?
- Model selection logic as a drift surface: optimal model blend shifts as models update — selection criteria need versioning
```

### Chapter 12: Security, Supply Chain, and Model Provenance

Append to working notes:
```
- Constrained model pool for federal use: Western frontier models only — need visibility into training methodology and corporate governance as a model selection criterion
- Model provenance as a trust/security decision, not just a performance decision
```

---

## Execution Order

1. Create `assets/diagrams/` directory if not exists
2. Create `book/figure-registry.md`
3. Create `assets/diagrams/fig-01-01_naive_vs_designed.md`
4. Append brainstorm material to chapter working notes (Ch 4, 5, 8, 9, 12)
5. Register new artifacts with Seldon (figure-registry, fig-01-01 concept)
6. Check Seldon for native figure/table artifact type support — document findings in a note appended to this CC task after execution

---

## Verification Checklist

- [ ] `book/figure-registry.md` exists with fig-01-01 entry
- [ ] `assets/diagrams/fig-01-01_naive_vs_designed.md` exists with full concept spec
- [ ] Ch 4 working notes include KG fidelity material
- [ ] Ch 5 working notes include four-layer architecture and model independence material
- [ ] Ch 8 working notes include benchmark critique material
- [ ] Ch 9 working notes include SFV-to-KG mapping and model drift material
- [ ] Ch 12 working notes include constrained model pool material
- [ ] All new artifacts registered in Seldon

---

## Execution Note (2026-03-28)

**Seldon native Figure type:** `seldon artifact create Figure` succeeds — Seldon has a native `Figure` artifact type. Used it for fig-01-01 (ID: `d19f1cf8`). Future figures should use `Figure` type, not `DataFile`. The `figure-registry.md` file was registered as `DataFile` (ID: `2e8ef2b5`) since it is a registry/tracking file, not a figure itself.
