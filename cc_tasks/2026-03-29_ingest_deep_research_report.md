# CC Task: Ingest Deep Research Report — Add BibTeX Entries and Route to Chapters

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Type:** Bibliography update + artifact registration
**Session:** 7

---

## Context

A Deep Research report (`docs/deep-research-report-chapt3.md`) returned eight usable citations across Chapters 3, 4, 5, and 8. This CC task adds the BibTeX entries and registers the report as a Seldon artifact with routing metadata.

---

## Task 1: Add New BibTeX Entries to `book/references.bib`

Append the following entries to `book/references.bib`, maintaining alphabetical order by key. Do not modify any existing entries.

```bibtex
@inproceedings{azanza_2025,
  author    = {Azanza, Maider and P\'{e}rez Lamancha, Beatriz and Pizarro, Emilio},
  title     = {Tracking the Moving Target: A Framework for Continuous Evaluation of {LLM} Test Generation in Industry},
  booktitle = {Proceedings of the International Conference on Evaluation and Assessment in Software Engineering (EASE 2025)},
  year      = {2025},
  note      = {CI/CD pipeline for continuously evaluating LLM-powered test generators. Integrates with SonarQube, applies continuous regression tests, tracks metrics like coverage and maintainability. Flagged LLM performance drift in longitudinal industrial study.}
}

@article{digiuseppe_2026,
  author    = {DiGiuseppe, Matthew R. and Flynn, Michael E.},
  title     = {Scaling Open-Ended Survey Responses Using {LLM}-Paired Comparisons},
  journal   = {Public Opinion Quarterly},
  year      = {2026},
  volume    = {nfag013},
  note      = {Peer-reviewed. Used six LLMs for pairwise comparisons on real open-ended survey responses (interest-rate knowledge). Bradley-Terry approach yielded more consistent, fine-grained scales than zero-shot numeric ratings, aligning closely with expert coding.}
}

@article{fagerberg_2025,
  author    = {Fagerberg, Pontus and Sallander, Oskar and Vikhe Patil, Koustubh and others},
  title     = {Dual-Model {LLM} Ensemble via Web Chat Interfaces Reaches Near-Perfect Sensitivity for Systematic-Review Screening: A Multi-Domain Validation with Equivalence to {API} Access},
  journal   = {medRxiv preprint},
  year      = {2025},
  note      = {Dual-LLM ensemble (GPT-5 + Gemini 2.5) with OR-rule attained 99.7\% sensitivity on 16 Cochrane review abstract screening tasks, vs 94--98\% for best single models. Traded specificity (~49\%). Demonstrates multi-model ensemble mitigating model-specific blind spots.}
}

@article{kamen_2025,
  author    = {Kamen, Ali and Kamen, Yonatan},
  title     = {Majority Rules: {LLM} Ensemble is a Winning Approach for Content Categorization},
  journal   = {arXiv preprint},
  year      = {2025},
  note      = {Ten LLMs zero-shot, majority vote ensemble for hierarchical taxonomy classification (IAB 8,660-sample corpus). Ensemble improved F1 by up to 65\% over best single model, approaching expert-level accuracy. Reduced hallucinations and inconsistency.}
}

@article{liu_2025_sejury,
  author    = {Liu, Xiaoyu and others},
  title     = {{SE-Jury}: An {LLM}-as-Ensemble-Judge Metric for Narrowing the Gap with Human Evaluation in Software Engineering},
  journal   = {arXiv preprint},
  year      = {2025},
  note      = {Ensemble of LLM evaluators for code generation tasks. Dynamic team selection achieved 30--140\% higher Kendall/Spearman correlation with human judgments than single-model metrics. Software engineering focus.}
}

@article{tam_2024,
  author    = {Tam, Thanh Yen Caelen and Sivarajkumar, Sonish and Kapoor, Sumit and others},
  title     = {A Framework for Human Evaluation of Large Language Models in Healthcare Derived from Literature Review},
  journal   = {NPJ Digital Medicine},
  volume    = {7},
  pages     = {258},
  year      = {2024},
  note      = {Systematic review (2018--Feb 2024) proposing QUEST framework: Quality of information, Understanding/Reasoning, Expression/Persona, Safety/Harm, Trust/Confidence. Structured human evaluation dimensions for LLMs in regulated clinical settings.}
}

@misc{templ_2026,
  author       = {Templ, Matthias},
  title        = {{AI}-Assisted Statistical Disclosure Control with {sdcMicro}},
  year         = {2026},
  howpublished = {R package vignette, R Foundation},
  note         = {sdcMicro integrates LLMs for disclosure avoidance. AI\_createSdcObj() classifies variables as quasi-identifiers; AI\_applyAnonymization() proposes anonymization strategies. LLM sees only metadata (variable names, types, categories), returns human-readable reasoning and reproducible R code. Austrian official statistics context.}
}

@inproceedings{tian_2025,
  author    = {Tian, Wenshan and Lu, Yulei and Ding, Yu and West, Brady T.},
  title     = {Comparing Large Language Models and Traditional Methods for Imputing Missing Survey Responses in a 2024 {U.S.} Presidential Election Survey},
  booktitle = {AAPOR 2025 Annual Conference},
  year      = {2025},
  note      = {Real 2024 U.S. election survey data with induced nonresponse. Llama 2 13B (few-shot) achieved F1 0.65--0.66 on categorical imputation, exceeding MICE (0.50--0.58) and KNN (0.29--0.55). LLM ran approximately 40x slower than MICE. Direct comparison of LLM vs standard imputation methods.}
}
```

## Task 2: Register Deep Research Report as Seldon Artifact

Register `docs/deep-research-report-chapt3.md` as a Seldon artifact:

- **Type:** DesignNote
- **Tags:** deep-research, external-sources, multi-chapter, citation-source
- **Description:** Deep Research report containing eight peer-reviewed or preprint citations across Chapters 3, 4, 5, and 8. All citations traced to primary sources. Returned from ChatGPT Deep Research query, Session 7.

Create `derives_from` links to:
- `book/chapter-03.md` (Tian et al. — LLM imputation)
- `book/chapter-04.md` (DiGiuseppe & Flynn — open-ended responses; Templ — sdcMicro disclosure)
- `book/chapter-05.md` (Fagerberg et al. — dual-model ensemble; Kamen & Kamen — majority vote; Liu et al. — SE-Jury)
- `book/chapter-08.md` (Tam et al. — QUEST framework; Azanza et al. — continuous evaluation)

## Task 3: Run `seldon verify`

After all writes, run `seldon verify` to confirm artifact integrity.

---

## Citation Routing Summary

| Citation | Key | Target Chapter | Strength | Notes |
|----------|-----|---------------|----------|-------|
| Tian et al. (2025) — LLM vs MICE/KNN imputation | `tian_2025` | **Ch 3** | Strong | Real survey data, direct method comparison, computational cost noted |
| DiGiuseppe & Flynn (2026) — LLM pairwise scaling | `digiuseppe_2026` | **Ch 4** | Strong | Peer-reviewed POQ, real survey responses, six LLMs |
| Templ (2026) — sdcMicro AI disclosure control | `templ_2026` | **Ch 4** | Strong | R package, Austrian official stats, LLM sees only metadata |
| Fagerberg et al. (2025) — dual-model systematic review | `fagerberg_2025` | **Ch 5** | Moderate | Medical domain, but dual-LLM OR-rule ensemble topology is directly relevant |
| Kamen & Kamen (2025) — majority vote ensemble | `kamen_2025` | **Ch 5** | Moderate | Ten LLMs, 65% F1 improvement, supports "multi-model as baseline" argument |
| Liu et al. (2025) — SE-Jury ensemble judge | `liu_2025_sejury` | **Ch 5** | Marginal | Software engineering, interesting methodology but distant from audience |
| Tam et al. (2024) — QUEST healthcare eval framework | `tam_2024` | **Ch 8** | Moderate | Structured human eval in regulated domain, parallels FCSM dimensions |
| Azanza et al. (2025) — continuous LLM evaluation | `azanza_2025` | **Ch 8** | Strong | CI/CD eval pipeline, drift monitoring, directly supports Ch 8.6 |

## Citations to Verify Before Final Drafts

- [ ] `tian_2025` — Confirm AAPOR 2025 conference paper availability; check if a journal version exists
- [ ] `digiuseppe_2026` — Confirm POQ publication status and correct article ID (nfag013)
- [ ] `templ_2026` — Confirm sdcMicro vignette availability on CRAN; verify AI function names
- [ ] `fagerberg_2025` — Confirm medRxiv preprint ID; verify GPT-5 model identification is accurate
- [ ] `kamen_2025` — Confirm arXiv ID; verify the 65% F1 improvement claim
- [ ] `liu_2025_sejury` — Confirm arXiv ID; verify correlation improvement range (30–140%)
- [ ] `tam_2024` — Confirm NPJ Digital Medicine volume/page; verify QUEST acronym components
- [ ] `azanza_2025` — Confirm EASE 2025 publication; verify SonarQube integration claim

---

## Verification Checklist

- [ ] Eight new BibTeX entries added to `references.bib` in alphabetical order
- [ ] No existing BibTeX entries modified
- [ ] Design note registered as Seldon artifact with correct type and links
- [ ] `seldon verify` passes
