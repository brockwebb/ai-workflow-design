# Keywords and Glossary Terms — Working Index

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Status:** Initial extraction from Sessions 4-5. Expand as chapters are drafted.

---

## Keywords by Chapter

### Chapter 1: Why Design Matters
- stochastic liabilities
- stochastic tax
- irreproducibility (LLM vs seeded stochastic processes)
- evidence chain
- State Fidelity Validity (SFV)
- variance amplification (multi-stage pipelines)
- iterative refinement trap
- self-bias amplification
- reward hacking (self-refinement)
- model collapse (training-time)
- inference-time degradation
- convergence ceiling
- maturity levels (Shapiro's Five Levels adapted)
- human-in-the-loop (reframed)
- evaluation trap
- compressed tenets
- working principles
- design discipline

### Chapter 2: Classification & Coding Workflows
- Federal Survey Concept Mapper
- dual-model cross-validation
- confidence routing
- agreement scoring
- human review escalation
- ensemble agreement

### Chapter 5: The Ensemble & Multi-Model Playbook
- ABBA designs
- judge loops
- model order switching
- cross-model evaluation

### Chapter 8: Evaluation by Design
- evaluation harness
- model-agnostic architecture
- metrics collection as architecture

### Chapter 9: State, Drift, and Validity
- State Fidelity Validity (SFV)
- context window drift
- terminology drift
- instrument mutability
- training cutoff windows

### Chapter 10: State Management & Research Provenance
- configuration control
- artifact tracking
- ontology management
- CC task discipline
- handoff documents (state serialization)

### Chapter 12: Security, Supply Chain, and Model Provenance
- Five Safes framework
- safe projects
- safe people
- safe settings
- safe data
- safe outputs
- model provenance
- supply chain integrity
- dependency auditing
- data residency
- "offline isn't offline"
- "free isn't free"
- model integrity verification
- constrained model pool
- jurisdictional risk
- data loss prevention (DLP)
- NIST AI RMF (AI 100-1)
- NIST GenAI Profile (AI 600-1)
- statistical disclosure control (SDC)

### Chapter 13: Deploying in Institutional Environments
- FedRAMP
- Authority to Operate (ATO)
- enterprise ATO (vs per-project)
- cloud parity gap
- governance inversion
- governance-as-gate vs governance-as-enabler
- tiered review
- embedded controls (automated governance)
- procurement temporal mismatch
- hybrid architecture (cloud + on-prem + local)
- AI corps (workforce capability)
- incremental trust building
- transience as principle
- visible capability gap
- incentive alignment

### Chapter 14: Cost & Practicality
- counterfactual cost analysis
- cost taxonomy (inference, development, operational, opportunity)
- batch economics
- token budgets
- model tier selection (cost-driven)
- configuration-driven model selection
- FTE-equivalent savings
- the $15 vs $1,500 pipeline
- opportunity cost

### Cross-cutting (Foreword, Framework, Appendix)
- compressed tenets (all 10)
- working principles (all 8)
- Feynman first principles
- cargo cult science (applied to AI)
- outcome-focused validation
- "find your edge"
- self-deception (Feynman thread)

---

## Glossary Terms (definitions needed)

| Term | Definition Status | Primary Chapter |
|---|---|---|
| Stochastic liability | Defined in Ch 1 | 1 |
| Stochastic tax | Defined in Ch 1 | 1 |
| State Fidelity Validity (SFV) | Canonical definition in `docs/sfv/SFV_TERMINOLOGY_BASELINE.md` — do NOT redefine, reference | 9 |
| Five Safes | Cite {cite:t}`desai_2016` — safe projects, people, settings, data, outputs | 12 |
| Evidence chain | Needs concise definition | 1 |
| Convergence ceiling | Needs concise definition (Yang et al. 2025) | 1 |
| Evaluation harness | Needs concise definition | 8 |
| Model provenance | Needs concise definition | 12 |
| Governance inversion | Needs concise definition | 13 |
| Counterfactual cost analysis | Needs concise definition | 14 |
| Batch economics | Needs concise definition | 14 |
| Configuration-driven model selection | Needs concise definition | 14 |
| Compressed tenets | Defined in appendix — 10 strategic alignment items | 1, Appendix |
| Working principles | Defined in appendix — 8 practitioner rules | 1, Appendix |
| ABBA design | Needs concise definition | 5 |
| Context window drift | Needs concise definition | 9 |
| Instrument mutability | Needs concise definition (SFV terminology) | 9 |
| Enterprise ATO | Needs concise definition | 13 |
| Cloud parity gap | Needs concise definition | 13 |
| Token budget | Needs concise definition | 14 |
| FedRAMP | Standard definition — cite source | 13 |
| Authority to Operate (ATO) | Standard definition — cite source | 13 |
| Statistical disclosure control (SDC) | Standard definition — cite source | 12 |
| DLP (Data Loss Prevention) | Standard definition | 12 |
| NIST AI RMF | Cite {cite:t}`nist_ai_rmf_2023` | 12 |

---

## Notes

- SFV terminology is locked per `docs/sfv/SFV_TERMINOLOGY_BASELINE.md`. Glossary entries for SFV terms must match canonical vocabulary exactly. Do not create local definitions.
- Terms from Chapters 2-8 and 10-11 are sparse here because those chapters haven't been drafted yet. Expand this index as chapters are written.
- This file lives in `docs/` as a working document, not in `book/`. A formal glossary page can be created later if the book warrants one.
- Keywords serve dual purpose: index terms for PDF and potential tags for HTML search.
