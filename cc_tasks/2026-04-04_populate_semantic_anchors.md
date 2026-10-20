# CC Task: Populate Semantic Anchors for All 14 Chapters

**Date:** 2026-04-04
**Project:** ai-workflow-design
**Depends on:** Seldon CC task `2026-04-04_semantic_anchor_schema_and_context_command.md` (must be completed first — adds schema properties and `assumes` relationship type)

---

## Context

All 14 chapters are drafted. The book is being audited and revised one chapter at a time. This task populates the new semantic anchor properties on all PaperSection (depth=0) artifacts in the graph, and creates `assumes` edges between chapters to map implicit dependencies.

After this task, `seldon paper context chapter-NN` will return structured context for any chapter, showing its claims, terminology, and bidirectional dependency map.

---

## Prerequisites

1. Seldon CC task `2026-04-04_semantic_anchor_schema_and_context_command.md` is completed
2. `seldon paper context` command exists and works (even with empty properties)
3. `assumes` relationship type exists in `research.yaml`

Verify: `seldon paper context chapter-07` should run without error (output will show empty anchor properties and whatever edges already exist).

---

## Instructions

### Pass 1: Populate anchor properties on all 14 chapters

For each chapter (01 through 14), read the chapter file and update the corresponding PaperSection artifact with anchor properties.

```bash
seldon artifact update <artifact-id> -p "core_argument=..." -p "claims=[...]" ...
```

**Or**, if the CLI doesn't handle list properties well via `-p`, write a small Python script that uses the Seldon API directly:

```python
from seldon.config import load_project_config, get_neo4j_driver
from seldon.core.artifacts import update_artifact

# For each chapter, update properties
update_artifact(project_dir, driver, database, domain_config, artifact_id, {
    "core_argument": "...",
    "claims": ["claim 1", "claim 2", ...],
    "terminology_defined": ["term: definition", ...],
    "forward_promises": ["chapter-NN: topic", ...],
    "open_threads": ["thread 1", ...],
    "anchor_date": "2026-04-04",
    "anchor_source": "direct chapter read",
})
```

For chapters that have completed AD-020 runs (Ch 4, 5, 6, 7), also read the corresponding audit files in `audits/` — the synthesis and cascade results contain cross-chapter analysis that should inform the anchor.

**Guidelines:**

- **`core_argument`** is the hardest part. Identify the thesis, not the topics. "This chapter covers X, Y, Z" is a summary. "Reliable pipelines require defensive engineering patterns borrowed from distributed systems" is an argument.

- **`claims`** must be falsifiable assertions. "Data quality matters" is not a claim. "Upstream data validation prevents the majority of pipeline failures that surface as model degradation" is a claim. Each entry in the list is one self-contained assertion.

- **`terminology_defined`** — each entry is `"term: definition"`. Cross-check against `book/glossary.md`. If a chapter uses a key term not in the glossary, note it (but still add the anchor entry).

- **`forward_promises`** — each entry is `"chapter-NN: topic"`. Include both explicit promises ("we'll return to this in Chapter 9") and implicit setups (a concept introduced that's clearly scaffolding for a later chapter).

- **`open_threads`** — topics acknowledged but deferred. These help future revision tasks know what's intentionally missing vs. accidentally omitted.

### Pass 2: Create `assumes` edges

After all 14 chapters have anchor properties, do a second pass to create `assumes` edges between chapters.

For each chapter, identify which other chapters it implicitly depends on — content it assumes the reader has absorbed that isn't signaled by an explicit cross-reference. These are the dependencies where revision cascades hide.

```bash
seldon link create --from <chapter-N-id> --to <chapter-M-id> --type assumes
```

Each `assumes` edge should carry properties:
- `topic`: what's assumed (e.g., "reader understands recursive stochasticity")
- `strength`: `strong`, `moderate`, or `weak`

**Strength classification:**
- **strong**: Chapter N directly uses a specific claim or definition from Chapter M. Revision of M *will* cascade to N.
- **moderate**: Chapter N builds on a concept from Chapter M without explicit reference. Revision *might* cascade.
- **weak**: Thematic overlap. Revision unlikely to cascade but should be checked.

**How to find implicit dependencies:**
1. Read each chapter's `terminology_defined` — which later chapters use those terms without defining them?
2. Read each chapter's `claims` — which later chapters build on those claims?
3. Read each chapter's `forward_promises` — are the promised topics delivered in the target chapters?

**Do not duplicate existing `cross_references` edges as `assumes` edges.** If Ch 7 explicitly references Ch 6, that's already tracked. Only create `assumes` for dependencies that aren't visible from the text's explicit cross-references.

### Pass 3: Validate

After both passes:

1. `seldon paper context chapter-07` — verify output includes anchor properties, assumes edges (both directions), cross-references, and siblings
2. Spot-check 3-4 other chapters
3. `seldon verify` — should pass (new properties are optional, so no violations)

Run a consistency check by querying the graph:

```bash
# Chapters with most incoming assumes edges (highest blast radius)
seldon query "MATCH (a:PaperSection)-[:ASSUMES]->(b:PaperSection) WHERE b.depth = 0 RETURN b.name, count(a) as dependents ORDER BY dependents DESC"

# Chapters with most outgoing assumes edges (most dependencies)  
seldon query "MATCH (a:PaperSection)-[:ASSUMES]->(b:PaperSection) WHERE a.depth = 0 RETURN a.name, count(b) as dependencies ORDER BY dependencies DESC"

# Chapters with no assumes edges in either direction (isolated — suspicious)
seldon query "MATCH (a:PaperSection) WHERE a.depth = 0 AND NOT (a)-[:ASSUMES]-() RETURN a.name"
```

If any chapter has zero `assumes` edges in either direction, verify that's correct (Chapter 1 might legitimately have no inbound assumptions; Chapter 14 might legitimately have no outbound promises). But most chapters should have at least one edge in each direction.

### Pass 4: Record completion

```bash
seldon cc complete cc_tasks/2026-04-04_populate_semantic_anchors.md
```

---

## Output

No new files created. All output is in the graph:
- 14 PaperSection artifacts updated with anchor properties
- N `assumes` edges created between PaperSection artifacts
- `seldon paper context <chapter>` works for any chapter

---

## How This Gets Used Going Forward

### AD-020 pipeline CC tasks
Add to the context section of every AD-020 CC task:

```
### Semantic Context
Run `seldon paper context <chapter-name>` and read the output before beginning analysis.
Pay special attention to the "Sections that assume this one" block —
these chapters may need cascade checks if this review produces revision recommendations.
```

### Revision CC tasks
When a revision task modifies a chapter, the `assumes` inbound edges are the blast radius. The revision CC task should:
1. Run `seldon paper context <chapter>` before starting
2. After revision, check if any `claims` or `terminology_defined` changed
3. If so, list the chapters with `strong` inbound `assumes` edges — these need cascade review
4. Update the revised chapter's anchor properties (especially `anchor_date`)

### Anchor maintenance
After each chapter revision that changes claims or terminology, update that chapter's anchor properties. If the revision is substantial, re-evaluate `assumes` edges to/from that chapter.

---

## Success Criteria

- All 14 PaperSection artifacts have `core_argument` populated (non-empty thesis statement, not summary)
- All 14 have `claims` as list of falsifiable assertions
- `assumes` edges exist between chapters with implicit dependencies
- `seldon paper context` produces useful output for any chapter
- Graph queries for blast radius and dependency counts return sensible results
- `seldon verify` passes
