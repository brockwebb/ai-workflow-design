# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 9

**Date:** 2026-04-05
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 007 (sixth `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6, Run 005 = Ch 7, Run 006 = Ch 8)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-09.md` — State, Drift, and Validity

---

## Context

This is the seventh AD-020 calibration run and the sixth on `document_type: book_chapter`. Ch 4 (run 002) tested on a thin domain chapter. Ch 5 (run 003) on a mature cross-cutting pattern chapter. Ch 6 (run 004) on an engineering implementation chapter. Ch 7 (run 005) on a defensive engineering chapter. Ch 8 (run 006) on a methodology/evaluation framework chapter. Ch 9 is the **author's original theoretical contribution** — State Fidelity Validity (SFV). This is a different chapter type: not operationalizing someone else's framework (like Ch 8 with NIST/FCSM), but presenting the author's own framework with canonical terminology locked in `SFV_TERMINOLOGY_BASELINE.md`.

Ch 9 is short (~2,160 words, ~117 lines). It has 6 citation instances from 4 unique sources (`webb_2026_ai4stats` x3, `webb_2026_pragmatics` x1, `webb_2025_opencensus_mcp` x1, `nist_genai_2024` x1). All substantive citations are self-citations. The sole external citation (`nist_genai_2024`) is for terminology ("confabulation" not "hallucination"), not substantive claims.

The chapter covers: the "instrument that changes itself" metaphor, the SFV definition, five threats (T1–T5: Semantic Drift, False State Injection, Compression Distortion, State Supersession Failure, State Discontinuity), a retrospective mapping of prior chapters to SFV countermeasures, a Pragmatics case study on deterministic retrieval, training cutoff as validity boundary, model selection drift, one thought experiment, and a bridge to Ch 10.

**The canonical SFV framework has two structures:** five threats (T1–T5) AND five sub-dimensions (TC: Terminological Consistency, SP: State Provenance, CF: Compression Fidelity, SC: Session Continuity, SCoh: State Coherence). These are locked in `docs/sfv/SFV_TERMINOLOGY_BASELINE.md` in the ai4stats repo at `/Users/brock/Documents/GitHub/ai4stats/docs/sfv/SFV_TERMINOLOGY_BASELINE.md`. **The sub-dimensions are entirely absent from Ch 9.** This is a known gap flagged in pre-audit analysis.

**Also known:** The SFV definition in Ch 9 is truncated relative to the canonical baseline. The canonical definition includes "(decisions, terminology, methodology, and intermediate findings)" and the trailing clause "rather than by degraded, distorted, confabulated, or selectively retained versions of that history." Ch 9 drops both.

**Calibration questions for this run:**
- How does the pipeline perform on an **original theoretical framework** chapter vs. a methodology chapter that operationalizes external frameworks (Ch 8)?
- At ~2,160 words, is the chapter substantively underdeveloped for the book's central original contribution?
- Does 100% self-citation rate create structural vulnerability? Is the framework purely self-referential, or does it connect to established concepts (concept drift, provenance, measurement validity)?
- The five threats are well-described but are they actionable? Does the reader know what to DO about them beyond "see prior chapters"?
- The sub-dimensions are absent. Does the pipeline flag this as a gap or is it only apparent when compared to the canonical baseline?
- Does the "Where Prior Chapters Were Already Fighting SFV Threats" section constitute genuine analysis, or is it a retroactive catalog that adds no new insight?
- The training cutoff and model selection sections feel structurally disconnected. Are they T4 case studies or orphaned appendages?
- Does the thought experiment reach Evaluate or Create?
- One reflection prompt in 2,160 words — is the chapter under-scaffolded for active engagement?
- How do cascades behave? Ch 9 references Ch 1, 5, 6, 7, 8 backward and Ch 10 forward. Ch 8 promises Ch 9 delivers "state, drift, and the validity framework." Does it?

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows"
  chapter_pattern: "opening hook → core content → distributed reflection prompts → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 006)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Citations required for factual claims. **ALSO:** verify SFV definition against canonical baseline |
| Tier 2a: Stress Test | Practitioner persona | "Can I design state management and drift detection for my pipeline with this?" |
| Tier 2b: Depth Check | Full Bloom taxonomy | Does reader reach Evaluate/Create, or stop at Understand? |
| Tier 3: Narrative | Full | Story arc, hook, tension, resolution |
| Tier 3: Clarity | Full | Jargon audit against stated audience |
| Tier 3: Visual gaps | Full | Diagrams, tables, figures |
| Tier 3: Motivation | Full | Keller ARCS — does reader know why they should care? |

**New gate for this run (from Run 006 recommendation):** Methodology/framework chapters need a specific check: "Does the framework presentation include a scaffolded exercise where the reader applies it to their own context?" If not, it will stay at Understand regardless of how good the exposition is.

**New gate for this run (canonical baseline check):** Compare all SFV terms, definitions, threat names, and sub-dimension names against `SFV_TERMINOLOGY_BASELINE.md`. Flag any deviation as HIGH priority. This is the SFV chapter — it must be canonically correct.

---

## Instructions

Run the full AD-020 pipeline. All tiers, all gates, synthesis at the end.

### Prerequisites

1. Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set.
2. Verify `.claude/agents/auditor.md` and `.claude/agents/cascade-checker.md` exist (symlinked from Seldon).
3. Verify `audits/` directory exists.
4. Read the SFV canonical baseline: `/Users/brock/Documents/GitHub/ai4stats/docs/sfv/SFV_TERMINOLOGY_BASELINE.md`.

### Step 1: Tier 1 — Correctness Audit (AD-019)

Use the auditor agent protocol on `book/chapter-09.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Read `book/chapter-09.md`.
4. Read `/Users/brock/Documents/GitHub/ai4stats/docs/sfv/SFV_TERMINOLOGY_BASELINE.md` for canonical SFV terms.
5. Execute the full audit per `.claude/agents/auditor.md`.
6. Write output to `audits/chapter-09_content_audit.yaml`.
7. Write Perplexity queries to `audits/chapter-09_perplexity_queries.md`.

**Specific verification targets for Ch 9:**

- **SFV definition (HIGH PRIORITY):** Compare Ch 9's definition word-for-word against `SFV_TERMINOLOGY_BASELINE.md`. Flag any truncation or deviation. The canonical definition includes "(decisions, terminology, methodology, and intermediate findings)" and "rather than by degraded, distorted, confabulated, or selectively retained versions of that history." Both are expected to be absent in Ch 9 — confirm and flag.
- **Five threats (T1–T5):** Verify each threat's canonical name and description match `SFV_TERMINOLOGY_BASELINE.md`. Confirm: T1 = Semantic Drift, T2 = False State Injection, T3 = Compression Distortion, T4 = State Supersession Failure, T5 = State Discontinuity.
- **Five sub-dimensions (TC, SP, CF, SC, SCoh):** Confirm these are absent from Ch 9. Flag as HIGH structural gap.
- **Pragmatics figures:** "91.2% pipeline fidelity versus 74.6% for RAG" — verify against `webb_2026_pragmatics` bib note. (Pre-audit confirmed match, but pipeline should independently verify.)
- **"Stochastic tax" attribution to Ch 1:** Verify Ch 1 actually establishes this term. If it does not, flag as unsourced attribution.
- **`nist_genai_2024` (NIST AI 600-1):** Verify "confabulation" is NIST's preferred term per this document.
- **`webb_2025_opencensus_mcp`:** Verify the "personality problem" is documented in this source.
- **`webb_2026_ai4stats` Ch 20 reference:** Verify ai4stats Chapter 20 covers SFV formally with TSE relationship and classical validity theory. (This is Brock's own book — verify the chapter exists and covers what Ch 9 claims.)
- **Cross-chapter number check:** Verify no question counts (6,954/7,000/6,987) or cost figures ($15/$100/$1,500) appear in Ch 9. (Pre-audit found none — confirm.)

**Do NOT spawn cascade checkers yet.** Save `cascading_audit_tasks` for Step 6.

### Step 2: Tier 2a — Practitioner Stress Test

Given the chapter topic (understanding and defending against state degradation in AI pipelines), generate 8-10 questions a working practitioner would ask.

**Persona:** Working data scientist at a federal statistical agency who has built and deployed a multi-session LLM pipeline using Chapters 5-8's patterns. The pipeline has been running for 3 months. Now they're noticing inconsistencies in outputs across sessions and need to diagnose whether it's a state problem, a data problem, or a model problem. They've read this chapter. Can they diagnose and fix their state issues?

**Example question framing:**
- "My pipeline is producing different results on the same inputs across sessions. How do I tell if it's semantic drift (T1) vs a model update (T4)?"
- "How do I detect that my context window compaction is losing important information (T3)? What should I be monitoring?"
- "My handoff documents are 2 pages long. How do I know if they're capturing enough state to prevent T5?"
- "The pipeline 'remembers' a decision I never made. How do I confirm it's a false state injection (T2) and not just my faulty memory?"
- "How do I measure pipeline fidelity? What's the actual metric and how do I compute it?"
- "My pipeline uses deterministic retrieval for some lookups and embedding search for others. How do I decide which lookups should be deterministic?"
- "A model update happened. How do I know whether my SFV assessment still applies?"
- "What does a state audit actually look like? Give me the checklist."
- "My team wants to extend sessions to reduce T5 risk, but that increases T3 risk. How do I make this tradeoff?"
- "How do I explain SFV to my program manager in terms they understand?"

For each question:
1. Attempt to answer using ONLY chapter 9 material.
2. Score: `fully_answerable` / `partially_answerable` / `not_answerable`.
3. For partial/not answerable: describe the gap.

Write output to `audits/chapter-09_practitioner_stress_test.yaml`:

```yaml
practitioner_stress_test:
  file: "book/chapter-09.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  persona: "Working data scientist diagnosing state degradation in deployed multi-session LLM pipeline"
  
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

For each `##`-level section in chapter 9, classify the highest Bloom level the reader is asked to reach.

**Chapter pattern check:** The book's pedagogical pattern specifies distributed reflection prompts and at least one thought experiment. Ch 9 has ONE reflection prompt (after T5) and one thought experiment (Model Selection Drift section). Check whether these scaffold to Evaluate or Create.

**Special attention for Ch 9:**
- Does the SFV definition section push beyond Remember (recall the definition) to Understand (explain why it matters)?
- Do the five threat descriptions push beyond Understand (describe the threat) to Apply (identify in your own pipeline)?
- Does "Where Prior Chapters Were Already Fighting SFV Threats" reach Analyze (map patterns to framework) or stay at Remember (catalog of mappings)?
- Does the deterministic retrieval section reach Apply (make design decisions) or Understand (describe the tradeoff)?
- Does the thought experiment reach Evaluate (diagnose which threats are active) or Create (design the monitoring)?
- **Framework exercise check (new from Run 006):** Does the chapter include a scaffolded exercise where the reader applies SFV to their own pipeline? If not, flag this as a Bloom gap — the methodology chapter pattern shows this is required for Apply.

Also check: does the chapter's scaffolding build properly? With only one reflection prompt in ~2,160 words, is there enough active engagement to sustain cognitive progression?

Write output to `audits/chapter-09_bloom_depth_check.yaml`:

```yaml
bloom_depth_check:
  file: "book/chapter-09.md"
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
  
  scaffolding_assessment: "[does the chapter build from lower to higher cognitive levels? or plateau?]"
  
  summary:
    sections_at_apply_or_below: N
    sections_at_analyze_or_above: N
    chapter_ceiling: "[the highest Bloom level achieved anywhere]"
    scaffolding_verdict: "well-scaffolded | plateaus_at_X | inconsistent"
```

### Step 4: Tier 3 — Secondary Lens Sweep (Blended)

Single pass applying all four secondary lenses. Read the Tier 2 outputs first so you don't duplicate findings already captured.

For each finding, tag with the lens that surfaced it.

**Special attention for Ch 9:**
- **Narrative:** The "instrument that changes itself" hook is strong. Does tension sustain through the five threats, or does it become an enumerated list? Does the "Where Prior Chapters" section kill momentum? Do the training cutoff and model selection sections feel connected or appended?
- **Clarity:** "State Fidelity Validity" is a term the audience has never encountered. Is the definition accessible? Are the five threat names self-explanatory or do they require memorization? "Stochastic tax" — is this jargon or an established concept?
- **Visual:** Zero figures. The five threats and their countermeasure mappings are a natural table/matrix. The "instrument = weights + context" metaphor could be a diagram. The sub-dimensions (if added) need a table. Severity: HIGH for a theoretical framework chapter.
- **Motivation:** The reader just learned evaluation (Ch 8). Now they're told the instrument changes under them. Does the chapter sustain the "this matters because your pipeline is already doing this" urgency, or does it feel like an academic detour?

Write output to `audits/chapter-09_secondary_sweep.yaml`:

```yaml
secondary_sweep:
  file: "book/chapter-09.md"
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

Combine ALL findings from Tiers 1-3 into a single synthesis document.

**Clustering rules:**
1. Group findings by topic, not by gate.
2. Tag each finding with its source lens/gate.
3. Count convergence (how many lenses flagged this cluster).
4. Order clusters by convergence (highest first).
5. Write actionable scope, not suggested edits.
6. Each cluster must be self-contained for serial processing.
7. Cap at ~8 clusters. Remaining items go in `unclustered`.

Write output to `audits/chapter-09_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-09.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-09_content_audit.yaml"
  
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

Read `cascading_audit_tasks` from `audits/chapter-09_content_audit.yaml`. Group by target chapter.

**Expected cascade targets:**
- **Ch 7 (backward):** "Chapter 7's thought experiment" — verify the 30% classification shift thought experiment exists and that Ch 9's reference is accurate.
- **Ch 7 (backward):** Config-driven architecture, progressive test infrastructure, checkpoint and recovery — verify these are presented in Ch 7 as described in Ch 9.
- **Ch 5 (backward):** Ensemble patterns — verify Ch 5 presents multi-model disagreement as described in Ch 9.
- **Ch 6 (backward):** Design for change — verify Ch 6 presents swap-ready interfaces as described in Ch 9.
- **Ch 8 (backward):** Evaluation by design — verify Ch 8 presents continuous quality metrics as described in Ch 9.
- **Ch 8 (backward bridge):** Ch 8's closing promises "state, drift, and the validity framework" — verify Ch 9 delivers this.
- **Ch 1 (backward):** "Stochastic tax" — verify this term is established in Ch 1.
- **Ch 10 (forward):** Ch 9 promises "state management and research provenance" — verify Ch 10 delivers.

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-09.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results to `audits/chapter-09_cascade_results.yaml`.

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, submission-equivalent assessment
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts, top gaps
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment

**Calibration comparison:** Explicitly compare Run 007 results to all prior runs (002–006). Note:
- **Theoretical framework chapter vs. methodology/framework (Ch 8):** Does presenting the author's own framework produce different signal than operationalizing someone else's? Does 100% self-citation create different risks than Ch 8's 77%?
- **Chapter length signal:** At ~2,160 words, is the pipeline sensitive to underdevelopment? Does shortness map to more unanswerable practitioner questions or lower Bloom ceilings?
- **Sub-dimension absence:** Does the pipeline independently flag the missing sub-dimensions, or does it only catch this because we told it to look? If the latter, consider adding a "canonical baseline verification" gate for framework chapters.
- **Backward-heavy cascade pattern:** Ch 9 references 5 prior chapters. Is this the most backward-referencing chapter in the series? Does it create a "retrospective catalog" problem where the chapter's value is mostly "you already learned these things, here are their names"?
- **Visual gap persistence (6th data point):** Confirm or deny.
- **Reflection prompt density:** One prompt in ~2,160 words vs. Ch 8's three prompts. Does the pipeline flag under-scaffolding?
- **External literature gap:** No connections to concept drift, provenance, or measurement validity literature. Does the pipeline flag the absence of external theoretical grounding for an original framework?

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-09_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-09_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-09_practitioner_stress_test.yaml` | Tier 2a: stress test |
| `audits/chapter-09_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-09_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-09_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-09_cascade_results.yaml` | Cascade checker results |

---

## Calibration Data Capture

After the run, write calibration notes to `seldon/docs/design/AD-020_calibration_007_ch09.md` covering:

1. **Gate effectiveness by tier** — which gates produced signal vs noise?
2. **Theoretical framework chapter characteristics** — how do gates behave on an original contribution chapter vs. methodology (Ch 8), engineering (Ch 6/7), pattern (Ch 5), domain (Ch 4)?
3. **Self-citation density at 100%** — structural vulnerability assessment. Does the chapter connect SFV to ANY established literature (concept drift, provenance, measurement validity), or is it entirely self-referential?
4. **Sub-dimension detection** — did the pipeline independently identify the missing sub-dimensions? If not, the canonical baseline check gate needs to be mandatory for framework chapters.
5. **Chapter development level** — at ~2,160 words, did the pipeline produce signal about underdevelopment? Practitioner unanswerable count and Bloom floor are proxies.
6. **Visual gap persistence (6th data point)** — update the running table.
7. **Cascade pattern for backward-heavy chapters** — Ch 9 references 5+ prior chapters. Does this create different cascade behavior than forward-heavy chapters (Ch 7)?
8. **Comparison table: Runs 002–007** — side-by-side of all metrics across 6 book_chapter runs.
9. **Recommendations for `book_chapter` gate profile adjustments** based on six data points.

**NOTE:** A pre-audit calibration analysis was written to `seldon/docs/design/AD-020_calibration_007_ch09.md` by the desktop session before this CC task was created. The CC task pipeline should produce its OWN calibration output and compare/reconcile with the pre-audit analysis. If findings diverge, note where and why — this is useful calibration data (does the pipeline find things the human+desktop analysis missed, and vice versa?).

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph
- Skip the synthesis step
- Skip the calibration data capture
- Skip the calibration comparison to Runs 002–006
- Assume the SFV definition in Ch 9 is correct — verify against canonical baseline
- Treat the sub-dimension absence as "by design" — flag it as a structural gap
- Skip the canonical baseline verification step (reading `SFV_TERMINOLOGY_BASELINE.md`)
