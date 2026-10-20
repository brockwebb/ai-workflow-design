# CC Task: Restructure Audits Directory and Re-audit Ch 9 (TEVV Verification)

**Date:** 2026-04-05
**Project:** ai-workflow-design
**Reference:** Design note `seldon/docs/design/2026-04-05_regression_audit_loop.md`, AD-020

---

## Context

The `audits/` directory currently holds 44 files from the first audit pass in a flat structure. A second audit pass (TEVV verification after revisions) would double the file count with no way to distinguish which run produced which files.

This task restructures the audits directory into dated run subdirectories, then runs a full AD-020 audit on the revised Ch 9 as the first TEVV verification pass.

## Part A: Restructure Audits Directory

### 1. Create run-001 directory

```bash
mkdir -p audits/run-001_2026-04-05
```

### 2. Move all existing audit files into run-001

Move every file currently in `audits/` into `audits/run-001_2026-04-05/`. Do NOT move subdirectories if any exist.

```bash
mv audits/*.yaml audits/run-001_2026-04-05/
mv audits/*.md audits/run-001_2026-04-05/
```

### 3. Create run manifest for run-001

Write `audits/run-001_2026-04-05/run_manifest.yaml`:

```yaml
run_manifest:
  run_id: "run-001"
  date: "2026-04-05"
  run_type: "discovery"
  model: "claude-opus-4.6"
  pipeline: "AD-020 manual Phase 1"
  chapters_audited:
    - chapter-03
    - chapter-04
    - chapter-05
    - chapter-06
    - chapter-07
    - chapter-08
    - chapter-09
    - chapter-10
  gates_run:
    - content_audit
    - practitioner_stress_test
    - bloom_depth_check
    - secondary_sweep
    - cascade_results
  notes: "First full audit pass across Ch 3-10. Discovery mode — no prior findings to compare against."
```

### 4. Create run-002 directory

```bash
mkdir -p audits/run-002_2026-04-05
```

## Part B: Re-audit Ch 9 (TEVV Verification)

Run the full AD-020 audit on `book/chapter-09.md` using the same gate configuration as run-001. This is NOT a regression-specific audit — it is the same audit, run on the revised chapter.

### Instructions

1. Read the auditor protocol from the project's `.claude/agents/auditor.md` (symlinked from seldon).
2. Run `seldon ontology list --verbose` from the ai-workflow-design project directory.
3. Read `book/chapter-09.md` (the revised version).
4. Read `book/references.bib` for citation context.
5. **Load cross-chapter context:** Run `seldon paper context <chapter-name> --format yaml` for all sibling chapters (chapter-01 through chapter-10, excluding chapter-09). This provides compressed semantic anchor data (core_argument, claims, forward_promises, terminology_defined) for cross-chapter awareness.

   If `seldon paper context` is not available or returns empty for some chapters, read the semantic anchor properties directly:
   ```bash
   cd /Users/brock/Documents/GitHub/ai-workflow-design
   seldon paper context chapter-01.md --format yaml
   seldon paper context chapter-02.md --format yaml
   # ... etc for all siblings
   ```

6. Execute the full audit per the auditor protocol:
   - Tier 1: Content audit → `audits/run-002_2026-04-05/chapter-09_content_audit.yaml`
   - Tier 2a: Practitioner stress test → `audits/run-002_2026-04-05/chapter-09_practitioner_stress_test.yaml`
   - Tier 2b: Bloom depth check → `audits/run-002_2026-04-05/chapter-09_bloom_depth_check.yaml`
   - Tier 3: Secondary sweep → `audits/run-002_2026-04-05/chapter-09_secondary_sweep.yaml`
   - Cascade check → `audits/run-002_2026-04-05/chapter-09_cascade_results.yaml`
   - Perplexity queries → `audits/run-002_2026-04-05/chapter-09_perplexity_queries.md`
   - Review synthesis → `audits/run-002_2026-04-05/chapter-09_review_synthesis.yaml`

7. After producing the review synthesis, read the run-001 synthesis for comparison:
   `audits/run-001_2026-04-05/chapter-09_review_synthesis.yaml`

8. **Produce delta summary.** Write `audits/run-002_2026-04-05/chapter-09_delta_summary.yaml`:

```yaml
delta_summary:
  chapter: "book/chapter-09.md"
  baseline_run: "run-001_2026-04-05"
  current_run: "run-002_2026-04-05"
  baseline_date: "2026-04-05"
  current_date: "2026-04-05"

  cluster_resolution:
    - baseline_cluster_id: C1
      baseline_title: "<from run-001>"
      baseline_severity: high
      resolution: resolved | partially_resolved | still_open
      evidence: "<specific textual evidence from revised chapter>"
      remaining_gaps: []

    # ... one entry per baseline cluster

  score_comparison:
    practitioner_stress_test:
      baseline: "<run-001 score>"
      current: "<run-002 score>"
      delta: "<change>"
    bloom_ceiling:
      baseline: "<run-001>"
      current: "<run-002>"
      delta: "<change>"
    citation_count:
      baseline: "<run-001>"
      current: "<run-002>"
      delta: "<change>"
    visual_elements:
      baseline: "<run-001>"
      current: "<run-002>"
      delta: "<change>"
    reflection_prompts:
      baseline: "<run-001>"
      current: "<run-002>"
      delta: "<change>"
    word_count:
      baseline: "<run-001>"
      current: "<run-002>"
      delta: "<change>"

  new_findings: []  # findings in run-002 not present in run-001

  verdict: "improved | stable | regressed"
  verdict_rationale: "<brief explanation>"
```

### 9. Create run manifest for run-002

Write `audits/run-002_2026-04-05/run_manifest.yaml`:

```yaml
run_manifest:
  run_id: "run-002"
  date: "2026-04-05"
  run_type: "tevv_verification"
  model: "claude-sonnet-4.6"  # or whatever model CC is using
  pipeline: "AD-020 manual Phase 1"
  baseline_run: "run-001_2026-04-05"
  chapters_audited:
    - chapter-09
  gates_run:
    - content_audit
    - practitioner_stress_test
    - bloom_depth_check
    - secondary_sweep
    - cascade_results
  cross_chapter_context: "semantic anchors from seldon paper context for all siblings"
  notes: "TEVV verification pass on Ch 9 after revision. Compares against run-001 baseline."
```

### 10. Mark complete

```bash
seldon cc complete cc_tasks/2026-04-05_ch09_tevv_verification.md
```

## Success Criteria

1. All existing audit files moved to `audits/run-001_2026-04-05/` with run manifest
2. Full AD-020 audit output in `audits/run-002_2026-04-05/` for Ch 9
3. `chapter-09_delta_summary.yaml` produced with cluster-by-cluster resolution scoring and score comparison
4. `audits/` root directory contains only `run-001_2026-04-05/` and `run-002_2026-04-05/` subdirectories
5. No files overwritten from run-001

## Do NOT

- Modify any run-001 files
- Skip any audit gate — run the full pipeline even if you expect some findings to be resolved
- Edit `book/chapter-09.md` — audit only
- Create Issue artifacts in the graph
