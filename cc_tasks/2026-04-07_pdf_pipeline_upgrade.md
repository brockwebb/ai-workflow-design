# CC Task: PDF Pipeline Upgrade -- build_pdf.py

**Date:** 2026-04-07
**Scope:** `scripts/build_pdf.py`, `scripts/table_inventory.json`, `scripts/table_map.yaml`, `scripts/typst_header.typ`
**Priority:** Publication-blocking
**Reference implementation:** `/Users/brock/Documents/GitHub/ai4stats/scripts/build_pdf.py`

---

## Problem

The current `build_pdf.py` was copy-adapted from ai4stats but is missing critical handlers for content patterns used in this book. The resulting PDF has broken citations (rendered as raw MyST role syntax), unmanaged table widths, unnumbered figures, and unresolved glossary/bibliography directives.

## Diagnosis Summary

From source file analysis of chapters 1, 2, 5, 7, 9, 14, and the glossary:

1. **Citations not resolved.** `{cite:t}` and `{cite:p}` roles appear throughout (Ch 1: 12, Ch 5: 11, Ch 9: 9, Ch 2: 4, Ch 7: 3, plus remaining chapters not yet counted). `process_directives()` has no handler for these. They render as literal `{cite:t}\`key\`` in the PDF.

2. **Tables unmanaged.** `table_inventory.json` and `table_map.yaml` are empty. Ch 9 has 4 tables (32 lines), Ch 14 has 4 tables (30 lines), Ch 5 and Ch 7 have smaller tables. The wide tables in Ch 9 (5-column diagnostic table) and Ch 14 (cost comparison, cost taxonomy) will overflow default column widths.

3. **Figures unnumbered.** `number_figures()` is a no-op. 15 deployed figures need PDF numbering (fig-01-01a through fig-13-01).

4. **Glossary directive unhandled.** The glossary uses `\`\`\`{glossary}` with definition list format (term + `: definition`). Current `convert_glossary()` strips the directive wrapper but doesn't format the definition list for pandoc/Typst.

5. **Bibliography directive unhandled.** The `\`\`\`{bibliography}\`\`\`` directive in `bibliography.md` will pass through as-is. Pandoc with `--citeproc` will generate its own bibliography section, but only if citations are converted to pandoc syntax first.

6. **`\$` escaping.** Chapter 14 has `\$` throughout for currency values. The `escape_typst()` function escapes bare `$` to `\$`, which means already-escaped `\$` will become `\\$`. Need to handle the double-escape case.

---

## Required Changes

### 1. Citation Resolution

Add pandoc citeproc support. Two-part fix:

**Part A -- Convert MyST citation roles to pandoc syntax:**

Add to `process_directives()` (or a new function called after it):

```python
def convert_citations(text):
    """Convert MyST citation roles to pandoc citation syntax.
    
    {cite:t}`key` -> @key  (narrative: "Huang et al. (2024)")
    {cite:p}`key` -> [@key] (parenthetical: "(Huang et al., 2024)")
    {cite:p}`key1;key2` -> [@key1; @key2] (multiple)
    """
    # Narrative citations: {cite:t}`key`
    text = re.sub(r'\{cite:t\}`([^`]+)`', r'@\1', text)
    
    # Parenthetical citations (possibly multiple keys separated by ;)
    def convert_parens(match):
        keys = match.group(1)
        parts = [k.strip() for k in keys.split(';')]
        return '[' + '; '.join(f'@{k}' for k in parts) + ']'
    
    text = re.sub(r'\{cite:p\}`([^`]+)`', convert_parens, text)
    return text
```

**Part B -- Add pandoc flags:**

In the pandoc command construction, add:
```python
"--citeproc",
f"--bibliography={os.path.join(BOOK_DIR, 'references.bib')}",
```

This makes pandoc resolve all `@key` references against `references.bib` and auto-generate a bibliography section at the end. The `bibliography.md` page's `{bibliography}` directive should be stripped (pandoc will produce its own).

### 2. Table Inventory and Map

**Step A -- Populate `table_inventory.json`:**

Write a script (or inline logic) that scans all chapter files for markdown tables (lines starting with `|`) and records each table's file, header row, and column count. Use the same format as ai4stats: `[{"file": "chapter-09.md", "header_match": "Sub-dimension | Shorthand | What It Checks"}, ...]`

**Step B -- Populate `table_map.yaml`:**

For wide tables that need custom column widths, add entries. Known problem tables:

```yaml
tables:
  # Ch 9: SFV sub-dimensions (3 cols, 3rd col is wide)
  - header_match: "Sub-dimension | Shorthand | What It Checks"
    columns: ["1.5fr", "0.8fr", "3fr"]
  
  # Ch 9: SFV threats to classical validity (3 cols)
  - header_match: "SFV Threat Active | Classical Validity Compromised | Why"
    columns: ["1.5fr", "1.5fr", "3fr"]
  
  # Ch 9: Practice cross-reference (4 cols)
  - header_match: "Practice | Chapter | Addresses | Mechanism"
    columns: ["1.5fr", "0.7fr", "0.8fr", "3fr"]
  
  # Ch 9: Diagnostic table (3 cols, all wide)
  - header_match: "Observable Symptom | Most Likely Threat(s) | First Investigation Step"
    columns: ["2fr", "1.5fr", "2.5fr"]
  
  # Ch 14: Cost comparison (3 cols)
  - header_match: " | AI Pipeline | Manual Equivalent"
    columns: ["1.5fr", "2.5fr", "2.5fr"]
  
  # Ch 14: Cost taxonomy (3 cols)
  - header_match: "Cost Category | What It Includes | Who Cares"
    columns: ["1.5fr", "3fr", "2fr"]
  
  # Ch 14: Model tier (4 cols)
  - header_match: "Model Tier | Relative Cost per Token | Est. Cost for 50K Records | When to Use"
    columns: ["1.2fr", "1.2fr", "1.2fr", "2.5fr"]
  
  # Ch 14: API vs fine-tuning (3 cols)
  - header_match: "Cost Category | API Path | Fine-Tuning Path"
    columns: ["1.2fr", "2.5fr", "2.5fr"]
```

Additional tables in other chapters (Ch 5, Ch 7, appendix) should be inventoried but may work fine with default `1fr` columns. Inspect during build and adjust as needed.

### 3. Figure Numbering

Replace the no-op `number_figures()` with a function that adds figure numbers based on the figure registry. The 15 deployed figures and their chapter assignments:

```
fig-01-01a -> Figure 1.1a (Ch 1)
fig-01-01b -> Figure 1.1b (Ch 1)
fig-02-01  -> Figure 2.1 (Ch 2)
fig-03-01  -> Figure 3.1 (Ch 3)
fig-04-01  -> Figure 4.1 (Ch 4)
fig-05-01  -> Figure 5.1 (Ch 5)
fig-05-02  -> Figure 5.2 (Ch 5)
fig-05-03  -> Figure 5.3 (Ch 5)
fig-06-01  -> Figure 6.1 (Ch 6)
fig-06-02  -> Figure 6.2 (Ch 6)
fig-06-03  -> Figure 6.3 (Ch 6)
fig-07-02  -> Figure 7.1 (Ch 7)
fig-07-03  -> Figure 7.2 (Ch 7)
fig-11-01  -> Figure 11.1 (Ch 11)
fig-13-01  -> Figure 13.1 (Ch 13)
```

Implementation approach: after `convert_myst_figure()` has converted `\`\`\`{figure}` directives to `![caption](path)`, scan for image references containing known figure filenames and prepend the figure number to the alt text / caption. E.g., `![Parallel Consensus](images/fig-05-01_parallel_consensus.png)` becomes `![Figure 5.1: Parallel Consensus](images/fig-05-01_parallel_consensus.png)`.

### 4. Glossary Formatting

The `convert_glossary()` function currently just strips the directive wrapper. The glossary uses MyST definition list format:

```
term
: Definition text here.
```

Pandoc supports definition lists natively, so stripping the `\`\`\`{glossary}` wrapper and leaving the content should work IF the definition list syntax is pandoc-compatible. Verify this renders correctly. If not, convert to a simple bold-term + indented-definition format:

```
**term**
: Definition text here.
```

### 5. Bibliography Handling

Strip the `\`\`\`{bibliography}\`\`\`` directive from `bibliography.md`. Pandoc's `--citeproc` will auto-generate a References section at the end of the combined document. The bibliography page should become either:
- A `# Bibliography` heading only (pandoc places references after it), OR
- Stripped entirely from the TOC for PDF (references appear at the end naturally)

Test both approaches and pick whichever renders cleaner.

### 6. Double-Escape Fix for `\$`

The `escape_typst()` function currently does:
```python
text = text.replace('$', '\\$')
```

This will double-escape already-escaped `\$` in chapter source to `\\$`. Fix:
```python
# Escape $ but not already-escaped \$
text = re.sub(r'(?<!\\)\$', r'\\$', text)
```

Apply the same pattern to any other characters that might already be escaped in source.

### 7. UNNUMBERED_FILES Update

Add missing back-matter files:
```python
UNNUMBERED_FILES = {
    "cover.md",
    "foreword.md",
    "intro.md",
    "appendix-principles.md",
    "appendix-security.md",
    "bibliography.md",
    "glossary.md",
    "index.md",
}
```

(Note: this set isn't currently used in the code -- `strip_chapter_number_prefix()` is defined but never called. If chapter headings in the source are already "# Chapter N - Title" format, this may not matter. Verify during build.)

---

## Execution Order

1. Add citation conversion + pandoc `--citeproc` + `--bibliography` flags
2. Fix `escape_typst()` double-escape for `\$`
3. Populate `table_inventory.json` by scanning chapter files
4. Populate `table_map.yaml` with entries above
5. Implement figure numbering
6. Fix glossary rendering
7. Fix bibliography handling
8. Update `UNNUMBERED_FILES`
9. Run build: `cd /path/to/ai-workflow-design && python scripts/build_pdf.py`
10. Inspect output PDF for:
    - Citations rendered as author-year text (not raw `{cite:t}` syntax)
    - Tables fitting within page margins
    - Figures numbered correctly
    - Glossary terms formatted as definition list
    - Bibliography/references section present at end
    - Dollar amounts rendering correctly (not LaTeX math)
    - No blank first page
11. Iterate on table column widths as needed

## Reference Files

- **Working implementation:** `/Users/brock/Documents/GitHub/ai4stats/scripts/build_pdf.py`
- **Working Typst header:** `/Users/brock/Documents/GitHub/ai4stats/scripts/typst_header.typ` (identical to this project's)
- **Working table map example:** `/Users/brock/Documents/GitHub/ai4stats/scripts/table_map.yaml`
- **Working table inventory example:** `/Users/brock/Documents/GitHub/ai4stats/scripts/table_inventory.json`
- **BibTeX source:** `book/references.bib`
- **Figure registry:** `book/figure-registry.md`

## Post-execution

- Keep `exports/_combined_DEBUG.md` if build fails -- essential for diagnosing Typst errors
- Run `seldon cc complete cc_tasks/2026-04-07_pdf_pipeline_upgrade.md`
- Do NOT commit `exports/_combined.md` (temp file, cleaned up by script)
- Commit changed files: `scripts/build_pdf.py`, `scripts/table_inventory.json`, `scripts/table_map.yaml`, and the output PDF
