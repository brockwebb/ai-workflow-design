# CC Task: Agent Team Content Audit — Chapter [NN]

**Date:** 2026-04-02
**Project:** ai-workflow-design
**Reference:** AD-019, Agent Team Audit Pattern
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`

---

## Instructions

Run a content audit on the target chapter using the agent team pattern.

### Step 1: Enable agent teams
Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set in your environment or settings.

### Step 2: Audit the chapter
Use the auditor agent protocol:
1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context
2. Read `references.bib` for citation context
3. Read the target chapter file
4. Execute the full audit per `.claude/agents/auditor.md`
5. Write output to `audits/<chapter>_content_audit.yaml`
6. Write Perplexity queries to `audits/<chapter>_perplexity_queries.md`

### Step 3: Spawn cascade checkers
Read `cascading_audit_tasks` from the YAML output. Group by target chapter.

For each unique target chapter, spawn a cascade-checker teammate:
```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-XX.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates.

### Step 4: Collect results
Wait for all teammates. Collect cascade_check YAML outputs.
- `confirmed` → write to `audits/<chapter>_cascade_results.yaml`
- `needs_full_audit` → note for follow-up
- `clear` → no action

### Step 5: Summary and cleanup
Print summary to terminal. Clean up the team.

## Output Files

- `audits/<chapter>_content_audit.yaml` — structured findings
- `audits/<chapter>_perplexity_queries.md` — verification queries
- `audits/<chapter>_cascade_results.yaml` — confirmed cascade findings (if any)

## Do NOT

- Edit any chapter files
- Run cascade checkers on chapters not in the cascading_audit_tasks list
- Let cascade checkers expand scope
- Create Issue artifacts (future automation)
