# Handoff: AI Workflow Design — Session 14

**Date:** 2026-03-31
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Chapter 14 Open Questions — Resolved

All three `[OPEN QUESTION]` markers in Chapter 14 resolved via CC task. These were the only remaining open questions in the manuscript — the "21 open questions" count from earlier handoffs was stale metadata that propagated unchecked from Session 7 through Session 13. Chapters 5 and 8 had zero open question markers on disk.

**The three resolutions:**

1. **Manual equivalent cost estimate** — Engineering judgment: 6,987 questions at 30/hr = 233 analyst-hours, $100/hr fully loaded = ~$24,100/cycle. AI pipeline: ~$3,500 development (one-time, 35 hours including prior experience) + $15/run inference. Year 1 total: ~$3,515 vs ~$24,100. Year 2+ per cycle: $15 vs $23,300.

2. **Cost taxonomy concrete numbers** — "Tens of hours" development framing, no false precision. Explicit callout that 35 hours reflects prior LLM pipeline experience; cold-start teams should budget person-weeks. Reinforces the pattern: inference is the smallest cost category.

3. **"When Cheap Models Win" reframed** — Killed the original question ("can we show a cheap model matching frontier accuracy?"). Replaced with evaluation-driven sufficiency: your harness defines the quality gate, not benchmarks. Added latency argument: smaller models are faster, not just cheaper — a frontier model on batch classification is a dump truck hauling a brick. Faster models buy room for multi-model consensus runs within the same time/cost envelope.

**CC task:**
- `2026-03-31_resolve_ch14_open_questions.md` — **EXECUTED**

### Stale Metadata Corrected

- The "21 open questions (Ch 5: 7, Ch 8: 7, Ch 14: 7)" count originated in Session 7 and was never re-verified. Chapters 5 and 8 have zero `[OPEN QUESTION]` markers — those items were resolved during CC task execution.
- Chapter 4 was flagged as a "placeholder" in Session 12 memory but has been a complete draft since Session 12's CC task execution. Confirmed on disk this session.

---

## CC Tasks Written This Session (1 file)

1. `2026-03-31_resolve_ch14_open_questions.md` — **EXECUTED**

**Total CC tasks on disk: 47** (46 prior + 1 this session)

---

## Current State of the Repo

All 14 chapters + foreword + introduction have first drafts. Glossary and index created. Zero `[OPEN QUESTION]` markers remain (pending verification sweep during audit). ~112 pages.

**Book files:**
- `foreword.md`, `intro.md`
- `chapter-01.md` through `chapter-14.md`
- `appendix-principles.md`
- `glossary.md`, `index.md`
- `bibliography.md`, `references.bib`
- `cover.md`, `figure-registry.md`
- `myst.yml` (TOC)

---

## What's Next

### Immediate: Full Chapter Audit

Walk through every chapter systematically. Author wants to review each one — not a marker sweep, a substantive read-through. This is the primary work for the next session(s).

Suggested audit approach: load each chapter, review for structural completeness, argument coherence, cross-reference accuracy, citation verification, and consistency with design decisions made in later sessions.

### Citation Verification

15 citations flagged across sessions as needing verification. Author plans to use Perplexity access at work. Can be integrated into the chapter audit or done as a separate pass.

### Deferred (unchanged)
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check
- Seldon graph reconciliation (`seldon paper sync` + `seldon verify --fix`)

---

## Key Decisions This Session

1. **Stale open question count killed.** The 21-question backlog was a handoff propagation artifact. Only 3 actual markers existed (all Ch 14), now resolved. Lesson: verify counts against disk state, not handoff chains.
2. **Cost numbers use engineering judgment, not false precision.** $100/hr fully loaded, 30 questions/hr, 35 hours development. Conservative but defensible. Explicitly notes prior experience compressed the timeline.
3. **"Cheap model matching frontier" is the wrong question.** Reframed to evaluation-driven sufficiency: the harness defines the gate, not benchmarks. Latency advantage of smaller models added as a design consideration (faster = more room for multi-model runs in same envelope).
4. **Chapter 4 confirmed complete.** Not a placeholder. Draft on disk since Session 12.

---

## Session Notes

- All tasks from Session 13 confirmed executed at session start (glossary, index, CLAUDE.md updates).
- Next session is substantive chapter-by-chapter audit — the first full review pass of the complete manuscript.
