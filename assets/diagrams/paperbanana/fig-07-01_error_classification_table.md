# fig-07-01: Error Classification Decision Table

## Diagram Type
Four-column reference table. Three data rows (one per error type) plus header. Operational quick-reference for practitioners debugging pipeline failures. Book-quality, clean.

## Table Structure

### Header Row
| Error Type | Examples | Pipeline Response | Investigation Priority |

### Row 1: Transient
| Transient | HTTP 429 (rate limit), network timeout, HTTP 503 | Retry with exponential backoff and jitter; stop after max retry count | Low — self-resolving; escalate only if max retries exceeded |

### Row 2: Permanent
| Permanent | Invalid API key, deprecated model, removed endpoint, malformed request | Log with full context; stop affected batch; alert operator immediately | High — immediate; do not retry |

### Row 3: Data
| Data | Malformed input, unparseable model response, schema mismatch | Log failure with input; skip record; continue processing | Medium — review in batch after run; quality signal, not infrastructure signal |

## Visual Style
- Clean book-quality table, not a web UI table
- Header row: dark gray background (#333333), white text
- Error Type column (left): light gray background (#F0F0F0), dark text — serves as row label
- Content cells: white (#FFFFFF)
- Alternating row shading: Row 1 white, Row 2 very light gray (#FAFAFA), Row 3 white
- Cell borders: thin light gray (#CCCCCC)
- Font: sans-serif, same as other chapter figures
- Moderate cell padding — readable, not bloated
- No icons, no color-coding on error type names

## Column Widths
- Error Type: narrow (15%)
- Examples: moderate (25%)
- Pipeline Response: moderate (35%)
- Investigation Priority: moderate (25%)

## Dimensions
- Landscape orientation — four columns require width
- Full column width in book layout

## What This Is NOT
- Not a flowchart showing error handling sequence
- Not a decision tree
- No vendor names, no product names
- Priority column is descriptive response guidance, not a ranked list

## Caption
"Error classification and pipeline response. The key design decision is that the pipeline must classify each error type and respond differently. Retrying permanent errors wastes resources. Stopping on data errors prevents completion. Ignoring transient errors produces incomplete results. Error type determines response."
