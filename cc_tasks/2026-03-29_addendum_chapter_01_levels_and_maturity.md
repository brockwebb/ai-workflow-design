# CC Task Addendum: Chapter 1 — AI Maturity Levels and the Infrastructure Gap

**Date:** 2026-03-29
**Parent task:** `2026-03-29_chapter_01_draft.md`
**Type:** Content Addendum — Additional Material for Chapter 1

---

## Summary

This addendum captures additional material for Chapter 1 that emerged in session discussion after the parent CC task was written. It covers two threads: (1) Dan Shapiro's five levels of AI coding automation as a framework to adapt for research workflows, and (2) a concrete example of limited-scope AI use (VBA/Excel macro generation) as the accessible entry point for the chapter.

## Material to Integrate

### Dan Shapiro's Five Levels of AI Coding (reference framework)

**Source:** Dan Shapiro (CEO, Glowforge; Wharton Research Fellow). "The Five Levels: from Spicy Autocomplete to the Dark Factory." Published January 23, 2026. URL: https://www.danshapiro.com/blog/2026/01/the-five-levels-from-spicy-autocomplete-to-the-software-factory/

Shapiro's levels, modeled after NHTSA's 2013 five levels of driving automation:

- **Level 0: Spicy Autocomplete** — AI suggests next line, human writes all code.
- **Level 1: Coding Intern** — Discrete, well-scoped tasks handed to AI, human reviews everything.
- **Level 2: Junior Developer** — AI navigates codebase, handles multi-file changes. Human still reads and reviews all code. Shapiro estimates 90% of "AI-native" developers are stuck here.
- **Level 3: Developer as Manager** — Human stops writing code, directs AI, reviews at feature/PR level.
- **Level 4: Developer as Product Manager** — Human writes spec, leaves, returns to check if tests pass. Code is a black box.
- **Level 5: The Dark Factory** — Autonomous. Markdown specs go in, working tested software ships. No human writes or reviews code.

**Key insight from Shapiro:** Every level past 2 "feels like you are done. But you are not done." The danger is that people plateau at Level 2 and mistake it for the ceiling.

**Supporting data point:** METR RCT (July 2025) — 16 experienced open-source developers, 246 real tasks. AI tools slowed work by 19% on average. Developers estimated AI made them 24% *faster*. They were wrong about both direction and magnitude. The tool changed; the workflow didn't.

### Translation to Research Workflows

**Critical distinction:** Shapiro's levels are about software development. The verification problem is different for research:

- Software Level 5 verification: "Do the tests pass?" (deterministic)
- Research Level 5 verification: "Is this defensible as official statistics?" (requires validity, provenance, institutional credibility — cannot be reduced to pass/fail)

**Adapted levels for research workflows (draft — Brock to refine):**

- **Level 0-1:** Use LLM as helper. Ask it for VBA code to QA 3,000 Excel files. Check its work. Real value, limited scope, limited risk. Most people should start here for most tasks.
- **Level 2:** LLM as junior analyst. It does multi-step work, you review everything. You're faster but you're the bottleneck. The "micromanager" mode — you double-check every output.
- **Level 3:** Outcome-based. You've built infrastructure — dual-path verification, evidence chains, graph-based provenance, statistical checks — so you don't have to read every line. You've moved yourself to where you provide the most value: validation, domain judgment, the critical 10%.
- **Level 4-5:** Specification-driven research pipelines. You write the research design spec, the system executes, you evaluate whether the outputs are defensible. The verification framework is the intellectual property, not the outputs themselves.

**The argument for Chapter 1:** The levels exist for research workflows too, but the infrastructure to operate safely at the higher levels *doesn't exist yet for this context.* The tooling market is building for software developers (test suites, CI/CD, type systems). For research workflows — SFV, artifact tracking, dual-path verification, evidence chains — you have to build it yourself. This book teaches you how.

### The VBA/Excel Example (concrete entry point)

Use as an accessible opening example somewhere in the chapter:

- Someone uses an LLM to generate VBA macro code for automating quality checks across 3,000 Excel files.
- They got help, modified the code to work, checked their results. Done.
- That's a perfectly valid, limited AI use case. Level 0-1. No elaborate design infrastructure needed.
- But if you want to move fast *and* at scale — automating multi-stage research pipelines, not just macros — you need to go up through the levels. And going up through the levels requires building the infrastructure this book teaches.

### The "Human in the Loop" Reframe

Brock's position (stated publicly at Census): "My goal is to remove myself as much as possible and only keep myself in the loop where I provide the most value."

This is counterintuitive to the "humans must be in the loop" discourse, but it's the correct framing:

- Being in the loop *everywhere* is waste. It's Level 2 thinking.
- The design discipline is identifying *where* in the loop human judgment is irreplaceable and building automation for everything else.
- This requires the prework: dual-path designs, evidence chains, provenance tracking, statistical quality checks. You can only step back *because* you built the systems that make stepping back safe.
- **Level 3+ is earned, not assumed.** You get there by doing the prework. The prework is what this book teaches.

### The Prework Argument

Brock's hard-won lesson: "I've learned the hard way by making lots of stupid mistakes. Even on stuff I know, because it's so easy to go too quick. I've even slowed down and still fucked things up."

This is the argument for the entire book distilled: the design discipline (the prework) isn't overhead — it's what lets you go fast safely. Without it, you either go slow (micromanaging at Level 2) or go fast and break things (which in official statistics is not acceptable).

## Placement Guidance

- **Shapiro's levels:** Near the "systems engineering gap" section (Section 4 in parent task). Reference and cite Shapiro, then reframe for research context.
- **VBA/Excel example:** Early in the chapter, possibly as the opening concrete example before the thesis gets abstract. Shows the simplest useful case, then escalates.
- **"Human in the loop" reframe:** Integrate with the systems engineering gap or as a bridge between the iterative refinement trap and the evaluation trap sections.
- **Prework argument:** This is the chapter's closing punch. The last thing the reader should take away before the tenets/principles section.

## Verified Citations (additional, ready to use)

7. Shapiro, Dan (2026). "The Five Levels: from Spicy Autocomplete to the Dark Factory." danshapiro.com, January 23, 2026. URL: https://www.danshapiro.com/blog/2026/01/the-five-levels-from-spicy-autocomplete-to-the-software-factory/

[NEEDS: METR RCT citation — verify full citation details. Published July 2025. 16 developers, 246 tasks, 19% slower result.]

## Execution Notes

- This addendum supplements the parent CC task. Claude Code should incorporate this material when executing `2026-03-29_chapter_01_draft.md`.
- Brock retains all decisions on final language, level definitions, and placement.
- The research-adapted levels are a draft framework — may evolve as the book develops.
