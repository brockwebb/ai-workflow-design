# CC Task: Bone Drop — Ch 13 Shadow IT and Workaround Culture

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Target chapter:** `book/chapter-13.md` (Deploying in Institutional Environments)
**Type:** Design notes for future revision — not a chapter draft

---

## Notes to Incorporate

### Shadow IT as Governance Failure, Not People Failure

When institutional controls block access to AI tools for extended periods, practitioners don't wait — they work around the controls. This isn't malicious. It's rational behavior in response to irrational constraints. People introduce:

- Unvetted models (personal API keys, free-tier services)
- Workflows without provenance tracking
- Data flows that bypass security review
- Tools whose supply chain and data residency properties are unknown

The design principle: **if your governance creates a gap between "what people need to do their jobs" and "what's officially permitted," you haven't created security — you've created shadow IT.** The workarounds introduce exactly the risks that the controls were supposed to prevent, but now they're invisible to the security team.

### The Access Gap Creates Competence Gaps

Prolonged blocked access doesn't just delay work — it degrades the quality of thinking about the work. Teams without hands-on experience build mental models from reading, conference talks, and speculation. When they finally get access, they:

- Solve problems that don't exist (bikeshedding extraction formats, inventing comparison tests for things that don't matter)
- Miss problems that do exist (chunking strategy, prompt fragility, model version drift)
- Over-engineer simple decisions because they lack the intuition that comes from having run things and watched them fail

Example pattern (universalized, no agency named): a team preparing to deploy a chatbot spent weeks debating whether to extract content from HTML or PDF for their RAG pipeline, whether to use multiple extraction methods and compare, whether a particular markdown extractor preserved document structure. The actual decision — print to PDF, chunk by section, test with real queries — would have taken an afternoon with hands-on access. The absence of access turned a simple engineering decision into an open-ended research project.

### Murphy's Law Acknowledgment

Even with approved technologies used the approved way, things go wrong. Acknowledge this honestly. The goal of governance isn't to prevent all failures — it's to make failures detectable, contained, and recoverable. The design patterns in Chs 7-8 (checkpoints, evaluation) serve governance by making failure visible, not by pretending it won't happen.

### Connection to Tenets/Principles

- **Tenet 4 (Governance must enable execution):** Shadow IT is the market signal that governance is failing to enable.
- **Tenet 7 (Adapt continuously):** Static governance in a fast-moving technology landscape guarantees workarounds.
- **WP 2 (Slow governance prevents delivery):** The direct cause of the workaround culture.
- **WP 6 (Access defines capability):** Blocked access doesn't just slow delivery — it erodes the team's ability to make good technical decisions.

---

## Source Material

- Session 6 conversation notes (shadow IT discussion, bikeshedding example, access gap analysis)
- Ch 13 existing draft — "Authorization and Procurement Gap" and "Cloud Parity Gap" sections
- Census AI strategy brainstorm materials (governance inversion, "flow or drown")
