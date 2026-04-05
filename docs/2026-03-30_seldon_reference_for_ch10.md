# Seldon Reference Document — For Ch 10 Drafting

**Date:** 2026-03-30
**Purpose:** Reference material for Chapter 10 (State Management & Research Provenance). Describes Seldon's requirements, architecture, and design rationale at a level suitable for extracting book-chapter content. Not a Seldon tutorial — the chapter teaches the *pattern*, Seldon is the worked example.

**Canonical repo:** `/Users/brock/Documents/GitHub/seldon/`

---

## 1. What Seldon Is (One Sentence)

An event-sourced research operating system that tracks artifacts, relationships, terminology, and provenance across AI-assisted research workflows using a graph-of-typed-artifacts pattern.

---

## 2. The Problem Seldon Solves

The core failure mode: **output quality and process traceability are decoupled in LLM-assisted research.** You get good results and no audit trail. Reconstructing how results were produced after the fact costs days, not hours — and sometimes results in abandoned projects.

Specific failure modes from direct experience (documented in `docs/2026-03-29_bone_drop_ch10_seldon_origin.md`):

1. **Numbers drift between sessions.** A result computed in conversation (91.2%) gets transcribed to a flat file, then cited as 91.6% three sessions later. No traceable path from the cited number back to the script that produced it.

2. **Tasks fall through cracks.** Session creates sub-tasks #1, #2, #3. #1 gets done. Conversation pivots. #2 and #3 never surface again. Weeks later: forensic archaeology through chat threads.

3. **The reference librarian tax.** The human maintains CLAUDE.md files, catches hallucinated model names, manually tracks which CC tasks were executed, rebuilds session context after every new conversation. This is Level 2 operation — supervisory work that should be automated.

4. **Context windows reset.** The AI assistant doesn't remember last session. Without explicit state serialization (handoff documents), you lose the "why" every time the context resets.

5. **Files don't know about each other.** A chapter cites a paper. A figure derives from a dataset. A design decision affects three chapters. These relationships are the provenance. Flat filesystems can't represent them.

---

## 3. Architecture (As Built)

### 3.1 Dual-Layer Storage: Event Log + Graph Database

Seldon uses a two-layer architecture where the source of truth and the queryable projection are deliberately separated:

```
Source of Truth          Projection (queryable)
─────────────          ──────────────────────
JSONL event log   →    Neo4j graph database
(append-only)          (persistent, indexed)
(in project repo)      (local service, per-project DB)
```

- **`seldon_events.jsonl`** — append-only event log in the project repo. Every artifact creation, state change, and link creation is an event. This is the authoritative record. It lives in git. It's portable. It's the backup.
- **Neo4j graph** — persistent, indexed projection of the event log. Each project gets its own Neo4j database (`seldon-<project-name>`). This is what gets queried. Cypher is the query language for agent retrieval, impact analysis, and provenance traversal.
- **`seldon.yaml`** — project configuration (domain, database connection, settings).

**Every mutation follows the same pattern:**
1. Event appended to JSONL (source of truth)
2. Corresponding Cypher executed against Neo4j (projection)

**Recovery:** If Neo4j dies, `seldon rebuild` replays all JSONL events into a fresh database. No data loss — the event log is the complete history.

**Why this separation matters:** The event log gives you portability, git-friendliness, and an immutable audit trail. The graph database gives you indexed queries, concurrent access, and Cypher — which is a dramatically better interface for agent retrieval than Python traversal code. You need both. The event log without the graph is an audit trail you can't query efficiently. The graph without the event log is a database with no recovery story.

**Key files:**
- Event store: `/Users/brock/Documents/GitHub/seldon/seldon/core/events.py`
- Graph operations: `/Users/brock/Documents/GitHub/seldon/seldon/core/graph.py`
- Event→Graph sync: `/Users/brock/Documents/GitHub/seldon/seldon/core/sync.py`
- Artifact CRUD: `/Users/brock/Documents/GitHub/seldon/seldon/core/artifacts.py`
- State machines: `/Users/brock/Documents/GitHub/seldon/seldon/core/state.py`
- Staleness propagation: `/Users/brock/Documents/GitHub/seldon/seldon/core/staleness.py`

### 3.2 Domain Configuration Layer

Seldon's core engine is domain-agnostic. What makes it a *research* tool is the domain configuration file:

**`/Users/brock/Documents/GitHub/seldon/seldon/domain/research.yaml`**

This YAML file defines:
- **16 artifact types** (Script, Result, DataFile, Figure, Table, PipelineRun, PaperSection, Citation, ResearchTask, LabNotebookEntry, SRS_Requirement, AgentRole, Workflow, OntologyTerm)
- **22+ relationship types** (cites, generated_by, computed_from, implements, blocks, depends_on, validates, produced_by, contains, derived_from, contains_section, appears_in, references_figure, references_table, tabulates, supports, cross_references, context_for, and ontology-specific types)
- **State machines per artifact type** — e.g., Result: `proposed → verified → published → stale`; PaperSection: `proposed → draft → review → published → stale`
- **Property schemas** — required vs. documentation-category properties per type

The domain config is schema, not code. Adding a new domain (engineering, clinical trials) means writing a new YAML file, not new infrastructure.

### 3.3 CLI Interface

Seldon exposes all functionality through a Python CLI (`pip install -e .`, then `seldon <command>`). Claude Code invokes CLI commands via bash. A lightweight MCP server exists for `seldon go` access from Claude Desktop, but the CLI is the primary interface.

**Key command groups (as implemented):**
- `seldon init` — initialize project
- `seldon go` — orientation briefing (queries graph for open tasks, stale artifacts, recent changes)
- `seldon artifact create/list/show/update` — artifact CRUD
- `seldon link create/list` — relationship management
- `seldon result register/verify` — result registry
- `seldon task create/list/update` — task tracking
- `seldon session start/end` — session lifecycle
- `seldon paper sync/build/audit` — paper assembly pipeline
- `seldon ontology ingest/sync/list` — terminology management
- `seldon verify` — universal integrity gate (file hashes, ontology freshness, glossary compliance, reference resolution, stale artifacts, unregistered files)
- `seldon status` — project overview

**CLI source:** `/Users/brock/Documents/GitHub/seldon/seldon/commands/` (13 command modules: artifact.py, docs.py, go.py, init.py, link.py, ontology.py, paper.py, rebuild.py, result.py, session.py, status.py, task.py, verify.py)

### 3.4 Authority Model

Default: AI writes artifacts as `proposed`, and they're auto-accepted. No blanket approval gates. Human intervenes at decision points only — typically state transitions to `published` or when risk factors are elevated.

All state transitions are logged. The graph records *who* changed *what*, *when*, and *why*.

---

## 4. Key Design Patterns (Ch 10 Relevance)

### 4.1 Configuration Control via CC Tasks

Changes to tracked artifacts go through a specification document ("CC task") that records intent before execution. The CC task is the decision record. Written to `cc_tasks/` with date-prefixed filenames.

**42 CC task files** in the Seldon repo alone (`/Users/brock/Documents/GitHub/seldon/cc_tasks/`), each documenting a specific unit of work: what to do, why, what files to touch, acceptance criteria.

This is the research equivalent of infrastructure-as-code: the specification is version-controlled and the execution is traceable back to it.

**Critical rule:** CC task files are never edited or overwritten once written to disk. If changes are needed, write a new file. This ensures the decision record is immutable.

### 4.2 The Graph-of-Artifacts Pattern

Every tracked entity is a typed node in a graph. Relationships between entities (cites, generated_by, computed_from, blocks, etc.) are typed edges. The graph answers provenance questions structurally:

- "Where did this number come from?" → Follow `generated_by` edge to Script, `computed_from` to DataFile
- "What breaks if I change this dataset?" → Follow downstream edges (staleness propagation)
- "Is this paper section fully supported?" → Check that all cited Results have status ≥ verified

**Provenance chain example:**
```
PaperSection → cites → Result → generated_by → Script → implements → SRS_Requirement
                         Result → computed_from → DataFile → produced_by → PipelineRun
```

### 4.3 State Machines on Artifacts

Every artifact type has a defined state machine. State transitions are enforced — you can't jump from `proposed` to `published` without going through `verified`.

This prevents the common failure: citing a result that was never verified, using a dataset that was marked stale, or publishing a section that's still in draft.

### 4.4 Staleness Propagation

When an upstream artifact changes, all downstream dependents are automatically flagged as potentially stale. This is graph traversal: upstream change → find all nodes reachable via dependency edges → mark as `needs_review`.

**Implementation:** `/Users/brock/Documents/GitHub/seldon/seldon/core/staleness.py`

### 4.5 State Serialization (The Handoff Problem)

LLM-assisted workflows have a unique provenance challenge: the conversation that produced the work product is ephemeral. Context windows reset.

Seldon's solution: explicit state serialization via handoff documents (`handoffs/YYYY-MM-DD_<slug>.md`) and session lifecycle commands (`seldon session start/end`). The `seldon go` command reconstructs working context at session start by querying the graph for open tasks, stale artifacts, recent changes, and pending work.

**10 handoff files** in the Seldon repo: `/Users/brock/Documents/GitHub/seldon/handoffs/`

### 4.6 Shared Vocabulary as Infrastructure (AD-017)

**This is a worked example of SFV T1 (Semantic Drift) countermeasure operationalized.**

When multiple projects use the same terms, those terms need a single source of truth. Seldon's AD-017 implements this as a master/replica pattern:

- **Master database** (`seldon-ontology`) holds 51 canonical terms and 36 relationships, parsed from a human-readable markdown vocabulary file
- **Project databases** hold read-only replicas, synced via epoch-based pull (`seldon ontology sync`)
- **Write protection enforced in code** — `create_artifact()` and `update_artifact()` refuse to modify OntologyTerm artifacts in project databases where inheritance is read-only
- **Same UUIDs everywhere** — master assigns IDs, replicas copy them verbatim, references work across the boundary

The key insight for the book: distributed copies cause terminology drift — the exact problem ontologies are meant to prevent. Master/replica with write protection is the correct pattern. It's the CDN model applied to vocabulary.

**Full design doc:** `/Users/brock/Documents/GitHub/seldon/docs/design/AD-017_central_validity_ontology.md`
**Vocabulary source:** `/Users/brock/Documents/GitHub/seldon/ontology/validity/VALIDITY_VOCABULARY.md`
**Parser:** `/Users/brock/Documents/GitHub/seldon/seldon/ontology/parser.py`

### 4.7 Verification Gates (`seldon verify`)

A universal integrity gate that checks:
- File hash integrity (has a tracked file changed out-of-band?)
- Ontology freshness (is the local replica up to date with master?)
- Glossary compliance (does prose use canonical terminology?)
- Reference resolution (are all cited keys resolvable?)
- Stale artifacts (any artifacts flagged stale that haven't been addressed?)
- Unregistered files (files in tracked directories that aren't in the graph)

CC sessions run `seldon verify` before reporting completion. Desktop sessions plan and write; CC sessions execute and verify. This separation is enforced by behavioral contract, documented in `seldon go` output.

**Design doc:** `/Users/brock/Documents/GitHub/seldon/docs/design/AD-018_document_structure_graph.md`

### 4.8 Paper-as-Graph Assembly

Paper sections are graph artifacts. The graph defines section ordering via `sequence` and `depth` properties, parent-child relationships (`contains_section` edges), cross-references (`references_figure`, `references_table`), and figure/table placement (`appears_in`). Assembly is a graph traversal:

- `seldon paper sync` — reads markdown files, creates/updates PaperSection artifacts in the graph, tracks content hashes, parses `##` headings into section hierarchy
- `seldon paper build` — assembles sections in graph-defined order into a single output document, resolves reference tokens (`{{figure:NAME}}`, `{{result:NAME:value}}`) to computed numbers
- `seldon paper audit` — checks for orphan sections, missing cross-references, citation coverage gaps

Figure and table numbers are derived from document position (graph traversal), never hardcoded in prose. Inserting a new figure means re-running the numbering query; all cross-references resolve automatically.

**Implementation:** `/Users/brock/Documents/GitHub/seldon/seldon/paper/` (build.py, sync.py, qc.py, numbering.py)

---

## 5. What Git Doesn't Do (And Why That Matters)

This is the proposed Ch 10 opening hook. The argument:

Git tracks **what changed in files**. Research provenance requires tracking:
- **Why** a change was made (decision rationale)
- **What relationships exist** between artifacts (a figure depends on a dataset which was produced by a script)
- **What state the system was in** when a decision was made (context reconstruction)
- **Whether cited results are still valid** (staleness propagation across the graph)

Git answers "what did you do?" Provenance systems answer "why did you do this, and can I trust the result?"

Git also can't represent relationships between files. A commit that changes `figure_3.py` and `section_4.md` doesn't record that the figure is cited by the section, or that the figure was regenerated because the underlying dataset changed. That semantic layer lives in the graph.

---

## 6. Seldon Repo Structure (For Extended Material Reference)

```
/Users/brock/Documents/GitHub/seldon/
├── CLAUDE.md                          # Boot loader for CC sessions
├── seldon.yaml                        # Project config
├── seldon_events.jsonl                # Event store (source of truth)
├── seldon/                            # Python package
│   ├── cli.py                         # CLI entry point
│   ├── config.py                      # Configuration loading
│   ├── mcp_server.py                  # MCP server (for Desktop `seldon go`)
│   ├── commands/                      # 13 CLI command modules
│   │   ├── artifact.py, docs.py, go.py, init.py, link.py,
│   │   ├── ontology.py, paper.py, rebuild.py, result.py,
│   │   ├── session.py, status.py, task.py, verify.py
│   ├── core/                          # Engine
│   │   ├── artifacts.py               # Artifact CRUD (with write protection)
│   │   ├── events.py                  # JSONL event store
│   │   ├── graph.py                   # Neo4j graph operations
│   │   ├── staleness.py               # Downstream staleness propagation
│   │   ├── state.py                   # State machine enforcement
│   │   └── sync.py                    # Event→Graph sync and rebuild
│   ├── domain/
│   │   ├── research.yaml              # Research domain config (16 types, 22+ rels)
│   │   └── loader.py
│   ├── ontology/
│   │   └── parser.py                  # Vocabulary markdown → graph parser
│   └── paper/
│       ├── build.py                   # Section assembly + token resolution
│       ├── sync.py                    # Markdown → graph sync with heading parser
│       ├── qc.py                      # Quality checks
│       └── numbering.py              # Figure/table numbering from graph position
├── ontology/validity/
│   ├── VALIDITY_VOCABULARY.md         # Canonical term definitions (51 terms)
│   └── provenance/                    # Naming/discovery history
├── docs/
│   └── design/                        # Architectural decisions (AD-011 through AD-018)
├── cc_tasks/                          # 42 CC task files (immutable decision records)
├── handoffs/                          # 10 session handoff documents
├── tests/                             # 29 test files, 341 tests
└── templates/                         # CC task templates, paper conventions
```

---

## 7. Test Coverage

341 tests across 29 test files. Key test areas: artifacts, events, graph operations, state machines, staleness propagation, paper sync/build/QC, ontology ingest/sync (27 ontology tests), document structure, agent roles, session management, verification.

Test source: `/Users/brock/Documents/GitHub/seldon/tests/`

---

## 8. Design Decisions Index (For Extended Material)

All in `/Users/brock/Documents/GitHub/seldon/docs/design/`:

| AD | Title | Status | Ch 10 Relevance |
|----|-------|--------|-----------------|
| AD-011 | Database-Driven Paper Assembly | Implemented | Background for paper-as-graph |
| AD-012 | Paper as Graph Assembly | Implemented | Direct: section ordering, cross-refs |
| AD-013 | Documentation as Traceability | Implemented | Direct: docs are tracked artifacts |
| AD-014 | Agent Roles as Graph Artifacts | Implemented | Specialist retrieval profiles |
| AD-016 | Paper QC Severity Tiers | Design only | Quality control infrastructure |
| AD-017 | Central Validity Ontology | Implemented | Direct: shared vocabulary pattern |
| AD-018 | Document Structure Graph | Implemented | Direct: verification gates, hierarchy, numbering |

---

## 9. Relationship to Other Systems

| System | Relationship | Ch 10 Relevance |
|--------|-------------|-----------------|
| **Wintermute** | Cross-domain knowledge graph. Separate system, separate databases. Seldon is per-project; Wintermute is cross-project. Currently being rebuilt. | Mention as the cross-project layer; don't depend on it for Ch 10 |
| **SFV Paper** | Seldon is the engineering implementation of SFV's validity framework. Paper 1 (SFV) establishes the theory; Paper 2 (planned) would describe Seldon as the methods implementation. | AD-017 is SFV operationalized. Ch 9 → Ch 10 bridge |
| **ANTS** | Historical predecessor. Folded into Seldon per AD-001. Proved the core pattern: graph of typed artifacts, event-sourced JSONL, authority model. 481 artifacts on the Federal Survey Concept Mapper project. | Origin story material |

---

## 10. Key Framing for Chapter 10

**What the chapter teaches (requirements any provenance system must satisfy):**

1. Track artifacts as typed entities, not just files
2. Track relationships between artifacts (the graph)
3. Enforce state machines (proposed → verified → published)
4. Propagate staleness downstream when upstream changes
5. Serialize session state explicitly (handoff documents)
6. Maintain shared vocabulary with write protection (ontology)
7. Gate changes through specification documents (CC tasks / configuration control)
8. Verify integrity automatically before declaring work complete

**Seldon is one implementation. The requirements are general.** A reader could satisfy these requirements with a simpler system (even a well-structured directory of YAML files with a validation script), or with a more complex one (a full MLOps platform). The point is that the requirements exist whether you build infrastructure for them or not — and if you don't, you pay the reconstruction tax.
