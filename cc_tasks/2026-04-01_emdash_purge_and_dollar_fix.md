# CC Task: Em-Dash Purge (Foreword–Ch02) and Dollar Sign Rendering Fix

**Date:** 2026-04-01
**Scope:** `book/intro.md`, `book/chapter-01.md`, `book/chapter-02.md`
**Type:** Prose fix (zero-tolerance em-dash removal + rendering regression fix)
**Status:** PENDING

---

## Context

Two issues discovered during Session 17 pre-audit:

1. **Dollar sign rendering regression in chapter-02.md:** MyST/Jupyter Book interprets bare `$` as LaTeX math delimiters. Lines 18 and 88 contain `$15` and `$100`, causing everything between dollar signs to render as a single run-on math block with no spaces. Fix: escape all dollar signs in prose as `\$` so MyST renders them as literal currency symbols.

2. **Em-dash zero tolerance:** 11 em-dashes (`—`) found across intro.md (1), chapter-01.md (2), and chapter-02.md (8). All must be replaced with appropriate punctuation. foreword.md is clean.

---

## Part 1: Dollar Sign Escaping (chapter-02.md)

### Fix 1a — Line 18 (section intro paragraph)
**Find:** `approximately $15 in API fees`
**Replace with:** `approximately \$15 in API fees`

### Fix 1b — Line 88, first occurrence
**Find:** `cost approximately $15 in API fees`
**Replace with:** `cost approximately \$15 in API fees`

### Fix 1c — Line 88, second occurrence
**Find:** `cost under $100 in total API fees`
**Replace with:** `cost under \$100 in total API fees`

### ALSO: Check all other .md files in book/ for bare dollar signs that could trigger the same rendering bug.
Run: `grep -rn '\$[0-9]' book/*.md` and escape any bare `$` followed by a digit. Known instances beyond ch02 include intro.md line referencing "$15" in the chapter 2 summary.

**Intro.md line (Chapter 2 summary):**
**Find:** `$15 in API costs`
**Replace with:** `\$15 in API costs`

---

## Part 2: Em-Dash Removal

For each replacement below, the em-dash is replaced with the punctuation that best fits the sentence structure (colon, semicolon, comma, or parenthetical restructure). Do NOT introduce new em-dashes anywhere.

### intro.md (1 instance)

**Line 53:**
**Find:** `then something clicks — a process improvement, a conceptual shift — and you are`
**Replace with:** `then something clicks (a process improvement, a conceptual shift) and you are`

### chapter-01.md (2 instances)

**Line 56:**
**Find:** `The LLM-specific tools researchers need — orchestration with research-grade provenance, evaluation infrastructure for stochastic pipelines, state management for mutable instruments — are not being built`
**Replace with:** `The LLM-specific tools researchers need (orchestration with research-grade provenance, evaluation infrastructure for stochastic pipelines, state management for mutable instruments) are not being built`

**Line 80:**
**Find:** `After completing the study — having actually been slowed down — they still estimated`
**Replace with:** `After completing the study, having actually been slowed down, they still estimated`

### chapter-02.md (8 instances)

**Line 50:**
**Find:** `The first two are deterministic logic gates — no additional model is involved.`
**Replace with:** `The first two are deterministic logic gates; no additional model is involved.`

**Line 56:**
**Find:** `Preserving both assignments broadens downstream matching — it is a form of fuzzy matching`
**Replace with:** `Preserving both assignments broadens downstream matching: it is a form of fuzzy matching`

**Line 58:**
**Find:** `If the dual-modal rate had been substantially higher — say 30% or more — that would have signaled`
**Replace with:** `If the dual-modal rate had been substantially higher, say 30% or more, that would have signaled`

**Line 60:**
**Find:** `The ones reviewed were defensible — reasonable arguments could be made`
**Replace with:** `The ones reviewed were defensible: reasonable arguments could be made`

**Line 60 (second instance):**
**Find:** `not wrong answers — a cost the pipeline could absorb`
**Replace with:** `not wrong answers, a cost the pipeline could absorb`

**Line 74:**
**Find:** `The independence is imperfect — models from different vendors still share overlapping training corpora — but it is stronger`
**Replace with:** `The independence is imperfect (models from different vendors still share overlapping training corpora) but it is stronger`

**Line 78:**
**Find:** `Every one of these routing decisions — what threshold triggers auto-accept, whether to preserve dual-modal ambiguity or force resolution, when to invoke a more expensive arbitrator — is an engineering judgment`
**Replace with:** `Every one of these routing decisions (what threshold triggers auto-accept, whether to preserve dual-modal ambiguity or force resolution, when to invoke a more expensive arbitrator) is an engineering judgment`

**Line 84:**
**Find:** `And for items where all models struggle — the approximately 38 questions`
**Replace with:** `And for items where all models struggle, the approximately 38 questions`

**Line 88:**
**Find:** `but it is not the whole story — the human engineering cost`
**Replace with:** `but it is not the whole story. The human engineering cost`

---

## Verification

After all edits:

1. Run `grep -rn '—' book/foreword.md book/intro.md book/chapter-01.md book/chapter-02.md` — expect 0 results.
2. Run `grep -rn '\$[0-9]' book/foreword.md book/intro.md book/chapter-01.md book/chapter-02.md` — expect 0 results (all should be `\$`).
3. Run `myst build --html` and visually confirm the cost paragraph in chapter 2 renders correctly with spaces and dollar signs.
4. Run `seldon verify --fix` after edits.

---

## Acceptance Criteria

- [ ] Zero em-dashes in foreword.md, intro.md, chapter-01.md, chapter-02.md
- [ ] All bare `$` before digits escaped as `\$` in all four files
- [ ] MyST HTML build renders cost paragraph correctly (no run-on text)
- [ ] No new em-dashes introduced
- [ ] `seldon verify` passes
