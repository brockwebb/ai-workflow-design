# CC Task: Full Discovery Audit Sweep — run-004

**Date:** 2026-04-06
**Project:** ai-workflow-design (`/Users/brock/Documents/GitHub/ai-workflow-design`)
**Reference:** AD-020, auditor agent (`seldon/.claude/agents/auditor.md`), agent team pattern (`seldon/docs/templates/cc_task_agent_team_audit.md`)
**Depends on:** `2026-04-06_audit_directory_reorganization.md` (completed), `seldon/cc_tasks/2026-04-06_enforce_run_directory_convention.md` (completed)

---

## Objective

Execute a full discovery audit across all book content to produce a consistent, complete calibration dataset. One run, one model, one day, all chapters. This is run-004.

Prior audit data (run-001 through run-003) becomes baseline for future TEVV comparisons. This run is a fresh discovery audit — not a regression check against prior runs.

## Scope

**Audit these sections (17 total):**

| Section | File | Prior audit data? |
|---------|------|-------------------|
| Foreword | `book/foreword.md` | No |
| Introduction | `book/intro.md` | No |
| Chapter 1 | `book/chapter-01.md` | No (busted manual process only) |
| Chapter 2 | `book/chapter-02.md` | No (busted manual process only) |
| Chapter 3 | `book/chapter-03.md` | Partial (run-001: content_audit + perplexity only) |
| Chapter 4 | `book/chapter-04.md` | Yes (run-001) |
| Chapter 5 | `book/chapter-05.md` | Yes (run-001) |
| Chapter 6 | `book/chapter-06.md` | Yes (run-001) |
| Chapter 7 | `book/chapter-07.md` | Yes (run-001) |
| Chapter 8 | `book/chapter-08.md` | Yes (run-001 + run-002 TEVV) |
| Chapter 9 | `book/chapter-09.md` | Yes (run-001 + run-002 TEVV) |
| Chapter 10 | `book/chapter-10.md` | Yes (run-001) |
| Chapter 11 | `book/chapter-11.md` | Yes (run-003) |
| Chapter 12 | `book/chapter-12.md` | Yes (run-003) |
| Chapter 13 | `book/chapter-13.md` | Yes (run-003) |
| Chapter 14 | `book/chapter-14.md` | Yes (run-003) |
| Appendix: Security | `book/appendix-security.md` | Yes (run-003) |

**Skip:** `book/cover.md`, `book/appendix-principles.md` (compressed tenets reference — not prose content requiring content audit), `book/bibliography.md`, `book/glossary.md`, `book/figure-registry.md`.

If `appendix-principles.md` has substantive prose beyond a reference table, audit it. Check first.

## Run Directory Setup

Before any audit output:

```bash
mkdir -p audits/run-004_2026-04-06
```

Write an initial manifest stub immediately:

```yaml
# audits/run-004_2026-04-06/run_manifest.yaml
run_manifest:
  run_id: "run-004"
  date: "2026-04-06"
  run_type: "discovery"
  model: "claude-sonnet-4.6"
  pipeline: "AD-020 agent team"
  chapters_audited: []  # Updated as each chapter completes
  gates_run:
    - content_audit
    - practitioner_stress_test
    - bloom_depth_check
    - secondary_sweep
    - cascade_results
    - review_synthesis
  book_context: "book/intro.md 'How This Book Is Organized' section"
  notes: "Full discovery sweep across all book content. Fresh baseline."
```

Update `chapters_audited` after each chapter completes.

## Context Loading (per chapter)

Each chapter audit loads:

1. **Target chapter** — full text
2. **Book-level context** — read `book/intro.md`, specifically the "How This Book Is Organized" section. This provides the five-phase structure and each chapter's role in the arc.
3. **Sibling semantic anchors** — run `seldon paper context` for cross-chapter compressed context (core_argument, claims, forward_promises, terminology_defined, open_threads). If semantic anchors are not populated for a chapter, note the gap in the manifest.
4. **Ontology** — `seldon ontology list --verbose`
5. **Bibliography** — `book/references.bib` or `book/bibliography.md`

Do NOT load all chapters fully. The compression approach (full target + compressed siblings) is proven and fits within context limits.

## Execution Pattern

### Per-chapter: Agent Team

For each chapter, use the agent team pattern from `seldon/docs/templates/cc_task_agent_team_audit.md`:

1. **Lead auditor** runs the full gate pipeline on the target chapter
2. **Cascade-checker teammates** (up to 5 concurrent) verify cross-section impacts
3. Lead collects cascade results, writes all output to `audits/run-004_2026-04-06/`

### Gates per chapter (all six):

1. `content_audit` — assertion classification, citation coverage, depth assessment
2. `practitioner_stress_test` — 10 questions a practitioner would ask
3. `bloom_depth_check` — cognitive depth assessment
4. `secondary_sweep` — narrative, visual elements, motivation, clarity
5. `cascade_results` — cross-section impact verification
6. `review_synthesis` — cluster findings, assign verdict

### Outer loop: Sequential batch

Process chapters in book order:

```
foreword → intro → ch1 → ch2 → ch3 → ... → ch14 → appendix-security
```

**Critical: clean context between chapters.** Do not carry accumulated state from prior chapters into the next audit. Each chapter gets a fresh context load (target + compressed siblings + ontology + bib). If running in a single CC session, explicitly state "Starting fresh audit of chapter N" to reset context framing.

If context pressure becomes noticeable (degraded output quality, slower responses, missed findings), stop the batch, commit what's done, update the manifest, and resume in a new CC session.

## Output Files (per chapter)

All files go to `audits/run-004_2026-04-06/`:

```
{chapter_slug}_content_audit.yaml
{chapter_slug}_perplexity_queries.md
{chapter_slug}_practitioner_stress_test.yaml
{chapter_slug}_bloom_depth_check.yaml
{chapter_slug}_secondary_sweep.yaml
{chapter_slug}_cascade_results.yaml
{chapter_slug}_review_synthesis.yaml
```

Where `{chapter_slug}` is: `foreword`, `intro`, `chapter-01`, ..., `chapter-14`, `appendix-security`.

## Gate Calibration Notes (from 8-run analysis)

Apply these lessons from the calibration analysis across run-001 through run-003:

1. **Practitioner stress test is highest-signal gate.** Weight its findings heavily in the synthesis. A chapter that scores poorly on practitioner questions has structural problems regardless of what other gates say.

2. **Zero visual elements is book-level, not per-chapter.** Do not flag "no figures" as a HIGH finding in every single chapter. Note it in the secondary sweep, but the synthesis should acknowledge this is a known book-wide production gap, not a per-chapter authoring failure.

3. **Citation density predicts audit character.** Low-citation chapters will produce "cite more" findings. High-citation chapters produce "cite better" findings. The synthesis should distinguish between these.

4. **Cross-chapter cascade checks justify their cost.** Number inconsistencies, broken bridge promises, forward reference failures — these are the findings that only cascade checks catch. Do not skip this gate.

5. **Document type matters.** Foreword and intro are different document types than body chapters. Adjust expectations: foreword doesn't need citations or practitioner stress test. Intro needs lighter citation coverage than body chapters. Apply `document_type` awareness in the synthesis verdict.

## Foreword and Introduction — Modified Gates

**Foreword:** Run only `content_audit` (light — check factual claims if any) and `secondary_sweep` (narrative quality). Skip practitioner_stress_test, bloom_depth_check, cascade_results. The foreword is a framing document, not a technical chapter.

**Introduction:** Run all gates but calibrate expectations. The intro's "How This Book Is Organized" section contains chapter summaries that should be consistent with actual chapter content — this is a high-value cascade check target.

## Completion

After all chapters are audited:

1. Update `run_manifest.yaml` with the final `chapters_audited` list
2. Verify all expected files exist:
   ```bash
   # 17 sections × 7 files = 119 files (minus foreword's skipped gates)
   ls audits/run-004_2026-04-06/ | wc -l
   ```
3. Run `seldon verify --strict`
4. Commit:
   ```bash
   git add audits/run-004_2026-04-06/
   git commit -m "feat: run-004 full discovery audit sweep — all chapters

   Complete AD-020 discovery audit across foreword, intro, Ch 1-14, and
   appendix-security. 17 sections, 6 gates each (modified for foreword).
   Fresh calibration baseline for the full book.

   Ref: AD-020, agent team audit pattern"
   ```

## Do NOT

- Edit any chapter files — audit only
- Compare against prior runs (this is discovery, not TEVV)
- Create ResearchTask or Issue artifacts in the graph (synthesis step handles that)
- Skip the cascade checks — they are the highest-value cross-chapter gate
- Write audit files outside the run-004 directory
- Continue auditing if context quality degrades — stop, commit, resume fresh

## Success Contract

**Inputs:** 17 section files, ontology, bibliography, semantic anchors
**Outputs:** ~115 YAML/MD files in `audits/run-004_2026-04-06/` with complete manifest
**Quality gate:** Every chapter has a `review_synthesis.yaml` with a verdict. No chapter skipped.
**Time estimate:** ~7-10 hours of CC execution time (30-40 min per chapter). May require 2-3 CC sessions.
**Known risk:** Context degradation after ~5-7 chapters in a single session. Mitigated by explicit "stop and resume" protocol.
