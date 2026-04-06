# AD-020 Calibration Run 011 — Chapter 13

**Date:** 2026-04-06
**Chapter:** Chapter 13: Deploying in Institutional Environments
**Type:** book_chapter (tenth instance)
**Chapter subtype:** institutional_deployment_guide (new type)
**Prior runs:** 002 (Ch 4), 003 (Ch 5), 004 (Ch 6), 005 (Ch 7), 006 (Ch 8), 007 (Ch 9), 008 (Ch 10), 009 (Ch 11), 010 (Ch 12)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** Zero citations. Eight Type B verifiable claims and four Type C empirical claims without sources. No factual errors in the book's own framework application.

| Severity | Finding |
|---|---|
| HIGH | Two Type C empirical claims using 'report' language with no sources: enterprise ATO timelines 'dropping from months to weeks' and dual metrics 'measurably faster authorization without increased incidents.' PQ3 and PQ5 designed to address. |
| HIGH | Broken cascade check CA9: 'the foreword's Feynman frame' is cited but the foreword does not contain a Feynman frame as named or described. Attribution error requiring author action. |
| MEDIUM | Figure discrepancy: Ch 13 hook uses $47/6 hours; Ch 14 breakdown uses $15/~2 hours for what appears to be the same Concept Mapper case study. 3x discrepancy on both figures. |
| MEDIUM | Eight Type B verifiable claims (FedRAMP timelines, procurement cycles, GovCloud lag, local inference capability) without citations or temporal hedges. All accurate; all dateable. |
| LOW | 'Model replaceability principle' in Ch 13 cites Ch 1, but Ch 1 uses 'model-agnostic architecture' language. Labeling inconsistency, not a conceptual error. |

**Zero citations overall:** This is the starkest citation profile in the audit series. The chapter's Type A claims (experiential wisdom) are appropriate without citation. The Type B and C claims are the vulnerability — a practitioner or governance audience skeptical of the institutional change arguments will challenge these claims and find no sources.

**New gate (adversarial tone check):** PASSED. Governance section is diagnostic throughout. 'This is a structural observation, not a personal criticism' is the key sentence. Persona B (IT/governance) would feel described, not attacked. The 'governance-as-power' observation is sharp but depersonalized.

**New gate (tenet diagnostic value check):** ADDED VALUE. Highest tenet/principle density in the series. The diagnostic framing (mapping institutional friction to tenet violations) creates analytical clarity rather than feeling mechanical.

**New gate (learned helplessness check):** BORDERLINE. Comprehensive obstacle catalog risks resignation. Antidote ('Earning Trust Incrementally') is real but sequentially buried at position 5 of 6. Chapter ends on 'culture changes slowly' — honest but anticlimactic.

**Cascade checks:** 9 confirmed, 2 confirmed with minor gap, 1 broken. The broken check (CA9: Feynman frame) is the priority finding. All citations to Ch 1, Ch 8, Ch 9-10, Ch 12, and Ch 14 are accurate. Ch 12's bridge lands cleanly in Ch 13 (CA12 confirmed).

---

## 2. Standout Findings vs. Prior Runs

**Broken Feynman attribution (unique to this run):** No prior run had a broken cross-reference to the foreword. The 'foreword's Feynman frame' appears in Ch 13's capability-building section but the foreword contains no Feynman reference as written. This is the most actionable single finding from Run 011.

**Zero citations — series outlier:** Ch 13 has the weakest citation profile in the series. Ch 10 had 2 self-citations (100% self-citation, the 'self-only' profile). Ch 13 has 0 citations total. The difference is that Ch 10's zero-external-citation profile is appropriate (self-developed framework); Ch 13 makes verifiable empirical claims about institutional behavior that a general audience will test against their experience.

**Triple persona test — strongest combined score:** The 7/8/0 score across 15 questions (three personas × five questions each) is the highest aggregate in the audit series. Zero 'not answerable' scores means the chapter doesn't leave any persona behind. The trade-off: eight 'partially answerable' scores reflect conceptual strength without procedural depth.

**Create-level thought experiment — series first:** Ch 13 is the first chapter in the audit series to reach Bloom level 6 (Create) at the thought experiment. 'Design a tiered governance model using compressed tenets as constraints' is a genuine construction task, not an evaluation. Prior chapter thought experiments topped at Evaluate.

**Zero tables — starkest visual gap in series:** Ch 13 has more frameworks (tiered governance, cloud portfolio, trust-building sequence, incentive structure) than any prior chapter and zero tables. Ch 12 had six tables, the most in the series. The contrast is stark: Ch 12's tables operationalized its framework; Ch 13's prose embeds its frameworks without surfacing them visually.

**Figure discrepancy ($47 vs. $15):** No prior run identified a figure discrepancy between chapters. The hook in Ch 13 and the cost breakdown in Ch 14 use figures from the same case study that differ by 3x on both dimensions. This is the first inter-chapter numerical consistency gap in the audit series.

---

## 3. Triple Persona Comparison Table

| Persona | Fully | Partial | Not | Top Gap |
|---|---|---|---|---|
| A (Practitioner) | 2 | 3 | 0 | Authorization sequence; pilot design template |
| B (IT/Governance) | 3 | 2 | 0 | Implementation pathway for governance reform |
| C (Program Manager) | 2 | 3 | 0 | Metric operationalization; phase milestones |
| **Combined** | **7** | **8** | **0** | Implementation specificity across all personas |

**Cross-run comparison of practitioner scores:**

| Run | Chapter | Persona(s) | Fully | Partial | Not |
|---|---|---|---|---|---|
| 006 | Ch 8 | A (single) | 0 | 9 | 1 |
| 007 | Ch 9 | A (single) | — | — | — |
| 009 | Ch 11 | A (single) | 1 | 9 | 0 |
| 010 | Ch 12 | A + B (dual) | 4 | 6 | 0 |
| 011 | Ch 13 | A + B + C (triple) | 7 | 8 | 0 |

**Calibration insight:** Each successive governance/operational chapter (Ch 11 → Ch 12 → Ch 13) has improved combined persona scores. The triple persona format for Ch 13 reflects the chapter's declared three-audience design ('Practitioners navigating institutions, IT/governance teams, program managers'). The governance audience (Persona B) consistently scores highest in governance chapters — a structural pattern not a chapter-specific finding. The program manager persona (C) is the first addition to the series; Ch 13 is well-suited to it given its organizational change focus.

---

## 4. Bloom Comparison Across Chapter Types

| Run | Chapter | Type | Bloom Ceiling | Sections at Apply/Below | Scaffolding |
|---|---|---|---|---|---|
| 006 | Ch 8 | methodology/framework | Evaluate | 5/9 | non-monotonic |
| 007 | Ch 9 | theoretical | Evaluate | ~3/9 | non-monotonic |
| 008 | Ch 10 | infrastructure | Evaluate | 5/9 | non-monotonic |
| 009 | Ch 11 | framework/landscape | Evaluate | 4/8 | non-monotonic |
| 010 | Ch 12 | governance/security | Evaluate | 8/9 | flat Apply plateau |
| 011 | Ch 13 | institutional deployment | **Create** | 4/8 | **monotonic ascent** |

**New observation:** Ch 13 is the first chapter to break the Evaluate ceiling and the first with monotonic scaffolding (no valleys). The Create ceiling is earned: 'design a tiered governance model using tenets as constraints' is a genuine construction task. The monotonic ascent (Understand → Apply plateau → Analyze → Create) is the cleanest scaffolding progression in the series.

**Ch 12 vs. Ch 13 Bloom contrast:** Ch 12 had the flattest scaffolding (8/9 sections at Apply, driven by tables enforcing Apply engagement). Ch 13 has the highest ceiling (Create) but carries its Bloom scaffolding entirely in prose. A reader who skims Ch 13 receives less scaffolding than a reader who skims Ch 12 because tables enforce engagement while prose does not.

---

## 5. Citation Profile Comparison

| Chapter | Total | Self-citations | External | Self % | Profile |
|---|---|---|---|---|---|
| Ch 9 | 4+ | 1 (webb_ai4stats) | 3 | 25% | balanced |
| Ch 10 | 2 | 2 | 0 | 100% | self-only |
| Ch 11 | 3 | 1 (webb_pragmatics) | 2 | 33% | model profile |
| Ch 12 | 4 | 1 (webb_crosswalk) | 3 | 25% | balanced |
| **Ch 13** | **0** | **0** | **0** | **n/a** | **zero — outlier** |

**Series conclusion:** Ch 13's zero-citation profile is the series outlier. The other chapters in the late-book cluster (Ch 11-12) established a citation pattern of 3-4 citations (one self, two to three external). Ch 13 makes more empirical assertions about organizational behavior than any prior chapter and has fewer citations than any chapter. The disconnect between assertion volume and citation support is the chapter's primary credibility risk.

**Zero citations does not mean zero appropriate claims:** 16 of the chapter's claims are Type A (experiential wisdom, appropriate without citation). The problem is the eight Type B and four Type C claims embedded among them without differentiation. A reader cannot tell which claims are backed by evidence and which are author observation.

---

## 6. Visual Gap Comparison

| Run | Chapter | Figures | Tables | Gap? |
|---|---|---|---|---|
| 002 | Ch 4 | 0 | 0 | yes |
| 003 | Ch 5 | 1 | 0 | partial |
| 004 | Ch 6 | 0+ | 0 | yes |
| 005 | Ch 7 | 2+ | 0 | partial |
| 006 | Ch 8 | 0 | 0 | yes |
| 007 | Ch 9 | 0 | 3 (post-revision) | resolved |
| 008 | Ch 10 | 0 | 0 | yes |
| 009 | Ch 11 | 0 | 1 | partial |
| 010 | Ch 12 | 0 | 6 | different pattern |
| **011** | **Ch 13** | **0** | **0** | **critical gap** |

**Ch 13 is the most framework-rich chapter with the fewest visuals.** The contrast with Ch 12 (six tables, framework operationalized) is stark. Ch 13 describes four distinct frameworks in prose: tiered governance, cloud portfolio, trust-building sequence, and incentive structure. None are visually operationalized.

**Running series conclusion:** Visual gaps are persistent. Ch 12 resolved its gap via tables (tables as primary content mechanism). Ch 9 resolved its gap via a post-revision table addition. Ch 13 is the highest-priority candidate for table additions in the series given the gap between framework density and visual representation.

---

## 7. What Worked / What to Adjust

**Worked well:**
- **Triple persona test:** First use of a triple persona format. Produced differentiated and diagnostic results. The program manager persona (C) is a natural addition for organizational change chapters. The 7/8/0 combined score validates the zero 'not answerable' design — the chapter genuinely serves all three audiences even if not all their needs.
- **Adversarial tone check (new gate):** Caught the most politically sensitive section cleanly. The governance power dynamics section passed the diagnostic test definitively. This gate is valuable for any chapter discussing institutional conflict.
- **Citation sparsity type taxonomy (A/B/C):** The Type A/B/C categorization of claims (experiential wisdom vs. verifiable vs. empirical) is the most analytically useful Tier 1 framework introduced in the series. Prior runs flagged 'citation gap' without differentiating between claims that appropriately lack citation and those that need it.
- **Learned helplessness check (new gate):** Borderline result is a genuine finding — the chapter's obstacle catalog structure is the primary ARCS weakness. This gate would have been valuable in earlier runs (Ch 11's landscape section had similar risk).
- **Feynman attribution catch:** The cascade check process correctly identified a broken cross-reference that would otherwise pass content review.

**Adjust for Run 012:**
- **Citation sparsity check with A/B/C taxonomy should be standard for all remaining chapters.** It is the most useful gate addition from this run.
- **Triple persona test:** Add the program manager persona (C) for any chapter with a declared multi-audience design. The governance-audience advantage pattern is now well-established across three runs; Persona C provides a needed third lens for organizational change chapters.
- **Figure discrepancy check:** The $47 vs. $15 finding suggests a need for a cross-chapter numerical consistency check, at minimum for hook figures and named case study results. Add 'hook figure consistency' to the cascade check table for any chapter whose opening uses specific numbers from the book's anchor case studies.
- **Learned helplessness check:** Should be standard for any chapter with a comprehensive obstacle catalog (not just governance chapters). The pattern (enumerate obstacles → provide antidote → check whether antidote is sequentially sufficient) is generalizable.
- **Bloom plateau check:** The Apply plateau (three consecutive sections at Apply) is the main Bloom weakness in Ch 13. Tables are the natural remedy. Bloom audit should now explicitly note whether a plateau could be resolved by table addition.

---

## 8. Comparison to Immediately Prior Runs

| Metric | Ch 11 (run-009) | Ch 12 (run-010) | Ch 13 (run-011) |
|---|---|---|---|
| Type | framework + landscape | governance/security | institutional deployment |
| Words | ~3,187 | ~2,855 | ~2,574 |
| Citations | 3 | 4 | **0** |
| Self-citation % | 33% | 25% | **n/a** |
| Figures | 0 | 0 | 0 |
| Tables | 1 | 6 | **0** |
| Triple persona score | 1/9/0 (single A) | 4/6/0 (dual A+B) | **7/8/0** (triple A+B+C) |
| Bloom ceiling | Evaluate | Evaluate | **Create** |
| Bloom scaffolding | non-monotonic | flat Apply plateau | **monotonic ascent** |
| Cascade broken | 1 (stochastic tax) | 0 | **1 (Feynman frame)** |
| Verdict | conditionally_ready | conditionally_ready | conditionally_ready |
| Top finding | LangChain hedging + stochastic tax attribution | agentic security gap (convergence 4) | **Feynman attribution error + zero citations** |
| New gates introduced | framework applicability | dual audience; regulatory accuracy; agentic gap | adversarial tone; tenet diagnostic value; learned helplessness; A/B/C citation taxonomy |

**Trajectory across Ch 11 → Ch 12 → Ch 13:**
- Citation count declining (3 → 4 → 0) while assertion volume is stable or increasing
- Word count declining (3187 → 2855 → 2574) — chapters are getting more efficient
- Persona score improving (1/9/0 → 4/6/0 → 7/8/0) — chapters are better serving declared audiences
- Tables: volatile (1 → 6 → 0) — Ch 12's table-heavy structure was a chapter-type choice, not a norm
- Bloom ceiling: held at Evaluate for three runs then broke to Create in Ch 13

**Ch 13 assessment:** The chapter is structurally and conceptually strong. The governance-as-gate vs. governance-as-infrastructure framing and the tiered review framework are genuine contributions. The three open items requiring author action (Feynman attribution, Type C empirical claims, figure discrepancy) are targeted and resolvable. The visual gap (zero tables) is the largest structural improvement opportunity. The conditionally_ready verdict is appropriate and consistent with the series pattern.

---

## 9. Gate Output for Book-Level Concerns

**Inter-chapter figure consistency (new concern, gate TBD):**
The $47 (Ch 13) vs. $15 (Ch 14) discrepancy for the same Concept Mapper case study is the first inter-chapter numerical consistency gap identified in the series. A book-level consistency check on anchor case study figures (specifically the Concept Mapper $15 inference cost, 6,954 questions, 99.5% accuracy) should be added. These numbers appear across multiple chapters and must be consistent.

**Foreword completeness check (new concern):**
The Feynman frame attribution in Ch 13 suggests the foreword may have been edited to remove content that later chapters reference. A foreword completeness audit against all chapters' cross-references to the foreword would prevent similar broken attributions in other chapters.

**Observation on chapter length trend:**
Ch 11: ~3,187 words. Ch 12: ~2,855 words. Ch 13: ~2,574 words. The late chapters are getting shorter. If Ch 14 continues this trend (and the initial read suggests it does), the book's final cluster is more compressed than the middle chapters. This may be appropriate (operational chapters are often more procedural and less discursive) but warrants monitoring.
