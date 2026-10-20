# CC Task: Figure Cleanup, Standardization, and Ch 14 Figure Insertion

**Date:** 2026-04-07
**Scope:** PaperBanana figure hygiene across the project

---

## Context

An audit of PaperBanana method files vs. rendered PNGs vs. chapter references revealed three issues:

1. Two PaperBanana method files (`fig-05-04`, `fig-07-01`) spec visual table renders for content that already exists as MyST text tables in the chapter source. The rendered PNGs are redundant — a table is the right format for a table, not a figure. Author decision: delete the specs, keep the MyST tables.

2. The Ch 13 governance figure has a naming mismatch: the PaperBanana source is `ch13_governance_models.png` but the deployed copy in `book/images/` is `fig-13-01_governance_models.png`. All other figures use the `fig-XX-YY_` prefix convention. The source file should be renamed to match.

3. `ch14_cost_trajectory.md` is a method file for a line chart (cumulative cost: AI pipeline vs. manual process over 5 years). This is a genuine figure — a trend visualization, not a table duplicate. It needs a PaperBanana render, filename standardization, deployment to `book/images/`, and insertion into Ch 14.

---

## Edit 1: Delete redundant PaperBanana table specs

**Decision rationale:** Tables rendered as PNGs lose searchability, accessibility, and maintainability. The MyST text tables in Ch 5 (`tbl-05-04`, line 130) and Ch 7 (`tbl-07-01`, line 79) are the correct format. The PaperBanana specs were written to produce visual versions but the text tables already serve the purpose. Figures are for diagrams and charts — visual content that cannot be represented as text.

**Actions:**

1. Delete `assets/diagrams/paperbanana/fig-05-04_topology_comparison_table_method.txt`
2. Delete `assets/diagrams/paperbanana/fig-05-04_topology_comparison_table.png` (the rendered PNG that was never deployed)
3. Delete `assets/diagrams/paperbanana/fig-07-01_error_classification_table.md`
4. No chapter file changes needed — neither figure was ever referenced in chapter text.

---

## Edit 2: Standardize Ch 13 PaperBanana source filename

**Convention:** All PaperBanana output PNGs use the pattern `fig-XX-YY_descriptive_name.png`. The Ch 13 source breaks this.

**Actions:**

1. Rename `assets/diagrams/paperbanana/ch13_governance_models.png` to `assets/diagrams/paperbanana/fig-13-01_governance_models.png`
2. Rename `assets/diagrams/paperbanana/ch13_governance_models.md` to `assets/diagrams/paperbanana/fig-13-01_governance_models.md`
3. No changes to `book/images/fig-13-01_governance_models.png` (already correctly named at deploy target)
4. No changes to `book/chapter-13.md` (already references `images/fig-13-01_governance_models.png`)

---

## Edit 3: Rename Ch 14 cost trajectory method file

**Convention consistency:** Same as Edit 2.

**Actions:**

1. Rename `assets/diagrams/paperbanana/ch14_cost_trajectory.md` to `assets/diagrams/paperbanana/fig-14-01_cost_trajectory.md`

---

## Edit 4: PaperBanana render of fig-14-01 (REQUIRES BROCK)

This step cannot be executed by CC. Brock must run PaperBanana on his machine.

**Method file:** `assets/diagrams/paperbanana/fig-14-01_cost_trajectory.md`

**CLI (with model overrides):**
```
paperbanana render assets/diagrams/paperbanana/fig-14-01_cost_trajectory.md \
  --vlm-model gemini-3.1-pro-preview \
  --image-model gemini-3.1-flash-image-preview
```

**Output:** `assets/diagrams/paperbanana/fig-14-01_cost_trajectory.png`

**Deploy:** Copy rendered PNG to `book/images/fig-14-01_cost_trajectory.png`

**Human visual QA required** — PaperBanana critic rubber-stamps (known JSON parse bug).

---

## Edit 5: Insert fig-14-01 into chapter-14.md

**Insertion point:** After the paragraph ending "the manual process costs \$23,200 every time." (currently line 38) and before the heading `## The Cost Taxonomy` (currently line 40).

**Insert this block:**

```markdown

```{figure} images/fig-14-01_cost_trajectory.png
:name: fig-14-01
:alt: Line chart showing cumulative cost comparison between AI pipeline and manual process over five years, with AI pipeline costs nearly flat after initial development investment while manual process costs climb linearly

Cumulative cost comparison: AI pipeline vs. manual process over five years. Development cost is recovered within the first cycle. The gap compounds annually.
```

```

**Note:** The blank line before and after the figure directive is required for MyST parsing.

---

## Edit 6: Update figure-registry.md

**Changes to existing rows:**

1. Row for `fig-07-01`: DELETE entire row (method file deleted in Edit 1)
2. Row for `fig-14-01`: Change status from `Method only — needs PaperBanana render` to `Deployed`; change source method file from `ch14_cost_trajectory.md` to `fig-14-01_cost_trajectory.md`
3. Row for `fig-13-01`: Change source method file from `ch13_governance_models.md` to `fig-13-01_governance_models.md`

**No new rows needed.** `fig-05-04` was never in the registry as deployed; its method file row does not exist (it was only a rendered PNG + method txt, both now deleted).

---

## Execution Order

1. Edits 1-3 (deletions and renames) — CC can execute
2. Edit 4 (PaperBanana render) — **Brock only**
3. Edit 5 (chapter insertion) — CC can execute after Edit 4 is confirmed
4. Edit 6 (registry update) — CC can execute alongside Edit 5

**CC should execute Edits 1-3 and 6 (partial: fig-13-01 rename only) immediately. Edits 4-5 and 6 (fig-14-01 status) are gated on Brock's PaperBanana render.**

---

## Verification

After all edits:
- `grep -r "fig-05-04\|fig-07-01\|ch13_governance" assets/diagrams/paperbanana/` should return nothing
- `ls book/images/fig-14-01_cost_trajectory.png` should exist
- `grep "fig-14-01" book/chapter-14.md` should return the figure directive
- `grep "fig-07-01\|fig-05-04" book/figure-registry.md` should return nothing
- Build: `cd book && myst build --html` should complete with no broken figure warnings
