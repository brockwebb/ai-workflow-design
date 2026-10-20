# CC Task: Batch Figure Rendering and Chapter Insertion (Ch 2-7)

**Date:** 2026-04-03
**Project:** ai-workflow-design
**Priority:** HIGH — Ch 7 has broken `::::{figure}` directives pointing to non-existent PNGs

---

## Problem

1. **Build-breaking:** Ch 7 has two `::::{figure}` directives (lines 73 and 95) pointing at PNG files that don't exist. MyST build will fail.
2. **Systematic gap:** Chapters 2-7 have 14 figure specs written but only Ch 1's two figures have been rendered. Chapters 2-6 have specs but no figure directives in the chapter text. Ch 7 has directives but no rendered images.
3. **No Figure artifacts in Seldon graph.** Nothing tracked.

## Scope

This task has three phases. Phase 1 is the immediate build fix. Phase 2 is the batch render. Phase 3 is chapter insertion and Seldon registration.

---

## Phase 1: Fix Ch 7 Build Break (IMMEDIATE)

**Option A (recommended if PaperBanana render is not immediate):** Comment out the two `::::{figure}` directives in `book/chapter-07.md` with a `<!-- TODO: uncomment when figures are rendered -->` marker so the build doesn't break. This is a temporary fix.

**Option B (if doing full render now):** Skip to Phase 2 and render Ch 7 figures first, then the build break resolves naturally.

If using Option A, the two blocks to comment out:

```
Lines 73-77:
::::{figure} ../assets/diagrams/paperbanana/fig-07-01_error_classification_table.png
:name: fig-07-01
:alt: Error classification table showing three error types, examples, pipeline responses, and priorities
Error classification and pipeline response. [... caption ...]
::::

Lines 95-99:
::::{figure} ../assets/diagrams/paperbanana/fig-07-02_checkpoint_safe_write.png
:name: fig-07-02
:alt: Flow diagram showing the transaction-safe checkpoint write sequence and crash recovery paths
Transaction-safe checkpoint write pattern. [... caption ...]
::::
```

---

## Phase 2: Render All Figure Specs

### PaperBanana-compatible specs (`.txt` method files — ready to render)

These are already in PaperBanana method format. Run PaperBanana on each:

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design/assets/diagrams/paperbanana

# Known config issue: model_config.yaml has wrong model name
# Always override via CLI:
#   --vlm-model gemini-3.1-pro-preview
#   --image-model gemini-3.1-flash-image-preview

# Ch 2
paperbanana run fig-02-01_classification_routing_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview

# Ch 3
paperbanana run fig-03-01_data_quality_routing_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview

# Ch 4
paperbanana run fig-04-01_extraction_pipeline_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview

# Ch 5 (4 figures)
paperbanana run fig-05-01_parallel_consensus_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview
paperbanana run fig-05-02_generator_critic_loop_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview
paperbanana run fig-05-03_llm_as_judge_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview
paperbanana run fig-05-04_topology_comparison_table_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview

# Ch 6 (3 figures)
paperbanana run fig-06-01_parallel_batch_architecture_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview
paperbanana run fig-06-02_model_abstraction_layer_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview
paperbanana run fig-06-03_pike_rules_pipeline_mapping_method.txt --vlm-model gemini-3.1-pro-preview --image-model gemini-3.1-flash-image-preview
```

After each run, inspect `outputs/run_YYYYMMDD_*/final_output.png` and copy the accepted render to the path the chapter directive expects (or will expect).

### Ch 7 specs (`.md` format — need assessment)

The Ch 7 specs are in markdown format, not PaperBanana method format. Assessment needed per figure:

1. **fig-07-01 (Error Classification Table):** This is a TABLE, not a diagram. PaperBanana may not be the right tool. Options:
   - Render as a styled HTML table → screenshot to PNG
   - Render via LaTeX/Typst table → PNG
   - Convert to PaperBanana method format and let it generate an image of a table
   - **Recommended:** Use a script to generate a clean table image (Python matplotlib or similar). The spec is fully detailed.

2. **fig-07-02 (Checkpoint Safe Write):** This is a flow diagram. Could be converted to PaperBanana method format. The spec (`fig-07-02_checkpoint_safe_write.md`) describes a sequential flow with a branch — standard PaperBanana territory.

3. **fig-07-03 (Config Validation Flow):** Same — flow diagram with a binary decision gate. Convert to PaperBanana method format.

**Action:** Convert `fig-07-02` and `fig-07-03` to `.txt` PaperBanana method files and render. For `fig-07-01`, generate the table image via script.

---

## Phase 3: Chapter Insertion and Registration

### Copy rendered PNGs to expected paths

The convention from Ch 7's existing directives: chapter figure directives point to `../assets/diagrams/paperbanana/fig-NN-NN_description.png`. This means final PNGs should live at:

```
assets/diagrams/paperbanana/fig-02-01_classification_routing.png
assets/diagrams/paperbanana/fig-03-01_data_quality_routing.png
assets/diagrams/paperbanana/fig-04-01_extraction_pipeline.png
assets/diagrams/paperbanana/fig-05-01_parallel_consensus.png
assets/diagrams/paperbanana/fig-05-02_generator_critic_loop.png
assets/diagrams/paperbanana/fig-05-03_llm_as_judge.png
assets/diagrams/paperbanana/fig-05-04_topology_comparison_table.png
assets/diagrams/paperbanana/fig-06-01_parallel_batch_architecture.png
assets/diagrams/paperbanana/fig-06-02_model_abstraction_layer.png
assets/diagrams/paperbanana/fig-06-03_pike_rules_pipeline_mapping.png
assets/diagrams/paperbanana/fig-07-01_error_classification_table.png
assets/diagrams/paperbanana/fig-07-02_checkpoint_safe_write.png
assets/diagrams/paperbanana/fig-07-03_config_validation_flow.png
```

### Add `::::{figure}` directives to Chapters 2-6

For each chapter, determine the appropriate insertion point for each figure. The figure should appear immediately after the prose that introduces the concept it illustrates. Follow Ch 7's directive format:

```
::::{figure} ../assets/diagrams/paperbanana/fig-NN-NN_description.png
:name: fig-NN-NN
:alt: [descriptive alt text]
[Caption from the figure spec's ## Caption section]
::::
```

**Insertion point guidance by figure:**
- Each figure spec has a `## Caption` section — use that for the directive caption.
- Each figure spec describes what concept it illustrates — find the corresponding prose in the chapter and insert the directive immediately after.
- Do NOT insert figures at the end of sections. Insert them inline where the concept is discussed.

### Uncomment Ch 7 directives (if Phase 1 used Option A)

If the directives were commented out in Phase 1, uncomment them.

### Add fig-07-03 directive to Ch 7

fig-07-03 (Config Validation Flow) has a spec but no directive in chapter-07.md. Find the appropriate insertion point in the Config-Driven Architecture section and add the directive.

### Register Figure artifacts in Seldon

After all figures are rendered and inserted, register each as a `Figure` artifact in the Seldon graph and link to the chapter it belongs to.

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
seldon artifact create --type Figure --name "fig-07-01" --path "assets/diagrams/paperbanana/fig-07-01_error_classification_table.png"
seldon link create fig-07-01 --rel illustrates --target chapter-07
# ... repeat for all figures
seldon verify
```

### Run `myst build --html` to verify no broken references

---

## Do NOT

- Modify any chapter prose content — only add/uncomment figure directives
- Change figure spec files — they are the source of truth for what should be rendered
- Use `assets/images/` — the convention from Ch 7 is `assets/diagrams/paperbanana/`
- Skip the PaperBanana CLI overrides — the config file has the wrong model name
- Render fig-07-01 (table) through PaperBanana without first assessing whether the table format is appropriate for PaperBanana's image generation approach
