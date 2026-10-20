# CC Task: Update CLAUDE.md

**Date:** 2026-03-31
**Session:** 13
**Scope:** Update CLAUDE.md to reflect current state after Session 12

---

## Task

Update `/Users/brock/Documents/GitHub/ai-workflow-design/CLAUDE.md` with the following changes. Read the full file, apply all changes, write the full file back.

### Change 1: Chapter 4 outline entry

**Current:**
```
4. **Detection & Extraction Workflows** — Entity extraction, pattern detection, disclosure review assistance. Recall vs precision tradeoffs in statistical contexts.
```

**Replace with:**
```
4. **Detection & Extraction Workflows** — Third of the domain trilogy (Ch 2 = classification, Ch 3 = wrangling, Ch 4 = extraction). Entity extraction, relationship extraction, pattern detection, disclosure review assistance. KG confidence laundering as signature warning. Worked examples: Templ (2026) sdcMicro disclosure review (metadata-only, LLM-as-advisor, output as inspectable code), DiGiuseppe & Flynn (2026) scaling open-ended survey responses (pairwise comparison, six-LLM ensemble, Bradley-Terry aggregation). Core principle: if you cannot trace every extracted element back to a specific source passage, model version, and prompt, you do not have a knowledge graph — you have a confabulation graph.
```

### Change 2: Chapter 6 outline entry — remove killed cost comparison

**Current:**
```
6. **Parallel, Serial, and the Bottleneck** — What runs concurrently. Batch design. Rate limits and cost. The $15 vs $1500 lesson.
```

**Replace with:**
```
6. **Parallel, Serial, and the Bottleneck** — What runs concurrently. Batch design. Rate limits and cost management. Architectural tradeoffs in pipeline topology.
```

**Rationale:** The "$15 vs $1500" framing was killed because it couldn't be justified with data. Intellectual honesty over rhetorical convenience.

### Change 3: Chapter 3 — verify name consistency

Verify Ch 3 says "Data Wrangling & Standardization" (not "Data Cleaning & Imputation") in BOTH the chapter outline description AND the Chapter-to-Principle Mapping table row. Fix if needed.

---

## Execution

1. Read full CLAUDE.md via `Filesystem:read_file`
2. Apply all three changes in memory
3. Write full file back via `Filesystem:write_file`
4. Verify changes landed correctly

## Verification

- Ch 4 outline entry includes: domain trilogy positioning, KG confidence laundering, Templ, DiGiuseppe & Flynn, confabulation graph principle
- Ch 6 outline entry no longer references "$15 vs $1500"
- Ch 3 name is "Data Wrangling & Standardization" everywhere in the file
- No other content changed
