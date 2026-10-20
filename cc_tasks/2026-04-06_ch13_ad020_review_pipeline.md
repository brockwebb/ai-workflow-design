# CC Task: AD-020 Multi-Lens Review Pipeline — Chapter 13

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 011 (tenth `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6, Run 005 = Ch 7, Run 006 = Ch 8, Run 007 = Ch 9, Run 008 = Ch 10, Run 009 = Ch 11, Run 010 = Ch 12)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-13.md` — Deploying in Institutional Environments

---

## Context

This is the eleventh AD-020 calibration run and the tenth on `document_type: book_chapter`. Ch 13 is an **institutional deployment / organizational change** chapter — it diagnoses why AI workflows fail to reach production in government environments and prescribes practical paths forward. This is a new chapter type for the pipeline: neither technical nor framework-based, but organizational and strategic.

Ch 13 is ~2,574 words — the shortest chapter audited in the series. It has **zero citations**. This is a significant data point: the chapter makes numerous claims about procurement timelines, governance structures, incentive dynamics, and organizational behavior patterns without any external references. The citation sparsity gate should fire hard on this chapter.

The chapter's declared diagnostic lens is the book's compressed tenets and working principles, stress-tested against institutional reality. Each section explicitly maps to specific tenets and principles. This tenet/principle threading is the densest and most explicit in the book.

The chapter covers: the "last mile is organizational" hook (\$47/6 hours vs. 3 FTEs/4 weeks), authorization and procurement gaps (FedRAMP, ATO, procurement cycles), cloud parity gaps (GovCloud lag), governance failure modes (governance-as-gate vs. governance-as-infrastructure, incentive misalignment), building organizational capability (distributed vs. centralized AI teams), earning trust incrementally (pilot-first pattern), culture shift (planned releases vs. continuous delivery, transience as design principle), thought experiment (tiered governance design), and bridge to Ch 14 (economics).

Cross-references: Ch 1 (stochastic nature, model replaceability, Level 3), Ch 8 (evaluation harness), Ch 9-10 (evidence chains), Ch 12 (security model, Five Safes, safe projects), foreword (Feynman frame). No cross-references to Ch 2-7, Ch 11, or Ch 14.

**Chapter type considerations:**
This is the first organizational/institutional chapter. Key tensions:
1. Making claims about institutional behavior without citations -- are these experience-based assertions or verifiable claims?
2. Balancing empathy for institutional constraints with advocacy for change -- does the chapter acknowledge real reasons for governance overhead without excusing dysfunction?
3. The tenet/principle diagnostic lens -- does it earn its place as an analytical tool, or is it mechanical (tenet → friction → recommendation)?
4. Audience: the chapter declares "practitioners navigating institutions, IT/governance teams, program managers" -- three audiences. Does it serve all three?
5. No specific agencies, companies, or individuals should be named as friction examples -- verify this constraint holds.
6. This chapter makes the strongest claims in the book about organizational dysfunction. Are they grounded or do they risk coming across as complaint?

**Known items from handoff and graph:**
- Ch 12 bridge to Ch 13 confirmed in Run 010 cascade check: "Security tells you what to do. Institutional deployment tells you what happens when you try to do it."
- No open graph tasks targeting Ch 13.
- The \$47/6-hour cost claim in the hook needs to be checked: is this a round number or a specific claim? If specific, it needs a source or context. If illustrative, it should read as illustrative.
- "Level 3 being earned, not assumed (Chapter 1)" -- verify this concept exists in Ch 1 as described.
- The chapter references "organizations that have moved to enterprise ATO models" and "organizations that have implemented dual metrics" -- these are empirical claims. Are they defensible without citation?

**Calibration questions for this run:**
- How does the pipeline perform on an **organizational/institutional** chapter vs. governance/security (Ch 12) vs. evaluation framework (Ch 11)?
- **Zero citations.** Is this a gap or a deliberate choice? The chapter is experiential/strategic, not empirical. But claims about procurement timelines (6-18 months), ATO processes, FedRAMP timing, and organizational behavior patterns are verifiable. Should some be cited?
- **Tenet/principle threading intensity.** Ch 13 has the highest density of explicit tenet/principle references in the book. Does the diagnostic lens framework add analytical value, or does it feel forced?
- The **governance-as-gate vs. governance-as-infrastructure** framing is the chapter's strongest conceptual contribution. Does it land? Is it original or does it restate known organizational theory?
- The **incentive problem** section names institutional power dynamics explicitly. Is this tone appropriate for the audience? Federal practitioners may find it validating. IT/governance audiences may find it adversarial.
- The **transience as a design principle** concept near the end is philosophically ambitious. Does it earn its place, or is it a bridge too far for a practical deployment chapter?
- Is the bridge to Ch 14 (economics) clean? Does the reader know why economics is next?
- Does the chapter avoid naming specific agencies, companies, or individuals as friction examples? (Constraint from book editorial policy.)
- The thought experiment asks the reader to design a tiered governance model. Is it well-constructed? Does it give enough parameters to be productive?

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Practitioners navigating institutions, IT/governance teams, program managers"
  chapter_pattern: "opening hook → diagnostic lens introduction → procurement gap → cloud gap → governance (longest section) → capability building → trust earning → culture shift → thought experiment → bridge"
```

### Gate Calibration for `book_chapter` (carried from Run 010)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Zero citations — every factual claim about timelines, processes, and organizational patterns needs evaluation. FedRAMP, ATO, and procurement characterizations need accuracy check. |
| Tier 2a: Stress Test | **Triple persona** | (A) "Can I navigate my institution with this?" (practitioner), (B) "Is this a fair characterization of my processes?" (IT/governance), (C) "Can I use this to build a business case?" (program manager) |
| Tier 2b: Depth Check | Full Bloom taxonomy | Expected ceiling: Evaluate (thought experiment asks reader to design a governance model). |
| Tier 3: Narrative | Full | Story arc, hook, tension, resolution. The hook is a cost/time differential — does it pay off? |
| Tier 3: Clarity | Full | Jargon audit — FedRAMP, ATO, GovCloud are government terms. Does the chapter explain enough for a broader audience? |
| Tier 3: Visual gaps | Full | 0 figures, 0 tables. This is the starkest visual gap in the series. |
| Tier 3: Motivation | Full | Keller ARCS — does the chapter motivate action or resignation? The risk is that naming institutional obstacles comprehensively produces learned helplessness. |

**Carried gate from Run 006:** Framework applicability check: Does the tenet/principle diagnostic lens give the reader a transferable analytical tool, or is it chapter-specific decoration?

**Carried gate from Run 008:** Tutorial vs. pattern check. Does the chapter teach transferable institutional navigation patterns, or is it specific to one type of government organization?

**Carried gate from Run 009:** Dateability check. FedRAMP processes, procurement thresholds, cloud parity gaps — do any specific claims about these processes risk dating the chapter?

**Carried gate from Run 010:** Dual audience check → extended to **triple audience** for this chapter. Practitioner / IT-governance / program manager perspectives.

**New gate for this run (citation sparsity check):** Zero citations in a chapter making claims about procurement timelines, governance effectiveness, organizational behavior, and institutional change patterns. Identify which claims are experiential wisdom (acceptable without citation), which are verifiable assertions (need citation or hedging), and which are empirical claims about measured outcomes (need citation or removal).

**New gate for this run (tenet diagnostic value check):** The chapter explicitly maps every section to compressed tenets and working principles. Does this mapping add analytical clarity (the reader sees institutional friction through a new lens) or is it mechanical (tenet label → friction description → recommendation, where the tenet label adds nothing)? Compare to chapters that reference tenets/principles lightly vs. this chapter's intensive threading.

**New gate for this run (adversarial tone check):** The governance section discusses power dynamics, incentive misalignment, and institutional dysfunction. Assess whether the tone is diagnostic (naming the problem to solve it) or adversarial (blaming governance/IT teams). The chapter's audience includes IT/governance professionals — would they feel described or attacked?

**New gate for this run (learned helplessness check):** The chapter catalogs numerous institutional obstacles. Does it leave the reader with actionable next steps and genuine optimism, or does the comprehensive obstacle list produce a sense that change is impossible? The "earning trust incrementally" section is presumably the antidote — does it work?

---

## Execution Instructions

Run the full AD-020 pipeline:

### Tier 1: Content Audit
Use `.claude/agents/auditor.md` agent. Run the auditor on `book/chapter-13.md` with `document_type: book_chapter`.
- Output: `audits/chapter-13_content_audit.yaml`
- Generate Perplexity verification queries for every factual claim about:
  - FedRAMP authorization timelines
  - ATO process characteristics
  - Government procurement cycle durations
  - Enterprise ATO model outcomes ("authorization timelines dropping from months to weeks")
  - Dual metrics governance outcomes ("measurably faster authorization timelines without increased incident rates")
  - GovCloud availability lag vs. commercial regions
  - Any other specific verifiable assertion
- Output: `audits/chapter-13_perplexity_queries.md`

### Tier 2a: Practitioner Stress Test (Triple Persona)
Run three passes:
- **Persona A (Practitioner):** "I'm a data scientist at a federal statistical agency trying to get my AI workflow into production. Does this chapter give me actionable guidance?"
- **Persona B (IT/Governance):** "I'm an IT security manager or governance lead at a federal agency. Does this chapter fairly characterize my processes and give me something useful, or does it blame me for institutional friction?"
- **Persona C (Program Manager):** "I'm a program manager trying to build a business case for AI adoption. Does this chapter give me the framework and vocabulary to advocate for change?"
- Output: `audits/chapter-13_practitioner_stress_test.yaml` with separate scores per persona

### Tier 2b: Bloom Depth Check
- Output: `audits/chapter-13_bloom_depth_check.yaml`

### Tier 3: Secondary Sweep
Includes: narrative arc, clarity, visual gaps, motivation (ARCS), plus all new and carried gates (citation sparsity, tenet diagnostic value, adversarial tone, learned helplessness, dateability, framework applicability).
- Output: `audits/chapter-13_secondary_sweep.yaml`

### Synthesis
Combine all tiers into findings clusters with convergence scores.
- Output: `audits/chapter-13_review_synthesis.yaml`

### Cascade Checking
Use `.claude/agents/cascade-checker.md` agent.

**Cross-references to verify (forward and backward):**

| ID | Source | Target | Claim to verify |
|----|--------|--------|----------------|
| CA1 | Ch 13 hook | Ch 12 | "The security model exists (Chapter 12)" — does Ch 12 deliver a complete security model? |
| CA2 | Ch 13 procurement | Ch 8 | "Chapter 8's evaluation harness" — does Ch 8 describe an evaluation harness that enables model-agnostic architecture? |
| CA3 | Ch 13 procurement | Ch 1 | "Chapter 1's principle of model replaceability" — does Ch 1 state this principle? |
| CA4 | Ch 13 cloud gap | Ch 12 | "Chapter 12 identified as safe projects" — does Ch 12's Safe Projects section define "safe projects" in a way Ch 13 correctly references? |
| CA5 | Ch 13 governance | Ch 12 | "Five Safes (Chapter 12)" — is the Five Safes reference in the tiered review section accurate? |
| CA6 | Ch 13 capability | Ch 1 | "stochastic nature of the tools (Chapter 1)" — does Ch 1 introduce stochastic nature as a concept? |
| CA7 | Ch 13 capability | Ch 8 | "designing evaluation frameworks (Chapter 8)" — does Ch 8 teach evaluation framework design? |
| CA8 | Ch 13 capability | Ch 9-10 | "building evidence chains (Chapters 9-10)" — do Ch 9-10 cover evidence chains? |
| CA9 | Ch 13 capability | foreword | "the foreword's Feynman frame" — does the foreword establish a Feynman frame? |
| CA10 | Ch 13 trust | Ch 1 | "Level 3 being earned, not assumed (Chapter 1)" — does Ch 1 define Level 3 and frame it as earned? |
| CA11 | Ch 13 bridge | Ch 14 | "The next chapter addresses the final operational concern: making the economic case and managing the budget." — does Ch 14 cover economics/budget? |
| CA12 | Ch 12 bridge | Ch 13 | Verify Ch 12's bridge sentence ("Security tells you what to do. Institutional deployment tells you what happens when you try to do it.") lands accurately in Ch 13. |

- Output: `audits/chapter-13_cascade_results.yaml`

### Calibration Record
Write calibration observations to: `seldon/docs/design/AD-020_calibration_011_ch13.md`

Include:
1. Gate effectiveness by tier (which gates fired, which found nothing)
2. Standout findings vs. prior runs
3. Triple persona comparison table (Fully/Partial/Not per persona)
4. Bloom comparison table (carry forward from Run 010, add Ch 13 row)
5. Citation profile comparison (carry forward, add Ch 13 row — zero citations is the notable data point)
6. Visual gap comparison (carry forward, add Ch 13 row — 0/0 figures/tables)
7. What worked / what to adjust for Run 012
8. Comparison to immediately prior runs (Ch 11, Ch 12, Ch 13 side by side)

---

## Verification

After all outputs are produced:
1. All seven audit files exist in `audits/`
2. Calibration record exists at `seldon/docs/design/AD-020_calibration_011_ch13.md`
3. Perplexity queries file identifies every verifiable factual claim
4. Triple persona scores are separate and comparable
5. Cascade results cover all 12 cross-reference checks
6. Run `seldon verify --fix` after all outputs are written

## Do NOT

- Edit `book/chapter-13.md` — this is an audit-only task
- Edit any other chapter file
- Edit `book/references.bib`
- Make revision recommendations in the audit outputs — the audit identifies issues; revision is a separate CC task
- Skip the triple persona test — this chapter's audience breadth is a key calibration question
- Assume zero citations is acceptable without evaluating which claims need citation
- Skip the adversarial tone check — the governance section's characterization of institutional dynamics is the highest-risk content in the chapter
