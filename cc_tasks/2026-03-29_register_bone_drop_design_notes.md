# CC Task: Register Bone Drop Design Notes in Seldon

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Type:** Housekeeping — artifact registration

---

## Task

Four design notes files were written to `cc_tasks/` in error during Session 6. They are design notes, not CC tasks. Brock will move them to `docs/` manually. Once moved, register them as Seldon artifacts.

## Files to Register (after Brock moves them to docs/)

| Current Location (wrong) | Correct Location | Artifact Type | Description |
|--------------------------|-----------------|---------------|-------------|
| `cc_tasks/2026-03-29_bone_drop_ch06_parallelization.md` | `docs/bone_drop_ch06_parallelization.md` | DesignNote | Parallelization patterns, rate limiting, checkpoint/resume, infrastructure reinvention tax. Target: Ch 6. |
| `cc_tasks/2026-03-29_bone_drop_ch13_shadow_it.md` | `docs/bone_drop_ch13_shadow_it.md` | DesignNote | Shadow IT as governance failure, access gaps degrading competence, public data vs shadow IT distinction. Target: Ch 13. |
| `cc_tasks/2026-03-29_bone_drop_ch07_ch11_ai_partner_stochasticity.md` | `docs/bone_drop_ch07_ch11_ai_partner_stochasticity.md` | DesignNote | Recursive stochasticity problem — building LLM pipelines with LLM tools. Target: Ch 7, Ch 11. |
| `cc_tasks/2026-03-29_bone_drop_ch10_seldon_origin.md` | `docs/bone_drop_ch10_seldon_origin.md` | DesignNote | Seldon origin story, provenance reconstruction nightmare, reference librarian tax, public data distinction. Target: Ch 10. |

## Registration

For each file, after confirming it exists in `docs/`:

1. `seldon artifact create` with type `DesignNote`
2. `seldon link create` with `informs` relationship to the target chapter artifact(s)

## Also

Delete the partially written duplicate file that was started at `docs/bone_drop_ch13_shadow_it.md` (incomplete write from Session 6 — Brock will confirm whether this partial exists before deletion).

## Verification

After registration, `seldon verify` should show no orphan files in `docs/` for these four.
