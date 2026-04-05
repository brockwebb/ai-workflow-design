# AD-020 Calibration Run 008 — Chapter 10

**Date:** 2026-04-05
**Chapter:** Chapter 10: State Management & Research Provenance
**Type:** book_chapter (seventh instance)
**Chapter subtype:** practitioner_infrastructure_guide
**Prior runs:** 002 (Ch 4, domain), 003 (Ch 5, pattern), 004 (Ch 6, eng/construction), 005 (Ch 7, eng/defensive), 006 (Ch 8, methodology/framework), 007 (Ch 9, theoretical framework)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** Ch 10 is cleaner than Ch 9 by a significant margin. No question count or cost figure conflicts with other chapters (verified — neither 6,954/7,000 nor the $15/$100 figures appear). The one number present (the $100 Concept Mapper figure) appears in Ch 6, not Ch 10. Cross-reference claims all verify:

- Ch 9 "instrument changes during use, and the changes are silent" — CONFIRMED in revised Ch 9
- Ch 7 "save the random seed" / config-driven architecture — CONFIRMED in content audit verification record
- Ch 1 Shapiro Level 2/3 — CONFIRMED consistent (description from a different angle, not contradiction)

Three Tier 1 issues identified:

| Severity | Finding |
|---|---|
| MEDIUM | DOORS full name ("Dynamic Object-Oriented Requirements System") uncited — needs verification or source |
| MEDIUM | Concept Mapper "days of reconstruction" claim cited to webb_2026_concept_mapper but is author experience, not a finding in that paper |
| LOW | Abandoned project claim has no citation and is not framed as author experience |

No false number citations, no factual contradictions with other chapters. This is the cleanest Tier 1 in the series after Ch 6.

**Canonical baseline gate (new gate added Run 007):** Not applicable. Ch 10 is an infrastructure/pattern chapter, not a theoretical framework chapter. No framework baseline to compare against.

**Tutorial vs. pattern gate (added Run 005 for infrastructure chapters):** PASSES. The chapter frames patterns over implementations consistently. The Graph-of-Artifacts section explicitly states "The pattern matters more than the implementation." Domain Configuration section confirms the pattern is domain-agnostic. Seldon is the worked example but is never named as the only implementation path. One tension: the dual-layer architecture is described at enough specificity that it implies a particular implementation, but the separation of event log from graph database is a genuine architectural pattern, not Seldon-specific. PASSES with minor tension.

**Citation density:** 2 citation instances across ~47 content sentences = 4.3%. Both are self-citations (shapiro_2026 and webb_2026_concept_mapper). **External citations: 0.** This is the second instance of 0% substantive external citations (after Ch 9). For a chapter making historical claims (DOORS) and architectural assertions, this is lower than expected.

**Word count:** ~3,146 words. The longest book_chapter run in the series. Density is good — more content per word than some shorter chapters.

---

**Tier 2a (Practitioner):** Ten practitioner stress-test questions scored 0 fully answerable, 9 partially answerable, 1 not answerable.

**Score: 0/10 fully, 9/10 partial, 1/10 not.**

Compared to prior runs:

| Run | Chapter | Full | Partial | Not |
|---|---|---|---|---|
| 002 | Ch 4 | 0 | 0 | 9 |
| 003 | Ch 5 | ~3 | ~5 | ~2 |
| 004 | Ch 6 | — | — | — |
| 005 | Ch 7 | — | — | — |
| 006 | Ch 8 | — | — | — |
| 007 | Ch 9 | 2 | 5 | 3 |
| 008 | Ch 10 | 0 | 9 | 1 |

Ch 10's score pattern differs from Ch 9: Ch 9 had genuine not-answerable questions (the missing sub-dimensions made several questions unanswerable). Ch 10 has 9 partial answers — the chapter orients on every question but never fully resolves any of them. This is the "orientation without action" failure mode: the chapter tells practitioners what a provenance system needs to do, but not how to build one or where to start. The top implementation gaps:

1. **No minimum viable implementation sequence.** Which of the eight requirements do you implement first? The chapter provides no sequencing.
2. **No domain-specific artifact taxonomy for LLM pipelines.** The provenance chain example uses PaperSection/Result/Script/DataFile (academic paper artifacts), not PromptConfig/ModelVersion/ClassificationBatch/ArbitrationDecision (pipeline artifacts).
3. **No example configuration file.** The YAML schema description names four fields (artifact types, relationship types, state machines, required properties) but provides no example structure.

This is the defining characteristic of the chapter type: infrastructure guides that describe patterns without implementation examples. The chapter is pattern-correct but practitioners need a landing zone.

---

**Tier 2b (Bloom):**

| Section | Bloom Level | Notes |
|---|---|---|
| Defensible by Design | Understand | Strong hook, no cognitive task |
| Three Reasons Provenance Is Not Optional | Understand | Explanatory, motivational |
| Eight Requirements | Remember/Understand | Listed and explained, no application exercise |
| Why Git Alone Does Not Satisfy Them | Analyze | Comparative analysis — four specific gaps |
| DOORS Lesson | Understand/Analyze | Historical case with analytical framing |
| AI Partners Change the Cost Equation | Apply (RP4) | Reflection prompt invites application |
| Configuration Control as a Design Pattern | Understand | Pattern described, no exercise |
| Graph-of-Artifacts — Problem Section | Apply (RP implicit) | Five failure modes recognizable from practice |
| Dual-Layer Architecture | Analyze | Design decision justified |
| Provenance Chains in Practice | Apply (RP3) | Reflection prompt drives Apply |
| Domain Configuration | Understand | Pattern described |
| Shared Vocabulary as Infrastructure | Understand | Pattern described |
| The Authority Model | Understand | Pattern described |
| Thought Experiment | Evaluate | Best thought experiment in the book |

**Bloom ceiling: Evaluate** (thought experiment). **Bloom floor: Remember** (eight requirements list).

**Bloom scaffolding verdict: BETTER THAN CH 9.** Ch 9 had a Remember floor for its central content. Ch 10's Remember floor is the requirements list, which is a design choice (requirements should be memorable and reference-scannable). The Analyze sections (Git comparison, dual-layer justification) appear mid-chapter rather than only at the end. Four reflection prompts (vs. Ch 9's 1) distribute Apply-level engagement throughout. The thought experiment is the strongest in the series.

**Framework exercise check (carried from Run 006):** Not applicable — Ch 10 is not a framework chapter.

---

**Tier 3 (Secondary):**

- **Visual gap: ZERO FIGURES.** Sixth of seven book_chapter runs with no visual content. Ch 10 has the most diagram-obvious content in the series: dual-layer architecture, provenance chain graph, staleness propagation. The minimum figure set (dual-layer architecture + provenance chain) is clear and needed.

- **Narrative:** Opening hook (IG audit scenario) is the strongest in the book after Ch 8's opening. Three-reasons structure is efficient. DOORS-to-AI transition is clean conceptually but the two sections lack a bridge sentence.

- **Clarity:** Four technical terms used without definition for the stated audience: append-only, projection, JSONL, CDN. Each is fixable in one sentence inline.

- **Experiential claims framing:** Two claims in the Concept Mapper paragraph read as documented findings when they are author experience. This is the same pattern as Ch 9's "personality problem" issue — authorial observations presented without framing.

- **Knowledge graph gap:** Ch 6 and Ch 9 both forward-reference Ch 10 for KG implementation guidance. Ch 10 implements graph-shaped state but does not address the semantic retrieval / knowledge graph dimension. This is the single highest-priority structural gap in the chapter (Seldon task c344d858).

---

## 2. Chapter Type Profile: Practitioner Infrastructure Guide

Ch 10 is the second infrastructure guide in the series (after Ch 6 in Run 004). Key differences from Ch 6:

**Ch 6 strengths Ch 10 lacks:**
- Ch 6 had three figures. Ch 10 has zero.
- Ch 6 provided concrete numbers (6 workers, 10-question checkpoint interval, exponential backoff 1/2/4/8/16s). Ch 10 has no concrete implementation parameters.

**Ch 10 strengths Ch 6 lacked:**
- Thought experiment quality: Ch 10's IG audit scenario is better than Ch 6's model swap thought experiment.
- Eight requirements: a more systematic framework than Ch 6's design properties.
- The "why" is stronger: three distinct reasons provenance is not optional vs. Ch 6's implicit assumption that parallelization is desirable.

**Infrastructure guide pattern finding:** Both Ch 6 and Ch 10 suffer from the "pattern without path" problem — correct design principles, insufficient implementation specificity. Ch 6's worked example (Concept Mapper) provides some grounding; Ch 10's worked example (Seldon) is present but abstracted to the point where it provides little implementation guidance.

---

## 3. Cross-Run Comparisons

### Practitioner Score Trajectory

The practitioner score series shows a problem: no chapter has achieved a "fully answerable" score on more than 3 of 10 questions. The series is:

- Ch 4: 0/9/1 — no implementation
- Ch 9: 2/5/3 — partial framework, missing sub-dimensions
- Ch 10: 0/9/1 — orientation only, no implementation path

The pattern suggests the book currently excels at framework and pattern orientation but consistently under-delivers on the "how do I actually do this?" question. This may be intentional design scope (the book is patterns, not tutorials), but it is a recurring practitioner gap worth tracking.

### Visual Gap Persistence

Seven runs. Six with zero figures. Ch 6 has three figures; every other audited chapter has zero. This is no longer a chapter-level gap — it is a book-level gap. The book describes pipeline architectures, decision frameworks, theoretical models, and data structures without any visual support. Figure planning for at minimum Ch 4, Ch 8, Ch 9, and Ch 10 should be on the book-level roadmap.

### Bloom Ceiling Progress

Chapters now consistently reach Evaluate via thought experiments. The Bloom floor is the continuing issue — framework and requirements sections tend to stay at Remember/Understand. The design challenge: how do you push a requirements list above Remember without turning it into a tutorial?

### Knowledge Graph Thread

The KG thread originated in the design note (`docs/design_note_knowledge_graphs_as_pipeline_state.md`), was seeded in Ch 6 (Run 004 session, inserted this session), developed in Ch 9 (state externalization paragraph), and promised in Ch 10 (Graph-of-Artifacts section). Ch 10 does not fulfill the promise. This thread needs a decision: either Ch 10 adds a KG subsection (Seldon task c344d858) or the forward references in Ch 6 and Ch 9 are scoped down to match what Ch 10 actually delivers.

---

## 4. Gate Profile for Future Runs

Based on 7 data points, the full gate profile for book_chapter runs:

| Gate | Applies When | Priority |
|---|---|---|
| Number accuracy (counts, costs, percentages) | Chapters citing Concept Mapper or Pragmatics results | BLOCKING |
| Cross-reference accuracy | All chapters with forward or backward references | HIGH |
| Canonical baseline comparison | Theoretical framework chapters (Ch 9, future framework chapters) | BLOCKING for framework type |
| Tutorial vs. pattern gate | Infrastructure/construction chapters (Ch 6, Ch 7, Ch 10, Ch 11) | HIGH |
| Experiential claim framing | Any chapter with author-experience anecdotes | MEDIUM |
| Visual gap tracking | All chapters | TRACKING (not blocking) |
| Framework exercise check | Methodology/framework chapters (Ch 8) | HIGH |

**New gate recommendation for Run 009+:** Add a "practitioner landing zone" check for infrastructure chapters. The check: does the chapter provide at minimum one of (a) an implementation sequence, (b) a worked example with concrete parameters, or (c) a minimum viable path from concept to working artifact? If none, flag as MEDIUM gap.

---

## 5. Required Actions Before Ch 10 Use

| Priority | Action | Routing |
|---|---|---|
| 1 | Add KG treatment or scope down Ch 6/Ch 9 forward references | needs_author + seldon_task:c344d858 |
| 2 | Reframe two experiential claims as author observation | needs_author |
| 3 | Define four technical terms inline: append-only, projection, JSONL, CDN | needs_author |
| 4 | Verify or remove DOORS full name expansion | auto_search or needs_author |
| 5 | Plan two figures: dual-layer architecture, provenance chain | needs_author (figure planning) |
| 6 | Add implementation sequencing guidance (which requirements first) | needs_author |
| 7 | Make thought experiment self-contained (two sentences of setup) | needs_author |
