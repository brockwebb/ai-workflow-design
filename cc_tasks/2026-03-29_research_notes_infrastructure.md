# CC Task: Add Research Notes Folder and Gitignore Entry

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Type:** Infrastructure — Research Notes

---

## Objective

Formalize the `docs/research_notes/` directory as a gitignored staging area for raw research material (deep research reports, literature reviews, notes from external sources). Copy the Feynman method deep research report into it.

## Rationale

Research notes are working material — they inform the book but aren't part of it. They shouldn't be in the public repo. Gitignoring them keeps the repo clean while preserving the material locally for reference during writing.

## Actions

### 1. Add gitignore entry

Append to `.gitignore`:

```
# Research notes (raw material, not for public repo)
docs/research_notes/
```

### 2. Create README in research notes folder

Create `docs/research_notes/README.md`:

```markdown
# Research Notes

Raw research material, deep research reports, literature reviews, and reference notes.
This folder is gitignored — contents are local working material that informs the book
but is not part of the published output.

## Contents

- `2026-03-29_feynman_method_learning_models.md` — Deep research report on Feynman technique, learning models, and application to GenAI systems in federal statistics.
```

### 3. Copy deep research report

Copy the uploaded file to:
`docs/research_notes/2026-03-29_feynman_method_learning_models.md`

Source: uploaded file `deep-research-report.md` (currently at project root or uploads).

## Dependencies

- `.gitignore` (exists)
- `docs/research_notes/` (directory created manually this session)
