# CC Task: Chapter 3 Perplexity Verification

**Date:** 2026-04-01
**Scope:** `book/chapter-03.md` factual claims and citations
**Type:** Citation verification (dual-path: web search + Perplexity)
**Status:** PENDING

---

## Context

Chapter 3 audit identified multiple factual claims, assertions, and cited works requiring dual-path verification. This task documents all items requiring Perplexity search. Web search was already attempted for each; Perplexity provides the independent second path.

---

## Verification Items

### V1: tian_2025 — LLM vs MICE imputation numbers

**Chapter claim:** "LLM imputation outperforming MICE on categorical variables (F1 0.65 versus 0.50) in a real 2024 election survey, but at 40 times the computational cost."

**Bib entry:** Tian, W., Lu, Y., Ding, Y., & West, B. T. (2025). "Comparing Large Language Models and Traditional Methods for Imputing Missing Survey Responses in a 2024 U.S. Presidential Election Survey." AAPOR 2025 Annual Conference.

**Web search result:** Could not find the specific paper or verify numbers independently. AAPOR 2025 program confirmed but paper not individually accessible.

**Perplexity query:** `Tian Lu Ding West 2025 AAPOR LLM imputation MICE categorical F1 election survey`

**Verify:** F1 0.65 vs 0.50, 40x computational cost, Llama 2 13B, 2024 U.S. election survey data.

---

### V2: LLMs superior to traditional NLP for open-ended semantic analysis

**Chapter claim (line 69):** "No traditional NLP approach handles open-ended semantic analysis at this quality level."

**Evidence needed:** Comparative study or benchmark showing LLMs outperform bag-of-words, topic models, keyword extraction, sentiment analysis for open-ended survey response analysis.

**Perplexity query 1:** `LLM vs traditional NLP open-ended survey response analysis comparison 2024 2025`

**Perplexity query 2:** `large language models outperform topic models bag of words text classification semantic analysis benchmark`

**Action:** Find citation to support claim, or determine if claim needs to be reframed as engineering judgment rather than stated fact.

---

### V3: Fine-tuning total cost of ownership vs API approach

**Chapter claim (line 33):** "For most use cases, the total cost of ownership for fine-tuning exceeds the API approach, often by a large margin, because people account for the API cost but not for the human engineering cost of the fine-tuning pipeline."

**Evidence needed:** Any credible source (industry report, peer-reviewed, NIST, or similar) documenting that teams underestimate fine-tuning TCO relative to API approaches. Multiple web sources corroborate the pattern anecdotally but no single authoritative citation was found.

**Perplexity query 1:** `fine-tuning LLM total cost ownership hidden costs underestimate vs API 2024 2025`

**Perplexity query 2:** `self-hosted LLM deployment cost analysis infrastructure MLOps overhead study`

**Action:** Find citation, or if none exists, soften to "the total cost of ownership comparison should include..." (design guidance framing rather than factual claim about what "most teams" do).

---

### V4: Fine-tuning/local deployment timeline — "6 to 18 months"

**Chapter claim (lines 35, 39):** Institutional deployment path for fine-tuning/local models takes "6 to 18 months" before processing a single production record. Stated twice.

**Evidence needed:** Any source documenting federal or institutional AI deployment timelines. GAO reports, OMB guidance, or federal CIO council publications on AI procurement timelines would be ideal.

**Perplexity query:** `federal agency AI deployment timeline procurement security review months GAO OMB 2024 2025`

**Action:** Find citation if available. If not, flag as engineering judgment based on practitioner experience and frame accordingly. Fix the repetition regardless.

---

### V5: Fellegi-Holt and MICE — missing bib entries

**Chapter references (line 81):** "MICE, hot-deck, Fellegi-Holt" named without citations.

**Already verified via web search:**
- Fellegi, I. P. & Holt, D. T. (1976). "A Systematic Approach to Automatic Edit and Imputation." JASA, 71, 17–35.
- van Buuren, S. & Groothuis-Oudshoorn, K. (2011). "mice: Multivariate Imputation by Chained Equations in R." Journal of Statistical Software, 45(3), 1–67.

**Perplexity query:** `Fellegi Holt 1976 JASA systematic approach automatic edit imputation` and `van Buuren Groothuis-Oudshoorn 2011 mice multivariate imputation chained equations R`

**Action:** Verify full citation details via Perplexity, add bib entries, add `{cite:p}` references in chapter text.

---

### V6: NAICS code 238220 — Plumbing, Heating, and Air-Conditioning Contractors

**Chapter claim (line 21):** Uses NAICS 238220 as example, described as "Plumbing, Heating, and Air-Conditioning Contractors."

**Perplexity query:** `NAICS code 238220 description plumbing heating air conditioning contractors`

**Action:** Confirm code-to-description mapping is accurate. Quick verification.

---

### V7: Title 13 and CIPSEA — data sensitivity claims

**Chapter claim (line 35):** "Data sensitivity that genuinely prohibits cloud API access: Title 13 data, CIPSEA-protected microdata, data with legal restrictions on transmission to external services."

**Perplexity query:** `Title 13 Census data cloud processing restrictions CIPSEA confidential information protection`

**Action:** Verify that Title 13 and CIPSEA do in fact prohibit transmission to external cloud APIs. This is a legal claim that should be accurate. No citation needed for the laws themselves, but accuracy of the characterization matters.

---

## Process Note

This is the dual-path verification process. Web search (path 1) was attempted during the audit session. Perplexity (path 2) is this task. Both paths must agree before numbers or claims are accepted. Where both paths fail to verify, claims are either softened, reframed as judgment, or marked `[NEEDS:]` for author resolution.
