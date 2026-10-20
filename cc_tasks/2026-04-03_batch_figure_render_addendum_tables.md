# Addendum: Batch Figure Render CC Task — Table Handling

**Date:** 2026-04-03
**Amends:** `cc_tasks/2026-04-03_batch_figure_render_and_insertion.md`
**Reason:** fig-07-01 (Error Classification Table) should be a native MyST table, not an image

---

## Change

**fig-07-01 (Error Classification Table):** Do NOT render as an image. Convert to a native MyST markdown table directly in `book/chapter-07.md`.

The existing `::::{figure}` directive at line 73 should be replaced with a proper MyST table:

```markdown
:::{table} Error classification and pipeline response. The key design decision is that the pipeline must classify each error type and respond differently. Retrying permanent errors wastes resources. Stopping on data errors prevents completion. Ignoring transient errors produces incomplete results. Error type determines response.
:name: tbl-07-01

| Error Type | Examples | Pipeline Response | Investigation Priority |
|:-----------|:---------|:-------------------|:-----------------------|
| Transient | HTTP 429 (rate limit), network timeout, HTTP 503 | Retry with exponential backoff and jitter; stop after max retry count | Low — self-resolving; escalate only if max retries exceeded |
| Permanent | Invalid API key, deprecated model, removed endpoint, malformed request | Log with full context; stop affected batch; alert operator immediately | High — immediate; do not retry |
| Data | Malformed input, unparseable model response, schema mismatch | Log failure with input; skip record; continue processing | Medium — review in batch after run; quality signal, not infrastructure signal |
:::
```

This means:
- The `::::{figure}` directive pointing to `fig-07-01_error_classification_table.png` gets REMOVED (not commented out)
- The `:::{table}` directive replaces it at the same location
- No PNG needs to be rendered for fig-07-01
- The PaperBanana spec file (`fig-07-01_error_classification_table.md`) remains as-is for reference but is superseded
- Seldon registers this as a `Table` artifact, not a `Figure` artifact
- Total PaperBanana renders needed drops from 14 to 13 (10 `.txt` method files + 2 Ch 7 flow diagrams converted from `.md`)

Also check `fig-05-04_topology_comparison_table_method.txt` — the name says "table." If its spec describes tabular data rather than a diagram, apply the same treatment: native MyST table instead of PaperBanana image.
