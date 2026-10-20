# Handoff: AI Workflow Design — Session 18

**Date:** 2026-04-01
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Full Content Audit of Chapter 3 (AD-019 Process)

Performed the first real content audit using the AD-019 framework built into Seldon after Session 17's failed manual audit. Located the original ai4stats audit process in `ai4stats/audits/` and the AD-019 infrastructure in `seldon/docs/` (design doc, auditor prompt, output convention, CC task template). Applied the auditor protocol directly in-session rather than delegating to Claude Code.

**Audit results:** 24 classified assertions, 7 citation gaps, 3 unsupported claims (judgment stated as fact), 2 thin sections (outline-grade), 1 orphan reference, 0 figures, 1 reflection prompt (needed more).

### Two Rounds of Perplexity Verification

All citation gaps and unsourced claims resolved with evidence:

- **Federal coding use case:** Census FedCASIC 2024 (SINCT/NAPCS, 78% fewer write-ins), Reveal 2025 (ACS autocoder with LLM embeddings)
- **Fine-tuning cost:** Practitioner consensus — API wins below ~$50k/year; conditional above that. No peer-reviewed study, but vendor/practitioner analyses converge.
- **LLM vs traditional NLP:** Nuanced — LLMs stronger for semantic grouping from messy short text; topic models better for reproducible corpus-level structure. Hybrid pattern.
- **LLM imputation limits:** Empirical evidence — >10pp mean absolute subgroup errors, chain-of-thought doesn't help, survey weights don't solve the core problem.
- **Schema matching:** TaDA/VLDB 2024 — LLMs assist data engineers, N-to-M weakest, context amount matters. Harmonia (Santos et al. 2025) — agentic harmonization with human review.
- **Format extraction:** 2026 PDF parser benchmark — LLM evaluation r=0.93 human correlation vs r=0.68 TEDS.
- **Fortier 2017 taxonomy:** Confirmed exact terms: "complete," "partial," "impossible."
- **OMB procurement timeline:** April 2025 memo, 180-day compliance window.
- **Title 13/CIPSEA:** Directionally correct but overstated — softened to "creates significant legal barriers."

### Direct Verification of tian_2025

Obtained and extracted the actual PDF. Found author name errors in bib entry (Wenshan→Weiyushi, Yulei→Yu-Shan), F1 range corrections (0.61–0.67 not 0.65–0.66, MICE 0.50–0.61 not 0.50–0.58). LLM won 2 of 3 datasets, tied MICE on one. 40x computational cost confirmed exactly (4h vs 5 min).

### Thin Section Expansions Designed and Approved

- **Schema Inference:** Expanded from ~200 to ~500 words. Concrete income example (three surveys, different names/units/types), schema matching research (TaDA), agentic harmonization (Harmonia), Fortier harmonization taxonomy, new reflection prompt (employment_status crosswalk).
- **Format Extraction:** Expanded from ~200 to ~350 words. Concrete five-format collection scenario, hybrid routing decision framework (10k same-template vs 47 systems), stratified review guidance (oversample the long tail).

### Chapter 3 Figure Designed

Data quality pipeline routing diagram: two swim lanes (LLM-assisted semantic reasoning vs traditional statistical methods), routing fork from messy input, verification checkpoint, clean output. Landscape, full page width. PaperBanana method file specified.

### "The System You Leave Behind" Section Added

Review identified that Chapter 3 covers the Pipeline Builder's perspective (which tool for which sub-task) but was missing the System Owner's perspective (what does this cost organizationally over time). New section added between Fine-Tuning Cost Trap and Schema Inference, naming five first-class engineering concerns: supportability, maintainability, opportunity cost, designing for replaceability, and the virtue of boring tools. Ties back to the chapter's routing figure. All claims are engineering judgment — no citations needed.

### CLAUDE.md Cleanup

CC task written to remove the chapter-to-principle mapping table and chapter outline numbered list from CLAUDE.md. Both are structural metadata tracked in the Seldon graph; convenience copies in CLAUDE.md have drifted (confirmed Session 17). Replaced with pointers to `seldon go`.

---

## CC Tasks Written This Session — ALL EXECUTED

1. `2026-04-01_ch03_content_audit.md` — AD-019 content audit (superseded by comprehensive revision)
2. `2026-04-01_ch03_comprehensive_revision.md` — **EXECUTED.** 9 audit fixes + 2 section expansions + 8 bib entries. Supersedes all Session 17 Ch 3 tasks.
3. `2026-04-01_ch03_verification_corrections.md` — **EXECUTED.** tian_2025 corrections, Fortier exact taxonomy, two TBD author lists filled.
4. `2026-04-01_ch03_final_polish.md` — **EXECUTED.** $50k cost heuristic, thought experiment Title 13 broadening.
5. `2026-04-01_render_fig-03-01_paperbanana.md` — **EXECUTED.** Data quality pipeline routing figure.
6. `2026-04-01_claude_md_cleanup.md` — **EXECUTED.** Removed drifted mapping table and chapter list from CLAUDE.md.
7. `2026-04-01_ch03_system_owner_section.md` — **EXECUTED.** New section "The System You Leave Behind" — five engineering concerns (supportability, maintainability, opportunity cost, replaceability, boring tools) inserted between Fine-Tuning Cost Trap and Schema Inference.

**Superseded Session 17 tasks (do NOT execute):**
- `2026-04-01_ch03_audit_prose_fixes.md` — superseded by comprehensive revision
- `2026-04-01_ch03_perplexity_verification.md` — superseded by comprehensive revision
- `2026-04-01_ch03_audit_remediation.md` — superseded by comprehensive revision
- `2026-04-01_ch03_seldon_paper_audit.md` — was misnamed/misscoped, deleted and replaced

**Also written but not a Ch 3 task:**
- `docs/2026-04-01_ch03_thin_section_design.md` — design note with rationale for section expansions (reference only)

---

## Current State of Chapter 3

**Chapter 3 is complete.** All audit findings resolved, all CC tasks executed.

- Citations: increased from 1 to 10+ (census_fedcasic_2024, reveal_2025, omb_ai_procurement_2025, pdf_parser_benchmark_2026, santos_2025_harmonia, tada_vldb_2024, fellegi_1976, van_buuren_2011, webb_2026_pragmatics, tian_2025 corrected, fortier_2017)
- All unsourced claims resolved: fine-tuning cost rewritten as conditional framework, "no traditional NLP" replaced with nuanced comparison, CIPSEA softened, deployment timeline framed as judgment with OMB evidence floor
- Thin sections expanded with concrete scenarios and citations
- Figure added: fig-03-01 data quality pipeline routing
- New section: "The System You Leave Behind" — System Owner's perspective with five named engineering concerns
- Reflection prompts: 3 (Response Code Correction blockquote, Schema Inference employment_status prompt, Thought Experiment)
- $50k cost heuristic added as breadcrumb for thought experiment
- Thought experiment Title 13 question broadened to include CIPSEA and policy/statutory restrictions
- tian_2025 bib entry corrected (authors, F1 ranges, detail)
- Fortier 2017 exact taxonomy terms restored
- Zero em-dashes, zero bare dollar signs, zero company names, zero TBD bib entries

---

## Current State of the Repo

**Audit progress:**
- Foreword: ✓ audited (Session 15)
- Introduction: ✓ audited (Session 15)
- Chapter 1: ✓ audited (Sessions 15–16)
- Chapter 2: ✓ audited (Session 16)
- Chapter 3: ✓ audited AND remediated (Session 18) — **complete**
- Chapters 4–14: not yet audited

**Em-dash purge (foreword–Ch02):** Executed.

**CLAUDE.md:** Cleaned. Graph-tracked structural metadata removed, pointers to `seldon go` in place.

---

## What's Next

### Resume Chapter Audits

The AD-019 content audit process is now proven on Chapter 3. The CC task template exists at `seldon/docs/templates/cc_task_content_audit.md`. Stamp out for Chapter 4 next, then continue sequentially. Each audit will surface its own citation gaps and Perplexity verification needs — the "15+ citations flagged across sessions" carry-forward item dissolves as chapters are audited.

### Carrying Forward

- **fig-02-01 visual check** — confirm re-render resolved labeling errors
- **21 open questions across Ch 5, 8, 14** — address when those chapters are audited

### Deferred (unchanged)

- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check
- Seldon graph reconciliation (documentation ratio)

---

## Key Decisions This Session

1. **AD-019 content audit process validated on real content.** The auditor prompt, claim classification taxonomy (fact/judgment/conjecture), and routing rules work. First successful structured audit of the book.
2. **Thin sections expanded, not scoped as secondary.** Schema Inference and Format Extraction got concrete scenarios, citations, and reflection prompts rather than being cut or flagged as optional.
3. **Cost heuristic included as breadcrumb.** Thought experiments that ask unanswerable questions without giving the reader any tools turn people off. The $50k practitioner threshold gives an anchor; Ch 14 provides the rigorous framework.
4. **tian_2025 independently verified from source PDF.** Author names and F1 ranges corrected. Paper is a conference presentation (AAPOR 2025), not peer-reviewed, but empirical work with real election survey data.
5. **Fortier 2017 exact taxonomy confirmed.** "Complete," "partial," "impossible" — safe to use the precise terms.
6. **CLAUDE.md stripped of graph-tracked metadata.** Chapter-to-principle mapping table and chapter outline removed. Graph is the single source of truth for structural metadata.
7. **Session 17 Ch 3 tasks fully superseded.** The manual audit from Session 17 was unreliable; all findings were re-derived from scratch using the AD-019 protocol.

---

## Process Notes

- The AD-019 auditor prompt (`seldon/docs/agents/auditor_prompt.md`) worked well for in-session use. The claim classification taxonomy (fact/judgment/conjecture) with routing rules (auto_search / needs_author / auto_fix) correctly identified all the issues that the Session 17 manual audit missed or misclassified.
- Perplexity verification was done in two rounds: first round covered most claims, second round filled TBD bib entries and verified Fortier taxonomy.
- The "execute all tasks before handoff" pattern worked well this session — no pending tasks carrying forward.
