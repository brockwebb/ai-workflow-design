# CC Task: Draft Chapter 4 — Detection & Extraction Workflows

**Date:** 2026-03-31
**Author:** Brock Webb
**Priority:** Chapter draft
**Depends on:** Chapter 2 (classification patterns), Chapter 3 (wrangling patterns), Chapter 5 (ensemble patterns), Chapter 9 (SFV framework)

---

## Context

Chapter 4 is the last remaining placeholder in the domain workflows trilogy (Ch 2–4). It covers the third fundamental relationship between LLMs and data: **extraction** — pulling structured elements out of unstructured input.

- **Ch 2:** Clean input → structured category (classification)
- **Ch 3:** Dirty input → corrected/standardized output (wrangling)
- **Ch 4:** Unstructured input → structured elements pulled out (extraction)

Ch 4 is the *inverse* of Ch 2. Classification maps whole items to categories; extraction pulls parts out of wholes.

---

## Chapter Identity

**Title:** Detection & Extraction Workflows

**Primary Working Principle:** If it cannot be explained, do not use it
**Primary Tenet:** Humans remain accountable

**Core thesis:** Extraction pipelines create the *appearance* of structured knowledge. Without verification infrastructure, they are confidence laundering machines — worse than no extraction because they create false certainty. The design challenge is not getting the LLM to extract things; it's knowing whether what it extracted is right.

---

## Opening Hook: "The Graph That Looked Right"

A team builds a knowledge graph from a corpus of agency reports. Entity extraction, relationship detection, the full pipeline. The graph looks authoritative — nodes, edges, types, a beautiful visualization. Leadership is impressed.

Then someone asks where a specific edge came from. The team traces it back: the LLM inferred a relationship that was implied but never stated in the source text. The inference is plausible. It might even be correct. But there is no passage in any source document that contains that relationship. The graph manufactured evidence.

This is not a failure of the model. The model did what extraction models do — it found patterns. The failure is in the pipeline design: no verification layer, no provenance from edge to source passage, no mechanism to distinguish "extracted from text" from "inferred by model." The graph that looks right is more dangerous than no graph at all, because it creates confidence without warrant.

---

## Section Structure

### Section 1: Extraction as a Design Problem

Extraction is the task family where LLMs pull structured elements from unstructured text. The common operations:

- **Entity extraction:** Names, organizations, locations, codes, dates, amounts from narrative text
- **Relationship extraction:** Connections between entities (person → organization, drug → condition, regulation → agency)
- **Pattern detection:** Recurring structures, anomalies, signals in text that match known patterns
- **Disclosure review assistance:** Identifying potentially identifying information in data products before release

What makes extraction different from classification (Ch 2) and wrangling (Ch 3): classification assigns categories to items; wrangling corrects and standardizes items; extraction *creates new structured data* from unstructured input. The output did not exist as structured data before the pipeline ran. This is the most generative of the three domain workflows, and that makes it the most dangerous for verification.

**The fundamental tension:** Extraction is valuable *because* it produces structured output from unstructured input. But every piece of structured output needs provenance — where in the source text did this come from? LLMs are excellent at extraction and terrible at citation. The design challenge is bridging this gap.

### Section 2: Disclosure Review Assistance — A Worked Example

**Source:** Templ (2026), `AI_createSdcObj()` and `AI_applyAnonymization()` in sdcMicro R package ({cite:t}`templ_2026`).

This is a real tool used in a real statistical office context (Austrian Statistical Office). The LLM only sees metadata — variable names, types, categories — not the actual microdata. It classifies variables as quasi-identifiers and proposes anonymization strategies.

**Why this is a good design:**
- The LLM never sees sensitive data (safe data principle from Ch 12)
- The LLM proposes, humans review — it does not execute anonymization decisions
- The output is reproducible R code, not just a recommendation — the human can inspect exactly what the LLM is proposing
- The metadata-only pattern reduces both security risk and confabulation risk (the model can't hallucinate relationships in data it never saw)

**Design patterns to highlight:**
- Metadata-only input as a security and fidelity pattern (stochastic tax reduction — less input surface = less room for confabulation)
- LLM-as-advisor, not LLM-as-executor for disclosure decisions
- Output as inspectable code rather than opaque recommendation
- Connection to Five Safes framework (Ch 12): safe data (metadata only), safe outputs (human-reviewed anonymization)

**Reflection prompt:** *What happens if the LLM misclassifies a direct identifier as a non-identifying variable? What is the downstream consequence for disclosure risk? How would you detect this error before the data product is released?*

### Section 3: Scaling Open-Ended Survey Responses

**Source:** DiGiuseppe & Flynn (2026), LLM-paired comparisons for scaling open-ended responses ({cite:t}`digiuseppe_2026`).

Survey research generates enormous volumes of open-ended text responses. Traditional coding is expensive and slow. This study used LLMs for pairwise comparisons of open-ended responses (interest-rate knowledge), producing Bradley-Terry scales that aligned closely with expert coding.

**Key design insight:** They did NOT ask the LLM to assign scores directly (zero-shot numeric rating). They used **pairwise comparison** — "which response demonstrates more knowledge?" — because comparative judgments are more reliable than absolute ratings from LLMs. This is the same insight behind the ABBA design in Ch 5: structure the task to play to the LLM's strengths (comparison, ranking) rather than its weaknesses (absolute calibration).

**Design patterns to highlight:**
- Pairwise comparison as a more reliable extraction/scoring pattern than direct rating
- Multiple LLMs (six in this study) for the comparison — ensemble extraction, not single-model
- Bradley-Terry as a principled aggregation method (the statistical audience will recognize this)
- Connection to Ch 5: the multi-model pattern isn't optional for extraction; it's how you get reliability

**Reflection prompt:** *If two LLMs disagree on which response demonstrates more knowledge, what does that disagreement tell you? Is it about the responses, the models, or the construct you're trying to measure?*

### Section 4: The Confidence Laundering Problem — Knowledge Graphs

This is the chapter's signature warning section. The KG hype cycle has produced extraction pipelines that create authoritative-looking structured knowledge without the verification infrastructure to back it up.

**The failure modes, stated plainly:**

1. **Garbage chunking:** Text split at arbitrary boundaries (character count, token count) instead of semantic boundaries. A paragraph about household income split across two chunks becomes two incomplete fragments, neither containing the full concept. Downstream extraction from either chunk is necessarily degraded.

2. **Lazy entity resolution:** "Census Bureau," "the Bureau," "Census," "U.S. Census Bureau" all become separate nodes in the graph. No coreference handling. The graph now has four entities where there should be one, and every relationship attached to each variant is disconnected from the others.

3. **No validation against source:** The extraction pipeline produces an edge: "Agency X → funds → Program Y." Does any source document actually state this? Or did the LLM infer it from context? Without provenance from every edge back to its source passage, there is no way to know. The graph becomes an untraceable mixture of extraction and inference.

4. **Structural overconfidence:** The graph *looks* structured. It has types, relationships, properties. This visual structure creates confidence that the content is verified. It is not. The structure is the output of a stochastic process, not a curated knowledge base.

**SFV sub-dimensions applied to extraction:**

- **Compression Fidelity (CF):** Chunk boundary placement destroys meaning. A 500-token chunk that splits a multi-sentence argument loses the argument's logic. The extraction from the fragment cannot recover what was lost in chunking.
- **Terminological Consistency (TC):** "household income" becomes five different nodes because different source documents use different terms for the same construct. Without a controlled vocabulary or ontology layer, the graph proliferates synonyms as distinct entities.
- **State Provenance (SP):** Every node, every edge, every property must trace back to: which source passage, which model version, which prompt, which extraction run. Without this, the graph is a black box that looks like a knowledge base.

**The design principle:** If you cannot trace every element in your extracted output back to a specific passage in a specific source document, processed by a specific model version with a specific prompt, you do not have a knowledge graph. You have a confabulation graph.

**Thought experiment:** *You are building an entity extraction pipeline to identify organizations mentioned in 10,000 public comments submitted to your agency during a rulemaking. The extracted entities will be used to characterize who commented. Your extraction pipeline identifies "American Medical Association" in 47 comments. An analyst reports this to leadership. Later, manual review of a sample reveals that 12 of the 47 mentions were actually "American Medical Assistants Association," "American Medical Women's Association," and other similarly-named organizations that the LLM collapsed into AMA. How would you redesign the pipeline to catch this class of error? What is the consequence if the misattribution reaches a published Federal Register analysis?*

### Section 5: Designing Extraction Pipelines That Earn Trust

Pull together the design patterns from the chapter into a coherent extraction pipeline architecture:

1. **Chunk at semantic boundaries, not token counts.** Use document structure (paragraphs, sections, headings) as chunk boundaries. If the document has no structure, that is a pre-processing problem to solve before extraction.

2. **Dual-model extraction with disagreement analysis.** Ch 5 patterns applied: two models extract independently, disagreements are signal. For entity extraction, disagreement on entity boundaries or types is especially informative.

3. **Provenance from every extracted element to source passage.** Not optional. Every entity, relationship, and attribute must carry a citation to the specific text span it was extracted from. If the model cannot point to where it found something, the extraction is inference, not extraction. Label it accordingly.

4. **Controlled vocabulary / ontology layer for entity resolution.** Don't let the LLM decide what the canonical entity names are. Provide a reference vocabulary (your agency's standard codes, your domain's controlled terms). Map extracted mentions to the vocabulary. Flag mentions that don't match.

5. **Human review calibrated to extraction type.** Not all extractions need the same review intensity. Direct entity mentions (proper nouns, codes, dates) are higher confidence. Relationship extraction (who funds whom, what regulation applies to what) is lower confidence and needs more review. Design the review queue accordingly.

6. **Recall vs. precision tradeoffs explicit in design.** For disclosure review: bias toward recall (catch everything that might be identifying, accept false positives). For entity extraction in analysis: bias depends on the downstream use. If you're counting organizations, false positives inflate counts; if you're searching for mentions, false negatives miss them. Make the tradeoff decision explicit in the pipeline configuration, not implicit in the prompt.

### Chapter Bridge to Chapter 5

The domain workflows trilogy is complete. Chapters 2 through 4 covered three fundamental ways LLMs interact with data: classifying it, correcting it, and extracting structure from it. Each chapter surfaced a common need: multi-model verification, confidence routing, disagreement as signal. Chapter 5 generalizes these patterns into the ensemble and multi-model playbook — the cross-cutting "how" that applies to every domain workflow.

---

## Citations Required

Ensure these are in `book/references.bib` (verify before adding — some may already be present):

- `templ_2026` — Templ, M. (2026). AI-assisted statistical disclosure control with sdcMicro. R Foundation. (Check if already in bib from earlier sessions.)
- `digiuseppe_2026` — DiGiuseppe, M. R., & Flynn, M. E. (2026). Scaling Open-Ended Survey Responses Using LLM-Paired Comparisons. *Public Opinion Quarterly*, nfag013. (Check if already in bib.)

**Do NOT add citations from memory.** Verify exact bibliographic details before adding to `references.bib`. If entries already exist, use existing keys.

---

## Pedagogical Pattern Checklist

- [ ] Opening hook: "The Graph That Looked Right" — concrete scenario
- [ ] Core content: Extraction design patterns, worked examples (Templ, DiGiuseppe & Flynn), confidence laundering
- [ ] Reflection prompts: At least 2 distributed through sections (provided above)
- [ ] Thought experiment: Organization extraction in public comments (provided above)
- [ ] Chapter bridge: Domain trilogy complete → Ch 5 generalizes the multi-model patterns

---

## Tone and Style

- Practitioner voice, not academic. These are people who process data for a living.
- No implementation code. Pseudocode only if algorithm structure is the point.
- "Confabulation" not "hallucination" throughout (NIST AI 600-1).
- No specific agency names. Universalize institutional examples.
- No specific companies or products. Design patterns are tool-agnostic.
- MyST citation roles: `{cite:t}` for narrative, `{cite:p}` for parenthetical.

---

## Expected Output

- `book/chapter-04.md` — full chapter draft replacing the placeholder
- Any new BibTeX entries added to `book/references.bib` (maintain alphabetical order, do not modify existing entries)

---

## Acceptance Criteria

- Chapter follows the pedagogical pattern (hook → content → prompts → thought experiment → bridge)
- KG confidence laundering thesis is clear and actionable, not just a critique
- Both worked examples (Templ, DiGiuseppe & Flynn) are integrated as design evidence
- SFV sub-dimensions applied to extraction are consistent with canonical vocabulary
- Bridge to Ch 5 is clean and forward-looking
- No bare prose citations — all use `{cite:t}` or `{cite:p}` roles
