# Design Note: Pragmatics, MCP Lessons Learned, and FCSM 25-03 Routing

**Date:** 2026-03-29
**Session:** 8

## Sources Registered

1. Webb, B. (2026). Pragmatics: Delivering Expert Judgment to AI Systems. Zenodo. https://doi.org/10.5281/zenodo.18913092
2. Webb, B. (2025). Open Census MCP Server: Lessons Learned. GitHub.
3. Hoppe, T., Gonzalez, J., Mirel, L., & Schmitt, R. (2025). AI-Ready Federal Statistical Data. FCSM 25-03.

## Narrative Arc

The three documents form a chronological narrative:

1. **MCP lessons learned (summer 2025):** Built the Census MCP server. Discovered semantic smearing, the 90/10 rule, and MCP platform friction. Identified the judgment gap — the system could retrieve data but couldn't assess fitness for use.

2. **Pragmatics paper (March 2026):** Formalized the judgment gap as a missing semiotic layer (Morris, 1938). Built and empirically tested pragmatics as the solution. Demonstrated that 36 curated expert judgment items outperform 311 RAG chunks from the same source material. Named semantic smearing. Produced a reusable evaluation framework (CQS rubric + three-stage pipeline).

3. **FCSM 25-03 (May 2025, published context):** The federal statistical community independently recognizes the same gap — machine-readable ≠ machine-understandable — and proposes experiments to close it. The Pragmatics paper answers the question FCSM 25-03 poses.

## Key Design Decisions

- The Pragmatics paper and Concept Mapper are the book's two primary case studies. They represent different architectures (batch classification vs. consultation pipeline), different problem shapes (harmonization vs. fitness-for-use assessment), and different maturity stages.
- The MCP lessons learned doc feeds the book as practitioner experience, not as a citable publication. Its insights appear in chapter prose attributed to author experience or as design principles.
- FCSM 25-03 is a supporting citation, not a case study. It establishes that the federal community recognizes the problem the Pragmatics paper addresses.

## Dropped Material (Session 8)

The following documents were reviewed and not registered:
- CDC Considerations for Agentic Research in Public Health (2026) — background only
- CDC Considerations for Generative AI in Public Health (2026) — background only
- HHS AI Strategy (2025) — aspirational, not technical enough for practitioner audience
- HHS AI Use Case Inventory FY25 (CSV, 447 use cases) — compliance-driven, low signal
- CDC PHDS: Using AI to Improve Public Health Efficiency (2025) — surface-level case descriptions

These may be revisited if specific chapters need federal landscape context, but none earned a citation at this time.
