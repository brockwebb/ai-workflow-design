# CC Task: Fix PDF Back Matter -- References Placement, Index Rendering, Appendix Orphan

**Date:** 2026-04-08
**Scope:** `scripts/build_pdf.py`
**Priority:** Publication-blocking (rendering defects in final ~20 pages)

---

## Problem 1: References/Bibliography Appear After Index

### Cause

Pandoc `--citeproc` auto-generates a references section and appends it at the **end of the entire document**. The TOC order in `myst.yml` is:

```
... appendix-security.md → bibliography.md → glossary.md → index.md
```

`process_directives()` strips the `{bibliography}` directive from `bibliography.md`, leaving just the `# Bibliography` heading. Pandoc then appends its citeproc-generated references after the last content -- which is the Index. So the rendered PDF shows:

```
Bibliography (empty page with just heading)
Glossary
Index
[pandoc-generated references dumped here]
```

### Fix

Move the Index and Glossary BEFORE the Bibliography in the combined markdown, so pandoc's auto-appended references land in the right place. Do this in `main()` after processing files but before joining:

```python
# Reorder back matter: Index and Glossary before Bibliography
# so pandoc's --citeproc references append after the Bibliography heading
back_matter_order = {
    "glossary.md": None,
    "index.md": None, 
    "bibliography.md": None,
}

# Extract back matter files from combined_md
reordered_md = []
for filename, content in zip(toc_files_processed, combined_md):
    if filename in back_matter_order:
        back_matter_order[filename] = content
    else:
        reordered_md.append(content)

# Append in desired order: glossary, index, bibliography (last, so references land here)
for key in ["glossary.md", "index.md", "bibliography.md"]:
    if back_matter_order.get(key) is not None:
        reordered_md.append(back_matter_order[key])

combined_md = reordered_md
```

This requires tracking filenames alongside processed content. Modify the processing loop to store `(filename, content)` tuples, or maintain a parallel list.

**Alternative simpler fix:** Change the TOC order in `myst.yml` to put `bibliography.md` last. But that changes the HTML site order too. Better to handle it in `build_pdf.py` only.

**Simplest fix:** Just reorder in the `myst.yml` toc -- put `bibliography.md` after `index.md`. The HTML site order change is minor (bibliography is last in the sidebar instead of second-to-last). This is probably fine.

Actually, the cleanest approach: in `main()`, after building `combined_md`, find the bibliography entry and move it to the end:

```python
# Track which index in combined_md corresponds to which file
# so we can reorder back matter
```

OR, even simpler: don't use pandoc's auto-append at all. Instead, generate a references section manually by reading `references.bib` and formatting it. But that's a lot of work.

**Recommended fix:** Reorder the processing so `bibliography.md` is processed LAST, regardless of `myst.yml` order. Add to `main()` after building the `toc_files` list:

```python
# Ensure bibliography.md is last so citeproc references append there
if "bibliography.md" in toc_files:
    toc_files.remove("bibliography.md")
    toc_files.append("bibliography.md")
```

This is 3 lines. It ensures the Bibliography heading is the last section in the combined markdown, so pandoc's citeproc references appear under it.

---

## Problem 2: Index Table Rendering

### Cause

The Index (`book/index.md`) is a ~100-row, 2-column markdown table. It's not in `table_map.yaml`, so it doesn't go through `apply_table_map()`. It may go through `inject_table_numbers()` if its header matches an inventory entry, but `table_inventory.json` only has chapter tables. So the index table stays as plain markdown.

Pandoc converts plain markdown tables to Typst tables. The default Typst table rendering may not handle page breaks well for a 100-row table.

### Fix

Add the index table to `table_map.yaml` with `breakable: true`:

```yaml
  # Index: keyword-to-chapter mapping (2 cols, breakable across pages)
  - header_match: "Keyword | Chapters"
    columns: ["3fr", "1fr"]
    breakable: true
```

Also add it to `table_inventory.json`:

```json
{"file": "index.md", "header_match": "Keyword | Chapters"}
```

**IMPORTANT:** Check the actual header text in `book/index.md`. The current index has `| Keyword | Chapters |` -- verify the exact column names and use those in the header_match.

---

## Problem 3: "Chapter-to-Principle Mapping" Heading Orphaned

### Cause

The heading "## Chapter-to-Principle Mapping" is in `appendix-principles.md`. The table that follows is in `table_map.yaml` with `landscape: true`. When `apply_table_map()` replaces the table with a `{=typst}` block containing `#page(flipped: true)[...]`, pandoc sees:

```markdown
## Chapter-to-Principle Mapping

```{=typst}
#page(flipped: true)[
#block(breakable: true)[
#table(...)
]
]
```
```

The `#page(flipped: true)` forces a new page. The heading is on the previous (portrait) page. The `#show heading: set block(breakable: false)` in `typst_header.typ` prevents heading from breaking, but it can't prevent the heading from being orphaned when the NEXT element forces a page break.

### Fix

Move the heading INSIDE the landscape page. Modify `apply_table_map()` (or `md_table_to_typst()`) so that when `landscape=True`, the function also captures the preceding heading and includes it inside the `#page(flipped: true)` block.

**Simpler approach:** In `md_table_to_typst()`, when `landscape=True`, add the section heading as part of the Typst block:

```python
def md_table_to_typst(header_cells, data_rows, columns, caption=None,
                       breakable=False, landscape=False, section_heading=None):
    lines = ["```{=typst}"]
    if landscape:
        lines.append("#page(flipped: true)[")
        if section_heading:
            lines.append(f"#heading(level: 2)[{section_heading}]")
            lines.append("#v(1em)")
    ...
```

And in `apply_table_map()`, when a table has `landscape: true`, look backward in the text for the preceding `##` heading, remove it from the markdown, and pass it as `section_heading`:

```python
if landscape:
    # Find and remove the preceding ## heading so it renders inside the landscape page
    # Look backward from the table position for the nearest ## heading
    preceding_text = text[:table_start_position]
    heading_match = re.search(r'^(## .+)$', preceding_text, re.MULTILINE)
    if heading_match:
        section_heading = heading_match.group(1).lstrip('# ')
        # Remove the heading from the text
        text = text[:heading_match.start()] + text[heading_match.end():]
```

This is tricky because `apply_table_map()` works line-by-line. A simpler approach:

**Simplest approach:** Do a post-processing pass on the combined text. Find any `## heading` immediately followed (within a few blank lines) by a `{=typst}` block containing `#page(flipped: true)`, and move the heading inside the block.

```python
def move_headings_into_landscape(text):
    """Move ## headings into following landscape page blocks."""
    pattern = r'(^## (.+?)$\n\n*)(```\{=typst\}\n#page\(flipped: true\)\[)'
    def replacer(match):
        heading_text = match.group(2)
        typst_start = match.group(3)
        return typst_start + f'\n#heading(level: 2)[{heading_text}]\n#v(1em)\n'
    return re.sub(pattern, replacer, text, flags=re.MULTILINE)
```

Call this after `apply_table_map()` and before writing the combined file.

---

## Execution Order

1. Fix reference placement (reorder `bibliography.md` to be last in processing)
2. Add index table to `table_map.yaml` with `breakable: true`
3. Add index table to `table_inventory.json`  
4. Implement `move_headings_into_landscape()` post-processing
5. Rebuild: `python scripts/build_pdf.py`
6. Verify in PDF:
   - Bibliography/References section appears between Glossary and Index (or after Index, wherever bibliography.md now sits -- the key is references are WITH the bibliography heading, not orphaned)
   - Index table breaks across pages cleanly
   - "Chapter-to-Principle Mapping" heading is on the same landscape page as its table
7. Check table of contents in the PDF matches expected section order

## Post-execution

- `seldon cc complete cc_tasks/2026-04-08_pdf_backmatter_fixes.md`
- Commit: "Fix PDF back matter: reference placement, index breakability, appendix heading"
