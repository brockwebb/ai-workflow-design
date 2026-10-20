# CC Task: Sweep Synthesis — run-004 Analysis and Staged Work Plan

**Date:** 2026-04-06
**Project:** ai-workflow-design (`/Users/brock/Documents/GitHub/ai-workflow-design`)
**Reference:** AD-020 calibration analysis (handoff `2026-04-05_late_evening_tevv_loop_closure.md`), run-004 sweep
**Depends on:** `2026-04-06_full_discovery_audit_sweep.md` (run-004 complete)

---

## Objective

Read all run-004 audit data and produce a **staged work plan** that groups findings by intervention type, identifies connected cross-chapter issues, and prioritizes work by impact. This is the deliverable that makes the audit actionable.

## Inputs

- All YAML files in `audits/run-004_2026-04-06/`
- `audits/run-004_2026-04-06/run_manifest.yaml`
- Prior calibration analysis findings (from handoff notes — see Context section below)

## Context: Prior Calibration Findings

The 8-run calibration analysis (run-001 through run-003) identified these book-level patterns. The run-004 synthesis should confirm, refine, or overturn these with the complete dataset:

1. Zero visual elements is universal (7/7 book chapters in prior runs)
2. Practitioner stress test is highest-signal gate at any stage
3. Cross-chapter cascade checks justify their token cost
4. Citation density predicts audit character (low → "cite more", high → "cite better")
5. Ch 9 was weakest chapter (0/10 practitioner, truncated SFV definition, 100% self-citation)

## Output: Staged Work Plan

Write to `docs/2026-04-06_sweep_synthesis_run004.md`.

The document has four sections:

### Section 1: Book-Level Patterns

Aggregate statistics across all 17 sections:
- Verdict distribution (how many `ready`, `conditionally_ready`, `revise_before_use`, etc.)
- Practitioner stress test score distribution
- Bloom ceiling/floor distribution
- Citation gap counts and external citation rates
- Visual element counts
- Word count distribution
- Any universal patterns (issues appearing in >50% of chapters)

Confirm or update the prior calibration findings with the full dataset.

### Section 2: Findings by Intervention Type

Group ALL findings from ALL chapters into these categories. Within each category, list the specific findings with chapter references.

**A. Mechanical fixes** (can be CC'd without author judgment)
- Citation gaps where the claim is verifiable and the source is findable
- Terminology inconsistencies against the ontology
- Factual errors with clear corrections (wrong numbers, wrong attributions)
- Formatting inconsistencies

**B. Citation research** (needs Perplexity/search but not author judgment)
- Citation gaps where the claim needs verification and source discovery
- Aggregate all perplexity_queries.md files into a prioritized research queue
- Group queries by topic to avoid redundant searches

**C. Structural improvements** (needs author judgment)
- Thin sections flagged as `outline-grade` or `missing_content`
- Judgments stated as facts needing reframing
- Conjectures in empirical sections
- Missing examples, case studies, worked demonstrations
- Practitioner stress test questions that are unanswerable from the text

**D. Cross-chapter coherence** (must be addressed as connected sets)
- Bridge promises not fulfilled (chapter N promises X, chapter M doesn't deliver)
- Forward reference failures
- Terminology used differently across chapters
- Framing inconsistencies (e.g., the $15/$100 scope issue across Ch 2/5/8/14)
- Number inconsistencies across chapters
- Intro chapter summaries that don't match actual chapter content

**E. Book-level production** (one fix applied everywhere)
- Zero visual elements (if confirmed universal)
- Consistent formatting issues
- Bibliography gaps affecting multiple chapters

**F. Decision gates** (blocked on other decisions)
- Items that require architectural or scope decisions before work can proceed
- Reference existing open tasks in the graph where applicable

### Section 3: Priority Matrix

For each finding in Section 2, assign:
- **Impact:** How much does fixing this improve the book? (high/medium/low)
- **Effort:** How much work to fix? (quick-fix / half-day / multi-day)
- **Dependencies:** Does this block or require other fixes first?

Produce a priority-ordered work queue. The ordering principle:
1. High-impact quick-fixes first (maximum improvement per hour)
2. Cross-chapter coherence issues next (these get worse if chapters are edited independently)
3. Structural improvements (author time, can be batched by chapter)
4. Book-level production (one-time effort, apply everywhere)
5. Decision gates last (blocked, park them)

### Section 4: Recommended Execution Batches

Group the priority queue into discrete work batches, where each batch:
- Can be completed in one CC session or one author session
- Has clear inputs and outputs
- Doesn't create conflicts with other batches running in parallel
- Lists which chapters are touched (to avoid merge conflicts)

Example batch structure:
```
Batch 1: Mechanical fixes across all chapters (CC task)
Batch 2: Citation research — top 20 Perplexity queries (CC task)
Batch 3: Cross-chapter $15/$100 framing alignment (author + CC)
Batch 4: Ch 9 structural revision (author, highest-priority structural)
Batch 5: Bridge promise fulfillment (author, cross-chapter)
...
```

## Do NOT

- Edit any chapter files — this is analysis only
- Create ResearchTask or Issue artifacts (author reviews the plan first, then creates tasks for approved items)
- Repeat the raw findings from individual YAML files — synthesize and group them
- Produce a chapter-by-chapter walkthrough (that's just restating the review_synthesis files). The value is the cross-chapter grouping.
- Ignore the calibration context — this analysis builds on prior findings, not from scratch

## Verification

- [ ] `docs/2026-04-06_sweep_synthesis_run004.md` exists
- [ ] All four sections present
- [ ] Section 2 references specific chapter + finding IDs from audit YAML
- [ ] Section 3 has explicit priority ordering
- [ ] Section 4 has discrete, executable batches
- [ ] No chapter was omitted from the analysis
