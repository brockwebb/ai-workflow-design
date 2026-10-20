# CC Task: Scaffold PDF Build Pipeline from ai4stats Template

**Date:** 2026-03-28
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** `2026-03-28_scaffold_myst_build_system_v2.md` (completed)
**Executor:** Claude Code

---

## Context

The ai4stats PDF pipeline (`scripts/build_pdf.py` + `scripts/typst_header.typ`) is proven and handles MyST→Pandoc→Typst conversion including directive preprocessing, table numbering, figure numbering, admonition conversion, code block escaping, and cover page insertion.

This task adapts that pipeline for ai-workflow-design. The bulk of the code is reusable. Project-specific values need to be parameterized.

**Source:** `/Users/brock/Documents/GitHub/ai4stats/scripts/`

## Instructions

### 1. Copy and adapt `build_pdf.py`

Copy `/Users/brock/Documents/GitHub/ai4stats/scripts/build_pdf.py` to `/Users/brock/Documents/GitHub/ai-workflow-design/scripts/build_pdf.py`.

Apply the following modifications:

#### a. Update docstring
Change:
```python
"""
build_pdf.py — Convert MyST markdown source to PDF via pandoc + typst.

Reads book/myst.yml for TOC order, preprocesses MyST directives into
pandoc-compatible markdown, and runs pandoc with Typst to produce
exports/ai4stats.pdf.

This script is a READ-ONLY consumer of book/*.md. It never modifies source files.
"""
```
To:
```python
"""
build_pdf.py — Convert MyST markdown source to PDF via pandoc + typst.

Reads book/myst.yml for TOC order, preprocesses MyST directives into
pandoc-compatible markdown, and runs pandoc with Typst to produce
exports/ai-workflow-design.pdf.

Adapted from ai4stats build pipeline. This script is a READ-ONLY consumer
of book/*.md. It never modifies source files.
"""
```

#### b. Remove FIGURES_DIR
Delete the line:
```python
FIGURES_DIR = os.path.join(REPO_ROOT, "figures")
```
This project uses `book/images/` and `assets/diagrams/` instead of a top-level `figures/` directory.

#### c. Update cover image config
Replace the cover image block:
```python
# Cover image for PDF (high-res version) — RELATIVE to REPO_ROOT
COVER_IMAGE_REL = "figures/AI-for-Official-Stats-Cover-1200x1600-300dpi.png"
COVER_IMAGE_ABS = os.path.join(REPO_ROOT, COVER_IMAGE_REL)
```
With:
```python
# Cover image for PDF (high-res version) — RELATIVE to REPO_ROOT
# Set to None until cover art is created
COVER_IMAGE_REL = None
COVER_IMAGE_ABS = None
```

#### d. Update UNNUMBERED_FILES
Replace:
```python
UNNUMBERED_FILES = {
    "foreword.md",
    "version.md",
    "intro.md",
    "glossary.md",
    "bibliography.md",
    "book_index.md",
}
```
With:
```python
UNNUMBERED_FILES = {
    "cover.md",
    "intro.md",
    "appendix-principles.md",
    "bibliography.md",
}
```

#### e. Make cover image check conditional
In `main()`, replace:
```python
    if not os.path.exists(COVER_IMAGE_ABS):
        print(f"ERROR: Cover image not found: {COVER_IMAGE_ABS}")
        sys.exit(1)
```
With:
```python
    if COVER_IMAGE_ABS and not os.path.exists(COVER_IMAGE_ABS):
        print(f"ERROR: Cover image not found: {COVER_IMAGE_ABS}")
        sys.exit(1)
    elif not COVER_IMAGE_ABS:
        print("  No cover image configured — PDF will skip cover page")
```

#### f. Make cover page conditional in combined markdown
In `main()`, replace the `cover_raw` block:
```python
    cover_raw = f"""```{{=typst}}
#page(margin: 0pt)[
  #image("{COVER_IMAGE_REL}", width: 100%, height: 100%, fit: "stretch")
]
#outline(depth: 2, indent: 1em)
#pagebreak()
```

"""
```
With:
```python
    if COVER_IMAGE_REL:
        cover_raw = f"""```{{=typst}}
#page(margin: 0pt)[
  #image("{COVER_IMAGE_REL}", width: 100%, height: 100%, fit: "stretch")
]
#outline(depth: 2, indent: 1em)
#pagebreak()
```

"""
    else:
        cover_raw = """```{=typst}
#outline(depth: 2, indent: 1em)
#pagebreak()
```

"""
```

#### g. Update output filename
In `main()`, replace:
```python
    output_pdf = os.path.join(EXPORTS_DIR, "ai4stats.pdf")
```
With:
```python
    output_pdf = os.path.join(EXPORTS_DIR, "ai-workflow-design.pdf")
```

#### h. Update resource path
In the pandoc command, replace:
```python
        f"--resource-path={BOOK_DIR}:{os.path.join(BOOK_DIR, 'images')}:{FIGURES_DIR}:{REPO_ROOT}",
```
With:
```python
        f"--resource-path={BOOK_DIR}:{os.path.join(BOOK_DIR, 'images')}:{os.path.join(REPO_ROOT, 'assets', 'diagrams')}:{REPO_ROOT}",
```

#### i. Update datestamped copy
Replace:
```python
    dated_name = f"ai4stats_{today}.pdf"
```
With:
```python
    dated_name = f"ai-workflow-design_{today}.pdf"
```

#### j. Remove hardcoded figure numbering
Replace the entire `number_figures` function:
```python
def number_figures(text, filename):
    """Add figure numbers. Currently only Chapter 10 has a figure."""
    if filename == "chapter-10.md":
        text = text.replace(
            "![SDL Risk Classification Decision Tree",
            "![Figure 10.1: SDL Risk Classification Decision Tree"
        )
    return text
```
With:
```python
def number_figures(text, filename):
    """Add figure numbers. No figures yet — placeholder for future use."""
    return text
```

#### k. Make write_typst_cover conditional
Replace:
```python
def write_typst_cover():
    """Write a Typst include file for the full-bleed cover page."""
    template_content = f"""// Full-bleed cover page for ai4stats PDF
#page(margin: 0pt)[
  #image("{COVER_IMAGE_REL}", width: 100%, height: 100%, fit: "stretch")
]
#pagebreak()
"""
    path = os.path.join(SCRIPTS_DIR, "typst_cover.typ")
    with open(path, "w") as f:
        f.write(template_content)
    return path
```
With:
```python
def write_typst_cover():
    """Write a Typst include file for the full-bleed cover page."""
    if not COVER_IMAGE_REL:
        return None
    template_content = f"""// Full-bleed cover page for PDF
#page(margin: 0pt)[
  #image("{COVER_IMAGE_REL}", width: 100%, height: 100%, fit: "stretch")
]
#pagebreak()
"""
    path = os.path.join(SCRIPTS_DIR, "typst_cover.typ")
    with open(path, "w") as f:
        f.write(template_content)
    return path
```

#### l. Update intro processing
Replace `strip_cover_image_from_intro` function body to handle the new intro format. Since ai-workflow-design's intro.md won't have a cover image embedded, simplify to:
```python
def strip_cover_image_from_intro(text):
    """Remove cover image from intro.md if present (for PDF, cover is separate)."""
    return text
```

#### m. Update print banner
Replace:
```python
    print("AI for Official Statistics -- PDF Build (pandoc + typst)")
```
With:
```python
    print("AI Workflow Design -- PDF Build (pandoc + typst)")
```

### 2. Copy `typst_header.typ`

Copy `/Users/brock/Documents/GitHub/ai4stats/scripts/typst_header.typ` to `/Users/brock/Documents/GitHub/ai-workflow-design/scripts/typst_header.typ`.

No modifications needed — the running headers, heading styles, table styling, and admonition formatting are all generic.

### 3. Create empty `scripts/table_inventory.json`

```json
[]
```

### 4. Create empty `scripts/table_map.yaml`

```yaml
# Table column width overrides for PDF export
# See ai4stats/scripts/table_map.yaml for format reference
tables: []
```

### 5. Add `scripts/` gitignore note

In `.gitignore`, the `scripts/` comment line is already present but commented out. Leave it as-is — for this project, scripts should be tracked in git (unlike ai4stats where `build_pdf.py` was gitignored).

### 6. Register artifacts with Seldon

Register:
- `scripts/build_pdf.py` — type: Script
- `scripts/typst_header.typ` — type: ConfigFile
- `scripts/table_inventory.json` — type: DataFile
- `scripts/table_map.yaml` — type: ConfigFile

Create a `derives_from` link from `scripts/build_pdf.py` to note its origin from ai4stats.

---

## Verification

1. `cd /Users/brock/Documents/GitHub/ai-workflow-design && python scripts/build_pdf.py` runs without error (PDF output will be mostly empty but pipeline should complete)
2. Output at `exports/ai-workflow-design.pdf`
3. No references to "ai4stats" remain in the adapted files (except the docstring noting provenance)
4. Cover page gracefully skipped when `COVER_IMAGE_REL` is None
5. `typst_header.typ` is identical to ai4stats version

## Notes

- `build_pdf.py` should remain gitignored per ai4stats convention? **Decision needed:** ai4stats gitignored it; this project may want it tracked. The `.gitignore` currently has the scripts line commented out, meaning scripts ARE tracked. Leave as-is unless Brock says otherwise.
- The `strip_blank_first_page` function uses `pypdf` — make sure it's installed (`pip install pypdf`).
- `pandoc` and `typst` must be installed (`brew install pandoc typst`).
