# CC Task: Content Audit — Chapter 3: Data Wrangling & Standardization Workflows

**Date:** 2026-04-01
**Project:** AI Workflow Design for Official Statistics
**Reference:** AD-019, Content Audit workflow
**Section:** `book/chapter-03.md`

---

## Instructions

1. Read `~/Documents/GitHub/seldon/docs/agents/auditor_prompt.md` for the full auditor protocol. Follow it exactly.
2. Run `seldon ontology list --verbose` to get the project's canonical terminology.
3. Read the target file: `book/chapter-03.md`
4. Read `book/references.bib` for existing citation context.
5. Execute the audit per the auditor prompt. Output YAML to `audits/chapter-03_content_audit.yaml`.
6. Extract all `citation_gap` findings into a Perplexity verification file at `audits/chapter-03_perplexity_queries.md`.
7. For each entry in `cascading_audit_tasks` in the output YAML: create a ResearchTask artifact via `seldon task create` with description referencing the source finding, the target section, and the audit type needed.

## Key Context for Auditor

- Citation convention is MyST `{cite:t}` and `{cite:p}` directives, not APA author-year in prose. Scan for those patterns.
- The book has a no-specific-companies rule (no OpenAI, Anthropic, Google in body text). Flag violations.
- Em-dashes are zero tolerance. Flag any found.
- Dollar signs must be escaped as `\$` in MyST. Flag bare `$` before numbers.
- Chapter pedagogical pattern requires: opening hook, core content, reflection prompts (distributed), at least one thought experiment, and a chapter bridge. Verify all are present.
- The chapter-to-principle mapping in the HTML comment at the top may not match the Seldon graph. Do not treat it as authoritative; flag discrepancies but do not resolve.

## Output Files

- `audits/chapter-03_content_audit.yaml` — structured findings per auditor prompt format
- `audits/chapter-03_perplexity_queries.md` — verification queries for citation gaps

## Do NOT

- Edit `book/chapter-03.md` or any book file
- Create Issue artifacts (that's Phase 2 automation)
- Run `seldon paper audit` (that's AD-016 prose QC, separate concern)
- Compare against Session 17 manual audit findings (those were unreliable)
