# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 4

**Date:** 2026-04-02
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 002 (first `book_chapter` type; Run 001 was leibniz-pi `academic_paper`)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-04.md` — Detection & Extraction Workflows

---

## Context

This is the second AD-020 calibration run and the first on `document_type: book_chapter`. The leibniz-pi run (calibration 001) tested `academic_paper` gates. This run tests whether Bloom taxonomy, practitioner stress test with practitioner persona, and full narrative lens produce value on pedagogical content.

Chapter 4 is ~97 lines / ~6-7KB. It is the shortest of the domain workflow trilogy (Chapters 2-4). The pipeline may correctly identify depth gaps — that is signal, not noise.

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows"
  chapter_pattern: "opening hook → core content → distributed reflection prompts → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter`

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Citations required for factual claims |
| Tier 2a: Stress Test | Practitioner persona | "Can I use this to design an extraction pipeline tomorrow?" |
| Tier 2b: Depth Check | Full Bloom taxonomy | Does reader reach Evaluate/Create, or stop at Apply? |
| Tier 3: Narrative | Full | Story arc, hook, tension, resolution — at full intensity |
| Tier 3: Clarity | Full | Jargon audit against stated audience |
| Tier 3: Visual gaps | Full | Diagrams, tables, figures |
| Tier 3: Motivation | Full | Keller ARCS — does reader know why they should care? |

---

## Instructions

Run the full AD-020 pipeline. All tiers, all gates, synthesis at the end.

### Prerequisites

1. Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set.
2. Verify `.claude/agents/auditor.md` and `.claude/agents/cascade-checker.md` exist (symlinked from Seldon).
3. Verify `audits/` directory exists.

### Step 1: Tier 1 — Correctness Audit (AD-019)

Use the auditor agent protocol on `book/chapter-04.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Read `book/chapter-04.md`.
4. Execute the full audit per `.claude/agents/auditor.md`.
5. Write output to `audits/chapter-04_content_audit.yaml`.
6. Write Perplexity queries to `audits/chapter-04_perplexity_queries.md`.

**Do NOT spawn cascade checkers yet.** Save `cascading_audit_tasks` for Step 6.

### Step 2: Tier 2a — Practitioner Stress Test

Given the chapter topic (detection & extraction workflows for official statistics), generate 8-10 questions a working practitioner would ask. These must be engineering judgment questions, not factual recall.

**Persona:** Working data scientist at a federal statistical agency who has been told to build an extraction pipeline. They've read this chapter. Can they make design decisions?

**Example question framing:**
- "I need to extract organization names from 50,000 public comments. How do I handle entity resolution?"
- "My extraction pipeline produces a knowledge graph. How do I verify the edges are real, not inferred?"
- "Leadership wants a confidence score on each extracted entity. How should I calibrate that?"
- "We have two models disagreeing on an entity boundary. The chapter says disagreement is signal — but signal of what, specifically? What do I do with it?"

For each question:
1. Attempt to answer using ONLY chapter 4 material.
2. Score: `fully_answerable` / `partially_answerable` / `not_answerable`.
3. For partial/not answerable: describe the gap.

Write output to `audits/chapter-04_practitioner_stress_test.yaml`:

```yaml
practitioner_stress_test:
  file: "book/chapter-04.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  persona: "Working data scientist at federal statistical agency building extraction pipeline"
  
  questions:
    - id: Q1
      question: "[the question]"
      answerability: "fully_answerable | partially_answerable | not_answerable"
      evidence_in_chapter: "[what the chapter provides, if anything]"
      gap: "[what's missing, if partial or not answerable]"
      severity: "high | medium | low"
  
  summary:
    fully_answerable: N
    partially_answerable: N
    not_answerable: N
    highest_value_gaps: ["[list the top 3 gaps by severity]"]
```

### Step 3: Tier 2b — Cognitive Depth Check (Bloom Taxonomy)

For each `##`-level section in chapter 4, classify the highest Bloom level the reader is asked to reach:

- **Remember:** Can recall facts presented
- **Understand:** Can explain concepts in own words
- **Apply:** Can use patterns in new situations
- **Analyze:** Can distinguish components, identify relationships
- **Evaluate:** Can judge, compare, recommend based on criteria
- **Create:** Can design new solutions using the principles

**Chapter pattern check:** The book's pedagogical pattern specifies distributed reflection prompts and at least one thought experiment. These should scaffold to Evaluate or Create. Check whether they actually do, or whether they stop at Apply.

Write output to `audits/chapter-04_bloom_depth_check.yaml`:

```yaml
bloom_depth_check:
  file: "book/chapter-04.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  
  sections:
    - heading: "[## heading]"
      word_count: N
      highest_bloom_level: "remember | understand | apply | analyze | evaluate | create"
      evidence: "[what in the section reaches this level]"
      potential_level: "evaluate | create | null"
      gap: "[what would be needed to reach the potential level, if applicable]"
  
  reflection_prompts:
    - text: "[the prompt text]"
      location: "[which section]"
      bloom_level_achieved: "[level]"
      notes: "[does it actually force active engagement at the stated level?]"
  
  thought_experiments:
    - text: "[the thought experiment]"
      bloom_level_achieved: "[level]"
      notes: "[does it reach Evaluate/Create?]"
  
  scaffolding_assessment: "[does the chapter build from lower to higher cognitive levels? or does it plateau?]"
  
  summary:
    sections_at_apply_or_below: N
    sections_at_analyze_or_above: N
    chapter_ceiling: "[the highest Bloom level achieved anywhere]"
    scaffolding_verdict: "well-scaffolded | plateaus_at_X | inconsistent"
```

### Step 4: Tier 3 — Secondary Lens Sweep (Blended)

Single pass applying all four secondary lenses. Read the Tier 2 outputs first so you don't duplicate findings already captured.

For each finding, tag with the lens that surfaced it. If relevant to multiple lenses, tag all.

Write output to `audits/chapter-04_secondary_sweep.yaml`:

```yaml
secondary_sweep:
  file: "book/chapter-04.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_2_reviewed: true
  
  findings:
    - id: S1
      lenses: ["narrative | clarity | visual | motivation"]
      section: "[## heading or 'chapter-level']"
      finding: "[what was found]"
      suggested_scope: "[what should be done — scope, not edit]"
      severity: "high | medium | low"
```

### Step 5: Synthesis

Combine ALL findings from Tiers 1-3 into a single synthesis document. This is the core deliverable.

**Clustering rules:**
1. Group findings by topic, not by gate.
2. Tag each finding with its source lens/gate.
3. Count convergence (how many lenses flagged this cluster).
4. Order clusters by convergence (highest first).
5. Write actionable scope, not suggested edits.
6. Each cluster must be self-contained for serial processing.
7. Cap at ~8 clusters. Remaining items go in `unclustered`.

Write output to `audits/chapter-04_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-04.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-04_content_audit.yaml"
  
  clusters:
    - id: 1
      title: "[descriptive heading]"
      convergence: N
      lenses: ["[list of lenses/gates that flagged this]"]
      
      findings:
        - lens: "[source lens]"
          finding: "[what was found]"
      
      suggested_scope: "[what to do — scope, not edit]"
      affected_sections:
        - "[## heading]"
    
  unclustered:
    - lens: "[source lens]"
      finding: "[what was found]"
      suggested_scope: "[scope]"
```

### Step 6: Cascade Checking (from Tier 1)

Now read `cascading_audit_tasks` from the Tier 1 output (`audits/chapter-04_content_audit.yaml`). Group by target chapter.

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-04.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results:
- `confirmed` → write to `audits/chapter-04_cascade_results.yaml`
- `needs_full_audit` → note for follow-up
- `clear` → no action

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, submission-equivalent assessment
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts, top gaps
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment for `book_chapter` type

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-04_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-04_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-04_practitioner_stress_test.yaml` | Tier 2a: stress test |
| `audits/chapter-04_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-04_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-04_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-04_cascade_results.yaml` | Cascade checker results (if any) |

---

## Calibration Data Capture

After the run, write calibration notes to `seldon/docs/design/AD-020_calibration_002_ch04.md` covering:

1. **Gate effectiveness by tier** — which gates produced signal vs noise for `book_chapter`?
2. **Bloom gate assessment** — did Bloom taxonomy add value over what the stress test already caught?
3. **Narrative lens assessment** — was full intensity justified, or should it be lighter for short chapters?
4. **Chapter length interaction** — did the ~97 line length affect gate quality? Did gates correctly identify thinness vs. completeness?
5. **Comparison to leibniz-pi calibration** — how did `book_chapter` gates differ from `academic_paper` gates in practice?
6. **Recommendations for `book_chapter` gate profile adjustments**

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph (future: `seldon audit ingest`)
- Skip the synthesis step — raw gate outputs without clustering are unusable
- Skip the calibration data capture — this run's purpose is calibration as much as review
