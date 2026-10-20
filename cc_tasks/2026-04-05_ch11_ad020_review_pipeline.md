# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 11

**Date:** 2026-04-05
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 009 (eighth `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6, Run 005 = Ch 7, Run 006 = Ch 8, Run 007 = Ch 9, Run 008 = Ch 10)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-11.md` — Workflow Orchestration & the Tool Landscape

---

## Context

This is the ninth AD-020 calibration run and the eighth on `document_type: book_chapter`. Ch 11 is a **landscape assessment and evaluation framework** chapter — it teaches the reader how to evaluate orchestration tools, not how to build one (that was Ch 10). It is the chapter the book explicitly warns will age fastest (HTML comment: "Design for updateability — this chapter ages fastest").

Ch 11 is ~3,187 words. It has exactly three citations: `webb_2026_pragmatics`, `fcsm_2025_aiready`, and `chen_2026_sweci`. This is a sparse citation profile for a chapter surveying an industry landscape. The question is whether this is appropriate (the chapter deliberately avoids tool-specific recommendations that would date) or a gap (landscape claims need sourcing).

The chapter covers: the tool gap (research vs. software engineering orchestration), a four-dimension evaluation framework (coupling, friction, transparency, volatility), four categories of orchestration (managed platforms, code-first frameworks, CLI/script, custom), the 90/10 rule and last mile problem, tool design for observability in agentic systems, context windows and state management, recursive stochasticity (full treatment), and bet-on-patterns vs. wait-on-consolidation guidance.

**Chapter type considerations:**
This is a new chapter type for the pipeline: **evaluation framework + landscape survey**. Unlike Ch 10 (infrastructure guide with author's system as case study) or Ch 9 (theoretical framework), Ch 11 must balance two tensions:
1. Being specific enough about current tools to be useful without dating itself
2. Providing a durable evaluation framework that outlasts any specific tool

The chapter's HTML comment acknowledges this tension explicitly. The pipeline should assess whether the balance works.

**Known items from handoff (Session 26):**
- The **industry vocabulary convergence design note** (`docs/design_note_industry_vocabulary_convergence.md`) targets Ch 11 for its terminology mapping table. This is a planned revision item, not an audit finding — but the audit should assess whether the chapter currently has a vocabulary bridging problem independent of the design note.
- Ch 9 + Ch 5 industry convergence insertions were just executed (late-stage gate disambiguation in Ch 9, convergent evidence sentence in Ch 5). Ch 11 should be assessed for consistency with those insertions.
- The recursive stochasticity section cites `chen_2026_sweci` — this is a relatively new citation. Verify it exists in `references.bib` and that the claims match.
- The FCSM AI-Ready Data citation (`fcsm_2025_aiready`) — verify it exists in `references.bib` and that the characterization is accurate.

**Calibration questions for this run:**
- How does the pipeline perform on an **evaluation framework + landscape survey** vs. infrastructure guide (Ch 10) vs. theoretical framework (Ch 9)?
- Does the four-dimension evaluation framework (coupling, friction, transparency, volatility) actually give the reader enough to evaluate a tool, or is it too abstract? Can the reader apply it to a concrete tool after reading this chapter?
- The chapter names specific tools (Airflow, Prefect, n8n, LangChain, LlamaIndex, Zapier, Make, Haystack, CrewAI, AutoGen). Are these characterizations accurate and fair? Are any important categories missing?
- LangChain gets called out specifically as a "cautionary example" for coupling. Is this characterization current and accurate, or has LangChain addressed these issues in recent versions?
- The 90/10 rule — is this an established concept or the author's framing? If the latter, does it need the "author's experience" treatment?
- The recursive stochasticity section is described as "the full treatment" but was seeded in Ch 7. Does it deliver on the promise of a full treatment, or is it still surface-level?
- The MCP (Model Context Protocol) discussion in the observability section — is this adequately introduced for the audience, or does it assume familiarity?
- Zero figures. For a chapter with a comparison table and an evaluation framework, is this a gap? Could the framework be more useful as a visual?
- Does the chapter bridge to Ch 12 (security/supply chain) cleanly?
- The chapter has 4 reflection prompts and 1 thought experiment. Is the reflection density appropriate?
- Does the "What to Bet On vs. What to Wait On" section make claims about the future that are actually defensible, or is it speculative?
- How does the self-citation ratio compare to prior chapters? Three citations total, one self-citation (`webb_2026_pragmatics`), one federal source (`fcsm_2025_aiready`), one external empirical (`chen_2026_sweci`).

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows"
  chapter_pattern: "opening hook → core content → distributed reflection prompts → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 008)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Citations required for factual claims. Only 3 citations — check if landscape claims are unsourced. |
| Tier 2a: Stress Test | Practitioner persona | "Can I evaluate my current orchestration tools after reading this?" |
| Tier 2b: Depth Check | Full Bloom taxonomy | Does reader reach Evaluate (likely ceiling for this chapter type)? |
| Tier 3: Narrative | Full | Story arc, hook, tension, resolution |
| Tier 3: Clarity | Full | Jargon audit against stated audience — MCP, DAG, CLI terms |
| Tier 3: Visual gaps | Full | Diagrams, tables, figures |
| Tier 3: Motivation | Full | Keller ARCS — does reader know why they should care? |

**Carried gate from Run 006:** Methodology/framework chapters need a specific check: "Does the framework presentation include a scaffolded exercise where the reader applies it to their own context?" Directly applies here — the four-dimension framework IS the scaffolded exercise. Can the reader actually use it?

**Carried gate from Run 008:** Tutorial vs. pattern check. Less directly applicable (Ch 11 is not a tutorial chapter), but relevant for the Pragmatics observability example and any Seldon references.

**New gate for this run (dateability check):** For each specific tool, framework, or protocol named, ask: "If this tool disappears or fundamentally changes in 6 months, does the paragraph still make sense?" The chapter explicitly acknowledges this risk — does it actually solve it?

**New gate for this run (vocabulary bridging check):** Does the chapter help a reader who arrives from industry AI engineering (familiar with "agent contracts," "skills," "second-look pattern") connect their vocabulary to the book's? This is independent of the design note — it asks whether the chapter currently has a translation gap. The design note provides the solution; the audit should confirm the problem exists (or not).

---

## Instructions

Run the full AD-020 pipeline. All tiers, all gates, synthesis at the end.

### Prerequisites

1. Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set.
2. Verify `.claude/agents/auditor.md` and `.claude/agents/cascade-checker.md` exist (symlinked from Seldon).
3. Verify `audits/` directory exists.

### Step 1: Tier 1 — Correctness Audit (AD-019)

Use the auditor agent protocol on `book/chapter-11.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Spawn auditor teammate:

```
Spawn a teammate using the auditor agent type with the prompt:

"Audit book/chapter-11.md using the AD-019 content auditing standard.

Document type: book_chapter
Audience: Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows

Provide:
1. Terminology context from ontology (already loaded)
2. Citation context from references.bib (already loaded)

Write output to audits/chapter-11_content_audit.yaml

When finished, report your summary and shut down."
```

4. Collect output from `audits/chapter-11_content_audit.yaml`.
5. Extract any Perplexity verification queries to `audits/chapter-11_perplexity_queries.md`.

**Specific items for Tier 1 attention:**
- `chen_2026_sweci`: Verify in `references.bib`. Claims: "100 tasks, each spanning an average of 233 days and 71 consecutive commits," "75% of frontier models broke previously working features," EvoScore metric. These are specific empirical claims that need exact verification.
- `fcsm_2025_aiready`: Verify in `references.bib`. Claims: distinguishes "machine-readable" from "machine-understandable," recommends "structured experiments with metadata-enhanced APIs, including MCP as an integration protocol." Verify these characterizations are accurate.
- `webb_2026_pragmatics`: Self-citation. Verify claims about MCP tool design for observability match what's in the Pragmatics paper/system.
- LangChain "cautionary example" characterization: Is this fair and current? If the chapter names a specific product as a negative example, the characterization must be accurate.
- "The 90/10 rule, observed across multiple tool adoption cycles" — observed by whom? Is this a named concept from software engineering, or the author's framing?
- Tool names: Airflow, Prefect, n8n, LangChain, LlamaIndex, Zapier, Make, Haystack, CrewAI, AutoGen. Are all of these still active/relevant? Any significant orchestration tools missing from the landscape?
- MCP (Model Context Protocol) — is it adequately introduced for a reader who has not encountered it before?
- "The AI tool landscape has a half-life measured in months, not years" — is this a defensible claim or rhetoric?

### Step 2: Tier 2a — Practitioner Stress Test

Generate 10 questions a federal statistical agency practitioner would need answered after reading Ch 11. Then assess each against the chapter content.

Practitioner persona: "I'm a statistician at [BLS/Census/NCHS] who just read this chapter. I need to evaluate orchestration options for a survey processing pipeline I'm building. Can I do it with what this chapter gives me?"

Write output to `audits/chapter-11_practitioner_stress_test.yaml`.

### Step 3: Tier 2b — Bloom Depth Check

Assess the chapter's cognitive depth using Bloom's taxonomy.

For a landscape/evaluation framework chapter, the expected ceiling is **Evaluate** (the chapter provides the framework for the reader to make judgments). The thought experiment may push toward **Create** (designing a migration strategy). Check whether the chapter actually reaches Evaluate or stays at Understand/Apply.

Write output to `audits/chapter-11_bloom_depth_check.yaml`.

### Step 4: Tier 3 — Secondary Sweep (Blended)

Run all Tier 3 lenses plus the new gates:

1. **Narrative arc:** Hook → tension → resolution. Does "The Tool That Isn't There" pay off?
2. **Clarity/jargon:** MCP, DAG, CLI, API, RAG — count undefined technical terms.
3. **Visual gaps:** Zero figures, one table. For a comparison/evaluation chapter, is this adequate?
4. **Motivation (ARCS):** Does the reader understand why they should care about evaluation frameworks vs. just picking whatever tool works?
5. **Dateability check (NEW):** For each named tool/framework, would the paragraph survive if the tool disappeared?
6. **Vocabulary bridging check (NEW):** Does a reader arriving from industry AI engineering vocabulary find connection points, or do they have to abandon their existing mental models?
7. **Framework applicability check (CARRIED):** Can the reader actually apply the four-dimension framework to evaluate their own tools? Is there enough scaffolding?
8. **Tutorial vs. pattern check (CARRIED from Run 008):** For the Pragmatics example and any Seldon references — pattern or product-specific?

Write output to `audits/chapter-11_secondary_sweep.yaml`.

### Step 5: Synthesis

Cluster findings across all tiers:
1. Merge findings by theme/section from all audit files.
2. Identify overlap (same issue flagged by multiple lenses).
3. Count convergence (how many lenses flagged this cluster).
4. Order clusters by convergence (highest first).
5. Write actionable scope, not suggested edits.
6. Each cluster must be self-contained for serial processing.
7. Cap at ~8 clusters. Remaining items go in `unclustered`.

Write output to `audits/chapter-11_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-11.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-11_content_audit.yaml"
  
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

Read `cascading_audit_tasks` from `audits/chapter-11_content_audit.yaml`. Group by target chapter.

**Expected cascade targets:**
- **Ch 7 (backward):** Ch 11 references "config-driven architecture from Chapter 7" and "Chapter 7's config-driven architecture." Verify Ch 7 establishes this pattern as described.
- **Ch 7 (backward):** "Chapter 7 introduced the problem" (recursive stochasticity). Verify Ch 7 seeds this concept.
- **Ch 8 (backward):** "Chapter 8 (evaluation by design)" — verify Ch 8 delivers evaluation by design as described.
- **Ch 9 (backward):** "Chapter 9's stochastic tax" — verify Ch 9 introduces and defines the stochastic tax concept.
- **Ch 10 (backward):** "Chapter 10's provenance requirements apply to the orchestration layer itself." Verify Ch 10's eight requirements are framed as applicable beyond the data pipeline.
- **Ch 10 (backward):** "Chapter 10's state serialization (handoff documents)" — verify Ch 10 covers handoff documents as state serialization.
- **Ch 10 (backward):** "Chapter 10's configuration control" — verify Ch 10 covers specification-before-execution.
- **Ch 10 (backward):** "The system from Chapter 10 is an example" (custom orchestration category). Verify this characterization is accurate.
- **Ch 13 (forward):** "Chapter 13 addresses the institutional dimension of this gap." Verify Ch 13 covers institutional deployment constraints.
- **Ch 12 (forward):** Bridge paragraph references security, supply chain, model provenance. Verify Ch 12 picks up these threads.

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-11.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results to `audits/chapter-11_cascade_results.yaml`.

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, verdict
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts, top gaps
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment

**Calibration comparison:** Explicitly compare Run 009 results to all prior runs (002–008). Note:
- **Evaluation framework + landscape survey chapter type vs. prior types:** Does the "dateability check" gate produce useful signal? How does a landscape chapter's Bloom distribution compare to infrastructure (Ch 10), theoretical (Ch 9), methodology (Ch 8)?
- **Self-citation profile:** 1 self-citation out of 3 total (~33%). Compare to Ch 10's profile, Ch 9's 100% self-citation, Ch 8's 77% external.
- **Citation sparsity:** 3 citations for a landscape survey chapter. Is this the sparsest chapter yet? Does the pipeline flag this as a gap or accept it as intentional (the chapter avoids tool-specific citations by design)?
- **Visual gap persistence (8th data point):** Zero figures, one table. Confirm or deny the visual gap pattern. Update the running table.
- **Reflection prompt density:** 4 reflection prompts + 1 thought experiment. Count and compare to prior chapters.
- **Practitioner answerability for evaluation framework chapters:** Does a framework chapter score higher or lower on answerability than an infrastructure chapter (Ch 10) or theoretical chapter (Ch 9)?
- **Named tool accuracy:** How many of the 10 named tools does the pipeline flag for verification? Is this a new category of audit finding?
- **Vocabulary bridging gap:** Does the pipeline independently identify a vocabulary translation problem, confirming the design note's diagnosis?
- **Recursive stochasticity "full treatment" delivery:** Does the pipeline assess whether the section actually delivers on the "full treatment" promise, or does it flag it as still incomplete?

Write calibration notes to `seldon/docs/design/AD-020_calibration_009_ch11.md`.

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-11_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-11_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-11_practitioner_stress_test.yaml` | Tier 2a: stress test |
| `audits/chapter-11_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-11_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-11_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-11_cascade_results.yaml` | Cascade checker results |
| `seldon/docs/design/AD-020_calibration_009_ch11.md` | Calibration data |

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph
- Skip the synthesis step
- Skip the calibration data capture
- Skip the calibration comparison to Runs 002–008
- Accept "the chapter intentionally avoids tool recommendations" as an excuse for unsourced factual claims about specific tools
- Conflate the design note's planned vocabulary table insertion with current audit findings — assess the chapter as it exists now
- Skip the dateability check — this is the chapter's own stated risk ("this chapter ages fastest")
