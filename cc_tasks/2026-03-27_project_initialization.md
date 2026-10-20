# CC Task: Initialize ai-workflow-design Project

**Date:** 2026-03-27
**Project:** AI Workflow Design for Official Statistics
**Repo:** `brockwebb/ai-workflow-design`
**Scope:** Full project initialization — git, GitHub, Seldon, scaffolding, shared ontology

---

## Context

New book project: *AI Workflow Design for Official Statistics*. Sequel to ai4stats. Teaches builders how to design reliable AI/LLM workflows for statistical research — classification, data cleaning, imputation, detection, extraction. Covers ensemble methods, multi-model architectures, checkpoint/recovery, cost engineering, evaluation-by-design.

The project directory already exists at `/Users/brock/Documents/GitHub/ai-workflow-design/` with partial scaffolding (CLAUDE.md, README.md, one chapter placeholder, and empty directories). This task formalizes everything and brings it under Seldon management.

**Shared Ontology Requirement (AD-017):** Per the Central Validity Ontology architecture decision, this project must inherit the shared validity vocabulary from the main Seldon repo (`/Users/brock/Documents/GitHub/seldon/ontology/validity/`). The canonical definitions live there — this project does NOT maintain local copies. Chapter 9 (State, Drift, and Validity) references SFV extensively and must pull terms from the shared namespace, not from local definitions.

## Lessons Applied from ai4stats Hotwash

- Lock structure before writing prose (outline → review → lock → write)
- Start with bibliography/citation approach from chapter 1
- Build PDF pipeline with prototype chapter before scaling
- CC tasks are the unit of work from day one
- Handoff documents at every session boundary
- `str_replace` doesn't work on user filesystem — read-modify-write only
- `github:create_or_update_file` is PROHIBITED on this repo
- Offload execution to Claude Code, keep orchestration lean

---

## Step 1: Git Init (local)

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
git init
```

## Step 2: Create .gitignore

Write `.gitignore` to project root:

```
# OS
.DS_Store
Thumbs.db

# Python
__pycache__/
*.py[cod]
*.egg-info/
.venv/
venv/

# Build outputs (tracked selectively)
exports/_combined_DEBUG.md
exports/_debug_output.typ

# Environment
.env
.env.local

# IDE
.vscode/
.idea/

# Seldon internal (tracked by Seldon, not git)
# .trace/ is tracked by git for portability

# Scripts directory (build scripts, gitignored per ai4stats convention)
# scripts/

# Node
node_modules/
```

## Step 3: Create GitHub Repo (private)

Use GitHub MCP:
```
github:create_repository
  name: ai-workflow-design
  description: "AI Workflow Design for Official Statistics — practical design patterns for reliable AI-powered data processing pipelines"
  private: true
  autoInit: false
```

## Step 4: Connect local to remote

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
git remote add origin https://github.com/brockwebb/ai-workflow-design.git
```

## Step 5: Create seldon.yaml

Write `seldon.yaml` to project root. **Note the `shared_ontology` section** — this connects this project to the central validity vocabulary per AD-017:

```yaml
project:
  name: ai-workflow-design
  description: "AI Workflow Design for Official Statistics"
  database: seldon-ai-workflow-design

paths:
  cc_tasks: cc_tasks/
  handoffs: handoffs/
  book: book/
  docs: docs/
  assets: assets/

shared_ontology:
  # Per AD-017: Central Validity Ontology
  # This project inherits shared terminology from the main Seldon repo.
  # Canonical definitions live in seldon/ontology/ — NOT in this project.
  # Project-level terms can extend but never override the shared namespace.
  source: /Users/brock/Documents/GitHub/seldon/ontology/
  vocabularies:
    - validity/VALIDITY_VOCABULARY.md
  inheritance: read-only  # This project queries, does not own

conventions:
  cc_task_naming: "YYYY-MM-DD_<descriptive_slug>.md"
  chapter_naming: "chapter-NN.md"
  handoff_naming: "HANDOFF_YYYY-MM-DD-sessionN.md"
  figures_term: "figure"
  prohibited_tools:
    - "github:create_or_update_file"
```

**If Seldon does not yet support a `shared_ontology` key in seldon.yaml**, then Seldon should determine the correct mechanism to:
1. Link this project's Neo4j database (`seldon-ai-workflow-design`) to the shared validity ontology nodes in the Seldon-self graph
2. Ensure SFV terms (sub-dimensions TC/SP/CF/SC/SCoh, threats T1-T5, severity scale, confabulation terminology) are queryable from this project's context
3. Any project-specific terms created here are tagged as project-level, not promoted to the shared namespace without an explicit promotion CC task

The intent is clear per AD-017 — Seldon should know how to handle this. If the mechanism differs from what's specified above, Seldon should use its own preferred approach.

## Step 6: Verify/Update CLAUDE.md

The existing CLAUDE.md at project root should be reviewed. Ensure it includes:
- Project overview and thesis
- Chapter outline (10 chapters)
- Workflow rules (Seldon-managed, CC task discipline, citation requirements)
- Key source material references
- Build system TBD note
- Lessons from ai4stats hotwash integrated
- **Reference to shared ontology** — add note that SFV terms come from `seldon/ontology/validity/VALIDITY_VOCABULARY.md`, not local definitions

**Current CLAUDE.md needs one addition:** Add under "Workflow Rules":

```
- **Shared ontology (AD-017):** SFV terminology and validity vocabulary are inherited from
  the main Seldon repo (`seldon/ontology/validity/VALIDITY_VOCABULARY.md`). This project
  does NOT maintain local copies of shared definitions. Chapter 9 references SFV; all terms
  must match the canonical vocabulary. Project-specific terms stay local until explicitly
  promoted via CC task.
```

## Step 7: Create Chapter Placeholders

Create the following files in `book/`. Chapter 1 already exists. Create chapters 2-10:

**book/chapter-02.md:**
```markdown
# Chapter 2: Classification & Coding Workflows

<!-- STATUS: Placeholder -->
<!-- Case study: Federal Survey Concept Mapper -->

## Working Notes

- Survey question mapping, occupation/industry coding, document classification
- Ensemble agreement scoring — never trust a single model call
- Confidence routing: high-agreement → auto-accept, low-agreement → human review
- Dual-model cross-validation (concept mapper pattern)
- The 99.5% accuracy at ~$15 story
- ABBA design: switch model order to detect position bias
```

**book/chapter-03.md:**
```markdown
# Chapter 3: Data Cleaning & Imputation Workflows

<!-- STATUS: Placeholder -->

## Working Notes

- LLMs for anomaly detection, inconsistency flagging, imputation proposals
- Where LLMs complement traditional methods (HB, Fellegi-Holt) vs where they don't
- Edit/imputation pipeline design
- The ground truth problem: no labeled "actually wrong" records
- Stratification constraints on ML training
- Survey design effects (weights, clustering) vs off-the-shelf assumptions
```

**book/chapter-04.md:**
```markdown
# Chapter 4: Detection & Extraction Workflows

<!-- STATUS: Placeholder -->

## Working Notes

- Entity extraction, pattern detection, disclosure review assistance
- Recall vs precision tradeoffs in statistical contexts
- When false negatives are worse than false positives (and vice versa)
- Designing extraction pipelines with verification steps
```

**book/chapter-05.md:**
```markdown
# Chapter 5: The Ensemble & Multi-Model Playbook

<!-- STATUS: Placeholder -->
<!-- Cross-cutting "how" chapter referenced by chapters 2-4 -->

## Working Notes

- ABBA designs: run Model A then Model B, then Model B then Model A
- Judge loops: model-as-judge, switching judge identity
- Agreement scoring: when models agree, confidence is high
- Model order effects and position bias detection
- When to use 2 models vs 3 vs N
- Consensus thresholds and escalation rules
- The "never trust a single model call" principle
```

**book/chapter-06.md:**
```markdown
# Chapter 6: Parallel, Serial, and the Bottleneck

<!-- STATUS: Placeholder -->

## Working Notes

- The Hadoop parallel: what's parallel, what's serial, where's the bottleneck
- LLM as the bottleneck node — designing around it
- Rate limits, latency, token throughput
- Batch design: chunk size, queue management, progress tracking
- The $15 vs $1500 lesson: design determines cost, not model choice
- When to parallelize API calls vs when serial is safer
```

**book/chapter-07.md:**
```markdown
# Chapter 7: Checkpoints, Failures, and Recovery

<!-- STATUS: Placeholder -->

## Working Notes

- Everything fails. Design for it.
- Checkpoint patterns: save state after each successful step
- Retry logic: idempotent operations, exponential backoff
- Picking up where you left off after a crash
- Config-driven state management
- Error classification: transient (retry) vs permanent (escalate) vs data (log and continue)
- Logging that gives you diagnostics, not just timestamps
```

**book/chapter-08.md:**
```markdown
# Chapter 8: Evaluation by Design

<!-- STATUS: Placeholder -->

## Working Notes

- It's less about statistics and more about designing systems that give you statistics
- Metrics collection as architecture, not afterthought
- Build evaluation into the pipeline from day one
- A/B comparison infrastructure
- Logging for analysis: what to capture, how to structure it
- The difference between "did it work?" and "how well did it work?"
- Batch testing economics: processing time vs cost vs quality tradeoffs
```

**book/chapter-09.md:**
```markdown
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
```

**book/chapter-10.md:**
```markdown
# Chapter 10: Cost & Practicality

<!-- STATUS: Placeholder -->

## Working Notes

- Token budgets: estimating cost before running
- Batch economics: cost per item at scale
- When cheap models win (and when they don't)
- Making the case to your program office / budget authority
- The hidden costs: developer time, review time, error correction
- Cost comparison frameworks: LLM pipeline vs manual process vs traditional automation
- Configuration-driven model selection: swap models without rewriting code
```

## Step 8: Create bibliography.md

**book/bibliography.md:**
```markdown
# Bibliography

<!-- 
  LESSON FROM AI4STATS: Start bibliography from chapter 1. 
  Every CC task that introduces a claim with a source adds the entry here.
  No exceptions. The citation is part of the content, not a polish step.
-->

## References

<!-- Entries in APA 7th edition format, alphabetical by first author -->

Webb, B. (2026). *AI for Official Statistics.* Zenodo. https://doi.org/10.5281/zenodo.19206379

Webb, B. (2026). *When AI Enters Federal Statistics: A Regulatory Crosswalk of NIST AI RMF and FCSM Statistical Quality Standards.* Zenodo. https://doi.org/10.5281/zenodo.18772590
```

## Step 9: Initialize Seldon

```
seldon-mcp:seldon_go
  project_dir: /Users/brock/Documents/GitHub/ai-workflow-design
```

If Seldon needs a `seldon.yaml` first (Step 5), create that before calling `seldon_go`.

Then register initial artifacts:
- CLAUDE.md (type: project-config)
- README.md (type: project-config)
- seldon.yaml (type: project-config)
- book/chapter-01.md through book/chapter-10.md (type: chapter, status: placeholder)
- book/bibliography.md (type: reference)
- cc_tasks/2026-03-27_project_initialization.md (type: cc-task — this file)

## Step 10: Shared Ontology Inheritance

After Seldon initializes the project database (`seldon-ai-workflow-design`), establish the connection to the shared validity ontology:

1. **Seldon should import/link the shared vocabulary** from `seldon/ontology/validity/VALIDITY_VOCABULARY.md` into this project's graph context per AD-017
2. **Verify inheritance:** Query the project graph to confirm SFV terms (sub-dimensions, threats, severity scale) are accessible
3. **Establish project-level namespace:** Any new terms created for this project (e.g., workflow-specific design pattern terminology) are tagged as `project:ai-workflow-design`, distinct from the shared `ontology:validity` namespace
4. **If the Neo4j ingestion script from AD-017 is not yet built:** Document this as a known gap and note that for now, the canonical reference is the markdown file. The graph-based inheritance is the target architecture; manual reference to the markdown is the interim approach.

Seldon knows the AD-017 architecture — use whatever mechanism Seldon currently supports for cross-project ontology sharing. If that mechanism doesn't exist yet, Seldon should flag it and the interim approach (explicit markdown reference) is acceptable.

## Step 11: Initial Commit

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
git add -A
git commit -m "Initial project scaffolding: AI Workflow Design for Official Statistics

10-chapter structure, Seldon-managed from day one.
Shared validity ontology inherited per AD-017.
Sequel to ai4stats (DOI: 10.5281/zenodo.19206379).
Lessons from ai4stats hotwash applied to project setup."
git branch -M main
git push -u origin main
```

## Step 12: Write Session 1 Handoff

Write `handoffs/HANDOFF_2026-03-27-session1.md` documenting:
- Project created and initialized
- Chapter structure locked (10 chapters)
- Title locked: "AI Workflow Design for Official Statistics"
- Seldon initialized with shared ontology inheritance (AD-017)
- GitHub repo created (private)
- Next: begin drafting chapter 1

---

## Verification

- [ ] Git repo initialized locally
- [ ] GitHub repo exists (private) at brockwebb/ai-workflow-design
- [ ] seldon.yaml exists with shared_ontology section and Seldon recognizes the project
- [ ] All 10 chapter placeholders exist in book/
- [ ] bibliography.md exists with ai4stats and crosswalk paper entries
- [ ] CLAUDE.md includes hotwash lessons AND shared ontology reference
- [ ] .gitignore in place
- [ ] Shared validity ontology accessible from project context (per AD-017)
- [ ] Chapter 9 placeholder references canonical vocabulary, not local definitions
- [ ] Initial commit pushed to main
- [ ] Handoff document written
- [ ] All artifacts registered with Seldon
