# CC Task: Ch 6 Knowledge Graph Design Choice Seed

**Date:** 2026-04-05
**Chapter:** `book/chapter-06.md`
**Task type:** Targeted insertion
**Blocks:** Ch 10 AD-020 audit (calibration run 008)
**Related Seldon task:** c7fb788a
**Design note:** `docs/design_note_knowledge_graphs_as_pipeline_state.md`

---

## Objective

Insert 1-2 paragraphs into Chapter 6 introducing graph vs relational as a design choice for pipeline state. This seeds the thread that continues in Ch 9 (SFV countermeasures) and culminates in Ch 10 (full implementation treatment).

## Insertion Point

Insert a new subsection **after** the "Versioned configurations" paragraph and **before** "Model turnover is the steady state" within the "Design for Change, Not for the Current Model" section.

The new content sits between these two existing passages:

**AFTER this paragraph:**
> **Versioned configurations.** Every pipeline run records which model, which version, which parameters were used. This is provenance (connects to Chapter 10) and it is also practical: when results change between runs, you need to know whether you changed something or the provider did.

**BEFORE this paragraph:**
> **Model turnover is the steady state.** Models deprecate. APIs change. New options appear. Pricing shifts. If your pipeline breaks when the model changes, you designed for a moment, not for a system. Design for model turnover as a normal operating condition, not as an exception.

## Content to Insert

Add a new bold-lead paragraph following the existing pattern of that section:

```markdown
**State has shape; match your storage to it.** Versioned configurations, run logs, and parameter snapshots are tabular. A relational database or structured config files handle them well. But pipeline state that involves typed relationships between entities — artifacts that depend on other artifacts, decisions that supersede prior decisions, evidence chains that connect claims to their sources — is graph-shaped. Forcing graph-shaped state into foreign keys and JOIN tables loses the relationship structure that makes provenance auditable and impact analysis tractable. The design choice is not "relational or graph." It is "what shape is this state?" Tabular state stays tabular. Relationship-rich state gets a relationship-aware data model. Chapter 10 provides the implementation guidance; the point here is that the choice is driven by state shape, not by technology preference.
```

## What This Is NOT

- Not a graph database tutorial
- Not a product recommendation (no Neo4j, no specific tools)
- Not longer than one paragraph
- Not a digression from Ch 6's throughput/engineering focus

## Constraints

- Maintain the bold-lead pattern used throughout the section
- Must read as natural continuation of the versioned configurations point (configs are one form of state; this generalizes to "what data model for all pipeline state")
- Forward reference to Ch 10 only (not Ch 9 — the SFV connection is Ch 9's job to make)
- No citations needed in this paragraph (foundational claim, not an empirical assertion)

## Verification After Execution

1. Confirm the paragraph appears between "Versioned configurations" and "Model turnover is the steady state"
2. Confirm no other content in Ch 6 was modified
3. Run `seldon verify --fix`
4. Run `seldon cc complete cc_tasks/2026-04-05_ch06_knowledge_graph_seed.md`
