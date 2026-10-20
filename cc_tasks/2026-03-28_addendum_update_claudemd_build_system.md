# CC Task Addendum: Update CLAUDE.md Build System and Open Questions

**Date:** 2026-03-28
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** `2026-03-28_scaffold_myst_build_system_v2.md` (completed)
**Executor:** Claude Code

---

## Context

The build system decision has been made: MyST (matching ai4stats). CLAUDE.md still says "TBD" for the build system and lists it as an open question. This task updates CLAUDE.md to reflect the decision.

## Instructions

### 1. Update Build System section in `CLAUDE.md`

Replace the current Build System block:

```
## Build System

TBD — will prototype PDF pipeline early (lesson from ai4stats). Likely Jupyter Book or Quarto. Decision deferred until chapter 1 draft exists.
```

With:

```
## Build System

**MyST** (`mystmd`) — matching ai4stats.

- HTML site: `cd book && myst build --html` → `book/_build/html/`
- PDF export: Typst via `myst build --pdf` (template: `plain_typst_book`, output: `exports/ai-workflow-design.pdf`)
- GitHub Pages: `.github/workflows/deploy.yml` deploys on push to `main` (requires Pages source set to "GitHub Actions" in repo settings)
- Config: `book/myst.yml`
- License: CC BY 4.0
```

### 2. Update Open Questions in `CLAUDE.md`

In the Related Projects section or wherever open questions are tracked, remove:
- "Build system decision (Jupyter Book vs Quarto)" — resolved: MyST
- "License (likely CC BY 4.0)" — resolved: CC BY 4.0

Keep any remaining open questions intact.

### 3. Register this update with Seldon

Update the existing `CLAUDE.md` artifact to reflect the modification.

---

## Verification

1. `CLAUDE.md` Build System section no longer says "TBD"
2. No references to "Jupyter Book" or "Quarto" remain as pending decisions in CLAUDE.md
3. License is stated as CC BY 4.0 (not "likely")
