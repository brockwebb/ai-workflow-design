# Handoff: AI Workflow Design — Session 15

**Date:** 2026-03-31
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Seldon Sync Bug Fixed

Graph was lagging behind disk state (118 nodes / 64 relationships). Sync bug identified and fixed. Graph now at **166 nodes / 110 relationships** — 48 nodes and 46 relationships recovered. Documentation ratio: 20/166 (12%).

### Foreword & Introduction Audit — Complete

Substantive read-through of `foreword.md` and `intro.md`. Five issues identified:

1. **Foreword §Purpose ¶2** — "obligations that commercial software does not" overbroad. Fix: tighten to public trust / democratic accountability.
2. **Foreword §AI-Assisted** — "AI partner" consistency check across book. Grep-and-report task.
3. **Intro §New Design Space ¶4** — "every other tool" overbroad. Fix: distinguish stochastic + natural language mimicry as the novel problem.
4. **Intro §Hardest Part ¶1** — "nobody talks about honestly" unsupported. Fix: reframe to "surprisingly little attention in practitioner guidance."
5. **Intro §Find Your Edge ¶5-7** — Motivational drift. Fix: compress three paragraphs to one, cut reassurance, keep nonlinear learning curve point.

**Decision:** Foreword is allowed personality and motivational tone. Initial overcalls on foreword items 1 and 3 (severity) were withdrawn — those are voice choices appropriate to a foreword. Item 2 (obligations claim) held as a factual precision issue regardless of tone.

**CC task:** `2026-03-31_audit_foreword_intro_fixes.md` — **EXECUTED**

### Chapter 1 Audit — Complete

Substantive read-through of `chapter-01.md`. Seven items identified, four actionable:

1. **§What This Book Covers ¶2** — "data cleaning and imputation" stale. Chapter 3 redesigned to "Data Wrangling & Standardization." Fixed.
2. **§Systems Engineering Gap ¶2** — "tools not being built" slightly overbroad. Tightened to specify LLM-specific research tooling.
3. **fig-01-01a and fig-01-01b** — No rendered images exist. Build will break. PaperBanana method files written, CC task created and executed. Figures rendered.
4. **METR 19% figure** — Independently verified via Perplexity. All numbers confirmed (19% slowdown, 24% pre-study forecast, 20% post-study estimate). Chapter text sharpened to distinguish the two perception numbers.
5. **DORA 39,000+ respondent count** — **FLAGGED.** Independent Perplexity verification could not confirm 39,000+ from original DORA 2024 report. Secondary sources indicate ~3,000. The 75%, 1.5%, and 7.2% analytical findings ARE confirmed. Author resolved: [record resolution here if decided during CC execution, otherwise carries forward].
6. **Shapiro citation** — Confirmed in bib. "Spicy autocomplete" is his language.
7. **DORA analytical figures** — Confirmed in bib note. Numbers match chapter text.

**CC tasks:**
- `2026-03-31_audit_ch01_fixes.md` — **EXECUTED**
- `2026-03-31_render_fig-01-01_paperbanana.md` — **EXECUTED**

### PaperBanana Figure Rendering

Method files written for both Chapter 1 figures:
- `assets/diagrams/paperbanana/fig-01-01a_naive_method.txt` — three-box naive workflow
- `assets/diagrams/paperbanana/fig-01-01b_designed_method.txt` — five-layer designed workflow

Rendered via PaperBanana CC task. Images now in `book/images/`. `[NEEDS:]` markers removed from chapter-01.md.

### Citation Verification Process Established

Independent dual-path verification confirmed as the standard:
- Claude web search is NOT sufficient for citation verification
- Author runs Perplexity independently as a parallel search
- This caught the DORA respondent count mismatch — a number that looked correct in the bib note and chapter text but could not be confirmed from the original source
- Process: Claude drafts Perplexity prompt → Author runs it → results fed back → CC task updated

---

## CC Tasks Written This Session (3 files, all EXECUTED)

1. `2026-03-31_audit_foreword_intro_fixes.md` — Foreword/intro prose fixes (5 items) — **EXECUTED**
2. `2026-03-31_render_fig-01-01_paperbanana.md` — PaperBanana figure rendering (2 figures) — **EXECUTED**
3. `2026-03-31_audit_ch01_fixes.md` — Chapter 1 prose fixes + citation verification (4 items) — **EXECUTED**

**Total CC tasks on disk: 50** (47 prior + 3 this session)

---

## Current State of the Repo

All 14 chapters + foreword + introduction have first drafts. All foreword, intro, and Chapter 1 audit fixes applied. fig-01-01a and fig-01-01b rendered. Zero `[OPEN QUESTION]` markers remain.

**Audit progress:**
- Foreword: ✓ audited, fixes applied
- Introduction: ✓ audited, fixes applied
- Chapter 1: ✓ audited, fixes applied (DORA respondent count may carry forward)
- Chapters 2–14: not yet audited

**Graph:** 166 nodes, 110 relationships (post-sync fix)

---

## What's Next

### Immediate: Chapter 2 Audit

Continue the chapter-by-chapter audit. Chapter 2 (Classification & Coding Workflows) is next. Same audit standards:
- Facts and claims supported or flagged `[NEEDS:]`
- No throat-clearing or academic filler
- Cross-reference accuracy to other chapters
- Citation verification (Perplexity for independent confirmation)
- Figures accounted for (existence, rendering, accuracy)
- Consistency with design decisions from later sessions
- Pedagogical pattern compliance (opening hook, reflection prompts, thought experiment, chapter bridge)

### Carrying Forward

- **DORA respondent count (Fix 4 from Ch 1 audit):** If not resolved during CC execution, author needs to verify whether 39,000+ comes from multi-year DORA data or is an error. Options: correct to ~3,000, confirm 39,000+ with source, or replace with "a large-scale global survey."
- **15 citations flagged across sessions** for Perplexity verification — integrate into chapter audit as each chapter is reviewed.

### Deferred (unchanged)

- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check
- Seldon graph reconciliation follow-up (sync bug fixed, but documentation ratio still 12%)

---

## Key Decisions This Session

1. **Foreword personality is appropriate.** Motivational tone in a foreword is a voice choice, not throat-clearing. Overcalls withdrawn.
2. **Independent citation verification is the standard.** Claude's web search does not substitute for Perplexity verification. Dual-path verification caught the DORA respondent count mismatch.
3. **Figures are audit items, not deferred items.** Missing figures are build-breaking problems with the same priority as factual errors.
4. **METR perception gap sharpened.** Pre-study forecast (24%) distinguished from post-study estimate (20%) — the persistence of misperception despite experience is the stronger finding.
5. **PaperBanana is appropriate for technical diagrams** given proper method file specs. Cover art aesthetic not required for block diagrams.

---

## Session Notes

- Seldon sync bug fixed at session start. Graph reconciled before audit work began.
- All 3 CC tasks confirmed executed by author before handoff.
- Next session begins with Chapter 2 audit — no outstanding blockers.
