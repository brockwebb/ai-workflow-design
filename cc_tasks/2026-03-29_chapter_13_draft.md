# CC Task: Draft Chapter 13 — Deploying in Institutional Environments

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** `2026-03-29_chapter_12_draft.md` (Ch 12 establishes Five Safes security frame and IT/security partnership; Ch 13 picks up the organizational deployment side)

---

## Objective

Replace the placeholder `book/chapter-13.md` with a full chapter draft. This is the chapter where the book's compressed tenets and working principles hit institutional reality. Ch 12 covered what the security controls are and positioned IT/security as mission partners. Ch 13 covers the organizational, procedural, and cultural reality of getting AI capability deployed and operational.

## Thesis

The technology works. The security model exists (Ch 12). The remaining obstacle is the institution itself — its procurement cycles, authorization timelines, governance culture, and incentive structures. This chapter closes the gap between "we know what to build" and "it's actually running in production."

## Tone and Scope

Honest about institutional friction without being a grievance list. Frame structural problems as incentive problems, not people problems. The people are rational actors in poorly designed systems — fix the system, the behavior follows. Balance friction points with success patterns. Keep it universal — "large institutions" not any specific agency, though the material draws from federal statistical system realities.

The compressed tenets and working principles are the diagnostic lens. For each institutional friction point, the chapter identifies which tenet or principle it violates and what the practical path forward looks like. This is where the book's framework gets stress-tested.

## Key Source Material

The compressed tenets and working principles (see `book/appendix-principles.md` and `CLAUDE.md`) are load-bearing structure for this chapter, not decoration:

**Relevant Compressed Tenets:**
- Trust defines the mission
- Deliver capability quickly
- Governance must enable execution
- Adapt continuously
- Build internal capability
- Infrastructure enables delivery

**Relevant Working Principles:**
- Slow governance prevents delivery
- Adoption determines impact
- Access defines capability
- If it cannot be explained, do not use it

## Chapter Structure

### Opening: The Last Mile Is Organizational (1-2 pages)

You've designed the workflow (Chs 1-11). You've secured it (Ch 12). Now deploy it inside an institution that was not designed to move at the speed AI requires.

The obstacles at this point aren't technical — they're procedural, cultural, and structural. This chapter uses the book's compressed tenets and working principles as the lens for diagnosing and resolving them. Each section maps to specific tenets and principles that institutional friction violates.

Frame the core tension: these institutions exist to produce trusted outputs. The governance and process overhead isn't arbitrary — it was built to protect something real. The problem is when protections designed for a different era become obstacles in the current one. The goal isn't to eliminate governance. It's to make governance proportionate, risk-based, and fast enough that it enables rather than prevents delivery.

### Section 1: The Authorization and Procurement Gap

**Tenets in tension:** "Deliver capability quickly" vs. authorization and procurement timelines.

The concrete gates:
- FedRAMP authorization is the primary gate for cloud services in federal environments. Takes months to years for providers to achieve.
- ATO (Authority to Operate) processes for internal systems. Designed for a world where you procure and run a system for five years, not a world where the model landscape changes monthly.
- Government procurement cycles run 6-18 months for major contracts. The AI tool landscape changes weekly.

The temporal mismatch is structural, not fixable by working harder.

**Practical paths forward:**
- Authorize platforms and patterns, not specific model versions. Authorize the infrastructure, security controls, and data handling procedures. Swap models within that authorized envelope.
- Enterprise ATO over per-project ATO. This is the single highest-leverage change. Every project going through its own authorization process doesn't scale. Enterprise-level authorization with tiered risk assessment does.
- Faster procurement vehicles: task-order contracts with pre-approved vendors, blanket purchase agreements for AI services, micro-purchases under simplified acquisition thresholds.
- Build model-agnostic architectures (Ch 8's evaluation harness, Ch 1's principle). If you can swap providers without rewriting code, procurement timelines hurt less.

**Working principle applied:** "Slow governance prevents delivery" — per-project ATO is the canonical example.

### Section 2: The Cloud Parity Gap

**Tenet in tension:** "Infrastructure enables delivery" meets the reality that government cloud environments lag commercial availability.

Honest treatment:
- Government cloud environments (GovCloud, Azure Gov, etc.) lag commercial availability by months to over a year. Latest models, features, APIs arrive in commercial regions first.
- By the time a service is available in government environments, it may be superseded commercially.
- This is improving, but slowly. The gap is partly a FedRAMP pipeline problem — providers pursue commercial authorization first.

The practical architecture is hybrid:
- Some workloads on authorized cloud (where the latest authorized models live)
- Some on-premises (where data never leaves your network)
- Some local inference (smaller, pruned, quantized models — getting better, won't match frontier)
- Public services for non-sensitive learning and exploration (Ch 12 Safe Projects framing)

Be honest: local inference on government hardware will not match frontier provider capability. Better pruned and tuned models are closing the gap for many tasks. But for frontier capability, you're dependent on the authorized cloud catalog.

**Working principle applied:** "Access defines capability" — you cannot use what you cannot reach.

### Section 3: Governance — Enough and No More

**Tenets:** "Governance must enable execution." **Principle:** "Slow governance prevents delivery."

This section carries the most weight. It must not become a grievance list. Frame structurally.

**The failure mode:** Governance processes that become the work instead of supporting the work. Review boards that meet monthly. Approval chains requiring six signatures. Risk assessments that take longer than the project they're assessing. The result is binary bad outcomes: people stop trying (governance wins, mission loses) or people use tools without telling anyone (mission wins short-term, trust loses long-term).

**The governance inversion:**
- Current state: governance is a gate. Every project proves innocence before proceeding. The process is the work.
- Target state: governance is embedded in tools and automated controls. Systems enforce boundaries in real time. DLP preventing sensitive data from reaching unapproved endpoints is a concrete proof point — it's already operational in some agencies.

**Tiered review, not uniform review:**
- Low-risk uses (public LLM for literature review, brainstorming, code assistance): light-touch, self-attestation
- Medium-risk uses (AI on de-identified data in approved environments): standard review
- High-risk uses (production pipelines on confidential data): full review with provenance requirements

Not every AI use case needs the same governance. Treating them the same is itself a governance failure.

**The incentive problem (frame structurally, not as finger-pointing):**
- Governance-as-gate is also governance-as-power. The people running review processes aren't inefficient — they're protecting something real to them. Eliminating the gate redistributes authority. That's why "common sense" arguments never work.
- IT and security teams are measured on uptime, incident prevention, compliance. Not measured on how quickly capability ships. The incentive structure rewards saying no and penalizes saying yes. Not malice — rational behavior in a misaligned incentive structure.
- Fix the incentive structure, not the people. Measure governance teams on time-to-capability alongside risk metrics. Make "enabled X teams to deploy safely" a performance metric.

**Working principle applied:** "Slow governance prevents delivery" — this section is the full operationalization of that principle.

### Section 4: Building Organizational Capability

**Tenets:** "Build internal capability." **Principle:** "Adoption determines impact."

Tools without capable people are shelfware. Procurement is easy. Building internal capacity to evaluate, operate, and adapt AI is hard and takes years.

Key points:
- Training isn't "here's how to prompt." Training is methodology: understanding the stochastic nature of the tools, designing evaluation frameworks, building evidence chains, knowing when to trust and when to verify.
- Build the AI corps — not a centralized team that does AI for everyone, but distributed capability where the people doing the mission work can use the tools effectively.
- The goal is auditable, defensible work at scale by the workforce, not by a specialized unit.
- Don't outsource understanding. Vendors will always outpace you. If you don't build internal capacity to evaluate what vendors offer, you can't make good procurement decisions either.

**Working principle applied:** "Adoption determines impact" — a tool nobody can use effectively has zero impact regardless of its technical capability.

### Section 5: Earning Trust Incrementally

**Tenet:** "Experiment under control."

This is the institutional version of Level 3 being earned, not assumed (Ch 1 callback).

The pattern that works:
- Start with a small pilot on non-sensitive data
- Demonstrate the controls work, the outputs are defensible, the evidence chain holds
- Expand scope incrementally
- Build a track record that earns institutional trust

This is how you create the "visible capability gap" that drives change. When one team using modern tools produces in two weeks what another spent a year on, the contrast is politically legible. Demonstrated speed differential is the lever — show it, don't debate it.

Success patterns, not just friction. This section should include concrete indicators of what "working" looks like: teams that earned expanded authorization, workflows that moved from pilot to production, governance processes that were streamlined after demonstrated success.

### Section 6: The Culture Shift (brief)

**Tenet:** "Adapt continuously."

Brief but honest. Most institutional IT culture is built around planned releases — quarterly, biannual, annual. AI workflows operate on continuous delivery. The model changes. Evaluation scores shift. Prompts get refined.

The shift required: from "approve once, run indefinitely" to "authorize the pattern, monitor continuously." From "change is risk" to "inability to change is risk."

The deeper principle (from the brainstorming material): transience as a design principle. The willingness to let go of infrastructure, tools, and territory when something better exists. Organizations structurally rewarded for permanence resist this. The hoarding behavior — people clinging to hard-won infrastructure — is rational given that getting anything new takes years. Fix the acquisition environment and the grip loosens naturally.

Don't dwell on this. Acknowledge it's the hardest part. It's a culture problem and culture changes slowly. Name it, point to where progress is happening, move on.

### Closing / Chapter Bridge

This chapter and Chapter 12 together cover the operational reality: what the security controls are (Ch 12), and what it takes to deploy within institutional constraints (Ch 13). The next chapter addresses the final operational concern — making the economic case and managing the budget.

### Pedagogical Elements

**Opening hook:** You've built the pipeline. It works on your laptop. It costs $47 and runs in 6 hours — replacing a task that currently takes three FTEs four weeks each quarter. Now deploy it inside an organization where the cloud service you need isn't authorized, the procurement cycle for the one that is takes 14 months, and the governance review board meets every six weeks. Welcome to institutional deployment.

**Reflection prompts (distribute 2-3):**

After the procurement section: "How long would it take you to get a new AI service approved for use in your organization? If you don't know, find out. That number shapes every technical decision you make."

After the governance section: "Think about the last time a governance process prevented you from doing something. Was the risk it was managing real and proportionate? What would a risk-based alternative have looked like?"

**Thought experiment:**

Your organization has ten teams that want to use AI for different tasks — from literature review to production data classification. Under current governance, each team files a separate request, each goes through full review, and the average time from request to approval is nine months. Three teams give up before approval. Two start using public tools without telling anyone.

Design a tiered governance model using the compressed tenets and working principles as constraints. Which uses get light-touch approval? Which require full review? What automated controls replace human review for the lower tiers? How do you handle the teams already using unsanctioned tools — punishment, amnesty, or integration?

**Chapter bridge:** See closing above.

## Writing Guidance

- **Primary Tenet:** "Governance must enable execution"
- **Primary Working Principle:** "Slow governance prevents delivery"
- **Secondary:** "Deliver capability quickly," "Adapt continuously," "Build internal capability," "Infrastructure enables delivery," "Access defines capability," "Adoption determines impact"
- Every section should explicitly reference which tenet or principle it operationalizes. Not as a header label — woven into the argument.
- Frame institutional friction as structural/incentive problems, not people problems. "The system rewards permanence" not "people resist change."
- Balance friction with success patterns. This chapter should not read as despair.
- The compressed tenets and working principles from `book/appendix-principles.md` are the diagnostic framework. Use them as the lens, not as decoration.
- Do not name any specific agency. Frame universally as "large institutions" or "organizations."
- Honest about difficulty. No false optimism. But also no learned helplessness.
- Estimated length: 12-16 pages. Don't pad.

## Files Modified

1. `book/chapter-13.md` — full replacement of placeholder

## Verification

1. `book/chapter-13.md` contains all six sections plus opening and closing
2. Compressed tenets and working principles are explicitly referenced throughout (not just in headers — in the argument)
3. Each section identifies which tenet/principle it operationalizes
4. `grep -c 'NEEDS' book/chapter-13.md` returns 0
5. Pedagogical elements present: opening hook, reflection prompts, thought experiment, chapter bridge
6. No specific agency names appear in the text
7. Institutional friction is framed structurally/incentive-based, not as personal criticism
8. At least one success pattern or positive indicator per friction section
