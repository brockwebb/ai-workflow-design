# Design Notes: YouTube Research Material — Chapter Routing

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Source:** Two YouTube video summaries (ingested via LeStat pipeline)
**Type:** Design notes routing external research to target chapters
**Session:** 7

---

## Source Attribution Note

The YouTube videos are commentary/aggregation channels. The value is in the **primary sources they reference**, not the commentary itself. All citations below trace to the original research. Do not cite the YouTube videos.

---

## Material Routed to Chapter 1: Why Design Matters

### Benchmark vs. Real-World Performance Gap

The Remote Labor Index (RLI) found that frontier AI agents completed only 2.5% of real freelance projects at client-acceptable quality — across 240 projects sourced from Upwork, spanning 23 work categories, representing over 6,000 hours of human labor valued at $140,000. The same models score near-expert on isolated benchmarks like GDPVal because those benchmarks provide all context. Real work requires you to bring your own.

**Why this matters for Ch 1:** This is a concrete, empirical demonstration of the book's thesis — that design discipline is what separates a working demo from a production system. The gap isn't model capability; it's the absence of workflow design around context provision, tool coordination, and end-to-end execution.

**Primary source:**
```bibtex
@article{mazeika_2025,
  author    = {Mazeika, Mantas and Gatti, Alice and Menghini, Cristina and Sehwag, Udari Madhushani and Singhal, Shivam and Orlovskiy, Yury and Basart, Steven and others},
  title     = {Remote Labor Index: Measuring {AI} Automation of Remote Work},
  journal   = {arXiv preprint arXiv:2510.26787},
  year      = {2025},
  url       = {https://arxiv.org/abs/2510.26787},
  note      = {240 Upwork projects, 23 categories, 6,000+ hours human labor. Best agent (Manus) automated 2.5\%. Scale AI + Center for AI Safety.}
}
```

**Citation to verify:**
- [ ] Confirm full author list from the arXiv PDF (abbreviated in search results)
- [ ] Confirm "2510.26787" is correct arXiv ID
- [ ] Confirm October 2025 publication date

### Design for Scale, Not for the Demo

From session conversation: The Concept Mapper processed 7,000 questions as a proof of concept, but nothing in the pipeline is hardcoded to 7,000. The architecture was designed for N — extend it to all Census demographic surveys, all federal surveys, cross-agency. The $15 scales because the architecture scales.

The "onesie-twosie" trap: people who design for small problems build systems that only work small. The technology now exists to solve problems at scales that were previously infeasible, but only if you design the pipeline as a machine, not as a one-off script.

**No external citation needed — this is author experience from the Concept Mapper.**

---

## Material Routed to Chapter 6: Parallel, Serial, and the Bottleneck

### Rob Pike's Five Rules of Programming (1989)

These rules, from Pike's *Notes on Programming in C* (1989), apply directly to LLM pipeline engineering:

1. You can't tell where a program is going to spend its time. Bottlenecks occur in surprising places — don't put in a speed hack until you've proven that's where the bottleneck is.
2. Measure. Don't tune for speed until you've measured.
3. Fancy algorithms are slow when N is small, and N is usually small.
4. Fancy algorithms are buggier than simple ones. Use simple algorithms and simple data structures.
5. Data dominates. If you've chosen the right data structures, the algorithms will be self-evident.

**Application to Ch 6:** Rules 1–2 are "profile before optimizing your pipeline." Rule 3 is "don't over-engineer for batch sizes you don't have yet" (but inverted for the federal stats audience: *design as if N will be large, because if the method works, N will be large*). Rule 5 is "right data structures make algorithms self-evident" — get your schemas right, and the pipeline design follows.

**Primary source:**
```bibtex
@misc{pike_1989,
  author       = {Pike, Rob},
  title        = {Notes on Programming in {C}},
  year         = {1989},
  howpublished = {Bell Labs internal document},
  url          = {https://www.lysator.liu.se/c/pikestyle.html},
  note         = {Five rules of programming. Pike co-created Go, Plan 9, and UTF-8. Worked at Bell Labs with Ken Thompson and Dennis Ritchie.}
}
```

### Factory.ai Compounding Loop (Possible Ch 6 or Ch 13)

Insight from Factory.ai: Agent readiness = environment readiness. Fix linter configs, documented builds, dev containers, agents.md — agent behavior becomes self-evident. Better environments → more productive agents → more time to improve environments → compounding loop.

**This may fit Ch 6 (as an environment design principle) or Ch 13 (as an institutional deployment pattern). Route TBD.**

**No citeable primary source found — this is a company insight from a YouTube interview, not a published paper. Use the principle without attribution, or drop it.**

---

## Material Routed to Chapter 7: Checkpoints, Failures, and Recovery

### SWE-CI: Writing Code vs. Maintaining Code

SWE-CI is the first benchmark built on the Continuous Integration loop — evaluating AI agents on long-term codebase maintenance, not one-shot bug fixes. 100 tasks, each spanning an average of 233 days and 71 consecutive commits in real Python repositories. Key finding: 75% of frontier models break previously working features during maintenance.

**Why this matters for Ch 7:** The checkpoint/recovery chapter argues that LLM pipelines need the same engineering discipline as production software. SWE-CI provides empirical evidence that AI coding agents — the tools you're using to *build* your pipeline — introduce regressions during maintenance. This directly connects to the bone drop on "your AI development partner is also stochastic" (session 6 design note). The implication: your pipeline's checkpoint/recovery architecture must survive not just runtime failures, but also development-time regressions introduced by AI coding assistants.

**Also relevant to Ch 9 (State, Drift, Validity):** The EvoScore metric — which weights later iterations more heavily to catch agents that produce quick fixes early but create mounting technical debt — is conceptually related to SFV's concern with state degradation over time.

**Primary source:**
```bibtex
@article{chen_2026,
  author    = {Chen, Jialong and Xu, Xander and Wei, Hu and Chen, Chuan and Zhao, Bing},
  title     = {{SWE-CI}: Evaluating Agent Capabilities in Maintaining Codebases via Continuous Integration},
  journal   = {arXiv preprint arXiv:2603.03823},
  year      = {2026},
  url       = {https://arxiv.org/abs/2603.03823},
  note      = {Sun Yat-sen University and Alibaba Group. 100 tasks, avg 233 days / 71 commits per task. 75\% of models break previously working code. Introduces EvoScore metric. CC BY 4.0.}
}
```

**Citation to verify:**
- [ ] Confirm full author list and affiliations from arXiv
- [ ] Confirm March 2026 publication date
- [ ] Confirm the 75% regression rate claim and which models were tested

---

## Material Routed to Chapter 8: Evaluation by Design

### "Evals Are the Job Now"

Framing from the video: Writing evaluations = encoding your contextual judgment into infrastructure. It's how you scale your knowledge across every agent you deploy. Not a chore, not for juniors.

**This aligns with Ch 8's thesis that evaluation is architecture, not afterthought.** The golden test set principle from the Concept Mapper is the same idea: you build evaluation into the pipeline from day one, not as a QA pass after the fact.

**No external citation needed for the principle — it's the chapter's thesis. The RLI benchmark (Mazeika et al., 2025) provides the empirical grounding: benchmarks that hand you the context produce near-expert scores; real work without provided context produces 2.5% completion.**

---

## Material Routed to Chapter 10: State Management & Research Provenance

### "Document Decisions, Not Just Outcomes"

Framing: Capture the why — constraints, trade-offs, context. This is the raw material that makes agents effective. Its absence makes them dangerous.

**This is Seldon's thesis.** The provenance reconstruction nightmare from the Concept Mapper (days to rebuild the decision trail) and the DAG project (burned to the ground) are the lived experience behind this principle. CC tasks, handoff documents, and the Seldon graph are the operational answer.

**No external citation needed — this is author experience. The Alexei disaster (below) provides an external example.**

### The Alexei Disaster (Production Data Wipe)

An AI agent wiped 1.9M rows of production student data plus backups. The agent made zero technical errors — it simply didn't know it was operating on production infrastructure. That knowledge existed only in the engineer's head. Recovery took 24 hours and emergency AWS support.

**Why this matters for Ch 10:** This is a provenance failure, not a technical failure. The agent had no way to distinguish production from development because that distinction wasn't encoded in the system's state. The engineer's contextual knowledge was load-bearing but invisible. This directly motivates the argument that state management and provenance tracking aren't bureaucratic overhead — they're safety infrastructure.

**Also relevant to Ch 12 (Security) and Ch 13 (Institutional Deployment).**

**Citation status:** This appears to be a widely-reported incident but I could not find a definitive primary source (postmortem, company statement) in the search results. The YouTube video references it but doesn't cite a primary. **Recommend: use the pattern (AI agent operating on production without environment awareness) as a universalized scenario, not as a specific named incident, unless a primary source can be located.**

- [ ] Search for "Alexei" AI agent production data deletion primary source / postmortem

---

## Material Routed to Chapter 12: Security, Supply Chain, and Model Provenance

### Agent Environment Awareness as Security Property

The Alexei disaster illustrates that environment identification (production vs. dev vs. staging) is a security control, not a convenience. When agents operate with elevated permissions, the distinction between environments must be enforced by the system, not assumed by the operator.

**Connects to Ch 12's Five Safes framing:** "Safe settings" — the controls around the computational environment where processing occurs.

---

## Material Routed to Chapter 13: Institutional Deployment

### Specification Discipline

From the video: The hardest problem in agent deployment is specification discipline. Teams struggle to write clear specs upfront. Context graphs must be clean hierarchies the agent can navigate, not everything stuffed in a window. Humans must be less lazy for agents to do good work.

**Application to Ch 13:** Institutional deployment of AI workflows requires the same specification discipline that the Seldon/CC-task workflow enforces. The design-before-drafting principle, the immutability of CC tasks once written, the CLAUDE.md project context file — these are all specification discipline operationalized.

**No citeable primary source — this is practitioner insight from a YouTube interview. Use the principle, don't cite the channel.**

---

## Summary: What Goes Where

| Material | Target Chapter | Has Citable Primary? |
|----------|---------------|---------------------|
| RLI 2.5% freelance failure rate | Ch 1, Ch 8 | Yes — Mazeika et al. (2025) |
| Design for scale / "onesie-twosie" trap | Ch 1, Ch 6 | No — author experience |
| Rob Pike's 5 rules | Ch 6 | Yes — Pike (1989) |
| Factory.ai compounding loop | Ch 6 or Ch 13 | No — drop or use without attribution |
| SWE-CI maintenance regression | Ch 7, Ch 9 | Yes — Chen et al. (2026) |
| "Evals are the job" | Ch 8 | No — principle, not finding |
| "Document decisions not outcomes" | Ch 10 | No — author experience (Seldon thesis) |
| Alexei disaster | Ch 10, Ch 12, Ch 13 | Uncertain — needs primary source verification |
| Specification discipline | Ch 13 | No — practitioner insight |
