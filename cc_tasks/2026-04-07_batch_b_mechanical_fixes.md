# CC Task: Batch B — Mechanical Fixes (run-004)

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` Section 2A + `docs/2026-04-06_author_decisions_run004.md`
**Scope:** Targeted single-file edits. No author judgment required. All fixes are citation markup additions, terminology corrections against canonical vocabulary, acronym expansions, cross-reference label corrections, or one-sentence clarifications.

---

## Prerequisites

- Read `docs/2026-04-06_author_decisions_run004.md` for DG-1 and DG-2 decisions
- Read `book/glossary.md` and any VALIDITY_VOCABULARY.md for canonical term verification

## Mandatory Post-Edit Cycle

After ALL edits are complete, run in order:
1. `python paper/check_glossary.py` (from seldon project — use `seldon verify` if available)
2. `seldon paper sync` (if applicable to this project)
3. `seldon paper build --no-render` (if applicable)

If these tools are not configured for ai-workflow-design, skip and note in completion log.

---

## Edits

### Fix 1: intro.md — "terminological stability" → "Terminological Consistency (TC)"
**File:** `book/intro.md`
**Location:** Ch 4 description in "How This Book Is Organized" section
**Find:** `compression fidelity, terminological stability, and state provenance`
**Replace with:** `compression fidelity, Terminological Consistency (TC), and state provenance`

### Fix 2: intro.md — Phase structure update (DG-1)
**File:** `book/intro.md`
**Location:** "How This Book Is Organized" section
**Action:** 
- Rename `### Validity and Infrastructure` heading to `### Validity`
- Move the Ch 11 paragraph (beginning "**Chapter 11: Workflow Orchestration and the Tool Landscape.**") from under `### Validity` to under `### Institutional Context`
- Rename `### Institutional Context` heading to `### Delivery`
- The final ordering under Delivery should be: Ch 11, Ch 12, Ch 13, Ch 14

### Fix 3: intro.md — "Where to Start" section (DG-1)
**File:** `book/intro.md`
**Location:** "Where to Start" section, first paragraph (statistician reader path)
**Find:** `The validity and infrastructure chapters (9 through 11)`
**Replace with:** `The validity chapters (9 and 10)`

### Fix 4: chapter-01.md — "four clusters" → "five phases" (DG-1)
**File:** `book/chapter-01.md`
**Location:** Find the passage where Ch 1 describes the book's organization using "four clusters" or "clusters" terminology
**Action:** Replace with "five phases" and align phase names/boundaries per the decision record:
  - Phase 1: Foundations (Ch 1)
  - Phase 2: Domain Workflows (Ch 2-4)
  - Phase 3: Cross-Cutting Patterns (Ch 5-8)
  - Phase 4: Validity (Ch 9-10)
  - Phase 5: Delivery (Ch 11-14)
**Note:** Match the voice and prose style of the surrounding text. Do not insert a table — weave the phase structure into the existing paragraph(s).

### Fix 5: chapter-01.md — MCMC and MAD acronym expansion
**File:** `book/chapter-01.md`
**Location:** First use of MCMC and MAD in chapter body
**Action:** Add parenthetical expansion on first use:
  - MCMC → "Markov Chain Monte Carlo (MCMC)"
  - MAD → expand appropriately based on context (likely "Median Absolute Deviation (MAD)")
**Note:** Check what MAD actually refers to in context before expanding.

### Fix 6: chapter-02.md — ABBA counterbalancing attribution
**File:** `book/chapter-02.md`
**Location:** "Order Effects and the ABBA Design" section, first paragraph
**Action:** Add one sentence establishing that ABBA counterbalancing is a standard technique from repeated-measures experimental design, not an author coinage. The term "ABBA counterbalancing" (also called "reverse counterbalancing") is established in the experimental psychology literature. Add after the first paragraph of the section. Example: "ABBA counterbalancing is a standard technique from repeated-measures experimental design: by reversing presentation order across conditions, order-dependent variance is exposed rather than hidden."
**Note:** The point is to signal to the reader that this is an established method with a real name, not a cute author invention. Match existing prose voice.

### Fix 7: chapter-03.md — "golden questions (Chapter 7)" → "golden test set (Chapter 8)"
**File:** `book/chapter-03.md`
**Location:** Find the phrase "golden questions" with a reference to Chapter 7
**Replace with:** reference to "golden test set" and Chapter 8

### Fix 8: chapter-03.md — CIPSEA and MICE acronym expansion
**File:** `book/chapter-03.md`
**Location:** First use of CIPSEA and MICE in chapter body
**Action:** Add parenthetical expansion on first use:
  - CIPSEA → "Confidential Information Protection and Statistical Efficiency Act (CIPSEA)"
  - MICE → "Multiple Imputation by Chained Equations (MICE)"

### Fix 9: chapter-04.md — Bradley-Terry citation
**File:** `book/chapter-04.md`
**Location:** Find the passage discussing Bradley-Terry model/comparison
**Action:** Add `{cite:p}\`bradley_terry_1952\`` at the appropriate point in the passage
**Note:** Bib entry confirmed present in references.bib

### Fix 10: chapter-04.md — "multi-model not optional" softening
**File:** `book/chapter-04.md`
**Location:** Find "is not optional for extraction tasks" or similar phrasing
**Replace with:** "is the default for extraction tasks — single-model requires explicit justification"
**Rationale:** Aligns with Ch 5 framing

### Fix 11: chapter-05.md — "throughput constraint ladder" → "The Throughput Ladder"
**File:** `book/chapter-05.md`
**Location:** Find reference to "throughput constraint ladder" referencing Chapter 6
**Replace with:** "The Throughput Ladder" (matching Ch 6's actual term)

### Fix 12: chapter-07.md — Ch 8 bridge addition
**File:** `book/chapter-07.md`
**Location:** Closing bridge paragraph (end of chapter, where Ch 9 and Ch 10 are referenced)
**Action:** Add a reference to Ch 8 alongside Ch 9 and Ch 10. The bridge should mention Ch 8 (evaluation) as the next step.
**Note:** Read the existing bridge to understand the flow before inserting.

### Fix 13: chapter-08.md — Thought experiment horizontal rule
**File:** `book/chapter-08.md`
**Location:** Before the "### Thought Experiment" heading (the final thought experiment near end of chapter)
**Action:** Add `---` separator before the heading for formatting consistency with other chapters
**Note:** Check Ch 2's thought experiment formatting as the reference pattern.

### Fix 14: chapter-08.md — Kappa clarification sentence (DG-2)
**File:** `book/chapter-08.md`
**Location:** "Multi-model agreement as evaluation" subsection, near the sentence: "The Concept Mapper's inter-rater reliability statistics (Fleiss' κ = 0.537 pre-arbitration, κ = 0.843 post-arbitration)"
**Action:** Add one clarification sentence after this passage noting that these Fleiss' κ values come from the three-rater harmonization stage (three independent rater models from three vendors), distinct from the two-model classification stage that produced Cohen's κ = 0.839 for topic-level agreement.
**Note:** Keep it to one sentence. Don't restructure the paragraph.

### Fix 15: chapter-10.md — "state machine" parenthetical
**File:** `book/chapter-10.md`
**Location:** First use of "state machine" in chapter body
**Action:** Add brief parenthetical definition for non-CS readers. Example: "state machine (a formal model where an artifact exists in exactly one defined state at a time, and transitions between states follow explicit rules)"
**Note:** Keep the parenthetical concise — one clause, not a paragraph.

### Fix 16: chapter-13.md — nist_ai_rmf_2023 citation
**File:** `book/chapter-13.md`
**Location:** Governance dual metrics paragraph (find the passage discussing NIST AI RMF governance concerns)
**Action:** Add `{cite:p}\`nist_ai_rmf_2023\`` at the appropriate point
**Note:** Bib entry confirmed present (used in Ch 8, Ch 12)

### Fix 17: chapter-13.md — DLP abbreviation expansion
**File:** `book/chapter-13.md`
**Location:** Governance table that uses "DLP monitoring"
**Action:** Expand to "data loss prevention (DLP) monitoring" on first use, OR expand within the table cell itself if that's where it first appears

### Fix 18: chapter-14.md — "throughput constraint ladder" → "The Throughput Ladder"
**File:** `book/chapter-14.md`
**Location:** Find reference to "throughput constraint ladder"
**Replace with:** "The Throughput Ladder" (matching Ch 6's actual term, same as Fix 11)

### Fix 19: intro.md — "maturity levels" → match Ch 1 section title
**File:** `book/intro.md`
**Location:** "Find Your Edge" section — reference to "maturity levels in Chapter 1"
**Action:** Verify this matches Ch 1's actual section title. If Ch 1 uses "levels of AI automation in research" rather than "maturity levels," update the intro reference to match. If Ch 1 does say "maturity levels," no change needed.

---

## Verification Checklist

After all edits:
- [ ] Confirm intro phase structure: Foundations → Domain Workflows → Cross-Cutting Patterns → Validity → Delivery
- [ ] Confirm Ch 11 is under Delivery, not Validity
- [ ] Confirm "Where to Start" references updated
- [ ] Confirm Ch 1 says "five phases" not "four clusters"
- [ ] Grep all edited files for "terminological stability" — should appear nowhere (replaced by TC)
- [ ] Grep for "golden questions (Chapter 7)" — should appear nowhere
- [ ] Grep for "throughput constraint ladder" — should appear nowhere in Ch 5 or Ch 14
- [ ] Grep for "Institutional Context" in intro headings — should appear nowhere (replaced by Delivery)
- [ ] Grep for "Validity and Infrastructure" in intro headings — should appear nowhere (replaced by Validity)

## Files Touched

`book/intro.md`, `book/chapter-01.md`, `book/chapter-02.md`, `book/chapter-03.md`, `book/chapter-04.md`, `book/chapter-05.md`, `book/chapter-07.md`, `book/chapter-08.md`, `book/chapter-10.md`, `book/chapter-13.md`, `book/chapter-14.md`

## Files NOT Touched

`book/chapter-06.md`, `book/chapter-09.md`, `book/chapter-11.md`, `book/chapter-12.md`, `book/appendix-principles.md`, `book/appendix-security.md`, `book/foreword.md`
