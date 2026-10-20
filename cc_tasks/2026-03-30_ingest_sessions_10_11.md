# CC Task: Ingest Sessions 10 and 11 into Seldon

**Date:** 2026-03-30
**Author:** Brock Webb
**Priority:** Housekeeping — graph sync

---

## Context

Seldon's graph currently reflects state through Session 9. Sessions 10 and 11 produced:

- **Session 10:** Ch 10 (State Mgmt & Provenance) and Ch 11 (Workflow Orchestration) drafted and executed.
- **Session 11:** Foreword/Introduction restructured, Ch 3 (Data Wrangling & Standardization) redesigned and drafted, SLM addendum applied.

Three CC tasks from Session 11 were executed between sessions:
1. `2026-03-30_foreword_and_introduction.md`
2. `2026-03-30_draft_chapter_03.md`
3. `2026-03-30_addendum_chapter_03_slm_guidance.md`

The handoff files exist on disk but the graph doesn't know about the new/modified artifacts.

---

## Instructions

### Step 1: Run `seldon paper sync`

This should detect file changes (new content in chapter-03.md, chapter-10.md, chapter-11.md, foreword.md, intro.md) and reconcile the graph.

```bash
seldon paper sync
```

Review output. If it reports unregistered files or missing artifacts, proceed to Step 2.

### Step 2: Register any unregistered artifacts

If `paper sync` didn't auto-register, manually register these artifacts if they aren't already tracked:

- `book/chapter-03.md` — type: Chapter (may already be registered as placeholder; update status to "drafted")
- `book/chapter-10.md` — type: Chapter (may already be registered as placeholder; update status to "drafted")
- `book/chapter-11.md` — type: Chapter (may already be registered as placeholder; update status to "drafted")
- `book/intro.md` — type: Chapter (or FrontMatter — was a placeholder, now has full Introduction content with roadmap)
- `book/foreword.md` — type: FrontMatter (was the Introduction content, now a brief personal note + acknowledgments)
- `handoffs/HANDOFF_2026-03-30-session10.md` — type: Handoff
- `handoffs/HANDOFF_2026-03-30-session11.md` — type: Handoff

For chapters that were placeholders and are now drafted, update their metadata/status accordingly.

### Step 3: Register CC tasks from Session 11

Ensure these CC task files are registered as artifacts if not already:

- `cc_tasks/2026-03-30_foreword_and_introduction.md`
- `cc_tasks/2026-03-30_draft_chapter_03.md`
- `cc_tasks/2026-03-30_addendum_chapter_03_slm_guidance.md`

### Step 4: Update provenance links

Create `derives_from` or `implements` links as appropriate:

- `book/chapter-03.md` derives_from `cc_tasks/2026-03-30_draft_chapter_03.md`
- `book/chapter-03.md` derives_from `cc_tasks/2026-03-30_addendum_chapter_03_slm_guidance.md`
- `book/chapter-10.md` derives_from `cc_tasks/2026-03-30_draft_chapter_10.md`
- `book/chapter-11.md` derives_from `cc_tasks/2026-03-30_draft_chapter_11.md`
- `book/foreword.md` derives_from `cc_tasks/2026-03-30_foreword_and_introduction.md`
- `book/intro.md` derives_from `cc_tasks/2026-03-30_foreword_and_introduction.md`

### Step 5: Verify

```bash
seldon verify --fix
```

Report any issues that `--fix` cannot resolve.

---

## Expected Outcome

- Graph reflects all 14 chapters as drafted (Ch 4 still placeholder content but file exists)
- Handoffs through Session 11 registered
- All CC tasks from Sessions 10–11 registered with provenance links
- `seldon verify` passes clean

---

## Notes

- Ch 4 (`book/chapter-04.md`) remains a placeholder with working notes — do NOT change its status to "drafted." It still needs a design session.
- The CLAUDE.md chapter outline table still says "Data Cleaning & Imputation" for Ch 3. This should be updated to "Data Wrangling & Standardization" — but that's a CLAUDE.md change, which Seldon may handle automatically or may need a separate task. If you can update it during this sync, do so. If not, note it as outstanding.
