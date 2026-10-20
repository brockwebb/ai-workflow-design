# Handoff: AI Workflow Design — Session 12

**Date:** 2026-03-31
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Chapter 4 Designed and CC Task Written + Executed

Full design session for Ch 4 (Detection & Extraction Workflows). Key design decisions:

- **Opening hook: "The Graph That Looked Right."** A team builds a KG from agency reports, leadership is impressed, then someone traces an edge back and discovers the LLM inferred a relationship never stated in the source text. The graph manufactured evidence.
- **Chapter positioned as the third of the domain workflows trilogy.** Ch 2 = clean input → category (classification). Ch 3 = dirty input → corrected output (wrangling). Ch 4 = unstructured input → structured elements pulled out (extraction). Ch 4 is the inverse of Ch 2.
- **Two worked examples:** Templ (2026) sdcMicro for disclosure review assistance (metadata-only pattern, LLM-as-advisor not executor, output as inspectable code). DiGiuseppe & Flynn (2026) for scaling open-ended survey responses (pairwise comparison > direct rating, six-LLM ensemble, Bradley-Terry aggregation).
- **KG confidence laundering as the chapter's signature warning section.** Four failure modes stated plainly: garbage chunking, lazy entity resolution, no validation against source, structural overconfidence. SFV sub-dimensions applied: compression fidelity, terminological consistency, state provenance.
- **Design principle:** If you cannot trace every extracted element back to a specific source passage, model version, and prompt, you do not have a knowledge graph — you have a confabulation graph.
- **Bridge to Ch 5:** Domain trilogy complete → Ch 5 generalizes the multi-model patterns that appeared in all three domain chapters.

**CC task:** `2026-03-31_draft_chapter_04.md` — **EXECUTED**

### Foreword and Introduction Additions — CC Task Written + Executed

Added material from Session 12 voice notes capturing the author's philosophy on living books, rate of change, acceleration curve, and public trust purpose.

**Foreword additions:**
- "On the Speed of This Field" section — living book statement, publish-early-and-iterate philosophy, rate of change argument, principles vs. examples framing. Mirrors ai4stats foreword pattern.
- "On Purpose" section — differentiation from commercial AI engineering books. This book serves people who produce work that upholds the public trust. Different stakes, different design constraints.
- Disclaimer verification against ai4stats pattern.

**Introduction additions:**
- Acceleration/velocity paragraph added to "Find Your Edge" section — the non-linear experience of leveling up, bursts of speed, looking back at what you were doing 3-4 months ago.
- Public trust paragraph added to "A New Design Space" section — for official statistics and scientific research, defensible output with evidence chains and provenance is the minimum standard.

**CC task:** `2026-03-31_foreword_and_intro_additions.md` — **EXECUTED**

### Seldon Ingest Task Written + Executed

CC task to reconcile Seldon graph with Sessions 10-11 changes: `paper sync`, artifact registration for Ch 3/10/11/foreword/intro, handoff registration, provenance links, `verify --fix`.

**CC task:** `2026-03-30_ingest_sessions_10_11.md` — **EXECUTED**

### Competitive Landscape Analysis

Evaluated two comparable books against the ai-workflow-design structure:

**Chip Huyen, *AI Engineering* (O'Reilly, 2025):**
- 10 chapters, horizontal treatment for commercial AI engineers
- Covers model internals, prompt engineering, RAG, fine-tuning, inference optimization, dataset engineering
- No analog to SFV, provenance/audit, institutional deployment, Five Safes security model
- Complementary, not competitive. Different audience, different constraints.

**Amit Bahree, *Generative AI in Action* (Manning, 2024):**
- 13 chapters, beginner-intermediate tutorial format, Azure/OpenAI ecosystem
- Code-along with Jupyter notebooks, covers image/audio generation
- Not in the same category. Teaches "what GenAI is and how to use it" vs. your book's "how to design reliable pipelines you can defend under audit."

**Conclusion:** No additional chapters needed. 14 is right. The gaps with both books are intentional and correct — your book's differentiation is SFV, provenance, institutional deployment, and the public trust framing. No other book in the space covers this vertical.

---

## CC Tasks Written This Session (3 files, all executed)

1. `2026-03-30_ingest_sessions_10_11.md` — **EXECUTED**
2. `2026-03-31_draft_chapter_04.md` — **EXECUTED**
3. `2026-03-31_foreword_and_intro_additions.md` — **EXECUTED**

---

## Current State of the Repo

### Chapter Status (All First Drafts Complete)

| Chapter | Status |
|---------|--------|
| Foreword | Revised with speed-of-field, purpose, AI authoring, acknowledgments (Session 12) |
| Introduction | Revised with acceleration curve, public trust paragraph (Session 12) |
| Ch 1: Why Design Matters | Drafted (Session 4), citations converted (Session 5) |
| Ch 2: Classification & Coding | Drafted (Session 6) |
| Ch 3: Data Wrangling & Standardization | Drafted (Session 11) |
| Ch 4: Detection & Extraction | **Drafted (Session 12)** |
| Ch 5: Ensemble & Multi-Model Playbook | Drafted (Session 7) |
| Ch 6: Parallel, Serial, Bottleneck | Drafted (Session 9) |
| Ch 7: Checkpoints, Failures, Recovery | Drafted (Session 9) |
| Ch 8: Evaluation by Design | Drafted (Session 7) |
| Ch 9: State, Drift, Validity | Drafted (Session 9) |
| Ch 10: State Mgmt & Provenance | Drafted (Session 10) |
| Ch 11: Workflow Orchestration | Drafted (Session 10) |
| Ch 12: Security & Supply Chain | Drafted (Session 5) |
| Ch 13: Institutional Deployment | Drafted (Session 5) |
| Ch 14: Cost & Practicality | Drafted (Session 6) |

**All 14 chapters + foreword + introduction have first drafts.**

### CC Tasks on Disk
Previously executed (Sessions 1–11): 39 files
Executed this session: 3 files
**Total: 42**

---

## What's Next

### Immediate: Glossary and Index

1. **Glossary** — ai4stats already has one. Pull the pattern, extend with ai-workflow-design-specific terms. New terms may include: stochastic tax, stochastic liabilities, confidence laundering, compression fidelity, terminological consistency, state provenance, golden test set, config-driven architecture, dual-model cross-validation, confidence routing, and others from the book's vocabulary.

2. **Index** — keywords by chapter, not page number. This is a living digital book, not a print index. Keyword tagging per chapter enables search and cross-reference without brittle page numbers.

### Then: Open Questions Backlog

Unresolved open questions from drafting sessions:
- Ch 5: 7 open items
- Ch 8: 7 open items
- Ch 14: 7 open items
- (Total: 21 known open questions)

Walk through these systematically. Some may already be resolved by later chapters; some may need design decisions.

### Then: Audit Pass

Full structural review of all chapters. Requires Perplexity for citation verification (15 citations flagged). Author plans to start audit in earnest next week when back at work with unlimited Perplexity access.

### Deferred (unchanged)
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check
- CLAUDE.md chapter outline table: Ch 3 name still says "Data Cleaning & Imputation" — needs update to "Data Wrangling & Standardization"

---

## Key Design Decisions This Session

1. **Ch 4 keeps "Detection & Extraction Workflows" title.** Third of the domain trilogy. KG confidence laundering thesis stays as the signature warning, not the frame — Templ and DiGiuseppe & Flynn provide the constructive design evidence.
2. **14 chapters confirmed as correct.** No additional chapter needed. Generation/summarization gap is intentional — the book covers workflows where output can be verified against ground truth or structural expectations.
3. **Foreword now has the living book statement.** Publish early, iterate, principles over examples. Mirrors ai4stats pattern but extends it.
4. **Public trust purpose made explicit.** Both foreword ("On Purpose" section) and introduction ("A New Design Space" addition). This is the book's core differentiation from Huyen, Bahree, and the commercial AI engineering literature.
5. **Acceleration/velocity curve captured.** Added to "Find Your Edge" in the introduction. Non-linear practitioner growth, bursts of speed, compounding velocity.

---

## Session Notes

- All CC tasks executed within session. No backlog carried forward.
- Competitive analysis confirmed the book occupies a unique position: no other book combines SFV, provenance, institutional deployment, and public trust framing for the federal statistical agency audience.
- ~112 pages current. Expected to reach 140-160 after glossary, index, figures, and resolved open questions. Lean is intentional — dense practitioner chapters, no filler.
- Seldon graph reconciliation for Sessions 10-11 completed this session.
- Next session priorities: glossary + index, then open questions walkthrough, then audit prep.
