# Addendum: Ch 10 Revision — Perplexity Verification Results for SCORE Citations

**Date:** 2026-04-05
**Amends:** `cc_tasks/2026-04-05_ch10_revision.md` (Part A)
**Perplexity results:** `docs/perplexity_results_score_project.md`

---

## Purpose

The original CC task flagged that SCORE Perplexity verification was pending and instructed Claude Code to use `<!-- PERPLEXITY: verify -->` placeholders for unverified claims. Verification is now complete. This addendum specifies what is safe to cite and what needs softer framing.

## Verified — Safe to Cite with Specific Numbers

| Paper | Safe claim | Source |
|---|---|---|
| Miske et al. 2026 | 53% reproduced exactly; ~72% approximately | Maastricht University press release confirming abstract |
| Aczel et al. 2026 | 74% same conclusion, 2% opposite conclusion | Greenwich repository abstract |
| Tyner et al. 2026 | 164 papers, 49.3% replication at paper level | Author publication page abstract |
| SCORE project | "Systematizing Confidence in Open Research and Evidence"; ~7 years; 865 researchers | Multiple sources |

## Partially Verified — Use Softer Framing

| Claim | Issue | How to handle |
|---|---|---|
| "600 papers examined, 145 had sufficient detail" (Miske) | Exact denominator wording not confirmed from snippet | Frame as: "only about half of examined results could be reproduced exactly" with `{cite:p}` to `miske_2026`. Do NOT cite the 600/145 breakdown. |
| Brodeur et al. 2026 specific percentages (85%, 72%, 25%) | Article statistics not surfaced in Perplexity results | Frame as: "research published under stronger data and code sharing norms showed substantially higher reproducibility rates" with `{cite:p}` to `brodeur_2026`. Do NOT cite specific Brodeur percentages. |

## Execution Guidance for Part A

When inserting the SCORE framing in the Defensibility paragraph:

1. Use Miske for the core finding: "only about half of examined results could be reproduced exactly" `{cite:p}miske_2026`.
2. Use Brodeur for the improvement signal: frame qualitatively, not with specific percentages. `{cite:p}brodeur_2026`.
3. The "76% couldn't even be attempted" framing is editorially derived arithmetic (600 minus 145). Do NOT use this as a cited statistic. If you want to convey the point, frame it as: "the majority of papers lacked sufficient documentation to even attempt reproduction."
4. Remove any `<!-- PERPLEXITY: verify -->` placeholders — verification is complete.
5. Do NOT cite Aczel or Tyner in Ch 10. They belong elsewhere.
