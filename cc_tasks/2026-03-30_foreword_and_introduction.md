# CC Task: Foreword (New) and Introduction (Revised)

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## Context

The current `book/foreword.md` is functionally an Introduction: it frames the problem, establishes philosophy, orients the reader, and bridges to Chapter 1. A Foreword is a brief personal note. The TOC (`myst.yml`) already has both `foreword.md` and `intro.md` in the correct order; `intro.md` is currently a two-sentence placeholder.

This task:
1. Writes a new `book/foreword.md` — brief personal note + acknowledgments (ai4stats pattern)
2. Writes a new `book/intro.md` — current foreword content restructured as Introduction, with a **roadmap section** added

No changes to `myst.yml` needed — the TOC ordering (`foreword.md` → `intro.md` → `chapter-01.md`) is already correct.

---

## Task 1: New Foreword (`book/foreword.md`)

**OVERWRITE** the existing file. The current content moves to `intro.md`.

### Structure

```markdown
# Foreword

**Author:** Brock Webb

*The views expressed in this work are those of the author in his personal capacity and do not represent the views of any federal agency. This work was not produced in the author's official capacity and does not constitute an official publication of any federal agency.*

---

## On AI-Assisted Authoring

[2–3 paragraphs. Same stance as ai4stats foreword: AI assists, humans decide. Can note that this book was designed and authored using the same design discipline it teaches — the recursive application of the methodology. The intellectual architecture, editorial decisions, audience framing, and all judgment calls are the author's. AI tools did execution work: drafting, reformatting, research assistance. This is consistent with the book's thesis.]

---

## Acknowledgments

[Reuse the ai4stats acknowledgment paragraph — it applies here too:]

*Throughout my career, I have been continually humbled and inspired by the generosity of others: those who shared their knowledge, offered honest feedback, and walked with me for portions of this journey. There are too many to name individually, and attempting to do so would inevitably leave someone out. You know who you are, and I am grateful. The only way I know to truly show that gratitude is to give back. This work is one small attempt to do so.*
```

### Voice and length
- Brief. Half a page to one page maximum.
- Personal but not sentimental.
- The "On AI-Assisted Authoring" section can be slightly more developed than ai4stats version since this book's recursive meta-point (using the discipline to write about the discipline) is worth noting.

---

## Task 2: Introduction (`book/intro.md`)

**OVERWRITE** the existing placeholder.

### Structure

The Introduction has two parts: the **orientation** (adapted from current foreword content) and the **roadmap** (new).

#### Part 1: Orientation (from current `foreword.md`)

Adapt these sections from the current `book/foreword.md` into the Introduction. They can be used largely as-is with light editing for context (they were written as introduction material):

1. **"A New Design Space"** — LLMs opened a design space, prototype-to-production gap, this book is about crossing it
2. **"First Principles, Not Recipes"** — principles over tools, durability argument
3. **"The Hardest Part"** — confirmation bias as silent killer, design discipline protects you from yourself
4. **"Learning to See"** — practitioner's eye, strategic attention allocation
5. **"Find Your Edge"** — self-guided tour, different readers bring different strengths

Light edits only:
- Change `# Foreword` heading to `# Introduction`
- Status comment to `<!-- STATUS: Draft -->`
- The "Where We Begin" section at the end of the current foreword is **REPLACED** by the new roadmap below. Do not carry it over.

#### Part 2: Roadmap (new section)

Add a new section after "Find Your Edge" titled **"How This Book Is Organized"** (or similar — use judgment on the heading).

**Design requirements for the roadmap:**

1. **Name the structural arc explicitly.** The book moves through five phases:
   - **Foundations** (Chapter 1): The nature of the instrument — stochastic liabilities, the stochastic tax, why design discipline is required
   - **Domain Workflows** (Chapters 2–4): Concrete applications — classification, data cleaning, detection/extraction — where the design patterns meet real statistical work
   - **Cross-Cutting Patterns** (Chapters 5–8): Engineering patterns that apply across all domain workflows — multi-model design, pipeline architecture, failure recovery, evaluation
   - **Validity & Infrastructure** (Chapters 9–11): The theoretical and engineering foundation for trust — SFV framework, provenance, orchestration
   - **Institutional Context** (Chapters 12–14): Moving from working pipeline to deployed system — security, institutional deployment, cost and practicality

2. **Give each chapter a 2–3 sentence preview.** Enough for a reader to know if they need it. Use the actual thesis/hook from each chapter's opening, not generic descriptions. Here are the hooks to work from:

   - **Ch 1 (Why Design Matters):** LLMs are stochastic instruments, not deterministic tools. "Stochastic liabilities, not bugs" — properties to design around, not defects to fix. The stochastic tax: every unnecessary LLM invocation is avoidable variance.
   - **Ch 2 (Classification & Coding):** 6,954 survey questions, 152 categories, $15 in API costs. The Concept Mapper case study demonstrates dual-model cross-validation, structured arbitration, and complete evidence chains. Classification is the natural entry point because it has ground truth.
   - **Ch 3 (Data Cleaning & Imputation):** Where LLMs complement traditional edit/imputation methods (Fellegi-Holt, hot-deck) and where they don't. The ground truth problem: no labeled "actually wrong" records. Survey design effects that off-the-shelf ML ignores. **Note to Claude Code: this chapter is a placeholder with working notes only, not drafted prose. Write the preview based on the working notes, not by extracting from chapter text.**
   - **Ch 4 (Detection & Extraction):** Entity extraction, pattern detection, disclosure review. Knowledge graphs as "confidence laundering machines" — extraction pipelines that look authoritative and are structurally wrong. SFV applied to extraction fidelity. **Note to Claude Code: same as Ch 3 — placeholder only. Write preview from working notes.**
   - **Ch 5 (Ensemble & Multi-Model):** "The silence of a single model" — single-model pipelines bury uncertainty in confident output. Three topologies: parallel consensus, generator-critic, cascade/triage. Multi-model is the baseline; single-model needs justification.
   - **Ch 6 (Parallel, Serial, Bottleneck):** Force multipliers amplify good and bad design equally. The LLM API call is almost always the bottleneck. Parallel vs. serial is a task-dependency question, not a preference.
   - **Ch 7 (Checkpoints, Failures, Recovery):** Everything fails. Config-driven architecture, progressive test infrastructure, checkpoint/recovery. Model parameters have a shelf life. The temperature tradeoff as bias-variance.
   - **Ch 8 (Evaluation by Design):** No benchmark exists for your pipeline. The FCSM/NIST crosswalk: two evaluation frameworks apply simultaneously — data quality and AI system trustworthiness. Evaluation is architecture, not afterthought.
   - **Ch 9 (State, Drift, Validity):** The instrument that changes itself. State Fidelity Validity (SFV): validity failure, not reliability failure. The composite instrument (fixed weights + mutable context) silently becomes a different instrument.
   - **Ch 10 (State Management & Provenance):** Defensible by design. Can you prove your pipeline's chain from input to output under independent audit? DOORS had the right requirements decades ago — AI partners change the cost equation that killed traceability systems.
   - **Ch 11 (Workflow Orchestration):** The orchestration tool researchers need largely doesn't exist. Four evaluation dimensions: coupling, friction, transparency, volatility. Patterns are durable, products are volatile — bet on patterns, wait on products.
   - **Ch 12 (Security & Supply Chain):** Security controls are enabling, not prohibitive. The Five Safes framework applied to AI workflows. US agencies already do these things under different names — Five Safes provides common vocabulary.
   - **Ch 13 (Institutional Deployment):** The last mile is organizational. Authorization gaps, procurement timelines, governance review cadence. The compressed tenets and working principles as diagnostic lens for institutional friction.
   - **Ch 14 (Cost & Practicality):** Every cost discussion is a comparison: AI pipeline cost versus the status quo alternative. The status quo has costs too — they're just already in the budget. Worked examples with real numbers.

3. **Suggest entry points for different reader profiles.** After the chapter previews, add a brief section (a few paragraphs, NOT a bulleted list) that helps readers self-select:
   - **Statisticians/domain experts new to pipeline engineering:** Start at Ch 1, read through. The domain chapters (2–4) are familiar territory; the cross-cutting chapters (5–8) are where you'll learn the most.
   - **Software engineers/data scientists new to official statistics:** Ch 1 for the stochastic framing, then Ch 8 (evaluation) and Ch 12 (security/Five Safes) for the institutional context that changes everything about how you design.
   - **Managers/program leaders:** Ch 13 (institutional deployment) and Ch 14 (cost) first for the operational picture, then Ch 1 for the design philosophy, then Ch 8 (evaluation) for the quality argument.
   - **Practitioners who already build LLM pipelines:** Ch 9 (SFV) is probably the most novel content. Ch 5 (multi-model) and Ch 10 (provenance) will challenge assumptions about single-model sufficiency and ad-hoc tracking.

4. **Include the predecessor book relationship.** The current foreword's "Where We Begin" section mentions ai4stats. Move that relationship note into the roadmap context — something like: if you're coming from ai4stats, that book built your foundation (what AI is, how it works); this book picks up with how to build systems you can trust. If you're new, Ch 1 is self-contained.

### Voice
- Same voice as the rest of the book: direct, no hedging, no filler.
- The roadmap should be informative, not promotional. It's a map, not a sales pitch.
- Chapter previews should use the actual language and concepts from the chapters, not watered-down summaries.

### Length
- Orientation sections: ~same as current foreword (they're being moved, not rewritten)
- Roadmap: substantial but not exhaustive. 2–3 sentences per chapter preview + reader profile guidance. Total roadmap section probably 1500–2500 words.

---

## Files Modified

| File | Action |
|------|--------|
| `book/foreword.md` | **OVERWRITE** — new foreword (personal note + acknowledgments) |
| `book/intro.md` | **OVERWRITE** — introduction (orientation from old foreword + new roadmap) |

No other files modified. `myst.yml` TOC is already correct.

---

## Verification

After execution:
1. `book/foreword.md` should be brief (< 1 page of content), contain views disclaimer, AI-assisted authoring note, and acknowledgments
2. `book/intro.md` should contain all five orientation sections from the old foreword + new roadmap section with all 14 chapter previews + reader entry points
3. `myst.yml` unchanged
4. No content from the old foreword should be lost — everything moves to `intro.md` except the "Where We Begin" section which is replaced by the roadmap
