# Addendum: Appendix Table Layout Fix

**Date:** 2026-04-08
**Amends:** `cc_tasks/2026-04-07_pdf_pipeline_upgrade.md`

---

## Additional Fix: Chapter-to-Principle Mapping Table (appendix-principles.md)

### Problem

The "Chapter-to-Principle Mapping" table in the appendix has three issues in the PDF:

1. **Orphaned heading** -- the section heading "Chapter-to-Principle Mapping" renders at the bottom of a page; the table starts on the next page.
2. **Column cramming** -- the Chapter column (e.g., "Ch 10: State Mgmt & Provenance") wraps to 3 lines in portrait orientation, wasting vertical space.
3. **Table overflow** -- `md_table_to_typst()` wraps all tables in `#block(breakable: false)`. A 14-row table that exceeds one page gets shoved/overlaps instead of breaking.

### Fix

This table needs special handling in `build_pdf.py`. Two changes:

**1. Add to `table_map.yaml`:**

```yaml
  # Appendix: Chapter-to-Principle Mapping (3 cols, landscape, breakable)
  - header_match: "Chapter | Primary Working Principle(s) | Primary Tenet(s)"
    columns: ["2fr", "3fr", "3fr"]
    landscape: true
    breakable: true
```

**2. Update `md_table_to_typst()` to support landscape and breakable options:**

The function currently hard-codes `#block(breakable: false)`. Add optional parameters:

```python
def md_table_to_typst(header_cells, data_rows, columns, caption=None, 
                       breakable=False, landscape=False):
```

When `landscape=True`, wrap the entire block in:
```typst
#page(flipped: true)[
  ... table content ...
]
```

When `breakable=True`, use `#block(breakable: true)` instead of `false`.

**3. Update `apply_table_map()` to pass these options through:**

Read `landscape` and `breakable` from the table_map entry and pass to `md_table_to_typst()`:

```python
landscape = entry.get("landscape", False)
breakable = entry.get("breakable", False)
typst_block = md_table_to_typst(
    header_cells, data_rows, entry["columns"], 
    caption=caption, breakable=breakable, landscape=landscape
)
```

### Expected result

The chapter-to-principle mapping renders in landscape orientation with comfortable column widths. Chapter names fit on one line. Table can break across pages if needed (though in landscape it should fit on one page). The heading stays attached to the table.

### Heading orphan prevention

Add a Typst show rule to `typst_header.typ` that prevents headings from appearing alone at the bottom of a page:

```typst
// Prevent orphaned headings (heading at bottom of page with no following content)
#show heading: set block(below: 1.5em, above: 2em, breakable: false)
```

This keeps the heading attached to whatever follows it. Test to ensure this doesn't create awkward spacing elsewhere.
