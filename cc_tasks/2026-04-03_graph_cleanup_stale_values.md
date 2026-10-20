# CC Task: Kill Stale Graph Data — "$15 vs $1,500" and "6,987"

**Date:** 2026-04-03
**Project:** ai-workflow-design
**Priority:** High — these stale values are seeding false findings in AD-020 cascade checkers and wasting tokens across sessions

---

## Context

The "$15 vs $1,500" framing has been resolved multiple times. It lives in Ch 14 ONLY. The Ch 5 bridge was rewritten in Session 20 to remove it. Yet the AD-020 cascade checker for Ch 6 (run 004) still flagged it as a broken bridge promise — because the graph contains stale metadata that references this framing.

The number 6,987 is wrong everywhere. The canonical count is 6,954 analyzable survey questions (after dedup/dual-topic cleanup from ~7,000 raw). The source paper (`FedSurveyHarmonization.pdf`) confirms 6,954. No pipeline stage produces 6,987.

These stale values in the graph are the root cause of repeated token waste across sessions. Memory edits don't fix the graph. The graph is the source of truth, and right now it's lying.

---

## Instructions

### Step 1: Find all graph nodes/properties containing "$15 vs $1,500" or "15 versus 1,500"

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
set -a; source .env; set +a
seldon artifact list --verbose 2>&1 | grep -i "15.*1.500\|1.500.*15\|15 vs\|15 versus"
```

If `seldon artifact list` doesn't expose the text, try:
```bash
seldon task list --verbose 2>&1 | grep -i "15.*1.500\|1.500.*15"
seldon issue list --verbose 2>&1 | grep -i "15.*1.500\|1.500.*15"
```

### Step 2: Find all graph nodes/properties containing "6,987" or "6987"

```bash
seldon artifact list --verbose 2>&1 | grep -i "6.987\|6987"
seldon task list --verbose 2>&1 | grep -i "6.987\|6987"
seldon issue list --verbose 2>&1 | grep -i "6.987\|6987"
```

### Step 3: Update or remove stale entries

For each hit:
- If it's a task description referencing "$15 vs $1,500" as something to add to Ch 6: close/resolve the task with note "Resolved: framing lives in Ch 14 only per Session 20 decision"
- If it's an artifact description containing "6,987": update to "6,954"
- If it's an issue: resolve with note "6,987 is incorrect, canonical count is 6,954 per source paper"

### Step 4: Also check CLAUDE.md

```bash
grep -n "6.987\|6987\|15.*1.500\|1.500.*15" CLAUDE.md
```

If CLAUDE.md contains either stale value, fix it there too. CLAUDE.md is read by every session — stale data there propagates everywhere.

### Step 5: Verify

```bash
seldon verify
```

---

## Do NOT

- Touch any chapter files — the chapter-level fixes are in `cc_tasks/2026-04-03_ch06_revision.md`
- Create new artifacts — this is cleanup only
- Skip the CLAUDE.md check — it's a major drift vector
