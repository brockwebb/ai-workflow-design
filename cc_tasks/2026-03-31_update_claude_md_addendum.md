# CC Task Addendum: 2026-03-31_update_claude_md.md

**Date:** 2026-03-31
**Session:** 13
**Amends:** `cc_tasks/2026-03-31_update_claude_md.md`

---

## Clarification 1: Chapter 6

The parent task refers to "Chapter 6 outline entry." To be precise: this refers to the Chapter 6 **summary description line** in the "Chapter Outline (Draft)" section of CLAUDE.md — not the chapter draft itself. Chapter 6 has a full draft. No changes to `book/chapter-06.md` are implied or authorized by this task.

## Clarification 2: Strip chapter outline to titles only

The paragraph-level chapter descriptions in CLAUDE.md's "Chapter Outline (Draft)" section are rot-prone duplication. They go stale every time a chapter evolves (which is exactly what triggered this CC task). The actual chapter content lives in the chapter files; an assistant can read those directly.

**Instead of applying Changes 1 and 2 from the parent task as written**, replace the entire "Chapter Outline (Draft)" section with a title-only list:

```
## Chapter Outline

1. Why Design Matters
2. Classification & Coding Workflows
3. Data Wrangling & Standardization Workflows
4. Detection & Extraction Workflows
5. The Ensemble & Multi-Model Playbook
6. Parallel, Serial, and the Bottleneck
7. Checkpoints, Failures, and Recovery
8. Evaluation by Design
9. State, Drift, and Validity
10. State Management & Research Provenance
11. Workflow Orchestration & the Tool Landscape
12. Security, Supply Chain, and Model Provenance
13. Deploying in Institutional Environments
14. Cost & Practicality
```

Remove the "(Draft)" qualifier from the section heading — all chapters have first drafts.

**Keep the Chapter-to-Principle Mapping table** — that's structural metadata not duplicated elsewhere.

**Change 3 from the parent task (Ch 3 name verification) still applies.** Verify "Data Wrangling & Standardization" is correct in the title list and the mapping table.
