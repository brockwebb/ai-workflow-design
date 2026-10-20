# CC Task: Appendix-Principles Revision + Back Matter TOC Reorder

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Target files:** `book/appendix-principles.md`, `book/myst.yml`
**Design note:** `docs/2026-04-06_appendix_principles_framing.md`

---

## Context

The principles appendix is currently a bare reference card: tenets, principles, and a chapter-to-principle mapping table. No framing, no context for why these principles matter or who they are for. This revision adds a short framing section before the tenets and fixes the back matter TOC ordering.

The design note (`docs/2026-04-06_appendix_principles_framing.md`) captures the author's intended framing. Read it before writing.

---

## Part A: Framing Paragraph

Add a framing section between the title and the "Compressed Tenets" heading. One to two paragraphs, drawing from the design note.

**What the framing should do:**
- Motivate the tenets/principles for a reader wondering whether they personally belong in this world
- Make clear that the book's design discipline is about comprehension and accountability, not speed and throughput
- Acknowledge the field is changing fast, but good design and evidence chains are the durable requirements
- Be short: one paragraph, maybe two. Not a manifesto.

**What the framing should NOT do:**
- Cite the Zuo article or any LinkedIn/blog source (universalize the insight, drop the source)
- Name Karpathy, Steinberger, or any Silicon Valley figures
- Claim AI is changing everything (generic, unhelpful)
- Be self-help ("you need to change your mindset")
- Overlap with Ch 14's forward-looking close (different purpose: the close is about what to do next; the appendix framing is about who these principles are for)
- Use em-dashes

**Core insight to capture (from design note, paraphrased):**
The shift this book supports is not "ship code you don't read." It's "insert yourself where you provide value, and when things break, trace it back and understand the failure." The book is for interdisciplinary thinkers who design systems -- people who see connections across domains, understand flows and algorithms intuitively, and can think in terms of design and systems, but who may not be traditional coders. The shift is from executing tasks to designing systems, from producing outputs to producing evidence, from controlling every step to knowing which steps require your judgment.

**Tone:** Direct, confident, no throat-clearing. Match the practitioner voice of the book's body chapters.

## Part B: Back Matter TOC Reorder

In `book/myst.yml`, change the back matter ordering from:

```
    - file: glossary.md
    - file: index.md
    - file: bibliography.md
```

to:

```
    - file: bibliography.md
    - file: glossary.md
    - file: index.md
```

Rationale: Standard academic/technical book convention is Appendices -> Bibliography -> Glossary -> Index. Bibliography is currently last (after index); it should come before glossary.

## Part C: Status Comment Update

Update the status comment at the top of `book/appendix-principles.md` from `<!-- STATUS: Placeholder -->` to `<!-- STATUS: Draft -->`.

---

## Verification

1. `book/appendix-principles.md` has a framing section before the tenets
2. The framing is 1-2 paragraphs, no more
3. No em-dashes in new content
4. No named individuals or specific articles cited
5. No overlap with Ch 14 capstone close
6. `book/myst.yml` has bibliography before glossary before index in the TOC
7. Status comment updated to Draft
8. Run `seldon verify --fix` after edits

## Do NOT

- Modify the tenets, principles, or mapping table content
- Add citations
- Write more than two paragraphs of framing
- Use em-dashes anywhere
- Reference Ch 14's closing language or themes
- Touch any other files
