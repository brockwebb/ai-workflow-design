# Handoff: AI Workflow Design — Session 13

**Date:** 2026-03-31
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### CLAUDE.md Update — CC Task Written

CC task to update CLAUDE.md with three changes:
- **Ch 4 outline entry:** Expanded from placeholder to full description (domain trilogy positioning, KG confidence laundering, Templ + DiGiuseppe & Flynn worked examples, confabulation graph principle)
- **Ch 6 outline entry:** Removed killed "$15 vs $1500" framing (intellectual honesty — couldn't justify with data)
- **Ch 3 name verification:** Confirm "Data Wrangling & Standardization" is correct everywhere

**Addendum written** superseding Changes 1 and 2: strip the entire chapter outline section to **titles only** (no paragraph descriptions). The descriptions are rot-prone duplication of content that lives in the chapter files. Keep the Chapter-to-Principle Mapping table (structural metadata not duplicated elsewhere). Remove "(Draft)" qualifier from section heading — all chapters have first drafts.

**CC tasks:**
- `2026-03-31_update_claude_md.md` — **EXECUTED**
- `2026-03-31_update_claude_md_addendum.md` — **EXECUTED**

### Glossary and Index — CC Task Written

CC task to create `book/glossary.md` and `book/index.md`, add both to `myst.yml` TOC.

- **Glossary:** MyST `{glossary}` directive format (matching ai4stats pattern). Seeded from ai4stats glossary entries that appear in this book, plus new terms extracted from all 14 chapters. Alphabetical, practitioner-oriented definitions.
- **Index:** Keyword-by-chapter table. Living digital book — no page numbers. Substantive discussion only, not passing mentions.
- **myst.yml:** Both files inserted between appendix-principles and bibliography.

**Addendum written** correcting "ABBA design" to **counterbalancing** (the established experimental design term). Ch 5 already calls it "standard counterbalancing from experimental design." General principle added: do not mint glossary entries for common terms that already have established names — use the proper term, note shorthand parenthetically.

**CC tasks:**
- `2026-03-31_create_glossary_and_index.md` — **PENDING**
- `2026-03-31_create_glossary_and_index_addendum.md` — **PENDING**

### LinkedIn Announcement Drafted

Post text finalized for the book announcement. Cover image + "Coming Soon" + chapter list + SFV hook + public trust framing. Opening: "Coming soon! I've been pushing hard on this one. 14 chapters, all drafted, all free and open source." Closing: "That book covered what AI is. This one covers how to build with it so you can defend what you built."

---

## CC Tasks Written This Session (4 files)

1. `2026-03-31_update_claude_md.md` — **EXECUTED**
2. `2026-03-31_update_claude_md_addendum.md` — **EXECUTED**
3. `2026-03-31_create_glossary_and_index.md` — **PENDING**
4. `2026-03-31_create_glossary_and_index_addendum.md` — **PENDING**

**Total CC tasks on disk: 46** (42 prior + 4 this session)

---

## Current State of the Repo

All 14 chapters + foreword + introduction have first drafts. ~112 pages. No chapter status changes this session.

---

## What's Next

### Immediate: Execute Pending CC Tasks

1. **Glossary and index** — `2026-03-31_create_glossary_and_index.md` + addendum. Execute via Claude Code.

### Then: Open Questions Walkthrough

Unresolved open questions from drafting sessions. This is the next substantive design work:
- **Ch 5:** 7 open items
- **Ch 8:** 7 open items
- **Ch 14:** 7 open items
- **Total: 21 known open questions**

Walk through systematically. Some may already be resolved by later chapters; some may need design decisions. Start banging away on these next session.

### Then: Audit Pass

Full structural review of all chapters. Citation verification (15 citations flagged). Author plans to use Perplexity access at work for verification.

### Deferred (unchanged from Session 12)
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check

### Resolved This Session
- ~~CLAUDE.md chapter outline table: Ch 3 name update~~ → addressed in CLAUDE.md CC task
- ~~CLAUDE.md Ch 4 placeholder description~~ → addressed (then superseded by strip-to-titles-only)
- ~~CLAUDE.md Ch 6 killed "$15 vs $1500" reference~~ → addressed (then superseded by strip-to-titles-only)

---

## Key Decisions This Session

1. **CLAUDE.md chapter descriptions are rot-prone duplication.** Stripped to title-only list. Principle mapping table retained (unique structural metadata).
2. **Use established terminology, not shorthand, in glossary entries.** "Counterbalancing" not "ABBA design." General rule: if a common term has an established name in experimental design, software engineering, or statistics, use the established name.
3. **CC task immutability enforced.** Corrections go in addendum files with explicit references to the file they amend. Only the author can grant permission to modify a written CC task.

---

## Session Notes

- LinkedIn announcement finalized and ready to post with cover image.
- Session was primarily housekeeping (CLAUDE.md, glossary/index setup, LinkedIn) — next session shifts to substantive design work on the 21 open questions.
