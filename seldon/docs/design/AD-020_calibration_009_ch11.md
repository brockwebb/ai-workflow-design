# AD-020 Calibration Run 009 — Chapter 11

**Date:** 2026-04-05
**Chapter:** Chapter 11: Workflow Orchestration & the Tool Landscape
**Type:** book_chapter (eighth instance)
**Chapter subtype:** evaluation_framework_landscape_survey (new type)
**Prior runs:** 002 (Ch 4, domain), 003 (Ch 5, pattern), 004 (Ch 6, eng/construction), 005 (Ch 7, eng/defensive), 006 (Ch 8, methodology/framework), 007 (Ch 9, theoretical framework), 008 (Ch 10, practitioner_infrastructure_guide)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** One cascade error found: 'Chapter 9's stochastic tax' should be 'Chapter 1's stochastic tax.' Confirmed via cascade checks CA3 and CA4. All three citations verified:
- `webb_2026_pragmatics`: pipeline fidelity 91.2% vs. 74.6% RAG, MCP tool design principles — CONFIRMED
- `fcsm_2025_aiready`: machine-readable vs. machine-understandable, MCP as integration protocol — CONFIRMED
- `chen_2026_sweci`: 100 tasks, 233 days/71 commits, 75% models break working code — CONFIRMED (arXiv preprint, pre-publication verification still needed)

Unsourced factual claims: three (LangChain historical coupling behavior, 90/10 rule attribution, AI landscape half-life). These are the chapter's residual Tier 1 gaps. All are framing issues, not factual errors — they need author-experience framing or citation, not correction.

**New gate (dateability check):** Most effective new gate in the series. Caught the LangChain risk immediately: named as a negative example with 'early versions' qualifier that provides partial but incomplete dateability protection. The chapter's self-aware HTML comment ('this chapter ages fastest') is earned by the framework-first structure. The dateability check confirmed the framework > tools approach is working. Five of ten named tools are at low dateability risk; one (LangChain as named negative example) is at moderate risk.

**Citation density:** 3 citations across ~47 content sentences = 6.4%. Self-citation rate: 1/3 (~33%). This is the most deliberately sparse citation profile in the series, but it is the correct choice — the chapter explicitly avoids tool-specific citations that would date. The three citations that do exist are appropriate (self-citation for case study, federal source for federal context, empirical citation for the strongest empirical claim). **This is not the same as Ch 9's 100% self-citation or Ch 10's 0% external — this is intentional sparsity with correct citation placement.**

**Word count:** ~3,187 words. Second-longest chapter. Appropriate density.

---

## 2. Gate Effectiveness by Tier (continued)

**Tier 2a (Practitioner):** 1 fully answerable, 9 partially answerable, 0 not-answerable.

| Run | Chapter | Type | Full | Partial | Not |
|---|---|---|---|---|---|
| 002 | Ch 4 | domain | 0 | 0 | 9 |
| 007 | Ch 9 | theoretical | 2 | 5 | 3 |
| 008 | Ch 10 | infrastructure | 0 | 9 | 1 |
| 009 | Ch 11 | framework/landscape | 1 | 9 | 0 |

Ch 11 scores better than Ch 10 (1 vs. 0 fully) because the chapter's core deliverable — the evaluation framework — is itself a usable tool. Ch 10's core deliverable (how to build a provenance system) was a pattern, not an implementation. The framework chapter type has a different answerability ceiling: the framework IS the answer to "how do I evaluate my tools." Implementation guidance is intentionally deferred to other chapters.

Calibration insight: **evaluation framework chapters have a natural 1/9/0 ceiling** unless they include worked examples for each major question. The one fully answerable question (Q7 — do I have a usable evaluation checklist?) is exactly what the chapter promises.

**Tier 2b (Bloom):** Ceiling: Evaluate. Scaffolding: non-monotonic with valley at "90/10 Rule and the Last Mile" (Understand). Sections at Apply or below: 4 of 8. Similar Bloom profile to Ch 9 and Ch 8.

| Run | Chapter | Bloom Ceiling | Sections at Apply/Below | Valley |
|---|---|---|---|---|
| 006 | Ch 8 | Evaluate | 5 | Tailored Crosswalk |
| 007 | Ch 9 | Evaluate | ~3 | (pre-revision estimate) |
| 008 | Ch 10 | Evaluate | 5 | Context budget |
| 009 | Ch 11 | Evaluate | 4 | 90/10 Rule |

The evaluation framework chapter type correctly peaks at Evaluate — the chapter's purpose is to give the reader a judgment tool. Evaluate ceiling is the right outcome, not a gap.

**Tier 3 (Secondary Sweep):**
- Narrative arc: works. Hook pays off. Framework-first structure earns the "ages fastest" acknowledgment.
- Clarity/jargon: adequate. Stochastic tax attribution error is both a Tier 1 cascade finding and a Tier 3 clarity finding (undefined for non-linear reader).
- Visual gaps: zero figures, one table (8th data point in running visual gap series). Evaluation framework as prose instead of visual is the strongest gap — a scoring template would directly improve practitioner usability.
- Motivation (ARCS): strong attention, strong relevance, moderate confidence/satisfaction. Friction and volatility dimensions have weaker motivational setup than coupling.
- Dateability check: well-handled overall. LangChain moderate risk; all others low risk.
- Vocabulary bridging: gap confirmed. Design note's diagnosis validated.
- Framework applicability: adequate, not excellent. No worked example applying all four dimensions to one tool.
- Tutorial vs. pattern: passes. Pragmatics example is principles-level, not tutorial.

---

## 3. Cross-Tier Cluster Analysis

| Cluster | Convergence | Severity | Status |
|---|---|---|---|
| C1: Stochastic tax attribution error | 2 | convergence 3 | fix before publication |
| C2: LangChain historical claim | 3 | convergence 3 | author decision |
| C3: 90/10 and half-life citation/framing | 2 | convergence 2 | author decision |
| C4: Visual gap — framework scoring template | 3 | convergence 3 | author decision |
| C5: Vocabulary bridging gap | 2 | convergence 2 | planned revision |
| C6: Recursive stochasticity solution depth | 2 | convergence 2 | author scope decision |
| C7: Practitioner score 1/9/0 (characterization) | 2 | convergence 2 | informational |
| C8: 'Frontier models' characterization | 1 | convergence 1 | pre-publication perplexity |

Top 3 by convergence: C2 (3), C4 (3), then C1 and C3 tied at (2) with C1 higher severity.

---

## 4. Calibration Data Points vs. Prior Runs

### New chapter type: evaluation_framework_landscape_survey

Ch 11 is the first landscape chapter in the series. Key differences from prior types:

- **Citation sparsity is correct, not a gap.** The chapter deliberately avoids tool citations. The 3 citations placed are all high-quality placements. Prior runs flagged citation sparsity as a gap (Ch 9's 100% self-citation, Ch 10's 0% external). Ch 11 has the most appropriate citation profile because it matches the chapter's design intent.

- **Named tool accuracy** is a new finding category. The pipeline identified LangChain characterization risk, Airflow/Prefect as low-risk (established projects), n8n/Zapier/Make as moderate (business model dependency), Haystack/CrewAI/AutoGen as low-moderate (actively developed). This is a useful new gate for landscape chapters.

- **Practitioner ceiling for framework chapters is 1/9/0, not 5+/N/0.** A chapter whose deliverable is a framework will score higher on Q7 ("do I have an evaluation tool") than on Q1-Q6 ("can I implement X"). The framework IS the fully answerable question. Infrastructure chapters (Ch 10) that promise implementation guidance have a higher bar.

### Visual gap — 8th data point

| Run | Chapter | Figures | Tables | Gap? |
|---|---|---|---|---|
| 002 | Ch 4 | 0 | 0 | yes |
| 003 | Ch 5 | 1 | 0 | partial |
| 004 | Ch 6 | 0+ | 0 | yes |
| 005 | Ch 7 | 2+ | 0 | partial |
| 006 | Ch 8 | 0 | 0 | yes |
| 007 | Ch 9 | 3 tables (post-revision) | 3 | resolved |
| 008 | Ch 10 | 0 | 0 | yes |
| 009 | Ch 11 | 0 | 1 | partial |

Pattern: visual gaps are persistent. Ch 11 has a well-placed comparison table. The missing figure (evaluation framework scoring tool) is the most actionable gap — it directly supports the chapter's core deliverable.

### Self-citation profile comparison

| Chapter | Self-citations | External | Total | Self % |
|---|---|---|---|---|
| Ch 9 | 1 (webb_2026_ai4stats) | 3 (widmer, gama, simmhan) | 4+ | 25% |
| Ch 10 | 2 (shapiro, concept_mapper) | 0 | 2 | 100% |
| Ch 11 | 1 (webb_2026_pragmatics) | 2 (fcsm, chen) | 3 | 33% |

Ch 11's citation profile is the most balanced: one self-citation (case study), one federal source (audience context), one external empirical (strongest claim). This is the model citation pattern for the book.

### Vocabulary bridging — first explicit confirmation

The vocabulary bridging check (new gate for this run) independently confirmed the design note's diagnosis without the note having been read during the audit. The audit found industry terms absent (agent contracts, skills, IaC, GitOps, second-look pattern) and confirmed the gap. The design note's planned intervention is validated.

### Recursive stochasticity "full treatment" assessment

The section delivers on the problem (empirical grounding via SWE-CI, causal model) but not fully on the solution (countermeasures named but not operationalized). This is a scope decision: if "full treatment" means fully treating the problem statement, the section delivers. If it means providing a complete implementation guide, it falls short. For a landscape/orchestration chapter, treating the problem fully and naming the countermeasures (with cross-references to implementation chapters) is the appropriate scope.

---

## 5. What Worked / What to Adjust

**Worked well:**
- Dateability check: most productive new gate. Immediately useful for landscape chapters.
- Vocabulary bridging check: confirmed the design note diagnosis without prompting.
- Tier 1 cascade chain for stochastic tax: found the attribution error through multi-hop reasoning (Ch 11 → Ch 9 → Ch 1).
- Citation verification for three targeted claims: all three passed cleanly.
- Named tool accuracy: useful category for landscape chapters, not previously tested.

**Adjust for future runs:**
- **Evaluation framework chapter type needs a different practitioner persona.** The current persona ("can I implement X after reading this?") undersells framework chapters. For Ch 11, the practitioner persona should include "do I have a judgment tool I can use immediately?" — which this chapter answers. Consider splitting the stress test for framework chapters into (a) can I use the framework?, and (b) can I implement the downstream actions the framework leads to?
- **Visual gap gate for landscape chapters should ask specifically:** "Could the evaluation framework be rendered as a template the reader fills in?" This is more precise than "are there figures?" for this chapter type.
- **Citation sparsity interpretation.** For landscape chapters, low citation count is not automatically a gap. The gate should ask: "Are the citations present at the right claims?" not "is the citation count sufficient?" Ch 11 has the right three citations.

---

## 6. Comparison to Immediately Prior Runs

| Metric | Ch 9 (run-007) | Ch 10 (run-008) | Ch 11 (run-009) |
|---|---|---|---|
| Type | theoretical framework | infrastructure guide | framework + landscape |
| Words | ~3,210 | ~3,146 | ~3,187 |
| Citations | 4 | 2 | 3 |
| Self-citation % | 25% | 100% | 33% |
| Figures | 3 tables | 0 | 0 |
| Tables | 3 | 0 | 1 |
| Practitioner full/partial/not | 2/7/1 | 0/9/1 | 1/9/0 |
| Bloom ceiling | Evaluate | Evaluate | Evaluate |
| Verdict | conditionally_ready | conditionally_ready | conditionally_ready |
| Top finding | canonical baseline FAILED (pre-revision) | no MVP sequence | stochastic tax attribution error |
| Cluster count | 8 | 5 | 8 |

Ch 11's verdict matches Ch 9 and Ch 10: conditionally_ready. The pattern holds: book chapters at this draft stage are ready for use with targeted corrections, not major revision.

Ch 11's one hard finding (stochastic tax attribution error) is easier to fix than Ch 9's canonical baseline failure or Ch 10's missing MVP sequence. The chapter is in better shape than Ch 10 at a comparable draft stage.
