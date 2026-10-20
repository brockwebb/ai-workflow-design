# CC Task: Chapter 12 — Insert Appendix Pointer Sentence

**Date:** 2026-04-06
**Project:** ai-workflow-design
**Reference:** Session 27 security appendix decision gate (1826188c, closed), AD-020 calibration run 010 §7
**Target:** `book/chapter-12.md`

---

## Context

The security appendix decision gate was closed in Session 27: standalone appendix chosen. Ch 12 revision Parts A–D were executed (CC task `2026-04-05_ch12_revision.md`, completed 2026-04-06T02:42:18Z). Part E was correctly skipped pending author decision, which is now made.

The calibration run 010 synthesis recommended: "Ch 12 needs one sentence: 'Agentic AI systems — where the AI autonomously selects and invokes tools at runtime — introduce additional security considerations covered in the appendix.'"

## Task

Insert one sentence into `book/chapter-12.md` in the **Framework Alignment** section, after the paragraph ending "Point to it rather than reproducing it here." and before the paragraph starting "For organizations looking to formalize..."

### Sentence to insert

```
Agentic AI systems -- where the AI autonomously selects and invokes tools at runtime -- introduce additional security considerations around tool authorization, agent identity, and prompt injection via tool outputs. These are covered in {ref}`appendix-security`.
```

**Notes on syntax:**
- Use `--` (double hyphen), not em-dash
- The `{ref}` role links to the appendix file's label. The appendix file (`book/appendix-security.md`) will have `(appendix-security)=` as its MyST target label at the top.
- If the `{ref}` role does not resolve at build time (because the appendix file doesn't exist yet), this is expected — the appendix CC task creates it.

## Verification

1. The inserted sentence appears in the Framework Alignment section.
2. No other content in `book/chapter-12.md` is modified.
3. The sentence uses `--` not em-dash.
4. The `{ref}` target is `appendix-security`.
5. Run `seldon verify --fix` after edit.

## Do NOT

- Modify any other section of Ch 12
- Edit any other chapter file
- Edit `book/myst.yml` (the TOC update happens in the appendix CC task)
- Add any BibTeX entries (those go in the appendix CC task)
