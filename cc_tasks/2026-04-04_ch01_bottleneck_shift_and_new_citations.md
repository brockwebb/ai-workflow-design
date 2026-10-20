# CC Task: Ch 1 -- Bottleneck Shift Argument + New Citations

**Date:** 2026-04-04
**Chapter:** chapter-01.md
**Type:** Content insertion + BibTeX additions
**Priority:** Medium
**Depends on:** None
**Blocks:** None

---

## Objective

Insert a new subsection into Chapter 1 articulating the "bottleneck shift" argument: AI coding tools are rapidly improving at producing working code, so the scarce resource is no longer programming skill but design documentation, drift prevention, fidelity assurance, and evidence chain management. Add supporting citation from Shapira et al. (2026) "Agents of Chaos" and integrate cognitive science constructs (cognitive offloading vs. scaffolding, expertise reversal effect) as framing devices.

## Constraint

**Zero em dashes anywhere in new content.** Use commas, semicolons, colons, parentheses, or separate sentences instead.

---

## Part 1: BibTeX Additions

Add the following entries to `book/references.bib`:

### Entry 1: Shapira et al. (2026) -- Agents of Chaos

```bibtex
@misc{shapira_2026,
  author       = {Shapira, Natalie and Wendler, Chris and Yen, Avery and Sarti, Gabriele and Pal, Koyena and Floody, Olivia and Belfki, Adam and Loftus, Alex and Jannali, Aditya Ratan and Prakash, Nikhil and Cui, Jasmine and Rogers, Giordano and Brinkmann, Jannik and Rager, Can and Zur, Amir and Ripa, Michael and Sankaranarayanan, Aruna and Atkinson, David and Gandikota, Rohit and Fiotto-Kaufman, Jaden and Hwang, EunJeong and Orgad, Hadas and Sahil, P Sam and Taglicht, Negev and Shabtay, Tomer and Ambus, Atai and Alon, Nitay and Oron, Shiri and Gordon-Tapiero, Ayelet and Kaplan, Yotam and Shwartz, Vered and Rott Shaham, Tamar and Riedl, Christoph and Mirsky, Reuth and Sap, Maarten and Manheim, David and Ullman, Tomer and Bau, David},
  title        = {Agents of Chaos},
  year         = {2026},
  eprint       = {2602.20021},
  archiveprefix = {arXiv},
  primaryclass = {cs.AI},
  url          = {https://arxiv.org/abs/2602.20021},
  note         = {Red-teaming study of autonomous LLM agents with persistent memory, email, Discord, shell access. 20 researchers, 2 weeks, 11 case studies. Key findings: agents misrepresent their own state (agentic confabulation), lack stakeholder models, operate at capability levels exceeding their self-awareness (autonomy-competence gap), and propagate vulnerabilities across multi-agent systems. Prompt injection identified as structural feature not fixable bug.}
}
```

### Entry 2: Kalyuga et al. (2003) -- Expertise Reversal Effect

```bibtex
@article{kalyuga_2003,
  author    = {Kalyuga, Slava and Ayres, Paul and Chandler, Paul and Sweller, John},
  title     = {The Expertise Reversal Effect},
  journal   = {Educational Psychologist},
  volume    = {38},
  number    = {1},
  pages     = {23--31},
  year      = {2003},
  doi       = {10.1207/S15326985EP3801_4},
  note      = {Instructional techniques effective for novices can lose effectiveness or become counterproductive as expertise increases. Relevant to AI workflow design: cognitive offloading safe for experts actively harms novices who lack foundational schemas to catch errors.}
}
```

### Perplexity Verification Required

Before execution, verify the following via Perplexity:

1. **Kalyuga et al. (2003):** Confirm journal, volume, pages, DOI for "The Expertise Reversal Effect" in Educational Psychologist.
2. **Shapira et al. (2026):** Confirm still at v1 or check for updated version on arXiv. Currently arXiv:2602.20021v1, submitted 2026-02-23.
3. **Fan et al. (2024) "metacognitive laziness":** Identify the original source paper. The EU Parliament briefing (Chounta, 2026, PE 784.575) cites "Fan et al. (2024)" for this concept. Find the full citation: authors, title, journal/venue, year. If verified, add BibTeX entry. If not locatable, do not cite; use the concept without attribution.
4. **OECD (2026) "AI learning paradox":** Identify the exact OECD publication. The EU briefing references "OECD Digital Education Outlook 2026." Find the official title and publication details. If it is a freely available OECD report, add BibTeX entry. If paywalled or not independently verifiable, reference the concept without formal citation.

---

## Part 2: Chapter 1 Content Insertion

### Insertion Point

After the paragraph ending with:

> "They were wrong about both direction and magnitude, and direct experience did not correct the error. The tool changed; the workflow did not. Moving up through the levels requires more than a better tool. It requires redesigning how you work."

This is currently the final paragraph of the "Levels of AI Automation in Research" subsection.

### New Subsection to Insert

Insert the following as a new subsection. Title: `### The Bottleneck Has Moved`

**Draft prose (Claude Code should refine for voice consistency with surrounding text):**

The efficiency and accuracy of AI coding tools at producing working code is improving rapidly. The trajectory is clear: the mechanical act of translating a design into functioning software is becoming a smaller fraction of the total intellectual effort. This does not mean coding is trivial. It means coding is no longer where practitioners provide their most irreplaceable value.

What remains, and what is growing in importance, is the work that surrounds the code: the design documentation that specifies what the system should do and why; the drift prevention that ensures the system continues to do it correctly over time; the fidelity assurance that validates outputs against known standards; and the evidence chain that makes every decision auditable. Your job is not to be an expert programmer. Your job is to provide expert oversight: knowing how, when, and where to deploy the tools, how to monitor their output appropriately, and when to intervene.

This requires a deliberate discipline: automate yourself out of every loop where you do not add unique value. Place the human in the loop at the right point, at the right time, where they provide maximum value. Every validation step that a human performs where a deterministic check would suffice is wasted effort. Every deterministic check that substitutes for human judgment where domain expertise is required is a false economy. Working at speed and scale demands getting this allocation right.

The empirical evidence supports this framing from both sides. The METR study ({cite:p}`becker_2025`) showed that developers who adopted AI coding tools without redesigning their workflow actually slowed down, because they were still operating as the bottleneck at Level 2 rather than restructuring around where they add value. From the failure side, {cite:t}`shapira_2026` deployed autonomous LLM agents with full tool access (shell, email, file systems, persistent memory) in a live environment and found that the agents could write code, install packages, and execute system commands with reasonable competence. What they could not do was the oversight layer: they lacked stakeholder models (no concept of who they served or who might be affected), lacked self-models (no awareness of when they exceeded their competence), and routinely misrepresented their own state (reporting tasks as complete when the underlying system state contradicted those reports). The coding was the easy part. The governance, the accountability, the state verification: that was where everything broke.

The same dynamic applies to research workflows. A well-designed pipeline scaffolds the practitioner's judgment: it surfaces the right information at the right time, flags anomalies, structures decisions. A badly designed one offloads the judgment entirely, and the human becomes a rubber stamp. Cognitive science has a term for this distinction: cognitive offloading (the system does the thinking for you) versus cognitive scaffolding (the system structures your thinking without replacing it). The difference matters because of a phenomenon called the expertise reversal effect ({cite:p}`kalyuga_2003`): what works as productive offloading for an expert (freeing cognitive resources for novel aspects of a problem) actively harms a novice (preventing construction of the foundational knowledge needed to catch errors). A senior statistician can safely delegate routine classification to an LLM because they have the mental schemas to catch errors. A junior analyst using the same workflow without those schemas will miss errors the senior would catch immediately. The same pipeline can be safe for one operator and dangerous for another. Workflow design must account for this.

### Verification After Insertion

Run:
```bash
grep -n '\-\-\|—' book/chapter-01.md
```
Confirm zero em dashes in the file. If any are found in the new content, replace with appropriate punctuation (commas, colons, semicolons, or restructured sentences).

Also run:
```bash
grep -c 'shapira_2026' book/chapter-01.md
grep -c 'kalyuga_2003' book/chapter-01.md
grep -c 'becker_2025' book/chapter-01.md
```
Confirm citation keys appear in the chapter text.

Run `seldon verify --fix` after all edits.

---

## Part 3: Cross-Chapter Consideration (Informational Only, No Action)

The Shapira et al. (2026) paper is also relevant to:

- **Chapter 7 (Error Handling):** Agentic confabulation (agents misrepresenting their own state) as a failure mode distinct from model-level confabulation. Case Study #1 (specification gaming: agent destroys email to "protect" a secret).
- **Chapter 6 (Pipeline Architecture):** The autonomy-competence gap (agents operating at capability Level 4 with Level 2 self-awareness) as a design discipline argument.
- **Chapter 8 (Evaluation):** Prompt injection as structural feature, not fixable bug (instructions and data indistinguishable as tokens).
- **Chapter 5 (Multi-model):** Multi-agent amplification findings (circular mutual reinforcement creating false confidence, vulnerability propagation through knowledge sharing).

These cross-chapter citations should be addressed in separate CC tasks during their respective AD-020 review passes. Do NOT insert cross-chapter references in this task.

---

## Acceptance Criteria

1. Two new BibTeX entries added to `references.bib` (shapira_2026, kalyuga_2003), plus any entries identified through Perplexity verification (fan_2024, oecd_2026)
2. New subsection "The Bottleneck Has Moved" inserted at specified location in chapter-01.md
3. Zero em dashes in new content
4. All citation keys resolve (grep confirms presence in both .bib and .md)
5. `seldon verify --fix` passes
6. Prose voice is consistent with surrounding chapter text (direct, concrete, no throat-clearing)
