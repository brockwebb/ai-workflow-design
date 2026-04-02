# Perplexity Verification Queries — Chapter 3 Content Audit

**Date:** 2026-04-01
**Source:** `audits/chapter-03_content_audit.yaml`

---

## Query 1: NAICS code 238220
**Finding:** paragraph 9, citation_gap
**Claim:** NAICS code 238220 = Plumbing, Heating, and Air-Conditioning Contractors
**Query:** `NAICS code 238220 description plumbing contractor 2022`
**Purpose:** Confirm the specific NAICS code used in the illustrative example is correct.

## Query 2: Self-reported coding error rates
**Finding:** paragraph 17, citation_gap
**Claim:** Respondents frequently mis-report NAICS/SOC/NAPCS codes
**Query:** `self-reported NAICS SOC coding error rates survey methodology Census`
**Purpose:** Find authoritative source for self-reported coding error prevalence in federal surveys. Foundational claim for the chapter.

## Query 3: NAICS coding error downstream impact
**Finding:** paragraph 25, citation_gap
**Claim:** Bad NAICS codes affect industry tabulations, economic indicators, and stratified analyses
**Query:** `impact NAICS coding errors economic indicators industry tabulation Census BLS`
**Purpose:** Find documentation of how coding errors propagate to published statistics.

## Query 4: Agencies fine-tuning models for NAICS/NAPCS
**Finding:** paragraph 31, citation_gap
**Claim:** Some agencies are fine-tuning small language models for NAICS and NAPCS coding
**Query:** `federal agencies fine-tuning language models NAICS NAPCS coding Census BLS`
**Purpose:** Find public references to federal agency fine-tuning efforts for statistical coding. If none found, claim should be reframed as author observation.

## Query 5: Fine-tuning TCO components
**Finding:** paragraph 33, citation_gap
**Claim:** Fine-tuning requires training data curation, compute, evaluation, retraining, hosting, MLOps, staff expertise
**Query:** `fine-tuning total cost of ownership MLOps lifecycle costs language model deployment`
**Purpose:** Find a TCO analysis or cost framework for LLM fine-tuning that supports the component list.

## Query 6: Title 13 and CIPSEA data restrictions
**Finding:** paragraph 35, citation_gap
**Claim:** Title 13 and CIPSEA prohibit cloud API access for protected data
**Query:** `Title 13 CIPSEA data protection cloud computing restrictions Census Bureau`
**Purpose:** Confirm the specific legal frameworks and their implications for cloud AI services.

## Query 7: Federal IT procurement timeline
**Finding:** paragraph 35, citation_gap
**Claim:** Institutional deployment of local AI infrastructure takes 6-18 months
**Query:** `federal government IT procurement timeline cloud authorization FedRAMP months`
**Purpose:** Find documentation of typical federal procurement/authorization timelines for IT infrastructure.

## Query 8: LLM schema mapping capabilities
**Finding:** paragraph 47, citation_gap
**Claim:** LLMs can read source schemas, propose mappings, auto-generate target schemas, propose join keys
**Query:** `LLM schema mapping data integration automated crosswalk generation research`
**Purpose:** Find research or case studies on LLM-based schema mapping and data integration.

## Query 9: LLM vs. traditional NLP for open-ended responses
**Finding:** paragraph 69, citation_gap
**Claim:** Topic models, keyword extraction, and sentiment analysis are crude approximations compared to LLMs
**Query:** `LLM versus topic models keyword extraction open-ended survey response analysis comparison`
**Purpose:** Find comparative studies of LLMs vs. traditional NLP methods for open-ended text analysis.

## Query 10: Imputation methods and distributional properties
**Finding:** paragraph 81, citation_gap
**Claim:** MICE, hot-deck, Fellegi-Holt preserve distributional properties and respect survey design effects
**Query:** `MICE hot-deck Fellegi-Holt imputation methods survey data distributional properties`
**Purpose:** Find standard reference for established imputation methods and their statistical properties.

## Query 11: LLM limitations for statistical imputation
**Finding:** paragraph 81, citation_gap
**Claim:** LLMs do not maintain distributional properties and have no concept of survey design
**Query:** `LLM imputation distributional properties statistical bias survey design effects`
**Purpose:** Find evidence that LLM-based imputation fails to preserve distributional properties.

---

## Priority Order for Verification

**High priority (foundational claims):**
- Query 2 (coding error rates — chapter's core premise)
- Query 5 (fine-tuning TCO — anchors a major section)
- Query 10 (imputation methods — supports the boundary argument)

**Medium priority (specific factual claims):**
- Query 6 (Title 13/CIPSEA — legal accuracy matters)
- Query 7 (procurement timelines — repeated twice, cascades to Ch 13)
- Query 9 (LLM vs. traditional NLP — supports strong comparative claim)
- Query 11 (LLM imputation limits — supports the boundary argument)

**Lower priority (supporting details):**
- Query 1 (NAICS 238220 — likely correct, easy to verify)
- Query 3 (error propagation — well-known but good to cite)
- Query 4 (agencies fine-tuning — may not have public references)
- Query 8 (schema mapping — supporting capability claim)
