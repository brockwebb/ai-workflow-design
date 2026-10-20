# CC Task: Draft Chapter 10 — State Management & Research Provenance

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Target file:** `book/chapter-10.md`
**Type:** Full chapter draft (replace placeholder content)
**Session:** 10

---

## Overview

Draft Chapter 10 as a complete chapter following the project's pedagogical pattern (opening hook, core content, distributed reflection prompts, thought experiment, chapter bridge). This chapter is the operationalization chapter — turning Chapter 9's SFV awareness into engineering infrastructure for tracking, proving, and defending what happened in an AI-assisted research pipeline.

**Primary Working Principle:** Build lineage before scale
**Primary Tenet:** Defensibility is required

**Bridge from Ch 9:** Chapter 9 ends with "countermeasures require infrastructure: tools that track state, detect deviations, and maintain provenance across sessions and pipeline runs. That infrastructure, state management and research provenance, is the subject of Chapter 10."

---

## Chapter Architecture

### 1. Opening Hook: Defensible by Design

**Theme:** Your agency deployed an AI-assisted occupation coding pipeline. It ran for three quarters. The results are challenged — maybe by a reviewer, maybe by an Inspector General, maybe by a congressional inquiry. The question is not "did the pipeline produce good results?" The question is: "Can you prove it?"

Can you show — to an independent auditor who was not there — which model version was used? Which prompt configuration? Which training data cutoff was in effect? Whether human review occurred where required? Whether the golden test set was re-run after the last model update? Whether the configuration that produced Q3 results is the same configuration that produced Q4 results?

If you cannot reconstruct the chain from input to output with enough fidelity to survive an independent audit, it does not matter how good the pipeline was. The results are indefensible.

This chapter is about building the infrastructure that makes AI-assisted research defensible — not after the fact, but by design.

**Tone:** Direct, high-stakes but not alarmist. The audience knows what an IG investigation looks like. They know what "defensible" means in their institutional context. Speak to that knowledge. Do not lecture about why audits matter — they know. Show them how to survive one.

### 2. Three Reasons Provenance Is Not Optional

Three paragraphs, one per reason. Each is a distinct argument, not a restatement of the others.

**Defensibility.** The ability to survive an independent audit. Not just "we kept good records" but "we can reconstruct the complete decision chain from raw input to published output, including model versions, prompt configurations, arbitration decisions, and human review points." In federal statistical agencies, this is not aspirational — it is a requirement. When AI enters the production pipeline, the provenance requirements do not relax; they intensify, because the instrument itself is more complex and less transparent than traditional statistical methods.

**Entropy management.** Long-running projects over months with multiple sessions, finite context windows, and team coordination accumulate entropy. Numbers drift between sessions. Tasks fall through cracks. Configuration details get transcribed incorrectly. Terminology shifts. Without enforced tracking, things degrade silently — the same state drift Chapter 9 describes at the pipeline level, but now at the project level. The processing cost of provenance infrastructure is quality insurance. The alternative — fighting entropy retroactively — costs more in every case. You will spend more energy fixing errors than you would have spent preventing them.

**Scientific rigor.** Provenance infrastructure enforces the documentation discipline that good science requires. Humans introduce variability into record-keeping, reporting, and interpretation. This is not a criticism of researchers — it is an observation about human cognitive limits. Over months of work, memories fade, rationales get reconstructed rather than recalled, and "I think we did it this way" replaces "here is the record showing exactly what happened." Provenance infrastructure is the research equivalent of standardized laboratory procedure: it reduces variance in the process itself, strengthens the claims that emerge from the process, and ensures that the work is reproducible by someone who was not in the room.

> **Reflection prompt:** Think about your last major analysis or pipeline project. If someone asked you today to reconstruct exactly how a specific result was produced — not approximately, but exactly — how far back could you trace the chain? Where would the trail go cold?

### 3. Eight Requirements for Research Provenance

State the requirements abstractly. These are what any provenance system — simple or complex, custom or commercial — must satisfy to support defensible AI-assisted research. One paragraph each. No implementation details yet.

**Requirement 1: Typed artifacts.** Track entities as typed objects, not just files. A "script" is different from a "result" is different from a "figure" is different from a "dataset." The type carries semantics — what the artifact is, what states it can be in, what relationships it can have. A flat filesystem treats everything as a file. A provenance system treats everything as a typed entity with properties and constraints.

**Requirement 2: Relationships between artifacts.** A chapter cites a result. A result was generated by a script. A script computed from a dataset. A dataset was produced by a pipeline run. These relationships are the provenance. Without them, you have a collection of files in a directory. With them, you have a traceable chain from output to input. The relationships must be explicit and queryable — not implicit in filenames or comments.

**Requirement 3: State machines.** Artifacts move through states: proposed, draft, verified, published, stale. State transitions should be enforced — you cannot cite a result that was never verified, publish a section that is still in draft, or use a dataset that has been marked stale. State machines prevent the common failure of treating unvalidated artifacts as if they were authoritative.

**Requirement 4: Staleness propagation.** When an upstream artifact changes, all downstream dependents must be flagged as potentially stale. If the dataset changes, every result computed from that dataset needs review. If a script changes, every result it generated may be affected. This is graph traversal: follow the dependency edges downstream from the changed artifact and mark everything reachable as needing review. Without this, upstream changes silently invalidate downstream artifacts.

**Requirement 5: State serialization.** LLM-assisted workflows have a unique provenance challenge: the conversation that produced the work product is ephemeral. Context windows reset between sessions. The AI partner does not remember what happened last time. Without explicit state serialization — documents that capture enough context to reconstruct the working state — you lose the "why" every time the context resets. Handoff documents, session logs, and structured briefings at session start are all forms of state serialization.

**Requirement 6: Shared vocabulary with write protection.** When multiple projects, chapters, or pipeline components use the same terms, those terms need a single source of truth. Distributed copies cause terminology drift — the exact problem shared vocabulary is meant to prevent. The correct pattern is a master/replica model: one authoritative source, read-only replicas in consuming projects, write protection enforced so local projects cannot accidentally diverge from the canonical definitions. This is the CDN model applied to vocabulary.

**Requirement 7: Change gating through specification documents.** Changes to tracked artifacts go through a specification document that records intent before execution. The spec says what will change, why, what files are affected, and what acceptance criteria apply — before the change is made. The specification is the decision record. It is version-controlled. It is immutable once written. This is the research equivalent of infrastructure-as-code: the specification is the auditable artifact, not the change itself.

**Requirement 8: Automated integrity verification.** A verification gate that checks — automatically, before declaring work complete — whether file hashes match expectations, whether cited references resolve, whether tracked artifacts are consistent, whether anything has changed out-of-band. Humans forget to check. Automated verification does not forget. The verification gate is the last line of defense against silent state corruption.

> **Reflection prompt:** Which of these eight requirements does your current workflow satisfy? Which ones does it violate? For the ones it violates, have you ever experienced the failure mode that the requirement is designed to prevent?

### 4. Why Git Alone Does Not Satisfy Them

**Two to three paragraphs. Brief. The argument is straightforward.**

Git tracks file-level diffs. It records what changed and when. It does not track:
- **Why** a change was made (decision rationale). Commit messages are optional and rarely contain the full reasoning.
- **Relationships between files.** A commit that modifies a script and a chapter does not record that the chapter cites a result generated by that script. The semantic layer — which artifacts depend on which other artifacts — is absent.
- **Artifact state.** Git does not know whether a result is "proposed" or "verified" or "stale." It tracks file existence and content, not lifecycle state.
- **Downstream impact.** Git does not propagate staleness. If a dataset changes, git does not flag every result computed from that dataset as needing review.

Git answers "what did you do?" Research provenance answers "why did you do this, what depended on it, and can I trust the result?" Git is necessary infrastructure — version control is non-negotiable — but it is not sufficient for research provenance. The semantic layer must sit on top of it.

### 5. The DOORS Lesson: Right Requirements, Wrong Cost Model

**One to two paragraphs. Sets up the AI-absorption argument.**

IBM DOORS — Dynamic Object-Oriented Requirements System — got the requirements right decades ago. Typed artifacts. Traceability matrices. Relationship tracking between requirements, implementations, and test cases. The aerospace and defense industries used it because the regulatory environment demanded it. The requirements traceability problem that DOORS solved is the same problem this chapter describes.

The adoption problem was human cost. Maintaining a DOORS database required dedicated operators. The friction of updating traceability matrices manually, for every change, was brutal. Nobody wanted to be the DOORS operator. In research environments without the regulatory mandate of aerospace, the cost-benefit calculation never justified the overhead. The requirements were right. The cost model was wrong.

### 6. AI Partners Change the Cost Equation

**Two to three paragraphs. This is the enablement argument — not the thesis, but the reason the thesis is now actionable.**

AI partners change the cost equation for provenance infrastructure. The bookkeeping that killed adoption of systems like DOORS — maintaining the artifact graph, updating traceability relationships, flagging staleness, reconstructing session context — is exactly the kind of structured, repetitive, context-dependent work that AI assistants absorb well.

The human moves from Level 2 operation (Shapiro's levels from Chapter 1) — manually tracking artifacts, catching errors, rebuilding context — to Level 3+: specifying intent and verifying outcomes. The AI partner maintains the graph, writes specification documents from design conversations, flags when tracked artifacts are stale, and reconstructs working context at session start. The human operates at the decision level: "should we change this design?" not "update row 47 of the traceability matrix."

This is not hypothetical. The author's experience building the Federal Survey Concept Mapper (Chapter 2) demonstrated the failure mode concretely: the pipeline produced reliable results, but reconstructing how those results were produced after the fact took days. A separate project had to be abandoned entirely because provenance could not be recovered. The reference librarian tax — the human maintaining architectural documentation, catching hallucinated model names, manually tracking task completion, rebuilding session context after every new conversation — consumed intellectual capital that should have been spent on design work. AI partners absorb that tax.

> **Reflection prompt:** What fraction of your time on a multi-session project is spent on logistics — tracking what happened, rebuilding context, coordinating state across sessions — versus the actual intellectual work of the project? What would it mean if that fraction dropped by half?

### 7. Configuration Control as a Design Pattern

**Two to three paragraphs. CC tasks as the research infrastructure-as-code pattern.**

Configuration control is the discipline of gating changes through specification documents. In software engineering, this manifests as infrastructure-as-code: the desired state of the system is declared in version-controlled files, and changes to the system go through changes to those files. In research, the same principle applies: changes to tracked artifacts go through a specification document — a CC task — that records what will change, why, what files are affected, and what acceptance criteria apply.

The CC task is written before the change is made. It is the decision record. Once written, it is immutable — if corrections are needed, they go in a new document that references the original. This immutability ensures the audit trail is append-only. You can always reconstruct the sequence of decisions that produced the current state by reading the CC tasks in chronological order.

This connects directly to Chapter 7's reproducible research discipline. Chapter 7 argues that config-driven architecture is the "save the random seed" principle extended to LLM pipelines. Configuration control extends it further: not just "save the configuration that produced the result" but "save the specification that authorized the change to the configuration." The specification is the rationale layer that configuration files alone do not capture.

### 8. The Graph-of-Artifacts Pattern — A Worked Example

**This is the Seldon bone drop. Frame as: "Here is one system that satisfies all eight requirements. The pattern matters more than the implementation."**

**Subsection 8a: The problem that motivated the system.**

Five concrete failure modes from direct experience building AI-assisted research pipelines:

1. **Numbers drift between sessions.** A result computed in conversation gets transcribed to a file, then cited with a different value three sessions later. No traceable path from the cited number back to the computation that produced it.

2. **Tasks fall through cracks.** A session creates three sub-tasks. One gets done. The conversation pivots. The other two never surface again. Weeks later: forensic archaeology through chat histories.

3. **The reference librarian tax.** The human maintains documentation files so AI coding assistants follow established patterns. Catches hallucinated model names. Manually tracks which tasks were executed, which files were modified, which artifacts are stale. Rebuilds session context after every new conversation. This is supervisory overhead that should be automated.

4. **Context windows reset.** The AI partner does not remember last session. Without explicit state serialization, you lose the "why" every time the context resets.

5. **Files do not know about each other.** A chapter cites a paper. A figure derives from a dataset. A design decision affects three chapters. These relationships are the provenance. Flat filesystems cannot represent them.

**Subsection 8b: The dual-layer architecture.**

The system uses a two-layer architecture that deliberately separates the source of truth from the queryable projection:

- **An append-only event log** (JSONL file, lives in git). Every artifact creation, state change, and link creation is an event. This is the immutable audit trail. It is portable — it is a text file in the repository. It is the backup. If the query layer dies, the event log is the complete recovery path.

- **A graph database** (Neo4j) that is a persistent, indexed projection of the event log. Artifacts are nodes. Relationships are edges. Provenance queries — "where did this number come from?", "what breaks if I change this dataset?", "is this section fully supported?" — are graph traversals.

**Why both layers?** The audit trail needs to be immutable and portable — an append-only log in version control. The provenance needs to be queryable and fast — a graph database with indexed traversal. These are different requirements satisfied by different storage models. The event log without the graph is an audit trail you cannot query efficiently. The graph without the event log is a database with no recovery story and no immutable history.

Every mutation follows the same pattern: event appended to the log (source of truth), then the corresponding update executed against the graph (projection). If the graph is corrupted or lost, rebuild it by replaying all events from the log. No data loss. The event log is the complete history.

**Subsection 8c: Provenance chains in practice.**

Show one provenance chain:

```
PaperSection → cites → Result → generated_by → Script → computed_from → DataFile
```

This chain answers the audit question: "Where did this number in the paper come from?" Follow the edges: the section cites a result; the result was generated by a script; the script computed from a dataset. Every link is an explicit, typed relationship in the graph. The auditor can traverse the chain without relying on the researcher's memory.

Staleness propagation is graph traversal: if the DataFile changes, follow the downstream edges — every Result computed from it, every PaperSection that cites those Results — and flag them as needing review. The researcher does not have to remember which sections are affected. The graph knows.

State machines on artifacts enforce lifecycle discipline: a Result cannot be cited in a published PaperSection unless the Result has reached "verified" status. A PaperSection cannot move to "published" unless all cited Results are verified and all referenced Figures are current. The state machine prevents the common failure of treating unvalidated artifacts as authoritative.

**Subsection 8d: Domain configuration, not domain code.**

The core engine is domain-agnostic. What makes it a research tool is a configuration file — a YAML schema that defines artifact types, relationship types, state machines per type, and required properties. Adding a new domain (clinical trials, engineering, policy analysis) means writing a new YAML file, not new infrastructure. The requirements from Section 3 are general; the domain configuration makes them specific.

> **Reflection prompt:** If you had to show an auditor the complete provenance chain for a specific result in your current project, which links in the chain are explicit and which are implicit? Where does the trail depend on your memory rather than a system of record?

### 9. Shared Vocabulary as Infrastructure

**Two paragraphs. The AD-017 / master-replica pattern. Connect to SFV T1.**

When multiple projects or pipeline components use the same terms — and in AI-assisted research, shared terminology is ubiquitous — those terms need a single authoritative source. The failure mode is predictable: Project A copies the vocabulary file locally and modifies it. Project B copies the same file and modifies it differently. Six months later, the same term means slightly different things in different contexts. This is SFV threat T1 (Semantic Drift), Chapter 9, operating at the project level rather than the pipeline level.

The solution is the CDN pattern applied to vocabulary: a master database holds canonical term definitions. Consuming projects hold read-only replicas, synchronized periodically. Write protection is enforced — consuming projects cannot modify shared terms locally. If a term needs updating, the change goes through the master, and all replicas pull the update. Same UUIDs everywhere, so references work across the boundary. This is infrastructure, not ceremony. The cost of maintaining it is trivial compared to the cost of discovering, months later, that your pipeline's behavior changed because a term definition drifted.

### 10. The Authority Model: Humans at Decision Points

**Two paragraphs. Where humans intervene, where they do not, and why.**

The default authority model: the AI partner writes artifacts as "proposed" and they are auto-accepted. No blanket approval gates. The human does not review every artifact creation or every relationship link. That would recreate the DOORS problem — provenance overhead that scales linearly with activity.

The human intervenes at decision points: state transitions to "published," changes that affect multiple downstream artifacts, and situations where risk is elevated (novel configurations, first-time model deployments, results that will be cited externally). All state transitions are logged — who changed what, when, and the rationale. The audit trail captures human decisions at the points where they matter, without burdening the human with bookkeeping at every intermediate step. This operationalizes Tenet 5 — humans remain accountable — without creating a bottleneck that slows delivery (Working Principle 2 — slow governance prevents delivery).

### 11. Thought Experiment

Your occupation coding pipeline from Chapter 9's thought experiment produced results last quarter that were published in an official statistical release. Six months later, a reviewer challenges one specific classification in the published data. They want to know:

- Which model version produced this classification?
- What prompt configuration was in effect?
- Was this record processed by the ensemble, or did it route through single-model classification due to a confidence threshold?
- Was the golden test set re-run after the last model update, and what were the results?
- Who signed off on the configuration change between Q3 and Q4?
- Can you prove that the Q3 configuration and the Q4 configuration were identical, or can you document exactly what changed and why?

Trace the provenance requirements backward from these questions. Which of the eight requirements from Section 3 would each question exercise? For the questions you cannot currently answer, identify which requirement — if implemented — would have kept the trail warm.

Now consider the inverse: what is the cost of *not* being able to answer these questions when the IG calls?

### 12. Chapter Bridge to Ch 11

**One to two paragraphs.**

State management and provenance tell you *what happened* and *why*. But the tracking infrastructure needs something to coordinate — the orchestration layer that sequences pipeline steps, manages failures, routes data between components, and could automate some of this provenance capture. The orchestration layer sits between the design patterns of Chapters 5–9 and the institutional deployment of Chapter 13. It is the "how does this actually run?" question.

Orchestration is also the layer where the tool landscape is most volatile. Frameworks rise and fall. Protocols emerge and stall. The market builds for software development, not research. Chapter 11 addresses orchestration not as a product recommendation but as an engineering evaluation framework — how to assess what exists, what to bet on, what to wait on, and how to avoid coupling your pipeline to infrastructure that will not be there in two years.

---

## New BibTeX Entries

No new entries required for the initial draft. All citations used in this chapter are already in `book/references.bib`:
- `webb_2026_ai4stats` — SFV framework canonical source
- `webb_2026_pragmatics` — if deterministic retrieval is referenced
- `webb_2026_concept_mapper` — Federal Survey Concept Mapper case study
- `nist_ai_rmf_2023` — NIST AI RMF (TEVV connection)
- `shapiro_2026` — Shapiro's five levels (Level 2→3 transition)

**Potential addition (verify before including):**

```bibtex
@misc{ibm_doors,
  author       = {{IBM Corporation}},
  title        = {{IBM Engineering Requirements Management DOORS}},
  year         = {2024},
  howpublished = {Product documentation},
  url          = {https://www.ibm.com/products/requirements-management-doors},
  note         = {Originally Telelogic DOORS (Dynamic Object-Oriented Requirements System). Requirements traceability and configuration management for aerospace, defense, and regulated industries.}
}
```

Verify the URL is current before adding. If verification fails, reference DOORS by name in prose without a formal citation — the audience in regulated industries will know what it is.

---

## Cross-Reference Obligations

The draft MUST include these cross-references:

1. **Ch 9 bridge pickup:** Open by connecting to Ch 9's closing paragraph about countermeasures requiring infrastructure.
2. **Ch 7 connection:** Config-driven architecture (Ch 7) as the "save the random seed" principle; configuration control (Ch 10) extends it to "save the specification that authorized the change."
3. **Ch 9 SFV T1:** Shared vocabulary section connects to Semantic Drift (T1) as a project-level threat.
4. **Ch 9 thought experiment continuity:** The thought experiment in Ch 10 extends Ch 9's occupation coding scenario — same pipeline, now challenged by a reviewer/auditor.
5. **Ch 1 Shapiro levels:** Level 2→3 transition in the AI-absorption section.
6. **Ch 2 Concept Mapper:** Referenced as the case study that demonstrated the provenance failure mode.
7. **Tenet/Principle mapping:** Working Principle 4 (Build lineage before scale), Tenet 6 (Defensibility is required), and Tenet 5 (Humans remain accountable) in the authority model section.

---

## Constraints

- **"Confabulation" not "hallucination"** throughout (per NIST AI 600-1, consistent with Ch 9).
- **SFV terminology locked** to `seldon/ontology/validity/VALIDITY_VOCABULARY.md` where SFV terms appear.
- **Seldon framed as worked example**, not product. The requirements are general; the implementation is one solution. "Here is one system that satisfies all eight requirements" — not "here is the system you should use."
- **No SSRN foreshadowing.** The chapter stands alone. Do not reference a paper that does not yet exist.
- **DOORS referenced by name** for the audience's recognition, but the chapter does not become a DOORS comparison or history. One to two paragraphs, then move on.
- **The bone drop is the origin story** — the five failure modes, the reference librarian tax, the cost equation shift. It is not a Seldon tutorial. Do not describe CLI commands, YAML schemas, or implementation details beyond what illustrates the pattern.
- **Approximately 3,500–4,500 words** for the full chapter draft.

---

## Acceptance Criteria

1. Chapter follows the pedagogical pattern: opening hook, core content, distributed reflection prompts (at least 3), thought experiment, chapter bridge.
2. All eight provenance requirements are stated abstractly before any implementation details.
3. The Seldon case study illustrates the pattern without becoming a tutorial.
4. Cross-references to Ch 1, 2, 7, 9 are present and use proper `{cite:t}` / `{cite:p}` roles where citing published works.
5. The DOORS reference is brief and sets up the AI-absorption argument.
6. The thought experiment extends Ch 9's occupation coding scenario.
7. The bridge to Ch 11 sets up orchestration as the coordination layer.
8. No bare prose citations — all use MyST role markup.
9. `seldon verify` passes after execution.
