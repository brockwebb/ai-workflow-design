# CC TASK — relocate ai-workflow-design off iCloud (blocks Batch B)

**Date:** 2026-08-15 · **Status:** dispatched
**Authority:** L4 — grounded decision on record: iCloud eviction/sync rewrites
mtimes, presents placeholder/stale file states, and has produced EDEADLK-class
contention with `git status` hanging >120s on this repo. Zero-cost move.
**Destructive-op protocol applies:**
`~/.wintermute/docs/decisions/2026-08-15_destructive-op-protocol.md` — this is
a namespace move; items 1–3 are mandatory below.

## Change

1. Relocate `/Users/brock/Documents/GitHub/ai-workflow-design/` →
   `/Users/brock/GitHub/ai-workflow-design/`.
2. **Copy-verify-then-quarantine, never move-in-place:**
   a. Pre-manifest: content-hash manifest of the source tree (blast radius).
   b. Force-materialize any iCloud placeholders before copying (`brctl
      download` or equivalent); a placeholder copied is a file lost.
   c. Copy to destination; post-manifest; byte-level diff must be empty.
   d. `git fsck` + `git status` clean at destination; timing sanity (<5s).
   e. Source renamed to `ai-workflow-design.PRE-MOVE-QUARANTINE/` — no
      deletion in this task. Hard removal is a later, separate step after
      soak.
3. Re-point the Seldon subagent **symlinks** (symlinks, never copies) and any
   absolute-path references: grep the repo and `~/.claude/` config surfaces
   for the old path; itemize every rewrite.
4. Batch B (`cc_tasks/2026-08-07_batch_b_mechanical_fixes.md`) executes only
   after relocation verifies — from the new path.

## Verification (required, RESULT sidecar)

1. Manifest diff source→destination: empty.
2. Placeholder check: zero non-materialized files encountered, or each one
   itemized as materialized-then-copied.
3. `git fsck` clean; `git status` < 5s at destination.
4. Symlink audit: every re-pointed link listed old→new; zero dangling.
5. Quarantine present, untouched.

## Result

Write `cc_tasks/2026-08-15_repo-relocation_RESULT.md` in the repo at its NEW
path. Immutable once dispatched.
