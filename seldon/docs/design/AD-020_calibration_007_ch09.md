# AD-020 Calibration Run 007 — Chapter 9

**Date:** 2026-04-05
**Chapter:** Chapter 9: State, Drift, and Validity
**Type:** book_chapter (sixth instance)
**Prior runs:** 002 (Ch 4, domain), 003 (Ch 5, pattern), 004 (Ch 6, eng/construction), 005 (Ch 7, eng/defensive), 006 (Ch 8, methodology/framework)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** No question count or cost figure issues — Ch 9 does not cite any numbers from the Concept Mapper, Pragmatics, or crosswalk studies except the Pragmatics pipeline fidelity figures (91.2% vs 74.6% for RAG), which match the bib note for `webb_2026_pragmatics` exactly. This is the cleanest Tier 1 result in the series.

However, a different correctness issue emerges: **the SFV definition is truncated relative to the canonical baseline.** The canonical definition in `SFV_TERMINOLOGY_BASELINE.md` includes the parenthetical "(decisions, terminology, methodology, and intermediate findings)" and the trailing clause "rather than by degraded, distorted, confabulated, or selectively retained versions of that history." Ch 9 drops both. Given that this is the SFV chapter — the one place in this book where the definition must be complete — this is a HIGH-priority correctness finding. The truncation loses specificity that distinguishes SFV from generic "state management."

**The five sub-dimensions (TC, SP, CF, SC, SCoh) are entirely absent.** The canonical SFV framework has two structures: five threats (T1–T5) and five sub-dimensions. Ch 9 covers the threats thoroughly but never mentions the sub-dimensions. This is the most significant structural gap in the chapter. A reader of Ch 9 gets half the SFV framework. The sub-dimensions are what connect SFV to measurement practice — TC maps to how you check terminology, SP maps to how you audit provenance, CF maps to how you evaluate summarization quality. Without them, the threats describe *what goes wrong* but the reader has no vocabulary for *what to check*.

Citation density: 6 citation instances across ~46 content sentences = 13.0%. All 6 are self-citations (100% self-citation rate). Sources: `webb_2026_ai4stats` x3, `webb_2026_pragmatics` x1, `webb_2025_opencensus_mcp` x1, `nist_genai_2024` x1. The NIST citation is external but is used for terminology ("confabulation"), not for substantive claims. **Effective external citation count for substantive claims: 0.**

Word count: ~2,160 words. This is notably short — the shortest chapter audited in the series. For comparison: Ch 4 was the prior shortest at ~3,200 words (estimated from paragraph count). A 2,160-word chapter covering the author's original theoretical contribution raises the question of whether it is sufficiently developed.

**Tier 1 findings summary:**

| Severity | Finding |
|----------|---------|
| HIGH | SFV definition truncated vs canonical baseline — missing parenthetical and trailing clause |
| HIGH | Five sub-dimensions (TC, SP, CF, SC, SCoh) completely absent |
| HIGH | Chapter is ~2,160 words — substantially underdeveloped for the book's central theoretical contribution |
| MEDIUM | 100% self-citation rate with 0 substantive external citations |
| LOW | "Stochastic tax" attributed to Ch 1 without citation — verify this term is actually established there |

**Tier 2a (Practitioner):** Ten practitioner stress-test questions:

1. "How do I detect semantic drift in my pipeline?" — Partially answered. Config-driven architecture mentioned as countermeasure, golden test set mentioned. No detection methodology (e.g., terminology tracking, automated vocabulary audits).
2. "What does a false state injection look like in practice?" — Answered well. The "personality problem" example from MCP lessons learned is concrete and recognizable.
3. "How do I set up context window monitoring?" — Not answered. Compression distortion (T3) is described but no monitoring approach is offered.
4. "How do I test whether a state supersession actually took effect?" — Not answered. T4 is described but countermeasure is only "use config files."
5. "What should my handoff document contain to prevent T5?" — Partially answered. Points to Ch 7 for handoff documents, but does not specify SFV-specific content requirements.
6. "How do I measure pipeline fidelity?" — Partially answered. The Pragmatics 91.2% figure is stated but the measurement methodology is not described. How was "pipeline fidelity" operationalized?
7. "When should I use deterministic retrieval vs embedding search?" — Answered well. The decision framework is clear: use deterministic when you can, stochastic only when you must.
8. "How do I handle model version changes without losing validity?" — Partially answered. "Version your model selections, record rationale, schedule re-evaluation" is correct but generic.
9. "How do I audit accumulated state for coherence?" — Not answered. State Coherence (SCoh) is not mentioned.
10. "What is the relationship between SFV and TSE?" — Not answered. Mentioned as existing in ai4stats Ch 20 but not explained. Practitioner must buy/read another book.

**Score: 2 fully answerable, 5 partially, 3 not answerable.**

This is the worst practitioner score since Ch 4 (0/0/9). The pattern is different from Ch 4 though — Ch 4 had no implementation at all. Ch 9 has a strong conceptual framework but the implementation guidance is thin. The threats are well-described (what goes wrong) but the countermeasures are almost entirely backward-pointing ("Chapter 7 already addressed this"). The chapter tells you what to worry about but not what to do about it beyond what you already learned.

**Tier 2b (Bloom):**

| Section | Bloom Level | Notes |
|---------|-------------|-------|
| The Instrument That Changes Itself | Understand | Strong metaphor, no application |
| State Fidelity Validity (definition) | Remember | Definitional, no scaffolding |
| The Five Threats (T1–T5) | Understand | Each well-described with examples, no application exercise |
| Where Prior Chapters Were Already Fighting | Analyze | Best section — reader maps prior knowledge to new framework |
| Deterministic Retrieval | Apply | Clear decision principle with concrete design guidance |
| Training Cutoff as Validity Boundary | Understand | Descriptive, no application |
| Model Selection Drift | Understand | Good description, generic countermeasure |
| Thought Experiment | Evaluate | Strong — reader must diagnose, trace, and judge |

**Bloom ceiling: Evaluate** (thought experiment). **Bloom floor: Remember** (SFV definition section). **Scaffolding: Non-monotonic with an early valley.** The SFV definition sits at Remember, then the threats climb to Understand, then "Where Prior Chapters Were Already Fighting" hits Analyze, deterministic retrieval reaches Apply, then it drops back to Understand for training cutoff and model selection, before the thought experiment reaches Evaluate. The early sections (definition, threats) are the weakest cognitively — the reader is told things, not asked to do things.

**KEY FINDING: The chapter's central content (SFV definition + five threats) sits at Remember/Understand — the lowest cognitive levels.** The strongest cognitive engagement happens in sections that reference OTHER chapters' content (the "already fighting" section) or present a single case study (deterministic retrieval). The SFV framework itself is presented entirely as exposition. This is the methodology chapter pattern identified in run 006 (Ch 8): framework operationalization stays at Understand without scaffolded exercises. But here it is worse — Ch 8 at least had worked examples of the crosswalk. Ch 9 has no worked examples of SFV assessment at all.

**Tier 3 (Secondary):** Zero figures. For the sixth time in seven runs, no visual content. The five threats and their relationship to prior-chapter countermeasures are an obvious candidate for a threat-countermeasure mapping table or matrix. The sub-dimensions (if added) would benefit from a table showing dimension → what to check → which threat it detects. The "instrument = weights + context" concept would benefit from a diagram. Visual severity: HIGH.

Narrative tension: The opening hook ("the instrument that changes itself") is strong and sustains through the five threats. Tension dissipates in the "Where Prior Chapters" section, which reads as a retrospective catalog rather than new insight. The training cutoff and model selection sections feel appended — related but structurally disconnected from the SFV framework. They are T4 examples but are presented as separate topics rather than as T4 case studies.

---

## 2. Theoretical Framework Chapter Characteristics

Ch 9 is the first *theoretical framework* chapter audited — distinct from Ch 8's methodology/framework type. Ch 8 operationalized someone else's framework (NIST + FCSM via crosswalk). Ch 9 presents the author's *original* theoretical contribution. This is a different beast.

**The authorial chapter problem:** When the chapter IS the framework (not an application of someone else's), there is no external authority to lean on. Ch 8 could point to NIST and FCSM as validation. Ch 9 has only the author's prior book. This makes the 100% self-citation rate structural, not a bias issue — but it also means the chapter's persuasive force depends entirely on the quality of its argumentation and examples, with no external buttressing.

**What external literature exists and is missing:** SFV is original, but the problems it names are not. Concept drift is a well-established ML concept (Widmer & Kubat, 1996; Gama et al., 2014). Provenance tracking has a literature (Simmhan et al., 2005; Buneman et al., 2001). Measurement validity in survey methodology has decades of work (Groves et al., 2009). The chapter makes no connection to any of this. The "instrument that changes itself" framing would be strengthened by acknowledging that concept drift in ML is a known phenomenon and that SFV extends this to the full pipeline state, not just model predictions.

**The "precondition" claim needs more support.** The chapter asserts SFV is a precondition for construct, internal, external, and statistical conclusion validity. This is a strong claim. It is stated as self-evident rather than argued. A sentence or two explaining *why* — if the operative history is wrong, you cannot know whether you measured the right construct (construct validity), whether your causal inferences hold (internal validity), etc. — would make this claim defensible rather than merely asserted.

---

## 3. Self-Citation Density Assessment

| Source | Count | Usage Pattern |
|--------|-------|---------------|
| webb_2026_ai4stats | 3 | Framework definition, canonical terminology, formal treatment reference |
| webb_2026_pragmatics | 1 | Case study — pipeline fidelity evidence |
| webb_2025_opencensus_mcp | 1 | Case study — personality problem as T2 variant |
| nist_genai_2024 | 1 | Terminology authority — "confabulation" not "hallucination" |

**Assessment:** 100% self-citation rate (5 of 6 instances to author's own work; the 6th is NIST for terminology). This is the highest in the series, surpassing Ch 8's 77%. It is also the most structurally justified: the chapter IS the author's framework, and external literature on SFV does not exist because SFV is original. However, external literature on the *constituent problems* (concept drift, provenance, measurement validity) does exist and would strengthen the chapter's positioning. The absence of any external empirical evidence — even a single study documenting state degradation in an LLM pipeline — leaves the framework entirely self-referential.

**Structural risk:** A chapter that introduces an original theoretical framework with zero external validation is vulnerable to the criticism that it is a naming exercise, not a contribution. The framework IS a contribution (it connects disparate failure modes under a unified validity lens), but the chapter does not demonstrate this persuasively because it never shows the framework illuminating something that the existing vocabulary could not.

---

## 4. Visual Gap Persistence (6th Data Point)

| Run | Chapter | Figures | Type | Visual Severity |
|-----|---------|---------|------|-----------------|
| 002 | Ch 4 | 0 | Domain | High |
| 003 | Ch 5 | 0 | Pattern | High |
| 004 | Ch 6 | 0 | Engineering/Construction | High |
| 005 | Ch 7 | 2 | Engineering/Defensive | Medium |
| 006 | Ch 8 | 0 | Methodology/Framework | High |
| 007 | Ch 9 | 0 | Theoretical/Framework | High |

Pattern holds. 5 of 6 runs at High visual severity. Ch 9's visual needs: (1) threat-countermeasure matrix table, (2) sub-dimension table (if added), (3) "instrument = weights + context" concept diagram, (4) possibly a state degradation timeline showing how threats compound across sessions.

---

## 5. Chapter Length and Development Assessment

At ~2,160 words, Ch 9 is the book's central theoretical contribution presented at roughly the length of a long blog post. For context:

- Ch 8 (methodology, operationalizing someone else's framework): significantly longer
- Ch 7 (defensive engineering): significantly longer
- The SFV Terminology Baseline document alone is ~800 words of definitions

The chapter has the right sections but each is thin. T1–T5 each get one paragraph of description and one paragraph of elaboration. The "Where Prior Chapters" section is a catalog of one-sentence mappings. The Pragmatics case study is one paragraph. The training cutoff section is two paragraphs.

**This chapter reads like an outline that was fleshed out to first-draft level but not developed.** The conceptual architecture is sound. The content is correct. But it is not yet a chapter — it is the skeleton of a chapter. For the book's original contribution, this needs substantially more development: worked examples, the sub-dimensions, external literature connections, and implementation guidance.

---

## 6. Cascade Behavior

| Direction | Target | Status | Finding |
|-----------|--------|--------|---------|
| Backward | Ch 8 (bridge) | Clear | Ch 8 promises "state, drift, and the validity framework" — Ch 9 delivers exactly this |
| Backward | Ch 7 (thought experiment) | Clear | Ch 9 answers Ch 7's "30% classification shift" thought experiment as promised |
| Backward | Ch 7 (config, testing, checkpoint) | Clear | Countermeasure references are accurate to Ch 7 content |
| Backward | Ch 5 (ensemble patterns) | Clear | Multi-model disagreement as T2 countermeasure is accurate |
| Backward | Ch 6 (design for change) | Clear | Swap-ready interfaces as T4 countermeasure is accurate |
| Backward | Ch 1 (stochastic tax) | **Verify** | "Stochastic tax" attributed to Ch 1 — needs verification that this term is established there |
| Forward | Ch 10 (bridge) | Clear | Promises "state management and research provenance" — appropriate bridge |
| Cross | ai4stats Ch 20 | **Gap** | Defers TSE relationship entirely to other book — reader of this book gets no explanation |

**Bridge position assessment:** Ch 9 sits between construction/evaluation chapters (5–8) and infrastructure chapters (10+). Its backward cascades are all clean — the countermeasure references to prior chapters are accurate. The forward bridge to Ch 10 is appropriate. The gap is lateral: the relationship to classical validity theory (TSE, construct validity) is fully deferred to another book. A reader who has not read ai4stats gets the threats and countermeasures but not the theoretical positioning.

---

## 7. Comparison Table: Runs 002–007

| Dimension | Run 002 (Ch 4) | Run 003 (Ch 5) | Run 004 (Ch 6) | Run 005 (Ch 7) | Run 006 (Ch 8) | Run 007 (Ch 9) |
|-----------|----------------|----------------|----------------|----------------|----------------|----------------|
| **Type** | Domain | Pattern | Eng/Construction | Eng/Defensive | Methodology | Theoretical |
| **Word count** | ~3,200 est. | — | — | — | — | ~2,160 |
| **Tier 1 findings** | 6 gaps, 1 term | 4 med, 14 low | 1 high, 1 med, 18 low | 1 high, 15 low | 2 high, 1 med, 2 low | 2 high, 1 high (length), 1 med, 1 low |
| **Citations present** | 2/48 | 14/58 | 4/42 | 3/38 | 12/52 | 6/46 |
| **Citation density** | 4.2% | 24.1% | 9.5% | 7.9% | 23.1% | 13.0% |
| **Self-citation %** | — | — | — | — | 77% | 100% |
| **Practitioner fully** | 0/9 | ~3/10 | 5/10 | 5/10 | 5/10 | 2/10 |
| **Practitioner partial** | 0/9 | ~5/10 | 4/10 | 4/10 | 5/10 | 5/10 |
| **Practitioner not** | 9/9 | ~2/10 | 1/10 | 1/10 | 0/10 | 3/10 |
| **Bloom ceiling** | Create | Create | Create | Evaluate | Evaluate | Evaluate |
| **Bloom floor** | Apply | Apply | Understand | Apply | Understand | Remember |
| **Bloom scaffolding** | Non-monotonic | Non-monotonic | Non-monotonic | Monotonic | Non-monotonic | Non-monotonic |
| **Visual figures** | 0 | 0 | 0 | 2 | 0 | 0 |
| **Cascade confirmed** | Multiple | Multiple | 2 | 0 | 3 | 0 (1 verify) |

**Key patterns updated with 6 data points:**

1. **Ch 9 is an outlier on practitioner score.** 2/5/3 is worse than any chapter since Ch 4. The theoretical chapter type has a structural gap: it names problems but does not scaffold solutions. This is different from Ch 4's "no implementation" gap — Ch 9 has solutions (they are in prior chapters) but does not integrate them into actionable guidance within SFV's own framework.

2. **Bloom floor hit Remember for the first time.** All prior runs had Apply or Understand as the floor. Ch 9's definitional section sits at Remember — the reader is told a definition and asked to retain it. This is the weakest cognitive engagement in the series.

3. **100% self-citation is a new data point.** The series now has: Domain (low external), Pattern (high mixed), Engineering (moderate external), Methodology (high self), Theoretical (100% self). The pattern: chapters presenting the author's own work trend toward higher self-citation, which is structurally expected but creates a vulnerability.

4. **Chapter length matters.** At ~2,160 words, Ch 9 is attempting to do too much in too little space: introduce an original framework, present five threats with examples, map countermeasures to prior chapters, present a case study, cover training cutoff validity, cover model selection drift, and bridge to Ch 10. Something has to give, and what gave was depth at every section.

---

## 8. Recommendations for CC Task

### HIGH priority (blocking)

1. **Restore full canonical SFV definition.** Add back the parenthetical "(decisions, terminology, methodology, and intermediate findings)" and trailing clause. This is the SFV chapter — the definition must match `SFV_TERMINOLOGY_BASELINE.md` exactly.

2. **Add the five sub-dimensions (TC, SP, CF, SC, SCoh).** These are canonical SFV components. Their absence means the reader gets threats (what goes wrong) but not dimensions (what to measure/check). A new section after the five threats, or integrated into the threats section, mapping each sub-dimension to its related threats and to concrete checks.

3. **Develop the chapter substantially.** Target: at least double the word count (~4,500 words minimum). Specific areas needing expansion:
   - Each threat needs a worked example beyond the current single-paragraph illustration. Ideally a case study from the Concept Mapper or Pragmatics work showing the threat manifesting in practice.
   - The "Where Prior Chapters" section needs to be more than a catalog — each mapping should explain *how* the countermeasure works against the threat, not just assert that it does.
   - The Pragmatics case study section needs to explain how pipeline fidelity was measured, not just state the number.
   - Add at least one more reflection prompt. Currently there is only one, at the end of the threats section.

### MEDIUM priority

4. **Add external literature connections.** At minimum: concept drift (Widmer & Kubat 1996 or Gama et al. 2014), provenance in scientific workflows (Simmhan et al. 2005 or equivalent), measurement validity in survey methodology (Groves et al. 2009). These position SFV as extending existing concepts rather than inventing from whole cloth. Perplexity verification required before citing.

5. **Verify "stochastic tax" is established in Ch 1.** If it is, add proper cross-reference. If it is not, either establish it there or remove the attribution.

6. **Restructure training cutoff and model selection sections as T4 case studies.** Currently they feel appended. They are both instances of State Supersession Failure. Presenting them as T4 case studies rather than standalone sections would tighten the chapter's structure and reinforce the framework.

### LOW priority

7. **Add a brief TSE positioning paragraph.** The full treatment is in ai4stats, but a reader of this book deserves 2–3 sentences explaining *why* SFV is a precondition for other validity types, not just the assertion that it is.

8. **Consider a scaffolded SFV assessment exercise.** Following the Ch 8 (run 006) recommendation: methodology/framework chapters need an exercise where the reader applies the framework to their own pipeline. A template or worksheet: "For each threat, describe how it could manifest in your pipeline. For each sub-dimension, identify your current monitoring approach (if any)."

---

## 9. Perplexity Verification Tasks

If external citations are added per recommendation #4, the following need dual-path verification:

- Widmer & Kubat (1996) — concept drift foundational paper
- Gama et al. (2014) — concept drift survey
- Simmhan et al. (2005) — provenance in scientific workflows
- Groves et al. (2009) — Survey Methodology (measurement validity)

These are well-established references unlikely to have verification issues, but the dual-path protocol applies regardless.

---

## 10. Pipeline Run vs. Pre-Audit Reconciliation

**Pre-audit:** Written by desktop session before this CC task was created.
**Pipeline run:** Full AD-020 execution (Tiers 1–3, synthesis, cascade checks) by Claude Code.

### Agreement

| Finding | Pre-audit | Pipeline | Verdict |
|---------|-----------|----------|---------|
| SFV definition truncated | HIGH — identified | HIGH — confirmed with exact delta | Agree |
| Five sub-dimensions absent | HIGH — identified | HIGH — all five absent confirmed | Agree |
| Visual gap (zero figures) | HIGH | HIGH | Agree |
| Practitioner score (not answerable) | 3/10 (Q3, Q9, Q4) | 3/10 (Q3, Q8, Q9) | Substantially agree — different Q numbering, same gap pattern |
| Bloom floor | Remember (definition) | Remember (definition) | Agree |
| Bloom ceiling | Evaluate (thought experiment) | Evaluate (thought experiment) | Agree |
| 100% self-citation structural vulnerability | HIGH | HIGH | Agree |
| Retroactive catalog problem in "Where Prior Chapters" | HIGH narrative | HIGH narrative | Agree |
| Training cutoff/model selection as appended sections | MEDIUM | MEDIUM | Agree |
| Reflection prompt density (1 in 2,160 words) | Identified | Confirmed | Agree |
| External literature gap (concept drift, provenance, validity) | Identified | Confirmed | Agree |

### Divergence / Pipeline-Additional Findings

| Finding | Pre-audit | Pipeline | Notes |
|---------|-----------|----------|-------|
| SFV-classical validity crosswalk table absent | Not explicitly flagged as separate finding | Flagged as HIGH structural gap distinct from sub-dimensions | Pipeline surfaced this as a separate cluster (Cluster 1). Pre-audit focused on sub-dimensions; pipeline found the crosswalk table is also absent and equally important. |
| "Personality problem" bib verification | Not flagged | MEDIUM finding — bib note doesn't confirm | Pipeline found that the bib note for webb_2025_opencensus_mcp doesn't explicitly mention "personality problem." Not a pre-audit concern. |
| Golden test set attribution error | Not flagged | MEDIUM cascade finding | Pipeline cascade check found Ch9 attributes golden test set pattern to Ch7 but it is introduced in Ch8. Pre-audit did not check this specific cross-reference. |
| "SFV is a precondition" claim needs citation | Not flagged as citation gap | Flagged as citation_gap | Pipeline applied systematic citation coverage check and flagged this as an uncited key theoretical claim. Pre-audit treated it as a judgment. |
| T3/T5 tension (extending sessions trades one threat for another) | Not flagged | Q9 not answerable | Pipeline identified the T3/T5 tradeoff as an unanswered practitioner question. Pre-audit did not surface this. |

### What the Pipeline Found That Pre-Audit Missed

1. **Golden test set attribution error** (Ch9→Ch7 vs actual Ch8 location) — a specific factual inconsistency requiring correction, not just a conceptual gap
2. **T3/T5 tradeoff gap** — practitioners face this real design tension and the chapter does not address it
3. **Bib note verification for personality problem** — pre-audit accepted the citation; pipeline found the bib note doesn't confirm the term

### What Pre-Audit Found That Pipeline Corroborated at Higher Detail

1. **Practitioner score** — pre-audit scored 3 not-answerable; pipeline independently scored 3 not-answerable on different specific questions. The gap pattern is the same (no audit procedure, no measurement methodology, no T3/T5 tradeoff guidance). Convergence validates the finding.
2. **Development level** — pre-audit called this "first-draft level." Pipeline's synthesis verdict: "revise_before_use." Consistent.
3. **Self-citation structural risk** — pre-audit analyzed this in depth. Pipeline confirmed and added specificity: the problem is not the self-citation rate but the absence of ANY external literature positioning SFV relative to concept drift, provenance, or classical validity theory.

### Meta-finding: Pipeline Value vs. Pre-Audit Value

Pre-audit produced a richer qualitative analysis of structural vulnerabilities and research context (external literature recommendations, comparative chapter-type analysis). Pipeline produced more systematic coverage (every assertion classified, Bloom scores per section, cascade checks against specific text). The two approaches are complementary:

- Pre-audit: "here is what this chapter type needs and why this chapter falls short"
- Pipeline: "here is exactly where each gap appears, with line-level evidence"

The golden test set attribution error is the clearest example of pipeline-specific value: no amount of qualitative analysis would have caught it without reading both Ch7 and Ch8 with the specific cross-reference in mind.

---

## 11. Gate Profile Recommendations (updated with 6 data points)

| Gate | Current Configuration | Recommendation |
|------|----------------------|----------------|
| Canonical baseline comparison | Added for Ch 9 (first instance) | **Make permanent for framework/theory chapters.** Any chapter presenting the author's own framework must be compared against the canonical baseline document. |
| Sub-dimension completeness | Added for Ch 9 | **Generalize: framework chapters must be checked for completeness against their own specification document.** |
| Practitioner unanswerable threshold | No formal threshold | **Flag as high-severity if 3+ of 10 questions are not answerable.** Ch 9 hit this threshold; Ch 4 hit it too. Both were the weakest development levels in the series. |
| Bloom floor check | No floor threshold | **Flag as structural gap if any section sits at Remember for a chapter beyond Chapter 1.** Remember-level content belongs in appendices or glossaries, not chapter sections. |
| Reflection prompt density | No formal check | **Minimum 1 prompt per 700 words of content, or flag.** Ch 9 had 1 per 2,160 words; Ch 8 had 3 per comparable count. The density correlates with Bloom engagement. |
| Self-citation rate | Not tracked | **Add to calibration metrics. Flag >80% for pipeline review, not necessarily for revision.** Structural self-citation (theoretical chapters) is expected; no-external-anchoring is the actual risk. |
| External theoretical anchoring | Not a formal gate | **Add: for framework chapters, require at least 1-2 external citations to established literature in the relevant tradition.** This is a different concern from citation density. |
