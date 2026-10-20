# CC Task: Pre-Publication Fixes -- Bibliography, Index Refresh, Foreword Compression

**Date:** 2026-04-07
**Scope:** `book/bibliography.md`, `book/index.md`, `book/foreword.md`, `book/myst.yml` (read-only diagnosis)
**Priority:** Publication-blocking (bibliography); publication-polish (index, foreword)

---

## Task 1: Diagnose and Fix Empty Bibliography Page

The `bibliography.md` page renders empty on the deployed site despite correct `{bibliography}` directive syntax and a populated `references.bib` with 80+ entries.

### Diagnosis steps (execute in order):

1. Run `myst clean --all` in `book/` to clear build cache
2. Run `myst build --html` and capture full build log
3. Search build log for:
   - Any warnings/errors mentioning `bibliography`, `bibtex`, `references.bib`, or `cite`
   - Whether individual page builds show citation resolution (look for "resolving citations" or similar)
4. Check the built HTML at `book/_build/html/bibliography.html` -- is it truly empty, or does it have content that just isn't rendering?
5. Check whether MyST is auto-rendering references at the bottom of each chapter page instead of aggregating to bibliography.md

### Fix paths (try in order):

**Path A -- Cache/build issue:** If `myst clean --all` + rebuild fixes it, done.

**Path B -- MyST directive syntax:** Current directive is bare:
```
\`\`\`{bibliography}
\`\`\`
```
Try adding explicit source reference:
```
\`\`\`{bibliography}
:style: unsrt
\`\`\`
```
Or try the filter option to show all entries:
```
\`\`\`{bibliography}
:all:
\`\`\`
```

**Path C -- Fallback to rendered markdown:** If the `{bibliography}` directive cannot be made to work with current mystmd, generate a hand-formatted markdown bibliography from `references.bib` (grouped by topic or alphabetical by key). This is the ai4stats approach and is known to render correctly. The `.bib` file remains the source of truth for in-text citation resolution; the bibliography page becomes a rendered projection.

### Acceptance criteria:
- Bibliography page shows all cited references when deployed
- In-text citations (`{cite:t}`, `{cite:p}`) still resolve correctly in chapter pages
- Both HTML and PDF builds pass clean

---

## Task 2: Index Refresh

Systematic pass through all 14 chapters to update `book/index.md`.

### Process:

1. Read current `book/index.md` to get the existing keyword list
2. For each chapter (01-14), grep for key terms and concepts that are substantively discussed (not just mentioned in passing)
3. Cross-reference against the existing index:
   - **Add** terms introduced during sweep batches (F, I, K) or earlier sessions that were never indexed
   - **Remove** terms that no longer appear substantively in any chapter
   - **Update** chapter numbers if terms moved or were removed from specific chapters
4. Pay particular attention to terms from recent insertions:
   - "model mix" / model selection per pipeline stage (Ch 14)
   - "format normalization" / preprocessing as infrastructure (Ch 6)
   - "automated resolution rate" (Ch 2, Ch 14)
   - "author experience" framing additions (Ch 1, 2, 6, 9)
   - Any terms from Batch I structural additions (Ch 4, 8, 13, 14)

### Format rules:
- Alphabetical by keyword
- Chapter numbers only (no page numbers, no section references)
- Only include terms that are substantively discussed, not passing mentions
- Use pipe-separated table format matching current structure

### Acceptance criteria:
- Every keyword in the index maps to at least one chapter where it is substantively discussed
- No stale entries pointing to chapters where the term no longer appears
- New terms from sweep batches are represented

---

## Task 3: Foreword -- Compress "On AI-Assisted Authoring"

### Current state:
The "On AI-Assisted Authoring" section in `book/foreword.md` is 3 paragraphs (~200 words) that over-explain the AI-assisted authoring process. The ai4stats foreword covered the same ground in 4 sentences.

### Change:

**Retitle** the section from "On AI-Assisted Authoring" to "On How This Book Was Written"

**Replace** the entire 3-paragraph section content with:

> This book was designed and authored using the same discipline it teaches. The intellectual architecture, editorial decisions, and all judgment calls are the author's. AI tools did execution work: drafting prose from detailed specifications, research assistance, citation verification, and build automation. This is itself a design decision consistent with the book's philosophy.

### Do NOT change:
- The "A note on product references" paragraph that follows -- keep as-is
- The "Acknowledgments" section -- keep as-is
- Any other foreword sections

### Rationale:
The current version protests too much. Three paragraphs explaining the CC task pipeline to the reader is inside baseball. The compressed version makes the credibility claim (recursive methodology) in sentence one and gets out. The reader will encounter the methodology in Chapter 10.

### Acceptance criteria:
- Section title is "On How This Book Was Written"
- Section body is exactly the 4 sentences above
- "A note on product references" paragraph unchanged
- Acknowledgments section unchanged
- No em-dashes introduced

---

## Execution order:
1. Task 3 (foreword) -- fastest, no diagnosis needed
2. Task 1 (bibliography) -- diagnose first, then fix
3. Task 2 (index) -- most labor-intensive, do last

## Post-execution:
- Run `seldon verify` before commit
- Run `seldon cc complete cc_tasks/2026-04-07_prepub_bibliography_index_foreword.md`
- Commit all changes with message: "Pre-publication fixes: bibliography, index refresh, foreword compression"
