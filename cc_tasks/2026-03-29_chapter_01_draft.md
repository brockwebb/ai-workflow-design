# CC Task: Chapter 1 Draft — Why Design Matters

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Type:** Content — Chapter Draft

---

## Objective

Replace the placeholder content in `book/chapter-01.md` with a full working draft of Chapter 1. This is a "go deep where we can, go light where we can't" draft — substantial prose where the argument is clear, explicit `[NEEDS: ...]` markers where more material, citations, or examples are needed.

## Context

This chapter is the bridge from *AI for Official Statistics* (ai4stats) Chapter 15, which introduced SFV and the reproducibility problem. That chapter ended with the reader understanding that AI-assisted research pipelines have validity threats that classical frameworks don't address. This chapter picks up with: now you want to *build* these systems — here's the design discipline required.

## Argument Flow

The chapter makes one sustained argument across these sections:

### 1. Opening: The Nature of the Beast

**Thesis statement (first paragraph, no throat-clearing):** LLM-powered research workflows are stochastic systems operating over language, not numbers. This isn't a bug — it's a fundamental property that requires a different design discipline than anything most researchers or data scientists have been trained in.

**Key points to develop:**

- These systems are *pattern machines*. They select the best-matching pattern from training data. There is always a probability that the pattern doesn't fit. This is not an error in the traditional sense — it's the nature of the instrument.
- The stochastic nature of LLMs is qualitatively different from the stochastic processes statisticians already use:
  - **Seeded stochastic** (Monte Carlo, bootstrap, MCMC): reproducible via seed, numerical, characterizable distributions, bounded uncertainty. Statisticians know how to design around these.
  - **LLM stochastic**: irreproducible across runs (even at temperature=0 on many APIs), output space is *language* not numbers, error distributions are not characterizable in classical terms, and failure modes are *coherent-sounding wrong answers* — not noise around a signal.
- "Stochastic liabilities, not bugs." A bug is a defect you fix. A stochastic liability is a property of the system you design around. You don't fix the weather; you build a roof.
- **The stochastic tax:** Every LLM invocation where a deterministic or seed-reproducible method would suffice is unnecessary variance, cost, and audit burden. The design discipline is minimizing this tax — not eliminating LLMs, but constraining their use to where they're genuinely needed.

### 2. What Breaks: Reproducibility, Evidence, and State

**Bridge from ai4stats Chapter 15.** That chapter introduced SFV and the three layers of the reproducibility problem (stochastic outputs, prompt sensitivity, state accumulation failures). Here we restate concisely and pivot to the design implications.

**Key points:**

- Traditional reproducible research: same data + same code = same results. With LLMs, same prompt + same model ≠ same output. The classical evidence chain is broken.
- This means you need a *different kind of evidence chain*. Not "reproduce the exact output" but "demonstrate the process was sound and the result is defensible." This is what SFV operationalizes (Chapters 9-10 go deep).
- State must be actively managed. Context windows are mutable, lossy, and subject to drift. The instrument changes under you (the terminology drift example from ai4stats Ch 15 — reference, don't repeat).
- Variance compounds through pipelines. A single stochastic node introduces manageable variance. Chain five of them and you have a variance amplification problem. This is the multi-stage design challenge (Chapters 5-8 address this).

### 3. The Iterative Refinement Trap

**Key insight:** Agentic loops that iterate on quality can make things *worse* after N rounds.

**Material to draw on:**

- Huang et al. (2024), "Large Language Models Cannot Self-Correct Reasoning Yet" (ICLR 2024) — when the evaluator has the same blind spots as the generator, iteration rearranges errors without removing them.
- Madaan et al. (2023), "Self-Refine: Iterative Refinement with Self-Feedback" (NeurIPS 2023) — showed diminishing returns, largest improvements in first 1-2 rounds.
- Yang et al. (2025), "A Probabilistic Inference Scaling Theory for LLM Self-Correction" (EMNLP 2025) — formalized the convergence ceiling: there is a maximum accuracy the loop can reach regardless of iterations, determined by the model's ability to preserve correct content and fix errors.
- Xu et al. (2024) — self-bias: LLMs systematically overrate their own generations, with monotonic amplification over multiple self-refinement steps.
- Pan et al. (2024) — reward hacking in self-refinement: generator exploits the evaluator when both are the same model.
- RefineBench (Lee et al., 2025) — state-of-the-art models show ≤1.8 percentage point gains from self-refinement across five iterations, but near-perfect gains with *external* guided feedback.

**The design implication:** "Machines can overthink problems too." Self-refinement loops need explicit stopping criteria, external validation, and awareness that the model's critic shares the model's blind spots. This connects to the ensemble approach (Chapter 5) — use *different* models to evaluate each other, not the same model evaluating itself.

**Brock's analogy to model collapse:** Model collapse (training on own outputs) degrades the model. Iterative self-refinement at inference time is an analogous dynamic — the system consuming its own output and converging on its own biases. The training-time and inference-time versions are structurally similar. [NEEDS: verify whether this specific comparison has been made in the literature. If not, flag as original observation worth developing.]

### 4. The Systems Engineering Gap

**Key points:**

- Statisticians and data scientists aren't trained in systems engineering. They're trained in methods, not architectures.
- The tooling market isn't solving this for research workflows. The market is building for software development (code generation, DevOps automation). Research documentation, scientific practice, provenance — these are niche concerns the market won't address.
- The community has to fill this gap or it won't get filled.
- "Just call the API" is not a design methodology. The false economy of skipping design: you'll rebuild it anyway, but now with accumulated technical debt and no evidence chain.

### 5. The Hadoop Aside (brief — 2-3 paragraphs max)

**Not the structural metaphor. A brief historical parallel.**

The actual parallel to Hadoop isn't "everyone did it wrong." It's that physical constraints forced design discipline:
- Data transport and compute time were bottlenecks. You had to understand where the physical constraints were and design for them.
- With LLMs: token throughput, throttle rates, cost, context window limits become the bottlenecks and engineering constraints.
- In both cases, the technology was accessible before the design patterns were codified. People FAFO'd their way through it. This book codifies the patterns from that process.

[NEEDS: fact-check the Hadoop timeline and specific claims. Don't assert anything from memory. If we can't verify, cut it to one paragraph of general analogy.]

### 6. The Evaluation Trap

**Key insight from Brock:** People who want to spend 6 months comparing Model A vs Model B are doing 2024 work on a 2026 landscape.

- By the time you finish your comparison study, the models have changed. The landscape shifts weekly.
- The design discipline is: build the *evaluation harness*, not the *evaluation conclusion*.
- Design for model replaceability. Your architecture should be model-agnostic at the inference layer.
- This book teaches the evaluation *process*, not specific model recommendations. (This is why Chapter 8 exists.)

### 7. The Organizing Framework

**Introduce tenets and working principles.**

- These aren't aspirational — they emerged from doing the work. From Census AI program strategy and from building real systems.
- **Compressed Tenets** (strategic — what matters): list all 10 with one-sentence explanations.
- **Working Principles** (practitioner — how to act): list all 8 with one-sentence explanations.
- Frame the relationship: tenets = what matters, principles = how to act.
- Each subsequent chapter maps to the principles it operationalizes. Reference the mapping table in the appendix.

### 8. What This Book Covers (chapter roadmap)

Brief paragraph per chapter cluster:
- **Chapters 2-4:** Domain workflow patterns (classification, cleaning, extraction)
- **Chapters 5-8:** Cross-cutting engineering patterns (ensemble, parallelism, checkpoints, evaluation)
- **Chapters 9-10:** State and provenance (SFV, artifact tracking)
- **Chapters 11-14:** Operational concerns (orchestration, security, deployment, cost)

### 9. Figure: fig-01-01

Reference `assets/diagrams/fig-01-01_naive_vs_designed.md` for the figure spec. Place between sections 4 and 5 (after establishing the design gap, before the Hadoop aside). Caption: something like "The gap between a naive single-stage LLM workflow and a designed one. Same input, same output — but only the right side can defend its result."

[NEEDS: figure not yet rendered. Include MyST figure directive with placeholder path `images/fig-01-01_naive_vs_designed.png`. Will be rendered via PaperBanana in a separate CC task.]

---

## Writing Guidance

- **Open with the thesis, not throat-clearing.** First sentence should be the core claim.
- **No hedging in the title or section headers.** "Why Design Matters" not "Introduction to Design Considerations."
- **Zero em-dashes in body text.** Use commas, semicolons, or restructure.
- **Minimal bold** — definitional terms only. Italics over bold for emphasis.
- **Figures are "figures," not "artwork."**
- **Audience calibration:** These are data scientists and statisticians in federal agencies. They know statistics, they know research methodology, they don't know systems engineering or distributed systems design. Don't explain statistical concepts; do explain engineering concepts.
- **Tone:** Direct, practical, no hype. Occasional dry humor is fine (the "stochastic liabilities, not bugs" line). Not academic — practitioner voice.
- **Citations:** Include only citations that have been verified via search in this session. For unverified claims, use `[NEEDS: citation for X]`. The self-refinement citations above are verified and ready to use. Everything else needs verification before inclusion.
- **Bridge from ai4stats:** Reference ai4stats Chapter 15 explicitly in the opening. Readers may not have read it — make the chapter self-contained, but acknowledge the connection. Don't repeat SFV definitions; point forward to Chapters 9-10.

## Verified Citations (ready to use)

These citations were verified via web search on 2026-03-29:

1. Madaan, A., Tandon, N., Gupta, P., et al. (2023). "Self-Refine: Iterative Refinement with Self-Feedback." *NeurIPS 2023*. — Showed diminishing returns in iterative self-refinement; largest improvements in first 1-2 rounds.
2. Huang, J., Chen, X., Mishra, S., et al. (2024). "Large Language Models Cannot Self-Correct Reasoning Yet." *ICLR 2024*. — When evaluator shares generator's blind spots, iteration rearranges errors without removing them.
3. Yang, Z., Zhang, Y., Wang, Y., et al. (2025). "A Probabilistic Inference Scaling Theory for LLM Self-Correction." *EMNLP 2025*. — Formalized convergence ceiling for self-refinement loops as Markov chain.
4. Xu et al. (2024). "Pride and Prejudice: LLM Amplifies Self-Bias in Self-Refinement." — Monotonic amplification of self-bias over multiple self-refinement steps.
5. Pan et al. (2024). "Spontaneous Reward Hacking in Iterative Self-Refinement." — Reward hacking failure mode when generator and evaluator are same model.
6. Lee et al. (2025). RefineBench. — State-of-the-art models show ≤1.8pp gains from self-refinement but near-perfect with guided external feedback.

## Unverified Claims (need citation search before inclusion)

- The "model collapse at inference time" analogy — check if anyone has made this comparison explicitly
- Hadoop-era specific claims about design pattern evolution
- Any specific cost figures beyond the $15 concept mapper reference (which is from Brock's own work)

## Target File

`book/chapter-01.md` — full replacement of existing placeholder content.

## Dependencies

- `book/appendix-principles.md` (exists, reference only)
- `assets/diagrams/fig-01-01_naive_vs_designed.md` (exists, figure not yet rendered)
- ai4stats Chapter 15 (reference only, do not copy content)

## Execution Notes

- Write the full chapter as a single markdown file
- Use MyST directives for figures: `{figure} images/fig-01-01_naive_vs_designed.png`
- Include `[NEEDS: ...]` markers for anything requiring further research, citation verification, or Brock's input
- Start bibliography entries — create/update `references.bib` if not already present
- Maintain the `<!-- STATUS: Draft -->` comment at top, replacing `<!-- STATUS: Placeholder -->`
