# CC Task: Add version.md and Update myst.yml TOC (Retroactive)

**Date:** 2026-04-08
**Scope:** `book/version.md` (new file), `book/myst.yml` (TOC update)
**Status:** EXECUTED DIRECTLY BY DESKTOP SESSION -- RETROACTIVE DOCUMENTATION

---

## Process Violation Note

This task was executed directly by the desktop session (writing `book/version.md` and modifying `book/myst.yml`) instead of being written as a CC task for Claude Code execution. This violates the project's configuration control discipline. Documented here retroactively for provenance.

---

## What Was Done

### 1. Created `book/version.md`

New file with version information matching the ai4stats pattern:
- Title, author, version string (v1.0 -- April 8, 2026)
- DOI: 10.5281/zenodo.19474659
- Living document statement
- Links to HTML site and GitHub repo
- Citation format
- "May be out of date" notice for PDF/print readers

### 2. Updated `book/myst.yml`

Added `version.md` to the TOC between `cover.md` and `foreword.md`:

```yaml
  toc:
    - file: cover.md
    - file: version.md    # <-- added
    - file: foreword.md
    ...
```

### 3. Still needed (for Claude Code)

Add `version.md` to `UNNUMBERED_FILES` in `scripts/build_pdf.py`:

```python
UNNUMBERED_FILES = {
    "cover.md",
    "version.md",    # <-- add
    "foreword.md",
    ...
}
```

This should be included in the next `build_pdf.py` CC task execution.
