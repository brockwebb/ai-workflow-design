# Chapter 4: Detection & Extraction Workflows

<!-- STATUS: Draft -->
<!-- Primary Working Principle: If it cannot be explained, do not use it -->
<!-- Primary Tenet: Humans remain accountable -->

## The Graph That Looked Right

A team builds a knowledge graph from a corpus of agency reports. Entity extraction, relationship detection, the full pipeline. The graph looks authoritative: nodes, edges, types, a beautiful visualization. Leadership is impressed.

Then someone asks where a specific edge came from. The team traces it back: the LLM inferred a relationship that was implied but never stated in the source text. The inference is plausible. It might even be correct. But there is no passage in any source document that contains that relationship. The graph manufactured evidence.

This is not a failure of the model. The model did what extraction models do: it found patterns. The failure is in the pipeline design. No verification layer. No provenance from edge to source passage. No mechanism to distinguish "extracted from text" from "inferred by model." The graph that looks right is more dangerous than no graph at all, because it creates confidence without warrant.

## Extraction as a Design Problem

Extraction is the task family where LLMs pull structured elements from unstructured text. The common operations: entity extraction (names, organizations, locations, codes, dates, amounts from narrative text), relationship extraction (connections between entities), pattern detection (recurring structures, anomalies, signals that match known patterns), and disclosure review assistance (identifying potentially identifying information in data products before release).

What makes extraction different from classification (Chapter 2) and wrangling (Chapter 3): classification assigns categories to items; wrangling corrects and standardizes items; extraction *creates new structured data* from unstructured input. The output did not exist as structured data before the pipeline ran. This is the most generative of the three domain workflows, and that makes it the most dangerous for verification.

The fundamental tension: extraction is valuable precisely because it produces structured output from unstructured input. But every piece of structured output needs provenance. Where in the source text did this come from? LLMs are excellent at extraction and poor at citation. The design challenge is bridging this gap.

## Disclosure Review Assistance

{cite:t}`templ_2026` implemented AI-assisted statistical disclosure control in the sdcMicro R package, used in the Austrian statistical office context. The design is instructive because it gets the boundaries right.

The LLM only sees metadata: variable names, types, categories. Not the actual microdata. It classifies variables as quasi-identifiers and proposes anonymization strategies. The output is reproducible R code, not just a recommendation. The human can inspect exactly what the LLM is proposing before any anonymization is applied.

This is a good design for several reasons. The LLM never sees sensitive data, satisfying the safe data principle from Chapter 12. The LLM proposes, humans review: it does not execute anonymization decisions. The output as inspectable code means the recommendation is transparent and auditable. And the metadata-only pattern reduces both security risk and confabulation risk: the model cannot confabulate relationships in data it never saw.

The metadata-only input pattern is a broader design principle. Every field you do not include in the prompt is a field that cannot be confabulated about. Every dimension of input you withhold from the model is a dimension of stochastic tax you do not pay. Less input surface means less room for confabulation, which means more reliable output. This is stochastic tax reduction applied to extraction pipeline design.

> *What happens if the LLM misclassifies a direct identifier as a non-identifying variable? What is the downstream consequence for disclosure risk? How would you detect this error before the data product is released?*

## Scaling Open-Ended Survey Responses

{cite:t}`digiuseppe_2026` used LLMs for pairwise comparisons of open-ended survey responses measuring interest-rate knowledge. Six LLMs performed the comparisons. Bradley-Terry models aggregated the results into scales that aligned closely with expert coding.

The key design insight: they did not ask the LLM to assign scores directly. Zero-shot numeric rating, where you ask a model "rate this response on a scale of 1 to 5," produces unreliable output because LLMs are poorly calibrated for absolute judgments. Instead, they used pairwise comparison: "which response demonstrates more knowledge?" Comparative judgments are more reliable from LLMs than absolute ratings. This is the same insight behind the ABBA design in Chapter 5: structure the task to play to the LLM's strengths (comparison, ranking) rather than its weaknesses (absolute calibration).

Six LLMs performed the comparisons, not one. This is ensemble extraction, not single-model extraction. The multi-model pattern from Chapter 5 is not optional for extraction tasks; it is how you get reliability when ground truth is unavailable. When six independently trained models converge on the same comparative judgment, the signal is meaningful. When they diverge, the divergence tells you something about the construct being measured, not just about the models.

Bradley-Terry as the aggregation method is worth noting for the statistical audience. It is a principled approach to turning pairwise comparisons into interval scales, well-understood in psychometrics and survey research. The LLMs provide the raw comparisons; the statistical model provides the scaling. Each component does what it does well.

> *If two LLMs disagree on which response demonstrates more knowledge, what does that disagreement tell you? Is it about the responses, the models, or the construct you are trying to measure?*

## The Confidence Laundering Problem

Knowledge graphs built from LLM extraction pipelines are the poster child for confidence without warrant. The knowledge graph hype cycle has produced extraction pipelines that create authoritative-looking structured knowledge without the verification infrastructure to back it up.

The failure modes, stated plainly:

**Garbage chunking.** Text split at arbitrary boundaries, character count or token count, instead of semantic boundaries. A paragraph about household income split across two chunks becomes two incomplete fragments, neither containing the full concept. Downstream extraction from either chunk is necessarily degraded. The chunk boundary destroyed meaning before the extraction even started.

**Lazy entity resolution.** "Census Bureau," "the Bureau," "Census," "U.S. Census Bureau" all become separate nodes in the graph. No coreference handling. The graph now has four entities where there should be one, and every relationship attached to each variant is disconnected from the others. The graph proliferates synonyms as distinct entities.

**No validation against source.** The extraction pipeline produces an edge: "Agency X funds Program Y." Does any source document actually state this? Or did the LLM infer it from context? Without provenance from every edge back to its source passage, there is no way to know. The graph becomes an untraceable mixture of extraction and inference.

**Structural overconfidence.** The graph looks structured. It has types, relationships, properties. This visual structure creates confidence that the content is verified. It is not. The structure is the output of a stochastic process, not a curated knowledge base.

SFV sub-dimensions applied to extraction illuminate why these failures are validity threats, not just quality problems:

*Compression Fidelity (CF):* Chunk boundary placement destroys meaning. A 500-token chunk that splits a multi-sentence argument loses the argument's logic. The extraction from the fragment cannot recover what was lost in chunking.

*Terminological Consistency (TC):* "Household income" becomes five different nodes because different source documents use different terms for the same construct. Without a controlled vocabulary or ontology layer, the graph proliferates synonyms as distinct entities. This is SFV threat T1 (Semantic Drift) operating at the extraction level.

*State Provenance (SP):* Every node, every edge, every property must trace back to: which source passage, which model version, which prompt, which extraction run. Without this, the graph is a black box that looks like a knowledge base.

The design principle: if you cannot trace every element in your extracted output back to a specific passage in a specific source document, processed by a specific model version with a specific prompt, you do not have a knowledge graph. You have a confabulation graph.

### Thought Experiment

You are building an entity extraction pipeline to identify organizations mentioned in 10,000 public comments submitted to your agency during a rulemaking. The extracted entities will be used to characterize who commented. Your extraction pipeline identifies "American Medical Association" in 47 comments. An analyst reports this to leadership.

Later, manual review of a sample reveals that 12 of the 47 mentions were actually "American Medical Assistants Association," "American Medical Women's Association," and other similarly-named organizations that the LLM collapsed into AMA. The misattribution inflated the count by 25%.

How would you redesign the pipeline to catch this class of error? What is the consequence if the misattribution reaches a published Federal Register analysis?

## Designing Extraction Pipelines That Earn Trust

The design patterns from the chapter, assembled into a coherent extraction pipeline architecture:

**Chunk at semantic boundaries, not token counts.** Use document structure (paragraphs, sections, headings) as chunk boundaries. If the document has no structure, that is a pre-processing problem to solve before extraction begins.

**Dual-model extraction with disagreement analysis.** Chapter 5 patterns applied: two models extract independently, disagreements are signal. For entity extraction, disagreement on entity boundaries or entity types is especially informative. It tells you where the source text is ambiguous, which is exactly where confabulation risk is highest.

**Provenance from every extracted element to source passage.** Not optional. Every entity, relationship, and attribute must carry a citation to the specific text span it was extracted from. If the model cannot point to where it found something, the extraction is inference, not extraction. Label it accordingly.

**Controlled vocabulary for entity resolution.** Do not let the LLM decide what the canonical entity names are. Provide a reference vocabulary: your agency's standard codes, your domain's controlled terms. Map extracted mentions to the vocabulary. Flag mentions that do not match. This is the shared vocabulary principle from Chapter 10 applied at the extraction level.

**Human review calibrated to extraction type.** Not all extractions need the same review intensity. Direct entity mentions (proper nouns, codes, dates) are higher confidence. Relationship extraction (who funds whom, what regulation applies to what) is lower confidence and needs more review. Design the review queue accordingly.

**Recall versus precision tradeoffs explicit in design.** For disclosure review: bias toward recall. Catch everything that might be identifying; accept false positives. For entity extraction in analysis: the bias depends on the downstream use. If you are counting organizations, false positives inflate counts. If you are searching for mentions, false negatives miss them. Make the tradeoff decision explicit in the pipeline configuration, not implicit in the prompt.

---

The domain workflows trilogy is complete. Chapters 2 through 4 covered three fundamental ways LLMs interact with data: classifying it, correcting it, and extracting structure from it. Each chapter surfaced a common need: multi-model verification, confidence routing, disagreement as signal, provenance from output to input. Chapter 5 generalizes these patterns into the ensemble and multi-model playbook, the cross-cutting architecture that applies to every domain workflow in this book.
