# CC Task: Deploy Cover Art Image

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Executor:** Claude Code

---

## Context

Cover art has been selected: retro groovy color band style on dark navy background, with diagonal sweep of steel blue, terracotta, sage green, and orange striped lines alongside circuit/flowchart detail. Generated via DALL-E. Raw file at `exports/aiwf4os.png` (5.5MB).

## Instructions

### 1. Create images directory if needed

```bash
mkdir -p book/images
```

### 2. Copy cover image to book images

```bash
cp exports/aiwf4os.png book/images/cover-web.png
```

Keep the original in `exports/` as the archival source. `book/images/cover-web.png` is the working copy referenced by the build system.

### 3. Create high-res PDF cover version

Create a resized version for PDF export (if needed — the build script handles cover image insertion):
```bash
cp exports/aiwf4os.png book/images/cover-print.png
```

For now both are the same file. Once GIMP work is done (title text overlay, upscaling), replace `cover-web.png` with the web version and `cover-print.png` with the high-res print version.

### 4. Update `book/cover.md`

Replace the placeholder content with:

```markdown
# AI Workflow Design for Official Statistics

```{image} images/cover-web.png
:alt: AI Workflow Design for Official Statistics — Book Cover
:width: 100%
```

*Brock Webb*
```

### 5. Update `book/myst.yml`

Add cover image to the exports config. In the `exports` block, add:

```yaml
  exports:
    - format: typst
      template: plain_typst_book
      output: exports/ai-workflow-design.pdf
      cover: images/cover-web.png
```

### 6. Register with Seldon

- `book/images/cover-web.png` — type: Figure
- `book/images/cover-print.png` — type: Figure
- Note provenance: DALL-E generation, retro color band style, 2026-03-29

---

## Notes

- The image does NOT have title text on it yet. That will be added in GIMP as a separate step. For now the raw art goes in.
- The `cover-web.png` / `cover-print.png` split follows the ai4stats pattern. Web version is for the HTML site, print version is for the PDF with full-bleed cover page.
- `build_pdf.py` (once the scaffold CC task is executed) handles cover insertion into the PDF. The `COVER_IMAGE_REL` variable will need to point to `book/images/cover-print.png` once that script is adapted.
