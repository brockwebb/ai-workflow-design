# CC Task: Ch 9 Groves Citation

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Target:** `book/chapter-09.md`, `book/references.bib`
**Graph task:** `d9fbc94f` (proposed — close on completion)

---

## Context

Ch 9's SFV-to-classical-validity crosswalk table uses standard validity terminology (construct validity, internal validity, statistical conclusion validity, external validity) without citation. These terms originate from Campbell & Stanley (1963) and were systematized for the survey methodology audience in Groves et al. (2009), *Survey Methodology* (2nd ed., Wiley). For the book's federal statistical agency audience, Groves et al. is the canonical reference for this vocabulary.

The table stands on its own structurally, but the classical validity types need a citation anchor for two reasons: (1) readers who know the terminology expect the standard reference, and (2) readers who don't know it need somewhere to go.

---

## Part A: Add BibTeX Entry

Add to `book/references.bib` in alphabetical order (do not modify existing entries):

```bibtex
@book{groves_2009,
  title = {Survey Methodology},
  author = {Groves, Robert M. and Fowler, Floyd J. and Couper, Mick P. and Lepkowski, James M. and Singer, Eleanor and Tourangeau, Roger},
  year = {2009},
  edition = {2nd},
  publisher = {Wiley},
  isbn = {978-0-470-46546-2},
  series = {Wiley Series in Survey Methodology}
}
```

## Part B: Add Citation to Crosswalk Paragraph

In `book/chapter-09.md`, find the sentence:

> SFV is the precondition the classical validity types assume but do not state.

Change to:

> SFV is the precondition the classical validity types assume but do not state {cite:p}`groves_2009`.

That is the only edit to chapter text. One citation, one sentence.

---

## Verification

1. `groves_2009` exists in `book/references.bib` with correct metadata
2. `book/chapter-09.md` has exactly one `{cite:p}groves_2009` reference
3. No other changes to `chapter-09.md`
4. Run `seldon verify --fix` after edits

## Do NOT

- Add multiple citations or modify any other sentences
- Edit any other chapter files
- Modify existing `references.bib` entries
- Add explanatory text about classical validity (the table already does this)
