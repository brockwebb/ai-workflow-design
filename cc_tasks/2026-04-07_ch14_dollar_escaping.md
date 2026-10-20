# CC Task: Ch 14 Dollar Sign Escaping for MyST Build

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** Ch 14 rendering bug -- unescaped `$` signs interpreted as LaTeX math delimiters by MyST, causing word concatenation in rendered output
**Scope:** One file, mechanical find-and-replace. No content changes.

---

## Problem

MyST interprets bare `$` as LaTeX math-mode delimiters. When two bare `$` signs appear in the same paragraph, everything between them renders as LaTeX math (spaces stripped, text italicized/concatenated). Ch 14 has 16 unescaped `$` signs across 8 lines. The rendered output shows concatenated blocks like `3,500inengineeringtime(roughly35hoursof...`.

The fix: every bare `$` in chapter-14.md must become `\$`. One instance (`\\$100`) is already correctly escaped.

---

## Fix: Escape all bare `$` signs in chapter-14.md

**File:** `book/chapter-14.md`

**Line 10:** (opening hook paragraph)
- `"$15."` → `"\$15."`

**Line 29:** (table row -- Development cost)
- `~$3,500` → `~\$3,500`
- `~$800` → `~\$800`

**Line 30:** (table row -- Per-run cost)
- `~$15` → `~\$15`
- `~$23,200` → `~\$23,200`

**Line 35:** (table row -- Year 1 total)
- `~$3,515` → `~\$3,515`
- `~$24,000` → `~\$24,000`

**Line 36:** (table row -- Year 2+ per cycle)
- `~$15` → `~\$15`
- `~$23,200` → `~\$23,200`

**Line 38:** (manual equivalent prose paragraph -- 5 bare `$` signs)
- `approximately $24,000 per cycle` → `approximately \$24,000 per cycle`
- `pipeline's $15 inference` → `pipeline's \$15 inference`
- `approximately $3,500 in engineering` → `approximately \$3,500 in engineering`
- `wave for $15;` → `wave for \$15;`
- `costs $23,200 every` → `costs \$23,200 every`
- NOTE: `\\$100` on this line is ALREADY correctly escaped -- do not touch it

**Line 55:** (Concept Mapper distribution paragraph)
- `Inference cost: $15.` → `Inference cost: \$15.`

**Line 166:** (thought experiment)
- `a $50,000 annual` → `a \$50,000 annual`

**Execution method:** Global regex replacement is safe here. Replace every `$` that is NOT preceded by `\` with `\$`. The regex: find `(?<!\\)\$` replace with `\$`. But verify that `\\$100` on line 38 is not double-escaped to `\\\$100` -- it should remain `\\$100`.

---

## Verification Checklist

- [ ] `grep -c '[^\\]\$' book/chapter-14.md` returns 0 (no bare dollar signs remain)
- [ ] `grep '\\\\\\$100' book/chapter-14.md` returns exactly one match (the already-escaped labor rate)
- [ ] No triple-escaped `\\\$` patterns anywhere in the file
- [ ] Run `myst build --html` and verify the Ch 14 cost paragraph renders with proper spacing and dollar signs

## Files Modified

`book/chapter-14.md` (16 character insertions, no content changes)
