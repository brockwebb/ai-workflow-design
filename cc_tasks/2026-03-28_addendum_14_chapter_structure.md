# CC Task Addendum: 14-Chapter Structure — Security & Institutional Chapters Split

**Date:** 2026-03-28
**Amends:** `cc_tasks/2026-03-28_addendum_12_chapter_structure.md`
**Reason:** Chapter 11 ("Workflow Orchestration & the Tool Landscape") was carrying two distinct scopes: (1) tool evaluation and orchestration patterns, and (2) operational realities including security, supply chain, and institutional deployment. These are separate audiences and separate concerns. Security and IT people need to see themselves in the table of contents — not buried inside an orchestration chapter. Additionally, the brainstorm addendum assigned material to "Operating in the Real World" (a title that never existed on disk), creating a mismatch. This addendum resolves both issues.

---

## Structural Change: 13 → 14 Chapters

### What Changes

- **Ch 11: Workflow Orchestration & the Tool Landscape** — UNCHANGED in scope. Keeps all orchestration content: tool evaluation frameworks, MCP friction analysis, CLI-first argument, LangChain coupling risks, context windows, what to bet on vs wait on, agent workflow management.
- **Ch 12: Security, Supply Chain, and Model Provenance** — NEW. Dedicated information security chapter. Supply chain risks, model provenance verification, dependency auditing, data residency, the security surface area of LLM workflows. Security and IT security teams see this chapter in the TOC immediately.
- **Ch 13: Deploying in Institutional Environments** — NEW. Organizational and operational realities. Cloud parity gap, ATO timelines, governance as bottleneck vs enabler, IT as partner, culture shift to continuous delivery, institutional friction.
- **Ch 14: Cost & Practicality** — RENAMED from Ch 12/13. Content unchanged, just renumbered.

### Updated Full Outline (14 Chapters)

1. **Why Design Matters** — The Hadoop parallel. LLM systems as distributed systems with stochastic components. The systems engineering gap for researchers. Design discipline isn't optional.
2. **Classification & Coding Workflows** — Survey question mapping, occupation/industry coding, document classification. Ensemble agreement, confidence routing, human review escalation. Federal Survey Concept Mapper as anchor case study.
3. **Data Cleaning & Imputation Workflows** — LLMs for anomaly detection, inconsistency flagging, imputation proposals. Where LLMs complement traditional methods. Edit/imputation pipeline design.
4. **Detection & Extraction Workflows** — Entity extraction, pattern detection, disclosure review assistance. Recall vs precision tradeoffs in statistical contexts.
5. **The Ensemble & Multi-Model Playbook** — ABBA designs, judge loops, agreement scoring, model order switching. The cross-cutting "how" chapter.
6. **Parallel, Serial, and the Bottleneck** — What runs concurrently. Batch design. Rate limits and cost. The $15 vs $1500 lesson.
7. **Checkpoints, Failures, and Recovery** — Config-driven architecture. Retry logic. Idempotent operations. Picking up where you left off.
8. **Evaluation by Design** — Design systems that produce their own statistics. Metrics collection as architecture, not afterthought.
9. **State, Drift, and Validity** — SFV applied. Context window management. Training cutoff windows. When your instrument changes under you.
10. **State Management & Research Provenance** — Tracking what happened, what changed, and why. Configuration control, artifact tracking, ontology management. Seldon as case study.
11. **Workflow Orchestration & the Tool Landscape** — Abstract treatment of orchestration approaches. Tradeoffs: friction vs capability, coupling vs flexibility. MCP friction analysis as worked example. Context windows and long-term memory. What to bet on vs wait on. Designed for updateability.
12. **Security, Supply Chain, and Model Provenance** — The information security chapter. Model provenance verification, dependency auditing, "offline isn't offline," data residency constraints, the security surface area of LLM workflows that security teams don't yet have playbooks for.
13. **Deploying in Institutional Environments** — Cloud parity gap, ATO timelines, governance-as-bottleneck vs governance-as-enabler, IT as partner not gatekeeper, continuous delivery culture shift, institutional friction, "enough governance and no more."
14. **Cost & Practicality** — Token budgets. Batch economics. When cheap models win. Making the case to your program office.

---

## Brainstorm Material Reassignment

The brainstorm addendum (`2026-03-28_addendum_brainstorm_material.md`) assigned items #8, #9, and #11 to "Ch 11: Operating in the Real World" — a title that never existed on disk. These items are now assigned to the correct new chapters:

| Brainstorm Item | Old Assignment | New Assignment |
|-----------------|---------------|----------------|
| #8: HuggingFace Callback Story | Ch 11 (Operating in the Real World) | **Ch 12: Security, Supply Chain, and Model Provenance** |
| #9: Government Cloud Parity Gap | Ch 11 (Operating in the Real World) | **Ch 13: Deploying in Institutional Environments** |
| #11: Operational Friction | Ch 11 (Operating in the Real World) | **Ch 13: Deploying in Institutional Environments** |

All other brainstorm material assignments are unchanged.

---

## Updated Chapter-to-Principle Mapping

| Chapter | Primary Working Principle(s) | Primary Tenet(s) |
|---------|------------------------------|------------------|
| Ch 1: Why Design Matters | All (introduction) | All (introduction) |
| Ch 2: Classification & Coding | Adoption determines impact | Deliver capability quickly |
| Ch 3: Data Cleaning & Imputation | Reuse data before collecting more | Data precedes models |
| Ch 4: Detection & Extraction | If it cannot be explained, do not use it | Humans remain accountable |
| Ch 5: Ensemble & Multi-Model | Outputs require full provenance | Defensibility is required |
| Ch 6: Parallel, Serial, Bottleneck | Adoption determines impact | Deliver capability quickly |
| Ch 7: Checkpoints & Recovery | Build lineage before scale | Experiment under control |
| Ch 8: Evaluation by Design | If it cannot be explained, do not use it | Defensibility is required |
| Ch 9: State, Drift, Validity | Outputs require full provenance | Trust defines the mission |
| Ch 10: State Mgmt & Provenance | Build lineage before scale | Defensibility is required |
| Ch 11: Workflow Orchestration | Access defines capability | Infrastructure enables delivery |
| Ch 12: Security & Supply Chain | Security is a system property | Trust defines the mission |
| Ch 13: Institutional Deployment | Slow governance prevents delivery | Governance must enable execution |
| Ch 14: Cost & Practicality | Slow governance prevents delivery | Infrastructure enables delivery |

---

## New Chapter Placeholder Files to Create

**book/chapter-12.md:**
```markdown
# Chapter 12: Security, Supply Chain, and Model Provenance

<!-- STATUS: Placeholder -->
<!-- AUDIENCE: Security teams, IT security, data scientists who need to think about security -->
<!-- This chapter exists so security and IT people see themselves in the table of contents -->

## Working Notes

- The security surface area of LLM workflows — what security teams don't yet have playbooks for
- Model provenance: where did this model come from, who trained it, on what data?
- Supply chain risks: hidden dependencies, unexpected callbacks, "offline isn't offline"
- The HuggingFace callback story: running a model locally, network goes down, job fails — "offline mode" wasn't offline
- Dependency auditing for ML pipelines — not just pip packages, but model weights, tokenizers, configs
- Data residency constraints: different laws in different jurisdictions affect where data can be processed
- Model integrity verification: checksums, signatures, trusted registries
- The motivated user problem: high demand + good faith assumptions = vulnerability surface
- Don't name specific providers — frame as "model repositories" generally
- Security is a system property, not a feature you bolt on
- Frame for security practitioners: "here's what's different about securing AI workflows vs traditional software"
```

**book/chapter-13.md:**
```markdown
# Chapter 13: Deploying in Institutional Environments

<!-- STATUS: Placeholder -->
<!-- AUDIENCE: IT operations, governance teams, program managers, data scientists navigating institutions -->
<!-- This chapter exists so IT and governance people see themselves in the table of contents -->

## Working Notes

- Cloud parity gap: 1+ year lag between commercial and government cloud capabilities
- Older models on government clouds become effectively useless for cutting-edge research
- The tension: security requirements vs capability requirements
- Improving landscape: better pruned/tuned smaller models, better hardware for local inference
- But local will not match frontier provider capability — be honest about that
- Authority-to-operate (ATO) and review processes that take months to years
- Governance processes that become the work instead of supporting the work
- The tendency to nitpick and bikeshed governance decisions for months
- "Enough governance and no more" — risk-based controls, not exhaustive review
- Automated controls (like DLP) as the model — governance embedded in systems, not committees
- The culture shift: from biannual releases to continuous delivery
- IT and security as business enablers, not gatekeepers
- People protecting established processes because change threatens their role
- Frame universally — "large institutions" not any specific agency
- None of this is easy. Acknowledge it honestly without dwelling on it.
```

**book/chapter-14.md:** (content from current chapter-12.md — Cost & Practicality)
```markdown
# Chapter 14: Cost & Practicality

<!-- STATUS: Placeholder -->
<!-- Was originally chapter 10, then 12, now 14 — content unchanged, just renumbered -->

## Working Notes

- Token budgets: estimating cost before running
- Batch economics: cost per item at scale
- When cheap models win (and when they don't)
- Making the case to your program office / budget authority
- The hidden costs: developer time, review time, error correction
- Cost comparison frameworks: LLM pipeline vs manual process vs traditional automation
- Configuration-driven model selection: swap models without rewriting code
```

---

## Files to Update

### book/chapter-12.md
- Current content is Cost & Practicality (from the 13-chapter numbering)
- Overwrite with new Security, Supply Chain, and Model Provenance placeholder

### book/chapter-13.md (NEW)
- Create with Deploying in Institutional Environments placeholder

### book/chapter-14.md (NEW)
- Create with Cost & Practicality content (moved from current chapter-12.md)

### CLAUDE.md
- Replace the Chapter Outline section with the 14-chapter outline
- Update the Chapter-to-Principle Mapping table
- Ch 11 title remains "Workflow Orchestration & the Tool Landscape" (no change)

### book/appendix-principles.md
- Update the Chapter-to-Principle Mapping table to 14 chapters

### Seldon
- Register new artifacts: chapter-12.md (updated), chapter-13.md (new), chapter-14.md (new)
- Update metadata on chapter-11.md if title/scope metadata exists

---

## Execution Order

1. Read current `book/chapter-12.md` to capture existing Cost & Practicality content
2. Write `book/chapter-14.md` with Cost & Practicality content
3. Overwrite `book/chapter-12.md` with Security, Supply Chain, and Model Provenance placeholder
4. Create `book/chapter-13.md` with Deploying in Institutional Environments placeholder
5. Update `CLAUDE.md` — chapter outline section and principle mapping table
6. Update `book/appendix-principles.md` — principle mapping table
7. Register new/updated artifacts with Seldon

---

## Verification Checklist

After execution, confirm:
- [ ] `book/chapter-12.md` contains Security content (NOT Cost)
- [ ] `book/chapter-13.md` contains Institutional Deployment content
- [ ] `book/chapter-14.md` contains Cost & Practicality content
- [ ] `CLAUDE.md` shows 14-chapter outline with correct titles
- [ ] `appendix-principles.md` mapping table has 14 rows
- [ ] Ch 11 title is "Workflow Orchestration & the Tool Landscape" everywhere (not "Operating in the Real World")
- [ ] No file references "Operating in the Real World" as a chapter title
- [ ] Brainstorm material #8 → Ch 12, #9 → Ch 13, #11 → Ch 13
- [ ] All new artifacts registered in Seldon
