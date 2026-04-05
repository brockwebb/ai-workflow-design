# AD-020 Calibration Run 004 — Chapter 6

**Date:** 2026-04-03
**Chapter:** Chapter 6: Parallel, Serial, and the Bottleneck
**Type:** book_chapter (third instance)
**Prior runs:** 002 (Ch 4, domain chapter), 003 (Ch 5, pattern chapter)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** Produced the highest-severity finding of any calibration run: the 6,954 vs 6,987 cross-chapter number inconsistency. This finding was flagged in the CC task itself, confirming that the gate catches this class of error. Pike's Rules verification was the most methodical factual check across all runs — five rules checked individually against canonical source. All cross-references verified accurately. Citation density is lower than Ch 5 (4/42 vs 14/58) but the chapter relies more on author engineering experience than external literature, which is appropriate for its content type.

**Tier 2a (Practitioner):** 5 fully answerable, 4 partially, 1 not. This is the strongest practitioner score across the three runs (Ch 4: 0/9 fully, Ch 5: not recorded in same format). The engineering chapter's concrete guidance (parallel vs serial decision, worker count optimization, model swapping as config change) directly answers practitioner questions. The operational gaps (shared API keys, dynamic rate limits, batch sizing) are real but less fundamental than Ch 4's missing implementation guidance.

**Tier 2b (Bloom):** The Apply floor was met and exceeded. Chapter ceiling at Create (thought experiment). Dominant level Apply with peaks at Evaluate (Model Selection) and Analyze (Pike's Rules, Infrastructure Reinvention). The Design for Scale section is the one Bloom dip (Understand in an engineering chapter). The gate correctly identified Pike's Rules as substantive (Analyze) rather than decorative.

**Tier 3 (Secondary):** Visual gap is the dominant finding again. Narrative lens caught the broken bridge promise. Motivation lens confirmed the opening hook and thought experiment are strong. Clarity lens identified the parallel/serial heuristic as exceptionally clear.

## 2. Engineering Chapter Characteristics vs Ch 4 and Ch 5

Engineering chapters (Ch 6) differ from domain chapters (Ch 4) and pattern chapters (Ch 5) in several ways that affect gate performance:

**Practitioner answerability is naturally higher.** Engineering chapters provide "how to build" guidance that directly answers practitioner questions. Domain chapters (Ch 4) and pattern chapters (Ch 5) provide "what to build" and "which pattern to use" guidance, which is one level of abstraction higher and leaves the practitioner with more implementation gaps.

**Citation density is naturally lower.** Engineering guidance draws more on author experience and standard practices (exponential backoff, checkpointing, config-driven architecture) than on academic literature. This is appropriate — you do not cite a paper to justify "use configuration files" — but it means Tier 1 citation gap analysis is less productive on engineering chapters.

**Bloom floor is easier to meet.** Engineering chapters are inherently about application. The Apply floor is natural rather than aspirational. The interesting Bloom question for engineering chapters is whether they push above Apply to Evaluate (tradeoff analysis) and Create (design exercises). Ch 6 does both, with Model Selection at Evaluate and the thought experiment at Create.

## 3. Pike's Rules as Organizing Device — Gate Evaluation

The Pike's Rules section is the most interesting gate test of this calibration run. The question: does it add cognitive depth or is it decorative?

**Bloom assessment: Analyze.** The section requires the reader to map general systems principles to the LLM pipeline domain. The Rule 3 inversion ("Pike says N is usually small; for federal statistics, plan for large N") is the highest-cognitive-demand element. This is genuine analytical work: understanding the original rule, understanding the domain context, and recognizing when to invert the advice.

**Practitioner assessment: partially actionable.** The mappings are conceptually strong but abstract. Rule 1 (profile your pipeline) does not tell the practitioner HOW to profile. Rule 2 (instrument first) does not tell them WHAT to instrument. Concrete examples would ground the mappings.

**Overall verdict: substantive but not fully realized.** Pike's Rules earns its place cognitively but leaves practical value on the table. The gates correctly identified it as above-Apply (the Bloom gate) and as conceptually strong but practically incomplete (the practitioner gate). No single gate would have produced this nuanced assessment. The multi-lens approach is essential for this type of section.

## 4. Visual Gap Persistence (3rd Data Point)

| Run | Chapter | Figures | Type | Visual Severity |
|-----|---------|---------|------|-----------------|
| 002 | Ch 4 | 0 | Domain | High (pipeline architecture) |
| 003 | Ch 5 | 0 | Pattern | High (3 topology diagrams) |
| 004 | Ch 6 | 0 | Engineering | High (parallel architecture, model abstraction) |

Three consecutive zero-figure chapters. This is now a confirmed book-wide pattern, not a per-chapter issue. The visual gap is the most consistently convergent finding across all calibration runs: 4-way convergence in each run (visual, clarity, practitioner, motivation). The book needs a systematic visual design pass, not chapter-by-chapter figure additions.

**Note:** Ch 4's synthesis review did suggest a figure (fig-04-01), and its inclusion in the chapter text (line 109) shows a figure reference that may or may not have a rendered image. The text includes a `{figure}` directive. Ch 2 has fig-02-01 (classification routing). So figures do exist in some chapters. The issue is concentrated in the engineering/pattern chapters (Ch 4 synthesis, Ch 5, Ch 6).

## 5. Bloom Gate on Engineering Content

The Bloom gate on engineering content works well when the floor is set correctly. Setting Apply as the floor for engineering chapters is the right calibration:

- **Below Apply signals a problem.** Design for Scale at Understand level was correctly flagged as the weakest section. Motivational advice without engineering substance is detectable.
- **Evaluate is the target for tradeoff sections.** Model Selection at Evaluate is what makes it the chapter's strongest section.
- **Create via thought experiment is the ceiling.** The three-model-swap scenario is well-constructed for Create level.
- **Analyze via mapping exercises (Pike's Rules) is substantive.** Cross-domain translation is genuine cognitive work.

The Bloom gate would miss a section that provides engineering guidance at Apply level but does so poorly (wrong advice, incomplete guidance). For that, the practitioner gate is needed. The two gates are complementary.

## 6. Cascade Richness at Bridge Position

Ch 6 sits at a bridge position: between the "what to build" chapters (Ch 2-5) and the "how to survive" chapters (Ch 7-8). Its cascade profile reflects this:

| Cascade Direction | Count | Status |
|-------------------|-------|--------|
| Backward (Ch 5 bridge) | 2 | 1 confirmed issue ($15 vs $1,500), 1 clear |
| Forward (Ch 7, 8, 10, 11) | 4 | All clear |
| Cross-cutting (Ch 2, 4, 14) | 3 | 1 confirmed (number inconsistency), 2 clear |

**Total cascades: 9.** This is comparable to Ch 5's cascade richness (also a bridge-position chapter) and higher than Ch 4's. Bridge-position chapters generate more cascades because they both reference prior chapters and promise future delivery. The forward references from Ch 6 were all verified — the chapter's promises are reliable.

The cross-cutting number inconsistency (6,954 vs 6,987) is the only cascade that touches 4+ chapters. This is the highest-impact single finding across all three calibration runs.

## 7. Comparison Table: Runs 002 vs 003 vs 004

| Dimension | Run 002 (Ch 4) | Run 003 (Ch 5) | Run 004 (Ch 6) |
|-----------|----------------|----------------|----------------|
| **Type** | Domain | Pattern | Engineering |
| **Tier 1 findings** | 6 citation gaps, 1 terminology | 4 medium, 14 low | 1 high (number), 1 medium (bridge), 18 low |
| **Citations present** | 2/48 | 14/58 | 4/42 |
| **Practitioner fully** | 0/9 | ~3/10 est. | 5/10 |
| **Practitioner not** | 9/9 | ~2/10 est. | 1/10 |
| **Bloom ceiling** | Create | Create | Create |
| **Bloom floor** | Apply (met) | Apply (met) | Understand (one section dips) |
| **Visual figures** | 0 (1 ref exists) | 0 | 0 |
| **Visual convergence** | 3 lenses | 4 lenses | 4 lenses |
| **Synthesis clusters** | 8 | 8 | 7 |
| **Max convergence** | 4 | 4 | 4 |
| **Cascade issues** | 7 tasks | 4 tasks | 2 confirmed, 5 clear |
| **Highest-severity** | Implementation gap | Visual absence | Number inconsistency |

**Key patterns across runs:**
1. Visual gap is universal (3/3 runs, 4-way convergence each time).
2. Engineering chapters have better practitioner answerability than domain/pattern chapters.
3. Citation density varies by chapter type: pattern > engineering > domain.
4. Bloom Create ceiling is consistent via thought experiments.
5. Cascade richness correlates with bridge position.
6. The number inconsistency is the first finding that demands immediate cross-chapter action.

## 8. Recommendations for book_chapter Gate Profile

Based on three calibration runs, the following adjustments to the book_chapter gate profile:

**Tier 1:**
- Cross-chapter number consistency should be a standard check item, not just caught ad hoc. The CC task included this as a "known discrepancy to flag" which the gate caught, but it should be systematic.
- Pike's Rules-style external source verification should become a standard Tier 1 sub-task: when the chapter paraphrases an external source, verify the paraphrases.
- Citation density expectations should be calibrated by chapter type: pattern chapters (10+), domain chapters (4-8), engineering chapters (3-6).

**Tier 2a:**
- The practitioner stress test is the most discriminating gate across chapter types. Domain chapters (Ch 4) fail dramatically (0/9 fully answerable). Engineering chapters (Ch 6) perform well (5/10). Pattern chapters (Ch 5) are intermediate. This discrimination is the gate's primary value.
- Add a standard question about "what does this chapter NOT cover that the practitioner might expect?" to surface expectation gaps.

**Tier 2b:**
- The Apply floor for engineering chapters is correct. Consider setting an Evaluate floor for "design decision" sections within engineering chapters (Model Selection, Choosing Your Topology in Ch 5).
- Pike's Rules assessment validates that the Bloom gate can evaluate external-framework-as-organizing-device sections. This is a reusable pattern.

**Tier 3:**
- The visual gap finding is saturated after 3 runs. Future runs should note presence/absence but not devote synthesis cluster space to it unless a chapter actually has figures.
- The broken bridge promise is a high-value finding type. Add "bridge promise verification" as a standard Tier 3 narrative lens check.

**Synthesis:**
- The 7-8 cluster range is stable across runs. The cap at 8 is appropriate.
- Max convergence of 4 is consistent. The visual gap reliably produces the highest convergence.
