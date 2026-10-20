# Handoff: AI Workflow Design — Session 9

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Chapter 6: Parallel, Serial, and the Bottleneck — Designed and Drafted

Full design session followed by CC task and execution. Key design decisions:

- **Killed the "$15 vs $1,500" framing.** The $15 was API cost only (excluded engineering time); the $1,500 was fabricated (no actual bad pipeline to compare against). The framing anchored readers small and was dishonest about true costs. The Concept Mapper's ~$15 API cost remains as a data point where relevant, with honest caveats about engineering costs. Ch 14 owns full cost accounting.
- **New opening anchor: "Force multipliers don't care."** LLM tooling has accelerated the speed at which you can create messes by orders of magnitude. Parallelization, batching, scale — these amplify good design and bad design equally.
- **Model selection as engineering decision, not research project.** Three arguments: (1) simpler models earn their place by default (cheaper, faster, better rate limits); (2) bike-shedding over fractional accuracy differences costs more in engineering time than the model difference ever would; (3) if two models are close, ensemble them instead of testing further — you get disagreement detection and bias discovery for free.
- **Rate of model advancement makes extended comparison experiments obsolete.** Six months of testing produces conclusions about models that have already been superseded. Design for change, not for the current model. Swap-ready interfaces, versioned configs, architecture that absorbs model turnover.
- **Pike's Five Rules** applied to pipeline design (already in bib as `pike_1989`).
- **Design for scale from day one** — the "onesie-twosie" trap. Compounding loop from Factory.ai (no citable source; stated as principle without attribution).
- **Infrastructure reinvention problem** introduced briefly, handed to Ch 7 for solution.

**CC task:** `2026-03-30_draft_chapter_06.md` — **EXECUTED**

### Chapter 7: Checkpoints, Failures, and Recovery — Designed and Drafted

Design session built directly on Ch 6's bridge ("what happens when something fails at record 30,000?"). Key design decisions:

- **Config-driven architecture framed as "you already know this."** Reproducible research discipline — save the random seed, never hardcode. Extended to LLM-specific failure modes: training cutoff contamination, parameter shelf life (temperature removed in GPT-5 transition), silent failures from parameter mismatches.
- **Temperature as bias-variance tradeoff.** High temperature = more variance = creative leaps AND higher error rate. Type I / Type II error analogy for the statistical audience. One paragraph, not a deep dive.
- **Silent failure story.** Author experienced pipeline failures caused by AI coding assistant hardcoding parameters the target model didn't accept. API didn't throw hard error — silently misbehaved. Troubleshooting required working backwards. Motivates runtime parameter validation.
- **Progressive test infrastructure — TEVV operationalized.** Defined unit tests, smoke tests, regression tests for the non-software-engineering audience. Just enough to understand why it matters. Golden test set pattern for drift detection. NIST AI RMF TEVV connection (`nist_ai_rmf_2023`, already in bib).
- **Error classification:** transient (retry), permanent (escalate), data (log and continue). Idempotent operations.
- **Full checkpoint/recovery architecture** that Ch 6 scoped out — granularity, what to checkpoint, transaction-safe writes, resume logic.
- **Recursive stochasticity** — your dev tools are stochastic too. SWE-CI evidence (`chen_2026_sweci`, already in bib): 75% of frontier models break previously working features during maintenance. Brief treatment; Ch 11 owns the full meta-level discussion.
- **Thought experiment bridges directly to Ch 9** — 30% of classifications shifted but nothing in config/code/data changed. Sets up the SFV chapter.

**CC task:** `2026-03-30_draft_chapter_07.md` — **EXECUTED**

### Chapter 9: State, Drift, and Validity — Designed and Drafted

The SFV chapter. Designed to ride the momentum from Ch 7's thought experiment. Key design decisions:

- **SFV applied, not re-derived.** This chapter teaches practitioners how SFV applies to workflow design. The formal derivation lives in ai4stats Ch 20. Enough for practitioners to understand and apply; cites canonical source for full treatment.
- **All terminology locked to `seldon/ontology/validity/VALIDITY_VOCABULARY.md`.** Sub-dimensions (TC, SP, CF, SC, SCoh), threats (T1–T5), severity scale — all canonical. "Confabulation" not "hallucination" throughout (per NIST AI 600-1).
- **Opening: "The instrument that changes itself."** Classical measurement assumes instrument stability. LLM pipelines violate that assumption — the context window IS part of the instrument, and it mutates during use.
- **Section 4 is the book's connective tissue:** "Where prior chapters were already fighting SFV threats." Shows readers that config-driven architecture (Ch 7) addresses T1/T4, progressive testing (Ch 7) addresses T2/T3, ensembles (Ch 5) address T2, evaluation by design (Ch 8) addresses all threats, design for change (Ch 6) addresses T4. The reveal: "you've been building SFV countermeasures all along."
- **Deterministic retrieval as stochastic tax reduction** from Pragmatics paper (`webb_2026_pragmatics`). Pipeline fidelity 91.2% vs 74.6% RAG. SQLite lookups instead of embedding search. Design principle: don't use an LLM where a lookup table will do.
- **Personality problem from MCP lessons learned** feeds T2 (False State Injection) — system developing behavioral patterns not specified in any prompt or config.
- **Training cutoff as validity boundary.** The model's knowledge is frozen; everything after the cutoff is a massive, permanent T4 (State Supersession Failure). Config-driven architecture is the primary countermeasure.
- **Model selection drift** as validity concern — changing the model without re-evaluation is running a different instrument and claiming old validation applies.
- **Thought experiment:** Occupation coding pipeline, "Other" category grows from 3% to 12% after a "minor" model update. Realistic for federal statistical audience.

**CC task:** `2026-03-30_draft_chapter_09.md` — **EXECUTED**

---

## CC Tasks Written This Session (3 files)

1. `2026-03-30_draft_chapter_06.md` — **EXECUTED**
2. `2026-03-30_draft_chapter_07.md` — **EXECUTED**
3. `2026-03-30_draft_chapter_09.md` — **EXECUTED**

---

## Current State of the Repo

### Chapters Drafted
| Chapter | Status |
|---------|--------|
| Foreword | Drafted (Session 4), revised opening + Feynman quotes removed (Session 8) |
| Ch 1: Why Design Matters | Drafted, citations converted (Sessions 4–5) |
| Ch 2: Classification & Coding | Drafted (Session 6) |
| Ch 5: Ensemble & Multi-Model Playbook | Drafted (Session 7) |
| Ch 6: Parallel, Serial, Bottleneck | **Drafted (Session 9)** |
| Ch 7: Checkpoints, Failures, Recovery | **Drafted (Session 9)** |
| Ch 8: Evaluation by Design | Drafted (Session 7) |
| Ch 9: State, Drift, Validity | **Drafted (Session 9)** |
| Ch 12: Security & Supply Chain | Drafted (Session 5) |
| Ch 13: Institutional Deployment | Drafted (Session 5) |
| Ch 14: Cost & Practicality | Drafted (Session 6) |

### Chapters Not Yet Drafted
| Chapter | Design Material Available |
|---------|--------------------------|
| Ch 3: Data Cleaning & Imputation | Tian et al. (2025), deep research report in docs/ |
| Ch 4: Detection & Extraction | DiGiuseppe & Flynn (2026), Templ (2026) |
| Ch 10: State Mgmt & Provenance | Bone drop: Seldon origin story. Direct bridge from Ch 9. |
| Ch 11: Workflow Orchestration | Bone drop + Pragmatics MCP architecture + FCSM MCP reference + 90/10 rule + recursive stochasticity full treatment |

### CC Tasks on Disk
Previously executed (Sessions 1–8): 31 files
Executed this session: 3 files
**Total executed: 34**

---

## Key Design Decisions This Session

1. **"$15 vs $1,500" permanently retired.** No fabricated cost comparisons. Real numbers with honest caveats. Ch 14 owns cost accounting.
2. **Model selection bike-shedding identified as a trap.** If two models are close: ensemble, don't experiment. The engineering time spent comparing costs more than the difference.
3. **Rate of model advancement reframes pipeline design.** Design for change as steady state. Swap-ready interfaces. Versioned configs. The model is a replaceable component; the architecture is the durable investment.
4. **Config-driven architecture connected to reproducible research.** The audience already knows this from simulation work. LLM-specific extensions: training cutoff contamination, parameter shelf life, config as enforcement mechanism.
5. **Progressive test infrastructure scoped for the audience.** Unit tests, smoke tests, regression tests defined in plain language. Just enough for statisticians to understand and apply.
6. **SFV applied, not re-derived.** Ch 9 teaches application; ai4stats Ch 20 owns the formal framework. Terminology locked to canonical vocabulary.
7. **Ch 9 Section 4 is the book's connective tissue.** Shows how Ch 5–8 practices are SFV countermeasures — the retrospective reveal.

---

## New Citations Added (Session 9)

No new citations. All references used in Ch 6, Ch 7, and Ch 9 were already in `book/references.bib`:
- `pike_1989` (added Session 8 via Ch 6 CC task)
- `chen_2026_sweci` (added prior session)
- `nist_ai_rmf_2023` (added prior session)
- `webb_2026_ai4stats`, `webb_2026_pragmatics`, `webb_2025_opencensus_mcp` (added prior sessions)

**Citation verification audit backlog: 15 (unchanged from Session 7)**

---

## What's Next

### Immediate
1. **Pick next chapter to draft** — candidates by readiness:
   - **Ch 10 (State Mgmt & Provenance)** — direct bridge from Ch 9, Seldon origin story bone drop ready. Strongest momentum.
   - **Ch 11 (Workflow Orchestration)** — deepest material pile (MCP lessons, Pragmatics sidecar, FCSM MCP, 90/10 rule, recursive stochasticity full treatment from Ch 7)
   - **Ch 3 (Data Cleaning & Imputation)** — domain workflow chapter, has Tian et al. + deep research report. Needs design session.
   - **Ch 4 (Detection & Extraction)** — domain workflow chapter, has DiGiuseppe & Flynn, Templ. Needs design session.

### Review Backlog (growing — unchanged from Session 7, now with 3 more chapters)
- Ch 2 draft (Session 6)
- Ch 5 draft (Session 7)
- Ch 6 draft (Session 9)
- Ch 7 draft (Session 9)
- Ch 8 draft (Session 7)
- Ch 9 draft (Session 9)
- Ch 12 and Ch 13 drafts (Session 5)
- Foreword and Ch 1 drafts (Session 4)
- Open questions: Ch 5 (7 items), Ch 8 (7 items), Ch 14 (7 items)

### Citation Verification
- 15 citations still need verification (unchanged)

### Deferred
- Render fig-01-01 (PaperBanana)
- Enable GitHub Pages
- SFV preprint (SSRN)
- Confabulation terminology consistency check

---

## Session Notes

- **11 of 14 chapters drafted.** Remaining: 3, 4, 10, 11.
- **Three chapters drafted in one session** — Ch 6, 7, 9. The sequential momentum (Ch 6 → Ch 7 → Ch 9) produced tight cross-references and natural bridges.
- **Ch 6 → Ch 7 → Ch 9 forms a coherent arc:** pipeline mechanics → failure resilience → validity framework. Each chapter's thought experiment or bridge sets up the next.
- **Ch 9 Section 4 retrospectively connects Ch 5–8** as SFV countermeasures. This is the structural payoff of drafting the infrastructure chapters before the SFV chapter.
- **No new bib entries this session.** All citations were already present from prior sessions.
- Three CC tasks written and executed.
- No protocol violations this session.
