# CC Task: Fix DORA Respondent Count — Chapter 1

**Date:** 2026-03-31
**Session:** 16
**Status:** PENDING
**Amends:** 2026-03-31_audit_ch01_fixes.md (Fix 4, DORA respondent count — previously flagged, now resolved)

---

## Context

The Chapter 1 text (line 82) reads:

> "The 2024 Accelerate State of DevOps Report {cite:p}`dora_2024`, surveying over 39,000 professionals globally, found the same pattern at scale..."

The "39,000+" figure is the cumulative DORA program respondent count across the report's history, not the 2024 AI-specific subsample. The AI-related findings (75%, 1.5%, 7.2%) are drawn from a much smaller subset (~3,000 respondents). As written, the sentence implies 39,000 people produced the AI results, which is misleading.

## Fix

**File:** `book/chapter-01.md`

**Find this text:**
```
The 2024 Accelerate State of DevOps Report {cite:p}`dora_2024`, surveying over 39,000 professionals globally, found the same pattern at scale:
```

**Replace with:**
```
The 2024 Accelerate State of DevOps Report {cite:p}`dora_2024`, a large-scale global survey of technology professionals, found the same pattern at scale:
```

**Rationale:** Drops the specific number that conflates program-level and subsample counts. Preserves the authority signal and sentence flow. The rest of the paragraph is unchanged.

## Verification

- Confirm the replacement text is in place
- Confirm no other instances of "39,000" exist in chapter-01.md
- Run `seldon verify`
