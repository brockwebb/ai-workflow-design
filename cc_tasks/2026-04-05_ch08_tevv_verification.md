# CC Task: TEVV Verification Audit — Chapter 8

**Date:** 2026-04-05
**Project:** ai-workflow-design
**Reference:** AD-020, regression audit loop design note

---

## Context

Chapter 8 has been revised since its run-001 audit. This task runs the same AD-020 audit on the revised chapter and produces a delta summary comparing run-001 and run-002 scores.

**Lessons from Ch 9 TEVV run:**
- The delta summary MUST read baseline scores directly from the run-001 YAML files — do NOT re-score or recall from memory. Transcribe the `summary:` block verbatim from `audits/run-001_2026-04-05/chapter-08_review_synthesis.yaml` and the individual gate files.
- Output all files to `audits/run-002_2026-04-05/` (directory already exists from Ch 9 run).

## Instructions

1. Read the auditor protocol from `.claude/agents/auditor.md`.
2. Run `seldon ontology list --verbose` from the ai-workflow-design project directory.
3. Read `book/chapter-08.md` (the revised version).
4. Read `book/references.bib` for citation context.
5. **Load cross-chapter context:** Run `seldon paper context <name> --format yaml` for sibling chapters (chapter-01 through chapter-10, excluding chapter-08). If unavailable, the semantic anchor data is in the graph — query it directly.
6. Execute the full AD-020 audit:
   - Tier 1: Content audit → `audits/run-002_2026-04-05/chapter-08_content_audit.yaml`
   - Tier 2a: Practitioner stress test → `audits/run-002_2026-04-05/chapter-08_practitioner_stress_test.yaml`
   - Tier 2b: Bloom depth check → `audits/run-002_2026-04-05/chapter-08_bloom_depth_check.yaml`
   - Tier 3: Secondary sweep → `audits/run-002_2026-04-05/chapter-08_secondary_sweep.yaml`
   - Cascade check → `audits/run-002_2026-04-05/chapter-08_cascade_results.yaml`
   - Perplexity queries → `audits/run-002_2026-04-05/chapter-08_perplexity_queries.md`
   - Review synthesis → `audits/run-002_2026-04-05/chapter-08_review_synthesis.yaml`

7. **Read the run-001 baseline files directly:**
   - `audits/run-001_2026-04-05/chapter-08_review_synthesis.yaml`
   - `audits/run-001_2026-04-05/chapter-08_practitioner_stress_test.yaml`
   - `audits/run-001_2026-04-05/chapter-08_bloom_depth_check.yaml`

8. **Produce delta summary.** Write `audits/run-002_2026-04-05/chapter-08_delta_summary.yaml`.

   **CRITICAL:** The `baseline` values in `score_comparison` must be copied verbatim from the run-001 YAML `summary:` blocks. Do NOT re-derive, re-score, or recall from memory. Read the file, copy the numbers.

   Structure:
   ```yaml
   delta_summary:
     chapter: "book/chapter-08.md"
     baseline_run: "run-001_2026-04-05"
     current_run: "run-002_2026-04-05"

     cluster_resolution:
       - baseline_cluster_id: <id>
         baseline_title: "<from run-001 review_synthesis>"
         baseline_severity: <from run-001>
         resolution: resolved | partially_resolved | still_open
         evidence: "<specific textual evidence>"
         remaining_gaps: []

     score_comparison:
       practitioner_stress_test:
         baseline: "<COPIED from run-001 file summary block>"
         current: "<from run-002>"
         delta: "<change>"
       # ... same for bloom, citations, visuals, word count, etc.

     new_findings: []
     verdict: "improved | stable | regressed"
     verdict_rationale: "<brief>"
   ```

9. Update the run manifest:
   Read `audits/run-002_2026-04-05/run_manifest.yaml`, add `chapter-08` to `chapters_audited` list.

10. Mark complete:
    ```bash
    seldon cc complete cc_tasks/2026-04-05_ch08_tevv_verification.md
    ```

## Success Criteria

1. Full AD-020 audit output in `audits/run-002_2026-04-05/` for Ch 8
2. `chapter-08_delta_summary.yaml` with baseline values transcribed from run-001 files (not re-scored)
3. Run manifest updated to include chapter-08
4. No run-001 files modified

## Do NOT

- Modify any run-001 files
- Re-score or re-derive baseline values — read them from the run-001 YAML files
- Edit `book/chapter-08.md`
- Create Issue artifacts in the graph
