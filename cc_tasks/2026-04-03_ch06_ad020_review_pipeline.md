# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 6

**Date:** 2026-04-03
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 004 (third `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-06.md` — Parallel, Serial, and the Bottleneck

---

## Context

This is the fourth AD-020 calibration run and the third on `document_type: book_chapter`. Ch 4 (run 002) tested gates on a thin chapter (~97 lines). Ch 5 (run 003) tested on a mature cross-cutting pattern chapter (~300+ lines) and produced cleaner signal. Ch 6 is an **engineering implementation** chapter — it teaches batch processing, parallelization, model selection, and infrastructure design. This is a "how to build" chapter, not a "how to choose" chapter (Ch 5) or a "what is the domain" chapter (Ch 4).

Ch 6 is moderately developed (~200 lines). It draws heavily from the Concept Mapper case study and applies Pike's Rules as an organizing device. Its position in the book is as a bridge between the design pattern chapters (3-5) and the reliability/recovery chapters (7-8).

**Calibration questions for this run:**
- How does the practitioner stress test perform on a pure engineering chapter vs. a design-pattern chapter (Ch 5)?
- Does the Bloom gate find meaningful gaps in a chapter that should naturally reach Apply/Analyze?
- How rich are cascade findings for a chapter that references backward (Ch 1, 2, 5) and forward (Ch 7, 8, 10, 11, 14)?
- Does the visual gap pattern (high convergence in Ch 4 and Ch 5) persist in an engineering chapter?

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows"
  chapter_pattern: "opening hook → core content → distributed reflection prompts → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 003)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Citations required for factual claims |
| Tier 2a: Stress Test | Practitioner persona | "Can I build a batch LLM pipeline with this tomorrow?" |
| Tier 2b: Depth Check | Full Bloom taxonomy | Does reader reach Evaluate/Create, or stop at Apply? |
| Tier 3: Narrative | Full | Story arc, hook, tension, resolution |
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

Use the auditor agent protocol on `book/chapter-06.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Read `book/chapter-06.md`.
4. Execute the full audit per `.claude/agents/auditor.md`.
5. Write output to `audits/chapter-06_content_audit.yaml`.
6. Write Perplexity queries to `audits/chapter-06_perplexity_queries.md`.

**Specific verification targets for Ch 6:**
- `pike_1989` — verify this is the correct citation key and that Pike's five rules are accurately paraphrased. The source is "Notes on Programming in C" but verify authorship, date, and rule content.
- `webb_2026_concept_mapper` — verify all Concept Mapper claims: 6,954 questions, dual-model pipeline, 6 parallel workers, exponential backoff (1s, 2s, 4s, 8s, 16s), checkpoint every 10 questions.
- `fortier_2011` and `wolf_2016` — verify these are domain framework citations appropriate for the claim about adopting existing schemas.
- "Embarrassingly parallel" usage — verify this is standard distributed systems terminology applied correctly.

**Do NOT spawn cascade checkers yet.** Save `cascading_audit_tasks` for Step 6.

### Step 2: Tier 2a — Practitioner Stress Test

Given the chapter topic (batch processing, parallelization, and infrastructure design for LLM pipelines in official statistics), generate 8-10 questions a working practitioner would ask. These must be engineering judgment questions, not factual recall.

**Persona:** Working data scientist at a federal statistical agency who has been told to build a batch LLM processing pipeline for a survey classification project. They've read this chapter. Can they build it?

**Example question framing:**
- "I need to process 50,000 records through an LLM. What's my first design decision?"
- "My API provider just cut my rate limit from 60 RPM to 30 RPM mid-run. Does my pipeline handle this?"
- "I want to run my pipeline on a shared server where other people also use the API key. How do I coordinate?"
- "Leadership wants results by Friday but my provider has a 4-hour outage. What happens to my pipeline?"
- "I'm switching from Model A to Model B next month. What do I need to change in my pipeline?"
- "How do I know if my task is actually embarrassingly parallel or if there are hidden dependencies?"
- "I need to defend the cost of running two models to my branch chief. What does this chapter tell me to say?"

For each question:
1. Attempt to answer using ONLY chapter 6 material.
2. Score: `fully_answerable` / `partially_answerable` / `not_answerable`.
3. For partial/not answerable: describe the gap.

Write output to `audits/chapter-06_practitioner_stress_test.yaml`:

```yaml
practitioner_stress_test:
  file: "book/chapter-06.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  persona: "Working data scientist at federal statistical agency building batch LLM pipeline"
  
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

For each `##`-level section in chapter 6, classify the highest Bloom level the reader is asked to reach:

- **Remember:** Can recall facts presented
- **Understand:** Can explain concepts in own words
- **Apply:** Can use patterns in new situations
- **Analyze:** Can distinguish components, identify relationships
- **Evaluate:** Can judge, compare, recommend based on criteria
- **Create:** Can design new solutions using the principles

**Chapter pattern check:** The book's pedagogical pattern specifies distributed reflection prompts and at least one thought experiment. These should scaffold to Evaluate or Create. Check whether they actually do, or whether they stop at Apply.

**Special attention for Ch 6:** This is an engineering chapter — Apply should be the floor, not the ceiling. The model selection section should reach Evaluate (judging tradeoffs). The thought experiment should reach Create (designing a swap-ready architecture). If the chapter plateaus at Apply, that's a significant finding for an implementation-focused chapter. Also check: does the Pike's Rules section add cognitive depth or is it decorative?

Write output to `audits/chapter-06_bloom_depth_check.yaml`:

```yaml
bloom_depth_check:
  file: "book/chapter-06.md"
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

Write output to `audits/chapter-06_secondary_sweep.yaml`:

```yaml
secondary_sweep:
  file: "book/chapter-06.md"
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

Write output to `audits/chapter-06_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-06.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-06_content_audit.yaml"
  
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

Now read `cascading_audit_tasks` from the Tier 1 output (`audits/chapter-06_content_audit.yaml`). Group by target chapter.

**Note:** Ch 6 references backward to Ch 1 (evaluation trap), Ch 2 (domain frameworks as schemas), Ch 5 (multi-model thesis, generator-critic), and forward to Ch 7 (checkpoint/recovery architecture), Ch 8 (evaluation-by-design), Ch 10 (provenance/versioned configurations), Ch 11 (development tool stochasticity, infrastructure reinvention), and Ch 14 (cost). Expect cascades in both directions.

**Specific cascade concerns:**
- Ch 5's bridge to Ch 6 was rewritten in Session 20. Verify the revised bridge matches what Ch 6 actually delivers.
- Ch 7 is promised twice (checkpoint architecture, config-driven infrastructure pattern). Verify Ch 7 delivers both.
- Ch 11 is referenced for "meta-level challenge" of LLM as development tool. Verify Ch 11 covers this.
- Ch 14 is implied but not cited for cost framework. Verify no cost claims in Ch 6 that should cite Ch 14.

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-06.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results:
- `confirmed` → write to `audits/chapter-06_cascade_results.yaml`
- `needs_full_audit` → note for follow-up
- `clear` → no action

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, submission-equivalent assessment
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts, top gaps
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment for `book_chapter` type

**Calibration comparison:** Explicitly compare Run 004 results to Runs 002 (Ch 4) and 003 (Ch 5). Note:
- Engineering chapter vs. pattern chapter vs. domain chapter — did the practitioner stress test produce different signal types?
- Did the visual gap pattern (high convergence in Ch 4 and Ch 5) persist?
- Did Pike's Rules section produce signal or was it missed by gates?
- Were cascade findings richer or sparser given Ch 6's bridge position between design patterns (3-5) and reliability (7-8)?
- How did Bloom gate perform on an engineering chapter where Apply should be the floor?

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-06_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-06_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-06_practitioner_stress_test.yaml` | Tier 2a: stress test |
| `audits/chapter-06_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-06_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-06_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-06_cascade_results.yaml` | Cascade checker results (if any) |

---

## Calibration Data Capture

After the run, write calibration notes to `seldon/docs/design/AD-020_calibration_004_ch06.md` covering:

1. **Gate effectiveness by tier** — which gates produced signal vs noise?
2. **Engineering chapter characteristics** — how did gates behave on a "how to build" chapter vs. "how to choose" (Ch 5) vs. "what is the domain" (Ch 4)?
3. **Pike's Rules as organizing device** — did any gate evaluate whether the rules add substance or are decorative?
4. **Visual gap persistence** — is the zero-figures finding a systematic pattern (now 3 data points if confirmed)?
5. **Bloom gate on engineering content** — Apply as floor: did the gate correctly identify when the chapter fails to reach Evaluate/Create?
6. **Cascade richness at bridge position** — Ch 6 sits between two chapter groups. Were cascades richer than non-bridge chapters?
7. **Comparison table: Runs 002 vs 003 vs 004** — side-by-side of cluster count, convergence distribution, cascade count, gate-level signal assessment
8. **Recommendations for `book_chapter` gate profile adjustments** based on three data points

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph (future: `seldon audit ingest`)
- Skip the synthesis step — raw gate outputs without clustering are unusable
- Skip the calibration data capture — this run's purpose is calibration as much as review
- Skip the calibration comparison to Runs 002 and 003 — three data points beats two
