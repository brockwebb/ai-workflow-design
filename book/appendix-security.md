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
