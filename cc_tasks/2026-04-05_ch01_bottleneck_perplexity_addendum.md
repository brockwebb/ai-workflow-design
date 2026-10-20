# CC Task Addendum: Perplexity-Verified Citations for Ch 1 Bottleneck Shift

**Date:** 2026-04-05
**Modifies:** cc_tasks/2026-04-04_ch01_bottleneck_shift_and_new_citations.md
**Type:** Citation verification results + additional BibTeX entries

---

## Verification Results

All four Perplexity queries resolved. Results below.

### 1. Kalyuga et al. (2003) -- CONFIRMED as written

No changes needed. Journal, volume, issue, pages, DOI all correct as specified in the parent CC task.

### 2. Fan et al. (2024) -- "Metacognitive Laziness" -- FOUND

Full citation: Yizhou Fan, Luzhen Tang, Huixiao Le, Kejie Shen, Shufang Tan, Yueying Zhao, Yuan Shen, Xinyu Li, and Dragan Gasevic. "Beware of Metacognitive Laziness: Effects of Generative Artificial Intelligence on Learning Motivation, Processes, and Performance." arXiv:2412.09315.

**Add this BibTeX entry to references.bib:**

```bibtex
@misc{fan_2024_metacognitive,
  author       = {Fan, Yizhou and Tang, Luzhen and Le, Huixiao and Shen, Kejie and Tan, Shufang and Zhao, Yueying and Shen, Yuan and Li, Xinyu and Ga\v{s}evi\'{c}, Dragan},
  title        = {Beware of Metacognitive Laziness: Effects of Generative Artificial Intelligence on Learning Motivation, Processes, and Performance},
  year         = {2024},
  eprint       = {2412.09315},
  archiveprefix = {arXiv},
  primaryclass = {cs.CY},
  url          = {https://arxiv.org/abs/2412.09315},
  note         = {Introduces the concept of ``metacognitive laziness'': progressive displacement of self-monitoring and self-correction when AI performs cognitive tasks on behalf of learners.}
}
```

**Usage note:** This is an arXiv preprint, not yet peer-reviewed as of verification date. Cite the concept, not the paper's empirical findings, unless a published version is located. The concept itself (metacognitive laziness) is well-grounded in prior cognitive science literature on automation bias and skill atrophy.

**Decision:** Include in BibTeX but use sparingly in prose. The concept is more important than the specific paper. If the prose only uses the concept without heavy reliance on the paper's data, the preprint status is acceptable.

### 3. OECD Digital Education Outlook 2026 -- CONFIRMED with caveat

Official title: "OECD Digital Education Outlook 2026"
Published: January 19, 2026 by the OECD
URL: https://www.oecd.org/en/publications/oecd-digital-education-outlook-2026_062a7394-en.html

**Caveat:** The phrase "AI learning paradox" is a descriptive label used in commentary about the report, not the OECD's own terminology. Do NOT attribute the phrase to the OECD directly. Instead, describe the phenomenon the OECD documents (improved task performance coexisting with reduced learning) and cite the report for the finding.

**Add this BibTeX entry to references.bib:**

```bibtex
@techreport{oecd_digital_education_2026,
  author       = {{Organisation for Economic Co-operation and Development}},
  title        = {{OECD Digital Education Outlook 2026}},
  institution  = {OECD Publishing},
  year         = {2026},
  month        = {January},
  url          = {https://www.oecd.org/en/publications/oecd-digital-education-outlook-2026_062a7394-en.html},
  note         = {Documents the tension between improved short-term task performance and weaker subsequent learning when general-purpose AI tools are used in educational contexts without pedagogical scaffolding. Cites Bastani et al. (2024) showing 48\% short-term improvement but 17\% decline after AI access removed.}
}
```

**Decision:** Include in BibTeX. Citable for the documented phenomenon. Do not use the phrase "AI learning paradox" as if it is an OECD term.

### 4. Bastani et al. (2024) -- UPGRADED to PNAS publication

Now published in Proceedings of the National Academy of Sciences.
Full title: "Generative AI Without Guardrails Can Harm Learning: Evidence from High School Mathematics"
DOI: 10.1073/pnas.2422633122

**Add this BibTeX entry to references.bib (replaces any SSRN-only entry):**

```bibtex
@article{bastani_2024,
  author    = {Bastani, Hamsa and Bastani, Osbert and Sungu, Alp and Ge, Haosen and Kabakc{\i}, \"{O}zge and Mariman, Rei},
  title     = {Generative {AI} Without Guardrails Can Harm Learning: Evidence from High School Mathematics},
  journal   = {Proceedings of the National Academy of Sciences},
  year      = {2024},
  doi       = {10.1073/pnas.2422633122},
  note      = {RCT: students with GPT-4 access improved short-term task scores by 48\% but performed 17\% worse on subsequent tests without AI. Published in PNAS; earlier version available as SSRN 4895486.}
}
```

---

## Prose Adjustments

In the parent CC task's draft prose, the cognitive science paragraph currently does not cite Fan or Bastani directly. If the executing session wants to strengthen the argument:

- Use `{cite:p}\`bastani_2024\`` when referencing the 48%/17% finding (now PNAS-published, strong cite)
- Use `{cite:p}\`fan_2024_metacognitive\`` when referencing metacognitive laziness (arXiv preprint, use cautiously)
- Reference OECD phenomenon without quoting "AI learning paradox" as their term
- The OECD report itself (`oecd_digital_education_2026`) is optional to cite if Bastani is cited directly, since the OECD cites Bastani for the same finding

---

## Acceptance Criteria for Addendum

1. Three additional BibTeX entries added (fan_2024_metacognitive, oecd_digital_education_2026, bastani_2024)
2. Kalyuga entry confirmed unchanged
3. Prose does not attribute "AI learning paradox" to OECD
4. All citation keys resolve in both .bib and .md
