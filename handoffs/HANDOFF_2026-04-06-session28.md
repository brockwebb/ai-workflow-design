# Handoff: Session 28 — Ch 12 Completion, Security Appendix, Ch 13 AD-020 + Revision

**Date:** 2026-04-06
**Session scope:** Ch 12 appendix pointer insertion, agentic AI security appendix creation (full draft + build integration + BibTeX), Ch 13 AD-020 calibration run 011, Ch 13 Perplexity verification (PQ1-PQ6), Ch 13 revision (13 parts), graph cleanup (3 tasks closed)
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Graph Cleanup

Three tasks closed at session start:
- `e526121b` — duplicate Meta-Harness research note (duplicate of `edcdc3d1`)
- `edcdc3d1` — Meta-Harness research note (Ch 11 citation done in Session 27; SFV deferred to SFV project)
- `1f6c25b1` — security appendix task (superseded by CC task `e19d9251`)

### Ch 12 Completion

CC task written (`cc_tasks/2026-04-06_ch12_appendix_pointer.md`), executed by Claude Code. Single sentence inserted at line 159 of `book/chapter-12.md` in the Framework Alignment section, pointing to the new security appendix via `{ref}\`appendix-security\``.

### Agentic AI Security Appendix

CC task written (`cc_tasks/2026-04-06_security_appendix.md`), executed by Claude Code. Three-part task:
- **Part A:** Created `book/appendix-security.md` (~1,800 words, 5 citations). Structured as: what makes agents different (NIST external-state-change boundary), threat surface (OWASP top 3 + 2 supplemental), identity gap (NCCoE + Cyber AI Profile + AASI convergence), controls that work today (4 actionable items), the CISO conversation (how to structure it), where this is headed (pre-standard context).
- **Part B:** Updated `book/myst.yml` TOC — `appendix-security.md` inserted between `appendix-principles.md` and `glossary.md`.
- **Part C:** Added 5 BibTeX entries to `book/references.bib`: `nccoe_agent_identity_2026`, `nist_aasi_2026`, `nist_caisi_rfi_2026`, `nist_cyber_ai_profile_2025`, `owasp_agentic_top10_2026`.

Framing: mission enablement for CISO conversation, shared vocabulary, not security engineering. Matches Ch 12's "enabling, not prohibitive" tone. All sources are NIST/OWASP — exactly the source hierarchy the federal audience trusts.

### Ch 13 AD-020 Pipeline (Calibration Run 011)

CC task written (`cc_tasks/2026-04-06_ch13_ad020_review_pipeline.md`), executed by Claude Code. Verdict: `conditionally_ready`. 6 clusters, 1 broken cascade.

New gates introduced:
- **Citation sparsity check** — fired hardest of any gate in the series (zero citations, 4 Type C empirical claims)
- **Tenet diagnostic value check** — confirmed the tenet/principle threading adds analytical clarity (not mechanical)
- **Adversarial tone check** — passed (diagnostic, not adversarial)
- **Learned helplessness check** — moderate risk; ARCS Confidence/Satisfaction scores were weak before revision

Triple persona test (first in series):
| Persona | Fully | Partial | Not |
|---|---|---|---|
| A (Practitioner) | 1 | 4 | 0 |
| B (IT/Governance) | 2 | 3 | 0 |
| C (Program Manager) | 1 | 4 | 0 |
| Combined | 4 | 11 | 0 |

Key findings:
- **C1 (convergence 4):** Zero citations with two high-priority Type C empirical claims ("report authorization timelines dropping" and "report measurably faster...without increased incident rates")
- **C2 (convergence 3):** Broken cascade CA9 — "the foreword's Feynman frame" not in foreword
- **C3 (convergence 3):** Figure discrepancy — \$47/6h (Ch 13 hook) vs. \$15/~2h (Ch 14 Concept Mapper)
- **C4 (convergence 3):** Zero tables in framework-heavy chapter — starkest visual gap in the series
- **C5 (convergence 2):** Narrative arc deferred — hook not paid off within chapter
- **C6 (convergence 2):** Implementation specificity gap — all personas receive "what" not "how"

Perplexity verification completed for PQ1-PQ6 (author-provided). Results: FedRAMP timelines confirmed (>1 year traditional, 20x targeting weeks), procurement "6-18 months" defensible as rule-of-thumb with MITRE AiDA source, enterprise ATO reframed with RAISE 2.0 citation, GovCloud lag hedged with Microsoft source, dual metrics reframed as normative argument (no federal case study found), SAT thresholds directionally correct but changing.

### Ch 13 Revision

CC task written (`cc_tasks/2026-04-06_ch13_revision.md`) + addendum (`cc_tasks/2026-04-06_ch13_revision_addendum.md`), both executed by Claude Code. Thirteen parts:

| Part | Content |
|------|---------|
| A | FedRAMP citation (`knoxsystems_fedramp_2026`) + timeline text |
| B | Procurement citation (`mitre_aida_timelines`) + reframe |
| C | Enterprise ATO: RAISE 2.0 citation (`doncio_raise2_2024`), remove "report" language |
| D | GovCloud: Microsoft citation (`microsoft_azure_gov_features`), "as of this writing" hedge |
| E | Dual metrics: normative argument, remove "measurably faster" empirical claim |
| F | Feynman frame removal: one-clause replacement ("forming your own expectation before looking"), no Feynman attribution |
| G | Hook: \$47/6h → "less than fifty dollars" / "a single day" (illustrative, not Concept Mapper) |
| H | SAT: remove fixed thresholds, advise checking current FAR/GSA guidance |
| I | Tiered governance table (Low/Medium/High with review process, automated controls, timeline columns) |
| J | CA3 labeling: "model replaceability" → "model-agnostic design principle" |
| K | Narrative arc resolution paragraph before bridge (returns to hook, grounded optimism) |
| L | Reflection prompt in Capability Building section ("If your organization's AI capability disappeared tomorrow...") |
| M | PaperBanana method file for governance models comparison figure |

Author decisions applied:
- Feynman: removed from Ch 13, NOT added to foreword. Lighter replacement than initial draft.
- \$47: was anecdotal/generic, not the Concept Mapper. Changed to illustrative "less than fifty dollars" / "a single day."
- Tables: tiered governance table added.
- Narrative arc: resolution paragraph added before bridge.

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Graph cleanup (3 tasks closed) | Done |
| Ch 12 appendix pointer insertion | Done |
| Security appendix created (`book/appendix-security.md`) | Done |
| `book/myst.yml` TOC updated (appendix in correct position) | Done |
| 5 security appendix BibTeX entries added | Done |
| Ch 13 AD-020 audit (calibration run 011) | Done |
| Ch 13 Perplexity verification (PQ1-PQ6) | Done |
| Ch 13 revision (Parts A-M) | Done |
| 4 Ch 13 revision BibTeX entries added | Done |
| PaperBanana method file for governance comparison figure | Done |

---

## Outstanding Items — Execution Queue

### Security appendix follow-up:

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 1 | **Security appendix AD-020 audit** | **NEXT (after Ch 14)** | The appendix needs its own AD-020 pass per the decision gate closure. Not blocking Ch 14 AD-020. |

### Ch 14 AD-020 pipeline:

| # | Task | Priority | Notes |
|---|------|----------|-------|
| 2 | **Ch 14 AD-020 audit** (calibration run 012) | **NEXT** | Write CC task, run pipeline. Ch 14 is "Making the Economic Case" — economics/budget chapter. Last numbered chapter. |

### Carried forward:

| # | Item | Priority | Notes |
|---|------|----------|-------|
| 3 | Em-dash purge + `\$` escaping (foreword-Ch 2) | Medium | Session 17 leftover |
| 4 | Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| 5 | Batch figure render + insertion | Verify | Was marked completed in graph (Session 24 reconciliation) — verify PNGs exist. New PaperBanana method files added this session (ch13_governance_models.md) and prior sessions. |
| 6 | arXiv:2502.01534 metadata verification | Low | Carried from Session 17 |
| 7 | Ch 9 optional Groves 2009 citation (`d9fbc94f`) | Low | Only remaining proposed task in graph. Evaluate on next Ch 9 pass. |
| 8 | Meta-Harness SFV citation | Low | Deferred to SFV paper writeup. Research note filed. |

---

## Key Design Decisions

1. **Feynman frame removed from Ch 13, NOT restored to foreword.** The verification principle ("form your own expectation before looking at the output") is stated in-text without Feynman attribution. One clause, not a passage. The foreword's prior Feynman content was deliberately removed in an earlier session and that decision stands.

2. **\$47/6h hook was anecdotal, not the Concept Mapper.** Changed to illustrative "less than fifty dollars" / "a single day" to avoid false precision and the appearance of a factual claim that contradicts Ch 14's \$15/~2h Concept Mapper breakdown. The emotional impact of the hook is preserved by the order-of-magnitude contrast with "3 FTEs four weeks each quarter."

3. **Ch 13 dual metrics claim reframed as normative, not empirical.** No federal case study found measuring "faster authorization without increased incidents." The revised text argues from incentive design logic ("you get what you measure") rather than claiming measured outcomes. Stronger argument because it's honest about the evidence base.

4. **Security appendix placed after appendix-principles, before glossary in TOC.** This is the correct build order for both HTML and PDF. The appendix gets its own AD-020 pass after Ch 14's audit.

5. **Triple persona test validated for three-audience chapters.** Ch 13's declared audience (practitioners, IT/governance, program managers) warranted three separate personas. The 4/11/0 combined score is useful but the per-persona breakdown is more diagnostic. Carry forward for any chapter declaring 3+ audiences.

6. **Citation sparsity gate is the most productive new gate in the series.** Ch 13's zero-citation starting point forced systematic identification of which claims are experiential wisdom (no citation needed), which are verifiable assertions (hedge with "as of this writing"), and which are empirical claims (need citation or reframing). This three-way classification should be standard for all future runs.

---

## New Artifacts Created This Session

| File | Type | Content |
|------|------|---------|
| `cc_tasks/2026-04-06_ch12_appendix_pointer.md` | CC task | Ch 12 appendix pointer sentence |
| `cc_tasks/2026-04-06_security_appendix.md` | CC task | Security appendix creation + build integration |
| `cc_tasks/2026-04-06_ch13_ad020_review_pipeline.md` | CC task | Ch 13 AD-020 audit |
| `cc_tasks/2026-04-06_ch13_revision.md` | CC task | Ch 13 revision (Parts A-J) |
| `cc_tasks/2026-04-06_ch13_revision_addendum.md` | CC task | Ch 13 revision addendum (Parts F/G overrides + K/L/M) |
| `book/appendix-security.md` | Appendix | Agentic AI security considerations (~1,800 words) |
| `assets/diagrams/paperbanana/ch13_governance_models.md` | PaperBanana method | Governance gate vs. infrastructure comparison figure |

## Files Modified This Session

| File | Changes |
|------|---------|
| `book/chapter-12.md` | Line 159: appendix pointer sentence inserted |
| `book/chapter-13.md` | Full revision: 4 citations added, hook reframed, Feynman removed, ATO/GovCloud/metrics reframed, governance table added, reflection prompt added, narrative arc resolution added |
| `book/myst.yml` | TOC: `appendix-security.md` added between `appendix-principles.md` and `glossary.md` |
| `book/references.bib` | Added 9 entries: 5 security appendix + 4 Ch 13 revision |

## Audit Files Created This Session

| File | Content |
|------|---------|
| `audits/chapter-13_content_audit.yaml` | Ch 13 Tier 1 |
| `audits/chapter-13_perplexity_queries.md` | Ch 13 verification queries |
| `audits/chapter-13_practitioner_stress_test.yaml` | Ch 13 Tier 2a (triple persona) |
| `audits/chapter-13_bloom_depth_check.yaml` | Ch 13 Tier 2b |
| `audits/chapter-13_secondary_sweep.yaml` | Ch 13 Tier 3 |
| `audits/chapter-13_review_synthesis.yaml` | Ch 13 synthesis |
| `audits/chapter-13_cascade_results.yaml` | Ch 13 cascades |
| `seldon/docs/design/AD-020_calibration_011_ch13.md` | Ch 13 calibration |

---

## AD-020 Pipeline Progress

| Run | Chapter | Type | Verdict | Key Finding |
|-----|---------|------|---------|-------------|
| 002 | Ch 4 | domain | conditionally_ready | — |
| 003 | Ch 5 | pattern | conditionally_ready | — |
| 004 | Ch 6 | eng/construction | conditionally_ready | — |
| 005 | Ch 7 | eng/defensive | conditionally_ready | — |
| 006 | Ch 8 | methodology/framework | conditionally_ready | — |
| 007 | Ch 9 | theoretical framework | conditionally_ready | — |
| 008 | Ch 10 | infrastructure guide | conditionally_ready | no MVP sequence |
| 009 | Ch 11 | evaluation/landscape | conditionally_ready | stochastic tax attribution |
| 010 | Ch 12 | governance/security | conditionally_ready | agentic security gap |
| **011** | **Ch 13** | **institutional deployment** | **conditionally_ready** | **zero citations + Feynman broken cascade** |
| 012 | Ch 14 | economics | **NEXT** | — |

Remaining: Ch 14 (last numbered chapter), security appendix, then Chs 1-3 + foreword if time permits.

---

## Nothing Modified Outside Scope

- No chapter files other than `book/chapter-12.md` and `book/chapter-13.md` edited
- `book/foreword.md` NOT modified (Feynman removal decision honored)
- `book/chapter-14.md` NOT modified
- No existing CC tasks modified (addendum written as separate file)
- Audit outputs written to `audits/`
- Calibration data written to `seldon/docs/design/`
