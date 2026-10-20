# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 7

**Date:** 2026-04-03
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 005 (fourth `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-07.md` — Checkpoints, Failures, and Recovery

---

## Context

This is the fifth AD-020 calibration run and the fourth on `document_type: book_chapter`. Ch 4 (run 002) tested on a thin domain chapter (~97 lines). Ch 5 (run 003) on a mature cross-cutting pattern chapter (~300+ lines). Ch 6 (run 004) on an engineering implementation chapter (~200 lines). Ch 7 is a **reliability and defensive engineering** chapter — it teaches config-driven design, progressive testing, error classification, checkpoint/recovery, and the recursive stochasticity problem (your dev tools are also stochastic).

Ch 7 is moderately developed (~105 lines). It has only 3 citations (`nist_ai_rmf_2023`, `webb_2026_concept_mapper`, `chen_2026_sweci`). Its position is at the transition between "how to build" (Ch 5-6) and "how to validate" (Ch 8-10). It references backward to Ch 6 (parallel batch architecture, exponential backoff, checkpoint requirement) and forward to Ch 9/10 (drift detection, state management), Ch 11 (development toolchain).

The chapter's unique contribution is the recursive argument: the same defensive engineering patterns (config-driven, progressive testing, checkpoint/recovery) that protect production pipelines also protect the development process from AI coding assistant stochasticity. This thesis-level claim needs careful audit.

**Calibration questions for this run:**
- How does the pipeline perform on a defensive engineering chapter vs. an implementation chapter (Ch 6)?
- Is the recursive stochasticity section (dev tools are stochastic too) substantive or hand-wavy? Does Bloom gate catch it?
- With only 3 citations, does Tier 1 produce useful signal or mostly flag the sparse citation density itself?
- Does the practitioner stress test surface gaps in the error classification taxonomy (transient/permanent/data)?
- How does cascade behavior differ for a chapter that is heavily forward-referencing (Ch 9, 10, 11) vs. Ch 6 which was more balanced?
- Does the chapter's bridge from Ch 6 (survivable) to Ch 9-10 (valid) hold up under cascade checking?

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows"
  chapter_pattern: "opening hook → core content → distributed reflection prompts → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 004)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Citations required for factual claims |
| Tier 2a: Stress Test | Practitioner persona | "Can I make my pipeline survive failures with this?" |
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

Use the auditor agent protocol on `book/chapter-07.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Read `book/chapter-07.md`.
4. Execute the full audit per `.claude/agents/auditor.md`.
5. Write output to `audits/chapter-07_content_audit.yaml`.
6. Write Perplexity queries to `audits/chapter-07_perplexity_queries.md`.

**Specific verification targets for Ch 7:**
- `nist_ai_rmf_2023` — verify TEVV (Test, Evaluation, Verification, and Validation) is accurately described as a continuous process, not a gate. Check that the cite key matches the actual NIST AI RMF document (NIST AI 100-1).
- `webb_2026_concept_mapper` — verify checkpoint claims: "saved progress every 10 questions with transaction-safe file writes." Cross-check with Ch 6's checkpoint claims for consistency.
- `chen_2026_sweci` — **NEW CITATION, HIGH PRIORITY.** Verify: (a) paper exists and is correctly attributed, (b) "100 tasks, each spanning an average of 233 days and 71 consecutive commits" is accurate, (c) "75% of frontier models broke previously working features" is accurate, (d) EvoScore metric description is fair, (e) the cite key format follows convention (first author, year, short descriptor).
- GPT-5 temperature claim — "When OpenAI moved to GPT-5, the temperature setting was removed." **VERIFY THIS.** This is a specific factual claim about a model release that may or may not be accurate. If wrong, it undermines the config shelf-life argument.
- "Embarrassingly parallel" — verify this term is not used in Ch 7 (it shouldn't be; it's Ch 6's term). Check for accidental bleeding.
- Idempotency definition — verify the definition given is technically correct and not oversimplified.

**Do NOT spawn cascade checkers yet.** Save `cascading_audit_tasks` for Step 6.

### Step 2: Tier 2a — Practitioner Stress Test

Given the chapter topic (making LLM pipelines survivable through config management, testing, error handling, and checkpoint/recovery), generate 8-10 questions a working practitioner would ask. These must be engineering judgment questions, not factual recall.

**Persona:** Working data scientist at a federal statistical agency whose batch LLM pipeline (built using Chapter 6's patterns) just failed at 3 AM on a Friday. They've read this chapter. Can they diagnose and recover?

**Example question framing:**
- "My pipeline crashed at record 25,000 of 50,000. How do I know what was saved and where to resume?"
- "I got HTTP 429 errors for 2 hours, then the API came back. Did my pipeline handle this automatically or do I need to restart?"
- "My config file says Model A but my results look like Model B outputs. How do I diagnose this?"
- "Leadership wants me to add a new classification category mid-run. Can I do that without starting over?"
- "I switched from Provider X to Provider Y. What's my testing protocol before I trust the new provider with 50,000 records?"
- "My checkpoint file got corrupted. What's my recovery path?"
- "The model provider pushed a silent update. My pipeline ran fine but results shifted. What infrastructure would have caught this?"
- "I have three different error types in my log. How do I prioritize which to investigate first?"

For each question:
1. Attempt to answer using ONLY chapter 7 material.
2. Score: `fully_answerable` / `partially_answerable` / `not_answerable`.
3. For partial/not answerable: describe the gap.

Write output to `audits/chapter-07_practitioner_stress_test.yaml`:

```yaml
practitioner_stress_test:
  file: "book/chapter-07.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  persona: "Working data scientist at federal statistical agency whose batch LLM pipeline just failed"
  
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

For each `##`-level section in chapter 7, classify the highest Bloom level the reader is asked to reach.

**Chapter pattern check:** The book's pedagogical pattern specifies distributed reflection prompts and at least one thought experiment. These should scaffold to Evaluate or Create. Check whether they actually do.

**Special attention for Ch 7:** This is a defensive engineering chapter — Apply should be the floor (can the reader implement these patterns?), but the recursive stochasticity argument should reach Analyze or Evaluate (the reader should understand WHY the same patterns apply to development and production). The thought experiment (silent model drift) should reach Evaluate (diagnosing what happened) or Create (designing the detection infrastructure). If the recursive section stays at Understand ("isn't it interesting that dev tools are stochastic too"), that's a significant gap — the section needs to reach "here's what you do about it."

Also check: does the chapter's scaffolding build properly from concrete (config files, test types) to abstract (recursive stochasticity, survivable vs. valid distinction)? Or does it jump?

Write output to `audits/chapter-07_bloom_depth_check.yaml`:

```yaml
bloom_depth_check:
  file: "book/chapter-07.md"
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

Write output to `audits/chapter-07_secondary_sweep.yaml`:

```yaml
secondary_sweep:
  file: "book/chapter-07.md"
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

Write output to `audits/chapter-07_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-07.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-07_content_audit.yaml"
  
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

Now read `cascading_audit_tasks` from the Tier 1 output (`audits/chapter-07_content_audit.yaml`). Group by target chapter.

**Note:** Ch 7 references backward to Ch 6 (parallel batch architecture, exponential backoff, checkpoint requirement, reflection prompt answer) and forward to Ch 9 (drift detection), Ch 10 (state management), and Ch 11 (development toolchain treatment). Expect cascades primarily forward.

**Specific cascade concerns:**
- Ch 6's bridge to Ch 7 promises checkpoint/recovery architecture and config-driven infrastructure. Verify Ch 7 delivers both.
- Ch 9 and Ch 10 are promised for "drift detection" and "state management." Verify these chapters deliver what Ch 7's bridge promises.
- Ch 11 is promised for "full treatment of the development toolchain as part of the workflow architecture." Verify Ch 11 covers the recursive stochasticity problem at the depth Ch 7 signals.
- Ch 6 reflection prompt answer: Ch 7 claims "the whole pipeline does not restart, just the failed worker's batch." Verify this is consistent with Ch 6's actual reflection prompt.
- `chen_2026_sweci` — if this paper is also cited elsewhere, verify consistency of claims.

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-07.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results:
- `confirmed` → write to `audits/chapter-07_cascade_results.yaml`
- `needs_full_audit` → note for follow-up
- `clear` → no action

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, submission-equivalent assessment
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts, top gaps
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment for `book_chapter` type

**Calibration comparison:** Explicitly compare Run 005 results to Runs 002 (Ch 4), 003 (Ch 5), and 004 (Ch 6). Note:
- Defensive engineering chapter vs. implementation chapter (Ch 6) vs. pattern chapter (Ch 5) vs. domain chapter (Ch 4) — did the practitioner stress test produce different signal types?
- Did the visual gap pattern (high convergence in Ch 4, 5, and 6) persist? (This would be the fourth data point.)
- With only 3 citations, did Tier 1 produce useful signal or was it mostly noise?
- Did the recursive stochasticity section produce meaningful Bloom/depth signal?
- Were cascade findings richer or sparser for a forward-heavy chapter vs. Ch 6's balanced references?
- How does the `chen_2026_sweci` citation hold up under verification? Is it a strong or weak anchor for the recursive argument?

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-07_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-07_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-07_practitioner_stress_test.yaml` | Tier 2a: stress test |
| `audits/chapter-07_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-07_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-07_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-07_cascade_results.yaml` | Cascade checker results (if any) |

---

## Calibration Data Capture

After the run, write calibration notes to `seldon/docs/design/AD-020_calibration_005_ch07.md` covering:

1. **Gate effectiveness by tier** — which gates produced signal vs noise?
2. **Defensive engineering chapter characteristics** — how did gates behave on a "how to survive" chapter vs. "how to build" (Ch 6) vs. "how to choose" (Ch 5) vs. "what is the domain" (Ch 4)?
3. **Recursive stochasticity section** — did any gate evaluate whether this section is substantive or hand-wavy? Did Bloom correctly assess its depth?
4. **Visual gap persistence** — is the zero-figures finding still holding (now 4 data points if confirmed)?
5. **Sparse citation behavior** — with only 3 citations, did Tier 1 produce useful signal or did it mostly flag the sparsity itself?
6. **Forward-heavy cascade behavior** — Ch 7 references 3 future chapters (9, 10, 11). Were cascade findings richer, sparser, or different in character from Ch 6's more balanced references?
7. **Comparison table: Runs 002 vs 003 vs 004 vs 005** — side-by-side of cluster count, convergence distribution, cascade count, gate-level signal assessment
8. **Recommendations for `book_chapter` gate profile adjustments** based on four data points

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph (future: `seldon audit ingest`)
- Skip the synthesis step — raw gate outputs without clustering are unusable
- Skip the calibration data capture — this run's purpose is calibration as much as review
- Skip the calibration comparison to Runs 002, 003, and 004 — four data points is where patterns get reliable
- Assume `chen_2026_sweci` is correct without verification — new citations get full scrutiny
