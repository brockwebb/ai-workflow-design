# CC Task: Remove Graph-Tracked Structural Metadata from CLAUDE.md

**Date:** 2026-04-01
**Scope:** `CLAUDE.md`
**Type:** Housekeeping — remove rot-prone duplication
**Status:** PENDING

---

## Context

Session 17 identified that the Chapter-to-Principle Mapping table in CLAUDE.md has drifted from the Seldon graph (Ch 3 header says "Outputs require full provenance" while the table says "Reuse data before collecting more"). Session 18 reaffirms the decision from Session 17: the graph is the source of truth for structural metadata. Convenience copies in CLAUDE.md rot.

This task removes structural metadata that is tracked in the Seldon graph and should not be duplicated in CLAUDE.md. CLAUDE.md retains project context that an AI assistant needs to orient (thesis, audience, conventions, workflow rules, build system) but not structural metadata that changes as the book evolves.

---

## What to Remove

### 1. Chapter-to-Principle Mapping Table

Remove the entire table and its heading, from:

```
**Chapter-to-Principle Mapping:**
```

Through the end of the table (the row for Ch 14), including the line:

```
See `book/appendix-principles.md` for standalone reference page.
```

**Replace with:**

```
**Chapter-to-Principle Mapping:** Tracked in the Seldon graph. Run `seldon go` to see current mappings. Do not maintain a convenience copy here; it drifts.
```

### 2. Chapter Outline (numbered list)

Remove the numbered chapter list (14 items from "1. Why Design Matters" through "14. Cost & Practicality").

**Replace with:**

```
14 chapters. Run `seldon go` for current chapter list and structure. The chapter count and titles are tracked in the Seldon graph and in `book/myst.yml`.
```

---

## What to Keep

Everything else in CLAUDE.md stays:

- Project Overview (thesis, audience, license)
- Project Structure (directory layout)
- Organizing Framework (tenets and working principles — these are conceptual framework, not structural metadata; they are introduced in Chapter 1 and do not change)
- Chapter Pedagogical Pattern (design convention, not structural metadata)
- Citation Conventions
- Workflow Rules
- Key Source Material
- Build System
- Related Projects

---

## Verification

After edits:

1. Confirm no chapter-to-principle mapping table exists in CLAUDE.md
2. Confirm no numbered chapter list exists in CLAUDE.md
3. Confirm the tenets and working principles lists are still present (they stay)
4. Confirm the replacement text points to `seldon go` as the source of truth
5. Run `seldon verify --fix`

---

## Acceptance Criteria

- [ ] Chapter-to-Principle Mapping table removed, replaced with pointer to graph
- [ ] Chapter Outline numbered list removed, replaced with pointer to graph and myst.yml
- [ ] All other CLAUDE.md content preserved unchanged
- [ ] No structural metadata remains that duplicates graph state
- [ ] `seldon verify` passes
