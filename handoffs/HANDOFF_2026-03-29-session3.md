# Handoff: AI Workflow Design — Session 3

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Build System Scaffolded (MyST)

Decision made: MyST, matching ai4stats. Jupyter Book rejected (opinionated wrapper, no added value). Quarto rejected (would mean learning new book workflow for no gain).

Three CC tasks written and executed:

1. **`2026-03-28_scaffold_myst_build_system_v2.md`** — EXECUTED
   - Created `book/myst.yml` with 14-chapter TOC, Typst PDF export config
   - Created `book/cover.md` and `book/intro.md` placeholders
   - Created `.github/workflows/deploy.yml` (GitHub Pages deploy, identical to ai4stats)
   - Updated `.gitignore` with `book/_build/`
   - Note: This task also cleaned up uncontrolled writes that were mistakenly made directly to disk earlier in the session (before Brock corrected the workflow). Claude must ONLY write CC task files to the managed repo — all other file operations go through CC task execution via Claude Code.

2. **`2026-03-28_addendum_update_claudemd_build_system.md`** — EXECUTED
   - Updated CLAUDE.md Build System section from "TBD" to MyST details
   - Removed build system and license from open questions
   - License locked as CC BY 4.0

3. **`2026-03-28_scaffold_pdf_build_pipeline.md`** — EXECUTED
   - Copied and adapted `build_pdf.py` from ai4stats
   - Copied `typst_header.typ` verbatim
   - Created empty `table_inventory.json` and `table_map.yaml` stubs
   - Cover image handling made conditional (graceful skip when no cover)
   - Output filename changed to `ai-workflow-design.pdf`
   - Hardcoded figure numbering removed (placeholder function)

### Cover Art Created

Explored multiple approaches and styles:
- Started with risograph on cream background (DALL-E) — too busy, too symmetric
- Tried PaperBanana — produced interesting results but "makes no sense as an actual process"
- Pivoted to retro groovy color band style on dark navy background — breakthrough direction
- Final selection: diagonal sweep of color bands (steel blue, terracotta, sage green, orange) with circuit/flowchart detail, dark navy background

**Cover art deployed:**
- `exports/aiwf4os.png` — original DALL-E output (archival)
- `book/images/cover-web.png` — web version with title text
- `book/images/cover-print.png` — print version with title text

CC tasks written and executed:
4. **`2026-03-29_generate_cover_art_paperbanana.md`** — EXECUTED (experimental, output not used for final cover)
5. **`2026-03-29_deploy_cover_art.md`** — EXECUTED

### Critical Workflow Correction

**Claude was corrected mid-session for writing files directly to a Seldon-managed repo.** The rule, restated:
- Claude writes CC task files to `cc_tasks/` — this is the ONLY direct write permitted
- All other file creation/modification goes through CC task execution in Claude Code
- This is non-negotiable. Seldon must track artifacts from creation.

### Minor Corrections
- Brock does his own GIMP work for cover design — not a partner
- 508 compliance is not required for a book cover (it's art)
- PaperBanana is viable for book figures but not optimal for decorative cover art (designed for academic diagrams)

## Current State of the Repo

### Build Infrastructure (COMPLETE)
| Component | Status |
|-----------|--------|
| `book/myst.yml` | Created, 14-chapter TOC |
| `.github/workflows/deploy.yml` | Created, matches ai4stats |
| `scripts/build_pdf.py` | Adapted from ai4stats, conditional cover |
| `scripts/typst_header.typ` | Copied from ai4stats verbatim |
| `scripts/table_inventory.json` | Empty stub |
| `scripts/table_map.yaml` | Empty stub |
| `.gitignore` | Updated with `book/_build/` |
| CLAUDE.md Build System section | Updated, no longer TBD |

### Cover Art (COMPLETE for now)
| File | Status |
|------|--------|
| `exports/aiwf4os.png` | Archival source (raw DALL-E) |
| `book/images/cover-web.png` | Deployed with title text |
| `book/images/cover-print.png` | Deployed with title text |

### Chapter Files
| File | Status |
|------|--------|
| `book/chapter-01.md` through `chapter-14.md` | Placeholders with working notes |
| `book/appendix-principles.md` | Tenets, principles, 14-chapter mapping |
| `book/bibliography.md` | Empty placeholder |
| `book/figure-registry.md` | Created, fig-01-01 entry |
| `book/cover.md` | Cover page with image reference |
| `book/intro.md` | Placeholder intro |

### CC Tasks on Disk (11 files)
All executed:
- `2026-03-27_project_initialization.md`
- `2026-03-28_addendum_12_chapter_structure.md`
- `2026-03-28_addendum_14_chapter_structure.md`
- `2026-03-28_addendum_brainstorm_material.md`
- `2026-03-28_addendum_figure_registry_and_brainstorm.md`
- `2026-03-28_addendum_principles_and_tenets.md`
- `2026-03-28_addendum_update_claudemd_build_system.md`
- `2026-03-28_scaffold_myst_build_system_v2.md`
- `2026-03-28_scaffold_pdf_build_pipeline.md`
- `2026-03-29_deploy_cover_art.md`
- `2026-03-29_generate_cover_art_paperbanana.md`

## What's Next

1. **Write Chapter 1: Why Design Matters** — All material queued in chapter-01.md working notes. The Hadoop parallel, the systems engineering gap, workflow decomposition thesis, tenets/principles introduction, and fig-01-01. This is the priority.
2. **Render fig-01-01** — "Naive vs Designed Single Stage" two-panel figure. Spec at `assets/diagrams/fig-01-01_naive_vs_designed.md`. PaperBanana is the right tool for this (it's a technical diagram, not decorative art).
3. **Gather source material for Ch 1** — Pull from concept mapper, ai4stats, AI Agents 101, Medium article.
4. **Enable GitHub Pages** — Toggle in repo settings: Settings → Pages → Source → GitHub Actions. Manual step.

## Open Questions

- Code examples vs prose-only
- Medium article location (referenced as source material but not yet located)
- fig-01-01 rendering method confirmed as PaperBanana (but untested for this type of diagram)

## Session Notes

- `str_replace` does not work on Brock's filesystem. Read → modify → write pattern required.
- `bash_tool` runs on Claude's container, not Brock's machine.
- `github:create_or_update_file` prohibited on Seldon-managed repos.
- Claude writes ONLY CC task files to `cc_tasks/`. Everything else through Claude Code execution.
- Neo4j MCP → Arnold database only. Don't use for Seldon graph queries.
- Brock executes CC tasks as produced, not queued.
- Filesystem MCP tools can deload mid-session — if `Filesystem:write_file` disappears, use `tool_search` to reload or write to container and have Brock copy manually.
- PaperBanana: good for technical diagrams, not for decorative art. Known config issue: use `gemini-3.1-pro-preview` (not `gemini-3.1-pro`).
