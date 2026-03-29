# Chapter 9: State, Drift, and Validity

<!-- STATUS: Placeholder -->
<!-- SFV framework applied to workflow design -->
<!-- SHARED ONTOLOGY: All SFV terms from seldon/ontology/validity/VALIDITY_VOCABULARY.md -->
<!-- Do NOT define SFV terms locally — reference the canonical vocabulary -->

## Working Notes

- State Fidelity Validity (SFV) applied to research workflows
- Context window drift: your instrument changes during use
- Training date cutoff windows: knowledge boundaries as design constraints
- Session state degradation across long-running pipelines
- The five sub-dimensions: TC, SP, CF, SC, SCoh
- The five threats: T1-T5
- Grounding strategies for temporal knowledge gaps
- Canonical source: seldon/ontology/validity/VALIDITY_VOCABULARY.md
- SFV sub-dimensions applied to knowledge graphs as concrete example:
  - Compression fidelity: did chunking/extraction preserve meaning, or lose context at chunk boundaries?
  - Terminological stability: is "household income" the same node every time, or did extraction create 5 variants?
  - State provenance: can you trace every edge and node to source passage, model version, prompt?
- Model selection logic as a drift surface: optimal model blend shifts as models update — selection criteria need versioning
