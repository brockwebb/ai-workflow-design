# Handoff: AI Workflow Design — Session 16

**Date:** 2026-04-01
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### DORA Respondent Count Resolved

The carrying-forward item from Session 15 (DORA 39,000+ respondent count) was resolved. The "39,000+" figure is the cumulative DORA program number across the report's history, not the 2024 AI-specific subsample (~3,000). The chapter text implied 39,000 produced the AI-specific findings. Fix: soften to "a large-scale global survey of technology professionals."

**CC task:** `2026-03-31_fix_dora_respondent_count.md` — **EXECUTED**

### Chapter 2 Audit — Complete

Full substantive read-through of `chapter-02.md` (Classification & Coding Workflows). Audit covered:
- Pedagogical pattern compliance (all four elements present ✓)
- Cross-reference accuracy to other chapters (all verified ✓)
- No `[NEEDS:]` markers, no `[TODO]` markers
- No figures existed — flagged as medium severity

**Empirical numbers verified against Concept Mapper repo:**

All numbers cross-checked against NUMBERS_MAP.md, 02_classification.qmd, 04_pairwise_harmonization.qmd, 05_results.qmd, and FedSurveyHarmonization.pdf:
- Routing percentages (68.5% / 11.8% / 19.7%) ✓
- Cohen's κ = 0.839 (topic), 0.687 (subtopic) ✓
- Fleiss' κ values (0.537, 0.611 pre-arb; 0.843, 0.796 post-arb) ✓
- 1,598 pairs, 142 bridge variables ✓
- 38 flagged questions ✓
- $15 classification cost ✓
- RoBERTa 0.64% uniform baseline ✓
- "$100 full pipeline" — confirmed as "under $100" (ceiling, not approximate). Fixed.

**Verification note:** Web search cannot verify Concept Mapper numbers — it's an unpublished draft working paper. Verification path is internal: checking chapter claims against repo analysis outputs. Perplexity dual-path is for *external* citations only.

### Routing Design Rationale Discussion

Extended discussion produced important design rationale for the dual-modal routing path:

1. **Logic gates vs. model invocations:** Consensus (68.5%) and dual-modal (11.8%) are deterministic logic gates — no model involved. Only arbitration (19.7%) invokes a third model. The chapter didn't make this clear.

2. **Dual-modal as deliberate engineering judgment:** Preserving both topic assignments was a design choice to broaden downstream matching. With ~152 subtopics, genuine taxonomic ambiguity is common. Accepting both signals is a form of fuzzy matching through the classification layer.

3. **Trade-off analysis:** 11.8% dual-modal rate was low enough that extra downstream calculations were acceptable. If substantially higher, would have signaled prompt design or taxonomy problems worth investigating.

4. **Spot-check QC:** Dual-modal assignments were manually spot-checked (results looked reasonable). Not a statistically designed sample, not logged as artifacts. Acknowledged as a trade-off appropriate to the risk level (wrong topic = more calculations, not wrong answers). Higher stakes would warrant more formal QC.

5. **Meta-point for the book:** Every routing decision is context-dependent engineering judgment. The Concept Mapper is an example, not a prescription. Design decisions must be made deliberately, documented, and defensible.

### Vendor Names Decision

Initial audit flagged "OpenAI, Anthropic, Google" in body text as violating the no-companies rule. **Reversed:** These are specific tools used in the case study and should be reported accurately. A foreword disclaimer was added instead: product/company mentions are for accurate methodology reporting, not endorsement.

### PaperBanana Figure — First Render Failed

First render of fig-02-01 had structural position labels ("Left Path (Consensus)") appearing as literal text in boxes. Method file rewritten with explicit instructions to avoid structural labels. Re-render CC task created with corrected method file.

**Lesson learned:** PaperBanana method files must describe box *content* only, never structural position references. The renderer may interpret any text in the spec as content to display.

**Also confirmed:** Do NOT change PaperBanana model names. Use `--vlm-model gemini-3.1-pro-preview` and `--image-model gemini-3.1-flash-image-preview` exactly. model_config.yaml has wrong names; CLI flags override.

---

## CC Tasks Written This Session (5 files, all EXECUTED)

1. `2026-03-31_fix_dora_respondent_count.md` — Ch 1 DORA fix — **EXECUTED**
2. `2026-04-01_render_fig-02-01_paperbanana.md` — First fig-02-01 render (had labeling errors) — **EXECUTED** (superseded by #4)
3. `2026-04-01_audit_ch02_prose_fixes.md` — Ch 2 five prose fixes + foreword disclaimer — **EXECUTED**
4. `2026-04-01_rerender_fig-02-01_paperbanana.md` — Corrected fig-02-01 method file + re-render — **EXECUTED**
5. `2026-04-01_ch02_routing_design_rationale.md` — Routing design rationale + engineering judgment framing — **EXECUTED**

**Total CC tasks on disk: 55** (50 prior + 5 this session)

---

## Current State of the Repo

**Audit progress:**
- Foreword: ✓ audited, fixes applied
- Introduction: ✓ audited, fixes applied
- Chapter 1: ✓ audited, fixes applied (DORA respondent count resolved this session)
- Chapter 2: ✓ audited, fixes applied, figure rendered (may need visual check on re-render)
- Chapters 3–14: not yet audited

---

## What's Next

### Immediate: Chapter 3 Audit

Continue chapter-by-chapter audit. Chapter 3 (Data Wrangling & Standardization Workflows) is next. Same audit standards. **One chapter per thread** — context stays tighter, avoids compaction risk.

### Carrying Forward

- **15 citations flagged across sessions** for Perplexity verification — integrate into chapter audit as each chapter is reviewed.
- **fig-02-01 visual check** — confirm re-render resolved labeling errors. If not, iterate method file.

### Deferred (unchanged)

- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check
- Seldon graph reconciliation follow-up (documentation ratio still 12%)

---

## Key Decisions This Session

1. **Vendor names stay in body text** when reporting case study methodology. Foreword disclaimer added for product/company mentions.
2. **Concept Mapper numbers verified internally** against repo outputs, not via web search. Dual-path Perplexity verification is for external citations only.
3. **"Under $100"** is the correct cost characterization (ceiling), not "approximately $100."
4. **Dual-modal routing is a logic gate**, not a model decision. Design rationale documented in chapter prose.
5. **Engineering judgment framing** added — the Concept Mapper is an example, not a prescription. Every situation requires its own design analysis.
6. **One chapter per thread** going forward to manage context window.
7. **PaperBanana method files** must avoid structural position labels — renderer may display them literally. Never change model names; use CLI overrides.

---

## Session Notes

- All 5 CC tasks confirmed executed by author before handoff.
- PaperBanana first render failure was instructive — method file format lesson captured.
- Next session: Chapter 3 audit. No outstanding blockers.
