# fig-01-01: Naive vs Designed Single Stage (Two-Stage Presentation)

## Concept
Two separate figures presented sequentially with reflection questions between them.
The reader sees the naive workflow first, engages with "what could go wrong," then
sees the designed workflow with each component motivated by the problems they identified.

## fig-01-01a: The Naive Workflow

Simple block diagram: **Input → Model → Output**

- Visually sparse, clean, deceptively simple
- No annotations, no callouts
- The simplicity IS the point: it looks easy, but hides all the problems

Label: "The naive workflow. Input goes in, model processes it, output comes out."

## fig-01-01b: The Designed Workflow

Input → [Model Selection Layer → Parallel Inference (Model A, Model B) → Agreement & Confidence Scoring → Decision Logic → Evidence Accumulation] → Output

Layers:
1. Model Selection: documented rationale (capability, cost, failure mode diversity)
2. Parallel Inference: N models with different architectures/tuning
3. Agreement & Confidence: quantitative comparison with defined thresholds
4. Decision Logic: explicit rule for N outputs → 1 decision
5. Evidence Accumulation: stored scores, versions, disagreements, adjudication

Label: "The designed workflow. Same input, same output, but now you can defend it."

## Design Constraints
- Two separate images, not one two-panel figure
- fig-01-01a: very sparse, muted colors
- fig-01-01b: rich but organized, distinct layers
- Same input/output boxes both sides for visual continuity
- Works in grayscale
- No company/product names

## Placement
- Primary: Chapter 1 (Why Design Matters), presented sequentially with reflection questions between
- Referenced: Ch 5 (Ensemble), Ch 8 (Evaluation), Ch 9 (State/Validity)

## Rendering
TBD — method chosen when build system is decided
