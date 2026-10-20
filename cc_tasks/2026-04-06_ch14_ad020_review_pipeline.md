# CC Task: AD-020 Multi-Lens Review Pipeline -- Chapter 14

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 012 (eleventh `book_chapter` type; Run 001 = leibniz-pi `academic_paper`, Run 002 = Ch 4, Run 003 = Ch 5, Run 004 = Ch 6, Run 005 = Ch 7, Run 006 = Ch 8, Run 007 = Ch 9, Run 008 = Ch 10, Run 009 = Ch 11, Run 010 = Ch 12, Run 011 = Ch 13)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/chapter-14.md` -- Cost & Practicality

---

## Context

This is the twelfth AD-020 calibration run and the eleventh on `document_type: book_chapter`. Ch 14 is an **economics/cost justification** chapter -- the "spreadsheet chapter." It teaches federal practitioners how to frame AI pipeline costs as comparisons against status quo alternatives, how to think about cost categories, and how to make the economic case to program offices. It is the last numbered chapter and the book's capstone.

Ch 14 is approximately 2,800 words. It has **zero citations** -- no `{cite:t}` or `{cite:p}` markup anywhere. This is the second consecutive chapter entering the pipeline with zero citations (Ch 13 had the same pattern). Unlike Ch 13, whose claims were about institutional behavior and procurement timelines, Ch 14's claims are primarily grounded in a single worked example (the Federal Survey Concept Mapper) where the author has first-person knowledge of the actual costs. The citation sparsity question here is different: are there external claims beyond the Concept Mapper numbers that need grounding?

The chapter is structured as a sustained economic argument with one detailed worked example. It is the canonical and only home for the "\$15 vs \$23,200" Concept Mapper cost comparison. This has been resolved multiple times -- this framing belongs in Ch 14 only.

The chapter covers: the "\$15" hook (cost conversation vs. value conversation), counterfactual framing (compared to what?), the Concept Mapper worked example (full cost comparison table), cost taxonomy (inference / development / operational / opportunity), batch economics (why statistical workflows are cost-advantaged), when cheap models win (evaluation-driven model selection), making the case (FTE-equivalent framing, cost justification template), the cost of not doing it (opportunity cost), thought experiment (\$50K portfolio design), and the closing bridge (reconnects to Ch 1's thesis).

Cross-references: Ch 5 (ensemble patterns), Ch 6 (throughput constraint ladder), Ch 7 (checkpoint design), Ch 8 (evaluation harness/framework), Ch 13 (procurement cycles, governance review). No cross-references to Ch 1-4, Ch 9-12, or Ch 14's own internal sections.

**Chapter type considerations:**

1. **Single worked example dependency.** The entire chapter rests on the Concept Mapper as proof-of-concept. The numbers are real (author's project), but the generalizability question looms: does one \$15 pipeline make the economic case for AI in official statistics, or does it make the case for one specific batch classification pipeline? The chapter needs to address (or already addresses) the gap between "this worked for classification" and "this pattern generalizes."

2. **Redundancy.** The \$15 inference cost vs. development cost distinction is stated twice in slightly different words (once in the worked example section, once in the cost taxonomy section). This may be intentional reinforcement or unintentional repetition. The audit should flag it and let the revision task decide.

3. **Zero citations with cost claims.** The Concept Mapper numbers need no external citation (author's data). But the chapter also makes claims about: token pricing ratios across model tiers, analyst classification rates (30 questions/hour), fully loaded labor rates (\$100/hour), batch processing economics, and model tier cost ratios (10-30x, 50-100x). Some of these are reasonable estimates; some may be verifiable.

4. **Capstone function.** As the last chapter, it needs to close the book's argument arc. The final paragraphs reconnect to Ch 1's opening thesis. Does this landing work? Does it earn its conclusion or merely restate the premise?

5. **No reflection prompts distributed through the body.** There is one embedded reflection before the thought experiment ("Pick one recurring task...") but no earlier interruptions. Every other chapter has distributed reflection prompts. This is a gap relative to the pedagogical pattern.

6. **No figures.** The chapter has several inline tables but no figure references, no figure specs, and no PaperBanana method files. For a chapter about cost comparisons, a visual cost breakdown or comparison chart would strengthen the argument.

7. **Token pricing claims.** The chapter wisely avoids specific dollar amounts for model pricing and uses ratios instead ("frontier models typically cost 10-30x more per token than mid-tier"). This is good dateability practice. But the ratios themselves are claims. Are they defensible?

8. **The cost justification template.** This is a practical deliverable -- a fill-in-the-blank template for making the case. Does it work? Is it complete? Would a program manager actually use it?

**Known items from handoff and graph:**
- "\$15 vs \$1,500" framing resolved -- lives in Ch 14 ONLY. (Note: the actual comparison in Ch 14 is \$15 vs \$23,200, not \$1,500. The "\$1,500" figure does not appear in the chapter.)
- Ch 13's bridge to Ch 14: "The next chapter addresses the final operational concern: making the economic case and managing the budget." (Verified in Run 011 cascade CA11.)
- Ch 13's hook was revised to "less than fifty dollars" / "a single day" (Session 28, Part G) to avoid contradicting Ch 14's specific Concept Mapper numbers (\$15/~2h). The Ch 14 audit should verify these are now consistent.
- 6,954 is the correct Concept Mapper count (not 6,987). Verify Ch 14 uses the correct number.
- No open graph tasks targeting Ch 14.

**Calibration questions for this run:**
- How does the pipeline perform on an **economics/cost justification** chapter vs. institutional deployment (Ch 13) vs. governance/security (Ch 12)?
- **Zero citations, second consecutive chapter.** Ch 13's citation sparsity gate was the most productive gate in the series. Does it fire as hard on Ch 14, given that the core numbers are first-person data? What claims beyond the Concept Mapper need grounding?
- **Single example dependency.** Is one worked example sufficient for a book chapter about cost justification, or does the chapter implicitly overgeneralize from one case?
- **Redundancy detection.** The pipeline has not previously flagged redundancy within a chapter. Does the repeated \$15/development cost explanation register as a finding?
- **Capstone landing.** Does the book's final paragraph earn its conclusion? Is it emotionally and intellectually satisfying, or does it deflate?
- **Cost justification template utility.** Is the template a genuine practical tool or a placeholder? Would revision improve it?
- **Batch economics claims.** The section on batch processing advantages makes several assertions (no latency requirements, predictable volume, retry-tolerant, off-peak scheduling). Are these accurate and complete?

### Document Type Configuration

```yaml
review:
  document_type: book_chapter
  audience: "Federal data scientists, statisticians, and program managers making budget cases for AI adoption"
  chapter_pattern: "hook ($15) --> counterfactual framing --> worked example (Concept Mapper table) --> cost taxonomy --> batch economics --> model selection economics --> making the case (template) --> opportunity cost --> reflection --> thought experiment --> capstone closing"
```

### Gate Calibration for `book_chapter` (carried from Run 011)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | Zero citations. Concept Mapper numbers are first-person data (no external verification needed for those). Focus on claims beyond the Concept Mapper: pricing ratios, analyst rates, labor rates, batch economics assertions. |
| Tier 2a: Stress Test | **Dual persona** | (A) "Can I use this to justify my AI project to leadership?" (practitioner/data scientist), (B) "Does this give me what I need to approve or advocate for AI spending?" (program manager/budget authority) |
| Tier 2b: Depth Check | Full Bloom taxonomy | Expected ceiling: Apply (the template and thought experiment ask the reader to apply the framework to their own situation). |
| Tier 3: Narrative | Full | Story arc: the \$15 hook must pay off. Capstone landing must close the book's 14-chapter arc. |
| Tier 3: Clarity | Full | Cost terminology -- does the chapter explain inference costs, tokens, API calls sufficiently for a non-technical budget audience? |
| Tier 3: Visual gaps | Full | Several inline tables but no figures. For a cost chapter, visual cost comparisons are high-value. |
| Tier 3: Motivation | Full | Keller ARCS -- does the chapter motivate the reader to actually build the business case, or does the complexity of cost categories discourage action? |

**Carried gates:**

| Gate | Source | Notes |
|------|--------|-------|
| Citation sparsity check | Run 011 (Ch 13) | Most productive gate in the series. Apply the three-way classification: experiential wisdom, verifiable assertions, empirical claims. |
| Dateability check | Run 009 (Ch 11) | Token pricing ratios, model tier terminology, batch API features -- do any risk dating? |
| Framework applicability check | Run 006 (Ch 8) | Does the cost taxonomy framework transfer to the reader's situation, or is it too tied to the Concept Mapper? |

**New gate for this run (single example dependency check):** The chapter's entire economic argument rests on one worked example. Assess whether the Concept Mapper case generalizes (batch classification of structured records against a taxonomy) or whether the chapter implicitly claims generalizability it has not earned. Are there places where the chapter should acknowledge the boundaries of what one example proves?

**New gate for this run (redundancy check):** First explicit redundancy gate in the pipeline. The \$15 inference cost / development cost distinction appears twice in different sections. Identify any other within-chapter redundancy. Distinguish intentional reinforcement (pedagogically motivated repetition) from unintentional duplication (same point restated without added value).

**New gate for this run (capstone coherence check):** As the final chapter, Ch 14 must close the book's argument arc. Does the closing reconnect meaningfully to Ch 1's thesis ("LLM-powered research workflows require the same architectural discipline that distributed systems have always required")? Does the reader feel they have arrived somewhere, or does the ending deflate? Compare to the hooks and bridges of prior chapters -- is the landing proportional to the journey?

**New gate for this run (template utility check):** The cost justification template is a concrete deliverable. Evaluate it as a practitioner tool: Is it complete? Are the categories right? Would a program manager actually fill this in and present it to leadership? Does it need more structure, or is its current open-ended format appropriate?

---

## Execution Instructions

Run the full AD-020 pipeline:

### Tier 1: Content Audit
Use `.claude/agents/auditor.md` agent. Run the auditor on `book/chapter-14.md` with `document_type: book_chapter`.
- Output: `audits/chapter-14_content_audit.yaml`
- Generate Perplexity verification queries for factual claims beyond the Concept Mapper's first-person data:
  - Token pricing ratios across model tiers (frontier 10-30x mid-tier, 50-100x small)
  - Analyst classification rate (30 questions/hour for taxonomy-based classification)
  - Fully loaded federal labor rate (\$100/hour)
  - Batch API pricing advantages (off-peak scheduling, dedicated capacity claims)
  - Any other specific verifiable assertion not grounded in the Concept Mapper's actual data
- Output: `audits/chapter-14_perplexity_queries.md`

### Tier 2a: Practitioner Stress Test (Dual Persona)
Run two passes:
- **Persona A (Practitioner/Data Scientist):** "I need to justify my AI pipeline to my program office. Does this chapter give me the framework, the vocabulary, and the evidence structure to make that case?"
- **Persona B (Program Manager/Budget Authority):** "Someone is asking me to fund an AI project. Does this chapter help me evaluate the proposal? Do the cost categories make sense? Is the comparison framework honest about what AI costs and what it saves?"
- Output: `audits/chapter-14_practitioner_stress_test.yaml` with separate scores per persona

### Tier 2b: Bloom Depth Check
- Output: `audits/chapter-14_bloom_depth_check.yaml`

### Tier 3: Secondary Sweep
Includes: narrative arc, clarity, visual gaps, motivation (ARCS), plus all carried and new gates (citation sparsity, dateability, framework applicability, single example dependency, redundancy, capstone coherence, template utility).
- Output: `audits/chapter-14_secondary_sweep.yaml`

### Synthesis
Combine all tiers into findings clusters with convergence scores.
- Output: `audits/chapter-14_review_synthesis.yaml`

### Cascade Checking
Use `.claude/agents/cascade-checker.md` agent.

**Cross-references to verify (forward and backward):**

| ID | Source | Target | Claim to verify |
|----|--------|--------|----------------|
| CA1 | Ch 14 "When Cheap Models Win" | Ch 8 | "The evaluation harness from Chapter 8 makes this determination possible" -- does Ch 8 describe an evaluation harness that enables model selection by accuracy threshold? |
| CA2 | Ch 14 "When Cheap Models Win" | Ch 5 | "ensemble patterns that validate cheaply (Chapter 5)" -- does Ch 5 describe ensemble/multi-model patterns for validation? |
| CA3 | Ch 14 "When Cheap Models Win" | Ch 8 | "evaluation infrastructure that proves which model suffices (Chapter 8)" -- same target as CA1, different claim framing. Verify both land. |
| CA4 | Ch 14 "When Cheap Models Win" | Ch 7 | "checkpoint design that prevents expensive reprocessing (Chapter 7)" -- does Ch 7 cover checkpoint/restart patterns? |
| CA5 | Ch 14 "Batch Economics" | Ch 6 | "Chapter 6 covers the throughput constraint ladder" -- does Ch 6 define a throughput constraint ladder? |
| CA6 | Ch 14 "Cost of Not Doing It" | Ch 13 | "a six-month procurement cycle delays capability deployment while the model landscape shifts (Chapter 13)" -- does Ch 13 discuss procurement cycle delays? |
| CA7 | Ch 14 "Cost of Not Doing It" | Ch 13 | "governance review takes longer than the project it is reviewing" -- does Ch 13 make this observation? |
| CA8 | Ch 13 bridge | Ch 14 | Verify Ch 13's bridge ("The next chapter addresses the final operational concern: making the economic case and managing the budget.") lands accurately in Ch 14's actual content. |
| CA9 | Ch 14 closing | Ch 1 | "The first chapter opened with a claim: LLM-powered research workflows require the same architectural discipline that distributed systems have always required." -- verify Ch 1 contains this claim or its equivalent. |
| CA10 | Ch 14 worked example | Concept Mapper | Verify 6,954 is the count used (not 6,987). Verify \$15 inference cost, ~\$3,500 development cost, 99.5% accuracy, ~2 hours runtime -- all consistent with the canonical Concept Mapper data. |
| CA11 | Ch 14 hook | Ch 13 hook | Verify consistency: Ch 13 (revised) uses "less than fifty dollars" / "a single day." Ch 14 uses "\$15" / "~2 hours." These should be consistent (Ch 13 is illustrative/rounded, Ch 14 is specific). Confirm no contradiction. |

- Output: `audits/chapter-14_cascade_results.yaml`

### Calibration Record
Write calibration observations to: `seldon/docs/design/AD-020_calibration_012_ch14.md`

Include:
1. Gate effectiveness by tier (which gates fired, which found nothing)
2. Standout findings vs. prior runs
3. Dual persona comparison table (Fully/Partial/Not per persona)
4. Bloom comparison table (carry forward from Run 011, add Ch 14 row)
5. Citation profile comparison (carry forward, add Ch 14 row -- second consecutive zero-citation chapter)
6. Visual gap comparison (carry forward, add Ch 14 row -- tables but no figures)
7. New gate assessments: single example dependency, redundancy, capstone coherence, template utility
8. What worked / what to adjust for future runs (security appendix is next)
9. Comparison to immediately prior runs (Ch 12, Ch 13, Ch 14 side by side)
10. **Series summary:** This is the last numbered chapter. Include a cumulative assessment of AD-020 pipeline performance across all 11 book chapter runs: which gates were most productive, which chapter types were hardest, what the pipeline consistently finds, what it consistently misses, and recommendations for the security appendix run.

---

## Verification

After all outputs are produced:
1. All seven audit files exist in `audits/`
2. Calibration record exists at `seldon/docs/design/AD-020_calibration_012_ch14.md`
3. Perplexity queries file identifies every verifiable factual claim beyond Concept Mapper first-person data
4. Dual persona scores are separate and comparable
5. Cascade results cover all 11 cross-reference checks
6. Calibration record includes series summary (this is the last numbered chapter)
7. Run `seldon verify --fix` after all outputs are written

## Do NOT

- Edit `book/chapter-14.md` -- this is an audit-only task
- Edit any other chapter file
- Edit `book/references.bib`
- Make revision recommendations in the audit outputs -- the audit identifies issues; revision is a separate CC task
- Skip the single example dependency check -- this is the highest-risk structural question for this chapter
- Skip the capstone coherence check -- this is the book's landing
- Skip the redundancy check -- the repeated \$15/development cost explanation is a known issue
- Treat the Concept Mapper numbers as needing external verification -- they are first-person author data
- Flag the "\$15 vs \$1,500" framing as an issue -- there is no \$1,500 in the chapter; this was resolved in earlier sessions
