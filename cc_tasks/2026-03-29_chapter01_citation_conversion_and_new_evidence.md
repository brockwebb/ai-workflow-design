# CC Task: Convert Chapter 1 Citations to MyST Roles and Add New Evidence

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** `2026-03-29_citation_infrastructure_and_bibliography.md` (must execute first)

---

## Objective

Convert all plain-text inline citations in `book/chapter-01.md` to proper MyST `{cite:t}` (narrative) or `{cite:p}` (parenthetical) roles. Add newly verified evidence (DORA 2024, METR full citation, model collapse references, inference-time analogy text). Remove `[NEEDS]` placeholders that are now resolved.

## Rationale

Chapter 1 currently uses plain prose citations like `Huang et al. (2024)` and `Madaan et al. (2023)`. These render as unlinked text in HTML and produce no bibliography connection in PDF. Converting to `{cite:t}` / `{cite:p}` roles ensures both build targets resolve citations properly with hover popups (HTML) and formatted references (PDF).

## Changes

### 1. Citation Role Conversions

All replacements below are exact find-and-replace operations. The `{cite:t}` role is used where the author name is the grammatical subject. The `{cite:p}` role is used for parenthetical citations at the end of a clause.

| Current plain text | Replacement |
|---|---|
| `Huang et al. (2024)` | `{cite:t}`huang_2024`` |
| `Madaan et al. (2023)` | `{cite:t}`madaan_2023`` |
| `Yang et al. (2025)` | `{cite:t}`yang_2025`` |
| `Xu et al. (2024)` | `{cite:t}`xu_2024`` |
| `Pan et al. (2024)` | `{cite:t}`pan_2024`` |
| `Lee et al., 2025` | `{cite:t}`lee_2025`` |
| `Dan Shapiro (2026)` | `{cite:t}`shapiro_2026`` |
| `METR (2025)` | `{cite:t}`becker_2025`` |

**Note:** The METR citation key is `becker_2025` (first author) not `metr_2025`. When used in narrative context where "METR" is the subject, write: "A randomized controlled trial by METR {cite:p}`becker_2025`" — keeping METR as prose and the citation as parenthetical. Alternatively, if the sentence structure uses the study as subject, rewrite to: "{cite:t}`becker_2025` studied 16 experienced open-source developers..."

### 2. Resolve the METR `[NEEDS]` placeholder

Find:
```
[NEEDS: METR RCT full citation details. Published July 2025. Verify author list and venue.]
```

Delete this placeholder. The citation is now fully resolved in `references.bib` as `becker_2025`.

### 3. Add DORA 2024 evidence to the productivity perception gap

In the section containing the METR RCT discussion (the paragraph starting "There is empirical support for the gap between perceived and actual productivity"), add the DORA finding as a second evidence layer. Insert a new paragraph immediately after the METR paragraph:

```markdown
This perception gap is not limited to a small-sample study. The 2024 Accelerate State of DevOps Report {cite:p}`dora_2024`, surveying over 39,000 professionals globally, found the same pattern at scale: 75% of developers self-reported productivity gains from AI tools, while measured delivery metrics told a different story. Every 25% increase in AI adoption correlated with a 1.5% dip in delivery speed and a 7.2% drop in system stability. The METR result is the RCT; the DORA result is the large-sample observational confirmation. Together they establish that the gap between perceived and actual AI-assisted productivity is robust across methodologies and sample sizes. When people report that AI has accelerated their work, the evidence suggests they may be wrong about both the direction and the magnitude of the effect.
```

### 4. Resolve the model collapse analogy `[NEEDS]` placeholder

Find the block:
```
[NEEDS: verify whether the analogy between inference-time self-refinement and training-time model collapse has been made explicitly in the literature. If not, this is an original observation worth developing: model collapse (training on own outputs) degrades the model over time; iterative self-refinement at inference time is a structurally similar dynamic, with the system consuming its own output and converging on its own biases. The training-time and inference-time versions may share more formal structure than the current literature acknowledges.]
```

Replace with:

```markdown
There is a structural resemblance between inference-time self-refinement degradation and training-time model collapse. Model collapse occurs when models are trained recursively on their own outputs, progressively degrading until the model becomes useless {cite:p}`shumailov_2024`. Self-consuming generative models, as {cite:t}`alemohammad_2023` demonstrated, go "MAD" — they lose diversity and converge on a narrow subset of their output space. At inference time, iterative self-refinement exhibits a structurally similar dynamic: the system consumes its own output, amplifies its own biases, and converges on increasingly confident but not increasingly correct answers.

The mechanisms are different. Training-time collapse involves weight updates on synthetic data eroding the learned distribution. Inference-time degradation involves context window pollution and the model's inability to reliably evaluate its own output — no weights change. But the pattern is shared: recursive self-consumption degrades output quality. The practical implication is the same in both cases: external signal is the remedy. Fresh training data prevents model collapse; external evaluation prevents self-refinement degradation. Design accordingly.
```

### 5. Convert the `*AI for Official Statistics*` reference

Find:
```
*AI for Official Statistics* (the predecessor to this book)
```

This is fine as prose (it's referencing the book by title in running text). But add a parenthetical citation after it:

```
*AI for Official Statistics* {cite:p}`webb_2026_ai4stats` (the predecessor to this book)
```

### 6. Add the Shapiro blog post citation style note

The current text says `Dan Shapiro (2026)`. Replace with `{cite:t}`shapiro_2026``. The narrative form will render as "Shapiro (2026)" which is correct APA style for a single author.

## Verification

After execution:
1. `grep -c 'NEEDS' book/chapter-01.md` should return 2 (the two figure `[NEEDS]` placeholders for fig-01-01a and fig-01-01b remain — those are rendering tasks, not citation tasks)
2. `grep -c 'cite:' book/chapter-01.md` should return at least 12 `{cite:t}` or `{cite:p}` instances
3. No plain-text author-year citations remain (no bare `Huang et al. (2024)` etc.)
4. `myst build --html` from `book/` renders Chapter 1 with linked citations

## Notes

- The RefineBench citation (`lee_2025`) still has incomplete author details in the .bib file. The `{cite:t}` role will render whatever is in the .bib entry. A future task should complete the author list.
- The DORA paragraph uses caveated language ("correlated with," "the evidence suggests") because DORA is observational, not experimental. This is deliberate.
- The model collapse analogy text explicitly acknowledges the mechanism difference (weight updates vs. context pollution). This prevents overreach while preserving the pedagogical value of the comparison.
