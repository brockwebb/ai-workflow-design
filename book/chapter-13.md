# Chapter 13: Deploying in Institutional Environments

<!-- STATUS: Draft -->
<!-- AUDIENCE: Practitioners navigating institutions, IT/governance teams, program managers -->
<!-- Diagnostic lens: Compressed tenets and working principles stress-tested against institutional reality -->
<!-- Primary Tenet: Governance must enable execution -->
<!-- Primary Working Principle: Slow governance prevents delivery -->

## The Last Mile Is Organizational

You have designed the workflow. You have secured it. The pipeline runs on your laptop, costs $47, and finishes in six hours, replacing a task that currently takes three full-time equivalents four weeks each quarter. Now deploy it inside an organization where the cloud service you need is not authorized, the procurement cycle for the one that is takes fourteen months, and the governance review board meets every six weeks.

Welcome to institutional deployment.

The obstacles at this point are not technical. They are procedural, cultural, and structural. The technology works. The security model exists (Chapter 12). The remaining gap is between "we know what to build" and "it is actually running in production." This chapter uses the book's compressed tenets and working principles as the diagnostic lens for that gap. Each section maps to the specific tenets and principles that institutional friction violates, and the practical paths forward that honor both the institution's obligations and the mission's requirements.

The core tension is real: these institutions exist to produce trusted outputs. The governance and process overhead is not arbitrary. It was built to protect something valuable. The problem arises when protections designed for a different era become obstacles in the current one. The goal is not to eliminate governance. It is to make governance proportionate, risk-based, and fast enough that it enables delivery rather than preventing it.

*Tenet: Governance must enable execution. Working Principle: Slow governance prevents delivery.* Those are the standards against which every institutional process in this chapter is measured.

## The Authorization and Procurement Gap

*Tenet in tension: "Deliver capability quickly" vs. authorization and procurement timelines.*

There are concrete gates between a working prototype and a production deployment, and they are measured in months to years, not weeks.

FedRAMP authorization is the primary gate for cloud services in government environments. A provider must achieve FedRAMP authorization at the appropriate impact level before an agency can use the service for production workloads. This process takes months to years for providers to complete. The newest, most capable AI services are available commercially months before they appear in authorized catalogs.

Authority to Operate (ATO) processes for internal systems add another layer. These were designed for a world where you procure and operate a system for five to ten years. The assumption is that the system is relatively stable once authorized. AI workflows violate that assumption: the model landscape changes monthly, prompts are refined continuously, and the evaluation metrics shift as the use case matures.

Government procurement cycles run six to eighteen months for major contracts. The AI tool landscape changes weekly. By the time a procurement is complete, the tool you specified in the requirements document may have been superseded, deprecated, or repriced.

This temporal mismatch is structural. It is not fixable by working harder or writing better justifications. It requires architectural and procedural changes.

**Practical paths forward.** Authorize platforms and patterns, not specific model versions. The security controls, data handling procedures, and monitoring infrastructure are what need authorization. Models are components within that authorized envelope, swappable without re-authorization as long as they meet the established security and performance criteria. This is the single highest-leverage change: enterprise-level authorization with tiered risk assessment, rather than per-project authorization for each system.

Use faster procurement vehicles where they exist. Task-order contracts with pre-approved vendors, blanket purchase agreements for AI services, and micro-purchases under simplified acquisition thresholds can get capability in the door while longer-term contracts work through the pipeline.

Build model-agnostic architectures (Chapter 8's evaluation harness, Chapter 1's principle of model replaceability). If you can swap providers without rewriting code, procurement timelines hurt less. Your architecture should never be coupled to a single vendor's API. The evaluation infrastructure that lets you compare models also lets you respond to procurement constraints.

Organizations that have moved to enterprise ATO models report authorization timelines dropping from months to weeks for new workloads within the authorized envelope. The pattern works. It requires institutional will to implement it.

*How long would it take you to get a new AI service approved for use in your organization? If you don't know, find out. That number shapes every technical decision you make.*

## The Cloud Parity Gap

*Tenet in tension: "Infrastructure enables delivery" meets the reality of government cloud availability.*

Government cloud environments, GovCloud, Azure Government, and their equivalents, lag commercial availability by months to over a year. The latest models, features, and APIs arrive in commercial regions first. By the time a service is available in an authorized government environment, it may already be superseded commercially.

This is improving, but slowly. The gap is partly a FedRAMP pipeline problem: providers pursue commercial authorization first because the market is larger. Government-specific regions are secondary priorities. The gap is also partly a demand signal problem: if agencies cannot articulate their requirements early in the provider's roadmap process, they get what the commercial market drives.

The practical architecture is hybrid, and it should be designed as hybrid from the start, not patched into hybrid after deployment.

Some workloads belong on authorized cloud infrastructure, where the latest authorized models live and where scale is available. Some workloads belong on-premises, where data never leaves the organization's network and where the most sensitive processing happens. Some workloads, particularly smaller models for routine tasks, run on local inference hardware. Pruned, quantized, and distilled models are getting substantially better, and for many tasks they are sufficient. But local inference on government hardware will not match frontier provider capability for the foreseeable future. Be honest about that constraint rather than pretending it doesn't exist.

And some uses, the professional development and exploration use cases that Chapter 12 identified as safe projects, belong on public services with no special authorization required.

The organizations that navigate this best treat the hybrid portfolio as a deliberate architecture, with clear criteria for which workloads go where, rather than an accident of procurement history.

*Working Principle: Access defines capability. You cannot use what you cannot reach. The cloud parity gap is the operational expression of that principle.*

## Governance: Enough and No More

*Tenet: Governance must enable execution. Working Principle: Slow governance prevents delivery.*

This section carries the most weight in the chapter, because governance is where institutional friction concentrates.

**The failure mode.** Governance processes that become the work instead of supporting the work. Review boards that meet monthly and have six-week backlogs. Approval chains requiring six signatures from people who do not understand what they are approving. Risk assessments that take longer than the project they are assessing. The output of this failure mode is binary and bad: either people stop trying (governance wins, mission loses) or people start using tools without telling anyone (mission continues short-term, institutional trust erodes long-term).

Both outcomes violate the compressed tenets. The first violates "deliver capability quickly." The second violates "trust defines the mission." A governance system that produces either outcome is a governance failure, regardless of how thorough its review process looks on paper.

**Tiered review, not uniform review.** Not every AI use case needs the same governance. Treating them the same is itself a governance failure, because it wastes review capacity on low-risk uses while creating bottlenecks that delay high-risk uses that actually need scrutiny.

*Low risk:* Public LLM for literature review, brainstorming, code assistance on non-sensitive work. Light-touch: self-attestation, published guidelines, no review board required.

*Medium risk:* AI processing on de-identified or public data in approved environments. Standard review: documented data handling, approved platform, periodic audit.

*High risk:* Production pipelines on confidential data. Full review with provenance requirements, dual-path verification, evidence chain documentation, and ongoing monitoring.

This tiering is not novel. It is risk-based controls applied to AI, the same risk-based thinking the statistical community applies to data access through frameworks like the Five Safes (Chapter 12).

**The governance inversion.** The current state in many organizations: governance is a gate. Every project proves innocence before proceeding. The process is the work. The target state: governance is embedded in tools and automated controls. Systems enforce boundaries in real time. Data loss prevention technology that prevents sensitive data from reaching unapproved endpoints is a concrete example. It is already operational in some organizations. It is a technical control that replaces a manual review step, faster and more reliable than a human reviewer checking a form.

The shift from governance-as-gate to governance-as-infrastructure is where the compressed tenet "governance must enable execution" becomes operational. The gate model asks "should we allow this?" The infrastructure model asks "how do we enable this safely?"

**The incentive problem.** Governance-as-gate is also governance-as-power, and this is a structural observation, not a personal criticism. The people running review processes are protecting something real. Eliminating the gate redistributes authority. That is why "common sense" arguments for streamlining governance never gain traction. The argument is not about common sense. It is about institutional authority.

IT and security teams are measured on uptime, incident prevention, and compliance. They are not measured on how quickly capability ships. The incentive structure rewards saying no and penalizes saying yes to anything novel. This is not malice. It is rational behavior in a misaligned incentive structure.

The fix is structural: measure governance teams on time-to-capability alongside risk metrics. Make "enabled X teams to deploy safely in Y weeks" a performance metric alongside "zero security incidents." When the incentive structure rewards enabling and protecting simultaneously, the behavior follows.

Organizations that have implemented dual metrics, measuring both protection and enablement, report measurably faster authorization timelines without increased incident rates. The evidence suggests the tradeoff between speed and security is less real than institutional culture assumes.

*Think about the last time a governance process prevented you from doing something. Was the risk it was managing real and proportionate? What would a risk-based alternative have looked like?*

## Building Organizational Capability

*Tenet: Build internal capability. Working Principle: Adoption determines impact.*

Tools without capable people are shelfware. Procurement is the easy part. Building internal capacity to evaluate, operate, and adapt AI workflows is hard and takes years.

Training in this context is not "here's how to write a prompt." Training is methodology: understanding the stochastic nature of the tools (Chapter 1), designing evaluation frameworks (Chapter 8), building evidence chains (Chapters 9-10), knowing when to trust and when to verify (the foreword's Feynman frame). The goal is a workforce that can make sound decisions about AI use independently, not a workforce that follows a script.

Build distributed capability, not a centralized AI team. A centralized unit that "does AI" for everyone becomes a bottleneck indistinguishable from the governance bottleneck described above. The goal is distributed capability: the people doing the mission work can use the tools effectively. The centralized team, if one exists, provides standards, training, shared infrastructure, and consulting, not a service window.

The goal is auditable, defensible work at scale by the workforce, not by a specialized unit. This is what "adoption determines impact" means operationally. A tool that ten people can use expertly has less organizational impact than a tool that two hundred people can use competently. Design training and infrastructure for the two hundred.

Do not outsource understanding. Vendors will always outpace internal teams on capability. That is fine. But if the organization does not build internal capacity to *evaluate* what vendors offer, it cannot make good procurement decisions, cannot assess whether outputs are defensible, and cannot adapt when the vendor relationship changes. Understanding is the one thing you cannot outsource.

## Earning Trust Incrementally

*Tenet: Experiment under control.*

Institutional trust is earned, not declared. This is the organizational version of Level 3 being earned, not assumed (Chapter 1). The pattern that works:

Start with a small pilot on non-sensitive data. Demonstrate that the controls work, the outputs are defensible, and the evidence chain holds. Document everything. Expand scope incrementally. Build a track record that earns institutional trust through demonstrated competence, not through arguments about potential.

This creates the *visible capability gap* that drives institutional change. When one team using modern tools produces in two weeks what another spent a quarter on, the contrast is politically legible. Demonstrated speed differential is the lever. Show it, do not debate it. Arguments about AI's potential are abstract. A completed project with documented quality metrics is concrete.

Success patterns exist. Teams that started with pilot projects on public data and expanded to production workloads after demonstrating reliability. Governance processes that were streamlined after track records were established. Authorization timelines that shortened as institutional experience accumulated. These are real patterns in organizations that have navigated this path.

The common thread: they started small, documented rigorously, built trust incrementally, and let results speak louder than arguments.

## The Culture Shift

*Tenet: Adapt continuously.*

Most institutional IT culture is built around planned releases: quarterly, biannual, annual. AI workflows operate on continuous delivery. The model changes. Evaluation scores shift. Prompts get refined. The workflow that was optimal last month may not be optimal this month.

The shift required is from "approve once, run indefinitely" to "authorize the pattern, monitor continuously." From "change is risk" to "inability to change is risk." This is a genuine culture shift, not a process tweak, and it will not happen quickly.

There is a deeper dynamic. Organizations that fought hard to acquire infrastructure, tools, and capabilities develop a hoarding behavior that is rational given their experience. Getting anything new takes years of justification, procurement, and authorization. Of course people cling to what they have. The grip loosens naturally when the acquisition environment improves: when getting new capability takes weeks instead of years, the attachment to existing capability diminishes.

Transience as a design principle, the willingness to let go of infrastructure and tools when something better exists, is the hardest cultural shift this chapter describes. It requires not just different processes but different institutional values. And it requires the procurement and authorization environment to support it, because nobody will let go of working infrastructure if they believe they cannot replace it.

This is the hardest part. Name it honestly. It is a culture problem, and culture changes slowly. But it changes. Organizations that five years ago could not imagine cloud deployment now run production workloads in authorized cloud environments. The trajectory matters more than the current state.

### Thought Experiment

Your organization has ten teams that want to use AI for different tasks, from literature review to production data classification. Under current governance, each team files a separate request, each goes through full review, and the average time from request to approval is nine months. Three teams give up before approval. Two start using public tools without telling anyone.

Design a tiered governance model using the compressed tenets and working principles as constraints. Which uses get light-touch approval? Which require full review? What automated controls replace human review for the lower tiers? How do you handle the teams already using unsanctioned tools: punishment, amnesty, or integration?

---

This chapter and Chapter 12 together cover the operational reality: what the security controls are and why they matter, and what it takes to deploy within institutional constraints. The next chapter addresses the final operational concern: making the economic case and managing the budget.
