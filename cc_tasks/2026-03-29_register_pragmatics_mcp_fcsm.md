# CC Task: Register Pragmatics Paper, MCP Lessons Learned, and FCSM 25-03

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Type:** Bibliography update + artifact registration + chapter routing
**Session:** 8

---

## Context

Three source documents are being registered as artifacts with chapter routing:

1. **Pragmatics paper** (Webb, 2026) — published on Zenodo, the author's knowledge representation study comparing pragmatics vs. RAG vs. control for delivering expert judgment to AI systems. Primary case study alongside the Federal Survey Concept Mapper. Cohen's d = 1.440 over control, d = 0.922 over RAG. 91.2% pipeline fidelity. 2.2x cost-effectiveness over RAG. $4.42 total evaluation cost for 39-query battery.

2. **OpenCensus MCP lessons learned** (Webb, 2025) — internal project documentation from building the open-source Census MCP server. Predates the Pragmatics paper by several months. Documents the 90/10 rule, semantic smearing discovery, MCP platform friction, personality problem, and the architectural insight that execution becoming cheaper makes planning more critical. The Pragmatics paper picked up where these lessons left off.

3. **FCSM 25-03: AI-Ready Federal Statistical Data** (Hoppe et al., 2025) — FCSM guidance on extending their Data Quality Framework to support AI/LLM consumption of federal statistical data. Proposes structured experiments with metadata enhancement, API standardization, and MCP as an integration protocol. Complements the Pragmatics paper's thesis that metadata (semantics) is necessary but insufficient — pragmatics (fitness-for-use judgment) is the missing layer.

---

## Task 1: Add New BibTeX Entries to `book/references.bib`

Append the following entries to `book/references.bib`, maintaining alphabetical order by key. Do not modify any existing entries.

```bibtex
@techreport{fcsm_2025_aiready,
  author       = {Hoppe, Travis and Gonzalez, Jeffrey and Mirel, Lisa and Schmitt, Rolf},
  title        = {{AI}-Ready Federal Statistical Data: An Extension of Communicating Data Quality},
  year         = {2025},
  month        = {5},
  number       = {FCSM 25-03},
  institution  = {Federal Committee on Statistical Methodology},
  note         = {Proposes extending FCSM Data Quality Framework for AI/LLM consumption. Distinguishes machine-readable from machine-understandable data. Recommends structured experiments with metadata-enhanced APIs, including MCP as integration protocol. Cross-agency effort involving BLS, NCHS, Census, BTS.}
}

@article{webb_2026_pragmatics,
  author    = {Webb, Brock},
  title     = {Pragmatics: Delivering Expert Judgment to {AI} Systems},
  year      = {2026},
  month     = {3},
  journal   = {Zenodo},
  doi       = {10.5281/zenodo.18913092},
  url       = {https://doi.org/10.5281/zenodo.18913092},
  note      = {Knowledge representation study. 39 Census data queries, three conditions (control, RAG, pragmatics) with identical data access. 36 curated pragmatics vs. 311 RAG chunks from same 354 pages. Cohen's d = 1.440 (vs. control), d = 0.922 (vs. RAG). Strongest effect on uncertainty communication (d = 1.353). Pipeline fidelity 91.2\% vs. 74.6\% RAG. 2.2x cost-effectiveness. Deterministic retrieval via SQLite lookup. Introduces semantic smearing concept for specialized-vocabulary metadata.}
}

@misc{webb_2025_opencensus_mcp,
  author       = {Webb, Brock},
  title        = {Open Census {MCP} Server: Lessons Learned},
  year         = {2025},
  howpublished = {Project documentation},
  url          = {https://github.com/brockwebb/open-census-mcp-server},
  note         = {LLM-first architecture for Census data consultation. 36K+ variables, natural language geographic resolution. Documents 90/10 rule (LLMs handle 90\% with 10\% effort; specialized tools close the last mile at 90\% effort), semantic smearing discovery, MCP platform friction, and cross-survey architecture potential.}
}
```

---

## Task 2: Register Artifacts in Seldon

Register three new artifacts:

### Artifact 1: Pragmatics Paper
```
seldon artifact create \
  --name "Webb 2026 Pragmatics Paper" \
  --type Reference \
  --path "external://zenodo/webb_2026_pragmatics" \
  --description "Knowledge representation study: pragmatics vs RAG vs control for delivering expert judgment to AI statistical consultation systems. Primary case study for the book alongside Federal Survey Concept Mapper." \
  --tags "pragmatics,RAG,evaluation,semantic-smearing,census,knowledge-representation,case-study"
```

### Artifact 2: OpenCensus MCP Lessons Learned
```
seldon artifact create \
  --name "OpenCensus MCP Lessons Learned" \
  --type Reference \
  --path "external://github/brockwebb/open-census-mcp-server/docs/lessons_learned" \
  --description "Project documentation from building the open-source Census MCP server. Predecessor to the Pragmatics paper. Documents architectural lessons: 90/10 rule, semantic smearing, MCP friction, personality problem." \
  --tags "MCP,lessons-learned,census,architecture,case-study"
```

### Artifact 3: FCSM 25-03
```
seldon artifact create \
  --name "FCSM 25-03 AI-Ready Data" \
  --type Reference \
  --path "docs/FCSM.25.03_AI-Ready-Extension-Data-Quality.pdf" \
  --description "FCSM guidance on extending the Data Quality Framework for AI/LLM consumption of federal statistical data. Proposes metadata enhancement experiments and MCP integration." \
  --tags "FCSM,data-quality,metadata,MCP,federal-statistics"
```

---

## Task 3: Chapter Routing

Create routing metadata. No chapter files are modified by this task — routing is recorded here for use during chapter drafting sessions.

### Pragmatics Paper → Chapter Routing

| Chapter | Section/Topic | How It's Used |
|---------|--------------|---------------|
| Ch 1 | Opening argument | "Execution becomes cheaper, so planning becomes more critical" — stated in MCP lessons, empirically demonstrated in Pragmatics. Selective curation (36 items) outperforms volume (311 chunks). |
| Ch 5 | Selectivity vs. volume | 36 curated items > 311 document chunks (d = 0.922). Semantic smearing as anti-pattern: enriching embeddings with more text makes discrimination worse, not better. Counter to "more data is better" assumption in multi-model designs. |
| Ch 5 | When multi-model is wrong | The Pragmatics paper's control condition shows a single model with the right knowledge representation beats a more complex pipeline with the wrong one. Design > complexity. |
| Ch 8 | Three-stage eval pipeline | Response generation → consultation quality scoring (multi-vendor judge panel) → pipeline fidelity verification. Reusable instrument. CQS rubric maps to FCSM 20-04 and NIST AI RMF via the crosswalk paper. |
| Ch 8 | Eval framework vs. model beauty contest | The paper built an evaluation framework that measures consultation quality across five dimensions. Contrasts with approaches that compare zero-shot prompt responses across models without a quality rubric — measuring model performance without defining what performance means. |
| Ch 8 | Cost of evaluation | Full 39-query evaluation: $4.42 at production rates. Three-vendor judge panel, counterbalanced ordering, six passes per comparison. Evaluation doesn't have to be expensive to be rigorous. |
| Ch 9 | Deterministic retrieval / stochastic tax | Pragmatics eliminates retrieval variance via SQLite lookup — same topic always returns same context. RAG's determinism depends on fixed index, embedding model, and configuration; change any component and retrieved context shifts. Directly operationalizes "reducing the stochastic tax." |
| Ch 9 | Pipeline fidelity as SFV | 91.2% fidelity (pragmatics) vs. 74.6% (RAG). Fidelity measures whether responses accurately report what tools returned — the operational definition of state fidelity in a pipeline. |
| Ch 11 | MCP as delivery mechanism | Sidecar architecture: pragmatics served alongside data via MCP, no client-side infrastructure (no vector DB, no embedding model). SQLite pack as zero-infrastructure deployment pattern. |
| Ch 11 | MCP platform assessment | MCP is a tool discovery and delivery harness, not an orchestration framework. Useful for flat tool surfaces (30-50 functions). High token cost. The paper demonstrates MCP working well for its intended purpose. |
| Ch 14 | Cost-effectiveness | Pragmatics costs 38% more per query than RAG but delivers 2.2x more quality improvement per marginal dollar. Total cost of ownership favors pragmatics: no vector database, no embedding model, no index maintenance. Runtime is a SQLite file. |

### MCP Lessons Learned → Chapter Routing

| Chapter | Section/Topic | How It's Used |
|---------|--------------|---------------|
| Ch 1 | Planning > execution | "With AI tools, execution of processes becomes cheaper. This makes upfront planning and work design all the more critical." Direct practitioner statement of the book's thesis. |
| Ch 5 | Semantic smearing origin | First identification of the problem: enriching Census variable descriptions with more text collapsed group discrimination by 63.7% (all-MiniLM-L6-v2) and 86.5% (RoBERTa-large). The Pragmatics paper formalized this into a named concept. |
| Ch 8 | Teacher salary failure | Real-world testing revealed the system couldn't assess fitness-for-use: ACS doesn't track teacher salaries by district, school districts don't align with Census boundaries, administrative data is the superior source. System failed on judgment, not retrieval. |
| Ch 9 | Personality problem | "Model behavior varies between sessions. Without system-level prompts, you can dial in behavior during a thread/session, but new threads reset to approximate baseline behavior." Instrument instability — the model changes under you. |
| Ch 11 | MCP platform maturity | "MCPs feel like GenAI images in early 2022: high technical barrier, lots of manual config, rapid experimentation." Cross-survey architecture potential: shared Geographic Agent, survey-specific Knowledge Agents. Refactoring from MCP to agent workflow as the system matures. |
| Ch 11 | 90/10 rule | LLMs handle 90% with 10% effort; specialized tools (RAG, MCP knowledge bases) close the last mile at 90% effort. Design implication: start with what the LLM already knows, add complexity only where it demonstrably fails. |

### FCSM 25-03 → Chapter Routing

| Chapter | Section/Topic | How It's Used |
|---------|--------------|---------------|
| Ch 8 | FCSM framework extension | FCSM proposing extension of their Data Quality Framework (utility, objectivity, integrity) to cover AI/LLM data consumption. Complements the crosswalk paper's mapping. The Pragmatics paper operationalizes what FCSM 25-03 proposes. |
| Ch 11 | MCP in federal landscape | FCSM explicitly names MCP as an integration protocol for agencies to experiment with. Landscape data point — not an endorsement, but evidence that the protocol is on the federal radar. |

---

## Task 4: Create Design Note

Create `docs/2026-03-29_pragmatics_mcp_fcsm_routing.md` with the following content:

```markdown
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
```

---

## Verification

After execution, verify:
1. `book/references.bib` contains three new entries: `fcsm_2025_aiready`, `webb_2026_pragmatics`, `webb_2025_opencensus_mcp`
2. No existing entries were modified
3. `docs/2026-03-29_pragmatics_mcp_fcsm_routing.md` exists
4. `seldon verify` passes
5. Three new artifacts registered in Seldon graph

---

## Notes

- The MCP lessons learned document lives in a separate repo (`census-mcp-server`), not in this repo. The artifact registration uses an `external://` path convention.
- No chapter files are modified by this task. All routing is recorded in the design note and in this CC task for use during future chapter drafting sessions.
