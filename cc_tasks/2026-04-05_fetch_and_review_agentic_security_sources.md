# CC Task: Fetch and Review Agentic AI Security Primary Sources

**Date:** 2026-04-05
**Type:** Research acquisition + targeted review
**Priority:** Medium
**Depends on:** None
**Blocks:** Potential supplementary chapter or appendix on security posture

---

## Objective

Fetch five primary source documents on agentic AI security governance. Review each for patterns, constructs, and frameworks usable in the book. Produce a structured summary for desktop session review.

This is NOT about making the book a security book. It is about equipping practitioners to have a productive conversation with their CISO/security counterparts using shared vocabulary and shared understanding of the threat model. The framing is "mission enablement": security that enables the work, not security that blocks it. Traditional approaches are too rigid for the pace of adversarial tooling; the whitehats need to become grey jedi (not too grey).

---

## Part 1: Document Acquisition

Fetch the following documents. Save each to `docs/security_sources/` with the filenames shown.

### Automatically fetchable (Claude Code can wget/curl these):

| # | Document | URL | Save As |
|---|----------|-----|---------|
| 1 | NIST CAISI RFI (Federal Register, docket NIST-2025-0035) | `https://public-inspection.federalregister.gov/2026-00206.pdf` | `nist_caisi_rfi_2026.pdf` |
| 2 | NIST AI Agent Standards Initiative announcement | `https://www.nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure-ai-agents` | `nist_agent_standards_initiative_2026.html` |
| 3 | NCCoE Concept Paper: AI Agent Identity and Authorization | `https://www.nccoe.nist.gov/sites/default/files/2026-02/accelerating-the-adoption-of-software-and-ai-agent-identity-and-authorization-concept-paper.pdf` | `nccoe_agent_identity_concept_2026.pdf` |
| 4 | OWASP Top 10 for Agentic Applications 2026 | `https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/` | `owasp_agentic_top10_2026.html` |

### May require manual fetch (flag if automated fetch fails):

| # | Document | URL | Save As | Notes |
|---|----------|-----|---------|-------|
| 5 | NIST IR 8596 (initial public draft): Cybersecurity Profile for AI Systems | Check CSRC: `https://csrc.nist.gov/pubs/ir/8596/ipd` | `nist_ir_8596_cyber_ai_profile_2025.pdf` | Dec 2025 draft. May require clicking through CSRC download page. If automated fetch fails, flag for Brock to download manually. |

### Fetch instructions:

```bash
mkdir -p docs/security_sources
cd docs/security_sources

# 1. NIST CAISI RFI
curl -L -o nist_caisi_rfi_2026.pdf "https://public-inspection.federalregister.gov/2026-00206.pdf"

# 2. NIST Agent Standards Initiative (save as HTML, extract text)
curl -L -o nist_agent_standards_initiative_2026.html "https://www.nist.gov/news-events/news/2026/02/announcing-ai-agent-standards-initiative-interoperable-and-secure-ai-agents"

# 3. NCCoE Concept Paper
curl -L -o nccoe_agent_identity_concept_2026.pdf "https://www.nccoe.nist.gov/sites/default/files/2026-02/accelerating-the-adoption-of-software-and-ai-agent-identity-and-authorization-concept-paper.pdf"

# 4. OWASP Agentic Top 10 (HTML page with embedded content)
curl -L -o owasp_agentic_top10_2026.html "https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/"

# 5. NIST IR 8596 -- try direct PDF link first
curl -L -o nist_ir_8596_cyber_ai_profile_2025.pdf "https://nvlpubs.nist.gov/nistpubs/ir/2025/NIST.IR.8596.ipd.pdf"
```

**If any fetch fails:** Report which document failed and why. Do NOT skip it silently. Brock will fetch manually.

**Verify all downloads:**
```bash
ls -la docs/security_sources/
file docs/security_sources/*
```

Confirm each file is non-empty and the correct type (PDF or HTML).

---

## Part 2: Targeted Review

For each successfully fetched document, produce a review focused ONLY on patterns usable in the book. Write output to `docs/security_sources/review_summary.md`.

### Review lens (apply to each document):

**DO extract:**
- Threat taxonomies or attack surface categories that map to LLM workflow failure modes
- Governance patterns that translate to research workflow governance (inventory, least-privilege, audit trails, evidence chains)
- Identity/authorization patterns applicable to pipeline component permissions
- Any framework for scoping governance investment (like CBRA's multiplicative scoring)
- Specific data points that ground the argument (e.g., "92% lack visibility into AI agent identities")
- Vocabulary/terminology that the book's audience would encounter from their CISO counterparts
- Timeline/horizon information (when standards arrive, what the gap looks like)

**DO NOT extract:**
- Enterprise product recommendations or vendor-specific guidance
- Detailed implementation instructions for IAM systems
- Regulatory compliance checklists
- Anything the book's audience (data scientists/statisticians) cannot act on

### Output format for each document:

```markdown
## [Document Title]
**Source:** [URL]
**Date:** [Publication date]
**Type:** [Federal Register / NIST pub / OWASP framework / etc.]

### Usable Patterns
1. [Pattern name]: [1-2 sentence description of what it is and how it maps to the book]
2. ...

### Key Data Points
- [Specific numbers, dates, or findings worth citing]

### Vocabulary for Shared Understanding
- [Terms the CISO will use that the practitioner needs to know]

### Citable? 
[Yes/No + BibTeX key suggestion if yes]

### Cross-chapter Relevance
- Ch X: [why]
- Ch Y: [why]
```

---

## Part 3: Optional Berkeley CLTC Paper

If time and context permit, also attempt to fetch:

| Document | URL | Save As |
|----------|-----|---------|
| Berkeley CLTC "Agentic AI Risk Management Standards Profile" (Feb 2026) | Search for it at `https://cltc.berkeley.edu/` | `berkeley_cltc_agentic_risk_2026.pdf` |

This is an academic analysis of why the EU AI Act doesn't cover agentic systems. Lower priority than the five above. If it requires institutional access or is not freely available, skip and flag.

---

## Acceptance Criteria

1. All fetchable documents saved to `docs/security_sources/`
2. Any unfetchable documents clearly flagged with reason
3. `review_summary.md` produced with structured review per document
4. Review focuses on patterns, not implementation details
5. Each document assessed for citability (primary federal source vs. vendor white paper)
6. `seldon verify --fix` passes after file creation

---

## What Happens Next (Informational, not part of this task)

Desktop session will review `review_summary.md` and decide:
- Which patterns get woven into existing chapters (Ch 10, Ch 12, others)
- Whether a supplementary chapter or appendix on "Security Posture for AI Workflows" is warranted
- Which documents earn BibTeX entries
- Framing: mission enablement, not security theater. The adversaries are already using these tools. The practitioners need to be able to work with (not against) their security teams.
