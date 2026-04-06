# AD-020 Calibration Run 012 — Chapter 14

**Date:** 2026-04-06
**Chapter:** Chapter 14: Cost & Practicality
**Type:** book_chapter (eleventh and final numbered chapter run)
**Chapter subtype:** economics_and_cost_justification (new type)
**Prior runs:** 002 (Ch 4), 003 (Ch 5), 004 (Ch 6), 005 (Ch 7), 006 (Ch 8), 007 (Ch 9), 008 (Ch 10), 009 (Ch 11), 010 (Ch 12), 011 (Ch 13)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** Zero citations (second consecutive zero-citation chapter). All Concept Mapper numbers verified as first-person author data. Five Type B and two Type C claims identified.

| Severity | Finding |
|---|---|
| HIGH | CA9 broken: Ch 14 capstone quotes 'The first chapter opened with a claim: LLM-powered research workflows require the same architectural discipline that distributed systems have always required.' This text does not appear verbatim in Ch 1. Ch 1 opens with stochastic systems framing, not distributed systems discipline. The quoted text matches the book's CLAUDE.md thesis statement. Attribution error — reader who checks Ch 1 will not find the quote. |
| MEDIUM | Token pricing ratios (10-30x frontier-to-mid, 50-100x frontier-to-small) stated without date hedge or citation. Chapter hedges 'Specific pricing changes constantly' but does not apply this hedge to the ratios themselves. Type B, dateable. |
| MEDIUM | Single-example dependency: Concept Mapper is a batch classification task — the most cost-favorable AI workflow type. Chapter presents its economics as 'typical distribution' without acknowledging scope limitation. Generative, retrieval, and agentic workflows have different cost structures. |
| MEDIUM | Cost justification template missing Year 1 vs. Year 2+ row — the core amortization argument is in the cost comparison table but not in the template practitioners will use to write proposals. |
| MEDIUM | 30 questions/hour analyst rate stated as 'a reasonable estimate' — partial hedge but this figure drives the $24,000 manual equivalent calculation. Should be explicitly marked as author estimate or provide a validation prompt. |
| LOW | $100/hour fully-loaded labor rate stated without citation. Verifiable via OPM pay tables + overhead multiplier. Well-hedged implicitly ('approximately'). |
| RESOLVED | CA11 figure discrepancy from Run 011 ($47/6h vs. $15/~2h): CONFIRMED RESOLVED. Ch 13 revised hook now uses 'less than fifty dollars' / 'single day,' consistent with Ch 14's $15 / ~2 hours. |

**CA11 Resolution note:** Run 011 identified a 3x discrepancy between Ch 13's $47/6-hour hook and Ch 14's $15/~2-hour Concept Mapper figures. The Run 012 cascade check CA11 confirms this has been resolved: Ch 13 now reads 'costs less than fifty dollars, and finishes in a single day,' which is consistent with (and rounds up from) Ch 14's specific figures.

**Cascade checks:** 9 confirmed, 1 confirmed with minor gap (CA2: 'validate cheaply' is Ch 14's framing, not Ch 5's vocabulary), 1 broken (CA9: distributed systems quote).

---

## 2. Standout Findings vs. Prior Runs

**First 5/0/0 persona A score in the series:** Ch 14 is the first chapter to achieve a perfect practitioner score. All five Persona A questions are fully answerable. The single-example design (Concept Mapper) plus the cost taxonomy plus the cost justification template constitute a complete toolkit for a practitioner building a cost comparison. No prior chapter achieved this for any single persona.

**Strongest ARCS profile in the series:** All four ARCS dimensions (Attention, Relevance, Confidence, Satisfaction) score strong. The chapter avoids the learned helplessness risk (Ch 13 borderline), presents costs as manageable, and provides actionable tools. The '$15 hook' is the most effective opening in the late-chapter cluster.

**Broken quote attribution (new category):** Prior broken cascade checks identified broken cross-references (Ch 11: stochastic tax, Ch 13: Feynman frame). Ch 14's CA9 is the first broken attribution where the chapter misquotes its own opening chapter. Ch 1 does not open with the distributed systems discipline claim; Ch 14 says it does. A careful reader will check.

**Single-example dependency check (new gate):** First deployment of this gate. Found a moderate risk: the Concept Mapper is a best-case scenario (batch classification, high volume, structured output). The chapter presents its economics as representative without scope acknowledgment. This gate is useful for any chapter with a single-example-driven argument.

**CA11 resolved:** The only carry-forward item from Run 011's cascade that required author action (figure discrepancy) is confirmed resolved. This is the first inter-chapter consistency fix documented across audit runs.

**Three tables in a 2,800-word chapter:** Ch 14 has the highest table density in the late-chapter cluster (Ch 12-14) relative to word count. Three tables in ~2,800 words (vs. Ch 12's six tables in ~2,855 words). The tables are appropriate for an economics chapter.

---

## 3. Dual Persona Comparison Table

| Persona | Fully | Partial | Not | Top Gap |
|---|---|---|---|---|
| A (Practitioner/Data Scientist) | 5 | 0 | 0 | None — perfect score |
| B (Program Manager/Budget Authority) | 3 | 2 | 0 | Template lacks Year 1/2+ rows; no 'when not to use AI' section |
| **Combined** | **8** | **2** | **0** | Template structure; cost-effectiveness boundary |

**Cross-run comparison of dual persona scores:**

| Run | Chapter | Persona(s) | Combined Fully | Combined Partial | Combined Not |
|---|---|---|---|---|---|
| 010 | Ch 12 | A + B (dual) | 4 | 6 | 0 |
| 011 | Ch 13 | A + B + C (triple, 15 Qs) | 7 | 8 | 0 |
| 012 | Ch 14 | A + B (dual, 10 Qs) | 8 | 2 | 0 |

**Calibration insight:** Ch 14 achieves 8/2/0 on 10 questions, the highest ratio of fully-answerable scores in any multi-persona run. The 5/0/0 Persona A score is a first in the series. The pattern across the late cluster: technical/tools chapters serve practitioners better than governance/institutional chapters; governance chapters serve governance audiences better. Ch 14 follows this pattern: the practitioner is perfectly served, the program manager has two partial gaps (template structure, cost-effectiveness boundaries).

---

## 4. Bloom Comparison Across Chapter Types

| Run | Chapter | Type | Bloom Ceiling | Scaffolding | Tables |
|---|---|---|---|---|---|
| 006 | Ch 8 | methodology/framework | Evaluate | non-monotonic | 0 |
| 007 | Ch 9 | theoretical | Evaluate | non-monotonic | 3 |
| 008 | Ch 10 | infrastructure | Evaluate | non-monotonic | 0 |
| 009 | Ch 11 | framework/landscape | Evaluate | non-monotonic | 1 |
| 010 | Ch 12 | governance/security | Evaluate | flat Apply plateau | 6 |
| 011 | Ch 13 | institutional deployment | **Create** | monotonic ascent | 0 |
| 012 | Ch 14 | economics/cost | Analyze | wave pattern | 3 |

**Ch 14 Bloom observations:**
- Ch 14's Analyze ceiling is appropriate for a practitioner-tools chapter. The cost taxonomy and templates are Apply-level deliverables; the designed/undesigned pipeline contrast and opportunity cost compounding reach Analyze.
- Ch 14 does not reach Ch 13's Create ceiling. The $50K portfolio thought experiment approaches Create but is more scaffolded than Ch 13's governance model design task.
- The wave pattern (Apply plateau → Analyze → Apply → Analyze → Apply/Create) is the first wave pattern in the series. Prior non-monotonic chapters had valleys (drops below Apply); Ch 14 has oscillation between Apply and Analyze without dropping below Apply.
- Three tables enforce Apply-level engagement throughout, consistent with the chapter's toolkit orientation.

**Series Bloom ceiling summary:**
- Chapters 8-12: Evaluate ceiling (consistent)
- Chapter 13: Create ceiling (series peak, first break above Evaluate)
- Chapter 14: Analyze ceiling (appropriate for economics chapter)
- Series pattern: theoretical and methodology chapters reach Evaluate; governance/deployment chapters can reach Create; tools/economics chapters appropriate at Apply-Analyze

---

## 5. Citation Profile Comparison

| Chapter | Total | Self-citations | External | Self % | Profile |
|---|---|---|---|---|---|
| Ch 9 | 4+ | 1 | 3+ | ~25% | balanced |
| Ch 10 | 2 | 2 | 0 | 100% | self-only |
| Ch 11 | 3 | 1 | 2 | 33% | model profile |
| Ch 12 | 4 | 1 | 3 | 25% | balanced |
| Ch 13 | 0 | 0 | 0 | n/a | zero — series outlier |
| **Ch 14** | **0** | **0** | **0** | **n/a** | **zero — second consecutive** |

**Two consecutive zero-citation chapters (Ch 13 and Ch 14) is a new pattern.** The late-book cluster (Ch 11-14) citation profile: 3, 4, 0, 0. The last two chapters of the book cite nothing.

**Distinction between Ch 13's and Ch 14's zero profiles:**
- Ch 13's zero citations are problematic primarily for two Type C empirical claims ('Organizations that have moved to enterprise ATO models report...'; 'Organizations that have implemented dual metrics... report measurably faster...') — these use 'report' language implying documented evidence.
- Ch 14's zero citations are less problematic overall: the chapter rests on first-person case study data (the Concept Mapper) which does not require external citation. The Type B gaps (pricing ratios, analyst rate, labor rate) are concerning but the chapter functions as practitioner wisdom without them.
- Ch 13's zero citations are a credibility vulnerability for the governance audience. Ch 14's zero citations are a dateability vulnerability for the pricing claims.

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
| 011 | Ch 13 | 0 | 0 | critical gap |
| **012** | **Ch 14** | **0** | **3** | **acceptable** |

**Ch 14 visual assessment:** Three tables in an economics chapter is appropriate. The absence of figures is a minor gap, not a critical one. The highest-value figure would be a cost trajectory waterfall (Year 0: development; Year 1: development + inference vs. manual; Year 2+: inference only vs. manual) — directly usable in the leadership presentations Ch 14's 'Making the Case' section targets.

**Series trend:** Visual gaps are the most persistent structural pattern in the audit series. Of 11 chapters:
- 5 have zero figures AND zero tables
- 3 have tables but no figures
- 3 have some combination of both
- No chapter has figures without tables
The book's visual strategy appears to prefer tables over figures throughout. Given the technical content, this is defensible. A book-level figure strategy review would be warranted.

---

## 7. New Gate Assessments

### Single Example Dependency Check
**First deployment.** Ch 14 uses the Federal Survey Concept Mapper as its sole worked example. The gap: the Concept Mapper is batch classification — the most cost-favorable AI workflow type. The chapter presents its cost distribution as 'typical' without acknowledging the scope. Risk: a practitioner building a generative text or agentic workflow will use Ch 14's $15/$3,500 economics as a baseline and produce underestimates.

**Recommendation for security appendix run:** The security appendix will likely not have a single-example dependency issue (security is principles-based, not example-driven). However, if the appendix uses specific security incidents or breach examples, the same gate applies: does the chapter acknowledge the scope limitations of the examples used?

### Redundancy Check
**No problematic redundancies found.** All repetitions in Ch 14 are intentional reinforcements with added content: the inference/development distinction is restated with narrative value in prose after the table states it in structured form; the development cost ($3,500) is restated in the Cost Taxonomy section with hourly breakdown not present in the Counterfactual section. This is a clean result — well-structured teaching reinforcement throughout.

### Capstone Coherence Check
**Connection is earned; attribution is broken.** The capstone successfully connects to the book's opening thesis and provides emotional satisfaction as a book ending. The specific attribution — 'The first chapter opened with a claim' — implies a verbatim quote, and the quoted text does not appear in Ch 1's opening. This is CA9 in the cascade checks. Ch 1 opens with stochastic systems framing; the distributed systems discipline claim is in the book's CLAUDE.md thesis, not Ch 1's opening sentence.

**Quote accuracy verdict:** PARTIAL MISMATCH. The capstone's emotional and rhetorical effectiveness is not undermined, but the attribution creates a navigation failure for careful readers.

### Template Utility Check
**The cost justification template is functional but incomplete.** Missing: Year 1 vs. Year 2+ row (the chapter's core cost insight). Present: all required cost categories, all three major sections (Current Process, Proposed AI Pipeline, Net Impact), the 'Evidence chain' row (the chapter's most important asymmetry insight). A program manager could fill this in and present it; they would benefit from the Year 1/Year 2+ row addition and from example values drawn from the Concept Mapper.

---

## 8. What Worked / What to Adjust for Security Appendix Run

**Worked well:**
- **Dual persona test with A/B taxonomy:** The 5/0/0 (Persona A) / 3/2/0 (Persona B) split is analytically clear. The practitioner/budget authority split maps well to a cost chapter.
- **Single example dependency check (new gate):** Found a genuine medium-risk gap (scope acknowledgment absent). This gate is efficient: two questions (Is the example the only one? Does the chapter acknowledge its scope limitations?) catch the gap in minutes.
- **Redundancy check (new gate):** Clean result (no problematic redundancies) — valuable negative finding. Confirms the author's teaching structure is intentional rather than accumulative.
- **Capstone coherence check (new gate):** Correctly identified the quote attribution mismatch. This is a precise, actionable finding.
- **CA11 resolution confirmation:** Explicitly verifying that the Run 011 issue was resolved is good process hygiene. Adding a 'carry-forward item resolution' step to cascade checks is valuable.

**Adjust for security appendix run:**
- **Audience scope:** The security appendix will likely have a single declared audience (security practitioners). The dual/triple persona format may need modification. Consider whether to run a single-persona deep audit or a dual persona (practitioner + reviewer/auditor).
- **Citation profile expectations:** The security appendix will likely have external citations (OWASP, NIST, NCCoE). The A/B/C claim taxonomy should be applied. Security claims should be held to higher citation standards than experiential wisdom claims.
- **Single example dependency:** If the appendix uses specific agentic security incidents, apply this gate.
- **Template utility:** If the appendix contains security checklists or assessment frameworks, apply the template utility check with the same criteria (completeness, usability, missing structure).
- **Visual gaps:** Security chapters benefit from decision trees and threat models. The 'highest-value figure' question should specifically ask about threat model diagrams.
- **Agentic security content:** The agentic security gap from Ch 12 (Run 010, convergence 4) is the appendix's primary motivation. The cascade check in the appendix should verify that the Ch 12 gap is addressed.

---

## 9. Comparison to Immediately Prior Runs

| Metric | Ch 12 (run-010) | Ch 13 (run-011) | Ch 14 (run-012) |
|---|---|---|---|
| Type | governance/security | institutional deployment | economics/cost |
| Words | ~2,855 | ~2,574 | ~2,800 |
| Citations | 4 | 0 | **0** |
| Self-citation % | 25% | n/a | **n/a** |
| Figures | 0 | 0 | 0 |
| Tables | 6 | 0 | **3** |
| Dual persona score | 4/6/0 (A+B) | 7/8/0 (A+B+C) | **8/2/0 (A+B)** |
| Bloom ceiling | Evaluate | Create | **Analyze** |
| Bloom scaffolding | flat Apply plateau | monotonic ascent | wave pattern |
| Cascade broken | 0 | 1 (Feynman frame) | **1 (distributed systems quote)** |
| Verdict | conditionally_ready | conditionally_ready | conditionally_ready |
| Top finding | agentic security gap (C4) | Feynman attribution + zero citations | **capstone quote attribution (CA9)** |
| New gates introduced | dual audience; regulatory accuracy; agentic gap | adversarial tone; tenet diagnostic value; A/B/C taxonomy; learned helplessness | single example dependency; redundancy check; capstone coherence; template utility |

**Trajectory across Ch 12 → Ch 13 → Ch 14:**
- Citations: 4 → 0 → 0 — the book's final three chapters include 4, 0, 0 citations. The late-book cluster is citation-sparse.
- Persona scores: 4/6/0 → 7/8/0 → 8/2/0 — improving combined scores across runs, with Ch 14 achieving the highest ratio of fully-answerable scores.
- Tables: 6 → 0 → 3 — volatile; chapter-type driven rather than series-normative.
- Broken cascade checks: 0 → 1 → 1 — each of the last two runs has exactly one broken cross-reference or attribution.
- Word count: 2855 → 2574 → 2800 — slight uptick in Ch 14. The compression trend did not continue.

**Ch 14 assessment:** The chapter is the strongest practitioner-tools chapter in the series. Its single-example design is both its greatest strength (complete, specific, auditable case study) and its main gap (scope limitation). The conditionally_ready verdict is appropriate; all five open items are targeted corrections of one to three sentences each. The chapter can ship with minor revisions.

---

## 10. Series Summary — AD-020 Pipeline Performance Across All 11 Book Chapter Runs

*This is the required series summary for the final numbered chapter run. It covers Runs 002-012 (Ch 4-Ch 14).*

### 10.1 Run Record

| Run | Chapter | Verdict | Cascade (Confirmed/Minor/Broken) | New Gates Introduced |
|---|---|---|---|---|
| 002 | Ch 4 | conditionally_ready | — | Content audit, citation taxonomy, basic cascade |
| 003 | Ch 5 | conditionally_ready | — | Practitioner stress test, Bloom depth |
| 004 | Ch 6 | conditionally_ready | — | Secondary sweep, narrative arc |
| 005 | Ch 7 | conditionally_ready | — | Perplexity queries pattern |
| 006 | Ch 8 | conditionally_ready | — | ARCS motivation assessment |
| 007 | Ch 9 | conditionally_ready | — | SFV framework gate |
| 008 | Ch 10 | conditionally_ready | — | Infrastructure chapter subtype |
| 009 | Ch 11 | conditionally_ready | — | Framework/landscape subtype |
| 010 | Ch 12 | conditionally_ready | 5/0/0 | Dual audience; regulatory accuracy; agentic gap; table-as-content-mechanism |
| 011 | Ch 13 | conditionally_ready | 9/2/1 | Adversarial tone; tenet diagnostic value; learned helplessness; A/B/C citation taxonomy |
| 012 | Ch 14 | conditionally_ready | 9/1/1 | Single example dependency; redundancy; capstone coherence; template utility |

**All 11 chapters received conditionally_ready verdicts.** No chapter received 'ready' or 'needs_major_revision.' This is a meaningful signal: the book's draft quality is consistently good enough to conditionally pass but consistently has targeted, resolvable gaps. No chapter was a structural failure; no chapter was clean enough to pass without conditions.

### 10.2 Most Productive Gates Across the Series

**1. Citation sparsity check with A/B/C taxonomy (introduced Run 011):** The most analytically useful Tier 1 framework in the series. Differentiating Type A (experiential wisdom, appropriate without citation), Type B (verifiable assertion, should cite or hedge), and Type C (empirical claim, needs citation or removal) resolves the 'everything without a citation is a citation gap' false positive problem. Prior runs flagged too many items as citation gaps; the A/B/C taxonomy makes the distinction tractable. Should be standard from Run 001 in future projects.

**2. Cascade checks:** Produced the most actionable findings across the series. Three broken checks total (Run 009 Ch 11: stochastic tax attribution; Run 011 Ch 13: Feynman frame; Run 012 Ch 14: distributed systems quote). Each broken check identified a reader navigation failure that would not have been caught by content-only review. The cascade process — actually reading the target chapters and verifying cross-references — is essential.

**3. Dual/triple persona stress test:** Consistently produced differentiated findings and identified the correct gaps. The practitioner/governance audience split correctly predicted which chapters served which audiences. The triple persona format (A+B+C in Run 011) was the most productive variant for a multi-audience governance chapter. For a tools chapter (Ch 14), the dual format (A+B) was sufficient.

**4. Secondary sweep narrative arc:** Found structural weaknesses that content audit missed. The $47 hook in Ch 13 that doesn't pay off within the chapter (C5 in Run 011 synthesis) was a narrative arc finding, not a content audit finding. The capstone coherence check (Run 012) is an evolution of this gate.

**5. Agentic security gap check (introduced Run 010):** Found the most significant content gap in the series — the absence of agentic security content in Ch 12's Five Safes framework. This is the motivation for the security appendix. The gate works by checking what the chapter does NOT cover against the chapter's declared scope. A negative space audit.

### 10.3 Chapter Types That Were Hardest to Audit

**Hardest: Theoretical/framework chapters (Ch 9-10):** These chapters describe author-developed frameworks (SFV, artifact tracking) with minimal external comparators. Evaluating the framework's conceptual completeness required deeper domain knowledge than evaluating factual claims. The pipeline is better calibrated for claim verification than for framework evaluation.

**Second hardest: Multi-audience governance chapters (Ch 12-13):** Ch 12 and Ch 13 have declared multiple audiences. The triple persona format helps but requires more audit work per chapter. The adversarial tone check (new in Run 011) was essential for Ch 13; its absence would have missed the governance section's tone calibration.

**Easiest: Practitioner-tools chapters (Ch 14):** Single audience, single example, clear deliverables (templates, tables, taxonomy). The content audit was straightforward. The practitioner stress test is efficient when the chapter's deliverables map directly to the persona's needs.

### 10.4 What the Pipeline Consistently Finds

**1. Citation gaps in claims about institutional behavior and pricing:** Every chapter that makes claims about federal procurement timelines, AI pricing, or organizational behavior has citation gaps. The pipeline finds these reliably. This is a structural feature of the book (practitioner voice, not academic citation style) and requires a consistent resolution strategy.

**2. Visual gaps:** Persistent across the series. Of 11 chapters, only 3 have figures; most have tables only or nothing. The pipeline consistently finds visual gaps because the gate is explicit and the finding is concrete ('zero figures in a [chapter type] chapter').

**3. Template/framework completeness gaps:** Chapters with practitioner tools (templates, decision frameworks, checklists) consistently have missing elements. Ch 13 had no tables for its frameworks; Ch 14's template was missing the Year 1/Year 2+ row. The pipeline reliably finds these when the template utility or bloom depth checks are applied.

**4. Cross-reference accuracy:** Three broken cascade checks in 11 runs. The pipeline catches broken cross-references when cascade checks are actually executed (i.e., the target chapter is read and the cross-reference is verified). Broken checks are more common than expected — one per ~3-4 runs.

**5. Bloom Apply plateau:** Present in most chapters. The pipeline reliably identifies sections where the chapter delivers prescriptions without scaffolding (Apply) when more analytical engagement is warranted (Analyze or Evaluate). The table-as-content-mechanism discovery (Ch 12) showed that tables are an effective remedy.

### 10.5 What the Pipeline Consistently Misses

**1. Cumulative argument coherence:** Individual chapters are audited in isolation. The pipeline does not check whether the book's cumulative argument is coherent across all 14 chapters. Ch 1 establishes the design discipline thesis; Ch 14's capstone misquotes it — this was caught by CA9, but only because the capstone explicitly invokes Ch 1. Chapters that build implicitly on prior arguments without explicit cross-references are not checked for cumulative coherence.

**2. Voice consistency:** The pipeline does not check whether the chapter's prose voice matches the book's established voice. This is partly by design (the audits focus on content and structure, not style) but voice drift across 14 chapters is a real risk.

**3. Pedagogy at the transition points:** The chapter bridges ('---' sections) are checked in cascade checks but only for promise/delivery accuracy. Whether the bridge choice (what to emphasize in the transition) is optimal for the reader is not assessed.

**4. Depth adequacy for the declared audience:** The pipeline assesses whether the chapter serves its declared personas but not whether the depth level is correct for the book's position (introductory vs. reference vs. practitioner guide). Ch 14 at 2,800 words is appropriate for a book chapter; the same content as a handbook would need 3-4x more detail. The pipeline validates presence and structure, not depth calibration.

**5. Worked example diversity:** The book uses the Federal Survey Concept Mapper as the primary worked example across multiple chapters (Ch 2, Ch 5, Ch 6, Ch 7, Ch 8, Ch 14). The single-example dependency gate (new in Run 012) was only applied to Ch 14. Prior chapters that reference the Concept Mapper should be checked for over-reliance on this single example type (batch classification for survey questions).

### 10.6 Recommendations for Security Appendix Run

**1. Use the full Tier 1-3 pipeline.** The security appendix will have more external citations than the late-book cluster; the A/B/C taxonomy will be essential for evaluating security-specific empirical claims (OWASP taxonomy, NIST CAISI findings, NCCoE guidance).

**2. Define the appendix's audience explicitly before auditing.** The appendix is likely written for a security-aware practitioner. Decide whether to use a dual persona (practitioner + security reviewer) or a single persona with a specialized lens.

**3. Agentic security gap verification (required):** The appendix's primary motivation is the agentic security gap identified in Ch 12 (Run 010). The cascade check CA1 for the security appendix run should explicitly verify that the gap is addressed: does the appendix cover agent invocation control, tool trust levels, agent identity, and runtime boundary enforcement?

**4. Ch 12 bridge consistency check:** The security appendix should be checked against Ch 12's bridge promise and against the agentic security gap finding. If the appendix is positioned as a supplement to Ch 12, the consistency check is a cascade check between Ch 12 and the appendix.

**5. Capstone coherence is not applicable for an appendix.** The capstone coherence gate is a book-ending concern; the appendix does not close the book. Apply a different closing gate: does the appendix bridge back to the main text, or does it stand alone?

**6. Template utility check applies.** If the appendix contains security checklists, threat assessment frameworks, or implementation guidance templates, apply the template utility check. Security frameworks are particularly prone to completeness gaps (missing threat categories, missing remediation paths).

**7. Single example dependency check.** If the appendix uses specific agentic security incidents or case studies, apply the single-example dependency check.

**8. Visual gaps check should include threat model diagrams.** Security chapters benefit from architecture diagrams and threat models. The 'highest-value figure' question for a security appendix should specifically ask: does the appendix include a threat model diagram showing the agentic attack surface?

**9. Citation density expectation.** The security appendix should have the highest citation density in the book (OWASP ASI taxonomy, NCCoE, NIST CAISI, NIST AI RMF). Zero citations would be the most anomalous result possible for a security-focused chapter. Set citation expectations accordingly in the Tier 1 audit.

**10. Gate economy:** The security appendix is not a numbered chapter; some Bloom and ARCS gates may not apply in the same form. Prioritize: cascade checks (especially the Ch 12 gap check), citation sparsity (A/B/C), practitioner stress test (single persona), and template utility. Bloom depth is lower priority for a reference appendix; ARCS is lower priority if the appendix is designed for reference, not narrative engagement.

---

*Series calibration complete. Eleven numbered chapter runs (Ch 4–Ch 14). All conditionally ready. Security appendix run is the next and final AD-020 run.*
