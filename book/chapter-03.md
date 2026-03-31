# Chapter 3: Data Wrangling & Standardization Workflows

<!-- STATUS: Draft -->
<!-- Primary Working Principle: Outputs require full provenance -->
<!-- Primary Tenet: Data precedes models -->

## The Code Says 999999

A respondent self-reported their NAICS code as 999999. Their free-text business description says "I fix toilets and sinks in people's houses." A human coder would read the description, look up the plumbing contractor code (238220), and fix it. An LLM can do the same thing. But you have 200,000 records with bad codes, and you need to verify 200,000 corrections.

This is not classification in the Chapter 2 sense. In Chapter 2, the input was well-formed: clear survey questions mapped to a structured taxonomy. Here, the input itself is the problem. Wrong codes, ambiguous descriptions, inconsistent formats, data arriving in five different file layouts. The LLM's job is not to classify clean input. It is to interpret messy human input and map it to structured output.

The design challenge is verification at scale. An LLM that proposes a "corrected" NAICS code with high confidence is performing what Chapter 4 will call confidence laundering if there is no evidence chain for why that correction is right. The dual-model patterns from Chapter 2 apply, but the error modes are different because the input quality is worse. When the input is noisy, single-model confidence is even less trustworthy than it was for clean classification.

## Response Code Correction

This is the core use case. Respondents self-report codes (NAICS, SOC, NAPCS, and others) and get them wrong. Sometimes wildly wrong: a restaurant coded as a hospital. Sometimes plausibly wrong: a general contractor coded as a specialty trade contractor. LLMs can read the free-text description alongside the reported code and propose corrections.

This is classification (Chapter 2 patterns apply) but with dirty input. The error modes are different from clean-input classification in important ways. The respondent's description might itself be ambiguous ("I do construction work" could be half a dozen NAICS codes), incomplete ("I work with computers"), or wrong (the description does not match what the business actually does). The LLM is reasoning over two unreliable signals: a code that is probably wrong and a description that may not be right either.

Dual-model cross-validation matters even more here than it did in Chapter 2. When input noise makes single-model confidence less reliable, the disagreement signal between two independent models becomes the primary quality indicator. If both models independently read "I fix toilets and sinks" and propose 238220 (Plumbing, Heating, and Air-Conditioning Contractors), you have meaningful convergence. If they disagree, the disagreement tells you something about the ambiguity of the input, not just about the models.

Confidence routing follows the same pattern as Chapter 2: high-confidence corrections auto-accept, low-confidence corrections route to the human review queue. But the thresholds may need to be different. Input noise means the pipeline will produce more low-confidence cases, and the fraction requiring human review will be larger than for clean-input classification. Design for that. Budget the human review time alongside the API cost.

Position in the pipeline matters. Code correction happens after initial data receipt and before downstream analysis. Getting this wrong propagates silently. A bad NAICS code that passes through correction unchallenged affects industry tabulations, economic indicators, and any analysis that stratifies by industry. The error is invisible in the output file. It looks like a valid code.

> *You have 200,000 records with self-reported NAICS codes. A quality audit of a 1% sample suggests 25% of codes are wrong. How do you estimate the total correction workload before running the full pipeline? What is the cost of not correcting them?*

## The Fine-Tuning Cost Trap

Some agencies are fine-tuning small language models for NAICS and NAPCS coding. This is a legitimate approach, and in specific circumstances it is the right one. But most teams that go down this path do not do the cost comparison honestly.

**The comparison most teams skip.** Fine-tuning requires training data curation (who labels the training set, and how do you know the labels are right?), compute for training (GPU time, cloud or on-premises), an evaluation harness (you need to measure whether the fine-tuned model is better than what you had), retraining when the classification system updates (NAICS revisions, SOC updates), model hosting and serving infrastructure, MLOps overhead for all of the above, and staff expertise to manage the full lifecycle. The API approach requires prompt engineering, a dual-model verification pipeline (Chapter 2 patterns), and API costs per call. For most use cases, the total cost of ownership for fine-tuning exceeds the API approach, often by a large margin, because people account for the API cost but not for the human engineering cost of the fine-tuning pipeline.

**When fine-tuning is the right call.** Be honest about the cases where it earns its place. Data sensitivity that genuinely prohibits cloud API access: Title 13 data, CIPSEA-protected microdata, data with legal restrictions on transmission to external services. Latency requirements for real-time coding at production scale where API round-trip time is a binding constraint. Offline deployment requirements where network access is unavailable or unreliable. But even in these cases, the institutional deployment tax from Chapter 13 applies: finding the budget, navigating security review, procuring and installing hardware, getting priority in the infrastructure queue, setup and staff learning, quality benchmarking against the existing process. This can take 6 to 18 months before you process a single production record.

**The uncomfortable truth.** If institutional constraints block API access and the fine-tuning/local deployment path takes 18 months, practitioners are stuck with traditional NLP (bag of words, regex, rule-based systems) that everyone knows is inferior for this task. The design discipline here is making the cost and timeline comparison explicit so leadership can make an informed access decision. Connect this to Chapter 12 (security controls as enabling, not prohibitive) and Chapter 13 (governance that prevents delivery is governance failure).

**If you are going down the local deployment path, do not wait for the hardware to start learning.** Build your pipeline, evaluation harness, and quality benchmarks against public data or synthetic data now, before the procurement clears, before the GPU arrives, before the security review finishes. Use public NAICS descriptions, synthetic respondent data, or any non-restricted dataset that exercises the same classification logic. When the infrastructure finally arrives, you should be validating a proven pipeline against production data, not writing your first prompt. The procurement and security process takes 6 to 18 months. That is 6 to 18 months of pipeline development, evaluation design, and benchmark construction you can do in parallel, if you plan for it.

**On small language models.** The SLM landscape is evolving fast. Models that are marginal today may be substantially more capable in 12 to 18 months. The design patterns in this book, dual-model verification, confidence routing, structured arbitration, provenance tracking, apply regardless of whether the model is a frontier API model or a local quantized SLM. If you build the pipeline right, swapping the model underneath is a configuration change (Chapter 7), not a redesign. That is the entire point of model-agnostic architecture.

## Schema Inference and Data Combination

Data arrives from disparate sources with different structures. CSV files with different headers. Excel workbooks with different column names. Databases with different schemas. The task: combine them into a unified target schema.

LLMs can read the source schemas and propose mappings. Auto-generate a target schema from the union of source fields. Propose join keys and crosswalks between fields. Identify semantic equivalences: "household_income" in one file is "hh_inc" in another.

The schema proposal is a draft, not a final product. Human review of the proposed schema is essential. Semantic equivalences can be wrong: "income" could mean gross or net, pre-tax or post-tax, individual or household. The LLM is pattern-matching on field names and sample values, not reasoning about the construct definitions behind the data. A field called "income" in two different surveys may measure different things, and the LLM has no way to know that without the metadata that Chapter 8's evaluation framework and the Pragmatics system's expert judgment layer are designed to provide.

Log the schema mapping decisions. When someone asks six months later why Field A was joined to Field B, the evidence chain exists (Chapter 10). This is a high-value, low-risk LLM application: the LLM proposes, the human reviews, the cost of the proposal is trivial, and the cost of getting it wrong is caught at review before it propagates.

## Format Extraction and Standardization

The "data arrived in five different formats" problem. Responses in Excel, Notepad, Word documents. Different layouts, conventions, structures. The LLM extracts information and maps it into a target schema.

This is the universal parser use case. LLMs handle format diversity better than any rule-based system because they can interpret structure from context rather than requiring explicit parsing rules for each format. A rule-based parser needs a new rule for every variation. An LLM reads the document and maps what it finds to the schema you defined.

Define the target schema first. This is the config-driven pattern from Chapter 7: the LLM maps to the schema, it does not invent one. The schema is the contract. It lives in configuration. It is versioned. The LLM is a tool for mapping diverse inputs to that contract, not for deciding what the contract should be.

Verification: spot-check extraction against source documents. Extraction errors on structured data (wrong field mapping) are different from extraction errors on unstructured data (misinterpretation of content). Both need detection, but the detection methods differ. For structured data, automated schema validation catches most errors. For unstructured data, human review of a stratified sample is usually necessary.

This is typically a one-time or periodic task (ingesting a new data source), not a continuous production pipeline. The cost and speed tradeoffs are different from the code correction use case: you optimize for correctness and completeness, not for throughput.

## Semantic Analysis of Open-Ended Responses

Public comments, free-text survey fields, open-ended response data. Not classification into a fixed taxonomy (Chapter 2) but interpretation, summarization, theme extraction.

This is where LLMs have the clearest advantage over any prior method. No traditional NLP approach handles open-ended semantic analysis at this quality level. Topic models, keyword extraction, and sentiment analysis are crude approximations compared to what a language model can produce from the same input.

But theme extraction is inherently subjective. Two models may extract different themes from the same corpus. This is the dual-model disagreement signal from Chapter 2: disagreement on themes is information about the ambiguity of the input, not error. When two models converge on the same themes independently, you have meaningful signal. When they diverge, the divergence tells you which themes are robust and which are artifacts of a particular model's perspective.

Provenance matters. Which responses contributed to which themes? Can you trace a summary back to the source responses that generated it? Chapter 10's provenance requirements apply: the theme extraction output should be traceable to the input that produced it, the model that generated it, and the prompt that framed the task.

The evaluation trap from Chapter 8 applies directly: how do you evaluate whether theme extraction is "correct" when there is no ground truth? The answer is the same as Chapter 8's thesis: build the evaluation instrument alongside the extraction pipeline. Define what "good" theme extraction means for your domain (coverage, specificity, faithfulness to source), and evaluate against those criteria.

## Where Traditional Methods Still Win

Knowing where not to use LLMs is as important as knowing where to use them. The boundary is the design discipline.

**Imputation of missing values.** MICE, hot-deck, Fellegi-Holt, and other established imputation methods preserve distributional properties, respect survey design effects (weights, clustering, stratification), and are theoretically well-understood. LLMs do not maintain distributional properties and have no concept of survey design. They will impute a plausible-looking value that has no relationship to the distribution of the variable in the population. For continuous variables and for maintaining statistical properties, traditional methods are not just adequate; they are superior.

**Continuous variable correction.** When the value is numeric and the correction needs to preserve distributional properties, statistical methods outperform LLMs. An edit/imputation system that enforces ratio constraints, bounds checking, and distributional consistency is doing work that a language model is structurally unable to do.

{cite:t}`tian_2025` showed LLM imputation outperforming MICE on categorical variables (F1 0.65 versus 0.50) in a real 2024 election survey, but at 40 times the computational cost. Even in the best case for LLMs, the cost-performance tradeoff is narrow, and it only favors LLMs on categorical variables where the "imputation" is closer to classification (what category does this record belong to?) than to statistical estimation (what value should this variable have?). This is evidence that the boundary is real, not an endorsement of replacing established imputation methods with LLMs.

The thesis: LLMs handle the *semantic reasoning* parts of the data quality pipeline. Traditional methods handle the *statistical* parts. The design discipline is routing each sub-task to the right tool.

### Thought Experiment

You receive a dataset of 500,000 business registrations with self-reported NAICS codes and free-text business descriptions. Quality audit of a sample suggests approximately 25% of NAICS codes are wrong. Design the correction pipeline:

- How do you use the free-text descriptions to propose corrections? What about records with no description?
- How do you decide which corrections to auto-accept versus route to human review?
- How do you evaluate whether your correction pipeline is actually improving data quality, given that you do not have ground truth for most records?
- At what scale does the API cost argument change? Is there a volume threshold where fine-tuning becomes cost-effective?
- How would your design change if the data is Title 13 protected and cannot leave the agency network?

---

Chapter 3 addressed the problem of fixing and standardizing data you already have. Chapter 4 addresses extracting structured data from unstructured sources, entity extraction, pattern detection, disclosure review, where the design challenge shifts from "correct the record" to "find the signal." The confidence laundering risk previewed in this chapter gets its full treatment there.
