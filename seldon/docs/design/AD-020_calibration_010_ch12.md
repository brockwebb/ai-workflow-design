# AD-020 Calibration Run 010 — Chapter 12

**Date:** 2026-04-05
**Chapter:** Chapter 12: Security, Supply Chain, and Model Provenance
**Type:** book_chapter (ninth instance)
**Chapter subtype:** governance_security_framework (new type)
**Prior runs:** 002 (Ch 4, domain), 003 (Ch 5, pattern), 004 (Ch 6, eng/construction), 005 (Ch 7, eng/defensive), 006 (Ch 8, methodology/framework), 007 (Ch 9, theoretical framework), 008 (Ch 10, practitioner_infrastructure_guide), 009 (Ch 11, evaluation_framework_landscape_survey)

---

## 1. Gate Effectiveness by Tier

**Tier 1 (Correctness):** Three citation/accuracy issues found; zero factual errors in the book's own framework application.

| Severity | Finding |
|---|---|
| MEDIUM | Five Safes legislative adoption claim — "embedded in UK Digital Economy Act and Australia's DAT Act" — likely overstated given the desai_2016 paper predates both acts. PQ1 needed. |
| MEDIUM | LLM memorization claim stated definitively without citation. Well-documented phenomenon; Carlini et al. is the canonical source. PQ2 needed. |
| LOW | Consumer/enterprise ToS characterization — broadly accurate but variable across providers and time. Needs hedging language or citation. |

All four citations verified:
- `desai_2016`: Five Safes framework paper confirmed in bib. Adoption claim content needs PQ1 verification.
- `nist_ai_rmf_2023`: MAP and MANAGE functions attribution CONFIRMED.
- `nist_genai_2024`: Used for NIST Generative AI Profile — CONFIRMED in bib.
- `webb_2026_crosswalk`: Title matches claim ("Regulatory Crosswalk of NIST AI RMF and FCSM") — CONFIRMED.

**Agentic security gap:** STRONG SIGNAL. No agentic security content. Chapter treats all AI workflows as predefined pipelines. Convergence 4 cluster. Security appendix decision gate (1826188c) receives: "gap confirmed, specific, significant."

**New gate (dual audience check):** Most useful new gate in the series for this chapter type. Found a moderate imbalance: security professionals (Persona B) scored 3/2/0 vs. practitioners (Persona A) scoring 1/4/0. The chapter gives practitioners principles; it gives security professionals a usable assessment framework. The asymmetry is structural to governance chapters.

**New gate (regulatory accuracy check):** Caught the Five Safes legislative adoption claim as the priority verification item. All other regulatory claims (FedRAMP characterization, jurisdiction framing, data retention principles) are accurate.

**Cascade checks:** 5/5 confirmed, 0 broken. Cleanest cascade record in the series. All Ch 11 bridge promises delivered. Ch 13 bridge pickup confirmed. Ch 1 confirmed as origin of both "stochastic tax" and "stochastic liability" terms used in Ch 12's questions tables.

---

## 2. Standout Findings vs. Prior Runs

**Narrative arc:** Strongest in the series. The "offline isn't offline" hook is reconnected three times (hook → Safe Settings → Model Provenance → thought experiment). No prior chapter has achieved this level of hook integration. This is a model for how a governance chapter avoids the compliance-catalog trap.

**Table-as-content-mechanism pattern (new):** Ch 12 is the first chapter where tables ARE the primary content delivery mechanism. Six questions tables constitute the chapter's operational core. This is a new chapter subtype the pipeline should recognize and calibrate differently from table-as-supplement chapters.

**Bloom scaffolding:** Flattest and most consistent in the series. Apply-level engagement across all five safe sections. The tables enforce Apply-level engagement structurally — the reader cannot passively read a questions table; they must apply it mentally to their context. This is the best Bloom scaffold construction in the series.

**"Enabling, not prohibitive" framing:** Works. The chapter consistently frames security controls as enabling tools, not compliance burdens. This framing is sustained throughout, not just asserted in the introduction. The Safe Projects section explicitly permits routine AI use without governance review — this is empowering language for the target audience.

**Chapter length:** ~2,855 words — shortest chapter in the audit series. For a governance chapter organized around a well-structured framework with six questions tables, the length is appropriate. The tables carry content that would otherwise require paragraphs of prose. Brevity here is a virtue.

---

## 3. Practitioner Scores — Dual Persona Comparison

| Persona | Fully | Partial | Not |
|---|---|---|---|
| A (Practitioner) | 1 | 4 | 0 |
| B (Security/IT) | 3 | 2 | 0 |
| Combined | 4 | 6 | 0 |

Calibration insight: **governance chapters naturally score higher for governance audiences than for practitioner audiences.** Persona A's gap: implementation specificity (Title 13 not named, FedRAMP tier evaluation method absent, ToS determination procedure absent). Persona B's gap: no formal threat model, no audit trail documentation procedure.

The 4/6/0 combined score is the highest in the audit series (previous high was Ch 11's 1/9/0 for a single persona). The dual persona test produces a more complete picture than a single practitioner persona for chapters with explicit dual-audience design.

---

## 4. Bloom Comparison Across Chapter Types

| Run | Chapter | Type | Bloom Ceiling | Sections at Apply/Below | Scaffolding |
|---|---|---|---|---|---|
| 006 | Ch 8 | methodology/framework | Evaluate | 5/9 | non-monotonic |
| 007 | Ch 9 | theoretical | Evaluate | ~3/9 | non-monotonic |
| 008 | Ch 10 | infrastructure | Evaluate | 5/9 | non-monotonic |
| 009 | Ch 11 | framework/landscape | Evaluate | 4/8 | non-monotonic |
| 010 | Ch 12 | governance/security | Evaluate | 8/9 | flat Apply plateau |

Ch 12 has the highest sections-at-Apply-or-below count (8/9) and the flattest scaffolding. This is appropriate for a governance chapter: the deliverable is an operational checklist, not a conceptual framework. The ceiling (Evaluate in thought experiment) is earned, not inflated.

---

## 5. Citation Profile Comparison

| Chapter | Total | Self-citations | External | Self % | Profile |
|---|---|---|---|---|---|
| Ch 9 | 4+ | 1 (webb_ai4stats) | 3 | 25% | balanced |
| Ch 10 | 2 | 2 | 0 | 100% | self-only |
| Ch 11 | 3 | 1 (webb_pragmatics) | 2 | 33% | model profile |
| Ch 12 | 4 | 1 (webb_crosswalk) | 3 | 25% | balanced |

Ch 12 has the balanced citation profile that governance chapters should have: self-citation for the crosswalk paper (appropriate — it's the detailed reference), NIST citations for the regulatory framework (appropriate — authoritative sources), Five Safes citation for the organizing framework (appropriate). Citation placement is well-targeted despite sparse count.

---

## 6. Visual Gap — 9th Data Point

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
| 010 | Ch 12 | 0 | 6 | different pattern |

Ch 12 breaks the binary: 0 figures, 6 tables. The table-heavy structure is not a gap — the tables ARE the content. The visual gap in this chapter is specifically a Five Safes overview diagram (pentagon or similar), which would help orient unfamiliar readers. The supply chain dependency tree is optional. Neither is blocking.

**Running conclusion:** Visual gaps are persistent across all chapters. Chapters with framework content (Ch 9 tables, Ch 11 comparison table, Ch 12 questions tables) handle this better than prose-only chapters. Chapters without any tables (Ch 8, Ch 10) have the most severe visual gaps.

---

## 7. Security Appendix Decision Gate Input

**Gate ID:** 1826188c
**Input status:** Confirmed gap — proceed with decision.

The agentic security gap is:
- Present (no agentic security content in Ch 12)
- Specific (identifiable threat surfaces: agent tool authorization, agent identity, MCP server attack surfaces, prompt injection via tool outputs)
- Significant (Ch 11 established agentic systems as an orchestration pattern; Ch 12 does not extend security framing to cover them)

The five reviewed security sources (OWASP ASI taxonomy, NCCoE agent identity concept paper, NIST CAISI RFI, NIST Cyber AI Profile, NIST Agent Standards Initiative) directly address the gap. The material is substantial enough for a dedicated appendix. If an appendix is created, Ch 12 needs one sentence: "Agentic AI systems — where the AI autonomously selects and invokes tools at runtime — introduce additional security considerations covered in the appendix."

---

## 8. What Worked / What to Adjust

**Worked well:**
- Dual audience check: produced genuinely differentiated results and identified the governance-audience advantage clearly.
- Regulatory accuracy check: caught the Five Safes legislative adoption claim immediately.
- Agentic security gap check: STRONG signal, clean input for the decision gate.
- Narrative arc assessment: first chapter where the hook integration warranted "strongest in the series" rating.
- Table-as-content-mechanism: pipeline correctly identified a new structural pattern.

**Adjust for future runs:**
- Governance chapters need a **compliance-catalog risk check**: assess whether the chapter reads as a list of restrictions despite enabling framing. Ch 12 passes; this check will be more useful for chapters that fail.
- The dual persona test should be used for **any chapter with a declared dual audience** in HTML comments. This gate should carry forward.
- **Citation adequacy gate for regulatory chapters**: four citations for a governance chapter may be inadequate if regulatory claims are specific. The LLM memorization gap (a well-known empirical claim stated without citation) is the clearest example. Future governance chapters should flag uncited factual claims about system behaviors more aggressively.
- **Chapter length calibration**: 2,855 words is appropriate for a governance chapter organized around structured tables. The pipeline should not flag this as a coverage gap without assessing whether tables carry content that would otherwise require prose expansion.

---

## 9. Comparison to Immediately Prior Runs

| Metric | Ch 10 (run-008) | Ch 11 (run-009) | Ch 12 (run-010) |
|---|---|---|---|
| Type | infrastructure | framework + landscape | governance/security |
| Words | ~3,146 | ~3,187 | ~2,855 |
| Citations | 2 | 3 | 4 |
| Self-citation % | 100% | 33% | 25% |
| Figures | 0 | 0 | 0 |
| Tables | 0 | 1 | 6 |
| Practitioner score | 0/9/1 | 1/9/0 | 4/6/0 (dual) |
| Bloom ceiling | Evaluate | Evaluate | Evaluate |
| Bloom scaffolding | non-monotonic | non-monotonic | flat Apply plateau |
| Cascade broken | 0 | 1 (stochastic tax) | 0 |
| Verdict | conditionally_ready | conditionally_ready | conditionally_ready |
| Top finding | no MVP sequence | stochastic tax attribution | agentic security gap |

Ch 12 is the strongest chapter in the audit series by cascade record (0 broken), narrative arc (hook integrated throughout), Bloom scaffolding (flattest), and practitioner combined score (4/6/0 dual). The primary open item (agentic security gap) is a gap in scope, not a content error. This chapter is ready for use; the agentic security gap is an enhancement pending the authorial decision on the appendix.
