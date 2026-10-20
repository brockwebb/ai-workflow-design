# CC Task: Fix Cost Category Count in Ch 14 Lead-In

**Date:** 2026-04-08
**Scope:** `book/chapter-14.md`
**Priority:** Publication-blocking (factual inconsistency)

---

## Problem

Line 42 of chapter-14.md reads:

> People conflate four different cost categories when they talk about "AI costs."

The table that follows lists FIVE categories (inference, development, operational, opportunity, institutional overhead). The 5th category (institutional overhead) was added in Batch I. Later references in the same chapter correctly say "five" (line 52 reflection prompt, line 82 "five-category cost taxonomy"). But the lead-in sentence was never updated.

## Fix

Change line 42 from:
```
People conflate four different cost categories when they talk about "AI costs."
```

To:
```
People conflate five different cost categories when they talk about "AI costs."
```

One word. No other changes.

## Post-execution
- `seldon cc complete cc_tasks/2026-04-08_ch14_cost_count_fix.md`
