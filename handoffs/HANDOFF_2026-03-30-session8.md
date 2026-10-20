# Handoff: AI Workflow Design — Session 8

**Date:** 2026-03-30
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`

---

## What Happened This Session

### Pragmatics Paper, MCP Lessons Learned, and FCSM 25-03 Registered

Full extraction and assessment of the Pragmatics paper (Webb, 2026), the OpenCensus MCP lessons learned doc (Webb, 2025), and FCSM 25-03 (Hoppe et al., 2025). All three registered with BibTeX entries and chapter routing.

**Pragmatics paper** routed to 11 chapter placements across Ch 1, 5, 8, 9, 11, 14. Key contributions to the book: selectivity beats volume (36 items > 311 chunks), semantic smearing as named anti-pattern, three-stage eval pipeline as Ch 8 worked example, deterministic retrieval as stochastic tax reduction (Ch 9/SFV), sidecar MCP architecture (Ch 11), cost-effectiveness analysis (Ch 14). DOI: 10.5281/zenodo.18913092.

**MCP lessons learned** routed to Ch 1, 5, 8, 9, 11. Key contributions: "execution becomes cheaper so planning becomes more critical" (Ch 1 thesis), semantic smearing origin story, teacher salary failure case (Ch 8), personality problem (Ch 9), MCP platform maturity assessment (Ch 11), 90/10 rule (Ch 11).

**FCSM 25-03** routed to Ch 8 and Ch 11. FCSM extending their Data Quality Framework for AI/LLM data consumption. Explicitly names MCP as integration protocol. Complements the Pragmatics paper — FCSM poses the question, Pragmatics answers it.

**Narrative arc established:** MCP lessons (summer 2025) → Pragmatics paper (March 2026) → FCSM 25-03 (May 2025, independent recognition of same gap). The book now has two primary case studies: Federal Survey Concept Mapper (batch classification) and Pragmatics/OpenCensus MCP (consultation pipeline). Different architectures, different problem shapes, different maturity stages.

**CC task:** `2026-03-29_register_pragmatics_mcp_fcsm.md` — **EXECUTED**

### Foreword Revision

Reviewed the full foreword. Identified three problems: opens with a Feynman quote (appeal to authority as the first thing readers see), makes unsupported claims about what "most people" can or cannot do, and over-relies on Feynman (three quotes total in one foreword).

Designed a new opening section ("A New Design Space") grounded in what the author actually observes: LLMs have opened a genuinely new design space, tools let you dig holes fast (prototype in days not months), the gap between prototype and production hasn't gone away, these systems break conventions from every other tool. No group name-dropping, no unsupported capability claims, no appeals to authority.

All three Feynman quotes removed. The underlying ideas (understanding vs. naming, self-deception risk, challenge authority) preserved as principles stated directly without attribution.

**CC task:** `2026-03-30_foreword_revision.md` — **EXECUTED**

### Seven Documents Reviewed; Six Dropped, One (MITRE) Also Dropped

Reviewed seven documents total. Six CDC/HHS documents assessed as low value for direct citation:

1. CDC Considerations for Agentic Research in Public Health (2026) — practical but surface-level
2. CDC Considerations for Generative AI in Public Health (2026) — STLT adoption patterns, 41K hours stat
3. HHS AI Strategy (2025) — aspirational OneHHS framing, five pillars
4. HHS AI Use Case Inventory FY25 (CSV) — 447 use cases, 167 deployed, only 2 "high-impact," heavy on admin/chatbots
5. CDC PHDS: Using AI for Public Health Efficiency (2025) — TowerScout, Clinical Narratives, NewsScape
6. MITRE LLM Attacks guide — derivative training module summarizing OWASP LLM Top 10 + MITRE ATLAS case studies. If Ch 12 needs OWASP/ATLAS, cite the primaries directly.

**Decision rationale:** The CDC/HHS material is compliance-driven inventory and adoption guidance, not architectural or empirical. The book's audience is practitioners building systems, not agencies reporting on them. The HHS inventory's most useful data point is "447 use cases, 2 high-impact" as a one-liner for Ch 1 or Ch 14, but not worth a formal citation.

These are documented in the design note (`docs/2026-03-29_pragmatics_mcp_fcsm_routing.md`) for potential revisit if specific chapters need federal landscape context.

### Context Assessment

Session was exploration-heavy. Seven documents extracted and read; only three earned registration (Pragmatics, MCP lessons learned, FCSM 25-03). The edge pieces are now clear: the book's case study architecture is settled (Concept Mapper + Pragmatics), FCSM 25-03 is positioned as supporting context, and the CDC/HHS/MITRE material is explicitly out of scope unless a chapter specifically needs it. Foreword opening revised to remove unsupported claims and authority appeals.

---

## CC Tasks Written This Session (2 files)

1. `2026-03-29_register_pragmatics_mcp_fcsm.md` — **EXECUTED**
2. `2026-03-30_foreword_revision.md` — **EXECUTED**

---

## Current State of the Repo

### Chapters Drafted
| Chapter | Status |
|---------|--------|
| Foreword | Drafted (Session 4), revised opening + Feynman quotes removed (Session 8) |
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
| Ch 3: Data Cleaning & Imputation | Tian et al. (2025) |
| Ch 4: Detection & Extraction | DiGiuseppe & Flynn (2026), Templ (2026) |
| Ch 6: Parallel, Serial, Bottleneck | Bone drop + Pike rules + scale design |
| Ch 7: Checkpoints & Recovery | Bone drop + SWE-CI |
| Ch 9: State, Drift, Validity | SFV chapter — Pragmatics fidelity + personality problem now routed |
| Ch 10: State Mgmt & Provenance | Bone drop: Seldon origin story |
| Ch 11: Workflow Orchestration | Bone drop + Pragmatics MCP architecture + FCSM MCP reference + 90/10 rule |

### CC Tasks on Disk
Previously executed (Sessions 1–7): 29 files
Executed this session: 2 files
**Total executed: 31**

---

## New Citations Added (Session 8)

| Key | Citation | Status |
|-----|----------|--------|
| `webb_2026_pragmatics` | Webb, B. (2026). Pragmatics: Delivering Expert Judgment to AI Systems. Zenodo. DOI: 10.5281/zenodo.18913092 | Verified (author's own) |
| `webb_2025_opencensus_mcp` | Webb, B. (2025). Open Census MCP Server: Lessons Learned. GitHub. | Verified (author's own) |
| `fcsm_2025_aiready` | Hoppe, T., Gonzalez, J., Mirel, L., & Schmitt, R. (2025). AI-Ready Federal Statistical Data. FCSM 25-03. | Verified (primary source read) |

**Total new citations this session: 3**
**Citation verification audit backlog: 15 (unchanged from Session 7)**

---

## What's Next

### Immediate
1. **Pick next chapter to draft** — candidates by readiness:
   - **Ch 6 (Parallel, Serial, Bottleneck)** — richest design material (bone drop + Pike rules + scale design)
   - **Ch 11 (Workflow Orchestration)** — now has substantial material (MCP lessons, Pragmatics sidecar architecture, FCSM MCP reference, 90/10 rule, bone drop)
   - **Ch 7 (Checkpoints & Recovery)** — bone drop + SWE-CI
   - **Ch 9 (State, Drift, Validity)** — SFV chapter, now has Pragmatics fidelity + personality problem routed; benefits from more domain chapters first
   - **Ch 3 or Ch 4** — domain workflow chapters, design sessions needed

### Review Backlog (unchanged from Session 7)
- Ch 2 draft (Session 6)
- Ch 5 draft (Session 7)
- Ch 8 draft (Session 7)
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

- **8 of 14 chapters drafted** (unchanged). Remaining: 3, 4, 6, 7, 9, 10, 11.
- **Two primary case studies now formally established:** Federal Survey Concept Mapper (batch classification, Ch 2 anchor) and Pragmatics/OpenCensus MCP (consultation pipeline, feeds Ch 5, 8, 9, 11, 14).
- **Ch 11 substantially enriched** — was the thinnest remaining chapter; now has MCP lessons, Pragmatics sidecar, FCSM MCP reference, 90/10 rule, and bone drop material.
- **Foreword revised** — new opening section, all Feynman quotes removed, unsupported claims cut.
- Seven documents reviewed; three registered, four dropped with rationale documented.
- Two CC tasks written and executed.
- No protocol violations this session.
