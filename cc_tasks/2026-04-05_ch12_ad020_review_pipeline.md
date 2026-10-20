# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 12

**Date:** 2026-04-05
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 010 (ninth `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6, Run 005 = Ch 7, Run 006 = Ch 8, Run 007 = Ch 9, Run 008 = Ch 10, Run 009 = Ch 11)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-12.md` — Security, Supply Chain, and Model Provenance

---

## Context

This is the tenth AD-020 calibration run and the ninth on `document_type: book_chapter`. Ch 12 is a **governance and security framework** chapter — it teaches the reader how to think about security controls for AI workflows using the Five Safes framework as the organizing principle. This is a new chapter type for the pipeline.

Ch 12 is ~2,855 words — the shortest chapter audited so far. It has 4 citations: `desai_2016` (Five Safes framework), `nist_ai_rmf_2023`, `nist_genai_2024`, and `webb_2026_crosswalk` (self-citation). The chapter has a dual audience declared in its HTML comments: "Practitioners building AI workflows AND security/IT professionals supporting them."

The chapter covers: the "offline isn't offline" hook (tokenizer network call), the Five Safes framework introduction, then one section per safe (projects, people, settings, data, outputs), model provenance and supply chain, framework alignment (NIST AI RMF crosswalk), thought experiment, and bridge to Ch 13 (institutional deployment).

Each safe section follows a consistent pattern: prose explanation → questions table → sometimes a reflection prompt. This is a notably different structure from prior chapters: the tables are the primary content delivery mechanism, not supporting material.

**Chapter type considerations:**
This is the first governance/security chapter in the pipeline. Key tensions:
1. Being concrete enough to be actionable without prescribing specific tools or vendor solutions
2. Speaking to two audiences simultaneously (practitioners AND security/IT staff) without condescending to either
3. Using the Five Safes framework as an organizing principle — does it earn its place, or is it forced?
4. Balancing "enabling, not prohibitive" framing with actual security substance

**Known items from handoff and graph:**
- The **security appendix decision gate** (`1826188c`) is explicitly blocked on Ch 12 AD-020. Five agentic AI security sources have been reviewed (`docs/security_sources/review_summary.md`): OWASP ASI taxonomy, NCCoE agent identity concept paper, NIST CAISI RFI, NIST Cyber AI Profile, NIST Agent Standards Initiative. The decision: does this material integrate into Ch 12 or become a standalone appendix? The audit should assess whether Ch 12 currently has an agentic security gap.
- Ch 3 cascade task (`54438acf`, completed): verify Title 13 and CIPSEA data protection citations are consistent between Ch 3 and Ch 12. This should be verified in cascade checking.
- Ch 11 bridge to Ch 12 confirmed in Run 009 cascade check CA6: "Models have provenance... Frameworks have dependencies... APIs have attack surfaces." Ch 12 covers all three.
- The chapter uses `webb_2026_crosswalk` as a self-citation for the FCSM/NIST crosswalk mapping. Verify this reference exists in `references.bib` and that the characterization is accurate.

**Calibration questions for this run:**
- How does the pipeline perform on a **governance/security framework** chapter vs. evaluation framework (Ch 11) vs. infrastructure guide (Ch 10)?
- Does the Five Safes framework earn its place as the organizing principle, or could the chapter work without it? Is it genuinely useful for the audience, or is it an imposed structure?
- The chapter has a **dual audience** (practitioners AND security/IT). Does it actually serve both, or does it talk to one while ignoring the other?
- The questions tables are the primary content delivery mechanism. Are they actionable? Could a practitioner use them as a checklist? Could a security professional use them to assess a workflow?
- Is the chapter too short at ~2,855 words? Does it cover the security surface adequately, or is there a major gap?
- **Agentic security gap:** The chapter discusses AI workflows as pipelines but does not appear to address agentic systems (autonomous tool use, MCP, runtime decision-making). Ch 11 introduced agentic systems and tool design for observability. Does Ch 12's security framing account for agents, or does it assume the "pipeline" model only? This is the key question for the security appendix decision gate.
- Citation density: 4 citations, 1 self-citation. For a governance chapter, is this adequate? The Five Safes framework needs proper attribution. Do the NIST citations cover the relevant landscape?
- The "offline isn't offline" hook — is this a real scenario? Does the chapter deliver on the security promise the hook sets up?
- Does the chapter address the **supply chain security** dimension adequately? Model provenance, dependency trees, unsigned binaries — are these practical enough for the audience?
- Zero figures, 6 tables (the questions tables). Does the table-heavy structure work for a security chapter, or does it need different visual treatment?
- Does the bridge to Ch 13 (institutional deployment) work? Ch 12 says "Security tells you what to do. Institutional deployment tells you what happens when you try to do it." Is that a clean handoff?
- Does the chapter connect back to the book's tenets and principles? "Security is a system property" (Working Principle) and "Trust defines the mission" (Tenet) are declared in HTML comments but may or may not surface in the text.

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows — AND security/IT professionals supporting them"
  chapter_pattern: "opening hook → framework introduction → five sections (one per safe) with question tables → supply chain → framework alignment → thought experiment → chapter bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 009)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Five Safes attribution, NIST citations, legal/regulatory claims need verification. |
| Tier 2a: Stress Test | **Dual persona** | Both (A) "Can I secure my AI pipeline with this?" and (B) "Can I assess a researcher's AI workflow with this?" |
| Tier 2b: Depth Check | Full Bloom taxonomy | Expected ceiling: Apply (can the reader apply the framework to their situation?). |
| Tier 3: Narrative | Full | Story arc, hook, tension, resolution |
| Tier 3: Clarity | Full | Jargon audit — security terms vs. statistical terms |
| Tier 3: Visual gaps | Full | 0 figures, 6 tables |
| Tier 3: Motivation | Full | Keller ARCS — "enabling not prohibitive" framing: does it work? |

**Carried gate from Run 006:** Framework applicability check: "Does the framework presentation include a scaffolded exercise where the reader applies it to their own context?" The Five Safes questions tables ARE the scaffolded exercise. Can the reader actually use them?

**Carried gate from Run 008:** Tutorial vs. pattern check. Less directly applicable, but relevant if any section is too specific to one agency's process rather than teaching transferable security principles.

**Carried gate from Run 009:** Dateability check. Security landscape changes. Do any specific claims about services, tools, or regulatory requirements risk dating the chapter?

**New gate for this run (dual audience check):** For each section, ask: "Does this paragraph serve the practitioner, the security professional, or both?" A governance chapter with a declared dual audience needs to actually address both. Sections that speak only to practitioners while ignoring the security professional (or vice versa) are a gap.

**New gate for this run (agentic security gap check):** Does the chapter's security framing account for agentic systems (autonomous tool use, runtime decision-making, MCP)? Or does it assume all AI workflows are predefined pipelines? This directly feeds the security appendix decision gate in the graph.

**New gate for this run (regulatory accuracy check):** The chapter makes claims about FedRAMP, data jurisdiction, NIST frameworks, Title 13/CIPSEA, and data classification levels. These are legal/regulatory assertions that need accuracy verification.

---

## Instructions

Run the full AD-020 pipeline. All tiers, all gates, synthesis at the end.

### Prerequisites

1. Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is set.
2. Verify `.claude/agents/auditor.md` and `.claude/agents/cascade-checker.md` exist (symlinked from Seldon).
3. Verify `audits/` directory exists.

### Step 1: Tier 1 — Correctness Audit (AD-019)

Use the auditor agent protocol on `book/chapter-12.md`:

1. Run `set -a; source .env; set +a; seldon ontology list --verbose` for terminology context.
2. Read `book/references.bib` for citation context.
3. Spawn auditor teammate:

```
Spawn a teammate using the auditor agent type with the prompt:

"Audit book/chapter-12.md using the AD-019 content auditing standard.

Document type: book_chapter
Audience: Data scientists, statisticians, and researchers in federal statistical agencies who are building AI workflows — AND security/IT professionals supporting them

Provide:
1. Terminology context from ontology (already loaded)
2. Citation context from references.bib (already loaded)

Write output to audits/chapter-12_content_audit.yaml

When finished, report your summary and shut down."
```

4. Collect output from `audits/chapter-12_content_audit.yaml`.
5. Extract any Perplexity verification queries to `audits/chapter-12_perplexity_queries.md`.

**Specific items for Tier 1 attention:**
- `desai_2016`: Five Safes framework attribution. Verify in `references.bib`. Verify the adoption claims: "UK Office for National Statistics... Australian Bureau of Statistics, Statistics New Zealand, Eurostat... UK Digital Economy Act and Australia's Data Availability and Transparency Act." These are specific institutional and legal claims.
- `nist_ai_rmf_2023` and `nist_genai_2024`: Verify in `references.bib`. Verify the characterization of MAP and MANAGE functions.
- `webb_2026_crosswalk`: Self-citation. Verify the claim that this paper "has the detailed mapping between NIST AI RMF and FCSM statistical quality standards."
- "Offline isn't offline" scenario: Is this a documented real-world pattern (tokenizer fetching from remote repo on first load)? Is it accurate for common frameworks (HuggingFace Transformers, etc.)?
- FedRAMP references: The chapter mentions "FedRAMP authorized at the appropriate level." Is this characterization accurate for AI services?
- Title 13 / CIPSEA: Not explicitly cited but implied in the data protection context. Verify consistency with Ch 3's treatment (cascade task `54438acf`).
- "LLMs can memorize and reproduce fragments of their training data. This is a known property, not a theoretical risk." — Citation needed? This is a factual claim about model behavior.
- "Consumer-tier AI services typically reserve the right to use inputs for model improvement. Enterprise and government tiers typically do not." — Is this accurate as a general characterization?
- Model provenance section: Are checksums and cryptographic signatures standard practice for model artifacts? Is this characterization accurate?

### Step 2: Tier 2a — Practitioner Stress Test

Generate 10 questions — **split between two personas:**

**Persona A (5 questions): Federal statistician/data scientist.** "I'm building an AI survey processing pipeline at Census/BLS/NCHS. After reading this chapter, can I determine what security controls I need?"

**Persona B (5 questions): Security/IT professional.** "A researcher on my team wants to deploy an AI workflow. After reading this chapter, can I assess whether it meets our security requirements?"

Assess each against the chapter content.

Write output to `audits/chapter-12_practitioner_stress_test.yaml`.

### Step 3: Tier 2b — Bloom Depth Check

Assess the chapter's cognitive depth using Bloom's taxonomy.

For a governance/security framework chapter, the expected ceiling is **Apply** (the reader can apply the Five Safes framework to their own situation using the questions tables). The thought experiment may push toward Evaluate. Check whether the chapter reaches Apply or stays at Understand.

Write output to `audits/chapter-12_bloom_depth_check.yaml`.

### Step 4: Tier 3 — Secondary Sweep (Blended)

Run all Tier 3 lenses plus the new gates:

1. **Narrative arc:** Hook → tension → resolution. Does "offline isn't offline" pay off throughout the chapter, or is it a one-shot anecdote?
2. **Clarity/jargon:** Security terminology (FedRAMP, DLP, SDC, ATO) vs. statistical terminology. Is the chapter accessible to both audiences?
3. **Visual gaps:** 0 figures, 6 tables. For a security/governance chapter with a framework, is this adequate? Could the Five Safes be visualized?
4. **Motivation (ARCS):** Does "enabling, not prohibitive" framing actually work, or does the chapter read as a list of restrictions despite the framing?
5. **Dual audience check (NEW):** For each section, which audience does it serve? Are there sections that leave one audience behind?
6. **Agentic security gap check (NEW):** Does the chapter account for autonomous tool use, MCP, runtime decision-making? Or does it assume predefined pipelines only? This is the critical input for the security appendix decision gate.
7. **Dateability check (CARRIED from Run 009):** Do any regulatory or service-specific claims risk dating?
8. **Framework applicability check (CARRIED):** Can the reader actually use the Five Safes questions tables as a working checklist?
9. **Regulatory accuracy check (NEW):** Are legal/regulatory assertions (FedRAMP, jurisdiction, data classification) accurate?

Write output to `audits/chapter-12_secondary_sweep.yaml`.

### Step 5: Synthesis

Cluster findings across all tiers:
1. Merge findings by theme/section from all audit files.
2. Identify overlap (same issue flagged by multiple lenses).
3. Count convergence (how many lenses flagged this cluster).
4. Order clusters by convergence (highest first).
5. Write actionable scope, not suggested edits.
6. Each cluster must be self-contained for serial processing.
7. Cap at ~8 clusters. Remaining items go in `unclustered`.

Write output to `audits/chapter-12_review_synthesis.yaml`:

```yaml
review_synthesis:
  file: "book/chapter-12.md"
  date: "[ISO date]"
  document_type: "book_chapter"
  tier_1_reference: "audits/chapter-12_content_audit.yaml"
  
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

Read `cascading_audit_tasks` from `audits/chapter-12_content_audit.yaml`. Group by target chapter.

**Expected cascade targets:**
- **Ch 3 (backward):** Title 13 / CIPSEA data protection consistency (cascade task `54438acf` previously completed — verify whether Ch 12 now references these consistently).
- **Ch 8 (backward):** "Evaluation by design" — Ch 12 says outputs need scrutiny. Does Ch 8's evaluation framework apply to security-relevant outputs?
- **Ch 9 (backward):** "Stochastic liability" concept referenced in Safe People questions table. Verify Ch 9 defines or uses this term.
- **Ch 10 (backward):** Provenance requirements — Ch 12's supply chain section overlaps with Ch 10's provenance requirements. Are they consistent?
- **Ch 11 (backward):** Ch 11 bridges to Ch 12. Verify the bridge promises match what Ch 12 delivers: "Models have provenance... Frameworks have dependencies... APIs have attack surfaces."
- **Ch 13 (forward):** Ch 12 bridges to Ch 13. Verify Ch 13 picks up the institutional deployment thread.
- **Ch 1 (backward):** "Stochastic tax" referenced in Safe Projects table. Verify correct attribution (Ch 1 is the origin — lesson learned from Ch 11 Run 009).

For each unique target chapter, spawn a cascade-checker teammate:

```
Spawn a teammate using the cascade-checker agent type with the prompt:

"Check book/chapter-NN.md for these cross-section impacts from book/chapter-12.md:

1. [audit_type]: [reason]
   Triggered by: [triggered_by]
   Priority: [priority]

Read the target file. Produce cascade_check YAML. Report and shut down."
```

Cap at 5 concurrent teammates. Batch multiple findings for the same target chapter.

Collect results to `audits/chapter-12_cascade_results.yaml`.

### Step 7: Summary and Cleanup

Print to terminal:
1. Synthesis summary: number of clusters, top 3 by convergence, verdict
2. Bloom summary: chapter ceiling, scaffolding verdict
3. Practitioner summary: answerable/partial/not counts FOR BOTH PERSONAS
4. Cascade summary: confirmed/clear/needs_full_audit counts
5. Calibration notes: what worked, what didn't, what needs adjustment
6. **Security appendix decision gate input:** Explicitly answer: "Does Ch 12 account for agentic security, or is there a gap that the reviewed security sources would fill?"

**Calibration comparison:** Explicitly compare Run 010 results to all prior runs (002–009). Note:
- **Governance/security chapter type vs. prior types:** How does a governance chapter's Bloom distribution compare to framework (Ch 11), infrastructure (Ch 10), theoretical (Ch 9)?
- **Dual audience performance:** Does the dual-persona stress test produce different results from single-persona runs? Is this a useful gate for other chapters?
- **Self-citation profile:** 1 self-citation out of 4 total (25%). Compare to prior chapters.
- **Citation density for governance chapters:** 4 citations for a security/governance chapter. Is this adequate given the regulatory claims?
- **Table-heavy structure:** 6 tables, 0 figures. Is the table-as-checklist pattern a new content delivery mechanism the pipeline should recognize?
- **Visual gap persistence (9th data point):** 0 figures. Update the running table.
- **Reflection prompt density:** Count and compare to prior chapters.
- **Chapter length:** ~2,855 words — shortest chapter in the audit series. Is brevity a virtue for a security chapter or a coverage gap?
- **Agentic security gap signal strength:** How clearly does the pipeline flag the absence of agentic security content? Is this a strong or weak signal?

Write calibration notes to `seldon/docs/design/AD-020_calibration_010_ch12.md`.

Clean up the team.

---

## Output Files

| File | Content |
|------|---------|
| `audits/chapter-12_content_audit.yaml` | Tier 1: AD-019 correctness audit |
| `audits/chapter-12_perplexity_queries.md` | Tier 1: verification queries |
| `audits/chapter-12_practitioner_stress_test.yaml` | Tier 2a: stress test (dual persona) |
| `audits/chapter-12_bloom_depth_check.yaml` | Tier 2b: cognitive depth |
| `audits/chapter-12_secondary_sweep.yaml` | Tier 3: blended lens sweep |
| `audits/chapter-12_review_synthesis.yaml` | Synthesis: clustered findings |
| `audits/chapter-12_cascade_results.yaml` | Cascade checker results |
| `seldon/docs/design/AD-020_calibration_010_ch12.md` | Calibration data |

---

## Do NOT

- Edit any chapter files — this is audit-only
- Run cascade checkers on chapters not in the `cascading_audit_tasks` list
- Let cascade checkers expand scope beyond their assigned finding
- Create Issue artifacts in the graph
- Skip the synthesis step
- Skip the calibration data capture
- Skip the calibration comparison to Runs 002–009
- Make the security appendix decision — only provide the input data for the decision gate
- Assume "enabling not prohibitive" framing means the chapter lacks substance — assess substance independently of framing
- Skip the dual audience check — this is the chapter's declared design intent
- Skip the agentic security gap check — this directly feeds a graph decision gate
