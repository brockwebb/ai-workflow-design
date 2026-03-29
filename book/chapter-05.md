# Chapter 5: The Ensemble & Multi-Model Playbook

<!-- STATUS: Placeholder -->
<!-- Cross-cutting "how" chapter referenced by chapters 2-4 -->

## Working Notes

- ABBA designs: run Model A then Model B, then Model B then Model A
- Judge loops: model-as-judge, switching judge identity
- Agreement scoring: when models agree, confidence is high
- Model order effects and position bias detection
- When to use 2 models vs 3 vs N
- Consensus thresholds and escalation rules
- The "never trust a single model call" principle
- Four-layer validation architecture (not just a design pattern):
  - Layer 1: Model Selection — decision matrix: capability (task-specific benchmarks), cost, diversity of failure modes. Document WHY these models, not just WHICH.
  - Layer 2: Parallel Inference with Controls — N models, same input. Define "agreement" quantitatively for your domain (token match? semantic similarity? structured output comparison?)
  - Layer 3: Evidence Accumulation — store everything: model versions, prompt versions, confidence scores, inter-model agreement rates, disagreement cases + adjudication
  - Layer 4: Decision Logic — N outputs → 1 decision. Majority vote? Confidence-weighted? Human-in-the-loop above threshold?
- Model independence debate: models sharing training corpora (Common Crawl, Wikipedia) aren't statistically independent, BUT different architectures, training objectives, RLHF tuning, parameter configs produce meaningfully different bias profiles — correlated but not identical failure modes
- Practical constraint for federal statistics: constrained pool of Western frontier models — optimizing within a bounded set where you have visibility into training methodology and corporate governance
- Two-vs-three models: the number isn't the point. The point is: more than one look, stored comparisons, decision rule for disagreements. Optimal blend shifts as models update — selection logic must be versioned and revisitable
- Reprocessing advantage over manufacturing: unlike physical goods (refurbishing costs), reprocessing data costs electrons — design around variability, run it again
