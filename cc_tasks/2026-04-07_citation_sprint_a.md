# CC Task: Citation Sprint A -- BibTeX Entries and Citation Insertions

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` Section 2B; Perplexity verification batches PQ-A through PQ-G (author-provided April 7, 2026); independent web verification of CG-X3 and CG-X4
**Scope:** Add new BibTeX entries to references.bib; insert citation markup into chapters; replace vague prose with verified figures. No structural changes, no new paragraphs.

---

## Part 1: New BibTeX Entries

**File:** `book/references.bib`

All entries must be inserted in alphabetical order by key. Existing entries must not be modified except where explicitly noted.

### 1A. New entries to ADD (alphabetical)

```bibtex
@article{brodeur_2025_ssrp,
  author    = {Brodeur, Abel and others},
  title     = {Assessing Reproducibility in Economics Using Standardized Crowd-sourced Analysis},
  journal   = {NBER Working Paper No. 33753},
  year      = {2025},
  url       = {https://www.nber.org/system/files/working_papers/w33753/w33753.pdf},
  note      = {487 reproductions via Social Science Reproduction Platform. ~30\% meet basic computational reproducibility standard.}
}
```
Insert between `brodeur_2026` and `bucknerPetty_2019`.

```bibtex
@inproceedings{chroma_2024_chunking,
  author    = {{Chroma}},
  title     = {Evaluating Chunking Strategies for Retrieval},
  year      = {2024},
  url       = {https://www.trychroma.com/research/evaluating-chunking},
  note      = {Chunking choice significantly impacts retrieval accuracy. Default settings for common strategies can perform poorly.}
}
```
Insert between `chen_2026_sweci` and `dell_acqua_2023`.

```bibtex
@misc{fedramp_20x_2025,
  author       = {{General Services Administration}},
  title        = {{GSA} Announces {FedRAMP} 20x},
  year         = {2025},
  url          = {https://www.gsa.gov/about-us/newsroom/news-releases/gsa-announces-fedramp-20x-03242025},
  note         = {March 24, 2025. GSA-led FedRAMP modernization backed by OMB M-24-15. Goals: automate 80\%+ of security requirements, shrink authorization to weeks instead of months/years.}
}
```
Insert between `fcsm_2025_aiready` and `fellegi_1976`.

```bibtex
@misc{gotel_1994,
  author       = {Gotel, Orlena C. Z. and Finkelstein, Anthony C. W.},
  title        = {An Analysis of the Requirements Traceability Problem},
  year         = {1994},
  booktitle    = {Proceedings of the 1st International Conference on Requirements Engineering},
  pages        = {94--101},
  note         = {Canonical academic reference on requirements traceability. Defines the traceability problem and its pre/post-requirements dimensions.}
}
```
Insert between `gama_2014` and `groves_2009`.

```bibtex
@article{landis_1977,
  author    = {Landis, J. Richard and Koch, Gary G.},
  title     = {The Measurement of Observer Agreement for Categorical Data},
  journal   = {Biometrics},
  volume    = {33},
  number    = {1},
  pages     = {159--174},
  year      = {1977},
  note      = {Standard kappa interpretation scale: poor (<0.00), slight (0.00--0.20), fair (0.21--0.40), moderate (0.41--0.60), substantial (0.61--0.80), almost perfect (0.81--1.00).}
}
```
Insert between `knoxsystems_fedramp_2026` and `lee_2025`.

```bibtex
@inproceedings{li_2023_order_sensitivity,
  author    = {Li, Peiwen and Chen, Tao and others},
  title     = {Large Language Models Sensitivity to the Order of Options in Multiple-Choice Questions},
  year      = {2023},
  journal   = {arXiv preprint arXiv:2308.11483},
  url       = {https://arxiv.org/abs/2308.11483},
  note      = {Systematic study of GPT-3.5/4 on MCQ benchmarks. Permuting answer options changes accuracy and choice distributions substantially. Position bias interacts with model uncertainty.}
}
```
Insert between `lee_2026_metaharness` and `li_d_2024`.

```bibtex
@article{liu_2024_chatgpt_behavior,
  author    = {Liu, Lingjiao and Ren, Zhitao and others},
  title     = {How Is {ChatGPT}'s Behavior Changing over Time?},
  journal   = {Harvard Data Science Review},
  year      = {2024},
  url       = {https://hdsr.mitpress.mit.edu/pub/y95zitmz},
  note      = {GPT-4 prime-number accuracy dropped from 97.6\% to 2.4\% between March and June 2023. Large shifts in safety refusal rates and response lengths. Backend updates opaque to users. Originally arXiv:2307.09009 (2023).}
}
```
Insert between `lin_2025` and `liu_2025_sejury`.

```bibtex
@misc{morris_2025_verasight,
  author       = {Morris, David},
  title        = {The Risks of Using {LLM} Imputation of Survey Data to Produce ``Synthetic Samples''},
  year         = {2025},
  institution  = {Verasight},
  url          = {https://www.verasight.io/reports/synthetic-sampling-2},
  note         = {LLM-generated survey data: topline error ~4pp on polarized questions, but mean absolute subgroup error >10 percentage points vs real crosstabs. Chain-of-thought and anchors did not reliably fix population totals.}
}
```
Insert between `mitre_aida_timelines` and `nccoe_agent_identity_2026`.

```bibtex
@inproceedings{ouyang_2025_nondeterminism,
  author    = {Ouyang, Siyuan and others},
  title     = {Non-Determinism of ``Deterministic'' {LLM} System Settings in Hosted {LLMs}},
  booktitle = {Eval4NLP 2025},
  year      = {2025},
  url       = {https://aclanthology.org/2025.eval4nlp-1.12.pdf},
  note      = {Systematic study: GPT, Llama, Mixtral families show substantial variance across 10 runs at temperature=0. Causes: FP non-determinism, batching effects, infrastructure differences, provider-side changes.}
}
```
Insert between `owasp_agentic_top10_2026` and `pan_2024`.

```bibtex
@inproceedings{song_2025_correlated_errors,
  author    = {Song, Zhi and others},
  title     = {Correlated Errors in Large Language Models},
  booktitle = {ICML 2025},
  year      = {2025},
  url       = {https://icml.cc/virtual/2025/poster/44225},
  note      = {Models agree 60\% of the time when both err. Shared providers drive correlation. Larger/more accurate models have highly correlated errors even across vendors.}
}
```
Insert between `simmhan_2005` and `tada_vldb_2024`.

### 1B. Existing entry to MODIFY

**`lee_2026_metaharness`**: Remove `PERPLEXITY: verify before publication.` from the `note` field. Paper independently verified via arXiv 2603.28052 (March 30, 2026). Keep all other note content.

---

## Part 2: Citation Insertions and Prose Fixes

### 2A. Ch 1 -- temperature=0 non-determinism (CG-R1)

**File:** `book/chapter-01.md`
**Location:** Line ~18, the sentence: `*LLM stochastic processes* are irreproducible across runs (even at temperature=0 on many APIs)`

**Find:** `irreproducible across runs (even at temperature=0 on many APIs)`

**Replace with:** `irreproducible across runs (even at temperature=0 on many APIs, as systematic studies have confirmed {cite:p}\`ouyang_2025_nondeterminism\`)`

### 2B. Ch 2 -- Landis-Koch kappa scale (CG-S1)

**File:** `book/chapter-02.md`
**Action:** Find the first use of the Landis-Koch interpretation labels (substantial, almost perfect, etc.) and add `{cite:p}\`landis_1977\`` after it. If no explicit Landis-Koch phrasing exists, locate the passage where kappa agreement is interpreted qualitatively and add the citation there.

**Search for:** any of "substantial agreement", "almost perfect", "Landis", "interpretation scale" in chapter-02.md. Add `{cite:p}\`landis_1977\`` parenthetically at the appropriate location.

### 2C. Ch 2 -- Position bias / ABBA design (CG-R3)

**File:** `book/chapter-02.md`
**Action:** Find the passage describing the ABBA counterbalancing design and why option order matters. Add `{cite:p}\`li_2023_order_sensitivity\`` to ground the position bias claim.

**Search for:** "ABBA" or "counterbalancing" or "position bias" or "order effect" in chapter-02.md. Add citation after the relevant claim about why randomized presentation order matters.

### 2D. Ch 3 -- 10-percentage-point subgroup error (CG-X4)

**File:** `book/chapter-03.md`
**Location:** Line ~115, the sentence containing "with mean absolute subgroup errors exceeding 10 percentage points in one study"

**Find:** `in one study`

**Replace with:** `{cite:p}\`morris_2025_verasight\``

### 2E. Ch 4 -- Chunking affects extraction quality (CG-T5)

**File:** `book/chapter-04.md`
**Action:** Find the passage discussing chunking strategy and extraction quality (likely in the knowledge graph / extraction section). Add `{cite:p}\`chroma_2024_chunking\`` to ground the claim.

**Search for:** "chunking" or "chunk" in chapter-04.md. Add citation after the first substantive claim about how chunking strategy affects extraction or retrieval quality.

### 2F. Ch 5 -- Cross-vendor independence (CG-M1/M2)

**File:** `book/chapter-05.md`
**Action:** Find the passage claiming that same-vendor models share training pipelines and cross-vendor provides more independence. Add `{cite:p}\`song_2025_correlated_errors\`` and qualify the independence claim.

**Search for:** "independence" or "same vendor" or "cross-vendor" or "training pipeline" in chapter-05.md. At the relevant claim, add citation. If the text implies full independence from cross-vendor, soften to "partial diversity" -- e.g., change "independent" to "more diverse, though still substantially correlated on hard cases {cite:p}\`song_2025_correlated_errors\`"

### 2G. Ch 8 -- Silent model updates (CG-R2)

**File:** `book/chapter-08.md`
**Location:** Line ~93, sentence: `Model providers push silent updates.`

**Find:** `Model providers push silent updates.`

**Replace with:** `Model providers push silent updates {cite:p}\`liu_2024_chatgpt_behavior\`.`

### 2H. Ch 9 -- Silent model updates (CG-R2, consistent with Ch 8)

**File:** `book/chapter-09.md`
**Location:** Line ~141, sentence containing "silent baseline updates"

**Find:** `may have degraded through silent baseline updates`

**Replace with:** `may have degraded through silent baseline updates {cite:p}\`liu_2024_chatgpt_behavior\``

### 2I. Ch 10 -- SCORE precise figures (CG-P2)

**File:** `book/chapter-10.md`
**Location:** Line ~21, the sentence: `the majority of papers lacked sufficient documentation to even attempt reproduction, and of those that could be attempted, only about half reproduced exactly`

**Find:** `the majority of papers lacked sufficient documentation to even attempt reproduction, and of those that could be attempted, only about half reproduced exactly`

**Replace with:** `only 24\% of 600 papers had sufficient data to attempt reproduction, and of the 143 where reproduction was attempted, 74\% reproduced approximately but only 54\% reproduced precisely`

### 2J. Ch 10 -- Brodeur precise figure (CG-P3)

**File:** `book/chapter-10.md`
**Location:** Line ~21, same paragraph. The sentence: `Research published under stronger data and code sharing norms showed substantially higher reproducibility rates`

**Find:** `Research published under stronger data and code sharing norms showed substantially higher reproducibility rates`

**Replace with:** `In economics, only about 30\% of recent studies meet even a basic computational reproducibility standard {cite:p}\`brodeur_2025_ssrp\`; research published under stronger data and code sharing norms showed substantially higher reproducibility rates`

### 2K. Ch 10 -- IBM DOORS citation (CG-P1)

**File:** `book/chapter-10.md`
**Action:** Find the passage mentioning DOORS (Dynamic Object-Oriented Requirements System) and add `{cite:p}\`gotel_1994\`` after the traceability concept discussion.

**Search for:** "DOORS" in chapter-10.md. Add citation at first mention. If DOORS acronym expansion is missing, it should read "DOORS (Dynamic Object-Oriented Requirements System)".

### 2L. Ch 13 -- FedRAMP 20x (CG-F1)

**File:** `book/chapter-13.md`
**Action:** Find the passage mentioning FedRAMP 20x and add `{cite:p}\`fedramp_20x_2025\``. If the text implies "20x" is a precise speed multiplier, soften to clarify it is an aspiration label (weeks instead of months/years), not a measured metric.

**Search for:** "FedRAMP 20x" or "20x" in chapter-13.md. Add citation.

---

## Verification Checklist

- [ ] `references.bib` has all 10 new entries in correct alphabetical position
- [ ] `lee_2026_metaharness` note field no longer contains "PERPLEXITY: verify before publication"
- [ ] Grep each chapter for the new citation keys to confirm they appear:
  - `ouyang_2025_nondeterminism` in chapter-01.md
  - `landis_1977` in chapter-02.md
  - `li_2023_order_sensitivity` in chapter-02.md
  - `morris_2025_verasight` in chapter-03.md
  - `chroma_2024_chunking` in chapter-04.md
  - `song_2025_correlated_errors` in chapter-05.md
  - `liu_2024_chatgpt_behavior` in chapter-08.md AND chapter-09.md
  - `brodeur_2025_ssrp` in chapter-10.md
  - `gotel_1994` in chapter-10.md
  - `fedramp_20x_2025` in chapter-13.md
- [ ] Ch 10 no longer contains "the majority of papers" or "only about half" (replaced with precise SCORE figures)
- [ ] No em-dashes introduced in any edit
- [ ] All `\$` signs properly escaped in any new text
- [ ] `references.bib` alphabetical order maintained throughout

## Files Modified

`book/references.bib` (10 new entries, 1 modified entry)
`book/chapter-01.md` (1 citation insertion)
`book/chapter-02.md` (2 citation insertions)
`book/chapter-03.md` (1 citation replacement)
`book/chapter-04.md` (1 citation insertion)
`book/chapter-05.md` (1 citation insertion + possible softening)
`book/chapter-08.md` (1 citation insertion)
`book/chapter-09.md` (1 citation insertion)
`book/chapter-10.md` (3 edits: SCORE figures, Brodeur figure, DOORS citation)
`book/chapter-13.md` (1 citation insertion)
