# CC Task: Fix PDF Build Failures -- Escape Logic and Table Rendering

**Date:** 2026-04-08
**Scope:** `scripts/build_pdf.py`
**Priority:** Publication-blocking (build currently fails with Typst error)
**Depends on:** Executed CC task `141485ef` (PDF pipeline upgrade)

---

## Problem

The `build_pdf.py` pipeline fails during Typst compilation with:

```
error: unknown variable: one
  ┌─ toPdfViaTempFile19193-0.typ:6693:35
  │
6693 │   [Development cost], [\~\\$3,500 (one-time: pipeline, prompts, evaluation design)], ...
```

The build log (`exports/pandoc_build.log`) also shows 16 Typst warnings about `no text within stars` from empty bold markers `[**]` in table headers.

## Root Cause Analysis

The `_combined_DEBUG.md` file (the combined markdown that `build_pdf.py` writes and pandoc reads) contains incorrect escaping inside `{=typst}` raw blocks:

**What the debug file contains (WRONG):**
```
[Development cost], [\~\\$3,500 (one-time: ...)], [\~\\$800 (one-time: ...)],
[Runtime], [\~2 hours], [\~232 analyst-hours],
```

**What it should contain (CORRECT):**
```
[Development cost], [~\$3,500 (one-time: ...)], [~\$800 (one-time: ...)],
[Runtime], [~2 hours], [~232 analyst-hours],
```

Three distinct bugs:

### Bug 1: Tilde escaping (`~` → `\~`)

The `escape_typst()` function does NOT explicitly escape tildes. Yet the output has `\~` everywhere a `~` appears in table cells. The `~` character in Typst content mode is a non-breaking space and should NOT be escaped -- `\~` is invalid Typst syntax.

**Hypothesis:** Although isolated testing of `escape_typst()` produces correct output, something in the actual execution context (possibly string encoding, the f-string interpolation in `md_table_to_typst`, or an interaction with how Python reads the markdown files) is introducing backslashes before special characters. The exact mechanism was not definitively identified in diagnosis.

**Fix:** Add an explicit tilde preservation step at the end of `escape_typst()`:
```python
# Ensure ~ is never escaped (Typst non-breaking space, valid as-is)
text = text.replace('\\~', '~')
```

### Bug 2: Dollar double-escaping (`\$` → `\\$`)

The source markdown has `\$3,500` (single backslash-dollar, escaped for MyST/LaTeX). The `escape_typst()` regex `r'(?<!\\)\$'` should skip `\$` because the `$` is preceded by `\`. But the debug output shows `\\$` (double backslash-dollar), which means the backslash itself is being escaped or the lookbehind is failing in context.

**Fix:** Replace the dollar escaping regex with a simpler, more robust approach. Since ALL dollar signs in the source are already escaped as `\$` (from the earlier em-dash/dollar sweep), don't try to escape dollars at all. Just verify they're already escaped:

```python
# Dollar signs: source already has \$ everywhere (from prior sweep).
# Do NOT re-escape. If a bare $ somehow appears, escape it.
# But do NOT touch \$ pairs.
text = re.sub(r'(?<!\\)\$', r'\\$', text)  # REMOVE THIS LINE

# Replace with: only escape truly bare $ (no preceding backslash)
# Using a two-step approach that's immune to lookbehind edge cases:
# 1. Temporarily protect \$ pairs
text = text.replace('\\$', '\x00DOLLAR\x00')
# 2. Escape any remaining bare $
text = text.replace('$', '\\$')
# 3. Restore protected \$ pairs
text = text.replace('\x00DOLLAR\x00', '\\$')
```

### Bug 3: Empty bold in table headers (`[**]`)

The Ch 5 topology comparison table and Ch 14 cost comparison table have an empty first column header (the markdown is `| | AI Pipeline | Manual Equivalent |`). After cell extraction, the first cell is an empty string. The header formatting on line 882:

```python
f"[*{escape_typst(c.strip())}*]" if c.strip() else "[]"
```

The `if c.strip() else "[]"` correctly handles empty cells. But the Typst build log shows `[**]` appearing, which means a cell contains ONLY `**` (bold markers with no content between them) rather than being truly empty. This happens when the markdown cell is ` ` (whitespace) rather than truly empty, AND the bold/italic regex doesn't match `**` (no content).

**Fix:** Add a check for cells that are only asterisks:
```python
cleaned = c.strip()
if not cleaned or cleaned in ('**', '***', '*'):
    cell_typst = "[]"
else:
    cell_typst = f"[*{escape_typst(cleaned)}*]"
```

---

## Implementation

### Updated `escape_typst()` function:

```python
def escape_typst(text):
    r"""Escape Typst special characters in table cell / caption content.

    The source markdown already has \$ for dollar signs (from prior sweeps).
    This function handles remaining Typst-special characters.
    """
    # Markdown bold/italic -> Typst equivalents
    text = re.sub(r'\*\*(.+?)\*\*', r'*\1*', text)
    text = re.sub(r'(?<!\*)\*(?!\*)(.+?)(?<!\*)\*(?!\*)', r'_\1_', text)

    # Escape # for Typst content mode
    text = text.replace('#', '\\#')
    
    # Dollar signs: protect existing \$ pairs, escape bare $, restore
    text = text.replace('\\$', '\x00PROTECTED_DOLLAR\x00')
    text = text.replace('$', '\\$')
    text = text.replace('\x00PROTECTED_DOLLAR\x00', '\\$')
    
    # Escape < > @ for Typst content mode
    text = text.replace('<', '\\<')
    text = text.replace('>', '\\>')
    text = text.replace('@', '\\@')
    
    # Safety: ensure ~ is never backslash-escaped (valid Typst as-is)
    text = text.replace('\\~', '~')
    
    return text
```

### Updated header cell formatting in `md_table_to_typst()`:

Replace line 881-883:
```python
    header_typst = ", ".join(
        f"[*{escape_typst(c.strip())}*]" if c.strip() else "[]"
        for c in header_cells
    )
```

With:
```python
    def format_header_cell(c):
        cleaned = c.strip()
        if not cleaned or cleaned in ('**', '***', '*'):
            return "[]"
        return f"[*{escape_typst(cleaned)}*]"
    
    header_typst = ", ".join(format_header_cell(c) for c in header_cells)
```

---

## Verification

After making changes:

1. Run `python scripts/build_pdf.py`
2. Check `exports/pandoc_build.log` for:
   - NO `unknown variable` errors
   - NO `no text within stars` warnings
   - Clean build (exit 0)
3. Open the output PDF and verify:
   - Ch 14 cost comparison table: dollar amounts render as `~$3,500`, `~$15`, etc.
   - Ch 14 cost comparison table: first column header is blank (not `**`)
   - Ch 5 topology comparison table: same blank first column, no `**`
   - Ch 9 tables: render with correct column widths
   - Appendix chapter-to-principle table: renders in landscape
   - All `~` characters render as non-breaking spaces (not `\~`)
4. If build succeeds, delete `exports/_combined_DEBUG.md` (no longer needed)

## Post-execution

- `seldon cc complete cc_tasks/2026-04-08_pdf_escape_fix.md`
- Commit: "Fix PDF build: escape_typst dollar/tilde handling, empty bold headers"
