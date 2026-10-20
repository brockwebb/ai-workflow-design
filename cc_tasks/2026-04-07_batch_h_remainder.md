# CC Task: Batch H Remainder -- Structural Short Additions

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` items 8, 9, 10, 14, 15
**Scope:** Five bounded content additions across four chapters. No research required. All additions are author-voice practitioner guidance that operationalizes concepts already present in the chapter text.

---

## Prerequisites

- Read this entire task file before making any edits
- No external research needed -- all content derives from concepts already in the chapters

## Style Rules

- No em-dashes anywhere
- Currency values escaped as `\$` (MyST requirement)
- No throat-clearing or academic filler
- Practitioner voice: direct, specific, actionable
- Citations use `{cite:t}` (narrative) or `{cite:p}` (parenthetical) roles only

## Post-Edit Verification

After ALL edits, run:
```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design
grep -n '—' book/chapter-05.md book/chapter-06.md book/chapter-09.md book/chapter-10.md  # zero results expected
grep -n '[^\\]\$[0-9]' book/chapter-05.md book/chapter-06.md book/chapter-09.md book/chapter-10.md  # zero results expected (all $ before numbers should be \$)
myst build --html 2>&1 | grep -i error  # no build errors
```

---

## Edit 1: Ch 5 -- Provenance Minimum Field Specification

**File:** `book/chapter-05.md`
**Location:** In the "Cross-Cutting Design Principles" section, AFTER the "Version everything." paragraph and BEFORE the "Store the disagreements" paragraph.
**Action:** Add a new bold-lead paragraph.

**Content to add (one paragraph):**

```
**Define a minimum provenance record.** Every pipeline output record should carry at minimum: a unique input record identifier, the model identifier and version used, the prompt template version, a timestamp, the raw output, the final classified/extracted value, a confidence or agreement flag, and the decision rule that produced the final value (majority vote, confidence-weighted, human override). For multi-model topologies, add each model's individual output and the arbitration path taken. This is the minimum set that allows you to answer "why did this record get this result?" six months later. Chapter 10 provides the infrastructure for storing and querying these records at scale; this section defines what to capture.
```

**Rationale:** Ch 5's working principle is "Outputs require full provenance" but the chapter never specifies what fields constitute provenance. This operationalizes the principle.

---

## Edit 2: Ch 5 -- Arbitration Strategy Selection Heuristic

**File:** `book/chapter-05.md`
**Location:** In the "Choosing Your Topology" section, AFTER the paragraph that begins "In practice, pipelines combine topologies..." and BEFORE the "## Cross-Cutting Design Principles" heading.
**Action:** Add a new paragraph.

**Content to add (one paragraph):**

```
**When models disagree, the arbitration strategy matters as much as the topology.** Three common approaches, each with different cost and quality profiles: Use confidence-weighted arbitration when both models produce calibrated confidence scores and the task has a clear correct answer (classification into a fixed taxonomy). Use a third-model tiebreaker when the disagreement is semantic rather than probabilistic, when the question is "which interpretation is right" rather than "which model is more confident." Use human review when the disagreement rate is low enough to be tractable (under 5-10% of records), when the stakes of a wrong answer are high, or when the disagreements themselves are the research finding you need to examine. The Concept Mapper used human review for its ~3% disagreement cases because the disagreements revealed genuine taxonomic ambiguity that no automated rule could resolve {cite:p}`webb_2026_concept_mapper`. The arbitration strategy is a design decision that belongs in your pipeline configuration alongside the topology choice, not an afterthought.
```

**Rationale:** Ch 5 presents three topologies and discusses when each fits, but when models disagree within a topology, the chapter does not guide the reader on choosing an arbitration method.

---

## Edit 3: Ch 6 -- Variable-Length Input Design Paragraph

**File:** `book/chapter-06.md`
**Location:** In the "Batch Design and Parallel Architecture" section, AFTER the runtime estimation paragraph (the one ending "...determines whether you can afford the architecture.") and BEFORE the figure directive `{figure} images/fig-06-01...`.
**Action:** Add a new paragraph.

**Content to add (3-5 sentences):**

```
The runtime formula above assumes roughly uniform processing time per record. Real inputs vary: a one-sentence survey question and a three-paragraph open-ended response do not take the same number of tokens to process, and token count drives both latency and cost. Two practical adjustments: first, sort inputs by estimated token count and assign similar-length records to the same batch, so workers finish at roughly the same time instead of one worker stalling on a batch of long records while others sit idle. Second, use a conservative effective_calls estimate based on your longest records, not your average. Over-estimating runtime is a scheduling inconvenience; under-estimating it means your "overnight" job is still running at 9 AM.
```

**Rationale:** The runtime estimation formula assumes uniform processing time. This is a genuine gap: variable-length inputs are common in survey data and the formula misleads without this caveat.

---

## Edit 4: Ch 9 -- Symptom-to-Threat Diagnostic Table

**File:** `book/chapter-09.md`
**Location:** In the "Where Prior Chapters Were Already Fighting SFV Threats" section, AFTER the paragraph that begins "The table shows what is covered. Two gaps remain..." and BEFORE the paragraph beginning "State externalization is the common principle..."
**Action:** Add a compact diagnostic table with a lead-in sentence.

**Content to add:**

```
The second gap, symptom-to-threat mapping, can be partially addressed with a diagnostic starting point. When pipeline behavior changes unexpectedly, these observable symptoms suggest which threats to investigate first:

:::{table} Symptom-to-threat diagnostic guide. Observable pipeline symptoms mapped to the SFV threats most likely responsible and initial investigation steps.
:name: tbl-09-01

| Observable Symptom | Most Likely Threat(s) | First Investigation Step |
|:--|:--|:--|
| Output vocabulary shifts (new terms, changed phrasing patterns) | T1 (Semantic Drift) | Compare golden test set results before and after the change window |
| Pipeline produces confident but factually wrong outputs | T2 (False State Injection) | Check whether the model is citing information not present in its input or configuration |
| Nuance or qualifications disappearing from outputs | T3 (Compression Distortion) | Compare full expert judgment text against what the pipeline actually delivered to the model |
| Known-fixed issue reappears | T4 (State Supersession Failure) | Verify config file versions; check whether a session reset loaded stale defaults |
| Results differ between identical reruns | T5 (State Discontinuity) | Check temperature settings, API version pinning, and whether context window carried state from a prior run |
| "Other" or default category volume increases | T1 or T4 | Run golden test set; compare model version against last validated version |
| Disagreement rate between models changes sharply | T1, T2, or T4 | Isolate which model changed behavior; check provider release notes |
:::

This table is a starting point, not a decision tree. Multiple threats can produce similar symptoms, and real failures often involve compound causes. The value is in narrowing the investigation: instead of checking everything, start with the most probable threat and follow the evidence.
```

**Rationale:** Ch 9 explicitly acknowledges the diagnostic gap ("no chapter provides a symptom-to-threat mapping for diagnosis"). This fills it with a compact, actionable table. The text already sets up the insertion perfectly.

---

## Edit 5: Ch 10 -- "Where to Start" Section

**File:** `book/chapter-10.md`
**Location:** AFTER the "## The Authority Model: Humans at Decision Points" section content (the paragraph ending "...without creating a bottleneck that slows delivery.") and BEFORE the "### Thought Experiment" heading.
**Action:** Add a new H2 section.

**Content to add (half-page):**

```
## Where to Start

The infrastructure described in this chapter can seem daunting. Graph databases, dual-layer architectures, shared ontologies, authority models. If you are starting from nothing, do not build all of it at once. Start with the minimum viable provenance setup and add layers as the pain points emerge.

**Start with a JSONL event log.** One append-only file. Every pipeline run appends a JSON object with: run ID, timestamp, model identifier and version, prompt template version, input file hash, record count, configuration snapshot (or hash of the config file), and outcome summary (records processed, error count, disagreement rate). This file lives in version control alongside your code. It is append-only: you never edit prior entries, only add new ones. This single file, maintained consistently, answers most of the "what happened and when" questions that arise in the first six months of a pipeline's life.

**Add per-record provenance when volume justifies it.** Once your pipeline processes enough records that you need to answer "why did this specific record get this specific result," extend the event log to per-record granularity. The minimum fields from Chapter 5 apply: input record ID, model output, final value, decision rule, agreement flag. Store this as structured output (JSONL or a relational table) alongside the run-level log. At this stage you have two layers: run-level events and record-level provenance, both append-only, both in version control or a simple database.

**Add a graph when you need traversal.** The signal that you need a graph model is when your questions become relational: "what downstream artifacts are affected if I change this prompt template?" or "which results were produced by the configuration that was in effect before the March update?" If you are doing multi-table JOINs to answer these questions, or worse, grepping through log files manually, the query pattern has outgrown the storage model. Move the relationship-rich state into a graph; keep the event logs as the immutable source of truth that feeds it.

The migration path is additive, not replacement. The JSONL log does not go away when you add a database. The database does not go away when you add a graph. Each layer serves a different query pattern. Most research pipelines in their first year need only the first layer. Know what the next layer looks like so you recognize the pain point when it arrives.
```

**Rationale:** DG-6 decision: Ch 10 currently motivates provenance but does not equip the reader to begin. This half-page addition converts orientation into an actionable starting point, using the JSONL-to-graph migration path already described in the chapter's worked example.

---

## Summary

| Edit | File | Type | Size |
|------|------|------|------|
| 1 | chapter-05.md | Paragraph insert | ~5 sentences |
| 2 | chapter-05.md | Paragraph insert | ~6 sentences |
| 3 | chapter-06.md | Paragraph insert | ~4 sentences |
| 4 | chapter-09.md | Table + framing | ~15 lines |
| 5 | chapter-10.md | New H2 section | ~4 paragraphs |

## Verification Checklist

After all edits:
- [ ] No em-dashes in any modified file
- [ ] All `$` before numbers are escaped as `\$`
- [ ] All citations use `{cite:t}` or `{cite:p}` roles (no bare prose citations)
- [ ] No new bib entries needed (all citations reference existing entries)
- [ ] Ch 9 table renders correctly in MyST (`:::{table}` directive syntax)
- [ ] Ch 10 new section heading is `##` level (same as other main sections)
- [ ] Ch 5 Edit 1 is between "Version everything" and "Store the disagreements"
- [ ] Ch 5 Edit 2 is between the topology composition paragraph and "## Cross-Cutting Design Principles"
- [ ] Ch 6 Edit 3 is between runtime formula paragraph and figure directive
- [ ] Ch 9 Edit 4 is between the "Two gaps remain" paragraph and the "State externalization" paragraph
- [ ] Ch 10 Edit 5 is between "Authority Model" content and "Thought Experiment"
- [ ] `myst build --html` completes without errors
