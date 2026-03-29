# CC Task: Scaffold MyST Build System and GitHub Pages Deploy

**Date:** 2026-03-28
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Scope:** Clean up uncontrolled writes, then create `book/myst.yml`, GitHub Pages deploy workflow, and front matter files under Seldon control
**Executor:** Claude Code

---

## Context

The ai4stats book uses MyST (`mystmd`) for HTML site builds and Typst-based PDF export. This task replicates that proven pattern for ai-workflow-design.

**Reference:** ai4stats config at `/Users/brock/Documents/GitHub/ai4stats/book/myst.yml` and deploy at `/Users/brock/Documents/GitHub/ai4stats/.github/workflows/deploy.yml`.

## Step 0: Clean Up Uncontrolled Writes

The following files were incorrectly written directly to disk outside CC discipline. Delete them so this task recreates them under Seldon control:

- `book/myst.yml`
- `book/cover.md`
- `book/intro.md`
- `.github/workflows/deploy.yml`
- `.github/workflows/` (directory)
- `.github/` (directory, if empty after above)

Also revert `.gitignore`: remove the two lines `# MyST build output` and `book/_build/` that were inserted between the `exports/_debug_output.typ` line and the `# Environment` line. Leave everything else intact.

Delete `cc_tasks/2026-03-28_scaffold_myst_build_system.md` — that was also an uncontrolled write. This file (`2026-03-28_scaffold_myst_build_system_v2.md`) replaces it.

---

## Step 1: Create `book/myst.yml`

```yaml
version: 1
project:
  title: 'AI Workflow Design for Official Statistics'
  authors:
    - name: Brock Webb
  github: brockwebb/ai-workflow-design
  jupyter: false
  exports:
    - format: typst
      template: plain_typst_book
      output: exports/ai-workflow-design.pdf
  toc:
    - file: cover.md
    - file: intro.md
    - file: chapter-01.md
    - file: chapter-02.md
    - file: chapter-03.md
    - file: chapter-04.md
    - file: chapter-05.md
    - file: chapter-06.md
    - file: chapter-07.md
    - file: chapter-08.md
    - file: chapter-09.md
    - file: chapter-10.md
    - file: chapter-11.md
    - file: chapter-12.md
    - file: chapter-13.md
    - file: chapter-14.md
    - file: appendix-principles.md
    - file: bibliography.md
site:
  options:
    folders: true
  template: book-theme
```

No `logo.png` reference — add later when a logo exists.

## Step 2: Create `book/cover.md`

```markdown
# AI Workflow Design for Official Statistics

*Brock Webb*

---

A practical guide to designing reliable AI/LLM workflows for statistical research and official statistics production.
```

## Step 3: Create `book/intro.md`

```markdown
# Introduction

<!-- STATUS: Placeholder -->

This book teaches the design discipline behind reliable AI-powered data processing pipelines. Where *AI for Official Statistics* introduced what AI is and how to evaluate it, this book is for the people who are building.
```

## Step 4: Create `.github/workflows/deploy.yml`

Create directories `.github/` and `.github/workflows/`, then the file:

```yaml
name: deploy-book

on:
  push:
    branches: [main]
  workflow_dispatch:

env:
  BASE_URL: /${{ github.event.repository.name }}

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: 'pages'
  cancel-in-progress: false

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Pages
        uses: actions/configure-pages@v3

      - uses: actions/setup-node@v4
        with:
          node-version: 20.x

      - name: Install MyST Markdown
        run: npm install -g mystmd

      - name: Build HTML Assets
        working-directory: book
        run: myst build --html

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: book/_build/html

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## Step 5: Append to `.gitignore`

Add the following lines after the `exports/_debug_output.typ` line:

```
# MyST build output
book/_build/
```

## Step 6: Register artifacts with Seldon

Register all new files:
- `book/myst.yml` — type: ConfigFile
- `book/cover.md` — type: Document
- `book/intro.md` — type: Document
- `.github/workflows/deploy.yml` — type: ConfigFile

---

## Verification

1. `cd book && myst build --html` completes (warnings about empty chapters expected)
2. `myst.yml` TOC matches all 14 chapters plus front/back matter
3. `.github/workflows/deploy.yml` exists
4. `book/_build/` is gitignored
5. All uncontrolled files from Step 0 are gone or replaced

## Post-Execution Manual Step

Enable GitHub Pages in repo settings: Settings → Pages → Source → GitHub Actions.
