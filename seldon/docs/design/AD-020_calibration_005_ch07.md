# AD-020 Calibration Run 005 — Chapter 7

**Date:** 2026-04-03
**Chapter:** Chapter 7: Checkpoints, Failures, and Recovery
**Type:** book_chapter (fourth instance)
**Prior runs:** 002 (Ch 4, domain chapter), 003 (Ch 5, pattern chapter), 004 (Ch 6, engineering/construction chapter)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** The GPT-5 temperature claim is the run's only HIGH severity finding. The gate correctly identified it via the CC task's high-priority verification flag, confirming that flagged claims receive appropriate scrutiny. All other factual claims verified clean. The chen_2026_sweci citation was verified against references.bib with all numbers matching. The NIST TEVV characterization is accurate but simplified. Cross-references to Ch 6, Ch 9, Ch 10, and Ch 11 are all consistent. The chapter avoids the 6,954/6,987 count inconsistency by not stating the Concept Mapper's total count — this is the first chapter that sidesteps rather than perpetuates a known cross-chapter issue. Citation density (3/38) is the lowest of any audited chapter but appropriate for the content type.

**Tier 2a (Practitioner):** 5 fully answerable, 4 partially, 1 not. Identical distribution to Ch 6's score (5/10 fully). The engineering chapter pattern holds: defensive engineering chapters answer practitioner questions well for their core topics and leave gaps at the edges (corrupted checkpoints, exceeded retry limits, mid-run config changes). The single unanswerable question (runtime estimation) is appropriately out of scope. The main practitioner gap is "what happens when prevention infrastructure itself fails" — the chapter teaches you to build transaction-safe writes but not what to do if the write is corrupted anyway.

**Tier 2b (Bloom):** Apply floor met by all four core sections (config, testing, error classification, checkpoint). Recursive Problem reaches Analyze with empirical grounding from chen_2026_sweci. Thought experiment reaches Evaluate (not Create — this is diagnostic, not generative). Scaffolding is monotonically ascending for the first time in the calibration series: no cognitive valleys. The Evaluate ceiling (vs Ch 6's Create ceiling) is appropriate for a defensive engineering chapter that asks "what works against failures?" rather than "design something new."

**Tier 3 (Secondary):** Visual gap is the dominant finding again (4-way convergence). The Config-Driven Architecture section's structural density (five topics, no subsection headers) was caught by both narrative and clarity lenses. The thought experiment's cross-chapter callback to Ch 9 was the strongest bridge verification of any run.

## 2. Defensive Engineering Chapter Characteristics

Ch 7 is the first "defensive engineering" chapter audited (Ch 6 was "constructive engineering"). Key differences:

**Bloom ceiling is naturally lower.** Defensive chapters peak at Evaluate (judging what works against failure scenarios) rather than Create (designing new systems). Ch 7's thought experiment asks "what would have caught this?" (Evaluate) while Ch 6's asks "design a pipeline for three model swaps" (Create). This ceiling difference is intrinsic, not a quality gap.

**Prescriptive sections dominate.** Error classification and checkpoint architecture are prescriptive: "here is the pattern, apply it." This is appropriate — error handling patterns are not tradeoffs to evaluate, they are standard practices to implement. The prescriptive mode naturally sits at Apply level, which is the chapter's dominant Bloom level.

**Thought experiment undermines chapter sufficiency.** Ch 7's thought experiment is uniquely designed to show that the chapter's own infrastructure is necessary but not sufficient. The silent drift scenario has no answer within Ch 7 alone — it requires Ch 9-10. This is pedagogically strong: it creates motivation for the next chapters without undermining the current one's value. Compare to Ch 6's thought experiment, which is self-contained within Ch 6's design principles.

**Practitioner gaps are at the edges, not the center.** Ch 4 (domain) had practitioner gaps at the center (no implementation guidance). Ch 6 (constructive) had gaps at operational edges (shared API keys). Ch 7 (defensive) has gaps at failure edges (corrupted checkpoints, exceeded retries). The closer a chapter is to operational guidance, the more specific the edge-case gaps become.

## 3. Recursive Stochasticity Section Assessment

The CC task specifically asked for Bloom assessment of the Recursive Problem section. Finding: Analyze level, which is appropriate.

**What it does well:**
- Meta-level recognition: the same patterns solve both runtime and development problems
- Empirical grounding via chen_2026_sweci (75% break rate, EvoScore)
- Correct scoping: "states the problem and its immediate engineering consequences"
- Clean handoff to Ch 11 for full treatment

**What it correctly avoids:**
- Does not attempt to reach Evaluate (would duplicate Ch 11's full treatment)
- Does not prescribe specific development-time protocols (Ch 11's job)
- Does not repeat the SWE-CI numbers at length (brief, accurate summary)

**Cross-chapter verification:** Ch 11's "Recursive Stochasticity: The Full Treatment" explicitly picks up from Ch 7: "Chapter 7 introduced the problem... This section delivers the full treatment." The handoff is verified. Ch 11 re-cites chen_2026_sweci with matching numbers.

## 4. chen_2026_sweci Verification Result

All claims verified against references.bib:
- 100 tasks: matches bib note
- avg 233 days: matches
- 71 commits per task: matches
- 75% of models break previously working code: matches
- EvoScore metric: matches
- arXiv ID 2603.03823: plausible for March 2026
- Sun Yat-sen University and Alibaba Group: matches

The chapter's description of EvoScore ("weights later iterations more heavily, exposes this pattern: initial pass rates look acceptable, but accumulated regressions degrade the codebase over time") is an accurate paraphrase of the bib note ("Introduces EvoScore metric"). The paraphrase adds explanatory context not present in the bib note, which is appropriate for a book chapter.

## 5. Visual Gap Persistence (4th Data Point)

| Run | Chapter | Figures | Type | Visual Severity |
|-----|---------|---------|------|-----------------|
| 002 | Ch 4 | 0 | Domain | High (pipeline architecture) |
| 003 | Ch 5 | 0 | Pattern | High (3 topology diagrams) |
| 004 | Ch 6 | 0 | Engineering/Construction | High (parallel architecture, model abstraction) |
| 005 | Ch 7 | 0 | Engineering/Defensive | Medium (error table, checkpoint diagram) |

Four consecutive zero-figure chapters. Visual severity for Ch 7 is medium rather than high because the chapter's visual-ready content is simpler (a table, a sequence diagram) compared to Ch 5-6's architectural diagrams. The error classification table is the single highest-value visual addition — it would serve as an operational quick-reference during pipeline failures.

**Confirmed pattern:** The visual gap is a book-wide issue, not chapter-specific. No further per-chapter visual gap analysis is needed; the recommendation is a systematic visual design pass across the book.

## 6. Forward-Heavy Cascade Behavior

Ch 7's cascade profile: 2 backward (Ch 6), 4 forward (Ch 9, 10, 11). All 6 verified clean — the first zero-issue cascade result.

**Comparison to Ch 6:** Ch 6 had 9 cascades (3 backward, 4 forward, 2 cross-cutting) with 2 confirmed issues (number inconsistency, broken bridge promise). Ch 7's cleaner cascade profile reflects:
1. Fewer backward references (only Ch 6, not multiple prior chapters)
2. More focused scope (defensive engineering, not broad pipeline architecture)
3. No repeating the Concept Mapper count number (avoids the known cross-chapter issue)
4. Specific forward references that Ch 9-11 explicitly pick up

**Forward reference fulfillment:** Ch 7's forward references are the best-verified of any run. Ch 9 explicitly answers Ch 7's thought experiment. Ch 10 explicitly extends Ch 7's config-driven architecture. Ch 11 explicitly delivers Ch 7's promised full treatment of recursive stochasticity. All three downstream chapters name Ch 7 by chapter number and section.

## 7. Sparse Citation Behavior — Engineering Chapter Pattern

| Chapter | Type | Citations | Assertions | Density |
|---------|------|-----------|------------|---------|
| Ch 4 | Domain | 2 | 48 | 4.2% |
| Ch 5 | Pattern | 14 | 58 | 24.1% |
| Ch 6 | Construction | 4 | 42 | 9.5% |
| Ch 7 | Defensive | 3 | 38 | 7.9% |

Ch 7's 3/38 density (7.9%) is consistent with engineering chapters (Ch 6: 9.5%) and substantially lower than the pattern chapter (Ch 5: 24.1%). The engineering chapter pattern is now established: standard engineering practices (config management, error handling, checkpointing, retry logic) do not require individual citations. The chen_2026_sweci citation in the Recursive Problem section does heavy lifting — it is the sole empirical source for the entire section.

**Citation quality vs quantity:** Ch 7's three citations each serve a distinct purpose: nist_ai_rmf_2023 (framework authority), webb_2026_concept_mapper (case study), chen_2026_sweci (empirical evidence). This is efficient citation usage — no filler citations, no decorative references.

## 8. Comparison Table: Runs 002-005

| Dimension | Run 002 (Ch 4) | Run 003 (Ch 5) | Run 004 (Ch 6) | Run 005 (Ch 7) |
|-----------|----------------|----------------|----------------|----------------|
| **Type** | Domain | Pattern | Eng/Construction | Eng/Defensive |
| **Tier 1 findings** | 6 gaps, 1 term | 4 med, 14 low | 1 high, 1 med, 18 low | 1 high, 15 low |
| **Citations present** | 2/48 | 14/58 | 4/42 | 3/38 |
| **Practitioner fully** | 0/9 | ~3/10 est. | 5/10 | 5/10 |
| **Practitioner not** | 9/9 | ~2/10 est. | 1/10 | 1/10 |
| **Bloom ceiling** | Create | Create | Create | Evaluate |
| **Bloom floor** | Apply (met) | Apply (met) | Understand (dip) | Apply (clean) |
| **Bloom scaffolding** | Non-monotonic | Non-monotonic | Non-monotonic (dip) | Monotonic (first) |
| **Visual figures** | 0 (1 ref) | 0 | 0 | 0 |
| **Visual convergence** | 3 lenses | 4 lenses | 4 lenses | 4 lenses |
| **Synthesis clusters** | 8 | 8 | 7 | 8 |
| **Max convergence** | 4 | 4 | 4 | 4 |
| **Cascade total** | 7 | 4 | 9 | 6 |
| **Cascade issues** | Multiple | Multiple | 2 confirmed | 0 |
| **Highest-severity** | Implementation gap | Visual absence | Number inconsistency | Unverifiable claim |

**Key patterns across four runs:**
1. Visual gap is universal (4/4 runs, 4-way convergence in 3/4). Confirmed saturated.
2. Engineering chapters (Ch 6, 7) have identical practitioner scores (5/10 fully, 1/10 not).
3. Citation density follows chapter type: pattern > construction > defensive > domain.
4. Bloom scaffolding improved: Ch 7 is the first monotonically ascending chapter.
5. Cascade cleanliness improved: Ch 7 is the first zero-issue cascade result.
6. Highest-severity finding type varies by chapter: implementation gap (domain), visual (pattern), number inconsistency (construction), unverifiable claim (defensive).

## 9. Recommendations for AD-020 Gate Profile

Based on four calibration runs:

**Confirmed effective:**
- Practitioner stress test remains the most discriminating gate across chapter types
- Bloom floor at Apply for engineering chapters: correctly identifies both meets (Ch 7) and violations (Ch 6 Design for Scale)
- Cross-chapter cascade verification: caught the Ch 6 number inconsistency and bridge promise, verified Ch 7's clean handoffs
- High-priority verification flags in CC tasks: effectively focus Tier 1 attention

**New from this run:**
- Defensive engineering chapters have an Evaluate ceiling (not Create). This is intrinsic and should not be flagged as a deficiency.
- Thought experiments that undermine chapter sufficiency (Ch 7's "none of the above is enough") are a distinct and valuable design pattern — the Bloom gate should recognize this as pedagogically strong, not as a gap.
- The "when prevention infrastructure fails" practitioner gap is specific to defensive chapters. Add as a standard practitioner question for defensive/resilience chapters.
- First monotonic Bloom scaffolding: validates that the scaffolding check has been useful in prior runs (identified Ch 6's dip, which was then absent in Ch 7).

**Saturated findings (reduce emphasis in future runs):**
- Visual gap: confirmed book-wide. Note presence/absence, do not devote synthesis cluster analysis.
- Sparse citations in engineering chapters: confirmed pattern. Flag only if density drops below Ch 7's 3/38 baseline.
