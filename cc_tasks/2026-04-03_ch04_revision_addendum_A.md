# CC Task Addendum: Chapter 4 Revision — Evaluation Heuristic and Tool Adoption Due Diligence

**Date:** 2026-04-03
**Amends:** `cc_tasks/2026-04-03_ch04_revision.md`
**Reason:** Author review identified two additional requirements not captured in the original task

---

## Addendum A: Extraction Tool Adoption Due Diligence

The original CC task universalizes the page-boundary chunking example but doesn't capture the broader design principle the author identified: **know what your tools do under the hood.**

The point is not "tool X is bad" — it's that extraction tools make architectural decisions (chunking strategy, entity resolution approach, output labeling) that directly affect pipeline validity. A practitioner who adopts a tool without understanding its internals inherits those decisions silently. If the tool chunks by page boundary instead of semantic boundary, you get garbage chunking. If the tool labels its output "knowledge graph" when it produces a concept map, you inherit the confidence laundering.

### Instruction

**Add to the Confidence Laundering section, after the "concept map ≠ knowledge graph" example, a practitioner evaluation heuristic.** This is the "how to think" contribution — not a checklist of specific tools, but a set of questions a practitioner should ask before adopting any extraction tool:

Something like:

> Before adopting an extraction tool into your pipeline, answer these questions:
>
> *What are the chunking boundaries?* Does the tool split text at semantic boundaries (paragraphs, sections, topic shifts) or at mechanical boundaries (page breaks, token counts, character limits)? Mechanical boundaries destroy meaning before extraction begins.
>
> *What does the tool call its output?* If the tool labels its output a "knowledge graph," verify whether it produces typed entities with explicit relationships defined by a schema, or a hierarchical concept map with implicit "is related to" links. The label creates expectations. If the output does not meet those expectations, the label is confidence laundering.
>
> *Does the tool do entity resolution?* If the same entity appears under different names in different source documents, does the tool merge them or create separate nodes? Unresolved entities proliferate the graph with synonyms masquerading as distinct concepts.
>
> *Can you trace every output element to its source passage?* If the tool produces an entity or relationship, can you see which specific text span it was extracted from? If not, you cannot distinguish extraction from inference.
>
> *What model does the tool use, and can you swap it?* Extraction quality varies dramatically across models. If the tool locks you into a specific model, you inherit that model's blind spots with no escape path when the model degrades or is deprecated.

**Format note:** This should be presented as a reflection prompt (consistent with the chapter's pedagogical pattern), not as a boxed checklist. The questions teach evaluation thinking, not compliance. Frame it as: "Before you adopt an extraction tool, ask yourself these questions — and if the vendor cannot answer them, that tells you something about the tool's transparency."

### Connection to Book Themes

This connects to multiple book principles:
- "If it cannot be explained, do not use it" (Chapter 4's working principle)
- Model transience as design constraint (book-wide theme)
- Stochastic tax — every unnecessary LLM invocation you don't understand is variance you can't account for
- The metadata-only input pattern from the sdcMicro case study — less input surface = less confabulation risk

---

## Addendum B: "Confidence Laundering" as Novel Terminology

Web search and Perplexity verification confirm that "confidence laundering" does not appear as an established term in the AI/ML literature. The closest existing concepts are:

- **"AI-washing"** — misrepresenting AI capability in marketing (not about pipeline output structure)
- **"Automation bias"** (Parasuraman & Riley, 1997) — humans over-trusting automated output (about human response, not artifact structure)
- **"Epistemic opacity"** (Humphreys, 2009) — knowing the output but not the reasoning (philosophical, not design-oriented)

None of these capture the specific failure mode the chapter describes: a pipeline that produces *structurally confident-looking* output from a *stochastic process without verification*, where the structure itself (typed nodes, edges, a graph visualization) creates unwarranted confidence in the content.

### Instruction

**Define "confidence laundering" explicitly in the chapter as the author's term.** Add a clear definition, something like:

"Confidence laundering occurs when a pipeline converts uncertain, unverified extraction output into a structured artifact whose format implies verification that never occurred. The structure — typed nodes, labeled edges, a clean visualization — creates confidence in the content. But the content was produced by a stochastic process. The structure launders the uncertainty out of the presentation without laundering it out of the data."

**Add "confidence laundering" to the book glossary** (`book/glossary.md`) with this definition and a reference to Chapter 4 as the defining chapter.

**Add to `references.bib` if a clean source is found for automation bias or epistemic opacity** to ground the concept in related prior work, but do NOT present it as synonymous with those terms. It is a distinct concept.

---

## Do NOT

- Modify the original CC task file (`cc_tasks/2026-04-03_ch04_revision.md`)
- Present the evaluation heuristic as a numbered compliance checklist — it is reflection prompts
- Claim "confidence laundering" is an established term — it is the author's contribution, explicitly defined
- Name specific tools or companies in the evaluation heuristic questions
