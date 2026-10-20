# CC Task: Create Glossary and Index

**Date:** 2026-03-31
**Session:** 13
**Scope:** Create glossary.md and index.md for ai-workflow-design, add to myst.yml TOC

---

## Context

All 14 chapters have first drafts. The ai4stats glossary (`/Users/brock/Documents/GitHub/ai4stats/book/glossary.md`) provides the base pattern and many reusable entries. This task creates the glossary and index for ai-workflow-design.

## Task 1: Create `book/glossary.md`

### Approach

1. Read all 14 chapter files, foreword, and introduction from `book/`
2. Read the ai4stats glossary for reusable entries and format reference
3. Extract all domain-specific terms that a practitioner reader would need defined
4. Build the glossary using MyST `{glossary}` directive format (same as ai4stats)

### Term Sources

**Carry forward from ai4stats glossary** — include any term that appears in ai-workflow-design chapters. Do NOT carry forward terms that only appear in ai4stats. Update definitions if the ai-workflow-design context has evolved the meaning.

**New terms unique to ai-workflow-design** (non-exhaustive — extract from chapters):
- stochastic tax
- stochastic liabilities
- confidence laundering / KG confidence laundering
- confabulation graph
- golden test set / golden questions
- config-driven architecture
- dual-model cross-validation
- ABBA design
- model transience
- fine-tuning cost trap
- 90/10 rule
- last mile problem
- disagreement as signal
- bone drop (design notes terminology)
- routing document
- pairwise comparison (in LLM evaluation context)
- Bradley-Terry aggregation
- judge loop
- agreement scoring
- checkpoint
- idempotent operation
- batch economics
- token budget
- ATO (Authority to Operate)
- cloud parity gap
- Five Safes (if referenced)
- MCP (Model Context Protocol)
- confabulation (per NIST AI 600-1 — not "hallucination")

### Format

```markdown
# Glossary

\`\`\`{glossary}
term
: Definition text. Keep definitions concise, practitioner-oriented. Include chapter cross-references where the term is primarily discussed (e.g., "See Chapter 5 for design patterns.").
\`\`\`
```

Alphabetical order. One blank line between entries.

### Rules
- Use "confabulation" not "hallucination" per NIST AI 600-1 vocabulary
- SFV sub-dimensions and threats: carry forward from ai4stats but verify definitions match the canonical baseline in `docs/sfv/SFV_TERMINOLOGY_BASELINE.md` (if accessible) or the Seldon shared ontology
- No definitions that are just restating the obvious — if a term doesn't need explaining for a data scientist audience, skip it
- Every definition should be useful to a federal practitioner who picks up this book

## Task 2: Create `book/index.md`

### Approach

A keyword-by-chapter reference page. This is a living digital book, not print — no page numbers.

### Format

```markdown
# Index

Keywords mapped to chapters where they are substantively discussed (not just mentioned in passing).

| Keyword | Chapters |
|---------|----------|
| ABBA design | 5 |
| agreement scoring | 2, 5 |
| ATO | 13 |
| batch economics | 6, 14 |
| ... | ... |
```

Alphabetical by keyword. Chapter numbers only (not titles — keeps the table compact). Include a keyword if it's substantively discussed in a chapter, not just name-dropped.

## Task 3: Update `book/myst.yml`

Add glossary and index to the TOC. Insert after `appendix-principles.md` and before `bibliography.md`:

```yaml
    - file: appendix-principles.md
    - file: glossary.md
    - file: index.md
    - file: bibliography.md
```

## Execution Order

1. Read all chapter files + foreword + intro (batch read)
2. Read ai4stats glossary for reusable entries
3. Extract terms from chapters, cross-reference with ai4stats entries
4. Write `book/glossary.md`
5. Build keyword-chapter mapping from the same chapter scan
6. Write `book/index.md`
7. Update `book/myst.yml` TOC

## Verification

- `book/glossary.md` exists, uses `{glossary}` directive, alphabetical order
- `book/index.md` exists, keyword-chapter table, alphabetical order
- `book/myst.yml` includes both new files in TOC between appendix-principles and bibliography
- No terms defined that aren't actually used in the book
- SFV terms match canonical definitions
- "confabulation" used, never "hallucination" as the primary term
