# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 8

**Date:** 2026-04-03
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 006 (fifth `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6, Run 005 = Ch 7)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-08.md` — Evaluation by Design

---

## Context

This is the sixth AD-020 calibration run and the fifth on `document_type: book_chapter`. Ch 4 (run 002) tested on a thin domain chapter (~97 lines). Ch 5 (run 003) on a mature cross-cutting pattern chapter (~300+ lines). Ch 6 (run 004) on an engineering implementation chapter (~200 lines). Ch 7 (run 005) on a defensive engineering chapter (~105 lines). Ch 8 is a **methodology and evaluation framework** chapter — it teaches practitioners how to design evaluation architectures using the FCSM-NIST crosswalk as scaffolding, covering golden test sets, regression testing, multi-model agreement as evaluation, continuous evaluation, and evaluation economics.

Ch 8 is well-developed (~250 lines). It has 5 citations (`mazeika_2025`, `webb_2026_crosswalk`, `nist_ai_rmf_2023`, `webb_2026_concept_mapper`, `chen_2026_sweci`). Notably, `webb_2026_crosswalk` is used 7 times — the crosswalk paper is the structural backbone of this chapter. `chen_2026_sweci` is reused from Ch 7 (already verified in run 005). The chapter's position is the transition from "how to make it reliable" (Ch 7) to "how to know it's valid" (Ch 9). It bridges construction chapters (5-7) with validity chapters (9-10).

The chapter's unique contribution is operationalizing the FCSM-NIST crosswalk as a design tool rather than a compliance checklist, and the argument that valid-and-reliable is a binary gate (not a dial). The "build your own benchmark" framing is distinctive in official statistics where practitioners often wait for standard benchmarks that will never arrive.

**Calibration questions for this run:**
- How does the pipeline perform on a methodology/framework chapter vs. an engineering chapter (Ch 7) vs. an implementation chapter (Ch 6)?
- Does heavy reliance on a single source (`webb_2026_crosswalk` × 7) produce Tier 1 concerns about source diversity, or is this appropriate for a chapter that operationalizes that paper?
- Is the "valid and reliable is a gate, not a dial" argument supported at the level of rigor the chapter claims? Does it reach Evaluate or stay at Understand?
- Does the chapter actually teach practitioners HOW to build evaluation architectures, or does it describe what good evaluation looks like without sufficient implementation guidance (Apply gap)?
- How do cascades behave for a chapter that references both its own author's work (crosswalk, concept mapper) and external sources? Does self-citation density create structural risks?
- Does the evaluation economics section ($100 for concept mapper, $15 for pragmatics) remain accurate and appropriately framed? These are powerful claims — verify they're bulletproof.
- The chapter has 3 reflection prompts and 1 multi-part thought experiment. Does the scaffolding actually build toward Evaluate/Create or plateau?
- Does the chapter adequately distinguish between evaluation of the AI system and evaluation of the data product? This is the crosswalk's core thesis — does the chapter deliver it?

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows"
  chapter_pattern: "opening hook → core content → distributed reflection prompts → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 005)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Citations required for factual claims |
| Tier 2a: Stress Test | Practitioner persona | "Can I design an evaluation architecture for my pipeline with this?" |
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

Use the auditor agent protocol on `book/chapter-08.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Read `book/chapter-08.md`.
4. Execute the full audit per `.claude/agents/auditor.md`.
5. Write output to `audits/chapter-08_content_audit.yaml`.
6. Write Perplexity queries to `audits/chapter-08_perplexity_queries.md`.

**Specific verification targets for Ch 8:**
- `mazeika_2025` — **NEW CITATION, HIGH PRIORITY.** Verify: (a) paper exists and is correctly attributed, (b) "240 real freelance projects sourced from Upwork" is accurate, (c) "spanning 23 work categories" is accurate, (d) "over 6,000 hours of human labor" is accurate, (e) "2.5% at client-acceptable quality" is accurate for the best agent, (f) cite key follows convention.
- `webb_2026_crosswalk` — This is Brock's own paper. Verify: (a) the five mapping types (Direct, Partial, Split, Distributed, FCSM-only) and their counts (4, 1, 2, 3, 4) are accurate against the paper, (b) the "valid and reliable is the foundation" claim accurately represents NIST's architecture, (c) the two tailored crosswalk summaries (batch classification, real-time consultation) are accurate against the paper, (d) "specification gap" framing is fair representation.
- `nist_ai_rmf_2023` — Verify the "valid and reliable" characterization as foundational/prerequisite to all other trustworthiness characteristics. Cross-check with Ch 7's NIST characterization for consistency.
- `webb_2026_concept_mapper` — Verify: (a) "under $100 in API fees for the full classification pipeline" is accurate (cross-check with Ch 14's framing — note: the "$15 vs $1,500" framing lives in Ch 14 ONLY), (b) "7,000 questions, three models, structured arbitration" — the canonical count is 6,954 analyzable questions from ~7,000 raw, (c) Fleiss' κ = 0.537 pre-arbitration, κ = 0.843 post-arbitration — verify these specific numbers, (d) the "construct validity" interpretation of multi-model agreement is defensible.
- `chen_2026_sweci` — Already verified in Run 005. Cross-check that claims in Ch 8 are consistent with Ch 7's usage. No re-verification needed unless claims differ.
- "$15 in API fees for a three-stage evaluation pipeline" for the pragmatics evaluation — verify this is attributed to the crosswalk paper (`webb_2026_crosswalk`), not the concept mapper. The $15 figure and the $100 figure are different evaluations of different systems.
- FCSM 20-04 — Verify this is the correct document number for the federal statistical quality standards. Not separately cited but named in body text.

**Do NOT spawn cascade checkers yet.** Save `cascading_audit_tasks` for Step 6.

### Step 2: Tier 2a — Practitioner Stress Test

Given the chapter topic (designing evaluation architectures for AI-powered research pipelines using FCSM-NIST crosswalk), generate 8-10 questions a working practitioner would ask. These must be evaluation design judgment questions, not factual recall.

**Persona:** Working data scientist at a federal statistical agency who has built a pipeline using Chapters 5-7's patterns and now needs to convince their agency's data quality review board that the pipeline produces trustworthy outputs. They've read this chapter. Can they design and defend their evaluation?

**Example question framing:**
- "I need to present my pipeline's evaluation results to our quality review board. They speak FCSM, not F1 scores. How do I translate?"
- "My golden test set has 200 questions. Is that enough? How do I know when my test set is 'good enough'?"
- "My pipeline uses a model from Vendor A and a model from Vendor B. They agree 92% of the time. Is that good? What does the agreement tell me about construct validity?"
- "Leadership wants me to use public benchmark scores to justify switching to a cheaper model. What evidence from the benchmarks should I reject as insufficient?"
- "My pipeline has been stable for 6 months. The CIO asks 'how do we know it's not making confident mistakes we haven't caught?' What's my honest answer?"
- "I want to add a confabulation detection layer. The chapter says neither FCSM nor NIST specifies what this looks like. Where do I start?"
- "My evaluation costs $100 per run. Finance says that's too expensive for monthly runs. How do I argue for continuous evaluation?"
- "A colleague says multi-model agreement is just 'correlated bias.' How do I address this?"
- "I have FCSM quality dimensions covered but no NIST trustworthiness mapping. Is that sufficient?"
- "My pipeline processes ACS data. The evaluation framework chapter doesn't mention ACS-specific concerns. What am I missing?"

For each question:
1. Attempt to answer using ONLY chapter 8 material.
2. Score: `fully_answerable` / `partially_answerable` / `not_answerable`.
3. For partial/not answerable: describe the gap.

Write output to `audits/chapter-08_practitioner_stress_test.yaml`:

```yaml
practitioner_stress_test:
  file: "book/chapter-08.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  persona: "Working data scientist at federal statistical agency defending pipeline evaluation to quality review board"
  
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

For each `##`-level section in chapter 8, classify the highest Bloom level the reader is asked to reach.

**Chapter pattern check:** The book's pedagogical pattern specifies distributed reflection prompts and at least one thought experiment. These should scaffold to Evaluate or Create. Check whether they actually do.

**Special attention for Ch 8:** This is a methodology chapter — the floor should be Apply (can the reader design an evaluation architecture?), but the crosswalk operationalization and the "valid and reliable is a gate" argument should reach Analyze or Evaluate. The thought experiment (annual quality review presentation) should reach Evaluate (what evidence to present) or Create (designing the defense). 

Key depth questions:
- Does "Building Your Own Evaluation Instruments" reach Apply (here's how to build a golden test set) or stay at Understand (here's what a golden test set is)?
- Does "The Tailored Crosswalk as Evaluation Design Tool" reach Analyze (map your own design choices to dual frameworks) or stay at Understand (here's what the crosswalk found)?
- Does "What Evaluation Cannot Do" reach Evaluate (judge the limits of your own evaluation) or stay at Remember (list of caveats)?
- Does the evaluation economics section reach Apply (design your evaluation budget) or stay at Understand (evaluation is cheap)?

Also check: does the chapter's scaffolding build properly from concrete (Remote Labor Index hook, golden test sets) to abstract (tailored crosswalk design tool, evaluation limits)? Or does it jump between levels?

Write output to `audits/chapter-08_bloom_depth_check.yaml`:

```yaml
bloom_depth_check:
  file: "book/chapter-08.md"
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

**Special attention for Ch 8:**
- **Narrative:** The Remote Labor Index hook is strong but does the chapter sustain tension? Or does it become a dry crosswalk summary after the opening?
- **Clarity:** "Direct," "Partial," "Split," "Distributed," "FCSM-only" — are these mapping types clear to the target audience without the paper in hand? Or is this insider vocabulary?
- **Visual:** The crosswalk mapping types and the tailored crosswalk examples are screaming for tables or diagrams. Zero figures in a methodology chapter is a bigger gap than in an engineering chapter.
- **Motivation:** Does the practitioner understand WHY they should build their own evaluation instruments rather than wait for standard benchmarks? The hook motivates this, but does the motivation sustain through the crosswalk section?

Write output to `audits/chapter-08_secondary_sweep.yaml`:

```yaml
secondary_sweep:
  file: "book/chapter-08.md"
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

Write output to `audits/chapter-08_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-08.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-08_content_audit.yaml"
  
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

Now read `cascading_audit_tasks` from the Tier 1 output (`audits/chapter-08_content_audit.yaml`). Group by target chapter.

**Note:** Ch 8 references backward to Ch 1 (evaluation trap), Ch 5 (multi-model agreement architecture, structured arbitration), and Ch 6 (implied batch architecture context). It references forward to Ch 9 (state, drift, validity framework). Expect cascades in both directions but lighter than Ch 7's forward-heavy pattern.

**Specific cascade concerns:**
- Ch 5's multi-model agreement architecture — Ch 8 claims it "addresses accuracy and reliability (FCSM) and valid and reliable (NIST) at the same time." Verify Ch 5 actually delivers multi-model agreement architecture at this level.
- Ch 5's structured arbitration protocol — Ch 8 claims it "addresses scientific integrity (FCSM) and accountable and transparent (NIST)." Verify Ch 5 delivers structured arbitration.
- Ch 1 evaluation trap — Ch 8 references "the evaluation trap from Chapter 1 inverted." Verify Ch 1 actually contains an evaluation trap argument and that the inversion is accurate.
- Ch 9 bridge — Ch 8's closing promises Ch 9 covers "what happens when the instrument changes under you: state, drift, and the validity framework." Verify Ch 9 delivers on this promise.
- `chen_2026_sweci` cross-chapter consistency — verify Ch 8's claims about this paper are consistent with Ch 7's verified usage. Same numbers, same framing.
- `webb_2026_concept_mapper` cross-chapter consistency — verify κ values and cost figures are consistent across all chapters that cite this paper.
- `nist_ai_rmf_2023` cross-chapter consistency — verify NIST characterization is consistent between Ch 7 and Ch 8.

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-08.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results:
- `confirmed` → write to `audits/chapter-08_cascade_results.yaml`
- `needs_full_audit` → note for follow-up
- `clear` → no action

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, submission-equivalent assessment
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts, top gaps
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment for `book_chapter` type

**Calibration comparison:** Explicitly compare Run 006 results to Runs 002 (Ch 4), 003 (Ch 5), 004 (Ch 6), and 005 (Ch 7). Note:
- Methodology/framework chapter vs. defensive engineering (Ch 7) vs. implementation (Ch 6) vs. pattern (Ch 5) vs. domain (Ch 4) — did the practitioner stress test produce different signal types?
- Did the visual gap pattern (high convergence in Ch 4, 5, 6, 7) persist? (This would be the fifth data point.)
- With 5 citations but heavy reliance on one (`webb_2026_crosswalk` × 7), did Tier 1 produce different signal than Ch 7's sparse-but-diverse citation profile?
- Did the crosswalk operationalization sections produce meaningful Bloom/depth signal? Is "operationalizing a framework paper" inherently at Apply or can it reach Analyze/Evaluate?
- Were cascade findings different for a chapter that bridges construction (5-7) and validity (9-10)?
- Does heavy self-citation (author's own crosswalk and concept mapper papers) produce structural risks that external citation wouldn't?
- How does the evaluation economics section hold up — is "$100" / "$15" bulletproof or does it need caveats?

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-08_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-08_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-08_practitioner_stress_test.yaml` | Tier 2a: stress test |
| `audits/chapter-08_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-08_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-08_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-08_cascade_results.yaml` | Cascade checker results (if any) |

---

## Calibration Data Capture

After the run, write calibration notes to `seldon/docs/design/AD-020_calibration_006_ch08.md` covering:

1. **Gate effectiveness by tier** — which gates produced signal vs noise?
2. **Methodology chapter characteristics** — how did gates behave on an evaluation/framework chapter vs. engineering (Ch 7), implementation (Ch 6), pattern (Ch 5), domain (Ch 4)?
3. **Self-citation density** — does `webb_2026_crosswalk` × 7 create structural risks? Is heavy reliance on author's own work appropriate when the chapter is explicitly operationalizing that work, or does it weaken the chapter's independence?
4. **Visual gap persistence** — is the zero-figures finding still holding (now 5 data points if confirmed)? A methodology chapter with crosswalk mapping types and tailored crosswalk examples and no tables/diagrams is a stronger visual gap signal than an engineering chapter.
5. **"Gate not dial" argument rigor** — did the pipeline evaluate whether this claim is adequately supported? Does the chapter assert it or demonstrate it?
6. **Evaluation economics robustness** — are the $100 and $15 figures verified and appropriately caveated? These are the kind of specific claims that get challenged in reviews.
7. **Bloom depth on framework operationalization** — does "here's how to use the crosswalk as a design tool" reach Apply or stay at Understand? This is a key signal for methodology chapters generally.
8. **Comparison table: Runs 002 vs 003 vs 004 vs 005 vs 006** — side-by-side of cluster count, convergence distribution, cascade count, gate-level signal assessment
9. **Recommendations for `book_chapter` gate profile adjustments** based on five data points

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph (future: `seldon audit ingest`)
- Skip the synthesis step — raw gate outputs without clustering are unusable
- Skip the calibration data capture — this run's purpose is calibration as much as review
- Skip the calibration comparison to Runs 002, 003, 004, and 005 — five data points is where patterns solidify
- Confuse the two cost figures: $100 is the concept mapper full pipeline cost, $15 is the pragmatics evaluation cost from the crosswalk paper — they are different systems, different evaluations
- Treat `chen_2026_sweci` as needing re-verification — it was verified in Run 005, just check cross-chapter consistency
- Assume FCSM 20-04 document number is correct without verification — it's named in body text but not formally cited
