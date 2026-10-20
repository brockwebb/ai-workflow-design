# CC Task: Audit Directory Reorganization

**Date:** 2026-04-06
**Project:** ai-workflow-design (`/Users/brock/Documents/GitHub/ai-workflow-design`)
**Reference:** AD-020, regression audit loop design note (`seldon/docs/design/2026-04-05_regression_audit_loop.md`)

---

## Context

The `audits/` directory contains three generations of audit data produced by the same AD-020 pipeline but with inconsistent organization:

1. **run-001_2026-04-05/** — Ch 3-10 discovery audits. Properly organized with manifest. Ch 3 is incomplete (only content_audit + perplexity_queries — missing practitioner_stress_test, bloom_depth_check, secondary_sweep, cascade_results, review_synthesis).

2. **run-002_2026-04-05/** — Ch 8, Ch 9 TEVV verification re-audits. Properly organized with manifest and delta summaries.

3. **Loose files in `audits/`** — Ch 11, Ch 12 (dated 2026-04-05), Ch 13, Ch 14, appendix-security (dated 2026-04-06). Full gate coverage. These were produced by the same AD-020 process as run-001 but after the run-directory convention was established. The other thread numbered them internally as run-009 through run-013 (per-chapter sequential), which conflicts with the directory-level run numbering.

## Objective

Consolidate loose audit files into a properly named run directory with a manifest. Establish a single numbering convention going forward.

## Numbering Convention Decision

**Directory-level run IDs** are the canonical numbering scheme. Each `run-NNN_YYYY-MM-DD/` directory represents a logical audit batch. The internal `run` fields in individual YAML files (run-009, run-010, etc.) are historical artifacts from the other thread's per-chapter sequential convention. They are NOT updated retroactively — that would violate CC task immutability of the YAML data — but they are superseded by the directory-level ID going forward.

## Instructions

### Step 1: Create run-003 directory

The loose files span two dates (April 5 and April 6). Use the later date since that's when the batch completed.

```bash
mkdir -p audits/run-003_2026-04-06
```

### Step 2: Move loose files

Move all chapter-11, chapter-12, chapter-13, chapter-14, and appendix-security audit files from `audits/` into `audits/run-003_2026-04-06/`:

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design

mv audits/chapter-11_bloom_depth_check.yaml audits/run-003_2026-04-06/
mv audits/chapter-11_cascade_results.yaml audits/run-003_2026-04-06/
mv audits/chapter-11_content_audit.yaml audits/run-003_2026-04-06/
mv audits/chapter-11_perplexity_queries.md audits/run-003_2026-04-06/
mv audits/chapter-11_practitioner_stress_test.yaml audits/run-003_2026-04-06/
mv audits/chapter-11_review_synthesis.yaml audits/run-003_2026-04-06/
mv audits/chapter-11_secondary_sweep.yaml audits/run-003_2026-04-06/

mv audits/chapter-12_bloom_depth_check.yaml audits/run-003_2026-04-06/
mv audits/chapter-12_cascade_results.yaml audits/run-003_2026-04-06/
mv audits/chapter-12_content_audit.yaml audits/run-003_2026-04-06/
mv audits/chapter-12_perplexity_queries.md audits/run-003_2026-04-06/
mv audits/chapter-12_practitioner_stress_test.yaml audits/run-003_2026-04-06/
mv audits/chapter-12_review_synthesis.yaml audits/run-003_2026-04-06/
mv audits/chapter-12_secondary_sweep.yaml audits/run-003_2026-04-06/

mv audits/chapter-13_bloom_depth_check.yaml audits/run-003_2026-04-06/
mv audits/chapter-13_cascade_results.yaml audits/run-003_2026-04-06/
mv audits/chapter-13_content_audit.yaml audits/run-003_2026-04-06/
mv audits/chapter-13_perplexity_queries.md audits/run-003_2026-04-06/
mv audits/chapter-13_practitioner_stress_test.yaml audits/run-003_2026-04-06/
mv audits/chapter-13_review_synthesis.yaml audits/run-003_2026-04-06/
mv audits/chapter-13_secondary_sweep.yaml audits/run-003_2026-04-06/

mv audits/chapter-14_bloom_depth_check.yaml audits/run-003_2026-04-06/
mv audits/chapter-14_cascade_results.yaml audits/run-003_2026-04-06/
mv audits/chapter-14_content_audit.yaml audits/run-003_2026-04-06/
mv audits/chapter-14_perplexity_queries.md audits/run-003_2026-04-06/
mv audits/chapter-14_practitioner_stress_test.yaml audits/run-003_2026-04-06/
mv audits/chapter-14_review_synthesis.yaml audits/run-003_2026-04-06/
mv audits/chapter-14_secondary_sweep.yaml audits/run-003_2026-04-06/

mv audits/appendix-security_cascade_results.yaml audits/run-003_2026-04-06/
mv audits/appendix-security_content_audit.yaml audits/run-003_2026-04-06/
mv audits/appendix-security_depth_check.yaml audits/run-003_2026-04-06/
mv audits/appendix-security_perplexity_queries.md audits/run-003_2026-04-06/
mv audits/appendix-security_practitioner_stress_test.yaml audits/run-003_2026-04-06/
mv audits/appendix-security_review_synthesis.yaml audits/run-003_2026-04-06/
mv audits/appendix-security_secondary_sweep.yaml audits/run-003_2026-04-06/
```

### Step 3: Write run-003 manifest

Create `audits/run-003_2026-04-06/run_manifest.yaml`:

```yaml
run_manifest:
  run_id: "run-003"
  date: "2026-04-06"
  run_type: "discovery"
  model: "claude-opus-4.6"
  pipeline: "AD-020 manual Phase 1"
  chapters_audited:
    - chapter-11
    - chapter-12
    - chapter-13
    - chapter-14
    - appendix-security
  gates_run:
    - content_audit
    - practitioner_stress_test
    - bloom_depth_check
    - secondary_sweep
    - cascade_results
    - review_synthesis
  notes: >
    Discovery audits for Ch 11-14 and appendix-security. Originally written as
    loose files in audits/ by a thread that used per-chapter sequential run IDs
    (run-009 through run-013 in internal YAML fields). Reorganized into this
    directory on 2026-04-06 to conform with the run-directory convention
    established by run-001 and run-002. Internal YAML run fields are historical
    and not updated. Ch 11-12 were audited 2026-04-05; Ch 13-14 and
    appendix-security were audited 2026-04-06.
```

### Step 4: Update run-001 manifest

Add a note about Ch 3's incomplete gate coverage. Append to `audits/run-001_2026-04-05/run_manifest.yaml`:

```yaml
  known_gaps:
    chapter-03:
      missing_gates:
        - practitioner_stress_test
        - bloom_depth_check
        - secondary_sweep
        - cascade_results
        - review_synthesis
      note: >
        Ch 3 received only content_audit and perplexity_queries in this run.
        The remaining gates were not executed. Ch 3 was the first chapter
        audited and the full gate pipeline was established during Ch 4.
```

### Step 5: Verify clean state

After moves, `audits/` should contain ONLY:
- `run-001_2026-04-05/` (directory)
- `run-002_2026-04-05/` (directory)
- `run-003_2026-04-06/` (directory)
- No loose YAML or MD files

Verify:
```bash
ls audits/*.yaml audits/*.md 2>/dev/null
# Expected: no output (no loose files remain)

ls -d audits/run-*/
# Expected: run-001_2026-04-05/  run-002_2026-04-05/  run-003_2026-04-06/
```

### Step 6: Commit

```bash
git add audits/
git commit -m "chore: reorganize loose audit files into run-003_2026-04-06

Move Ch 11-14 and appendix-security audit YAMLs from audits/ root into
run-003_2026-04-06/ with manifest. Updates run-001 manifest to document
Ch 3 incomplete gate coverage. Establishes directory-level run IDs as
canonical numbering convention.

Ref: AD-020, regression audit loop design note"
```

## Verification

- [ ] No loose YAML/MD files in `audits/` root
- [ ] `run-003_2026-04-06/` contains 35 files (7 per chapter × 4 chapters + 7 appendix)
- [ ] `run-003_2026-04-06/run_manifest.yaml` exists and is valid YAML
- [ ] `run-001_2026-04-05/run_manifest.yaml` updated with `known_gaps` section
- [ ] `git status` shows only moves (no untracked files in audits/ root)
- [ ] `seldon verify --strict` passes

## Do NOT

- Edit the internal `run` fields in any YAML file (data is immutable)
- Renumber run-001 or run-002 directories
- Move run-002 TEVV data anywhere
- Create any new audit data — this task is organization only
