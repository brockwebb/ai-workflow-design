# CC Task: Establish BibTeX Citation Infrastructure and Update Bibliography

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** None (foundational infrastructure task)

---

## Objective

Establish a BibTeX-based citation system that works for both the MyST HTML build and the Typst PDF export pipeline. Create `book/references.bib` as the single source of truth for all citations. Update `book/myst.yml` to reference it. Populate with all verified citations accumulated through Session 4, including newly verified entries from this session.

## Rationale

The current `book/bibliography.md` is a hand-maintained markdown file with several `[NEEDS: full citation details]` entries. MyST supports BibTeX natively via `{cite:t}` (narrative/textual) and `{cite:p}` (parenthetical) roles, which:
- Render correctly in HTML with hover popups
- Export correctly through Pandoc to Typst for PDF
- Enforce that every inline citation has a matching bibliography entry
- Support APA-style output via CSL configuration

The markdown bibliography file will be retained as the rendered references page but populated automatically from the .bib file via a `{bibliography}` directive.

## Step 1: Create `book/references.bib`

Create the file `book/references.bib` with all verified entries in BibTeX format. Use APA-compatible entry types. Keys follow the convention: `firstauthor_year` (lowercase, underscore-separated).

```bibtex
% references.bib — AI Workflow Design for Official Statistics
% Single source of truth for all citations
% Keys: firstauthor_year (e.g., huang_2024, madaan_2023)
% Format: APA 7th edition compatible BibTeX entries

@inproceedings{huang_2024,
  author    = {Huang, Jie and Chen, Xinyun and Mishra, Swaroop and Zheng, Huadong Steven and Yu, Adams Wei and Song, Xinying and Zhou, Denny},
  title     = {Large Language Models Cannot Self-Correct Reasoning Yet},
  booktitle = {Proceedings of the Twelfth International Conference on Learning Representations (ICLR 2024)},
  year      = {2024},
  url       = {https://arxiv.org/abs/2310.01798}
}

@inproceedings{madaan_2023,
  author    = {Madaan, Aman and Tandon, Niket and Gupta, Prakhar and Hallinan, Skyler and Gao, Luyu and Wiegreffe, Sarah and Alon, Uri and Dziri, Nouha and Prabhumoye, Shrimai and Yang, Yiming and Gupta, Shashank and Majumder, Bodhisattwa Prasad and Hermann, Katherine M. and Welleck, Sean and Yazdanbakhsh, Amir and Clark, Peter},
  title     = {Self-Refine: Iterative Refinement with Self-Feedback},
  booktitle = {Advances in Neural Information Processing Systems 36 (NeurIPS 2023)},
  year      = {2023},
  url       = {https://arxiv.org/abs/2303.17651}
}

@inproceedings{yang_2025,
  author    = {Yang, Zhangyue and Zhang, Yifan and Wang, Yuxin and others},
  title     = {A Probabilistic Inference Scaling Theory for {LLM} Self-Correction},
  booktitle = {Proceedings of the 2025 Conference on Empirical Methods in Natural Language Processing (EMNLP 2025)},
  year      = {2025}
}

@article{xu_2024,
  author    = {Xu, Wenda and others},
  title     = {Pride and Prejudice: {LLM} Amplifies Self-Bias in Self-Refinement},
  year      = {2024},
  journal   = {arXiv preprint},
  url       = {https://arxiv.org/abs/2402.11436}
}

@article{pan_2024,
  author    = {Pan, Linyi and others},
  title     = {Spontaneous Reward Hacking in Iterative Self-Refinement},
  year      = {2024},
  journal   = {arXiv preprint}
}

@article{lee_2025,
  author    = {Lee, Harrison and others},
  title     = {{RefineBench}: Evaluating Iterative Self-Refinement in Large Language Models},
  year      = {2025},
  journal   = {arXiv preprint}
}

@misc{shapiro_2026,
  author       = {Shapiro, Dan},
  title        = {The Five Levels: From Spicy Autocomplete to the Dark Factory},
  year         = {2026},
  month        = {1},
  day          = {23},
  howpublished = {danshapiro.com},
  url          = {https://www.danshapiro.com/blog/2026/01/the-five-levels-from-spicy-autocomplete-to-the-software-factory/}
}

@article{becker_2025,
  author    = {Becker, Joel and Rush, Nate and Barnes, Elizabeth and Rein, David},
  title     = {Measuring the Impact of Early-2025 {AI} on Experienced Open-Source Developer Productivity},
  year      = {2025},
  month     = {7},
  journal   = {arXiv preprint arXiv:2507.09089},
  url       = {https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/},
  note      = {Published by METR (Model Evaluation and Threat Research). RCT with 16 developers, 246 tasks, February--June 2025. Tools: Cursor Pro with Claude 3.5/3.7 Sonnet.}
}

@report{dora_2024,
  author       = {{DORA Team, Google Cloud}},
  title        = {Accelerate State of {DevOps} Report 2024},
  year         = {2024},
  month        = {10},
  institution  = {Google Cloud},
  url          = {https://dora.dev/research/2024/dora-report/},
  note         = {39,000+ respondents globally. AI chapter uses causal inference methods. Key finding: 75\% of developers self-reported productivity gains from AI, but every 25\% increase in AI adoption correlated with 1.5\% delivery speed dip and 7.2\% stability drop. Self-reported productivity vs.\ measured delivery metrics are different measurement types. Observational study with causal inference, not RCT.}
}

@book{webb_2026_ai4stats,
  author    = {Webb, Brock},
  title     = {{AI} for Official Statistics},
  year      = {2026},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.19206379},
  url       = {https://doi.org/10.5281/zenodo.19206379}
}

@article{webb_2026_crosswalk,
  author    = {Webb, Brock},
  title     = {When {AI} Enters Federal Statistics: A Regulatory Crosswalk of {NIST AI RMF} and {FCSM} Statistical Quality Standards},
  year      = {2026},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.18772590},
  url       = {https://doi.org/10.5281/zenodo.18772590}
}

@article{shumailov_2024,
  author    = {Shumailov, Ilia and Shumaylov, Zakhar and Zhao, Yiren and Papernot, Nicolas and Anderson, Ross and Gal, Yarin},
  title     = {{AI} Models Collapse When Trained on Recursively Generated Data},
  journal   = {Nature},
  volume    = {631},
  number    = {8022},
  pages     = {755--759},
  year      = {2024},
  doi       = {10.1038/s41586-024-07566-y}
}

@article{alemohammad_2023,
  author    = {Alemohammad, Sina and Casco-Rodriguez, Josue and Luzi, Lorenzo and Humayun, Ahmed Imtiaz and Babaei, Hossein and LeJeune, Daniel and Siahkoohi, Ali and Baraniuk, Richard G.},
  title     = {Self-Consuming Generative Models Go {MAD}},
  journal   = {arXiv preprint arXiv:2307.01850},
  year      = {2023},
  url       = {https://arxiv.org/abs/2307.01850}
}
```

## Step 2: Update `book/myst.yml`

Add the bibliography reference to the project configuration. Insert under the `project:` key:

```yaml
project:
  bibliography:
    - references.bib
```

This tells MyST to resolve `{cite:t}` and `{cite:p}` roles against the BibTeX file.

## Step 3: Update `book/bibliography.md`

Replace the current hand-maintained reference list with a MyST bibliography directive that auto-generates from the .bib file. The page becomes:

````markdown
# Bibliography

<!-- Auto-generated from references.bib -->
<!-- All citation entries maintained in book/references.bib -->
<!-- Use {cite:t}`key` for narrative citations (e.g., "Huang et al. (2024) showed...") -->
<!-- Use {cite:p}`key` for parenthetical citations (e.g., "...(Huang et al., 2024)") -->

```{bibliography}
:style: unsrt
```
````

## Step 4: Update CLAUDE.md — Citation Conventions

Add the following section to CLAUDE.md under "Workflow Rules":

```markdown
## Citation Conventions

- **BibTeX file:** `book/references.bib` — single source of truth for all citations.
- **Narrative (textual) citations:** `{cite:t}`key`` → renders as "Author et al. (Year)"
  - Example: `{cite:t}`huang_2024`` → Huang et al. (2024)
  - Use when the author is the grammatical subject: "Huang et al. (2024) demonstrated..."
- **Parenthetical citations:** `{cite:p}`key`` → renders as "(Author et al., Year)"
  - Example: `{cite:p}`huang_2024`` → (Huang et al., 2024)
  - Use at end of a claim: "LLMs cannot self-correct reasoning ({cite:p}`huang_2024`)."
- **Multiple citations:** `{cite:p}`key1;key2`` → (Author1, Year; Author2, Year)
- **Key convention:** `firstauthor_year` in lowercase with underscores.
- **Adding new citations:** Every CC task that introduces a source MUST add the BibTeX entry to `references.bib` AND use the proper `{cite:t}` or `{cite:p}` role in the chapter text.
- **No bare prose citations.** Do not write "Huang et al. (2024)" as plain text. Always use the role markup so both HTML and PDF builds resolve correctly.
- **PDF pipeline:** MyST → Pandoc → Typst. The `{cite:t}` and `{cite:p}` roles resolve through Pandoc's citeproc. The BibTeX file is the input for both build targets.
```

## Verification

After execution, verify:
1. `book/references.bib` exists and is valid BibTeX (run `bibtool -s book/references.bib` or similar lint)
2. `book/myst.yml` includes the `bibliography` key under `project`
3. `book/bibliography.md` uses the `{bibliography}` directive
4. `myst build --html` from `book/` resolves at least one citation without errors
5. CLAUDE.md contains the citation conventions section

## Notes

- The `[NEEDS: full citation details]` entries from the old bibliography.md are now resolved where possible. `lee_2025` and `pan_2024` still need full author lists and venue details — mark with comments in the .bib file.
- The `note` field in `becker_2025` and `dora_2024` entries contains methodology details for writer reference; these may or may not render depending on the citation style. They are there primarily for Claude and Brock to reference when writing text.
- APA 7th edition CSL can be added later if the default citation style doesn't match APA closely enough. For now, the default MyST citation rendering is acceptable.
