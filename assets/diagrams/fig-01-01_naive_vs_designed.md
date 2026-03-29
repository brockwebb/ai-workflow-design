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
