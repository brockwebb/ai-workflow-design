# CC Task Addendum: Chapter 1 — Pedagogical Structure and Fig-01-01 Rework

**Date:** 2026-03-29
**Parent task:** `2026-03-29_chapter_01_draft.md`
**Type:** Content Addendum — Pedagogical Pattern and Figure Presentation

---

## Summary

This addendum captures two structural decisions made in session discussion:

1. The fig-01-01 presentation should be reworked as a "what's wrong here" exercise, not a side-by-side comparison.
2. All chapters should include a consistent pedagogical pattern of reflection prompts and thought experiments.

## 1. Fig-01-01 Rework: "What's Wrong With This Picture?"

**Current spec** (in `assets/diagrams/fig-01-01_naive_vs_designed.md`): Two-panel horizontal comparison — naive workflow on left, designed workflow on right. Present both simultaneously.

**Revised approach:** Present in two stages, not side-by-side.

**Stage 1 — Present the naive workflow only.**

Show: Input → Model → Output. The simplest possible LLM workflow. One model, one call, one result.

Then ask the reader:
- What could go wrong here?
- How would you know if the output was wrong?
- Could you defend this result to a reviewer? To an auditor? To Congress?
- What happens when you run it again tomorrow and get a different answer?
- What happens when the model provider updates the model next month?

Give the reader space to think. These aren't rhetorical questions — they're the actual engineering problems the rest of the book addresses.

**Stage 2 — Present the designed workflow.**

After the reader has engaged with the problems, show the designed version. Now it makes sense *because the reader understands what each component is solving.* The evidence accumulation layer exists because you can't defend a result without it. The agreement scoring exists because a single stochastic output isn't trustworthy. The model selection layer exists because you need to reason about your instrument.

The chapter then maps each component to where it's addressed in the book: ensemble patterns (Ch 5), evaluation (Ch 8), state management (Ch 9-10), etc.

**Implication for figure rendering:** We may want two separate figures instead of one two-panel figure:
- `fig-01-01a`: The naive workflow (simple, sparse)
- `fig-01-01b`: The designed workflow (rich, annotated)

Or keep them as one figure but present them sequentially in the text with the reflection questions between them. Either works. Brock to decide on presentation.

**Update to figure spec:** The existing spec at `assets/diagrams/fig-01-01_naive_vs_designed.md` should be updated to reflect this two-stage presentation. This can be done as a separate micro CC task or folded into the figure rendering task.

## 2. Chapter Pedagogical Pattern

**Decision:** Every chapter includes reflection prompts and thought experiments. This is a consistent structural element, not optional.

**Pattern for each chapter:**

- **Opening hook:** A concrete scenario or problem that motivates the chapter's topic. Not abstract — grounded in something the reader recognizes.
- **Core content:** The technical material, design patterns, principles.
- **Reflection prompts (distributed throughout):** "What could go wrong here?" / "How would you check this?" / "What would you do differently?" These are inline, not boxed at the end. They interrupt the reading at natural pause points to force active engagement.
- **Thought experiment (at least one per chapter):** A more substantial scenario that asks the reader to apply what they've learned. Not homework — a provocation. Example: "Your pipeline processed 50,000 records overnight. The summary statistics look reasonable. How do you know the model didn't silently change its classification criteria at record 23,000?"
- **Chapter bridge:** Each chapter ends by connecting forward — what comes next and why it matters given what you just learned.

**This pattern is Feynman pedagogy operationalized:** study (core content), explain/apply (thought experiments), find gaps (reflection prompts), go back (chapter bridges pointing to related chapters).

**Documentation:** Add a note to `CLAUDE.md` or `book/appendix-principles.md` (or a new `docs/chapter-structure-pattern.md`) describing this pattern so future chapter drafts follow it consistently.

## 3. The 3,000 Excel Files Example — Repositioned

**Decision:** The VBA/Excel macro example does NOT open the book or Chapter 1. It's a useful reference point but not the opening.

**Revised placement:** Use it *inside* Chapter 1 as a calibration point when discussing the maturity levels (Shapiro framework). Something like: "At the simplest level, someone uses an LLM to generate a VBA macro for batch QA across thousands of spreadsheets. They check the code, verify the results, move on. That's real value — and for many tasks, that's all you need. This book is for when you need to go further."

It's a contrast point, not an opener. The opener comes out of the foreword's Feynman frame and lands on the thesis about the stochastic nature of LLMs.

## Execution Notes

- These changes modify the argument flow in the parent CC task (`2026-03-29_chapter_01_draft.md`). Claude Code should incorporate them when writing the chapter draft.
- The fig-01-01 two-stage presentation is a structural change — the figure spec file may need a follow-up update.
- The chapter pedagogical pattern should be documented somewhere persistent (CLAUDE.md or a dedicated doc) so it carries forward to all chapters.
