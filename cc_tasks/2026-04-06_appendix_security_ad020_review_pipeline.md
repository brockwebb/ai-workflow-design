# CC Task: AD-020 Multi-Lens Review Pipeline -- Security Appendix

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Reference:** AD-020 (Iterative Content Review Pipeline), AD-019 (Content Audit)
**Calibration run:** 013 (first `appendix` type; Runs 002-012 = book chapters Ch 4-14)
**Subagents:** `.claude/agents/auditor.md`, `.claude/agents/cascade-checker.md`
**Target:** `book/appendix-security.md` -- Agentic AI Security Considerations

---

## Context

This is the thirteenth AD-020 calibration run and the first on `document_type: appendix`. The security appendix supplements Chapter 12 (Security & Governance). It covers the security surface introduced by agentic AI systems -- territory that Ch 12's Five Safes framework was not designed to address.

The appendix is approximately 1,800 words. It has **5 citations**, all institutional sources: NIST CAISI RFI (`nist_caisi_rfi_2026`), OWASP Agentic Top 10 (`owasp_agentic_top10_2026`), NCCoE Agent Identity concept paper (`nccoe_agent_identity_2026`), NIST Cyber AI Profile (`nist_cyber_ai_profile_2025`), and NIST AI Agent Standards Initiative (`nist_aasi_2026`). All five sources were in input-gathering or initial draft phases as of early 2026.

The appendix is structured as a practitioner-facing security vocabulary primer: what makes agents different, the threat surface (OWASP taxonomy), the identity gap (unsolved), controls that work today, how to talk to your CISO, and where standards are headed. The framing is mission enablement, not security engineering.

**Key differences from book chapter runs:**

1. **Document type: appendix.** Appendices have different pedagogical expectations than chapters. No opening hook/closing bridge pattern required. No thought experiment required. No chapter-to-chapter bridges. The appendix exists to supplement Ch 12, not to stand alone as a teaching unit.

2. **Supplement relationship to Ch 12.** The appendix explicitly opens by scoping what Ch 12 covers (predefined pipelines, Five Safes) and what it does not (agentic autonomy). The boundary must be clean -- no overlap, no contradiction.

3. **All sources are pre-standard.** Every cited source was in draft, RFI, or comment period as of early 2026. The appendix acknowledges this. The dateability question is different here: the content is explicitly time-stamped. The risk is not that claims will date -- it's that they already have. Have any of these standards progressed since the appendix was written?

4. **Practitioner audience with security audience dual-read.** The appendix is written for practitioners ("you need vocabulary for the CISO conversation") but will also be read by security professionals evaluating the book's security coverage. It needs to satisfy both without being a security manual.

5. **No figures, no tables, no templates.** Pure prose + citations. The visual gap question is simpler here.

6. **Em-dash usage.** The appendix uses em-dashes extensively (at least 10+ instances). The project standard is no em-dashes in new content. However, this appendix predates the em-dash prohibition and has not had a cleanup pass. The audit should flag the count but the revision task will handle cleanup.

**Known items from handoff and graph:**
- Session 28 (Ch 12 AD-020, Run 010) identified "agentic security gap" as a key finding. The security appendix was written to address that gap. Verify that what Ch 12 Run 010 flagged is actually covered here.
- The handoff (Session 29) lists this as the next AD-020 target.
- No open graph tasks targeting the security appendix.
- The five stuck proposed-state tasks (from the `cc_complete` bug) are unrelated to this appendix.

**Calibration questions for this run:**
- How does the pipeline perform on an **appendix** vs. a numbered chapter? What gates are irrelevant? What new concerns emerge?
- **Source currency.** All five sources were pre-standard as of early 2026. Has any of them progressed? (The audit should flag this as a Perplexity verification question, not attempt to answer it.)
- **Ch 12 boundary.** Is the handoff from Ch 12 to the appendix clean? Does the appendix repeat any Ch 12 content, or does it leave any gaps in coverage?
- **OWASP taxonomy fidelity.** The appendix selects three OWASP categories as "most relevant." Is that selection defensible? Does it omit anything a practitioner building research workflows should know about?
- **Identity gap framing.** The appendix calls agent identity "the central unsolved problem." Is that still accurate? Is the framing balanced, or does it overstate the gap?
- **Controls section completeness.** Four controls are listed. Are they the right four? Is anything obvious missing that a security-literate reader would notice?
- **CISO conversation section.** Is this actually useful, or is it patronizing? Would a practitioner find it genuinely helpful for structuring a real conversation?
- **Tone calibration.** The appendix walks a line between "accessible to non-security practitioners" and "credible to security professionals." Does it succeed, or does it condescend to one audience while losing the other?

### Document Type Configuration

```yaml
review:
  document_type: appendix
  parent_chapter: chapter-12
  audience: "Federal data scientists building agentic AI workflows AND security/IT professionals evaluating those workflows"
  appendix_pattern: "scope boundary (what Ch 12 covers vs. what this covers) --> agent definition (NIST boundary) --> threat surface (OWASP taxonomy, 3 selected + 2 noted) --> identity gap (unsolved, pre-standard) --> controls today (4 practitioner controls) --> CISO conversation (structuring the discussion) --> forward look (standards timeline)"
```

### Gate Calibration for `appendix` (first run of this type)

| Gate | Intensity | Notes |
|------|-----------|-------|
| Tier 1: Correctness | Full | 5 citations -- verify all are accurately represented. Focus on whether OWASP taxonomy descriptions match the source, whether NIST quotes/paraphrases are faithful, whether the NCCoE three-property framework (identification/authentication/authorization) is correctly stated. |
| Tier 2a: Stress Test | **Dual persona** | (A) "I'm a data scientist about to deploy an agentic pipeline. Does this appendix give me the vocabulary and framework to navigate security review?" (practitioner), (B) "I'm a CISO or IT security lead reviewing an AI project proposal. Does this appendix demonstrate that the author understands my concerns?" (security professional) |
| Tier 2b: Depth Check | Adapted | Bloom taxonomy is less relevant for reference material. Instead: does the appendix enable the reader to DO something (have the CISO conversation) or is it purely informational? |
| Tier 3: Narrative | Adapted | No hook/bridge pattern required. Instead: is the appendix internally coherent? Does the argument build logically from definition to threats to gap to controls to conversation? |
| Tier 3: Clarity | Full | Security terminology -- does the appendix explain terms (prompt injection, tool misuse, non-repudiation) sufficiently for a non-security audience without over-explaining for a security audience? |
| Tier 3: Visual gaps | Light | Pure prose appendix. Flag only if a diagram or table would substantially improve comprehension. |
| Tier 3: Motivation | Light | ARCS less relevant for supplementary material. But: does the reader finish feeling equipped or overwhelmed? |

**Carried gates:**

| Gate | Source | Notes |
|------|--------|-------|
| Citation fidelity check | All runs | Are the 5 citations accurately represented? Do paraphrases match sources? Are claims attributed to the right source? |
| Dateability check | Run 009 (Ch 11) | Explicitly time-stamped content ("as of early 2026"). The risk is staleness, not implicit dating. Flag as Perplexity verification items. |
| Source currency check | **New for appendix** | All 5 sources were in draft/RFI/comment phases. Have any progressed to published standards? This is a Perplexity verification question. |

**New gate for this run (Ch 12 boundary check):** The appendix opens by scoping what Ch 12 covers and what it does not. Verify: (a) the characterization of Ch 12's scope is accurate, (b) no content in the appendix duplicates Ch 12, (c) no gap exists between where Ch 12 ends and the appendix begins.

**New gate for this run (taxonomy selection check):** The appendix selects 3 of OWASP's 10 agentic threats as "most relevant to research workflows." Assess whether the selection is defensible and whether any omitted threats would surprise a security-literate reader building federal research pipelines.

**New gate for this run (tone calibration check):** The appendix serves two audiences (practitioners and security professionals) with different baseline knowledge. Assess whether the tone succeeds for both, or whether it condescends to one while alienating the other. Flag specific passages where tone calibration fails.

---

## Execution Instructions

Run the full AD-020 pipeline:

### Tier 1: Content Audit
Use `.claude/agents/auditor.md` agent. Run the auditor on `book/appendix-security.md` with `document_type: appendix`.
- Output: `audits/appendix-security_content_audit.yaml`
- Generate Perplexity verification queries for:
  - NIST CAISI RFI (nist_caisi_rfi_2026): Is the agent definition accurately represented? Has the RFI progressed to a published document?
  - OWASP Agentic Top 10 (owasp_agentic_top10_2026): Are the three selected threat categories accurately described? Has v1.0 been published? Is the oversight fatigue threat (ASI09) correctly named?
  - NCCoE Agent Identity (nccoe_agent_identity_2026): Is the three-property framework (identification/authentication/authorization) correctly attributed? Has the concept paper progressed?
  - NIST Cyber AI Profile (nist_cyber_ai_profile_2025): Is the Priority 1 rating for agent identity accurate? Is the supply chain framing accurate? Has the profile moved beyond "initial preliminary draft"?
  - NIST AI Agent Standards Initiative (nist_aasi_2026): Is the February 2026 launch date accurate? Is the "mission enablement" framing accurate? Has it produced any outputs?
  - OAuth 2.0/2.1, OpenID Connect, Model Context Protocol: Are these correctly identified as candidate standards under NCCoE evaluation?
  - "12-24 months away" for implementation guidance: Is this timeline defensible as of early 2026?
- Output: `audits/appendix-security_perplexity_queries.md`

### Tier 2a: Practitioner Stress Test (Dual Persona)
Run two passes:
- **Persona A (Practitioner/Data Scientist):** "I'm about to deploy an agentic pipeline that reads external documents and writes classifications to a database. Does this appendix give me what I need to prepare for security review? Can I use it to structure a conversation with my CISO?"
- **Persona B (CISO/IT Security Lead):** "A team wants to deploy an agentic AI system in my environment. They handed me this appendix. Does it demonstrate security awareness? Is anything missing that I'd expect to see? Does it accurately represent the standards landscape?"
- Output: `audits/appendix-security_practitioner_stress_test.yaml` with separate scores per persona

### Tier 2b: Depth Check
Adapted for appendix: instead of Bloom taxonomy, assess action-enablement.
- Does the appendix enable the reader to take a concrete action (structure a CISO conversation, implement controls, scope an agent's permissions)?
- Or is it purely informational with no actionable outcome?
- Output: `audits/appendix-security_depth_check.yaml`

### Tier 3: Secondary Sweep
Includes: internal coherence, clarity, visual gaps (light), motivation (light), plus all carried and new gates (citation fidelity, dateability, source currency, Ch 12 boundary, taxonomy selection, tone calibration).
- Output: `audits/appendix-security_secondary_sweep.yaml`

### Synthesis
Combine all tiers into findings clusters with convergence scores.
- Output: `audits/appendix-security_review_synthesis.yaml`

### Cascade Checking
Use `.claude/agents/cascade-checker.md` agent.

**Cross-references to verify:**

| ID | Source | Target | Claim to verify |
|----|--------|--------|----------------|
| CA1 | Appendix opening | Ch 12 | "Chapter 12 covered security controls for AI workflows using the Five Safes framework." -- verify Ch 12 uses Five Safes as its primary security framework. |
| CA2 | Appendix opening | Ch 12 | "That framework assumes the workflow is a predefined pipeline -- the designer specifies what happens at each step, and the system executes it." -- verify this characterization of Ch 12's scope is accurate. Ch 12 should NOT already cover agentic scenarios extensively. |
| CA3 | Appendix "Agent behavior hijack" | Ch 12 | Indirect prompt injection is mentioned. Does Ch 12 cover prompt injection at all? If so, is there overlap or clean handoff? |
| CA4 | Appendix "Controls: Comprehensive action logging" | Ch 12 | "the same artifact that supports reproducibility -- the chain of custody from human decision to agent action." Does Ch 12 discuss audit trails/logging? Overlap check. |
| CA5 | Appendix "Controls: Supply chain provenance" | Ch 12 | Does Ch 12 cover supply chain considerations for AI components? Overlap check. |
| CA6 | Ch 12 AD-020 (Run 010) | Appendix | Run 010 key finding was "agentic security gap." Does this appendix actually close that gap? What specific aspects of the gap does it address vs. leave open? |
| CA7 | Appendix "CISO Conversation" | Ch 12 | "The NIST Cybersecurity Framework (GOVERN, IDENTIFY, PROTECT, DETECT, RESPOND, RECOVER) is the framework your CISO already uses." Does Ch 12 reference the NIST CSF? Consistency check. |
| CA8 | Appendix citations | `book/references.bib` | Verify all 5 citation keys exist in references.bib with correct metadata: `nist_caisi_rfi_2026`, `owasp_agentic_top10_2026`, `nccoe_agent_identity_2026`, `nist_cyber_ai_profile_2025`, `nist_aasi_2026`. |

- Output: `audits/appendix-security_cascade_results.yaml`

### Calibration Record
Write calibration observations to: `seldon/docs/design/AD-020_calibration_013_appendix_security.md`

Include:
1. Gate effectiveness by tier -- which gates from the chapter pipeline transferred well to appendix type, which were irrelevant, which needed adaptation
2. Standout findings vs. prior runs
3. Dual persona comparison table (Fully/Partial/Not per persona)
4. New gate assessments: Ch 12 boundary, taxonomy selection, tone calibration, source currency
5. Document type comparison: how does appendix audit differ from book chapter audit in practice?
6. Recommendations for future appendix-type runs (if any)
7. What the pipeline found that manual reading would likely miss
8. What the pipeline cannot assess (e.g., whether OWASP taxonomy descriptions match the actual source document -- this requires Perplexity verification)

---

## Verification

After all outputs are produced:
1. All seven audit files exist in `audits/` (content_audit, perplexity_queries, practitioner_stress_test, depth_check, secondary_sweep, review_synthesis, cascade_results)
2. Calibration record exists at `seldon/docs/design/AD-020_calibration_013_appendix_security.md`
3. Perplexity queries file covers all 5 citation sources with currency checks
4. Dual persona scores are separate and comparable
5. Cascade results cover all 8 cross-reference checks
6. Calibration record includes document type comparison (appendix vs. chapter)
7. Run `seldon verify --fix` after all outputs are written

## Do NOT

- Edit `book/appendix-security.md` -- this is an audit-only task
- Edit any chapter file
- Edit `book/references.bib`
- Make revision recommendations in the audit outputs -- the audit identifies issues; revision is a separate CC task
- Skip the Ch 12 boundary check -- the relationship between Ch 12 and this appendix is the structural foundation
- Skip the source currency check -- all 5 sources were pre-standard; staleness is the primary risk
- Skip the tone calibration check -- this appendix serves two audiences and must work for both
- Flag em-dashes as findings -- they are a known cleanup item, not an audit discovery
- Attempt to verify OWASP/NIST source accuracy from memory -- generate Perplexity queries and let the author verify externally
