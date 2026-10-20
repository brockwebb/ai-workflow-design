# CC Task Addendum: Chapter 13 Revision — Author Decisions and Adjustments

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Amends:** `cc_tasks/2026-04-06_ch13_revision.md`
**Target:** `book/chapter-13.md`

---

## Author Decisions

This addendum provides author decisions for items flagged in the base revision task and adds three additional parts (K, L, M) based on session review.

### Part F Adjustment (Feynman Frame)

The base task replacement text is slightly overwritten. Use a lighter touch. The principle should be stated briefly, not elaborated.

**Replace the Part F replacement text with:**
```
Training in this context is not "here's how to write a prompt." Training is methodology: understanding the stochastic nature of the tools (Chapter 1), designing evaluation frameworks (Chapter 8), building evidence chains (Chapters 9-10), and developing the discipline of forming your own expectation before looking at what the model produced. The goal is a workforce that can make sound decisions about AI use independently, not a workforce that follows a script.
```

**Notes:** Lighter than the base task version. Removes the "easiest person to fool" phrasing -- keeps the principle (estimate before you look) without the Feynman attribution or quotation. One clause, not two sentences.

### Part G Decision (\$47/6h Figure)

The \$47/6-hour figure is anecdotal -- a generic illustrative scenario, not the Concept Mapper case study. Ch 14's \$15/~2h is the Concept Mapper. They are different things.

**Replace the Ch 13 hook sentence:**

Current:
```
The pipeline runs on your laptop, costs $47, and finishes in six hours, replacing a task that currently takes three full-time equivalents four weeks each quarter.
```

New:
```
The pipeline runs on your laptop, costs less than fifty dollars, and finishes in a single day, replacing a task that currently takes three full-time equivalents four weeks each quarter.
```

**Notes:** Removes the specific \$47 and "six hours" numbers, which created a false precision that invited comparison with Ch 14's actual Concept Mapper breakdown. "Less than fifty dollars" and "a single day" are clearly illustrative framing for a generic scenario. No citation needed for an illustrative hook.

---

## Part K — Narrative Arc Resolution (C5)

Insert a brief closing paragraph **before** the existing bridge paragraph (the one starting "This chapter and Chapter 12 together cover...").

**Insert after the paragraph ending "...the trajectory matters more than the current state." and before the existing bridge paragraph:**

```
The pipeline that costs less than fifty dollars and finishes in a day? Teams are running it. Not everywhere, not without friction, and not without the obstacles described in this chapter. But the trajectory is real: institutions that started with a single pilot on non-sensitive data are now running production workloads. The gaps in this chapter are closable. They close faster when you name them honestly and build the evidence that earns trust.
```

**Notes:** Returns to the hook, provides grounded optimism without overpromising, connects to the "earning trust incrementally" section. Brief -- four sentences.

---

## Part L — Additional Reflection Prompt (Capability Building section)

Ch 13 has only 2 distributed reflection prompts across 7 substantive sections. The Capability Building section currently has none. Insert one after the paragraph ending "...Understanding is the one thing you cannot outsource."

**Insert:**
```
*If your organization's AI capability disappeared tomorrow -- the tools, the vendor access, the trained staff -- how quickly could you rebuild it? The answer tells you how much of your capability is actually internal.*
```

---

## Part M — PaperBanana Figure Spec: Governance Tiering Decision Framework

In addition to the table from Part I, spec a figure for the governance-as-gate vs. governance-as-infrastructure comparison. This is the chapter's strongest conceptual contribution and deserves a visual.

**Create PaperBanana method file at:** `assets/diagrams/paperbanana/ch13_governance_models.md`

```markdown
# Figure: Governance Models — Gate vs. Infrastructure

## Layout
Two-column comparison diagram. Left column: "Governance as Gate." Right column: "Governance as Infrastructure."

## Left Column (Gate Model)
Box labeled "Project Team" at top.
Arrow down to box labeled "Submit Request."
Arrow down to box labeled "Review Board (6-week cycle)."
Arrow down to diamond labeled "Approved?"
Arrow from diamond "No" back up to "Submit Request" (loop).
Arrow from diamond "Yes" down to box labeled "Deploy."
Side annotation: "Time: months. Bottleneck: review queue. Failure mode: teams stop trying or go around."

## Right Column (Infrastructure Model)
Box labeled "Project Team" at top.
Arrow down to box labeled "Automated Policy Check."
Arrow down to box labeled "Platform Envelope Validation."
Arrow down to box labeled "Deploy (with continuous monitoring)."
Side annotation: "Time: days to weeks. Control: embedded in platform. Failure mode: policy gaps in automation."

## Bottom
Shared label: "Same risk managed. Different cost. Different speed."
```

**Notes:**
- This is a method file for PaperBanana rendering, not a direct figure insertion
- Place in `assets/diagrams/paperbanana/` per project convention
- Actual rendering and insertion into chapter happens in the batch figure render CC task
- The figure should be referenced in the chapter text near the governance inversion paragraph, but the `::::{figure}` directive insertion waits for the rendered PNG

---

## Execution Order (Updated)

Execute Parts A through F (with F adjustment from this addendum), then G (from this addendum), then H through J, then K, L, M.

1. Part A (FedRAMP citation)
2. Part B (Procurement citation)
3. Part C (Enterprise ATO reframe)
4. Part D (GovCloud hedging)
5. Part E (Dual metrics reframe)
6. Part F (Feynman -- use THIS ADDENDUM's lighter version, not the base task version)
7. **Part G (Hook figure -- use THIS ADDENDUM's illustrative framing)**
8. Part H (SAT hedging)
9. Part I (Tiered governance table)
10. Part J (CA3 labeling)
11. **Part K (Narrative arc resolution -- new)**
12. **Part L (Reflection prompt -- new)**
13. **Part M (PaperBanana method file -- write to `assets/diagrams/paperbanana/ch13_governance_models.md`)**

## Additional Verification

After all parts including addendum:
- The hook uses "less than fifty dollars" and "a single day" -- no specific dollar figure
- The Feynman replacement is one clause, not two sentences
- The narrative arc resolution paragraph appears before the bridge paragraph
- The reflection prompt appears after the capability building outsourcing paragraph
- The PaperBanana method file exists at the specified path
- All other verifications from the base task still apply
