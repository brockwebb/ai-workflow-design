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
- Constrained model pool for federal use: Western frontier models only — need visibility into training methodology and corporate governance as a model selection criterion
- Model provenance as a trust/security decision, not just a performance decision
