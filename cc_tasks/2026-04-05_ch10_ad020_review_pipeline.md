# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 10

**Date:** 2026-04-05
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 008 (seventh `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6, Run 005 = Ch 7, Run 006 = Ch 8, Run 007 = Ch 9)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-10.md` — State Management & Research Provenance

---

## Context

This is the eighth AD-020 calibration run and the seventh on `document_type: book_chapter`. Ch 10 is an **infrastructure and implementation** chapter — it teaches the reader how to build provenance systems. It sits on the critical path: Ch 9 names the validity problem (SFV), Ch 10 provides the infrastructure response. The chapter's primary case study is Seldon (the author's own artifact tracking system), with secondary reference to the Concept Mapper and Pragmatics.

Ch 10 is ~3,146 words. It has relatively few citations — `webb_2026_concept_mapper` and `shapiro_2026` are the identifiable ones. This is a chapter type the pipeline has not seen: **practitioner infrastructure guide with the author's own system as primary case study**. The risk profile differs from prior chapters: the danger is not missing external literature (infrastructure chapters are inherently experience-based) but rather that the chapter reads as a Seldon tutorial rather than teaching transferable design patterns.

The chapter covers: defensibility framing, three reasons provenance is non-optional, eight requirements for research provenance, why git is insufficient, the DOORS lesson (right requirements, wrong cost model), AI partners changing the cost equation, configuration control as design pattern, the graph-of-artifacts pattern (dual-layer architecture), provenance chains, domain configuration, shared vocabulary as infrastructure, authority model, thought experiment, and bridge to Ch 11.

**Known items from handoff (Session 25):**
- Ch 10 is the destination for the full knowledge graph treatment. Task in graph (5e20b17a). The design note (`docs/design_note_knowledge_graphs_as_pipeline_state.md`) specifies what the KG section should cover: graph schema design, Seldon worked example, Pragmatics worked example, relational-to-graph migration path, practical tradeoffs.
- Hogan et al. 2021 bib entry needed. Task in graph (bfda3b09).
- Ch 6 now seeds the graph vs relational design choice (just inserted). Ch 9 connects graph-based state externalization to SFV countermeasures. Ch 10 should complete the thread.
- The chapter currently has NO explicit knowledge graph section despite the design note calling for one. The "Graph-of-Artifacts Pattern" section is close but doesn't name knowledge graphs, doesn't reference Pragmatics' graph-based retrieval, and doesn't provide the relational-to-graph migration path.

**Calibration questions for this run:**
- How does the pipeline perform on a **practitioner infrastructure guide** vs. theoretical framework (Ch 9) vs. methodology (Ch 8)?
- Does the chapter actually teach transferable patterns, or does it read as a Seldon feature list?
- The "Eight Requirements" section is the chapter's structural backbone. Are the requirements specific enough to be actionable but general enough to transfer beyond Seldon?
- Does the dual-layer architecture (event log + graph) section explain WHY two layers rather than just describing that there are two?
- Is the DOORS section earning its real estate? Does the reader care about a 1990s requirements management tool?
- The chapter promises "defensible by design" in the hook. Does it deliver on that promise by the end?
- How does the cascade behavior differ for an infrastructure chapter that references many prior chapters as motivating problems?
- Is the authority model section (humans at decision points) adequately connected to the book's tenet "Humans remain accountable"?
- Zero figures. For a chapter teaching infrastructure architecture, this is likely a severe gap.
- Does the chapter bridge to Ch 11 (orchestration) cleanly, or does it feel like an abrupt topic switch?

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows"
  chapter_pattern: "opening hook → core content → distributed reflection prompts → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 007)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Citations required for factual claims. Verify Shapiro 2026 levels reference. |
| Tier 2a: Stress Test | Practitioner persona | "Can I build a provenance system for my pipeline with this?" |
| Tier 2b: Depth Check | Full Bloom taxonomy | Does reader reach Evaluate/Create, or stop at Understand? |
| Tier 3: Narrative | Full | Story arc, hook, tension, resolution |
| Tier 3: Clarity | Full | Jargon audit against stated audience |
| Tier 3: Visual gaps | Full | Diagrams, tables, figures |
| Tier 3: Motivation | Full | Keller ARCS — does reader know why they should care? |

**Carried gate from Run 006:** Methodology/framework chapters need a specific check: "Does the framework presentation include a scaffolded exercise where the reader applies it to their own context?" Applies here — the eight requirements are a framework. Can the reader assess their own system against them?

**New gate for this run (tutorial vs. pattern check):** Does the chapter teach the PATTERN or does it teach SELDON? For each section, ask: "If I replaced 'Seldon' with 'my system,' does this section still make sense?" If not, the section is too implementation-specific.

---

## Instructions

Run the full AD-020 pipeline. All tiers, all gates, synthesis at the end.

### Prerequisites

1. Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set.
2. Verify `.claude/agents/auditor.md` and `.claude/agents/cascade-checker.md` exist (symlinked from Seldon).
3. Verify `audits/` directory exists.

### Step 1: Tier 1 — Correctness Audit (AD-019)

Use the auditor agent protocol on `book/chapter-10.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Read `book/chapter-10.md`.
4. Execute the full audit per `.claude/agents/auditor.md`.
5. Write output to `audits/chapter-10_content_audit.yaml`.
6. Write Perplexity queries to `audits/chapter-10_perplexity_queries.md`.

**Specific verification targets for Ch 10:**

- **Shapiro 2026 levels reference:** Ch 10 cites `shapiro_2026`'s levels from Chapter 1. Verify: (a) the bib entry exists, (b) Ch 1 actually presents these levels, (c) the "Level 2 → Level 3" framing in Ch 10 matches what Ch 1 establishes.
- **DOORS claims:** "IBM DOORS, Dynamic Object-Oriented Requirements System" — verify the full name. Verify it was used in aerospace/defense. Verify the adoption problem characterization (dedicated operators, manual traceability). These are verifiable factual claims.
- **Concept Mapper provenance claim:** "reconstructing how those results were produced after the fact took days" — this is experiential. Flag as author's observation, not verifiable. But verify the Concept Mapper citation resolves.
- **"A separate project had to be abandoned entirely because provenance could not be recovered"** — author's claim. Not independently verifiable. Flag for acknowledgment in the chapter that this is experiential.
- **Eight requirements completeness check:** Are the eight requirements internally consistent? Do any overlap? Do any contradict? Is there a gap — a requirement that a practitioner would need but isn't listed?
- **Cross-chapter number check:** Verify any question counts (6,954/7,000/6,987) or cost figures match canonical values. The "$100 total API cost" for the Concept Mapper — verify this doesn't conflict with other chapters' cost claims.
- **"257 artifacts with 131 typed relationships across 14 chapters"** — this appears in the design note's Ch 9 section. Check if similar numbers appear in Ch 10 and whether they're current (Seldon graph currently shows 264 nodes, 131 relationships per `seldon_go` output).

**Do NOT spawn cascade checkers yet.** Save `cascading_audit_tasks` for Step 6.

### Step 2: Tier 2a — Practitioner Stress Test

Given the chapter topic (building provenance infrastructure for AI-assisted research), generate 8-10 questions a working practitioner would ask.

**Persona:** Working data scientist at a federal statistical agency who has read Ch 9 (SFV) and now needs to build the infrastructure to defend against those threats. They have a running pipeline. They have git. They don't have a provenance system. They need to build one, or adopt one, or justify the investment to their manager.

**Example question framing:**
- "I have 200 Python scripts and 50 datasets. How do I start tracking provenance without boiling the ocean?"
- "My manager asks: what's the ROI of building a provenance system vs. just keeping good notes? What do I tell them?"
- "The eight requirements make sense, but implementing all eight at once is impossible. Which ones do I start with?"
- "How do I handle provenance for ad-hoc analyses that weren't planned? Not everything goes through a spec."
- "The dual-layer architecture sounds like I need a graph database. Do I? What's the minimum viable version?"
- "How do I integrate provenance tracking with my existing CI/CD pipeline?"
- "The chapter mentions 'staleness propagation.' How does this work in practice — do I get an alert? Do I run a script?"
- "My pipeline runs monthly. Do I need continuous provenance tracking, or is batch tracking sufficient?"
- "The DOORS comparison is helpful, but I'm not in aerospace. What does 'right requirements, wrong cost model' mean for a 3-person team at a statistical agency?"
- "How do I prove to an auditor that my provenance system itself is trustworthy?"

For each question:
1. Attempt to answer using ONLY chapter 10 material.
2. Score: `fully_answerable` / `partially_answerable` / `not_answerable`.
3. For partial/not answerable: describe the gap.

Write output to `audits/chapter-10_practitioner_stress_test.yaml`:

```yaml
practitioner_stress_test:
  file: "book/chapter-10.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  persona: "Working data scientist building provenance infrastructure for deployed AI pipeline"
  
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

For each `##`-level section in chapter 10, classify the highest Bloom level the reader is asked to reach.

**Chapter pattern check:** The book's pedagogical pattern specifies distributed reflection prompts and at least one thought experiment. Count reflection prompts in Ch 10. Verify at least one thought experiment exists.

**Special attention for Ch 10:**
- Does the "Eight Requirements" section push beyond Remember (list the requirements) to Apply (assess your own system against them)?
- Does the dual-layer architecture section push beyond Understand (describe the architecture) to Evaluate (assess whether you need both layers)?
- Does the DOORS section push beyond Remember (recall that DOORS existed) to Analyze (extract the transferable lesson about cost models)?
- Does the Graph-of-Artifacts section push beyond Understand (describe the pattern) to Apply (design your own graph schema)?
- Does the thought experiment reach Evaluate or Create?
- **Framework exercise check (from Run 006):** The eight requirements ARE a framework. Does the chapter include a scaffolded exercise where the reader assesses their own system? The reflection prompt after the eight requirements is the natural location.
- **Tutorial vs. pattern check (new):** For sections that describe Seldon specifically, does the cognitive demand stay at Understand (describe how Seldon works) or does it generalize to Apply/Evaluate (design your own system using these patterns)?

Write output to `audits/chapter-10_bloom_depth_check.yaml`:

```yaml
bloom_depth_check:
  file: "book/chapter-10.md"
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

**Special attention for Ch 10:**
- **Narrative:** The IG audit hook is strong. Does the chapter sustain urgency through the eight requirements, or does it become an enumerated specification? Does the DOORS historical aside maintain or break narrative momentum? Does the dual-layer architecture section feel like a design rationale or an implementation manual?
- **Clarity:** "Typed artifacts," "staleness propagation," "state serialization," "event log projection" — is this vocabulary accessible to the stated audience (data scientists at federal agencies)? Or does it assume distributed systems engineering background?
- **Visual:** Zero figures. For a chapter teaching dual-layer architecture, provenance chains, and graph-of-artifacts patterns, this is almost certainly a severe gap. The provenance chain example is a text-based graph traversal that screams for a diagram. The dual-layer architecture is described but not shown.
- **Motivation:** Does the chapter maintain the "this saves you when the IG calls" urgency throughout, or does it drift into infrastructure aesthetics? The DOORS section and the shared vocabulary section are the most likely places where motivation sags.

Write output to `audits/chapter-10_secondary_sweep.yaml`:

```yaml
secondary_sweep:
  file: "book/chapter-10.md"
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

Write output to `audits/chapter-10_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-10.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-10_content_audit.yaml"
  
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
  
  verdict: "submit_as_is | revise_before_use | major_revision_needed"
```

### Step 6: Cascade Checking (from Tier 1)

Read `cascading_audit_tasks` from `audits/chapter-10_content_audit.yaml`. Group by target chapter.

**Expected cascade targets:**
- **Ch 9 (backward):** Ch 10 opens by saying "Chapter 9 named the problem." Verify Ch 9 delivers SFV as promised.
- **Ch 9 (backward):** "the same state drift Chapter 9 describes at the pipeline level" — verify Ch 9 actually frames state drift this way.
- **Ch 7 (backward):** "Chapter 7's reproducible research discipline" and "config-driven architecture is the 'save the random seed' principle" — verify Ch 7 establishes these.
- **Ch 1 (backward):** Shapiro 2026 levels — verify Ch 1 introduces Level 2/Level 3 distinction.
- **Ch 5 (backward):** Multi-model patterns — verify any Ch 10 references to ensemble design match Ch 5.
- **Ch 11 (forward):** Ch 10 bridges to orchestration. Verify Ch 11 picks up where Ch 10 leaves off.
- **Ch 6 (backward):** The new KG seed paragraph references Ch 10 for implementation guidance. Verify Ch 10 delivers (or flag that the KG treatment section is still missing).

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-10.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results to `audits/chapter-10_cascade_results.yaml`.

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, verdict
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts, top gaps
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment

**Calibration comparison:** Explicitly compare Run 008 results to all prior runs (002–007). Note:
- **Infrastructure guide chapter type vs. prior types:** Does the "tutorial vs. pattern" gate produce useful signal? Does this chapter type produce different Bloom distributions than theoretical (Ch 9), methodology (Ch 8), or engineering (Ch 6/7)?
- **Self-citation profile:** What's the ratio? Compare to Ch 9's 100% self-citation and Ch 8's 77% external.
- **Visual gap persistence (7th data point):** Confirm or deny. Update the running table.
- **Reflection prompt density:** Count and compare to prior chapters.
- **Practitioner answerability for infrastructure chapters:** Does an implementation-focused chapter score higher on answerability than a theoretical chapter (Ch 9)?
- **DOORS section ROI:** Does the pipeline flag this section as earning/not earning its word count? Does the historical aside add insight or break flow?
- **Knowledge graph treatment gap:** The design note calls for explicit KG sections that don't yet exist. Does the pipeline independently flag this absence, or does it only surface through the cascade check against Ch 6's new forward reference?

Write calibration notes to `seldon/docs/design/AD-020_calibration_008_ch10.md`.

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-10_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-10_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-10_practitioner_stress_test.yaml` | Tier 2a: stress test |
| `audits/chapter-10_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-10_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-10_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-10_cascade_results.yaml` | Cascade checker results |
| `seldon/docs/design/AD-020_calibration_008_ch10.md` | Calibration data |

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph
- Skip the synthesis step
- Skip the calibration data capture
- Skip the calibration comparison to Runs 002–007
- Treat the missing KG treatment section as acceptable — flag it as a structural gap
- Describe Seldon features without extracting the transferable pattern
- Skip the "tutorial vs. pattern" check on Seldon-specific sections
