# Chapter 4: Detection & Extraction Workflows

<!-- STATUS: Placeholder -->

## Working Notes

- Entity extraction, pattern detection, disclosure review assistance
- Recall vs precision tradeoffs in statistical contexts
- When false negatives are worse than false positives (and vice versa)
- Designing extraction pipelines with verification steps
- Knowledge graph extraction as fidelity case study: the KG hype crowd treats extraction as solved, but the extraction pipeline IS the fidelity bottleneck
- Garbage chunking, lazy entity resolution, no coreference handling, no validation against source → graph that looks authoritative and is structurally wrong
- KG as "confidence laundering machine" — worse than no graph because it creates false confidence
- SFV sub-dimensions applied to KG: compression fidelity (chunk boundary meaning loss), terminological stability ("household income" as 5 different nodes), state provenance (trace every edge/node to source passage, model version, prompt)
