# CC Task: Figure Deployment — JPEG→PNG Conversion + Path Normalization

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** Handoff `seldon/handoffs/2026-04-07_decision_gates_batch_b.md` (Image Situation Diagnosed), session inventory analysis
**Scope:** Copy PaperBanana rendered figures to `book/images/`, convert JPEG→PNG where needed, normalize all chapter `{figure}` directive paths, update figure registry, clean up stale run directories.

---

## Background

PaperBanana outputs JPEG image data with `.png` file extensions. All files in `assets/diagrams/paperbanana/*.png` are actually JPEG/JFIF (300 DPI, 2752x1536). The five figures already in `book/images/` (Ch 1-4) were previously converted to actual PNG data. Chapters 5-7 reference the paperbanana source files directly via `../assets/diagrams/paperbanana/` paths, which are the mislabeled JPEGs. This causes rendering failures in some build targets.

**Verification command:** `file assets/diagrams/paperbanana/fig-05-01_parallel_consensus.png` will report "JPEG image data" — confirming the mismatch.

---

## Prerequisites

- Ensure `Pillow` or `ImageMagick` is available for JPEG→PNG conversion
- Preferred conversion: `convert input.png output.png` (ImageMagick) or `python3 -c "from PIL import Image; Image.open('input.png').save('output.png', 'PNG')"`

---

## Part A: Convert and Deploy Figures to `book/images/`

For each file listed below, convert from JPEG to actual PNG and save to `book/images/`. Skip files that already exist in `book/images/` as real PNGs (Ch 1-4 are already done).

**Already in `book/images/` as real PNGs — SKIP these (verify only):**
1. `fig-01-01a_naive.png` — verify `file` reports PNG, not JPEG
2. `fig-01-01b_designed.png` — verify
3. `fig-02-01_classification_routing.png` — verify
4. `fig-03-01_data_quality_routing.png` — verify
5. `fig-04-01_extraction_pipeline.png` — verify

**Convert and copy these (source: `assets/diagrams/paperbanana/` → dest: `book/images/`):**
6. `fig-05-01_parallel_consensus.png`
7. `fig-05-02_generator_critic_loop.png`
8. `fig-05-03_llm_as_judge.png`
9. `fig-06-01_parallel_batch_architecture.png`
10. `fig-06-02_model_abstraction_layer.png`
11. `fig-06-03_pike_rules_pipeline_mapping.png`
12. `fig-07-02_checkpoint_safe_write.png`
13. `fig-07-03_config_validation_flow.png`
14. `fig-11-01_evaluation_framework_template.png`
15. `ch13_governance_models.png` — rename to `fig-13-01_governance_models.png` during copy (follow naming convention)

**Conversion command pattern:**
```bash
python3 -c "from PIL import Image; Image.open('assets/diagrams/paperbanana/FILENAME').save('book/images/FILENAME', 'PNG')"
```
Or with ImageMagick:
```bash
convert assets/diagrams/paperbanana/FILENAME PNG:book/images/FILENAME
```

**Do NOT convert or copy:**
- `fig-05-04_topology_comparison_table.png` — redundant with Ch 5's MyST table (line ~130). No figure directive exists or is needed.
- `ch14_cost_trajectory.md` — method file only, no rendered PNG exists yet. Requires separate PaperBanana run.
- `fig-07-01_error_classification_table.md` — method file only, no rendered PNG exists yet.

---

## Part B: Update Chapter Figure Directive Paths

Update all `{figure}` directives that currently point to `../assets/diagrams/paperbanana/` to use `images/` instead (relative to `book/`).

### chapter-05.md
**Line ~40:**
```
```{figure} ../assets/diagrams/paperbanana/fig-05-01_parallel_consensus.png
```
→
```
```{figure} images/fig-05-01_parallel_consensus.png
```

**Line ~74:**
```
```{figure} ../assets/diagrams/paperbanana/fig-05-02_generator_critic_loop.png
```
→
```
```{figure} images/fig-05-02_generator_critic_loop.png
```

**Line ~98:**
```
```{figure} ../assets/diagrams/paperbanana/fig-05-03_llm_as_judge.png
```
→
```
```{figure} images/fig-05-03_llm_as_judge.png
```

### chapter-06.md
**Line ~57:**
```
```{figure} ../assets/diagrams/paperbanana/fig-06-01_parallel_batch_architecture.png
```
→
```
```{figure} images/fig-06-01_parallel_batch_architecture.png
```

**Line ~91:**
```
```{figure} ../assets/diagrams/paperbanana/fig-06-02_model_abstraction_layer.png
```
→
```
```{figure} images/fig-06-02_model_abstraction_layer.png
```

**Line ~111:**
```
```{figure} ../assets/diagrams/paperbanana/fig-06-03_pike_rules_pipeline_mapping.png
```
→
```
```{figure} images/fig-06-03_pike_rules_pipeline_mapping.png
```

### chapter-07.md
**Line ~43:**
```
```{figure} ../assets/diagrams/paperbanana/fig-07-03_config_validation_flow.png
```
→
```
```{figure} images/fig-07-03_config_validation_flow.png
```

**Line ~105:**
```
::::{figure} ../assets/diagrams/paperbanana/fig-07-02_checkpoint_safe_write.png
```
→
```
::::{figure} images/fig-07-02_checkpoint_safe_write.png
```

---

## Part C: Add Figure Directives for Unreferenced Figures

### chapter-11.md
Add a `{figure}` directive for `fig-11-01_evaluation_framework_template.png`. 

**Action:** Read the chapter and find the most appropriate location for an evaluation framework figure. Look for a section discussing evaluation frameworks, structured evaluation, or evaluation templates. Insert:

```
```{figure} images/fig-11-01_evaluation_framework_template.png
:name: fig-11-01
:alt: Evaluation framework template showing structured dimensions for workflow assessment
Evaluation framework template. [Read the figure content and write an appropriate caption matching the chapter's voice.]
```

### chapter-13.md
Add a `{figure}` directive for `fig-13-01_governance_models.png`.

**Action:** Read the chapter and find the most appropriate location for a governance models figure. Look for a section discussing governance models, governance structures, or institutional governance patterns. Insert:

```
```{figure} images/fig-13-01_governance_models.png
:name: fig-13-01
:alt: Governance models comparison showing different institutional approaches
Governance models comparison. [Read the figure content and write an appropriate caption matching the chapter's voice.]
```

**Note for both:** View the actual images to write accurate captions. If the image content doesn't match any section well, note the mismatch rather than forcing insertion.

---

## Part D: Update Figure Registry

Overwrite `book/figure-registry.md` with the complete registry:

```markdown
# Figure & Table Registry

<!-- This file tracks all figures and tables across the book -->
<!-- Figure source files: assets/diagrams/paperbanana/ -->
<!-- Rendered figures: book/images/ -->

## Figures

| Figure ID | Chapter | Title | Source Method File | Status |
|-----------|---------|-------|--------------------|--------|
| fig-01-01a | Ch 1 | The Naive Workflow | fig-01-01a_naive_method.txt | Deployed |
| fig-01-01b | Ch 1 | The Designed Workflow | fig-01-01b_designed_method.txt | Deployed |
| fig-02-01 | Ch 2 | Classification Routing | fig-02-01_classification_routing_method.txt | Deployed |
| fig-03-01 | Ch 3 | Data Quality Routing | fig-03-01_data_quality_routing_method.txt | Deployed |
| fig-04-01 | Ch 4 | Extraction Pipeline | fig-04-01_extraction_pipeline_method.txt | Deployed |
| fig-05-01 | Ch 5 | Parallel Consensus | fig-05-01_parallel_consensus_method.txt | Deployed |
| fig-05-02 | Ch 5 | Generator-Critic Loop | fig-05-02_generator_critic_loop_method.txt | Deployed |
| fig-05-03 | Ch 5 | LLM-as-Judge | fig-05-03_llm_as_judge_method.txt | Deployed |
| fig-06-01 | Ch 6 | Parallel Batch Architecture | fig-06-01_parallel_batch_architecture_method.txt | Deployed |
| fig-06-02 | Ch 6 | Model Abstraction Layer | fig-06-02_model_abstraction_layer_method.txt | Deployed |
| fig-06-03 | Ch 6 | PIKE Rules Pipeline Mapping | fig-06-03_pike_rules_pipeline_mapping_method.txt | Deployed |
| fig-07-02 | Ch 7 | Checkpoint Safe Write | fig-07-02_checkpoint_safe_write.md | Deployed |
| fig-07-03 | Ch 7 | Config Validation Flow | fig-07-03_config_validation_flow.md | Deployed |
| fig-11-01 | Ch 11 | Evaluation Framework Template | fig-11-01_evaluation_framework_template_method.txt | Deployed |
| fig-13-01 | Ch 13 | Governance Models | ch13_governance_models.md | Deployed |
| fig-07-01 | Ch 7 | Error Classification Table | fig-07-01_error_classification_table.md | Method only — needs PaperBanana render |
| fig-14-01 | Ch 14 | Cost Trajectory | ch14_cost_trajectory.md | Method only — needs PaperBanana render |

## Tables

| Table ID | Chapter | Title | Status |
|----------|---------|-------|--------|
| (tracked inline in chapter source) | — | — | — |
```

---

## Part E: Clean Up Stale Run Directories

Delete all `run_*` directories in both locations:

```bash
rm -rf book/images/run_*
rm -rf assets/diagrams/paperbanana/run_*
```

These are PaperBanana generation artifacts (intermediate outputs from each render attempt). They are not referenced by any chapter and bloat the repo.

**Count before deletion:** List the directories first, confirm count, then delete.

---

## Verification Checklist

After all edits:
- [ ] `file book/images/fig-*.png` — ALL report "PNG image data", NONE report "JPEG"
- [ ] `file book/images/ch*.png` — should not exist (ch13 renamed to fig-13-01)
- [ ] `grep -r 'assets/diagrams/paperbanana' book/chapter-*.md` — should return NO results
- [ ] `grep -r 'images/' book/chapter-01.md book/chapter-02.md book/chapter-03.md book/chapter-04.md book/chapter-05.md book/chapter-06.md book/chapter-07.md` — all should use `images/` prefix
- [ ] `ls book/images/run_*` — should return "No such file or directory"
- [ ] `ls assets/diagrams/paperbanana/run_*` — should return "No such file or directory"
- [ ] Ch 11 has a `{figure}` directive referencing `images/fig-11-01_evaluation_framework_template.png`
- [ ] Ch 13 has a `{figure}` directive referencing `images/fig-13-01_governance_models.png`
- [ ] `book/figure-registry.md` lists all 15 deployed figures + 2 method-only entries
- [ ] `myst build --html` in `book/` directory completes without figure-related errors (if build is available)

## Files Modified

`book/chapter-05.md`, `book/chapter-06.md`, `book/chapter-07.md`, `book/chapter-11.md`, `book/chapter-13.md`, `book/figure-registry.md`

## Files Created

Figures copied to `book/images/`: 10 new PNG files

## Files Deleted

All `run_*` directories in `book/images/` and `assets/diagrams/paperbanana/`
