# AD-020 Calibration Run 013 — Appendix: Agentic AI Security Considerations

**Date:** 2026-04-06
**Document:** book/appendix-security.md
**Type:** appendix (first appendix-type run in AD-020 series)
**Document subtype:** security_reference_supplement
**Word count:** ~1,800
**Prior runs:** 002 (Ch 4), 003 (Ch 5), 004 (Ch 6), 005 (Ch 7), 006 (Ch 8), 007 (Ch 9), 008 (Ch 10), 009 (Ch 11), 010 (Ch 12), 011 (Ch 13), 012 (Ch 14)

---

## 1. Gate Effectiveness by Tier

### Tier 1: Content Audit

All five citation keys confirmed in references.bib. No citation gaps on empirical claims (contrast with Ch 12 which had 2 citation gaps). Zero bare assertions presented as fact without citation or logical grounding.

| Finding | Severity | Routing |
|---|---|---|
| OWASP category names and IDs (ASI09 especially) — specific, verifiable, unverifiable from memory | HIGH | Perplexity AV-03, CC-02 |
| NIST IR 8596 iprd focus area names ('Secure,' 'Thwart') and 'Priority 1' designation | HIGH | Perplexity AV-02, CC-04 |
| NCCoE three-property framework exact terminology | MEDIUM | Perplexity AV-04, AV-05 |
| OAuth/OpenID/MCP candidate standards sentence has no inline citation | LOW | targeted_edit |
| NIST CSF invoked in CISO Conversation without citation | LOW | add nist_csf_2024 to bib |
| 'First public draft' characterization of OWASP vs. bib's 'peer-reviewed by 100+ experts' | LOW | CC-02 verification |

**Key Tier 1 insight:** The appendix has better citation discipline than Ch 12 (zero genuine citation gaps vs. Ch 12's two) but has more high-specificity claims that are unverifiable without Perplexity. This is the nature of a standards-heavy appendix -- it cites institutional sources precisely, and precision creates verification obligation. The pipeline caught what manual reading would likely miss: that naming specific OWASP IDs (ASI09) and specific NIST IR structural terms (Priority 1, Secure, Thwart) is a factual risk, not a stylistic choice.

### Tier 2a: Dual Persona Stress Test

| | Persona A (Practitioner) | Persona B (CISO/Security Lead) |
|---|---|---|
| **A1 / B1** | Fully served — can identify relevant threats | Partially served — source accuracy questions remain |
| **A2 / B2** | Fully served — agent identity clearly explained | Fully served — threat descriptions technically sound |
| **A3 / B3** | Partially served — controls named but not how-to | Fully served — controls reflect sound security practice |
| **A4 / B4** | Fully served — CISO conversation structured | Fully served — gap acknowledgment honest and accurate |
| **A5 / B5** | Fully served — standards timeline clear | Partially served — SBOM, MCP attack surfaces, DETECT function absent |

**Persona A combined:** 4 fully / 1 partial / 0 not (vs. Ch 12 Run 010: 1 fully / 4 partial / 0 not)
**Persona B combined:** 3 fully / 2 partial / 0 not (vs. Ch 12 Run 010: 3 fully / 2 partial / 0 not)
**Total:** 7 fully / 3 partial / 0 not (vs. Ch 12: 4 fully / 6 partial / 0 not)

**Key Tier 2a insight:** The appendix serves Persona A dramatically better than Ch 12 did (4/1/0 vs. 1/4/0). This is the expected result for supplementary material with a focused scope: a ~1,800-word appendix on a defined topic serves practitioners better than a 2,855-word chapter covering governance for all AI workflow types. Persona B scores are stable (3/2/0) -- the appendix neither gains nor loses ground with the CISO audience. The character of Persona B's partial scores shifted: Ch 12's gaps were formal threat model absence and audit procedure; the appendix's gaps are source verification and scope completeness (SBOM, MCP attack surfaces, DETECT function).

### Tier 2b: Depth Check (Action-Enablement Assessment)

**6 of 7 sections action-enabling (86%).** Most actionable: Controls That Work Today (implementation-ready, four named controls). Least actionable: Opening paragraph (framing -- appropriate for an appendix opening). Action-type distribution is excellent: the six action-enabling sections enable six qualitatively different action types (classify, triage, diagnose, implement, communicate, plan). No dead-end sections.

| Section | Action Type | Verdict |
|---|---|---|
| Opening | informational | appropriate |
| What Makes Agents Different | classification | action-enabling |
| The Threat Surface | risk triage | action-enabling |
| The Identity Gap | diagnostic | action-enabling |
| Controls That Work Today | implementation | action-enabling (most) |
| The CISO Conversation | communication | action-enabling |
| Where This Is Headed | expectation-setting | action-enabling |

---

## 2. Standout Findings vs. Run 010 (Ch 12)

### What the pipeline found that manual reading would likely miss

1. **OWASP ASI09 specificity is a factual risk.** Naming 'OWASP ASI09: Human-Agent Trust Exploitation' is precise enough that a CISO who has read the OWASP document will immediately check it. If the name or ID has changed (OWASP documents evolve), the error is conspicuous. Manual reading does not flag 'ASI09' as a risk; the pipeline's content audit flags it as a high-specificity verifiable claim.

2. **NIST IR 8596 iprd structural terminology.** 'Priority 1,' 'Secure,' and 'Thwart' as named elements of the NIST Cyber AI Profile are precise enough to be verifiable and wrong-if-wrong. Manual reading of the appendix does not surface this risk without having the NIST document open for comparison. The pipeline flagged it because the content audit checks all high-specificity factual claims for Perplexity routing.

3. **The NCCoE candidate standards sentence has no inline citation.** 'The NCCoE concept paper identifies OAuth 2.0/2.1, OpenID Connect, and the Model Context Protocol as candidate standards under evaluation.' This sentence relies on a citation in an earlier paragraph of the same section. A human reader checking citations might miss the gap; the pipeline found it by assessing each sentence's citation status independently.

4. **The temporal qualifier ('as of early 2026') appears only in the final section** but the timeline claims appear in The Identity Gap section. The pipeline's dateability check caught this as a location mismatch that a manual reader would not notice unless reading specifically for dateability.

5. **Source currency risk is HIGH for all five sources.** The pipeline's new source currency gate explicitly assessed staleness risk per source. A human reader would note the draft/RFI status of each source, but would not systematically assess which are 'likely_progressed' vs. 'may_have_progressed.' The pipeline produced a five-row currency table that gives the author a clear priority stack for pre-publication verification.

### Standout differences from Ch 12 Run 010

- **Citation gaps:** Ch 12 had 2 genuine citation gaps (LLM memorization, consumer/enterprise ToS). The appendix has 0 citation gaps on empirical claims -- better citation discipline.
- **Bloom vs. action-enablement:** Ch 12's table-as-content-mechanism achieved Apply-level Bloom structurally. The appendix achieves comparable action-enablement through prose alone, which is appropriate for the shorter format.
- **Persona scores:** The dramatic improvement in Persona A scores (4/1/0 vs. 1/4/0) is the single most striking comparison. Focused supplementary material serves the primary practitioner audience better than a broad governance chapter.
- **Cascade checks:** Ch 12 had 5 cascade checks (all confirmed). The appendix has 8 cascade checks (7 confirmed, 1 with note). The richer cascade set was appropriate for an appendix that needed to verify boundary accuracy, overlap absence, and gap closure -- three concerns that don't apply to mid-book chapters.
- **Source currency risk:** Ch 12 had low overall dateability risk (stable published frameworks). The appendix has HIGH currency risk (all pre-standard sources). This is a structural difference between a chapter citing stable published frameworks and an appendix citing pre-publication standards-in-progress.

---

## 3. New Gate Assessments

### Ch 12 Boundary Check (new gate for this run)

**Verdict: CLEAN HANDOFF on all three items checked.**

| Boundary Item | Result |
|---|---|
| Appendix characterization of Ch 12 scope | Accurate (predefined pipeline assumption confirmed) |
| Prompt injection -- overlap or handoff? | Clean handoff -- Ch 12 names it once; appendix develops it |
| Audit trails -- overlap or handoff? | Complementary -- different granularity levels |
| Supply chain -- overlap or handoff? | Adjacent -- different scope (pipeline artifacts vs. orchestration layer) |

This gate had high value: it directly verified that the appendix doesn't duplicate Ch 12 and that Ch 12's characterization is accurate. A manual reading might assume the boundary is clean; the cascade check confirmed it empirically.

### Taxonomy Selection Check (new gate for this run)

**Verdict: THREE SELECTED ARE APPROPRIATE for federal research pipeline practitioners.**

The three selected threats (agent behavior hijack, tool misuse, cascading failures) cover the three most practitioner-accessible attack surfaces: external content injection, tool scope control, and inter-agent trust. The 'additional threats' framing for identity abuse and memory poisoning is sound architecture.

**Potentially surprising omissions (for security-literate readers):**
- Excessive agency / scope: arguably more fundamental than tool misuse; partially addressed by the least-privilege control
- Data exfiltration via agent: directly relevant to federal data sensitivity context; implied but not named

**Pipeline assessment:** The omissions are defensible but visible. An appendix author who has reviewed all 10 OWASP threats and intentionally selected 3 is making an editorial decision. The pipeline surface this decision for the author's awareness -- it's not an error, but the author should have a reason for the omissions that could be articulated if challenged.

### Tone Calibration Check (new gate for this run)

**Verdict: WELL CALIBRATED overall, one minor clarity gap.**

| Passage | Assessment |
|---|---|
| Agent behavior hijack explanation | Does not condescend to security professionals -- uses their vocabulary ('indirect prompt injection') and adds new context (tool access amplifies consequence) |
| Identity gap section for non-security practitioners | Accessible -- three-property framework is explained with clear parentheticals; NCCoE framing is in plain English |
| CISO Conversation section | Not patronizing -- frames the CISO as a partner, not an obstacle |
| 'Non-repudiation' in logging paragraph | UNEXPLAINED -- only unexplained security term in the appendix |

**Best-balanced section:** Controls That Work Today -- each control explained for both audiences simultaneously. The chain-of-custody framing for logging (connecting to research reproducibility) is the best dual-audience bridge in the appendix.

**Finding the pipeline found that manual reading misses:** The pipeline systematically checked each security term for explanation status. 'Non-repudiation' passed initial reading because it is surrounded by explanatory prose, but the pipeline's explicit terminology check flagged it as unexplained-by-definition. This is the kind of finding a skilled editor might catch on revision but that a first-pass reader would miss.

### Source Currency Check (new gate for this run)

| Source | Status at Writing | Currency Risk |
|---|---|---|
| nist_caisi_rfi_2026 | RFI, comment closed Jan 2026 | LIKELY PROGRESSED |
| owasp_agentic_top10_2026 | First public draft, Dec 2025 | LIKELY PROGRESSED |
| nccoe_agent_identity_2026 | Draft, comment closed Apr 2 2026 | LIKELY PROGRESSED |
| nist_cyber_ai_profile_2025 | IPRD, Dec 2025 | MAY HAVE PROGRESSED |
| nist_aasi_2026 | Program launch page, Feb 2026 | MAY HAVE PROGRESSED |

**Key pipeline finding:** All five sources are in the 'likely_progressed' or 'may_have_progressed' category. This is categorically different from Ch 12 (which cited stable published frameworks). The appendix's currency risk is structural -- it was written ahead of the standards it covers. The 'as of early 2026' qualifier is the correct mitigation, but it needs to appear in the Identity Gap section (where the timeline claims live), not only in the final section.

---

## 4. Document Type Comparison: Appendix vs. Book Chapter

### What is different about auditing reference/supplementary material?

**1. Bar calibration**

A teaching chapter needs to scaffold learning (Bloom taxonomy, narrative arc, reflection prompts, thought experiment, chapter bridge). An appendix needs to: (a) accurately characterize what it supplements, (b) provide usable reference content, and (c) enable reader action. The bar is lower but different. The pipeline adapted this run by replacing the Bloom depth check with an action-enablement assessment and by adding three new gates specific to appendix type: Ch 12 boundary check, taxonomy selection check, tone calibration check.

**2. Persona scores interpret differently**

A chapter serving 4/1/0 + 3/2/0 across two personas would be 'conditionally ready' for a teaching chapter. An appendix serving those scores is 'ready' -- supplementary material does not need to fully answer all practitioner implementation questions; it needs to enable the practitioner to ask the right questions. This appendix scored 4/1/0 + 3/2/0 (7/3/0 combined), which is effectively a pass for this document type.

**3. Citation discipline has different character**

Chapters cite to support empirical claims and framework references. Appendices supplement chapters by providing vocabulary and framing from specific institutional sources -- and those sources are often pre-publication documents. The citation discipline concern for this appendix is not 'is this claim cited at all?' (answer: yes, all major claims are cited) but 'is the citation to a document that has since been updated?' This is a qualitatively different verification need.

**4. Cascade checks need more structure**

For mid-book chapters, cascade checks verify that the chapter delivers on promises made by the preceding chapter and keeps promises for the following chapter. For an appendix, cascade checks need to verify a richer set: (a) accurate characterization of the supplemented chapter, (b) no duplication, (c) no gap at the boundary, (d) gap closure from the trigger that created the appendix. The appendix run needed 8 cascade checks vs. Ch 12's 5. Future appendix runs should plan for an expanded cascade check scope.

**5. Source currency is the primary risk**

Book chapters typically cite published, stable sources. Appendices covering emerging topics (like agentic security standards) may cite pre-publication sources. When this is true, source currency becomes the primary dateability risk rather than a secondary concern. The pipeline should treat source currency as a Tier 1 gate for appendices citing pre-standard/draft sources.

---

## 5. Recommendations for Future Appendix-Type Runs

1. **Add source currency as a Tier 1 gate when any source is pre-publication.** For this appendix, source currency should have been assessed before the Perplexity queries were generated -- it determines the routing for every source-specific claim.

2. **Adapt cascade checks for appendix type:** Always include (a) boundary accuracy, (b) duplication check, (c) gap check, (d) gap closure from trigger. For this appendix, CA6 (gap closure from Run 010) was the most valuable cascade check.

3. **Replace Bloom depth check with action-enablement assessment for appendices.** The Bloom framework is designed for teaching content. An appendix is reference content. The 6/7 action-enabling ratio is the right metric for supplementary material.

4. **The persona stress test bar should be explicitly calibrated lower for appendices.** A 4/1/0 + 3/2/0 score that would be 'conditionally ready' for a chapter is effectively 'ready' for an appendix. Document this explicitly in the stress test output.

5. **Tone calibration (Tier 3 new gate) has high value for dual-audience appendices.** The security appendix has two explicit audiences (practitioners and security professionals). The tone calibration check found one unexplained term and confirmed that the CISO Conversation section is not patronizing -- these are findings that improve the document meaningfully.

6. **Taxonomy selection check (Tier 3 new gate) has high value for curated-subset appendices.** When an appendix selects a subset of a larger taxonomy (3 of 10 OWASP threats), the pipeline should surface which threats were omitted and whether any omissions would surprise the target audience. This check transfers to any appendix with curated selections.

---

## 6. What the Pipeline Found That Manual Reading Would Likely Miss

1. OWASP ASI09 specificity as a factual risk (named in Tier 1 findings above)
2. NIST IR 8596 iprd structural terminology as a verifiable claim (Tier 1)
3. Inline citation gap for the NCCoE candidate standards sentence (Tier 1)
4. Temporal qualifier location mismatch (dateability check)
5. ALL FIVE sources rated 'likely' or 'may have' progressed (source currency)
6. 'Non-repudiation' as the one unexplained security term (tone calibration)
7. Excessive agency/scope and data exfiltration as OWASP omissions potentially surprising to CISO-level readers (taxonomy selection)
8. MCP server attack surfaces as a residual gap relative to Ch 12's specific handoff promise (CA6)

---

## 7. What the Pipeline Cannot Assess (Requires Perplexity)

All items in `audits/appendix-security_perplexity_queries.md`:

**Accuracy verification (cannot be confirmed without document access):**
- AV-01: NIST CAISI agent definition exact wording
- AV-02: NIST IR 8596 iprd focus area names and Priority 1 designation
- AV-03: OWASP Agentic Top 10 exact category names and ASI09 ID
- AV-04: NCCoE three-property framework exact terminology
- AV-05: NCCoE candidate standards list (OAuth, OpenID Connect, MCP)
- AV-06: NIST CAISI three-tier control model structure
- AV-07: NIST Cyber AI Profile supply chain framing
- AV-08: NIST CAISI least privilege framing
- AV-09: NCCoE non-repudiation framing

**Currency checks (cannot be assessed without checking publication status):**
- CC-01: NIST CAISI follow-on guidance after RFI
- CC-02: OWASP Agentic Top 10 revision status
- CC-03: NCCoE concept paper post-comment-period status
- CC-04: NIST IR 8596 second draft status
- CC-05: NIST AASI program updates

---

## 8. Summary

**Verdict:** CONDITIONALLY READY

The appendix is well-constructed for its type. It closes the Run 010 convergence-4 agentic security gap, serves Persona A (practitioners) significantly better than the supplemented chapter did, has clean cascade checks across all eight verified relationships, and achieves 86% action-enablement across sections. The conditionally-ready verdict reflects verifiable factual risks (OWASP category names/IDs, NIST IR 8596 structural terminology) rather than structural problems. Once Perplexity verification is complete for the priority items, the appendix is ready for publication.

**Calibration value:** Run 013 establishes the first appendix-type calibration record. The adaptations made in this run -- source currency as primary gate, action-enablement replacing Bloom, three new Tier 3 gates (boundary check, taxonomy selection, tone calibration), expanded cascade check scope -- should be treated as the starting point for all future appendix-type runs.
