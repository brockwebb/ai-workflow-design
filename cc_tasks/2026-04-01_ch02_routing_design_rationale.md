# CC Task Addendum: Chapter 2 — Routing Design Rationale and Engineering Judgment Prose

**Date:** 2026-04-01
**Session:** 16
**Status:** PENDING
**Amends:** 2026-04-01_audit_ch02_prose_fixes.md (adds design rationale prose not covered in that task)

---

## Context

The three-path routing description in §Dual-Model Cross-Validation needs two improvements:

1. It does not explain the *design rationale* for the dual-modal path — why preserving both topic assignments was a deliberate engineering judgment to broaden downstream matching rather than force premature resolution.
2. It does not make clear that the first two paths are deterministic logic gates (no model involved), while only the third path invokes an arbitrator model.
3. The chapter needs a broader discussion of context-dependent engineering judgment — the dual-modal decision is an example of the kind of design thinking the book teaches.

---

## Fix 1: Rewrite the three-path routing descriptions

**File:** `book/chapter-02.md`

**Find the block starting with:**
```
The agreement analysis routes outputs through three paths:

**Consensus (68.5% of classifications).** Both models agree on topic and subtopic. High confidence, auto-accept. When two independently trained systems with different architectures and different training data arrive at the same answer independently, you have a meaningful signal. Not proof, but signal.

**Dual-modal assignment (11.8%).** Both models are highly confident (≥0.90) but assign different primary topics. In these cases, the question genuinely spans two domains. The higher-confidence model's topic is assigned as primary, the lower-confidence model's topic as secondary. Disagreement here is not error; it is the system surfacing genuine taxonomic ambiguity that a single model would have silently resolved.

**Arbitration (19.7%).** Models disagree and at least one has low confidence. These cases escalate to a more capable model with access to both prior judgments, for structured resolution.
```

**Replace with:**
```
The agreement analysis routes outputs through three paths. The first two are deterministic logic gates — no additional model is involved. Only the third path invokes an arbitrator.

**Consensus (68.5% of classifications).** Both models agree on topic and subtopic. Auto-accept. When two independently trained systems with different architectures and different training data arrive at the same answer independently, you have a meaningful signal. Not proof, but signal. No further processing needed. This is a logic gate: agreement triggers acceptance.

**Dual-modal assignment (11.8%).** Both models are highly confident (≥0.90) but assign different primary topics. Rather than forcing a resolution, the pipeline accepts both: the higher-confidence model's topic as primary, the lower-confidence model's topic as secondary. No arbitrator is invoked. This is a logic gate, not a model decision.

This was a deliberate engineering choice, not an oversight. With 152 subtopics distributed across five broad topics, genuine taxonomic ambiguity is common. A question about health insurance costs could reasonably classify under Economic or Social topics. If the models are both confident but pointing in different directions, forcing a single answer discards a signal. Preserving both assignments broadens downstream matching — it is a form of fuzzy matching through the classification layer that accepts ambiguity rather than prematurely collapsing it.

The trade-off: dual-modal assignments generate more downstream calculations, since questions with two topic assignments get compared against both topic pools. At 11.8%, that cost was manageable. If the dual-modal rate had been substantially higher — say 30% or more — that would have signaled a prompt design problem or a taxonomy mismatch worth investigating before proceeding. The low rate confirmed that the taxonomy was working and that true ambiguity, not systematic confusion, was driving the disagreements.

The dual-modal assignments were spot-checked manually. The ones reviewed were defensible — reasonable arguments could be made for either topic assignment. This is a quality control trade-off: the spot check was not a statistically designed sample with a calculated confidence interval, and the individual reviews were not logged as artifacts. For a higher-stakes application, more formal sampling and documentation would be warranted. Here, the risk of a wrong topic assignment was additional downstream calculations, not wrong answers — a cost the pipeline could absorb.

**Arbitration (19.7%).** Models disagree *and* at least one has low confidence. These are the cases where the system genuinely does not know, and a deterministic rule cannot resolve the disagreement. Only here does the pipeline escalate to a more capable arbitrator model, which reviews both prior judgments and renders a structured verdict with reasoning. This is the only path that invokes a third model.
```

---

## Fix 2: Add engineering judgment framing after the routing section

**File:** `book/chapter-02.md`

**After the paragraph ending "...not where the models are failing." (the kappa discussion paragraph), insert:**

```
Every one of these routing decisions — what threshold triggers auto-accept, whether to preserve dual-modal ambiguity or force resolution, when to invoke a more expensive arbitrator — is an engineering judgment that depends on context. The Concept Mapper is an example, not a prescription. A different taxonomy, a different downstream use, or a different risk profile would justify different choices. The point is not to copy this specific pipeline. It is to recognize that these are *design decisions* that should be made deliberately, documented as artifacts, and defensible under review. When someone asks why you accepted dual-modal assignments instead of forcing arbitration, you should have an answer grounded in your analysis of the trade-offs, not a shrug.
```

**Rationale:** This framing connects the specific case study back to the book's core teaching: design decisions are context-dependent, must be made deliberately, and must be captured. The Concept Mapper demonstrates the *process* of making these decisions, not the *answers*.

---

## Verification

- Confirm the three-path description is rewritten with logic gate / model invocation distinction
- Confirm dual-modal design rationale paragraph is present
- Confirm spot-check honesty paragraph is present (trade-off acknowledged, not hidden)
- Confirm engineering judgment framing paragraph is inserted after kappa discussion
- Run `seldon verify`
