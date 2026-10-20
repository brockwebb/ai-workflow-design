# CC Task: Implement Semantic Anchoring (Pattern A) — Full Book Anchor Map

**Date:** 2026-04-04
**Project:** ai-workflow-design
**Reference:** Design note `seldon/docs/design/2026-04-04_semantic_anchoring_and_narrative_logic.md`
**Supersedes:** Earlier version of this file (same date) that assumed linear drafting sequence

---

## Context

All 14 chapters are already drafted. The book is being audited and revised one chapter at a time via AD-020 pipeline runs. The problem semantic anchoring solves in this context is NOT "prevent drift during initial drafting" — it's:

1. **When revising Ch N, know what downstream chapters assume about Ch N.** If you tighten a definition in Ch 5, which chapters break?
2. **When auditing Ch N, verify it fulfills promises made by earlier chapters.** Ch 4 says "we'll see how this plays out in validation" — does Ch 9 actually deliver?
3. **When the cascade checker flags a cross-chapter issue, have a structured map to assess blast radius** without re-reading every chapter.

This requires **bidirectional anchors for all 14 chapters** — not a linear "through chapter N" accumulation.

---

## Instructions

### Step 1: Create anchors directory

```bash
mkdir -p anchors/
```

### Step 2: Pass 1 — Generate per-chapter anchor files

For each chapter (01 through 14), read the chapter file and produce a YAML anchor file at `anchors/chapter-NN_anchor.yaml`.

For chapters that have completed AD-020 runs (Ch 4, 5, 6, 7), also read the corresponding files in `audits/` — the synthesis and cascade results contain cross-chapter analysis that should inform the anchor.

**Schema (mandatory fields):**

```yaml
semantic_anchor:
  chapter: "chapter-NN"
  title: "[chapter title from first heading]"
  date_generated: "2026-04-04"
  generated_from: "[AD-020 calibration run NNN | direct chapter read]"
  ad020_completed: true | false

  core_argument: >
    1-2 sentences: the chapter's central thesis or organizing claim.
    Not a summary — the argument. What is the chapter trying to convince
    the reader of?

  claims_established:
    # Specific claims the chapter makes that other chapters might
    # reference, depend on, or contradict.
    # Each claim is a complete, falsifiable assertion — not a topic label.
    # Bad: "prompt engineering"
    # Good: "Prompt structure determines output quality more than model choice for classification tasks"
    - "[claim 1]"
    - "[claim 2]"

  terminology_introduced:
    # Terms defined or given specific meaning in this chapter.
    # Include the definition, not just the term.
    # Cross-check against book/glossary.md — flag terms used but not in glossary.
    - term: "[term]"
      definition: "[definition as used in this chapter]"
      in_glossary: true | false

  forward_references:
    # Explicit promises: "we will cover X in Chapter Y"
    # Implicit setups: concepts introduced that are clearly scaffolding for later chapters.
    - target: "chapter-NN"
      topic: "[what's promised/set up]"
      type: "explicit | implicit"

  backward_references:
    # Explicit references to prior chapters.
    # What does this chapter assume the reader already knows?
    - source: "chapter-NN"
      topic: "[what's referenced/assumed]"
      type: "explicit | implicit"

  open_threads:
    # Topics acknowledged but deferred. Questions raised but not answered.
    - "[topic — context for why it's deferred]"
```

### Guidelines for Pass 1

- **Core argument is the hardest part.** Identify the thesis, not the topics. "This chapter covers X, Y, Z" is a summary. "Reliable pipelines require defensive engineering patterns borrowed from distributed systems" is an argument.

- **Claims must be falsifiable.** "Data quality matters" is not a claim. "Upstream data validation prevents 80% of pipeline failures that would otherwise surface as model degradation" is a claim.

- **Implicit references matter more than explicit ones.** Explicit cross-references ("as we discussed in Chapter 3") are easy to find. Implicit dependencies ("this section assumes the reader understands prompt versioning") are where revision cascades hide. Spend extra time on implicit backward references — these are the invisible load-bearing connections.

- **Terminology cross-check is mandatory.** Every term in `terminology_introduced` gets checked against `book/glossary.md`. If it's not in the glossary, set `in_glossary: false`. This surfaces glossary gaps as a side effect.

### Step 3: Pass 2 — Cross-link dependency graph

After all 14 anchors exist, do a second pass to add the `depends_on_me` field to each anchor. This is the inverse of `backward_references` — it answers "which downstream chapters will break if I change this chapter?"

**Add to each anchor file:**

```yaml
  depends_on_me:
    # Chapters that reference or assume content from THIS chapter.
    # Populated in Pass 2 by inverting all backward_references across the full anchor set.
    - dependent: "chapter-NN"
      topic: "[what they depend on from this chapter]"
      strength: "strong | moderate | weak"
      # strong: they directly reference a specific claim or definition
      # moderate: they assume familiarity with a concept introduced here
      # weak: thematic connection, revision unlikely to break them
```

**How to populate:** For each chapter's `backward_references`, create a corresponding `depends_on_me` entry in the referenced chapter. Then assess strength:
- **Strong:** The downstream chapter names this chapter or quotes/uses a specific definition or claim from it. Revision here *will* cascade.
- **Moderate:** The downstream chapter builds on a concept introduced here but doesn't explicitly reference it. Revision here *might* cascade — needs review.
- **Weak:** Thematic overlap. The downstream chapter covers related territory but doesn't structurally depend on specific claims. Revision here is unlikely to cascade but should be checked.

### Step 4: Generate the anchor map

Produce `anchors/anchor_map.md` — a readable dependency map for the full book.

**Format:**

```markdown
# Book Anchor Map — ai-workflow-design

Generated: 2026-04-04
Chapters anchored: 14

---

## Dependency Summary

### Chapters with most dependents (revision here has widest blast radius)
1. Chapter NN: [title] — N strong, M moderate, K weak dependents
2. ...

### Chapters with most dependencies (most assumptions about prior content)
1. Chapter NN: [title] — depends on N prior chapters
2. ...

### Undelivered forward references (promises not yet fulfilled)
- Ch N → Ch M: "[topic]" — [status: delivered | partial | missing]

### Terminology introduced but not in glossary
- "[term]" (Ch N) — [definition]

---

## Per-Chapter Anchors

### Chapter 1: [title]

**Core argument:** [from anchor]

**Claims established:**
- [claim 1]
- [claim 2]

**Terminology introduced:**
- [term — definition] [glossary: yes/no]

**Forward references:**
- → Ch N: [topic] (explicit/implicit)

**Backward references:**
- ← Ch N: [topic] (explicit/implicit)

**Depends on me (revision blast radius):**
- Ch N: [topic] (strong/moderate/weak)
- Ch M: [topic] (strong/moderate/weak)

**Open threads:**
- [thread]

---

### Chapter 2: [title]
[etc. for all 14 chapters]
```

### Step 5: Validate

After generating the full map, do a consistency check:

1. **Terminology conflicts:** Same term defined differently in different chapters? Flag.
2. **Orphan forward references:** Chapter promises something that no later chapter delivers? Flag with status `missing`.
3. **Circular dependencies:** Chapter A depends on B, B depends on A? Flag (may be legitimate — note context).
4. **Unstated dependencies:** Chapter assumes knowledge no prior chapter established? Flag.
5. **Glossary gaps:** Terms used as key terminology but not in glossary? List.

Write findings to `anchors/consistency_check.md`.

### Step 6: Record completion

```bash
seldon cc complete cc_tasks/2026-04-04_implement_semantic_anchoring.md
```

---

## Output Files

| File | Description |
|------|-------------|
| `anchors/chapter-NN_anchor.yaml` (×14) | Per-chapter semantic anchors |
| `anchors/anchor_map.md` | Combined readable dependency map with blast radius analysis |
| `anchors/consistency_check.md` | Cross-book consistency findings |

---

## How This Gets Used

### During AD-020 pipeline runs
The CC task for each chapter's AD-020 run includes:
```
### Semantic Anchors
Read `anchors/anchor_map.md` before beginning analysis.
For the target chapter, pay special attention to:
- Chapters listed in `depends_on_me` — these chapters assume this chapter's content
- Chapters listed in `backward_references` — verify this chapter fulfills their promises
- Use anchor claims to verify cross-chapter consistency of terminology and assertions
```

### During chapter revision
When a revision CC task modifies a chapter, the `depends_on_me` list is the blast radius checklist. Every chapter with a `strong` dependency gets a cascade check. `moderate` dependencies get flagged for author review. `weak` dependencies are noted but don't block.

### Anchor maintenance
After each chapter revision, the affected chapter's anchor must be regenerated. If claims or terminology changed, Pass 2 must re-run on affected dependents to update `depends_on_me` entries. This is a small task — add "update anchor" as a post-revision step in future revision CC tasks.

---

## Success Criteria

- All 14 anchor files parse as valid YAML
- Core arguments are thesis statements, not summaries
- Claims are falsifiable assertions, not topic labels
- Pass 2 `depends_on_me` is populated for all chapters with dependents
- Anchor map dependency summary identifies the highest-blast-radius chapters
- Consistency check surfaces real conflicts (zero is fine if the book is consistent)
- Total anchor map is readable as a standalone document — a new session can read it and understand the book's structural skeleton without reading any chapter text
