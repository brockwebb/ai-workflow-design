# CC Task: Render fig-01-01a and fig-01-01b via PaperBanana

**Date:** 2026-03-31
**Session:** 15
**Status:** PENDING
**Scope:** Figure rendering — `book/images/fig-01-01a_naive.png`, `book/images/fig-01-01b_designed.png`
**Prerequisites:** Read `/Users/brock/Documents/GitHub/central_library/paperbanana_cc_instruct.md` FIRST.

---

## Context

Chapter 1 references two figures with `{figure}` directives pointing to `images/fig-01-01a_naive.png` and `images/fig-01-01b_designed.png`. Neither image exists. The build will break.

Method files are written and ready:
- `/Users/brock/Documents/GitHub/ai-workflow-design/assets/diagrams/paperbanana/fig-01-01a_naive_method.txt`
- `/Users/brock/Documents/GitHub/ai-workflow-design/assets/diagrams/paperbanana/fig-01-01b_designed_method.txt`

Figure spec: `/Users/brock/Documents/GitHub/ai-workflow-design/assets/diagrams/fig-01-01_naive_vs_designed.md`

---

## Steps

### Step 0: Read PaperBanana instructions
```bash
cat /Users/brock/Documents/GitHub/central_library/paperbanana_cc_instruct.md
```
Follow the instructions there exactly. Key points:
- Check `.env` has `GOOGLE_API_KEY` (not just `GEMINI_API_KEY`)
- Use `--vlm-model gemini-3.1-pro-preview` (config file has a typo)
- Use `--image-model gemini-3.1-flash-image-preview`
- Do NOT use `--diagram-type` flag (does not exist)

### Step 1: Generate both diagrams in parallel

```bash
cd /Users/brock/Documents/GitHub/ai-workflow-design/assets/diagrams/paperbanana

paperbanana generate \
  --input fig-01-01a_naive_method.txt \
  --caption "The naive workflow. Input goes in, model processes it, output comes out." \
  --vlm-model gemini-3.1-pro-preview \
  --image-model gemini-3.1-flash-image-preview \
  --iterations 3 &

paperbanana generate \
  --input fig-01-01b_designed_method.txt \
  --caption "The designed workflow. Same input, same output, but now you can defend it." \
  --vlm-model gemini-3.1-pro-preview \
  --image-model gemini-3.1-flash-image-preview \
  --iterations 3 &
```

Use `run_in_background: true` for both. Record task IDs.

### Step 2: Copy outputs to book images directory

When both complete, copy final outputs:

```bash
cp <paperbanana_dir>/outputs/<run_id_a>/final_output.png /Users/brock/Documents/GitHub/ai-workflow-design/book/images/fig-01-01a_naive.png
cp <paperbanana_dir>/outputs/<run_id_b>/final_output.png /Users/brock/Documents/GitHub/ai-workflow-design/book/images/fig-01-01b_designed.png
```

### Step 3: Visual QA

Open both images for human review:
```bash
open /Users/brock/Documents/GitHub/ai-workflow-design/book/images/fig-01-01a_naive.png
open /Users/brock/Documents/GitHub/ai-workflow-design/book/images/fig-01-01b_designed.png
```

**The PaperBanana critic is unreliable** (rubber-stamps due to JSON parse bug). Human visual review is required before accepting.

### Step 4: Remove [NEEDS:] markers from chapter

If images pass QA, remove these two lines from `book/chapter-01.md`:
```
[NEEDS: fig-01-01a not yet rendered.]
[NEEDS: fig-01-01b not yet rendered.]
```

### Step 5: Record provenance

Note in this CC task or the figure registry:
- fig-01-01a run ID: `run_YYYYMMDD_HHMMSS_xxxxxx`
- fig-01-01b run ID: `run_YYYYMMDD_HHMMSS_xxxxxx`
- Iterations completed
- Visual QA pass/fail

### Step 6: Verify

```bash
seldon verify --fix
```

---

## Acceptance Criteria

- Both PNG files exist in `book/images/`
- fig-01-01a is visually sparse: three boxes, two arrows, nothing else
- fig-01-01b shows the five-layer processing block between matching Input/Output boxes
- Both work in grayscale
- [NEEDS:] markers removed from chapter-01.md
- `seldon verify` passes
