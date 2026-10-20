# CC Task: Register YouTube Research Routing Design Note and Add BibTeX Entries

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Type:** Artifact registration + bibliography update
**Session:** 7

---

## Task 1: Register Design Note as Seldon Artifact

Register `docs/2026-03-29_youtube_research_routing.md` as a Seldon artifact:

- **Type:** DesignNote
- **Tags:** research-routing, external-sources, multi-chapter
- **Description:** Routes research material from two YouTube video summaries to target chapters, with primary source citations traced to original papers. Covers RLI benchmark, SWE-CI benchmark, Rob Pike's five rules, and practitioner insights.

Create `derives_from` links to the following target chapter artifacts:
- `book/chapter-01.md` (RLI benchmark, design-for-scale)
- `book/chapter-06.md` (Rob Pike's rules, scale design)
- `book/chapter-07.md` (SWE-CI maintenance regression)
- `book/chapter-08.md` (evals-as-architecture)
- `book/chapter-09.md` (SWE-CI EvoScore / state degradation)
- `book/chapter-10.md` (document decisions, Alexei disaster)
- `book/chapter-12.md` (environment awareness as security)
- `book/chapter-13.md` (specification discipline)

## Task 2: Add New BibTeX Entries to `book/references.bib`

Append the following three entries to `book/references.bib`, maintaining alphabetical order by key. Do not modify any existing entries.

```bibtex
@article{chen_2026_sweci,
  author    = {Chen, Jialong and Xu, Xander and Wei, Hu and Chen, Chuan and Zhao, Bing},
  title     = {{SWE-CI}: Evaluating Agent Capabilities in Maintaining Codebases via Continuous Integration},
  journal   = {arXiv preprint arXiv:2603.03823},
  year      = {2026},
  url       = {https://arxiv.org/abs/2603.03823},
  note      = {Sun Yat-sen University and Alibaba Group. 100 tasks, avg 233 days / 71 commits per task. 75\% of models break previously working code during long-term maintenance. Introduces EvoScore metric weighting later iterations more heavily. CC BY 4.0.}
}

@article{mazeika_2025,
  author    = {Mazeika, Mantas and Gatti, Alice and Menghini, Cristina and Sehwag, Udari Madhushani and Singhal, Shivam and Orlovskiy, Yury and Basart, Steven and others},
  title     = {Remote Labor Index: Measuring {AI} Automation of Remote Work},
  journal   = {arXiv preprint arXiv:2510.26787},
  year      = {2025},
  url       = {https://arxiv.org/abs/2510.26787},
  note      = {Scale AI + Center for AI Safety. 240 Upwork projects, 23 categories, 6,000+ hours human labor valued at \$140,000. Best agent (Manus) automated 2.5\% of projects at client-acceptable quality. Published October 2025.}
}

@misc{pike_1989,
  author       = {Pike, Rob},
  title        = {Notes on Programming in {C}},
  year         = {1989},
  howpublished = {Bell Labs internal document},
  url          = {https://www.lysator.liu.se/c/pikestyle.html},
  note         = {Five rules of programming. Rule 5: ``Data dominates. If you've chosen the right data structures and organized things well, the algorithms will almost always be self-evident.'' Pike co-created Go, Plan 9, and UTF-8 at Bell Labs with Ken Thompson and Dennis Ritchie.}
}
```

## Task 3: Update Existing Ch 6 Design Note

Append the following section to `docs/2026-03-29_bone_drop_ch06_parallelization.md`, after the existing `## Source Material` section:

```markdown
---

## Additional Material (Session 7)

### Rob Pike's Five Rules Applied to Pipeline Design

Rob Pike's five rules from *Notes on Programming in C* (1989) map directly to LLM pipeline engineering decisions:

1. **Bottlenecks surprise you** — profile your pipeline before optimizing. The bottleneck in an LLM batch pipeline is often not where you expect (it may be JSON parsing, file I/O, or rate-limit backoff sleep time, not the LLM inference itself).
2. **Measure before tuning** — instrument first, optimize second. Matches Ch 8's evaluation-by-design thesis.
3. **Fancy algorithms are slow when N is small** — but invert for federal stats: *design as if N will be large, even when proving it small.* If the method works, N will be large. The Concept Mapper processed 7,000 questions but nothing in the pipeline is hardcoded to 7,000.
4. **Fancy = buggy** — use simple data structures. Config-driven pipelines with flat JSON schemas over clever object hierarchies.
5. **Data dominates** — get your schemas right, and the pipeline design follows. Directly connects to Ch 2's argument for adopting existing domain frameworks (DataSHaPER, Wolf et al.) as structured output schemas.

**Source:** {cite:p}`pike_1989`

### Design for Scale from Day One

The Concept Mapper was designed for N, not for 7,000. The $15 API cost scales linearly — extend to all Census demographic surveys, all federal surveys, cross-agency. The architecture holds because:
- No hardcoded batch sizes or survey-specific logic
- Parallel worker count is a configuration parameter
- Schema definitions are external to the processing code
- Checkpoint/resume works at any scale

The "onesie-twosie" trap: people who design for small problems build systems that only work small. The technology now exists to solve problems at previously infeasible scales — but only if you design the pipeline as a machine, not a one-off script.

**Source:** Author experience, Federal Survey Concept Mapper.
```

## Task 4: Run `seldon verify`

After all writes, run `seldon verify` to confirm artifact integrity.

---

## Verification Checklist

- [ ] Design note registered as Seldon artifact with correct type and links
- [ ] Three new BibTeX entries added to `references.bib` in alphabetical order
- [ ] No existing BibTeX entries modified
- [ ] Ch 6 design note updated with Pike + scale material
- [ ] `seldon verify` passes
