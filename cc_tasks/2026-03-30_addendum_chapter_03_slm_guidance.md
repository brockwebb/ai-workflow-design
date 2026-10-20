# CC Task Addendum: Chapter 3 — SLM Practical Guidance

**Date:** 2026-03-30
**Amends:** `2026-03-30_draft_chapter_03.md`

---

## Addition to "The Fine-Tuning Cost Trap" Section

Add the following guidance after the discussion of when fine-tuning IS the right call and the institutional deployment timeline:

**If you're going down the local deployment path, don't wait for the hardware to start learning.**

Build your pipeline, evaluation harness, and quality benchmarks against public data or synthetic data NOW — before the procurement clears, before the GPU arrives, before the security review finishes. Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt.

This is the design discipline applied to the institutional timeline from Chapter 13. The procurement and security process takes 6–18 months. That is 6–18 months of pipeline development, evaluation design, and benchmark construction you can do in parallel — if you plan for it. The teams that treat infrastructure procurement as a blocking dependency waste a year. The teams that treat it as a parallel track arrive ready.

**On SLMs specifically:** The small language model landscape is evolving fast. Models that are marginal today may be substantially more capable in 12–18 months. The design patterns in this book — dual-model verification, confidence routing, structured arbitration, provenance tracking — apply regardless of whether the model is a frontier API model or a local quantized SLM. If you build the pipeline right, swapping the model underneath is a configuration change (Chapter 7), not a redesign. That is the entire point of model-agnostic architecture.

---

## No other changes to the original CC task.
