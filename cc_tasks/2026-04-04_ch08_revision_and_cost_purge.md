# CC Task: Chapter 8 Revision + "$15 vs $1,500" Purge from Ch 14 + Cost Scope Clarifications

**Date:** 2026-04-04
**Project:** ai-workflow-design
**Reference:** AD-020 calibration run 006 (Ch 8), Perplexity verification results, crosswalk paper Table 6.1
**Target files:** `book/chapter-08.md` (primary), `book/chapter-14.md` (cost purge), `book/chapter-05.md` (scope fix), `book/intro.md` (scope fix)

---

## Context

AD-020 calibration run 006 (Ch 8) produced 8 clusters + unclustered findings. Perplexity verification resolved all open claims. This CC task addresses the actionable findings.

**Source documents verified:**
- Crosswalk paper Table 6.1: Concept Mapper classification pipeline = `<$100 API`; Pragmatics 3-stage evaluation = `~$15 API`
- Pragmatics paper Section 5.6: full 39-query evaluation runtime cost = $4.42
- Ch 14: Concept Mapper per-run inference cost = $15; development cost = ~$3,500

**Cost figure reconciliation (author-confirmed):**
- $15 in Ch 5, Ch 14, intro = Concept Mapper **per-run inference cost** (one model pass on ~7,000 questions)
- <$100 in crosswalk paper = Concept Mapper **total API cost** across all models, arbitration, evaluation
- ~$15 in crosswalk paper Table 6.1 for Pragmatics = **evaluation pipeline** (judges × queries × orderings)
- $4.42 in Pragmatics paper = **runtime cost** of 39 production queries only
- All numbers are correct but describe different scopes. The problem is inconsistent scope labeling.

---

## Fixes

### Fix 1: Question count — Ch 8 (HIGH)

**Line 105:** Change `7,000 questions` → `6,954 questions`

Canonical count is 6,954 analyzable questions from ~7,000 raw. All other chapters (Ch 2, 6, 14) already use 6,954. This was flagged in calibration runs 004 and 005.

### Fix 2: Cost scope clarification — Ch 8 Evaluation Economics (HIGH)

The current text has two cost claims:
1. "The Concept Mapper evaluation cost under $100 in API fees for the full classification pipeline: 7,000 questions, three models, structured arbitration"
2. "The Pragmatics evaluation from the crosswalk paper cost approximately $15 in API fees for a three-stage evaluation pipeline"

Both attributions are correct per the crosswalk paper Table 6.1. However, a reader who saw "$15" for the Concept Mapper in Ch 5 or Ch 14 will be confused by "$100" here.

**Action:** After the $100 sentence, add a clarifying sentence:
"The per-run inference cost for classification alone was approximately $15; the full pipeline total reflects three models, structured arbitration, and evaluation across the complete question set."

This connects Ch 8's $100 to Ch 5/14's $15 without contradicting either.

### Fix 3: "$15 vs $1,500" PURGE — Ch 14 (HIGH — author-requested, multiple prior attempts)

**The "$15 vs $1,500" framing must be completely removed from Chapter 14.** The author has explicitly and repeatedly requested this removal. It has survived multiple prior revision cycles.

**Lines to modify:**

**Line 87:** Remove the entire bold header and rewrite the section without the $1,500 comparison:
```
Current: **The $15 vs. $1,500 pipeline.** Same task, same data, same accuracy requirement. The difference is design, not capability.
```
Replace with a framing that makes the design discipline point without inventing a hypothetical $1,500 figure. The point is: design choices (right-sized model, batching, caching, prompt optimization) dramatically reduce cost. Make that point with the real numbers from the cost table above it, not a fabricated comparison.

**Lines 89-92:** The "$1,500 version" paragraph and the "$15 version" paragraph (line 91). Rewrite as a general design principles discussion — what makes a pipeline expensive vs cheap — without anchoring to specific dollar figures.

**Line 163:** Remove the "$15 pipeline from the $1,500 pipeline" phrasing from the closing paragraph. Replace with language about designed vs undesigned pipelines. The closing should reference the design discipline argument, not specific dollar amounts.

**CRITICAL:** Search the ENTIRE file for any remaining `$1,500` or `$1500` or `$15 vs` references after editing. Leave zero instances.

### Fix 4: Cost scope label — Ch 5 (MEDIUM)

**Line 156:** Change:
```
The $15 API cost for the Concept Mapper was real
```
To:
```
The $15 per-run inference cost for the Concept Mapper was real
```

Adding "per-run inference" makes the scope explicit and prevents confusion with the crosswalk paper's $100 total pipeline cost.

### Fix 5: Tailored crosswalk section — scaffold to Apply (MEDIUM)

**Section: "The Tailored Crosswalk as Evaluation Design Tool"**

Bloom audit found this section stays at Understand — the reader sees worked examples but isn't scaffolded to create their own crosswalk. Add a practitioner exercise after the two tailored crosswalk examples. Something like:

> *For your own pipeline, take one design choice and map it: what FCSM quality dimension does it address? What NIST trustworthiness characteristic does it satisfy? If a design choice maps to neither, it is either unnecessary or you have not identified the concern yet. Start with your most consequential design choice — the one that, if wrong, would most undermine trust in the output.*

This pushes from Understand to Apply/Analyze with minimal text addition.

### Fix 6: Reconnect to Remote Labor Index hook (LOW)

**Section: "Evaluation Economics"**

The opening hook (Remote Labor Index, 2.5% client-acceptable) is strong but never revisited. Add one sentence reconnecting to it, something like:

"The same agents that scored near-expert on benchmarks achieved 2.5% on real freelance work. Your evaluation infrastructure is what ensures your pipeline is not the statistical production equivalent of that gap."

### Fix 7: NIST "valid and reliable" wording precision (LOW)

**Section: "Valid and Reliable Is a Gate, Not a Dial"**

Perplexity confirmed this is an accurate interpretive characterization but not a direct NIST quote. The current text says "NIST's own architecture shows valid and reliable as the foundation on which all other trustworthiness characteristics rest."

**Action:** Soften slightly: "NIST's framework positions valid and reliable as foundational — the characteristic on which all other trustworthiness assessments depend." This is defensible as interpretation without implying it's NIST's exact words.

### Fix 8: SWE-CI "18 models" — add to bib note (LOW)

Perplexity confirmed 18 models from 8 providers. Ch 8 says "18 AI coding models" which Ch 7 does not include. No change to chapter text needed — both are accurate (Ch 7 is less specific, Ch 8 adds detail). Consider adding "18 models from 8 providers" to the `references.bib` note for `chen_2026_sweci` for consistency.

### Fix 9: FCSM 20-04 BibTeX entry (LOW)

FCSM 20-04 is named in body text but not formally cited. Consider adding a BibTeX entry:
```bibtex
@techreport{fcsm_2020_data_quality,
  title = {A Framework for Data Quality},
  author = {{Federal Committee on Statistical Methodology}},
  institution = {Federal Committee on Statistical Methodology},
  year = {2020},
  number = {FCSM-20-04},
  url = {https://nces.ed.gov/FCSM/pdf/FCSM.20.04_A_Framework_for_Data_Quality.pdf}
}
```
Then replace inline "FCSM 20-04" references with `{cite:p}` or `{cite:t}` roles.

---

## Do NOT

- Modify any cost figures — they are all correct for their respective scopes
- Re-introduce "$15 vs $1,500" anywhere — this is a permanent removal
- Change the crosswalk paper's mapping type counts (4/1/2/3/4) — verified correct
- Change the `mazeika_2025` claims (240 projects, 2.5%) — verified correct
- Change the `chen_2026_sweci` claims — verified in run 005, consistent across Ch 7/8
- Modify figure directives or figure specs — those are handled by the batch figure CC task
- Add figures to Ch 8 — that's a separate task after figures are rendered

## After execution

- Run `seldon verify --fix`
- Verify no remaining `$1,500` anywhere in `book/` directory: `grep -rn '\$1,500\|\$1500' book/`
- Verify `7,000` is gone from Ch 8: `grep -n '7,000' book/chapter-08.md`
