# AD-020 Calibration Run 006 — Chapter 8

**Date:** 2026-04-03
**Chapter:** Chapter 8: Evaluation by Design
**Type:** book_chapter (fifth instance)
**Prior runs:** 002 (Ch 4, domain chapter), 003 (Ch 5, pattern chapter), 004 (Ch 6, engineering/construction chapter), 005 (Ch 7, engineering/defensive chapter)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** The $100 vs $15 cost discrepancy is the run's highest-severity finding. Ch 8 says the Concept Mapper cost "under $100"; Ch 5, Ch 14, and intro.md all say "$15." These may refer to different scopes, but the inconsistency needs author resolution. The 7,000 vs 6,954 question count inconsistency persists — Ch 8 is the only chapter using the rounded figure, perpetuating the known cross-chapter issue from runs 004-005. The FCSM 20-04 document number is plausible but unverified. The "18 AI coding models" claim for chen_2026_sweci adds detail not present in Ch 7 or references.bib. mazeika_2025 verified clean against bib note: all numbers match (240 projects, 23 categories, 6,000+ hours, 2.5%). Citation density is 5 citations with 12 cited assertions out of 52 total (23.1%), driven heavily by webb_2026_crosswalk x 7. The five mapping type counts (4+1+2+3+4=14) are internally consistent.

**Tier 2a (Practitioner):** 5 fully answerable, 5 partially, 0 not. This is the first run with zero unanswerable questions. The methodology chapter's framework-based guidance means every question has at least partial coverage. The top gaps are: (1) no confabulation detection implementation guidance, (2) no step-by-step evaluation architecture design workflow, (3) no quantitative golden test set sizing or agreement threshold interpretation guidance. These are Apply-level gaps — the chapter provides the conceptual framework but not always the implementation path.

**Tier 2b (Bloom):** Evaluate ceiling reached in two sections (Gate Not Dial, What Evaluation Cannot Do) and the thought experiment. Apply floor met by most sections. KEY FINDING: The Tailored Crosswalk section — the chapter's centerpiece methodology — stays at Understand. The reader watches the author map; they do not map themselves. This is the chapter's most significant cognitive gap. Evaluation Economics also stays at Understand. Scaffolding is non-monotonic with a valley in the middle (Tailored Crosswalk at Understand, Evaluation Economics at Understand).

**Tier 3 (Secondary):** Visual gap is the dominant finding for the fifth consecutive run. Uniquely, Ch 8's visual gap is the strongest signal in the series: a methodology chapter teaching a dual-framework crosswalk with zero tables or diagrams. The mapping types, tailored crosswalks, and evaluation architecture are all screaming for structured visual treatment. Narrative tension dissipates after the Remote Labor Index hook. The crosswalk section's shift from second-person to third-person breaks motivational momentum.

## 2. Methodology Chapter Characteristics

Ch 8 is the first methodology/framework chapter audited. Key differences from prior chapter types:

**Practitioner gaps are at the implementation boundary, not the center.** Domain chapters (Ch 4) had gaps at the center (no implementation). Engineering chapters (Ch 6, 7) had gaps at operational edges. Methodology chapters have gaps at the implementation boundary: the framework is complete, but the path from framework to implementation is not always scaffolded. Q6 (confabulation detection) and Q10 (first three steps of evaluation architecture) illustrate this pattern.

**Bloom ceiling matches defensive chapters.** Evaluate, not Create. This is intrinsic: methodology chapters ask "how do you evaluate your evaluation?" (Evaluate) rather than "design something new" (Create). The thought experiment reaches Evaluate (present evidence and judge sufficiency) but not Create (design the evaluation). This is appropriate for a chapter that teaches evaluation discipline.

**Self-citation density is high but appropriate.** webb_2026_crosswalk x 7 dominates the chapter because the chapter explicitly operationalizes that paper. This is not a structural risk — it is the intended design. The chapter is the book's application layer for the crosswalk paper. The risk is not citation diversity but rather whether the chapter adds enough value beyond the paper to justify its existence. It does: the golden test set pattern, multi-model agreement as evaluation, continuous evaluation, and evaluation economics all extend beyond the crosswalk paper's scope.

**The "gate not dial" argument reaches Evaluate.** The chapter asserts and demonstrates (via NIST architecture and crosswalk operational evidence) that valid-and-reliable is a binary prerequisite. The argument is supported at Evaluate level because the reader can assess the implication for their own pipeline. However, the specification gap (what confabulation detection looks like in a particular domain) is identified but not filled — this is honest but leaves an Apply-level gap.

## 3. Self-Citation Density Assessment

| Source | Citation Count | Usage Pattern |
|--------|---------------|---------------|
| webb_2026_crosswalk | 7 | Structural backbone — mapping types, tailored crosswalks, specification gap, evaluation framework translation |
| webb_2026_concept_mapper | 3 | Case study evidence — golden test sets, multi-model agreement, cost data |
| nist_ai_rmf_2023 | 1 | Framework authority — trustworthiness hierarchy |
| mazeika_2025 | 1 | Opening hook — benchmark vs reality gap |
| chen_2026_sweci | 1 | Continuous evaluation evidence — long-term maintenance regressions |

**Assessment:** 10 of 13 citation instances are to the author's own work (77%). This is the highest self-citation density in the series. It is appropriate because the chapter explicitly operationalizes the author's crosswalk paper — the crosswalk IS the content, not just a supporting reference. The risk is not bias but rather independence: a reviewer could question whether the chapter is sufficiently grounded in external evidence. The mazeika_2025 and chen_2026_sweci citations provide external anchoring, but the evaluative framework itself rests entirely on the author's interpretation. This is disclosed ("The crosswalk is an evaluation framework translation, not empirical validation") which is honest and appropriate.

**Structural risk identified:** The $100 cost figure's conflict with other chapters creates a specific self-citation credibility issue. When the author is both the source and the interpreter, internal consistency must be bulletproof. It is not currently bulletproof.

## 4. Visual Gap Persistence (5th Data Point)

| Run | Chapter | Figures | Type | Visual Severity |
|-----|---------|---------|------|-----------------|
| 002 | Ch 4 | 0 | Domain | High (pipeline architecture) |
| 003 | Ch 5 | 0 | Pattern | High (3 topology diagrams) |
| 004 | Ch 6 | 0 | Engineering/Construction | High (parallel architecture, model abstraction) |
| 005 | Ch 7 | 2 | Engineering/Defensive | Medium (error table, checkpoint diagram — NOW HAS FIGURES) |
| 006 | Ch 8 | 0 | Methodology/Framework | High (mapping types table, tailored crosswalk tables, architecture diagram) |

**UPDATE:** Ch 7 now has two figures (fig-07-01 error classification table, fig-07-02 checkpoint safe write pattern), added between runs 005 and 006. This is the first chapter to gain figures after being flagged. Ch 8 has zero figures and the strongest visual gap signal: a methodology chapter with structured framework content (mapping types with counts, dual-framework mappings, two tailored crosswalk examples) and no visual representation whatsoever.

**Confirmed pattern with 5 data points:** Visual absence is a book-wide issue. Ch 7's figure addition validates that the pipeline's visual gap findings lead to action. Ch 8's visual needs are more urgent than Ch 7's were — tables for framework content are higher-value than diagrams for engineering patterns because practitioners will reference framework tables repeatedly.

## 5. Evaluation Economics Robustness

The $100 and $15 figures are NOT bulletproof.

**$100 for Concept Mapper:** This figure conflicts with $15 stated in Ch 5, Ch 14, and intro.md. The most likely explanation is scope difference ($15 = inference cost for the classification pipeline; $100 = full pipeline including all evaluation stages), but this is not stated. If the $100 figure is correct for a broader scope, it must be explicitly distinguished from the $15 figure. If it is an error, it must be corrected. Either way, a reader who reads both Ch 5 and Ch 8 will notice the discrepancy.

**$15 for pragmatics evaluation:** Correctly attributed to webb_2026_crosswalk, not the Concept Mapper. But Ch 5 line 124 attributes "$15" to the Concept Mapper, creating confusion about which system costs $15. Author must decide: does $15 belong to the Concept Mapper (as Ch 5, Ch 14, intro.md say) or to the pragmatics evaluation (as Ch 8 says)?

**Assessment:** These specific cost claims are exactly the kind of details that reviewers and practitioners will fact-check. The inconsistency undermines a powerful argument ("evaluation is cheap"). Resolution is HIGH priority.

## 6. Bloom Depth on Framework Operationalization

**Key finding:** "Operationalizing a framework paper" naturally sits at Understand when presented as worked examples. It reaches Analyze/Apply only when the reader is scaffolded to DO the operationalization themselves.

Ch 8's Tailored Crosswalk section presents two worked examples from the paper (batch classification, real-time consultation). The reader understands the methodology but is not asked to apply it. The section opens with "for each design choice in your pipeline, ask what FCSM quality dimension it addresses and what NIST trustworthiness characteristic it satisfies" — this is Apply-level instruction. But it is immediately followed by the author's examples, not by a scaffolded exercise. The reader watches the demonstration and does not practice.

**Recommendation for methodology chapters:** When the chapter's core methodology is framework operationalization, a structured exercise (template, worksheet, or prompted activity) is required to push from Understand to Apply. This is the methodology chapter equivalent of the engineering chapter's "build this pattern" sections.

## 7. Cascade Behavior for Bridge Chapter

Ch 8's cascade profile: 4 clear, 3 confirmed. This is the first run with confirmed cascades since run 004 (Ch 6).

| Direction | Target | Status | Finding |
|-----------|--------|--------|---------|
| Backward | Ch 5 (architecture) | Clear | Multi-model agreement and structured arbitration delivered as claimed |
| Backward | Ch 5 (cost) | Confirmed | $100 vs $15 cost discrepancy |
| Backward | Ch 1 (evaluation trap) | Clear | Inversion characterization is accurate |
| Forward | Ch 9 (bridge) | Clear | SFV framework delivered as promised |
| Cross | Ch 7 (NIST) | Clear | Different aspects of NIST cited, both accurate |
| Cross | Ch 7 (chen_2026_sweci) | Confirmed | Ch 8 adds "18 models" not present in Ch 7 or bib |
| Cross | Ch 2 (question count) | Confirmed | 7,000 vs 6,954 — known issue |

**Bridge position assessment:** Ch 8 bridges construction chapters (5-7) and validity chapters (9-10). Its backward cascades to Ch 5 are structural (does the architecture deliver what the evaluation chapter claims?) while its forward cascade to Ch 9 is a promise (does the next chapter deliver what this one promises?). Both directions verified clean for structural claims. The confirmed issues are all factual consistency (numbers/costs), not structural mismatches. This is the healthiest cascade pattern: architecture is sound, details need cleanup.

## 8. Comparison Table: Runs 002-006

| Dimension | Run 002 (Ch 4) | Run 003 (Ch 5) | Run 004 (Ch 6) | Run 005 (Ch 7) | Run 006 (Ch 8) |
|-----------|----------------|----------------|----------------|----------------|----------------|
| **Type** | Domain | Pattern | Eng/Construction | Eng/Defensive | Methodology/Framework |
| **Tier 1 findings** | 6 gaps, 1 term | 4 med, 14 low | 1 high, 1 med, 18 low | 1 high, 15 low | 2 high, 1 med, 2 low |
| **Citations present** | 2/48 | 14/58 | 4/42 | 3/38 | 12/52 |
| **Citation density** | 4.2% | 24.1% | 9.5% | 7.9% | 23.1% |
| **Practitioner fully** | 0/9 | ~3/10 est. | 5/10 | 5/10 | 5/10 |
| **Practitioner partial** | 0/9 | ~5/10 est. | 4/10 | 4/10 | 5/10 |
| **Practitioner not** | 9/9 | ~2/10 est. | 1/10 | 1/10 | 0/10 |
| **Bloom ceiling** | Create | Create | Create | Evaluate | Evaluate |
| **Bloom floor** | Apply (met) | Apply (met) | Understand (dip) | Apply (clean) | Understand (dip) |
| **Bloom scaffolding** | Non-monotonic | Non-monotonic | Non-monotonic (dip) | Monotonic (first) | Non-monotonic (valley) |
| **Visual figures** | 0 (1 ref) | 0 | 0 | 2 (added post-run) | 0 |
| **Visual convergence** | 3 lenses | 4 lenses | 4 lenses | 4 lenses | 4 lenses |
| **Synthesis clusters** | 8 | 8 | 7 | 8 | 8 |
| **Max convergence** | 4 | 4 | 4 | 4 | 4 |
| **Cascade total** | 7 | 4 | 9 | 6 | 7 |
| **Cascade confirmed** | Multiple | Multiple | 2 | 0 | 3 |
| **Highest-severity** | Implementation gap | Visual absence | Number inconsistency | Unverifiable claim | Cost discrepancy |

**Key patterns across five runs:**

1. **Visual gap confirmed saturated (5/5 runs).** Ch 7 gained figures between runs, proving the finding leads to action. Ch 8 needs tables urgently.
2. **Practitioner zero-unanswerable is new.** Ch 8 is the first chapter with 0 unanswerable questions. Methodology chapters provide at least partial coverage for every practitioner question because they teach frameworks, not implementations.
3. **Citation density tracks chapter type:** Pattern/methodology chapters (Ch 5: 24.1%, Ch 8: 23.1%) > Construction (Ch 6: 9.5%) > Defensive (Ch 7: 7.9%) > Domain (Ch 4: 4.2%).
4. **Bloom ceiling: Evaluate for methodology chapters, matching defensive chapters (Ch 7).** Create ceiling requires generative thought experiments (Ch 4, 5, 6). Methodology and defensive chapters ask "evaluate what you have" rather than "create something new."
5. **Bloom valley returns.** After Ch 7's monotonic success, Ch 8 has a valley at the Tailored Crosswalk section (Understand in a section that should be Apply/Analyze). Framework operationalization sections need scaffolded exercises to avoid this.
6. **Cost/number discrepancies are the dominant Tier 1 finding type for chapters citing author's own work.** Ch 6: 6,954 vs 6,987. Ch 8: 7,000 vs 6,954 AND $100 vs $15. Self-cited numbers must be internally consistent across all chapters.
7. **Cascade confirmed count correlates with self-citation density.** Ch 7 (sparse citations): 0 confirmed. Ch 8 (heavy self-citation): 3 confirmed. More internal references mean more opportunities for inconsistency.

## 9. Recommendations for `book_chapter` Gate Profile Adjustments

Based on five calibration runs:

**Confirmed effective (stable across 5 runs):**
- Practitioner stress test: most discriminating gate. Produces different signal by chapter type (domain: center gaps; engineering: edge gaps; methodology: implementation-boundary gaps).
- Bloom depth check: correctly identifies valleys and distinguishes chapter-type-appropriate ceilings.
- Cross-chapter cascade verification: caught $100 vs $15 discrepancy that no single-chapter gate would find.
- High-priority verification flags in CC tasks: effectively focus Tier 1 attention.

**New from this run:**
- Methodology chapters need a specific gate check: "Does the framework operationalization section include a scaffolded exercise?" If not, it will stay at Understand regardless of how good the worked examples are.
- Self-citation density above 50% should trigger a specific "internal consistency audit" that cross-checks all numbers, cost figures, and counts across every chapter citing the same source.
- Cost figures should be verified with explicit scope annotations: "this $X covers [scope]." Bare dollar amounts without scope create cross-chapter inconsistency.

**Saturated findings (reduce emphasis in future runs):**
- Visual gap: confirmed book-wide (5/5 runs). Ch 7's figure addition validates the finding leads to action. For future runs: note figure count only, do not devote synthesis cluster analysis unless the chapter has unusual visual needs.
- The 8-cluster cap and 4-convergence max are stable across all 5 runs. These parameters are calibrated.

**Adjustments for remaining chapters:**
- Ch 9 (SFV): expect methodology chapter characteristics. Watch for the Tailored Crosswalk pattern (framework presentation vs scaffolded application).
- Ch 10 (engineering): expect Ch 6/7 pattern. Watch for Apply floor.
- Ch 11-14 (operational): new chapter type. May need gate profile recalibration.
