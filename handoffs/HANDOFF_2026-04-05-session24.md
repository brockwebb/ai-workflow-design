# Handoff: Session 24 -- New Citations, Security Source Review, Throughput Design, Seldon Bug

**Date:** 2026-04-05
**Session scope:** Paper intake (Shapira et al., EU education briefing, CSA security white paper), Ch 1 bottleneck shift CC task, security source acquisition CC task, Ch 6 throughput constraint CC task, Perplexity verification, Seldon cc_complete bug identification
**Projects touched:** ai-workflow-design (primary)

---

## What Was Done

### Paper Intake and Analysis

Three papers reviewed for applicability to the book:

1. **Shapira et al. (2026), "Agents of Chaos" (arXiv:2602.20021):** Red-teaming study of autonomous LLM agents. Directly applicable to Ch 1 (bottleneck shift argument), Ch 5 (multi-agent amplification), Ch 6 (autonomy-competence gap), Ch 7 (agentic confabulation as failure mode), Ch 8 (prompt injection as structural feature). CC task written for Ch 1 integration; cross-chapter citations deferred to respective AD-020 passes.

2. **Chounta (2026), EU Parliament Briefing "AI in Classrooms: Cognitive Dimensions" (PE 784.575):** Not directly citable (policy briefing about K-12 education), but yielded three usable cognitive science constructs: cognitive offloading vs. scaffolding, expertise reversal effect (Kalyuga et al., 2003), and metacognitive laziness (Fan et al., 2024). These were incorporated into the Ch 1 CC task as framing devices for why human-in-the-loop placement is a design decision with cognitive consequences.

3. **CSA/CAISI (2026), "The AI Agent Governance Gap" (AI-assisted white paper):** Not citable directly (AI-generated, not peer-reviewed), but identified five primary sources worth pulling. Led to the security source acquisition CC task.

### CC Tasks Written This Session

| CC Task | File | Status |
|---------|------|--------|
| Ch 1 bottleneck shift + new citations | `cc_tasks/2026-04-04_ch01_bottleneck_shift_and_new_citations.md` | Proposed |
| Ch 1 Perplexity verification addendum | `cc_tasks/2026-04-05_ch01_bottleneck_perplexity_addendum.md` | Proposed |
| Fetch + review agentic security sources | `cc_tasks/2026-04-05_fetch_and_review_agentic_security_sources.md` | **Completed** (by Claude Code) |
| Ch 6 throughput constraint insertion | `cc_tasks/2026-04-05_ch06_throughput_constraint_insertion.md` | Proposed |

### Perplexity Verification Results (Ch 1 Citations)

All four items verified:
- **Kalyuga et al. (2003):** Confirmed as written. Educational Psychologist, vol 38, issue 1, pp 23-31, DOI 10.1207/S15326985EP3801_4.
- **Fan et al. (2024):** Found. "Beware of Metacognitive Laziness." arXiv:2412.09315. Preprint, not yet peer-reviewed.
- **OECD Digital Education Outlook 2026:** Confirmed. Published Jan 19, 2026 by OECD. Caveat: "AI learning paradox" is commentary label, not OECD's own term.
- **Bastani et al. (2024):** Upgraded. Now published in PNAS, DOI 10.1073/pnas.2422633122. Title: "Generative AI Without Guardrails Can Harm Learning."

### Security Sources Review

Claude Code fetched and reviewed five documents. Full structured review at `docs/security_sources/review_summary.md`. Key synthesis:

1. Identity gap is the central unsolved problem (all five documents converge)
2. "External state change" is the governance boundary for agent vs. tool
3. Standards lag deployment by 12-24 months
4. Audit trails are the one governance primitive that works today

Material assessed as sufficient for an appendix on security posture for AI workflows. Decision deferred until remaining chapters complete AD-020 passes.

### Design Note: Token Throughput Constraint

Written at `docs/design_note_token_throughput_constraint.md`. Captures the throughput bottleneck ladder (tokens/sec > rate limits > cost), local vs. API tradeoff, and the insight that cost-per-token is not the right metric (cost-per-hour-of-human-attention is). Primary home: Ch 6. Cross-references: Ch 5 and Ch 14.

CC task written for Ch 6 insertion (`cc_tasks/2026-04-05_ch06_throughput_constraint_insertion.md`).

### Seldon cc_complete Bug Identified

**Bug:** `seldon_cc_complete` (MCP tool) detects existing artifacts by filepath and warns "already recorded as completed," but does NOT transition the graph state from `proposed` to `completed`. All executed CC tasks remain stuck in `proposed` state.

**Evidence:** 8 tasks show as `proposed` in graph despite being executed (audit outputs exist, chapter files modified). Calling `seldon_cc_complete` on them produces the warning but leaves state unchanged.

**Impact:** Graph state does not reflect reality. Session orientation sees 8 pending tasks that are actually done.

**Status:** Bug confirmed but not fixed. No Seldon issue written yet. The fix is in the `cc_complete` command logic: when it finds an existing artifact matching the filepath, it should update the state to `completed` rather than short-circuit with a duplicate warning.

---

## Confirmed Complete

| Item | Status |
|------|--------|
| Shapira et al. paper review | Done |
| EU education briefing review | Done |
| CSA security white paper review | Done |
| Perplexity verification (4 citations) | Done |
| Security sources fetch + review | Done (Claude Code) |
| Ch 1 CC task + addendum written | Done |
| Ch 6 CC task written | Done |
| Design note (throughput) written | Done |
| Seldon cc_complete bug identified | Identified, not fixed |

---

## Outstanding Items -- Execution Queue

### Immediate (run before Ch 9 AD-020):

| # | CC Task | Path | Priority |
|---|---------|------|----------|
| 1 | **Ch 6 throughput insertion** | `cc_tasks/2026-04-05_ch06_throughput_constraint_insertion.md` | **HIGH** -- blocking Ch 9 |
| 2 | **Ch 1 bottleneck shift** (read addendum first) | `cc_tasks/2026-04-04_ch01_bottleneck_shift_and_new_citations.md` | **HIGH** |
| 3 | **Ch 1 Perplexity addendum** | `cc_tasks/2026-04-05_ch01_bottleneck_perplexity_addendum.md` | HIGH (read with #2) |

### Carried forward from Session 23:

| # | CC Task | Path | Priority |
|---|---------|------|----------|
| 4 | Ch 8 revision + $1,500 purge | `cc_tasks/2026-04-04_ch08_revision_and_cost_purge.md` | HIGH -- may already be executed, verify |
| 5 | Batch figure render + insertion | `cc_tasks/2026-04-03_batch_figure_render_and_insertion.md` | HIGH -- Ch 7 build break |
| 6 | Figure addendum (tables) | `cc_tasks/2026-04-03_batch_figure_render_addendum_tables.md` | HIGH -- read with #5 |

### After queue clears:

| Item | Priority | Notes |
|------|----------|-------|
| **Ch 9 AD-020 pipeline run** | **Next** | Calibration run 007 |
| Em-dash purge + `\$` escaping (foreword-Ch 2) | Medium | Session 17 leftover |
| Ch 3 prose fixes (Session 17) | Medium | Verify what's still outstanding |
| Seldon cc_complete bug fix | Medium | Write issue, fix command logic |
| Security appendix decision | Low | After remaining AD-020 passes |
| arXiv:2502.01534 metadata verification | Low | Carried from Session 17 |

---

## Key Design Decisions

1. **Throughput constraint goes in Ch 6, not Ch 14.** Ch 6 is the pipeline engineering chapter. The throughput ladder (tokens/sec > rate limits > cost) and local/API tradeoff are engineering decisions, not economic analysis. Ch 5 and Ch 14 get brief cross-reference pointers.

2. **Shapira et al. earns citations in at least 3 chapters.** Ch 1 (bottleneck shift, via CC task), plus Ch 5, 7, 8 during their respective AD-020 passes. The "autonomy-competence gap" and "agentic confabulation" constructs are too useful to cite only once.

3. **Cognitive science constructs cited through original sources, not EU briefing.** Kalyuga (2003) for expertise reversal, Fan (2024) for metacognitive laziness, Bastani (2024, PNAS) for the performance/learning divergence. The EU briefing was the pointer; the book cites the science.

4. **Security material warrants an appendix, not a chapter.** The book is not a security book. The audience needs enough shared vocabulary to have a productive CISO conversation, framed as "mission enablement" rather than compliance. OWASP ASI taxonomy + NCCoE six focus areas + "external state change" boundary is the right scope.

5. **"AI learning paradox" is not attributed to OECD.** Perplexity confirmed it's a commentary label, not OECD's term. The phenomenon (improved task performance + reduced actual learning) is described and cited; the catchy label is not used as if the OECD coined it.

---

## Nothing Modified Outside Scope

- No chapter files edited directly by this session
- No existing CC tasks modified (addendum written for Ch 1 task)
- No Seldon code changes
- Security source files written to `docs/security_sources/` by Claude Code
- Design note written to `docs/`
