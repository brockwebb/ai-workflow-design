# CC Task: Chapter 2 Audit Prose Fixes

**Date:** 2026-04-01
**Session:** 16
**Status:** PENDING

---

## Context

Chapter 2 (Classification & Coding Workflows) audit identified prose issues. All empirical numbers verified against the Concept Mapper repo (NUMBERS_MAP.md, 02_classification.qmd, 04_pairwise_harmonization.qmd, 05_results.qmd) and the published PDF (FedSurveyHarmonization.pdf). Routing percentages, kappa values, pair counts, and bridge variable counts all confirmed. Two number characterization issues and three prose issues below. Vendor names (OpenAI, Anthropic, Google) are retained — these are specific tools used in the case study and should be reported accurately.

---

## Fix 1: Cost characterization

**File:** `book/chapter-02.md`

**Find:**
```
The full pipeline including barrier rating and arbitration cost approximately $100.
```

**Replace:**
```
The full pipeline including barrier rating and arbitration cost under $100 in total API fees.
```

**Rationale:** The Concept Mapper paper says "total API cost under $100" in two places (abstract and conclusions). "Approximately $100" implies it was about $100; "under $100" is the ceiling characterization used in the source.

---

## Fix 2: Expert review percentage

**File:** `book/chapter-02.md`

**Find:**
```
approximately 38 questions (0.5%)
```

**Replace:**
```
approximately 38 questions (0.55%)
```

**Rationale:** 38/6,954 = 0.547%, rounds to 0.55%. "0.5%" rounds down too aggressively for a chapter that emphasizes measurement precision.

---

## Fix 3: Opening hook — mark 85% as illustrative

**File:** `book/chapter-02.md`

**Find:**
```
A single model gets about 85% right on its first pass. Is that good enough?
```

**Replace:**
```
Suppose a single model gets about 85% right on its first pass. Is that good enough?
```

**Rationale:** The 85% is a hypothetical framing device, not a measured result from the Concept Mapper. "Suppose" makes the illustrative nature explicit without losing the hook.

---

## Fix 4: Overstatement about single raters

**File:** `book/chapter-02.md`

**Find:**
```
Statisticians would never accept a single human rater's judgment as definitive for a classification task. The entire field of inter-rater reliability exists because individual raters are biased, inconsistent, and occasionally wrong. Why would you accept a single model's judgment without the same scrutiny?
```

**Replace:**
```
Statisticians would never accept a classification study design that relies on a single rater without measuring reliability. The entire field of inter-rater reliability exists because individual raters are biased, inconsistent, and occasionally wrong. Why would you accept a single model's judgment without the same scrutiny?
```

**Rationale:** Statisticians do use single raters in operational settings (e.g., NAICS coding). What they wouldn't accept is a study design with no reliability measurement. The issue is unmeasured reliability, not single raters per se.

---

## Fix 5: Human/LLM independence analogy caveat

**File:** `book/chapter-02.md`

**Find:**
```
LLMs are independently trained neural networks, just as human raters are independently trained neural networks, with very different architectures but the same fundamental property: independent training produces independent biases.
```

**Replace:**
```
LLMs are independently trained neural networks, just as human raters are independently trained neural networks, with very different architectures but the same fundamental property: independent training produces independent biases. The independence is imperfect — models from different vendors still share overlapping training corpora — but it is stronger than within-vendor model diversity and sufficient to surface meaningful disagreement signals.
```

**Rationale:** The analogy is doing good work but slightly overclaims independence. LLMs share training data (Common Crawl, etc.) in ways human raters don't share life experience. One sentence caveat acknowledges this without undermining the point.

---

## Fix 6: Foreword disclaimer for product/company mentions

**File:** `book/foreword.md`

**Add the following to the end of the foreword, before any acknowledgments section, as a brief standalone paragraph:**

```
A note on product references: this book occasionally names specific AI models, vendors, and tools where doing so is necessary to report methodology accurately or to ground design patterns in real implementations. These references reflect the tools available at the time of writing and do not constitute endorsement. The design patterns themselves are vendor-independent.
```

**Rationale:** The book names vendors (OpenAI, Anthropic, Google) in case study reporting. This is accurate methodology reporting, not endorsement. A foreword disclaimer clarifies intent once rather than hedging in every chapter.

---

## Verification

- Confirm Fixes 1–5 are applied in `book/chapter-02.md`
- Confirm Fix 6 disclaimer is added to `book/foreword.md`
- Grep for "approximately \$100" in chapter-02.md — should return zero hits
- Grep for "(0.5%)" in chapter-02.md — should return zero hits
- Run `seldon verify`
