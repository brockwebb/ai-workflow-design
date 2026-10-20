# CC Task: Write Agentic AI Security Appendix + Build Integration

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Reference:** Security appendix decision gate (1826188c, closed Session 27), task `1f6c25b1`, `docs/security_sources/review_summary.md`
**Targets:**
- CREATE `book/appendix-security.md`
- MODIFY `book/myst.yml` (TOC insertion)
- MODIFY `book/references.bib` (append 5 BibTeX entries)

---

## Context

The agentic AI security gap was confirmed in Ch 12 AD-020 (calibration run 010, convergence 4 cluster). Author decision: standalone appendix rather than Ch 12 insertion. Ch 12's Five Safes structure stays intact for pipeline workflows. The appendix covers the additional security surface that agentic systems introduce -- tool authorization, agent identity, prompt injection via tool outputs, MCP server attack surfaces, runtime boundary enforcement.

**Framing:** Mission enablement for a CISO conversation. Shared vocabulary, not security engineering. The reader is a data scientist or statistician who needs to have a productive conversation with their CISO about deploying agentic AI workflows. The appendix gives them the vocabulary and the framework references to do that.

**Audience:** Same as Ch 12's dual audience -- practitioners building AI workflows AND security/IT professionals supporting them.

**Tone:** Matches the book. No throat-clearing, no academic filler, no broad unverified claims. Direct, practical, grounded. Same "enabling, not prohibitive" framing as Ch 12.

**Sources (all reviewed in `docs/security_sources/review_summary.md`):**
1. OWASP Top 10 for Agentic Applications 2026
2. NCCoE Agent Identity and Authorization Concept Paper (Booth et al. 2026)
3. NIST CAISI RFI on Agent Security (January 2026)
4. NIST IR 8596 iprd — Cyber AI Profile (December 2025)
5. NIST AI Agent Standards Initiative announcement (February 2026)

---

## Part A: Create `book/appendix-security.md`

Create the file with the content below. The MyST target label `(appendix-security)=` at the top enables the `{ref}` cross-reference from Ch 12.

### File content

```markdown
(appendix-security)=
# Appendix: Agentic AI Security Considerations

<!-- STATUS: Draft -->
<!-- PURPOSE: Supplement to Chapter 12 — security surface introduced by agentic AI systems -->
<!-- AUDIENCE: Practitioners building AI workflows AND security/IT professionals supporting them -->
<!-- FRAMING: Mission enablement for CISO conversation, shared vocabulary, not security engineering -->

Chapter 12 covered security controls for AI workflows using the Five Safes framework. That framework assumes the workflow is a predefined pipeline -- the designer specifies what happens at each step, and the system executes it. Agentic AI systems break that assumption. When an AI autonomously selects which tools to invoke, what data to access, and what actions to take at runtime, the security surface changes in ways the Five Safes model was not designed to address.

This appendix covers those additional considerations. It is not a security engineering manual. It is the vocabulary and framework you need to have a productive conversation with your CISO about deploying agentic AI workflows in an institutional environment.

## What Makes Agents Different

The boundary is not capability -- it is autonomy over external state. NIST's Center for AI Standards and Innovation defines an AI agent system as a generative AI model plus scaffolding software that enables autonomous actions affecting external state: persistent changes outside the AI system itself, including file writes, API calls, database mutations, and network actions {cite:p}`nist_caisi_rfi_2026`. Standalone chatbots and retrieval-augmented generation systems that do not take autonomous actions fall outside this boundary.

This distinction matters for governance. If your pipeline reads documents, classifies them, and writes results to a file following a script you wrote, Chapter 12's Five Safes framework covers it. If your system decides which documents to read, which tools to call, and what to write based on runtime reasoning, you are in agentic territory and need the additional controls described here.

## The Threat Surface

The OWASP Top 10 for Agentic Applications provides the most practitioner-accessible threat taxonomy available {cite:p}`owasp_agentic_top10_2026`. Three categories are most relevant to research workflows.

**Agent behavior hijack.** An agent processing external content -- a document, a web page, a dataset -- encounters adversarial instructions embedded in that content and deviates from its assigned task. This is indirect prompt injection applied to an agent with tool access. The risk is not that the agent produces wrong text; it is that the agent takes wrong actions -- writing files, calling APIs, or querying databases in ways the operator never intended. Research pipelines that ingest documents from external sources and then act on them are the target environment for this attack class.

**Tool misuse.** An agent is tricked into using its granted tools in unintended ways. The mitigation is straightforward: the fewer tools an agent has access to and the more narrowly scoped each tool is, the smaller the misuse surface. This is a direct argument for designing tool APIs with minimal capability footprint -- not for performance, but because tool scope is the primary governance control available to practitioners without platform-level security infrastructure.

**Cascading failures.** In multi-agent systems or pipelines where one agent's output feeds another's input, errors and compromises propagate. Each downstream agent treats the upstream output as ground truth. This is the multi-agent version of garbage-in, garbage-out, but across trust boundaries where each agent may amplify errors through its own reasoning. The governance implication: inter-agent outputs need the same validation discipline as external data inputs.

Two additional threats are worth understanding even if they are less directly within a practitioner's control. Identity and privilege abuse (agents impersonating other agents or escalating access through identity weaknesses) motivates the identity infrastructure discussion below. Memory and context poisoning (corruption of an agent's persistent state to distort reasoning) is relevant to any system using vector databases, conversation histories, or structured memory stores -- poisoned context produces systematically wrong outputs that may not be detectable without explicit provenance tracking.

## The Identity Gap

Agent identity is the central unsolved problem in agentic AI security. All five sources reviewed for this appendix converge on the same conclusion from different angles.

The NCCoE concept paper organizes the problem around three properties: identification (what metadata uniquely identifies this agent?), authentication (how does the agent prove it is that agent?), and authorization (what is the agent permitted to do, and under what conditions?) {cite:p}`nccoe_agent_identity_2026`. For most research pipelines today, the honest answer to all three questions is "we have not thought about this." Agents run under a shared service account, present whatever credentials they inherit from the orchestration layer, and have access to whatever the service account can reach.

The NIST Cyber AI Profile makes the recommendation explicit: give AI systems unique and traceable identities and credentials to track their activity {cite:p}`nist_cyber_ai_profile_2025`. This is rated Priority 1 -- the highest urgency -- for both the "Secure" and "Thwart" focus areas. For practitioners, this means each pipeline component that acts autonomously should have its own identity, not a shared service account.

The practical gap is that mature, standardized identity infrastructure for agents does not yet exist. The NIST AI Agent Standards Initiative, launched in February 2026, is investing in research on agent authentication and identity infrastructure {cite:p}`nist_aasi_2026`. The NCCoE concept paper identifies OAuth 2.0/2.1, OpenID Connect, and the Model Context Protocol as candidate standards under evaluation. The comment periods for both the NCCoE paper and the CAISI RFI closed in early 2026. Implementation guidance is 12--24 months away.

This pre-standard gap is the context a CISO will use to frame the conversation. They will not evaluate your agentic workflow against a compliance checklist that does not yet exist. They will use a risk acceptance framework. Your job is to articulate what controls you have implemented, what gaps remain, and why the mission value justifies the residual risk. The vocabulary in this appendix helps you do that.

## Controls That Work Today

Standards are developing. But four controls are available now, require no platform-level infrastructure, and are valued by both security frameworks and research integrity norms.

**Least-privilege tool access.** Grant each agent only the tools and permissions it needs for its specific task. If an agent classifies documents, it does not need write access to a database. If it queries a database, it does not need network access beyond that database. Scope tools narrowly. Accept capability loss as a security tradeoff. The CAISI RFI explicitly identifies least privilege as a foundational agent security principle {cite:p}`nist_caisi_rfi_2026`.

**Comprehensive action logging.** Log every tool invocation, every input, every output, every decision point. Make the logs tamper-evident. The NCCoE concept paper frames this as non-repudiation: ensuring agents log their actions in a verifiable manner that binds back to human authorization {cite:p}`nccoe_agent_identity_2026`. For researchers, this is the same artifact that supports reproducibility -- the chain of custody from human decision to agent action. Audit trails are the one governance primitive that works today, has no downside, and resonates with both security and research integrity audiences.

**Human checkpoints for consequential actions.** Not every agent action needs human approval. But actions that modify external state -- file writes, API calls that change data, database mutations -- should have friction proportional to their consequence. The CAISI RFI enumerates three tiers of controls: model-level robustness, agent-system-level restrictions, and human oversight controls including approvals for consequential actions {cite:p}`nist_caisi_rfi_2026`. Design your checkpoints to require actual engagement, not click-through approval. Oversight fatigue -- where humans approve reflexively rather than critically -- is itself a named threat (OWASP ASI09: Human-Agent Trust Exploitation).

**Supply chain provenance for components.** Know where your models came from, what data they were trained on, what dependencies your orchestration layer pulls in, and whether any of those dependencies make network calls you did not expect. The Cyber AI Profile treats all data input -- training and inference -- as supply chain {cite:p}`nist_cyber_ai_profile_2025`. For practitioners assembling pipelines from open-source components, this means model cards, fine-tuning provenance, and dependency audits are security artifacts, not just documentation.

## The CISO Conversation

If you have read this far, you have the vocabulary for a productive conversation. Here is how to structure it.

**Start with the boundary.** Explain what your system does in terms of external state changes. "Our pipeline reads survey responses, classifies them using an LLM, and writes classifications to a database" is a clear scope statement. "We are using AI" is not.

**Map to what they know.** The NIST Cybersecurity Framework (GOVERN, IDENTIFY, PROTECT, DETECT, RESPOND, RECOVER) is the framework your CISO already uses. The Cyber AI Profile maps AI-specific considerations to those functions {cite:p}`nist_cyber_ai_profile_2025`. You do not need to master the mapping. You need to show that your controls (logging, least privilege, human checkpoints, supply chain awareness) map to their categories.

**Name the gap honestly.** Agent identity infrastructure is pre-standard. Say so. Explain what you are doing in the absence of standards (scoped permissions, logged actions, human approval for consequential operations) and why the mission value of the workflow justifies accepting the residual risk.

**Frame security as enabling.** The controls in this appendix and in Chapter 12 exist so you can use these tools, not so you cannot. A CISO who understands your workflow, sees your controls, and knows you understand the gaps is far more likely to approve deployment than one who encounters a system with no articulated security posture. The NIST Agent Standards Initiative itself frames its work as mission enablement -- security standards designed to accelerate adoption, not restrict it {cite:p}`nist_aasi_2026`.

## Where This Is Headed

As of early 2026, all five sources reviewed for this appendix are in input-gathering or initial draft phases. The CAISI RFI, the NCCoE concept paper, and the NIST AI Agent Standards Initiative are all collecting comments and conducting listening sessions. The OWASP Agentic Top 10 is in its first public draft. The Cyber AI Profile is an initial preliminary draft.

This means practitioners deploying agentic workflows today are building ahead of established security standards. That is not a reason for paralysis. It is context that shapes realistic expectations. The controls described above are portable -- they will remain valid regardless of what standards emerge. The vocabulary is durable -- NIST's three-tier control model, OWASP's threat taxonomy, and the NCCoE's identity/authentication/authorization framework will be recognizable in whatever standards follow.

Build the audit trail now. Scope permissions tightly now. Log everything now. When the standards arrive, you will be ahead of them rather than scrambling to comply.
```

### End of file content

**Notes:**
- No em-dashes anywhere. Double hyphens (`--`) used for parenthetical dashes.
- Currency values escaped if any appear (none in this appendix).
- All citations use `{cite:p}` role -- no bare prose citations.
- No specific agencies, companies, or individuals named as friction examples.
- No implementation code.
- No vendor names beyond protocol names (MCP, OAuth) which are standards, not vendor products.
- The `(appendix-security)=` label at the top enables the `{ref}\`appendix-security\`` cross-reference from Ch 12.

---

## Part B: Update `book/myst.yml` TOC

In the `toc:` section, insert the new appendix entry **after** `appendix-principles.md` and **before** `glossary.md`:

Current:
```yaml
    - file: appendix-principles.md
    - file: glossary.md
```

Change to:
```yaml
    - file: appendix-principles.md
    - file: appendix-security.md
    - file: glossary.md
```

This places the security appendix as the second appendix, after the principles reference and before the glossary. Both HTML site build and PDF export will pick up the new file in this position.

---

## Part C: Append BibTeX entries to `book/references.bib`

Append the following five entries to `book/references.bib` in alphabetical order relative to existing entries. Do NOT modify any existing entries. Insert each entry at the correct alphabetical position.

### Entry 1: `nccoe_agent_identity_2026`

```bibtex
@techreport{nccoe_agent_identity_2026,
  author       = {Booth, Harold and Fisher, Bill and Galluzzo, Ryan and Roberts, Joshua},
  title        = {Accelerating the Adoption of Software and {AI} Agent Identity and Authorization},
  institution  = {National Cybersecurity Center of Excellence, National Institute of Standards and Technology},
  year         = {2026},
  month        = {February},
  note         = {Concept Paper (Draft); public comment period February 5 -- April 2, 2026},
  url          = {https://www.nccoe.nist.gov/sites/default/files/2026-02/accelerating-the-adoption-of-software-and-ai-agent-identity-and-authorization-concept-paper.pdf}
}
```

### Entry 2: `nist_aasi_2026`

```bibtex
@misc{nist_aasi_2026,
  author       = {{National Institute of Standards and Technology, Center for AI Standards and Innovation}},
  title        = {{AI Agent Standards Initiative: Ensuring a Trusted, Interoperable, and Secure Agentic Frontier}},
  year         = {2026},
  month        = {February},
  note         = {Program page, created 2026-02-17},
  url          = {https://www.nist.gov/caisi/ai-agent-standards-initiative}
}
```

### Entry 3: `nist_caisi_rfi_2026`

```bibtex
@techreport{nist_caisi_rfi_2026,
  author       = {{National Institute of Standards and Technology, Center for AI Standards and Innovation}},
  title        = {Request for Information Regarding Security Considerations for Artificial Intelligence Agents},
  institution  = {National Institute of Standards and Technology, U.S. Department of Commerce},
  year         = {2026},
  month        = {January},
  note         = {Federal Register docket NIST-2025-0035; FR Doc. 2026-00206},
  url          = {https://federalregister.gov/d/2026-00206}
}
```

### Entry 4: `nist_cyber_ai_profile_2025`

```bibtex
@techreport{nist_cyber_ai_profile_2025,
  author       = {Megas, Katerina and Cuthill, Barbara and Dotter, Marissa and Garris, Michael and Khemani, Ishika and Patrick, Bronwyn and Schiro, Noah and Snyder, Julie Nethery and Zarei, Mohammad},
  title        = {Cybersecurity Framework Profile for Artificial Intelligence ({Cyber AI Profile})},
  institution  = {National Institute of Standards and Technology, U.S. Department of Commerce},
  year         = {2025},
  month        = {December},
  number       = {NIST IR 8596 iprd},
  note         = {Initial Preliminary Draft},
  url          = {https://doi.org/10.6028/NIST.IR.8596.iprd}
}
```

### Entry 5: `owasp_agentic_top10_2026`

```bibtex
@misc{owasp_agentic_top10_2026,
  author       = {{OWASP GenAI Security Project, Agent Security Initiative}},
  title        = {{OWASP Top 10 for Agentic Applications 2026}},
  year         = {2025},
  month        = {December},
  note         = {Published December 9, 2025; peer-reviewed by 100+ experts},
  url          = {https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/}
}
```

---

## Verification

After all three parts are applied:

1. `book/appendix-security.md` exists and starts with `(appendix-security)=`
2. `book/myst.yml` TOC includes `appendix-security.md` between `appendix-principles.md` and `glossary.md`
3. `book/references.bib` contains all five new entries in correct alphabetical position
4. No existing entries in `references.bib` were modified
5. Run `myst build --html` from `book/` and verify the appendix renders and the Ch 12 `{ref}` link resolves (after the Ch 12 pointer CC task is also executed)
6. Run `seldon verify --fix` to update the graph

## Do NOT

- Edit `book/chapter-12.md` (the pointer sentence is in a separate CC task)
- Edit any other chapter file
- Modify existing BibTeX entries
- Add implementation code, vendor-specific tool recommendations, or security engineering procedures
- Use em-dashes anywhere
- Add specific agency names as examples of institutional friction
- Include the MITRE ATLAS, SPIFFE/SPIRE, SCIM, or NGAC details from the review summary -- those are too implementation-specific for this appendix's scope
