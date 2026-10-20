# Handoff: AI Workflow Design — Session 7

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Chapter 5 Designed and CC Task Written

Full design session for Ch 5 (The Ensemble & Multi-Model Playbook). Addressed the "one-dimensionality" problem — the Concept Mapper and Pragmatics share similar pipeline shapes, so Ch 5 needed genuinely different topologies to avoid being "Ch 2 but abstract."

**Three topologies designed:**

1. **Parallel consensus** (Section 5.2) — brief abstraction from Ch 2, not re-taught. ABBA counterbalancing, constrained model pool for federal context, inter-rater reliability as native evaluation.
2. **Generator-critic loops** (Section 5.3) — Madaan et al. (2023) Self-Refine as canonical reference, six existing degradation citations as counterweight, cross-model variant as the robust design for statistical production. Key design question: termination conditions (diminishing returns after 2–3 rounds).
3. **LLM-as-Judge / arbiter** (Section 5.4) — Gu et al. (2024) and Li et al. (2024) surveys, preference leakage (Li, D. et al., 2024) as key design trap, rubric design as practitioner skill.

**Counterexample:** TWIX (Lin et al., 2025) — Berkeley structured extraction tool, 520x faster and 3,786x cheaper than GPT-4V by exploiting document structure. Used in Section 5.5 as "when the answer is none of the above."

**Design decision framework** in Section 5.5: when to use which topology, and when not to use multi-model at all.

**CC task:** `2026-03-29_chapter_05_draft.md` — **EXECUTED**

### Chapter 8 Designed and CC Task Written

Full design session for Ch 8 (Evaluation by Design). The crosswalk paper (`webb_2026_fcsm_nist_crosswalk.pdf`) is the chapter's spine — not just a reference but the structural framework.

**Key sections:**
- **8.1** — RLI 2.5% stat as the "benchmark illusion" opening hook
- **8.2** — FCSM × NIST crosswalk as evaluation scaffolding (five mapping types)
- **8.3** — "Valid & Reliable is a gate, not a dial" — confabulation detection as the specification gap
- **8.4** — Building golden test sets, regression testing, multi-model agreement as evaluation
- **8.5** — Tailored crosswalks from both implementations (batch vs. real-time produce different emphasis patterns)
- **8.6** — Continuous evaluation via SWE-CI (75% regression rate cautionary tale)
- **8.7** — Evaluation economics ($15 and $100 pipeline evaluations)
- **8.8** — Honest limits of evaluation
- **8.9** — Thought experiment: annual quality review
- **8.10** — Bridge to Ch 9 (SFV)

**CC task:** `2026-03-29_chapter_08_draft.md` — **EXECUTED**

### YouTube Research Material Routed

Two YouTube video summaries (ingested via LeStat pipeline) were analyzed. Primary sources traced, YouTube commentary discarded. Three citable primary sources found:

1. **Mazeika et al. (2025), Remote Labor Index** — Scale AI + CAIS, 240 Upwork projects, 2.5% agent completion. → Ch 1, Ch 8
2. **Pike (1989), Notes on Programming in C** — Five rules of programming. → Ch 6
3. **Chen et al. (2026), SWE-CI** — Alibaba, 75% of models break working code during maintenance. → Ch 7, Ch 9

Additional material routed without external citation (author experience or practitioner insight): "evals are the job" → Ch 8; "document decisions not outcomes" → Ch 10; specification discipline → Ch 13; Factory.ai compounding loop → Ch 6 or Ch 13.

Design note written: `docs/2026-03-29_youtube_research_routing.md`

**CC task:** `2026-03-29_register_youtube_research_routing.md` — **EXECUTED**

### Deep Research Report Ingested

ChatGPT Deep Research returned eight peer-reviewed or preprint citations. All ingested as BibTeX entries and routed to target chapters:

| Citation | Key | Target Chapter | Strength |
|----------|-----|---------------|----------|
| Tian et al. (2025) — LLM vs MICE/KNN imputation | `tian_2025` | Ch 3 | Strong |
| DiGiuseppe & Flynn (2026) — LLM pairwise scaling, POQ | `digiuseppe_2026` | Ch 4 | Strong |
| Templ (2026) — sdcMicro AI disclosure control | `templ_2026` | Ch 4 | Strong |
| Fagerberg et al. (2025) — dual-model systematic review | `fagerberg_2025` | Ch 5 | Moderate |
| Kamen & Kamen (2025) — majority vote ensemble | `kamen_2025` | Ch 5 | Moderate |
| Liu et al. (2025) — SE-Jury ensemble judge | `liu_2025_sejury` | Ch 5 | Marginal |
| Tam et al. (2024) — QUEST healthcare eval framework | `tam_2024` | Ch 8 | Moderate |
| Azanza et al. (2025) — continuous LLM evaluation CI/CD | `azanza_2025` | Ch 8 | Strong |

**CC task:** `2026-03-29_ingest_deep_research_report.md` — **EXECUTED**

### Ch 6 Design Note Updated

The existing bone drop for Ch 6 was extended with Rob Pike's five rules (mapped to pipeline engineering) and the "design for scale from day one" principle (Concept Mapper designed for N, not for 7,000).

Updated via CC task `2026-03-29_register_youtube_research_routing.md` (Task 3).

---

## CC Tasks Written This Session (4 files)

1. `2026-03-29_chapter_05_draft.md` — **EXECUTED**
2. `2026-03-29_chapter_08_draft.md` — **EXECUTED**
3. `2026-03-29_register_youtube_research_routing.md` — **EXECUTED**
4. `2026-03-29_ingest_deep_research_report.md` — **EXECUTED**

---

## Current State of the Repo

### Chapters Drafted
| Chapter | Status |
|---------|--------|
| Foreword | Drafted (Session 4) |
| Ch 1: Why Design Matters | Drafted, citations converted (Sessions 4–5) |
| Ch 2: Classification & Coding | Drafted (Session 6) |
| Ch 5: Ensemble & Multi-Model Playbook | Drafted (Session 7) |
| Ch 8: Evaluation by Design | Drafted (Session 7) |
| Ch 12: Security & Supply Chain | Drafted (Session 5) |
| Ch 13: Institutional Deployment | Drafted (Session 5) |
| Ch 14: Cost & Practicality | Drafted (Session 6) |

### Chapters Not Yet Drafted
| Chapter | Design Material Available |
|---------|--------------------------|
| Ch 3: Data Cleaning & Imputation | Deep Research citation: Tian et al. (2025) — LLM vs MICE/KNN |
| Ch 4: Detection & Extraction | Deep Research citations: DiGiuseppe & Flynn (2026), Templ (2026) |
| Ch 6: Parallel, Serial, Bottleneck | Bone drop + Pike rules + scale design (Sessions 6–7) |
| Ch 7: Checkpoints & Recovery | Bone drop (Session 6) + SWE-CI routing (Session 7) |
| Ch 9: State, Drift, Validity | SFV chapter — benefits from more domain chapters first |
| Ch 10: State Mgmt & Provenance | Bone drop: Seldon origin story (Session 6) |
| Ch 11: Workflow Orchestration | Bone drop: AI partner stochasticity (Session 6) |

### Design Notes in `docs/`
| File | Target | Session |
|------|--------|---------|
| `2026-03-29_bone_drop_ch06_parallelization.md` | Ch 6 | 6, updated 7 |
| `2026-03-29_bone_drop_ch07_ch11_ai_partner_stochasticity.md` | Ch 7 & 11 | 6 |
| `2026-03-29_bone_drop_ch10_seldon_origin.md` | Ch 10 | 6 |
| `2026-03-29_bone_drop_ch13_shadow_it.md` | Ch 13 | 6 |
| `2026-03-29_youtube_research_routing.md` | Multi-chapter | 7 |
| `deep-research-report-chapt3.md` | Chs 3, 4, 5, 8 | 7 |

### CC Tasks on Disk
Previously executed (Sessions 1–6): 25 files
Executed this session: 4 files
**Total executed: 29**

---

## New Citations Added (Session 7)

### Added via Ch 5 CC task:
| Key | Citation | Status |
|-----|----------|--------|
| `gu_2024` | Gu, J., et al. (2024). A Survey on LLM-as-a-Judge. arXiv:2411.15594. | To be verified |
| `li_h_2024` | Li, H., et al. (2024). LLMs-as-Judges. arXiv:2412.05579. | To be verified |
| `li_d_2024` | Li, D., et al. (2024). From Generation to Judgment. arXiv:2411.16594. | To be verified |
| `wang_2022` | Wang, X., et al. (2022). Self-Consistency Improves Chain of Thought. arXiv:2203.11171. | To be verified |
| `lin_2025` | Lin, Y., et al. (2025). TWIX: Structured Data from Templatized Documents. PACMMOD. | To be verified |

### Added via YouTube routing CC task:
| Key | Citation | Status |
|-----|----------|--------|
| `mazeika_2025` | Mazeika, M., et al. (2025). Remote Labor Index. arXiv:2510.26787. | To be verified |
| `pike_1989` | Pike, R. (1989). Notes on Programming in C. Bell Labs. | Verified (primary source located) |
| `chen_2026_sweci` | Chen, J., et al. (2026). SWE-CI. arXiv:2603.03823. | To be verified |

### Added via Deep Research ingest CC task:
| Key | Citation | Status |
|-----|----------|--------|
| `tian_2025` | Tian, W., et al. (2025). LLM vs Traditional Imputation. AAPOR 2025. | To be verified |
| `digiuseppe_2026` | DiGiuseppe, M. & Flynn, M. (2026). LLM-Paired Comparisons. POQ. | To be verified |
| `templ_2026` | Templ, M. (2026). AI-Assisted SDC with sdcMicro. R Foundation. | To be verified |
| `fagerberg_2025` | Fagerberg, P., et al. (2025). Dual-Model LLM Ensemble. medRxiv. | To be verified |
| `kamen_2025` | Kamen, A. & Kamen, Y. (2025). Majority Rules: LLM Ensemble. arXiv. | To be verified |
| `liu_2025_sejury` | Liu, X., et al. (2025). SE-Jury Ensemble Judge. arXiv. | To be verified |
| `tam_2024` | Tam, T., et al. (2024). QUEST Framework. NPJ Digital Medicine, 7, 258. | To be verified |
| `azanza_2025` | Azanza, M., et al. (2025). Continuous LLM Evaluation. EASE 2025. | To be verified |

**Total new citations this session: 16**
**Citation verification audit backlog: 15 (all except Pike 1989)**

---

## What's Next

### Immediate
1. **Review Ch 5 draft** — read, react, revision pass
2. **Review Ch 8 draft** — read, react, revision pass
3. **Review Ch 2 draft** — from Session 6, not yet reviewed
4. **Review Ch 12 and Ch 13 drafts** — from Session 5, not yet reviewed
5. **Review foreword and Ch 1 drafts** — from Session 4, not yet reviewed
6. **Answer Ch 14 open questions** — 7 items flagged in the CC task (Session 6)
7. **Answer Ch 5 open questions** — 7 items flagged
8. **Answer Ch 8 open questions** — 7 items flagged

### Chapter Drafting Priority
- **Ch 6 (Parallel, Serial, Bottleneck)** — most design material available (bone drop + Pike + scale). Concept Mapper–heavy but Pike rules diversify it.
- **Ch 3 (Data Cleaning & Imputation)** — now has Tian et al. as a case study anchor. Design session needed.
- **Ch 4 (Detection & Extraction)** — now has DiGiuseppe & Flynn + Templ as case studies. Design session needed.
- **Ch 7 (Checkpoints & Recovery)** — bone drop + SWE-CI. Has material for design.
- **Ch 9 (State, Drift, Validity)** — SFV chapter. Benefits from more domain chapters existing first.
- **Ch 10 (State Mgmt & Provenance)** — bone drop: Seldon origin story. Ready when prioritized.
- **Ch 11 (Workflow Orchestration)** — bone drop: AI partner stochasticity. Ready when prioritized.

### Citation Verification
- 15 citations need verification (Perplexity, arXiv, or direct source check)
- Recommend: batch verification session — knock them all out at once

### Deferred
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Remaining open questions from Sessions 3–6
- Confabulation terminology consistency check across chapters (Ch 8 uses "confabulation" per NIST AI 600-1; other chapters may use "hallucination")

---

## Session Notes

- **8 of 14 chapters now drafted** (Foreword + Chs 1, 2, 5, 8, 12, 13, 14). Remaining: Chs 3, 4, 6, 7, 9, 10, 11.
- **Design material now exists for every remaining chapter** — some thin (Ch 3, Ch 4 before Deep Research), some rich (Ch 6, Ch 7, Ch 10).
- Deep Research closed the biggest gap: Chs 3 and 4 now have citable primary sources from real survey/statistics contexts.
- The crosswalk paper proved more central than anticipated — it's not just a Ch 8 reference but the evaluation framework the entire book's pipelines are assessed against.
- No protocol violations this session.
- All workflow rules from previous sessions remain in effect.
