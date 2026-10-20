# RESULT — ai-workflow-design relocated off iCloud

**Task:** `cc_tasks/2026-08-15_repo-relocation.md`
**Date:** 2026-08-15/16 · written at the NEW path
**Protocol:** `~/.wintermute/docs/decisions/2026-08-15_destructive-op-protocol.md`,
items 1–3 shown below.

`/Users/brock/Documents/GitHub/ai-workflow-design/` →
**`/Users/brock/GitHub/ai-workflow-design/`**

| gate | result |
|---|---|
| manifest diff source→destination | **empty** — 7,616 = 7,616, 0 missing, 0 extra, 0 hash mismatch |
| placeholders | **6,889 materialized, 0 failed, 0 remaining** |
| `git fsck` | **clean** (2 dangling blobs, normal) |
| `git status` timing | **0.40 s** (was **>120 s**, the reason for the move) |
| symlink audit | 6 links, **2 re-pointed, 0 dangling** |
| quarantine | present, **7,610 files**, untouched |

## Protocol items

1. **Blast radius enumerated first** — SHA-256 manifest of all 7,616 source
   files at `/tmp/awd_src_manifest.json`, taken before the rename. 0 read
   errors, 6 symlinks captured as link targets rather than content.
2. **Backup ⊇ blast radius** — the destination copy *is* the backup and its
   coverage is proven by the empty manifest diff, not asserted. The source is
   additionally retained whole in quarantine.
3. **Deletes stage as renames** — nothing was deleted. Source renamed to
   `ai-workflow-design.PRE-MOVE-QUARANTINE/`. Hard removal is a separate later
   step after soak.

## The placeholder problem was the whole job

**6,889 of 7,616 files were iCloud placeholders (`SF_DATALESS`)** — 90% of the
repo. A placeholder copied is a file lost, so this had to be resolved before any
copy.

**`brctl download .` returned exit 0 and materialized nothing.** The task named
it as the tool; it is a no-op here. Materialization was achieved by reading every
file, which forces synchronous fetch: **7,616 read OK, 0 failures, 0 dataless
remaining.**

What was dataless, and why it mattered unevenly:

| subtree | files | consequence of a bad copy |
|---|---:|---|
| `book/_build/` | 5,578 | gitignored build output — regenerable |
| **`.git/objects`** | **620** | **repository corruption** |
| `assets/diagrams` | 86 | the paperbanana figures |
| everything else | ~57 | tracked content (110 files tracked total) |

**`du` on the source reported 192 MB. The real transfer was 1.3 GB.** `du` sizes
placeholders as stubs, so any capacity estimate taken from it would have been
off by ~7×. Recording it because the next relocation will be sized the same
wrong way otherwise.

Copy method: `rsync -a`, run twice — the second pass is the belt-and-braces
check that nothing was still materializing during the first. The manifest diff,
not rsync's exit code, is the RED/GREEN (protocol item 5: counts don't verify
survival).

## Symlink audit — every link, old → new

| link | old target | new target | resolves |
|---|---|---|---|
| `.claude/agents/auditor.md` | `…/Documents/GitHub/seldon/.claude/agents/auditor.md` | `/Users/brock/GitHub/seldon/.claude/agents/auditor.md` | OK |
| `.claude/agents/cascade-checker.md` | `…/Documents/GitHub/seldon/.claude/agents/cascade-checker.md` | `/Users/brock/GitHub/seldon/.claude/agents/cascade-checker.md` | OK |
| 4 × `book/_build/…/node_modules/.bin/*` | relative (`../…`) | unchanged | OK |

**Seldon was never actually in iCloud.** `Documents/GitHub/seldon` is itself a
**symlink** to `/Users/brock/GitHub/seldon` — same inode, same HEAD
(`ee2e588e`), byte-identical agent files. The two links resolved correctly
before the move; they were re-pointed anyway so they no longer route through an
iCloud path.

## Absolute-path references

| surface | occurrences | action |
|---|---:|---|
| `~/.claude.json` (live config) | 2 | **rewritten**; JSON validated before and after; backup at `/tmp/claude.json.pre-relocation.bak` |
| `~/.claude/history.jsonl` | 216 | **left as-is** |
| `~/.claude/projects/**.jsonl` (transcripts) | many | **left as-is** |
| `~/.claude/backups/*.backup.*` | many | **left as-is** |
| repo working tree | 0 | none needed |

The last three are append-only records of what was true at the time. Rewriting
history to match the present is falsification, not maintenance — only live
config was changed.

## Finding outside the task's scope — reported, not acted on

**`/Users/brock/Documents/GitHub/` is not empty. It holds ~80 repositories**,
many duplicating `/Users/brock/GitHub/` (`census-mcp-server`, `icsp_notebook`,
`measuring-ai-economy`, `brock_projects`, `survey-dag-extractor`, `webdesktop`,
`wintermute`, …), plus repos that exist nowhere else.

`~/.wintermute/CLAUDE.md` states: *"`/Users/brock/Documents/GitHub` is empty"*.
That is wrong, and every one of those repos is exposed to the same
placeholder/eviction hazard this task was raised to fix — 90% dataless, `du`
under-reporting by 7×, `git status` hanging past 120 s. Whether they are live
checkouts, stale duplicates, or symlinks like `seldon` is **unaudited**.

Per the standing rule, disk-vs-graph gaps are reported and the operator gates
them. This is a one-line CLAUDE.md correction and a much larger relocation
question.

## Batch B

`cc_tasks/2026-04-07_batch_b_mechanical_fixes.md` (the task references it as
`2026-08-07`; no such file exists) is **already complete** — commit `06627c5`,
2026-04-07, all 19 fixes verified against the working tree on 2026-08-14. The
"executes only after relocation verifies" clause has nothing left to run. If a
re-verification from the new path is wanted, it is a fresh dispatch.

## State at close

- destination live at `/Users/brock/GitHub/ai-workflow-design`, HEAD `99d5d5a`
- pre-existing working-tree state carried over unchanged: `M seldon_events.jsonl`,
  `?? exports/`
- quarantine at `/Users/brock/Documents/GitHub/ai-workflow-design.PRE-MOVE-QUARANTINE/`,
  7,610 files, **not deleted**
