# CC Task: Security Appendix Revision

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Target:** `book/appendix-security.md`, `book/references.bib`
**Inputs:** `audits/appendix-security_review_synthesis.yaml`, Perplexity verification results (PQ1-PQ7, author-provided)
**Depends on:** `cc_tasks/2026-04-06_appendix_security_ad020_review_pipeline.md` (completed)

---

## Context

The AD-020 audit (Run 013) returned `conditionally_ready` with 6 clusters and 2 unclustered findings. Perplexity verification confirmed the appendix is directionally accurate but identified several places where the text over-specifies source language or uses interpretive framing as if it were source terminology. All five sources have progressed since the appendix was written.

This revision addresses verified findings only. No structural changes to the appendix's organization or argument arc.

---

## Part A: CAISI Agent Definition -- Attributed Paraphrase

**Finding (C1/Perplexity PQ1):** The appendix's agent definition ("persistent changes outside the AI system itself, including file writes, API calls, database mutations, and network actions") is tighter and more enumerated than the source. The CAISI RFI says something closer to "generative AI models with software scaffolding" enabling actions affecting "real-world systems or environments."

**Edit:** In the "What Makes Agents Different" section, change the definition sentence to an attributed paraphrase. Replace:

> NIST's Center for AI Standards and Innovation defines an AI agent system as a generative AI model plus scaffolding software that enables autonomous actions affecting external state: persistent changes outside the AI system itself, including file writes, API calls, database mutations, and network actions

with language that paraphrases the CAISI RFI more faithfully: a generative AI model combined with software scaffolding that enables planning and actions affecting real-world systems or environments. The enumerated examples (file writes, API calls, database mutations, network actions) can stay as the appendix's own elaboration, but must be separated from the attributed definition -- e.g., "In practice, this means file writes, API calls, database mutations, and network actions."

Keep the `{cite:p}` citation.

## Part B: NIST Cyber AI Profile -- Fix "Priority 1" Framing

**Finding (C2/Perplexity PQ2):** The Cyber AI Profile uses focus areas (Secure, Defend, Thwart), not priority numbering. "Priority 1 -- the highest urgency" is editorial interpretation presented as source terminology.

**Edit:** In the "Identity Gap" section, replace:

> This is rated Priority 1 -- the highest urgency -- for both the "Secure" and "Thwart" focus areas.

with language that uses the profile's native structure. Something like: "The profile highlights this under its Secure and Thwart focus areas as a high-priority recommendation." Do not present numerical priority ratings as NIST terminology.

Note: Perplexity also flagged that the profile uses "Defend" not just "Secure" and "Thwart" -- verify the exact focus area names are Secure, Defend, Thwart (not Secure, Detect, Thwart or similar) when editing.

## Part C: OWASP Category Names -- Use Exact Taxonomy

**Finding (C1/Perplexity PQ3):** The OWASP source uses "Agent Goal Hijack" (ASI01), not "agent behavior hijack." Other names (Tool Misuse and Exploitation, Identity and Privilege Abuse, Cascading Failures, Human-Agent Trust Exploitation) are close but should match the source exactly.

**Edit:** In the "Threat Surface" section:
- Change "Agent behavior hijack" to "Agent goal hijack" (matching ASI01)
- Verify "Tool misuse" matches the source (ASI02 is "Tool Misuse and Exploitation" -- use the full name at first mention, can abbreviate after)
- Verify "Cascading failures" matches ASI08
- Verify "Identity and privilege abuse" matches ASI03
- Verify ASI09 "Human-Agent Trust Exploitation" is the exact name

If the OWASP version cited has been updated since the bib entry, note the version in the citation or add a footnote.

## Part D: Non-repudiation -- Soften Attribution

**Finding (unclustered/Perplexity PQ4):** Non-repudiation is an associated concern about auditing/accountability in the NCCoE paper, not a primary organizing property.

**Edit:** In the "Controls: Comprehensive action logging" paragraph, the NCCoE framing currently says: "The NCCoE concept paper frames this as non-repudiation: ensuring agents log their actions in a verifiable manner that binds back to human authorization."

Soften to something like: "The NCCoE concept paper raises a related concern: non-repudiation (the ability to verify that an action was taken and by whom) -- ensuring agents log their actions in a verifiable manner that connects back to human authorization."

This both softens the attribution and adds the parenthetical definition that the audit flagged as missing.

## Part E: Temporal Qualifier in Identity Gap

**Finding (C5):** The timeline claim "The comment periods for both the NCCoE paper and the CAISI RFI closed in early 2026. Implementation guidance is 12--24 months away." lacks an anchoring timestamp.

**Edit:** Add "As of early 2026," to anchor the sentence: "As of early 2026, the comment periods for both the NCCoE paper and the CAISI RFI had closed. Implementation guidance was estimated at 12 to 24 months from that baseline."

Also update the verb tenses to past tense since the comment periods have now closed (Perplexity confirmed).

## Part F: NIST CSF Citation

**Finding (C4):** The CISO Conversation section invokes the NIST Cybersecurity Framework with specific function names (GOVERN, IDENTIFY, PROTECT, DETECT, RESPOND, RECOVER) but has no citation. GOVERN is specific to CSF 2.0 (2024).

**Edit:**
1. Add to `book/references.bib` (alphabetical order, do not modify existing entries):

```bibtex
@techreport{nist_csf_2024,
  title = {The {NIST} Cybersecurity Framework ({CSF}) 2.0},
  author = {{National Institute of Standards and Technology}},
  year = {2024},
  institution = {National Institute of Standards and Technology},
  type = {NIST Cybersecurity White Paper},
  number = {NIST CSWP 29},
  doi = {10.6028/NIST.CSWP.29},
  note = {February 26, 2024}
}
```

2. Add `{cite:p}` after the CSF function list sentence.

## Part G: MCP Server Attack Surface -- One Sentence Addition

**Finding (C6):** Ch 12's handoff sentence specifically names "prompt injection via tool outputs" as covered in the appendix. The appendix covers indirect prompt injection generally but does not develop MCP server attack surfaces specifically.

**Edit:** Add one sentence to the "Agent behavior hijack" paragraph, after the sentence about research pipelines ingesting external documents:

"For pipelines using the Model Context Protocol or similar tool-calling frameworks, the tool outputs themselves become the injection surface -- any tool that returns external content can carry adversarial instructions back to the agent."

## Part H: Em-dash Cleanup

The appendix uses em-dashes (--) extensively. Replace all em-dashes with project-standard alternatives:
- Parenthetical asides: use parentheses or restructure
- Lists/elaborations: use colons
- Breaks: use periods or semicolons

Count before cleanup, count after. Target: zero em-dashes in final text.

## Part I: Source Status Framing

**Finding (Perplexity overall):** The appendix should explicitly state the document status for each source rather than grouping them all as "draft" or "pre-standard."

**Edit:** In the "Where This Is Headed" section, replace the blanket "all five sources reviewed for this appendix are in input-gathering or initial draft phases" with a more specific characterization:

- CAISI RFI: comment period closed, superseded by AI Agent Standards Initiative
- NCCoE concept paper: published as concept paper, progressing beyond draft
- OWASP Agentic Top 10: first public release (verify exact status descriptor)
- Cyber AI Profile: initial public review draft (IPRD)
- NIST AI Agent Standards Initiative: launched February 2026, actively convening

This gives the reader a more accurate snapshot and demonstrates awareness of the standards pipeline stages.

## Part J: Status Comment Update

Change `<!-- STATUS: Draft -->` to `<!-- STATUS: Revised -->`.

---

## Verification

1. CAISI definition is attributed paraphrase, not quoted definition
2. "Priority 1" removed; replaced with focus-area language
3. All OWASP category names match the cited source version
4. Non-repudiation is softened from organizing property to associated concern, with parenthetical definition
5. Temporal qualifier anchors the timeline claim
6. `nist_csf_2024` exists in `references.bib` with correct metadata
7. CSF sentence has inline `{cite:p}` citation
8. MCP sentence added to agent behavior hijack paragraph
9. Zero em-dashes remain
10. Source status framing is per-document, not blanket
11. No `\$` escaping issues in new text (no currency values in this appendix)
12. Run `seldon verify --fix` after all edits

## Do NOT

- Change the appendix's structure or argument arc
- Add new sections
- Remove any of the five existing citations
- Add citations beyond the NIST CSF addition (Part F)
- Touch any chapter files
- Modify the tenets, principles, or mapping in appendix-principles.md
- Modify any existing `references.bib` entries (append only)
