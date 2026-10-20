# Session Handoff: Publication Baseline -- Zenodo v1.0, PDF Pipeline, Post-Publication Fixes

**Date:** 2026-04-08
**Project:** ai-workflow-design
**Prior handoff:** `handoffs/HANDOFF_2026-04-07_all_batches_complete.md`

---

## What Was Accomplished This Session

### 1. Publication Milestone
- Book published to Zenodo as v1.0 (DOI: 10.5281/zenodo.19474659)
- Filename: `webb_2026_ai_workflow_design_v1.0.pdf`
- HTML site live at brockwebb.github.io/ai-workflow-design/
- LinkedIn announcement drafted

### 2. Version Page Added (`8c0e81a8`) -- COMPLETE (retroactive)
- Created `book/version.md` with DOI, version string (v1.0 -- April 8, 2026), living document statement, citation format
- Added to `book/myst.yml` TOC between cover and foreword
- **Process violation:** Written directly by desktop session instead of CC task. Documented retroactively.

### 3. PDF Pipeline Upgrade (`141485ef`) -- COMPLETE (executed by Claude Code)
- Citation conversion: `{cite:t}`/`{cite:p}` → pandoc `@key`/`[@key]` syntax
- Pandoc `--citeproc` and `--bibliography` flags added
- Table inventory populated (15 entries)
- Table map populated (15 entries with custom column widths)
- Figure numbering for all 15 figures
- Landscape + breakable table support
- Colon-fence directive handlers added
- Orphan heading prevention in `typst_header.typ`

### 4. PDF Escape Fix (`9878de46`) -- COMPLETE (executed by Claude Code)
- Sentinel-based dollar escaping (protect `\$`, escape bare `$`, restore)
- Tilde safety net (`\~` → `~`)
- Empty bold header fix for blank first-column cells
- Build now succeeds (was previously failing with Typst `unknown variable: one` error)

### 5. Pre-Publication Fixes (`3f07787a`) -- COMPLETE (executed by Claude Code)
- Bibliography diagnosis and fix
- Index refresh
- Foreword compressed: "On AI-Assisted Authoring" → "On How This Book Was Written" (4 sentences)

### 6. Foreword Addendum Applied
- Removed recursive methodology claim per author direction
- Final text matches ai4stats weight: plain disclosure, no self-mythology

### 7. Ch 14 Cost Count Identified (`464cef8a`) -- PROPOSED
- Line 42 says "four" cost categories; table lists five; later references say "five"
- One-word fix registered, not yet executed

---

## Current State

### Graph
- **2 proposed tasks:**
  - `9206ddfd`: PDF back matter fixes (bibliography placement, index breakability, appendix heading orphan, glossary heading)
  - `464cef8a`: Ch 14 cost count fix ("four" → "five")
- **Zero in-progress tasks**
- **Zero open issues**

### PDF Pipeline Status
- Build succeeds (`python scripts/build_pdf.py` → 184 pages, 69.1 MB)
- **Known remaining rendering issues (covered by `9206ddfd`):**
  - Bibliography/references section placement (currently at very end; functional but may need reordering)
  - Glossary missing `# Glossary` heading (merges visually with preceding section)
  - Index table not breakable (may overflow/compress on page boundaries)
  - "Chapter-to-Principle Mapping" heading orphaned from its landscape table

### Published Artifacts
- Zenodo v1.0: DOI 10.5281/zenodo.19474659
- HTML: brockwebb.github.io/ai-workflow-design/
- GitHub: github.com/brockwebb/ai-workflow-design

---

## Open CC Tasks

| File | ID | Status | Description |
|------|-----|--------|-------------|
| `cc_tasks/2026-04-08_pdf_backmatter_fixes.md` | `9206ddfd` | Proposed | Bibliography placement, index table, appendix orphan, glossary heading |
| `cc_tasks/2026-04-08_pdf_glossary_heading_addendum.md` | (addendum) | -- | Amends `9206ddfd`: add `# Glossary` heading in `process_file()` |
| `cc_tasks/2026-04-08_ch14_cost_count_fix.md` | `464cef8a` | Proposed | "four" → "five" cost categories in Ch 14 lead-in |

### Addenda (amend parent CC tasks, not separately registered)
- `cc_tasks/2026-04-07_prepub_foreword_addendum.md` -- foreword text override (applied)
- `cc_tasks/2026-04-08_pdf_appendix_table_addendum.md` -- landscape table + heading orphan fix (part of `9206ddfd`)
- `cc_tasks/2026-04-08_pdf_glossary_heading_addendum.md` -- glossary heading injection (part of `9206ddfd`)

---

## Deferred Decisions

### PDF Distribution from GitHub
Decision deferred. Options discussed:
1. **GitHub Releases** (recommended): tag releases, attach PDF as asset, link from site. Clean, no repo bloat.
2. **Commit PDF to repo**: simple but bloats git history with 70MB binaries.
3. **GitHub Actions auto-build**: fully automated but requires CI setup for pandoc+typst.
4. **Zenodo only**: zero infrastructure but stale between major uploads.

No action taken. Revisit when the update cadence becomes clear.

### Post-Publication Carry-Forwards (non-blocking)
- Em-dash purge and `\$` escaping for foreword through Ch 2 (Session 17 leftover)
- Ch 3 prose fixes (carried forward)
- `version.md` needs to be added to `UNNUMBERED_FILES` in `build_pdf.py`

### Seldon Repo Tasks (separate project)
- `7e862893`: `outlined` state gate for PaperSection
- `84c880a8`: Build artifact tracking for AD-018
- Enforce run directory convention in auditor agent

---

## Items NOT to Re-flag
All items from prior handoff, plus:
- "On AI-Assisted Authoring" framing (compressed to 4 sentences, retitled)
- Recursive methodology claim (removed per author direction)
- fig-14-01 deletion (completed in prior session)
- 99.5% accuracy mislabel (fixed in prior session)
- Bibliography empty page diagnosis (resolved -- pandoc citeproc generates references)
- `escape_typst()` dollar/tilde bugs (fixed with sentinel pattern)
- Typst `unknown variable: one` build failure (resolved)
