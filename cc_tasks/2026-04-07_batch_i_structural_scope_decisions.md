# CC Task: Batch I -- Structural Scope Decisions

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Reference:** Sweep synthesis items 5, 6, 7, 13, 16, 17, 20; `docs/2026-04-06_sweep_synthesis_run004.md`
**Batch:** I (structural improvements requiring author scope decisions)
**Supersedes:** Earlier versions of this file from same date (I-4 revised twice, I-5 revised once per author feedback)

---

## Context

Seven items from the sweep synthesis required author judgment on scope before writing. All author decisions made in session.

---

## Fix I-1 -- Ch 8: Evaluation Calibration Scope Note

**File:** `book/chapter-08.md`
**Section:** After `## Continuous Evaluation, Not Snapshot Testing`, after the existing reflection prompt (the "94% drops to 88%" block quote).
**Action:** Add a paragraph (4-6 sentences) as a scope note.

**Author decision:** Option B -- scope note, not a new section. The science of "how much evaluation is enough" for stochastic LLM pipelines does not exist yet as a solved problem.

**Content direction:** The scope note should make these points:

1. Traditional statistical process control assumes stationary processes. LLM pipelines are not stationary: the instrument changes through provider updates, context drift, and model deprecation. Classical SPC thresholds do not transfer directly.
2. The golden test set (described above) is the practical mechanism: it gives you directionality. You know when confidence is degrading. The question "at what threshold do you halt?" is a risk-managed judgment call, not a statistical formula -- it depends on the downstream consequence of error in your specific application.
3. The soup spoon principle: you do not need to evaluate every output. You need to sample intelligently enough to know the direction of drift. The golden test set is that spoonful.
4. Consider the broader context: surveys have known response error rates. Manual coding has known disagreement rates. The tools performing operations may or may not outperform human coders, but with human coders you only get a fraction of the coverage. The question is not "is this perfect?" but "at what point do you lose confidence in the direction?" That is a judgment call, not a formula.
5. Acknowledge the gap honestly: calibrating evaluation thresholds for stochastic research pipelines is an open problem. The book provides the infrastructure (golden test sets, drift detection, regression runs); the specific thresholds are context-dependent and require practitioner judgment.

Do NOT add sample size formulas, SPC control chart methodology, or statistical test specifications. The point is to name the gap, explain why it is a gap, and point to the golden test set as the available practical tool.

Insert AFTER the existing reflection prompt block quote, BEFORE `## Evaluation Economics`.

---

## Fix I-2 -- Ch 14: Governance/Authorization Cost Category

**File:** `book/chapter-14.md`
**Section:** `## The Cost Taxonomy`

**Action:** Two changes.

### I-2a: Add fifth row to cost taxonomy table

After the "Opportunity costs" row, add:

```
| **Institutional overhead** | Security authorization (ATO, FedRAMP), compliance documentation, environment provisioning, procurement cycles | Security teams, CISOs, contracting officers |
```

### I-2b: Add paragraph after the table's reflection prompt

After the italicized reflection prompt ("*Think about the last AI-related budget conversation...*"), add a paragraph (3-5 sentences) with this content direction:

Institutional overhead is the cost category federal practitioners recognize immediately but rarely see in AI cost analyses written for commercial audiences. An Authority to Operate can take 12 months or longer. FedRAMP compliance requires dedicated staff and documentation effort measured in person-months. Environment provisioning in government networks often means working with infrastructure that lags commercial equivalents by years. These are direct costs -- staff time, consultant fees, calendar time -- not opportunity costs. For federal teams, institutional overhead often exceeds all other cost categories combined, not because the security work is unnecessary, but because the processes were not designed for the pace at which AI tooling evolves. Security that functions as a mission enabler rather than a gate looks different from security that optimizes for compliance paperwork.

Also update the sentence at approximately line 51 that reads:

```
*Think about the last AI-related budget conversation in your organization. Which of these four cost categories dominated the discussion? Which ones were never mentioned?*
```

Change "four" to "five".

Also check approximately line 79 where "four-category cost taxonomy" appears and update to "five-category cost taxonomy."

---

## Fix I-3 -- Ch 13: Pilot Specification Reframe

**File:** `book/chapter-13.md`
**Section:** `## Earning Trust Incrementally`, after the paragraph ending "Build a track record that earns institutional trust through demonstrated competence, not through arguments about potential."

**Action:** Add a paragraph (4-6 sentences) with this content direction:

"Small" is relative. The pilot does not need a fixed sample size or a prescribed timeline. It needs three properties: it must solve a real pain point that people currently waste time on; it must use public or non-sensitive data so that security authorization does not become the bottleneck before you can demonstrate anything; and it must ship fast enough that the result exists before the process can kill it. The political lever is speed differential -- when one team produces in two weeks what another spent a quarter on, the contrast is visible and motivating. The biggest risk is not that the pilot fails technically. The biggest risk is that 100 hours of security reviews, acquisition gates, and approval chains consume the window of opportunity before a single record is processed. Build organizational muscle by actually using the tools, on real problems, with real documentation, outside the blast radius of the gatekeepers if necessary. The pilot specification is not a checklist. It is a demonstration that earns the right to ask for more.

**Tone note:** The author's voice in Ch 13 is already more direct and institutional-friction-aware than the technical chapters. This paragraph should match that voice -- urgent, practitioner-grounded, slightly impatient with process theater. Do not sanitize the frustration into bland advice.

---

## Fix I-4 -- Ch 4: LLM vs. Deterministic Extraction (REVISED v2)

**File:** `book/chapter-04.md`
**Section:** `## Designing Extraction Pipelines That Earn Trust`, after the `**Chunk at semantic boundaries**` paragraph (before or after `**Dual-model extraction with disagreement analysis**`).

**Action:** Add a paragraph (6-10 sentences) as a new bold-header design principle.

**Author decision (revised twice):** The original synthesis recommended "use regex where the pattern is known." The author reversed this framing and then sharpened the argument further: regex is not actually deterministic in practice. A regex pattern is a bet against the input space. It matches what you anticipated when you wrote it and silently misses everything else. That silent miss is a worse failure mode than LLM stochasticity because LLM variance is observable and measurable -- you can monitor it, detect drift, flag disagreements. Regex gives you invisible systematic error that you believe is correct because "it's deterministic." You have traded observable stochasticity for invisible bias.

**Content direction:**

```
**Let the model handle structured formats.** The instinct to use regular expressions or rule-based parsers for structured fields -- NAICS codes, dates, phone numbers, addresses -- comes from an era before LLMs could handle these tasks trivially. Today it is usually a false economy, and the reasoning goes deeper than cost.

Regex feels deterministic. It is not. A regex pattern is a bet against the input space: it matches what you anticipated when you wrote it and silently passes over everything else. An address in a name field. A date in an unexpected locale format. A phone number with an extension notation your pattern did not account for. The pattern does not flag these misses. It does not raise an error. It silently produces incomplete results that you trust because "it's deterministic." This is a worse failure mode than LLM stochasticity. The LLM's variance is observable: you can measure agreement rates, flag low-confidence extractions, detect drift. The regex gives you invisible systematic error dressed up as reliability.

The maintenance burden compounds the problem. The author built redaction and extraction pipelines using traditional ML and regex before LLMs were available for these tasks. The result was a brittle mountain of increasingly complex pattern-matching: overfitting to edge cases, breaking on unexpected input formats, requiring specialized knowledge to debug, and consuming more engineering time in maintenance than it ever saved in inference costs. LLMs solved the same problems with a fraction of the effort. Current models already recognize structured formats as part of their training. The cost per extraction is negligible at current pricing. The default recommendation for practitioners: use the LLM. Reserve your engineering effort for the design problems that actually need it -- evaluation infrastructure, confidence routing, provenance tracking -- not for reimplementing pattern matching that the model handles as a side effect of its general capability.
```

---

## Fix I-5 -- Ch 1: Additional Reflection Prompts (REVISED)

**File:** `book/chapter-01.md`
**Action:** Add THREE reflection prompts at natural pause points. The author wants "have you experienced this / what did you learn" style pauses throughout Ch 1, not just the existing bullet list at line 110.

### I-5a: After The Iterative Refinement Trap

Insert after the paragraph ending "Design accordingly." (the end of the recursive self-consumption discussion, before the five degradation pathways summary paragraph).

**Content direction:**

> *Have you built a refinement loop that seemed to improve output at first, then plateaued or got worse? What signal finally told you the iterations were no longer helping? If you have not experienced this yet, consider: how would you know?*

### I-5b: After The Evaluation Trap

Insert after the paragraph ending "...build evaluation infrastructure that tests *your* pipeline on *your* data after every change."

**Content direction:**

> *Think about the last time your team compared AI tools or models. How long did the evaluation take? Were the results still valid by the time the report was finished? What would have happened if you had spent that time building evaluation infrastructure for your specific pipeline instead?*

### I-5c: After Removing Yourself from the Loop (Carefully)

Insert after the paragraph ending "Level 3 is earned, not assumed. You get there by doing the prework."

**Content direction:**

> *Where in your current workflow are you the bottleneck -- reviewing every output because you do not trust the system to flag its own problems? What would it take to build enough infrastructure that you could step back from that loop and focus on the cases that actually need your judgment?*

---

## Fix I-6 -- Ch 3: Working Principle Connection

**File:** `book/chapter-03.md`
**Section:** In the schema combination / harmonization frameworks discussion. Find the section where existing harmonization frameworks (DataSHaPER, DDI, GSIM, or similar) are discussed as reusable infrastructure.

**Action:** Add 1-2 sentences connecting to the working principle.

**Content direction:** "This is the working principle 'Reuse data before collecting more' applied to schema design: established harmonization frameworks and controlled vocabularies are reusable infrastructure. Building a new taxonomy when a usable one already exists is waste."

---

## Fix I-7 -- Ch 2: Fine-Tuning Cross-Reference

**File:** `book/chapter-02.md`
**Section:** `## Model Transience as a Design Constraint`, in or near the **Model-agnostic pipeline design** paragraph.

**Action:** Add one sentence.

**Content direction:** "Chapter 3 examines the fine-tuning versus API tradeoff for classification tasks directly, including the cost and maintenance implications that affect which side of this design constraint you land on."

---

## Verification

After execution:
1. Ch 8: New paragraph exists between the "94% to 88%" reflection prompt and `## Evaluation Economics`
2. Ch 14: Cost taxonomy table has 5 rows, not 4. "four" replaced with "five" in reflection prompt and any later references to "four-category"
3. Ch 13: New paragraph exists in "Earning Trust Incrementally" after the "demonstrated competence" paragraph
4. Ch 4: New bold-header paragraph exists in extraction pipeline design section with LLM-first framing (NOT regex-first). Must include the "regex is not actually deterministic" argument
5. Ch 1: Three new reflection prompts (after Iterative Refinement Trap, after Evaluation Trap, after Removing Yourself from the Loop)
6. Ch 3: Working principle sentence added in harmonization framework discussion
7. Ch 2: Cross-reference sentence added in model transience section
8. No other changes to any file
9. `seldon verify` passes

---

## Files Modified

| File | Change |
|------|--------|
| `book/chapter-08.md` | Evaluation calibration scope note (4-6 sentences) |
| `book/chapter-14.md` | Fifth cost category row + institutional overhead paragraph + "four"→"five" updates |
| `book/chapter-13.md` | Pilot specification reframe paragraph (4-6 sentences) |
| `book/chapter-04.md` | LLM vs. deterministic extraction paragraph (6-10 sentences, LLM-first framing, regex-as-false-determinism argument) |
| `book/chapter-01.md` | Three reflection prompts at natural pause points |
| `book/chapter-03.md` | 1-2 sentences connecting to working principle |
| `book/chapter-02.md` | One cross-reference sentence |
