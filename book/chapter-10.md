# Chapter 10: State Management & Research Provenance

<!-- STATUS: Draft -->
<!-- Case study: Seldon artifact tracking system (worked example, not tutorial) -->
<!-- SHARED ONTOLOGY: Terms from seldon/ontology/validity/VALIDITY_VOCABULARY.md -->
<!-- Primary Working Principle: Build lineage before scale -->
<!-- Primary Tenet: Defensibility is required -->

## Defensible by Design

Your agency deployed an AI-assisted occupation coding pipeline. It ran for three quarters. The results are challenged. Maybe by a reviewer, maybe by an Inspector General, maybe by a congressional inquiry. The question is not "did the pipeline produce good results?" The question is: can you prove it?

Can you show, to an independent auditor who was not there, which model version was used? Which prompt configuration? Which training data cutoff was in effect? Whether human review occurred where required? Whether the golden test set was re-run after the last model update? Whether the configuration that produced Q3 results is the same configuration that produced Q4 results?

If you cannot reconstruct the chain from input to output with enough fidelity to survive an independent audit, it does not matter how good the pipeline was. The results are indefensible.

This chapter is about building the infrastructure that makes AI-assisted research defensible, not after the fact, but by design. Chapter 9 named the problem: the instrument changes during use, and the changes are silent. The countermeasures from prior chapters are the engineering response. But countermeasures require infrastructure. This chapter provides it.

## Three Reasons Provenance Is Not Optional

**Defensibility.** The ability to survive an independent audit. Not just "we kept good records" but "we can reconstruct the complete decision chain from raw input to published output, including model versions, prompt configurations, arbitration decisions, and human review points." In federal statistical agencies, this is not aspirational. It is a requirement. When AI enters the production pipeline, the provenance requirements do not relax; they intensify, because the instrument itself is more complex and less transparent than traditional statistical methods. Research that cannot be reproduced cannot be defended. The SCORE project (Systematizing Confidence in Open Research and Evidence), a seven-year effort involving 865 researchers, examined social and behavioral science research at scale: only 24\% of 600 papers had sufficient data to attempt reproduction, and of the 143 where reproduction was attempted, 74\% reproduced approximately but only 54\% reproduced precisely {cite:p}`miske_2026`. In economics, only about 30\% of recent studies meet even a basic computational reproducibility standard {cite:p}`brodeur_2025_ssrp`; research published under stronger data and code sharing norms showed substantially higher reproducibility rates {cite:p}`brodeur_2026`. AI-assisted research, with more complex and dynamic instrumentation than traditional statistical methods, cannot afford a weaker documentation standard.

**Entropy management.** Long-running projects over months with multiple sessions, finite context windows, and team coordination accumulate entropy. Numbers drift between sessions. Tasks fall through cracks. Configuration details get transcribed incorrectly. Terminology shifts. Without enforced tracking, things degrade silently, the same state drift Chapter 9 describes at the pipeline level, but now at the project level. The processing cost of provenance infrastructure is quality insurance. The alternative, fighting entropy retroactively, costs more in every case.

**Scientific rigor.** Provenance infrastructure enforces the documentation discipline that good science requires. Over months of work, memories fade, rationales get reconstructed rather than recalled, and "I think we did it this way" replaces "here is the record showing exactly what happened." Provenance infrastructure is the research equivalent of standardized laboratory procedure: it reduces variance in the process itself, strengthens the claims that emerge from the process, and ensures that the work is reproducible by someone who was not in the room.

> *Think about your last major analysis or pipeline project. If someone asked you today to reconstruct exactly how a specific result was produced, not approximately but exactly, how far back could you trace the chain? Where would the trail go cold?*

## Eight Requirements for Research Provenance

These are what any provenance system, simple or complex, custom or commercial, must satisfy to support defensible AI-assisted research.

**Requirement 1: Typed artifacts.** Track entities as typed objects, not just files. A "script" is different from a "result" is different from a "figure" is different from a "dataset." The type carries semantics: what the artifact is, what states it can be in, what relationships it can have. A flat filesystem treats everything as a file. A provenance system treats everything as a typed entity with properties and constraints.

**Requirement 2: Relationships between artifacts.** A chapter cites a result. A result was generated by a script. A script computed from a dataset. A dataset was produced by a pipeline run. These relationships are the provenance. Without them, you have a collection of files in a directory. With them, you have a traceable chain from output to input. The relationships must be explicit and queryable, not implicit in filenames or comments.

**Requirement 3: State machines** (a formal model where an artifact exists in exactly one defined state at a time, and transitions between states follow explicit rules)**.** Artifacts move through states: proposed, draft, verified, published, stale. State transitions should be enforced. You cannot cite a result that was never verified, publish a section that is still in draft, or use a dataset that has been marked stale. State machines prevent the common failure of treating unvalidated artifacts as if they were authoritative.

**Requirement 4: Staleness propagation.** When an upstream artifact changes, all downstream dependents must be flagged as potentially stale. If the dataset changes, every result computed from that dataset needs review. If a script changes, every result it generated may be affected. This is graph traversal: follow the dependency edges downstream from the changed artifact and mark everything reachable as needing review.

**Requirement 5: State serialization.** LLM-assisted workflows have a unique provenance challenge: the conversation that produced the work product is ephemeral. Context windows reset between sessions. The AI partner does not remember what happened last time. Without explicit state serialization, documents that capture enough context to reconstruct the working state, you lose the "why" every time the context resets. Handoff documents, session logs, and structured briefings at session start are all forms of state serialization.

**Requirement 6: Shared vocabulary with write protection.** When multiple projects or pipeline components use the same terms, those terms need a single source of truth. Distributed copies cause terminology drift, the exact problem shared vocabulary is meant to prevent. The correct pattern is a master/replica model: one authoritative source, read-only replicas in consuming projects, write protection enforced so local projects cannot diverge from canonical definitions.

**Requirement 7: Change gating through specification documents.** Changes to tracked artifacts go through a specification document that records intent before execution. The spec says what will change, why, what files are affected, and what acceptance criteria apply, before the change is made. The specification is the decision record. It is version-controlled. It is immutable once written. Corrections go in new documents that reference the original. This is the research equivalent of infrastructure-as-code: the specification is the auditable artifact, not the change itself. This is the specification-before-execution pattern: define what will change and why before making the change. The specification document is not bureaucracy; it is the artifact that makes the change auditable, reversible, and attributable to a deliberate decision rather than an ad-hoc edit.

**Requirement 8: Automated integrity verification.** A verification gate that checks, automatically, before declaring work complete, whether file hashes match expectations, whether cited references resolve, whether tracked artifacts are consistent, whether anything has changed out-of-band. Humans forget to check. Automated verification does not forget.

> *Which of these eight requirements does your current workflow satisfy? Which ones does it violate? For the ones it violates, have you ever experienced the failure mode that the requirement is designed to prevent?*

## Why Git Alone Does Not Satisfy Them

Git tracks file-level diffs. It records what changed and when. It does not track *why* a change was made. Commit messages are optional and rarely contain the full reasoning. It does not track relationships between files: a commit that modifies a script and a chapter does not record that the chapter cites a result generated by that script. It does not track artifact state: git does not know whether a result is "proposed" or "verified" or "stale." And it does not propagate staleness: if a dataset changes, git does not flag every result computed from that dataset as needing review.

Git answers "what did you do?" Research provenance answers "why did you do this, what depended on it, and can I trust the result?" Git is necessary infrastructure. Version control is non-negotiable. But it is not sufficient for research provenance. The semantic layer must sit on top of it.

## The DOORS Lesson: Right Requirements, Wrong Cost Model

IBM DOORS (Dynamic Object-Oriented Requirements System) is a requirements management tool widely used in aerospace and defense, where traceability and regulatory compliance are critical. It got the requirements right decades ago. Typed artifacts. Traceability matrices. Relationship tracking between requirements, implementations, and test cases. The aerospace and defense industries used it because the regulatory environment demanded it. The requirements traceability problem that DOORS solved is the same problem this chapter describes {cite:p}`gotel_1994`.

The adoption problem was human cost. Maintaining a DOORS database required dedicated operators. The friction of updating traceability matrices manually, for every change, was brutal. In research environments without the regulatory mandate of aerospace, the cost-benefit calculation never justified the overhead. The requirements were right. The cost model was wrong. AI partners fix the cost model.

## AI Partners Change the Cost Equation

AI partners change the cost equation for provenance infrastructure. The bookkeeping that killed adoption of systems like DOORS, maintaining the artifact graph, updating traceability relationships, flagging staleness, reconstructing session context, is exactly the kind of structured, repetitive, context-dependent work that AI assistants absorb well.

The human moves from Level 2 operation ({cite:t}`shapiro_2026`'s levels from Chapter 1), manually tracking artifacts, catching errors, rebuilding context, to Level 3 and beyond: specifying intent and verifying outcomes. The AI partner maintains the graph, writes specification documents from design conversations, flags when tracked artifacts are stale, and reconstructs working context at session start. The human operates at the decision level: "should we change this design?" not "update row 47 of the traceability matrix."

The author's experience building the Federal Survey Concept Mapper {cite:p}`webb_2026_concept_mapper` demonstrated this failure mode concretely: the pipeline produced reliable results, but reconstructing how those results were produced after the fact took days of forensic work through conversation logs and file histories. In one case, the author abandoned a separate project entirely because its provenance trail had gone cold — there was no recoverable path from outputs back to the decisions that produced them. The reference librarian tax, the human maintaining architectural documentation, catching confabulated model names, manually tracking task completion, rebuilding session context after every new conversation, consumed intellectual capital that should have been spent on design work. AI partners absorb that tax.

> *What fraction of your time on a multi-session project is spent on logistics, tracking what happened, rebuilding context, coordinating state across sessions, versus the actual intellectual work of the project? What would it mean if that fraction dropped by half?*

## Configuration Control as a Design Pattern

Configuration control is the discipline of gating changes through specification documents. In software engineering, this manifests as infrastructure-as-code: the desired state of the system is declared in version-controlled files, and changes to the system go through changes to those files. In research, the same principle applies: changes to tracked artifacts go through a specification document that records what will change, why, what files are affected, and what acceptance criteria apply.

The specification document is written before the change is made. It is the decision record. Once written, it is immutable. If corrections are needed, they go in a new document that references the original. This immutability ensures the audit trail is append-only. You can always reconstruct the sequence of decisions that produced the current state by reading the specifications in chronological order.

This connects directly to Chapter 7's reproducible research discipline. Chapter 7 argues that config-driven architecture is the "save the random seed" principle extended to LLM pipelines. Configuration control extends it further: not just "save the configuration that produced the result" but "save the specification that authorized the change to the configuration." The specification is the rationale layer that configuration files alone do not capture.

## The Graph-of-Artifacts Pattern

Here is one system that satisfies all eight requirements. The pattern matters more than the implementation.

### The Problem That Motivated the System

Five concrete failure modes from direct experience building AI-assisted research pipelines:

Numbers drift between sessions. A result computed in conversation gets transcribed to a file, then cited with a different value three sessions later. No traceable path from the cited number back to the computation that produced it.

Tasks fall through cracks. A session creates three sub-tasks. One gets done. The conversation pivots. The other two never surface again. Weeks later: forensic archaeology through chat histories.

The reference librarian tax. The human maintains documentation files so AI coding assistants follow established patterns. Catches confabulated model names. Manually tracks which tasks were executed, which files were modified, which artifacts are stale. Rebuilds session context after every new conversation. This is supervisory overhead that should be automated.

Context windows reset. The AI partner does not remember last session. Without explicit state serialization, you lose the "why" every time the context resets.

Files do not know about each other. A chapter cites a paper. A figure derives from a dataset. A design decision affects three chapters. These relationships are the provenance. Flat filesystems cannot represent them.

### The Dual-Layer Architecture

The system uses a two-layer architecture that separates the source of truth from the queryable projection:

An *append-only event log* (a file where new entries are added at the end and existing entries are never modified or deleted, stored as JSONL, JSON Lines: one JSON object per line, lives in git). Every artifact creation, state change, and link creation is an event. This is the immutable audit trail. It is portable, a text file in the repository. If the query layer dies, the event log is the complete recovery path.

A *graph database* that is a persistent, indexed projection of the event log (the graph is derived from the log and can be rebuilt from it at any time). Artifacts are nodes. Relationships are edges. Provenance queries, "where did this number come from?", "what breaks if I change this dataset?", "is this section fully supported?", are graph traversals.

Why both layers? The audit trail needs to be immutable and portable: an append-only log in version control. The provenance needs to be queryable and fast: a graph database with indexed traversal. The event log without the graph is an audit trail you cannot query efficiently. The graph without the event log is a database with no recovery story and no immutable history. Every mutation follows the same pattern: event appended to the log (source of truth), then the corresponding update executed against the graph (projection). If the graph is corrupted or lost, rebuild it by replaying all events from the log.

### Provenance Chains in Practice

One provenance chain:

```
PaperSection → cites → Result → generated_by → Script → computed_from → DataFile
```

This chain answers the audit question: "Where did this number in the paper come from?" Follow the edges: the section cites a result; the result was generated by a script; the script computed from a dataset. Every link is an explicit, typed relationship in the graph. The auditor can traverse the chain without relying on the researcher's memory.

Staleness propagation is graph traversal: if the DataFile changes, follow the downstream edges, every Result computed from it, every PaperSection that cites those Results, and flag them as needing review. The researcher does not have to remember which sections are affected. The graph knows.

State machines on artifacts enforce lifecycle discipline: a Result cannot be cited in a published PaperSection unless the Result has reached "verified" status. A PaperSection cannot move to "published" unless all cited Results are verified and all referenced Figures are current. The state machine prevents the common failure of treating unvalidated artifacts as authoritative.

### Domain Configuration, Not Domain Code

The core engine is domain-agnostic. What makes it a research tool is a configuration file, a YAML schema that defines artifact types, relationship types, state machines per type, and required properties. Adding a new domain means writing a new configuration file, not new infrastructure. The eight requirements from earlier in this chapter are general. The domain configuration makes them specific.

> *If you had to show an auditor the complete provenance chain for a specific result in your current project, which links in the chain are explicit and which are implicit? Where does the trail depend on your memory rather than a system of record?*

## When Pipeline State Is Graph-Shaped

Chapter 6 established the design choice: tabular state belongs in relational storage; graph-shaped state, state that involves typed relationships between entities, belongs in a relationship-aware data model. This section provides the implementation guidance for graph-shaped state in research pipelines.

**What makes state graph-shaped.** Research pipeline state becomes graph-shaped when you need to traverse relationships to answer operational questions. Artifact dependencies (this result was generated by that script, which computed from this dataset) form a directed graph. Decision provenance (decision A superseded decision B, which was informed by evidence C) is a path through a relationship structure. Typed relationships between entities (*depends_on*, *informs*, *supersedes*, *tracks*) are the edges that make impact analysis and staleness propagation tractable. When you find yourself constructing a JOIN across three or more tables to answer a provenance question, you have a graph you have not named yet.

**State nodes and relationship types.** In a graph model for research provenance, entities are nodes with types and properties. A script node has a version, a hash, a state (active, deprecated). A dataset node has a source, a timestamp, a state (current, stale). The relationships between them are not just foreign keys; they are typed, directed edges that carry their own properties. The *generated_by* edge from a result to a script carries a timestamp and a configuration reference. The *depends_on* edge from a section to a result carries a status (confirmed, pending reverification). These relationship properties are what make provenance queries precise: not just "what depends on this dataset" but "what depends on this dataset in a state that would be affected by this specific change."

**A research pipeline management system as worked example.** A system built to track research artifacts across a multi-chapter book project uses this pattern directly. Artifact nodes with types (chapter, result, figure, dataset, decision). Typed relationship edges (informs, depends_on, supersedes, tracks). State properties on each node. Session orientation reconstitutes working context from the graph at session start: the system answers "what is the current state of the project?" by traversing the graph, not by relying on any one session's memory. Cascade impact analysis determines the blast radius of a proposed change by following dependency edges downstream and surfacing all artifacts that would need review. Every one of these operations is a graph traversal; none of them maps cleanly to a relational query. The transferable pattern: if your provenance system needs to answer "what downstream artifacts are affected by this change?" you need a traversal, not a JOIN.

**Deterministic retrieval as graph pattern.** The same structural logic extends to retrieval. A retrieval-augmented generation system returns content *similar* to the query: probabilistic, embedding-based similarity. A structured knowledge base returns the specific judgment that applies to the specific input, traversed deterministically. When the pipeline needs a particular expert judgment rather than a semantically related one, graph traversal outperforms embedding similarity. Chapter 9's Pragmatics case demonstrated this: 91.2% pipeline fidelity via deterministic retrieval versus 74.6% for retrieval-augmented generation {cite:p}`webb_2026_pragmatics`, a 16.6 percentage point difference attributable to structure over similarity. The knowledge graph literature formalizes what the engineering intuition suggests: typed relationships between entities, traversed by path, recover information that vector distance cannot {cite:p}`hogan_2021`.

**The relational-to-graph migration path.** Your provenance system does not need to start as a graph database. The migration path is conceptual. Run logs, parameter snapshots, and configuration histories are tabular; keep them in relational storage or structured files. Artifact dependencies, decision chains, and provenance edges are graph-shaped: when you find yourself doing multi-table JOINs to answer "what would break if I changed this dataset?", move those relationships into a graph model. The query that requires four JOINs in a relational schema becomes a two-step path traversal in a graph model. The gain is not speed; it is expressibility. Path queries and variable-length traversals over relationship structures are operations that relational databases were not designed for. A graph model makes them direct.

**Practical tradeoffs.** Most research pipelines need both models. The event log (append-only, in version control) is the immutable history. The graph database is the queryable projection. Run logs stay tabular. Provenance chains go in the graph. The design rule from Chapter 6 applies: match your storage to the shape of your state. Tabular state stays tabular. Relationship-rich state gets a relationship-aware model. The choice is not relational or graph. It is: which parts of your state require traversal to answer the operational questions your provenance system must answer?

## Shared Vocabulary as Infrastructure

When multiple projects or pipeline components use the same terms, and in AI-assisted research shared terminology is ubiquitous, those terms need a single authoritative source. The failure mode is predictable: Project A copies the vocabulary file locally and modifies it. Project B copies the same file and modifies it differently. Six months later, the same term means slightly different things in different contexts. This is SFV threat T1 (Semantic Drift, Chapter 9), operating at the project level rather than the pipeline level.

The solution is the CDN pattern (like a content delivery network that serves identical copies from a single authoritative source) applied to vocabulary: a master database holds canonical term definitions. Consuming projects hold read-only replicas, synchronized periodically. Write protection is enforced, consuming projects cannot modify shared terms locally. If a term needs updating, the change goes through the master, and all replicas pull the update. Same identifiers everywhere, so references work across the boundary.

## The Authority Model: Humans at Decision Points

The default authority model: the AI partner writes artifacts as "proposed" and they are auto-accepted. No blanket approval gates. The human does not review every artifact creation or every relationship link. That would recreate the DOORS problem: provenance overhead that scales linearly with activity.

The human intervenes at decision points: state transitions to "published," changes that affect multiple downstream artifacts, and situations where risk is elevated (novel configurations, first-time model deployments, results that will be cited externally). All state transitions are logged: who changed what, when, and the rationale. The audit trail captures human decisions at the points where they matter, without burdening the human with bookkeeping at every intermediate step. This operationalizes Tenet 5, humans remain accountable, without creating a bottleneck that slows delivery.

## Where to Start

The infrastructure described in this chapter can seem daunting. Graph databases, dual-layer architectures, shared ontologies, authority models. If you are starting from nothing, do not build all of it at once. Start with the minimum viable provenance setup and add layers as the pain points emerge.

**Start with a JSONL event log.** One append-only file. Every pipeline run appends a JSON object with: run ID, timestamp, model identifier and version, prompt template version, input file hash, record count, configuration snapshot (or hash of the config file), and outcome summary (records processed, error count, disagreement rate). This file lives in version control alongside your code. It is append-only: you never edit prior entries, only add new ones. This single file, maintained consistently, answers most of the "what happened and when" questions that arise in the first six months of a pipeline's life.

**Add per-record provenance when volume justifies it.** Once your pipeline processes enough records that you need to answer "why did this specific record get this specific result," extend the event log to per-record granularity. The minimum fields from Chapter 5 apply: input record ID, model output, final value, decision rule, agreement flag. Store this as structured output (JSONL or a relational table) alongside the run-level log. At this stage you have two layers: run-level events and record-level provenance, both append-only, both in version control or a simple database.

**Add a graph when you need traversal.** The signal that you need a graph model is when your questions become relational: "what downstream artifacts are affected if I change this prompt template?" or "which results were produced by the configuration that was in effect before the March update?" If you are doing multi-table JOINs to answer these questions, or worse, grepping through log files manually, the query pattern has outgrown the storage model. Move the relationship-rich state into a graph; keep the event logs as the immutable source of truth that feeds it.

The migration path is additive, not replacement. The JSONL log does not go away when you add a database. The database does not go away when you add a graph. Each layer serves a different query pattern. Most research pipelines in their first year need only the first layer. Know what the next layer looks like so you recognize the pain point when it arrives.

---

### Thought Experiment

Your agency's occupation coding pipeline processes survey responses and classifies them into occupational categories for official statistical releases. The pipeline ran for three consecutive quarters, with results published each quarter in official statistical releases. Six months after the final quarter's release, a reviewer challenges one specific classification in the published data. They want to know:

- Which model version produced this classification?
- What prompt configuration was in effect?
- Was this record processed by the ensemble, or did it route through single-model classification due to a confidence threshold?
- Was the golden test set re-run after the last model update, and what were the results?
- Who signed off on the configuration change between Q3 and Q4?
- Can you prove that the Q3 configuration and the Q4 configuration were identical, or can you document exactly what changed and why?

Trace the provenance requirements backward from these questions. Which of the eight requirements from earlier in this chapter would each question exercise? For the questions you cannot currently answer, identify which requirement, if implemented, would have kept the trail warm.

Now consider the inverse: what is the cost of not being able to answer these questions when the IG calls?

---

State management and provenance tell you what happened and why. But the tracking infrastructure needs something to coordinate: the orchestration layer that sequences pipeline steps, manages failures, routes data between components, and could automate some of this provenance capture. The orchestration layer sits between the design patterns of Chapters 5 through 9 and the institutional deployment of Chapter 13.

Orchestration is also the layer where the tool landscape is most volatile. Frameworks rise and fall. Protocols emerge and stall. The market builds for software development, not research. Chapter 11 addresses orchestration not as a product recommendation but as an engineering evaluation framework: how to assess what exists, what to bet on, what to wait on, and how to avoid coupling your pipeline to infrastructure that will not be there in two years.
