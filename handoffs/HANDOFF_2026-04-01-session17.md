# Handoff: AI Workflow Design — Session 17

**Date:** 2026-04-01
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Em-Dash Purge and Dollar Sign Rendering Fix

Discovered two issues across foreword through chapter 2:

1. **Dollar sign rendering regression in chapter-02.md:** MyST interprets bare `$` as LaTeX math delimiters. Lines 18 and 88 contain `$15` and `$100`, causing everything between dollar signs to render as a single run-on math block with no spaces in HTML output. Source files on disk are clean; this is a rendering issue. Fix: escape as `\$`.

2. **Em-dash zero tolerance enforcement:** 11 em-dashes found across intro.md (1), chapter-01.md (2), and chapter-02.md (8). foreword.md was clean. Each replacement specified with contextually appropriate punctuation.

**CC task:** `2026-04-01_emdash_purge_and_dollar_fix.md` — **PENDING**

### Chapter 3 Audit — Partially Complete

Audit of `chapter-03.md` (Data Wrangling & Standardization Workflows) conducted. Mechanical checks passed (zero em-dashes, zero bare dollar signs, zero NEEDS/TODO markers). Substantive issues found.

**Audit exposed systemic process failures.** The audit protocol was not followed correctly. Key failures:

- **Dual-path citation verification was not performed.** The established process (web search + Perplexity independent verification) was not followed. Only one web search was attempted for tian_2025; Perplexity path was skipped entirely.
- **Unsourced factual claims were presented as "needs your judgment" instead of being automatically sent to Perplexity search.** Claims like "No traditional NLP approach handles open-ended semantic analysis at this quality level" and fine-tuning TCO assertions should have generated search tasks automatically, not been escalated for author input.
- **CLAUDE.md was treated as source of truth for chapter-to-principle mapping.** The graph is the source of truth. CLAUDE.md has a convenience-copy mapping table that has drifted. This table may need to be removed from CLAUDE.md entirely.
- **Items classified as "not requiring author judgment" actually did.** The audit process needs better separation of mechanical fixes from substantive decisions.
- **Later sections (schema inference, format extraction, semantic analysis) appear to be lightly-fleshed outline material** rather than substantive content. This was flagged but not investigated.

### Chapter 3 Findings Summary

| Severity | Issue | Status |
|----------|-------|--------|
| High | Orphan "Pragmatics system" reference — needs `{cite:p}` to `webb_2026_pragmatics` | CC task written |
| High | Only 1 citation in entire chapter — thin for empirical claims | Perplexity task written |
| High | Multiple unsourced factual claims (fine-tuning TCO, LLMs vs NLP, deployment timelines) | Perplexity task written |
| Medium | No figures | Noted, not tasked yet |
| Medium | Chapter header WP mismatch with CLAUDE.md — flagged, not fixed (graph is source of truth) | CC task flags discrepancy |
| Medium | Later sections may be outline remnants needing expansion | Needs design session |
| Low | No Ch 14 cross-reference in fine-tuning section | CC task written |
| Low | "6 to 18 months" stated twice | CC task written |

### Pragmatics Paper Figures Located

Found figures in `/Users/brock/Documents/GitHub/census-mcp-server/paper/figures/`:
- `fig_sidecar_architecture.png` — RAG vs Pragmatics architecture comparison (better fit for Ch 11 or wherever MCP gets full treatment)
- `F4_pragmatic_item_anatomy.pdf` — internal structure of a pragmatic item (better fit for deep pragmatics treatment, not Ch 3)
- Chapter 3 still needs its own figure (code correction pipeline flow)

### Meta-Decision: Audit Process Overhaul

Author decided to build a proper audit agent into Seldon rather than continue with the current ad-hoc process. The current audit approach is "extremely immature and not working well." Key requirements for the new audit agent:

- Automatic dual-path citation verification (web search + Perplexity) for every factual claim
- Automatic fact/conjecture/judgment classification for every assertion
- Content depth assessment (substantive vs outline-grade)
- Multiple actors handling different parts of the audit
- No escalation to author for items that should be resolved by search

---

## CC Tasks Written This Session (3 files, all PENDING)

1. `2026-04-01_emdash_purge_and_dollar_fix.md` — Em-dash removal (11 instances) + dollar sign escaping across foreword–Ch02 — **PENDING**
2. `2026-04-01_ch03_perplexity_verification.md` — 7 verification items covering all factual claims in Ch 3 — **PENDING**
3. `2026-04-01_ch03_audit_prose_fixes.md` — 7 prose fixes for Ch 3 (pragmatics citation, bib entries, cross-refs, repetition) — **PENDING** (partially depends on Perplexity results)

**Total CC tasks on disk: 58** (55 prior + 3 this session)

---

## Current State of the Repo

**Audit progress:**
- Foreword: ✓ audited (Session 15), em-dash clean
- Introduction: ✓ audited (Session 15), 1 em-dash to fix
- Chapter 1: ✓ audited (Sessions 15–16), 2 em-dashes to fix
- Chapter 2: ✓ audited (Session 16), 8 em-dashes + dollar sign rendering to fix
- Chapter 3: Partially audited (Session 17) — prose fixes and Perplexity verification pending; thin sections need design session
- Chapters 4–14: not yet audited

**BLOCKED:** Chapter audit process suspended pending Seldon audit agent build.

---

## What's Next

### Immediate: Seldon Audit Agent

Author is building an audit agent into Seldon before continuing chapter audits. The current manual audit process failed to follow established procedures and produced poor results. The new agent should automate:
- Dual-path citation verification
- Factual claim classification
- Content depth assessment
- Cross-reference validation
- Em-dash and formatting checks

### Execute Pending CC Tasks

Three CC tasks from this session are pending execution:
1. Em-dash purge and dollar sign fix (foreword–Ch02)
2. Chapter 3 Perplexity verification
3. Chapter 3 prose fixes (partially dependent on #2)

### Carrying Forward (unchanged from Session 16 + additions)

- **15+ citations flagged across sessions** for Perplexity verification
- **fig-02-01 visual check** — confirm re-render resolved labeling errors
- **CLAUDE.md chapter-to-principle mapping table** — may need removal (graph is source of truth, table has drifted)
- **Chapter 3 thin sections** (schema inference, format extraction, semantic analysis) — need design session to determine expand vs scope explicitly
- **Chapter 3 figure** — code correction pipeline flow needed

### Deferred (unchanged)

- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check
- Ch 13: "Building competence outside the perimeter" content check
- Seldon graph reconciliation follow-up (documentation ratio still 12%)

---

## Key Decisions This Session

1. **Em-dashes are zero tolerance** across the entire book. Purge retroactively.
2. **Dollar signs must be escaped** as `\$` in MyST markdown to prevent LaTeX math interpretation.
3. **The graph is the source of truth**, not CLAUDE.md. The chapter-to-principle mapping table in CLAUDE.md has drifted and should not be used for editorial decisions. May need removal.
4. **Audit process is being overhauled.** Current manual approach failed to follow dual-path verification, improperly escalated searchable items to author, and misclassified fix severity. A Seldon audit agent will replace the ad-hoc process.
5. **Chapter audits paused** until the audit agent is built.
6. **Pragmatics paper figures located** at `/Users/brock/Documents/GitHub/census-mcp-server/paper/figures/` — sidecar architecture and pragmatic item anatomy available for future chapter figures.

---

## Process Failures Documented (for audit agent requirements)

These specific failures should inform the Seldon audit agent design:

1. **Perplexity dual-path not executed.** Every citation and factual claim needs two independent verification paths. The audit produced zero Perplexity searches.
2. **"Needs your judgment" used as a catch-all.** Claims without evidence should generate searches, not author questions. The default action for an unsourced assertion is search, not escalate.
3. **CLAUDE.md treated as authoritative.** Convenience copies drift. The graph is the only source of truth for structural metadata.
4. **Severity misclassification.** Items labeled "straightforward / no discussion needed" would have introduced errors if executed without review.
5. **Content depth not assessed.** Outline-grade material was not distinguished from substantive content.
6. **Assertion type not classified.** Facts, engineering judgments, and conjecture were not differentiated, leading to claims stated as fact without evidence.

---

## Session Notes

- No CC tasks executed this session (all 3 are PENDING).
- Session pivoted from audit execution to audit process failure analysis.
- Author will build Seldon audit agent before resuming chapter audits.
- Next substantive chapter work will restart from the beginning with the new agent.
