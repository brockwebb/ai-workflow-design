# Glossary

```{glossary}
counterbalancing
: A standard experimental design technique for controlling order effects by systematically varying the sequence in which conditions are presented. In LLM evaluation, applied as position bias control: present the options in one order, then the reverse (the A-B-B-A sequence, often called the "ABBA" notation), and check whether results are order-invariant. If results change with ordering, the judgment is unstable and should not be trusted. The book applies counterbalancing wherever models compare, rank, or choose between options. See Chapters 2, 4, and 5.

agency
: Granted decision-making authority. Agency is conferred by a system designer, not inherent to a model. Granting less agency is often the better design choice. See Chapter 11.

agent
: An entity that performs work within a workflow. In agentic AI, the agent is typically an LLM operating with granted authority over a defined set of actions. See Chapter 11.

agentic
: Behavior in which an AI system exercises granted decision-making authority within a workflow. Agentic is a property of behavior, not of the system itself. See Chapters 11 and 13.

agreement scoring
: A quantitative measure of how often independent models produce the same output on the same input. Used as a confidence signal and quality metric in multi-model pipelines. Cohen's kappa and Fleiss' kappa are standard agreement statistics from inter-rater reliability applied to LLM outputs. See Chapters 2 and 5.

ATO (Authority to Operate)
: A formal security authorization that permits an information system to operate at a federal agency. Traditionally designed for stable, long-lived systems; poses significant friction for AI workflows where models, prompts, and configurations change continuously. Enterprise ATO models authorize a platform and pattern rather than a specific system version, reducing re-authorization burden. See Chapter 13.

batch economics
: The cost and throughput characteristics of processing large, predictable volumes of work through AI pipelines. Statistical workflows are naturally batch-oriented — thousands of records with no real-time latency requirement — which enables cost optimization through tier selection, off-peak scheduling, and efficient token use. See Chapters 6 and 14.

bounded agency
: The design principle that AI systems with explicit constraints, defined scope, and human oversight outperform fully autonomous systems in high-stakes contexts. The preferred operating model for AI in federal statistical work. See Chapters 1 and 13.

Bradley-Terry aggregation
: A statistical method for converting pairwise comparison judgments into interval scales. Used in DiGiuseppe and Flynn (2026) to aggregate six LLMs' pairwise comparisons of survey response quality into a reliable scale. Each LLM provides comparative judgments ("which response shows more knowledge?"); Bradley-Terry converts those comparisons into a ranking. See Chapter 4.

checkpoint
: A saved record of pipeline state at a specific point in processing, enabling resumption after failure without restarting from the beginning. Minimum contents: which records have been processed, their results, and enough state to continue from the next unprocessed record. Transaction-safe writes (write to temp file, then atomically rename) prevent checkpoint corruption. See Chapters 6 and 7.

cloud parity gap
: The lag between availability of AI capabilities in commercial cloud environments and in authorized government cloud environments (FedRAMP-authorized regions). Typically months to over a year. New model releases and features reach commercial regions first; government regions follow. Practical consequence: federal practitioners often cannot access the most capable models when they are most useful. See Chapter 13.

compaction
: Automated summarization or truncation of an LLM's context window to fit token limits. A source of Compression Distortion (T3) in the SFV threat taxonomy. Compaction is lossy: the system decides what to preserve and what to discard, and may silently drop methodological caveats or decision rationale. See Chapters 9 and 11.

Compression Distortion (T3)
: An SFV threat: compaction or summarization causes a pipeline to lose nuance, qualifications, or specificity from earlier state. The pipeline continues operating on a degraded representation of prior decisions. A dropped exclusion criterion or a compressed methodological caveat are concrete examples. See Chapter 9.

Compression Fidelity (CF)
: An SFV sub-dimension: the degree to which context window management (summarization, compaction, chunking) preserves the accuracy of prior state rather than introducing distortion. Relevant to extraction pipeline design: chunking at token boundaries rather than semantic boundaries degrades CF. See Chapters 4 and 9.

config-driven architecture
: The design pattern of externalizing all configurable pipeline parameters (model names, API endpoints, thresholds, batch sizes, retry limits, checkpoint intervals) into version-controlled configuration files rather than hardcoding them in source code. Prevents silent configuration drift, makes settings auditable, and enables model swaps without code changes. The "save the random seed" principle extended to LLM pipelines. See Chapters 7, 9, and 10.

confabulation
: The generation of content that is presented as factual but is not grounded in the pipeline's actual inputs, history, or source documents. The precise term per NIST AI 600-1; preferred over "hallucination" because confabulation is a clinical term describing a specific failure mode (confident false assertion) rather than a generic error label. Confabulation is particularly dangerous in extraction and state management contexts because it looks the same as valid output. See Chapters 1, 4, 8, and 9.

confabulation graph
: A knowledge graph produced by an extraction pipeline that cannot trace its edges and nodes back to specific source passages with provenance. The graph looks structured and authoritative but contains a mixture of extracted facts and model-generated inferences that cannot be distinguished after the fact. The design antidote: every extracted element must carry a citation to the source passage, model version, and prompt that produced it. See Chapter 4.

confidence laundering
: A term introduced in this book. Confidence laundering occurs when a pipeline converts uncertain, unverified extraction output into a structured artifact whose format implies verification that never occurred. Typed nodes, labeled edges, and clean visualizations create confidence in the content, but the content was produced by a stochastic process. The structure launders the uncertainty out of the presentation without laundering it out of the data. Distinct from "AI-washing" (misrepresentation in marketing), automation bias (human over-trust of automated output), and epistemic opacity (opacity of model reasoning); confidence laundering is a design-level failure in pipeline architecture, not a cognitive or marketing phenomenon. Introduced in Chapter 3; defined in Chapter 4.

confidence-based routing
: Directing pipeline outputs along different paths based on confidence score. High-confidence results auto-accept; low-confidence results escalate to human review or arbitration. A specific implementation of the general principle that AI handles volume and humans handle judgment. Requires calibrated confidence scores. See Chapters 2 and 3.

context window
: The token buffer containing an LLM's current operative state — inputs, instructions, conversation history, intermediate results. In SFV terms, the context window IS the instrument: its integrity is a validity condition. Context windows are mutable, finite, and subject to compaction. Critical state that lives only in the context window can be silently dropped. See Chapters 1, 9, and 11.

disagreement as signal
: The design principle that when two independently trained models produce different outputs on the same input, the disagreement is valuable information rather than noise. Disagreement surfaces genuine ambiguity, taxonomic boundary problems, and low-confidence cases. A pipeline that surfaces disagreements is more informative than one that hides them. See Chapters 2, 3, 4, and 5.

dual-model cross-validation
: A pipeline architecture in which two architecturally distinct models (different vendors, different training, different alignment) independently process the same input and their outputs are compared. Agreement indicates confidence; disagreement triggers escalation or arbitration. Directly analogous to inter-rater reliability in survey methodology. See Chapters 2, 3, and 5.

evidence chain
: A complete, traceable record linking a published output to its inputs, the models used, the prompts sent, the confidence scores returned, and the decision rules applied at each stage. The evidence chain is the difference between a result you can defend and a result you cannot. See Chapters 1, 2, and 10.

False State Injection (T2)
: An SFV threat: the pipeline incorporates incorrect information — from confabulation, tool error, or flawed intermediate result — and treats it as valid prior state. The pipeline then builds further analysis on a false foundation. In multi-session workflows, the false state may masquerade as institutional memory of decisions that never occurred. See Chapter 9.

FCSM
: Federal Committee on Statistical Methodology. Sets quality standards for federal statistical products: relevance, accuracy, timeliness, accessibility, interpretability, and coherence. FCSM 20-04 provides the quality framework that applies simultaneously with NIST AI RMF when AI participates in federal statistical production. See Chapter 8.

FedRAMP
: Federal Risk and Authorization Management Program. The authorization framework for cloud services used by federal agencies. A service must achieve FedRAMP authorization at the appropriate impact level before agencies can use it for production workloads. A primary gate between available AI capability and deployable AI capability in government settings. See Chapters 12 and 13.

fine-tuning
: Adapting a pre-trained model to a specific task by training it further on task-specific labeled data. For statistical coding tasks (NAICS, SOC, NAPCS), fine-tuning can improve accuracy on domain-specific classification. See the fine-tuning cost trap entry for the common failure mode. See Chapter 3.

fine-tuning cost trap
: The failure to account for the full total cost of ownership when comparing fine-tuned local models against API-based approaches. Teams typically account for API inference cost but omit training data curation, compute, evaluation harness development, retraining costs when taxonomies update, model hosting infrastructure, MLOps overhead, and staff expertise. The comparison most teams skip: total cost of fine-tuning pipeline versus total cost of API-based dual-model pipeline. See Chapter 3.

Five Safes
: A framework for data access governance developed at the UK ONS and adopted internationally. The five safes: safe projects (appropriate use?), safe people (trained users?), safe settings (secure environment?), safe data (appropriate protection applied?), safe outputs (non-disclosive results?). Applies naturally to AI workflows because the core question is the same: how to provide access for legitimate purposes while managing risk. See Chapters 12 and 13.

generator-critic loop
: A multi-model topology in which one model generates output and a second model evaluates it, with evaluation feedback feeding back to the generator for revision. More robust than same-model self-refinement because the critic's failure modes are independent of the generator's. Key design constraints: cross-model (not same-model) evaluation, explicit termination conditions, maximum iteration caps, and specific actionable rejection feedback. See Chapter 5.

golden test set
: A curated collection of inputs with known-correct outputs that a pipeline must handle correctly. Design properties: domain-representative (including edge cases and genuinely ambiguous cases), version-controlled, and living (grows as new failure modes are discovered). Run after every pipeline change (model update, prompt revision, config change) to detect regressions before they reach production. See Chapters 2, 7, 8, and 9.

handoff document
: Explicit written serialization of accumulated pipeline state for session continuity. Captures decisions made, rationale, open questions, and enough context to reconstruct the working state without relying on the context window. An engineering countermeasure to State Discontinuity (T5). See Chapters 7 and 10.

idempotent operation
: An operation that produces the same result whether run once or multiple times. In LLM pipelines: a batch retried after transient failure should not produce duplicate results, corrupt state, or double-count records. Write operations (saving results, updating checkpoints) must be idempotent so that re-execution is safe. See Chapter 7.

imputation
: The process of filling in missing values in survey data using statistical methods. Hot-deck, regression, and multiple imputation (MICE) are the standard approaches in federal surveys. LLMs outperform MICE on categorical variables (classification of what category a missing value should belong to) but not on continuous variables where statistical properties must be preserved. See Chapter 3.

inter-rater reliability
: Statistical measures of agreement between independent raters on a classification or coding task. Cohen's kappa (two raters), Fleiss' kappa (three or more raters), and Krippendorff's alpha are the standard statistics. Applied to LLM pipelines: two independently trained models are treated as independent raters, and their agreement rates provide evidence of task well-definedness and classification confidence. See Chapters 2 and 5.

judge loop
: See *LLM-as-judge*.

knowledge graph
: A structured representation of entities and relationships extracted from a corpus. LLM-built knowledge graphs are vulnerable to confidence laundering: the visual structure of nodes and edges creates apparent authority regardless of whether the content is grounded in source documents. See *confabulation graph*. See Chapter 4.

last mile problem
: The gap between a pipeline that works in a development environment and one that works in production with real institutional constraints. For federal researchers: running inside authorized cloud environments with limited service catalogs, meeting data residency requirements, satisfying audit logging requirements, and operating within security-constrained network configurations. The demo works; the last mile is what it costs to get from the demo to deployed. See Chapters 11 and 13.

LLM-as-judge
: A multi-model topology in which a model is explicitly tasked with evaluating another model's output against defined criteria (a rubric). Three variants: tie-breaking arbiter (adjudicates disagreements between two generators), quality gate (every output passes through a judge before production), and pairwise comparison (judge selects the better of two candidate outputs). Rubric design is the practitioner skill: criteria must be domain-grounded, decomposed into multiple dimensions, and versioned. See Chapter 5.

MCP (Model Context Protocol)
: An open protocol for connecting AI agents to external data sources and tools. MCP servers expose structured interfaces that agents can query; the agent decides what to query and when, rather than following a predefined pipeline sequence. Tool design is the observability strategy in MCP-based systems: if tools only return final answers, there is no intermediate data for monitoring; tools designed to return structured metadata, confidence scores, and provenance enable evaluation. See Chapter 11.

model card
: Standardized documentation for a trained model reporting intended use, performance metrics, training data characteristics, ethical considerations, and limitations. Proposed by Mitchell et al. (2019). Agencies should require model cards as part of AI procurement and deployment review. A model card's description of training data as "internet data" without further specification is a model provenance flag. See Chapter 12.

model provenance
: The documented origin and transformation history of a trained model: training data sources, training process, organizational governance, fine-tuning or post-processing applied, and hosting jurisdiction. A trust decision, not just a performance decision. Models trained on unknown data from organizations under different legal jurisdictions introduce compliance risk that benchmark scores do not capture. See Chapter 12.

model transience
: The design constraint that the models available today will not be the models available in six months. Models deprecate, update silently, change pricing, and get superseded. Design implication: model-agnostic pipeline architecture (model identifiers in configuration, not hardcoded), golden test sets for detecting drift after updates, and version pinning with scheduled expiration review. See Chapters 2, 6, and 9.

model version pinning
: Locking pipeline configuration to a specific dated model version identifier rather than a floating alias. Prevents silent behavior changes from vendor updates between pipeline runs. Required for reproducibility. Treat the model identifier as a software dependency version: pin it, test it, and document when you upgrade. See Chapters 2, 6, 7, and 9.

NIST AI 600-1
: The Generative Artificial Intelligence Profile, published by NIST in 2024. Identifies 12 risk categories specific to generative AI, including confabulation, information integrity risks, harmful bias, and data privacy concerns. Maps suggested actions to the AI RMF GOVERN-MAP-MEASURE-MANAGE structure. The most specific NIST guidance available for evaluating generative AI tools. Establishes "confabulation" as the precise term for outputs presented as factual but not grounded in actual inputs. See Chapters 8, 9, and 12.

NIST AI RMF
: The Artificial Intelligence Risk Management Framework (NIST AI 100-1), published January 2023. A voluntary, sector-agnostic framework for managing AI risks through four functions: GOVERN, MAP, MEASURE, and MANAGE. The primary federal AI governance framework. Used in this book for the FCSM/NIST crosswalk: when AI participates in federal statistical production, both the FCSM quality framework and NIST AI RMF apply simultaneously. See Chapters 7, 8, and 12.

90/10 rule
: The empirical observation that the first 90% of capability from any orchestration tool is easy to achieve, while the last 10% — edge cases, error handling, integration with specific institutional infrastructure, compliance logging — consumes 90% of the effort. Evaluate tools on last-mile fit, not demo capability. Related: the last mile problem. See Chapter 11.

pairwise comparison
: Asking an LLM to compare two items and select which better satisfies a criterion, rather than asking it to assign an absolute score. LLMs produce more reliable judgments from pairwise comparison than from absolute rating, because comparative judgment plays to the model's strengths (relative pattern recognition) rather than its weaknesses (absolute calibration). Used in DiGiuseppe and Flynn (2026) for survey response quality assessment; aggregated via Bradley-Terry. See Chapters 4 and 5.

parallel consensus
: A multi-model topology in which N models independently process the same input and their outputs are compared. Agreement indicates confidence; disagreement triggers escalation. The canonical multi-model pattern for classification and coding tasks. Direct application of inter-rater reliability methodology to LLM outputs. See Chapters 2 and 5.

position bias
: The tendency of LLM outputs to vary based on the order in which options or inputs are presented. In classification: the model's preference may be influenced by which category appears first in the prompt. In pairwise evaluation: which item appears first affects the comparison result. ABBA design controls for position bias in evaluation; randomized option ordering controls for it in classification. See Chapters 2 and 5.

quantization
: A compression technique that reduces model precision (e.g., from 32-bit to 4-bit weights) to decrease memory footprint and inference cost while preserving most accuracy. AWQ (Activation-aware Weight Quantization) is currently recommended over pruning. Enables running capable models on agency hardware without API dependencies, relevant to the data-sensitivity use cases in the fine-tuning cost trap discussion. See Chapter 3.

recursive stochasticity
: The condition in which the tools used to build stochastic pipelines are themselves stochastic. AI coding assistants ignore configuration files, reinvent debugged infrastructure, suggest deprecated APIs, and lose architectural context at session boundaries. The same design discipline required for reliable LLM data pipelines applies to LLM development tools: specification before execution, config-driven architecture, regression testing, and state serialization. See Chapters 7 and 11.

regression testing
: Automated re-execution of a test suite after any pipeline change to detect whether something previously working has broken. In LLM pipelines: run the golden test set after every model update, prompt revision, configuration change, or framework update. Catches silent regressions before they propagate to production data. See Chapters 7 and 8.

Semantic Drift (T1)
: An SFV threat: key terms shift meaning across turns or sessions without explicit redefinition. The pipeline continues as if the terms are stable, introducing inconsistency that is difficult to detect because it looks like natural language variation. Example: a pipeline that begins using "family earnings" where it previously used "household income" may silently break downstream processing that depends on exact terminology. See Chapters 9 and 10.

Session Continuity (SC)
: An SFV sub-dimension: the degree to which state accumulated in prior sessions is accurately and completely preserved and accessible in subsequent sessions. Poor session continuity means prior decisions, constraints, and results must be reconstructed from incomplete records. Handoff documents and state serialization are the engineering countermeasures. See Chapter 9.

small language model (SLM)
: A language model with roughly 0.5–7 billion parameters, designed for domain-specific tasks where a fine-tuned small model can outperform a general-purpose large model at lower cost. SLMs can be quantized and deployed on agency hardware without API dependencies. Relevant to data sensitivity use cases (Title 13, CIPSEA) where external API transmission is prohibited. The SLM capability boundary is improving rapidly. See Chapter 3.

smoke test
: A quick sanity check run before committing to a full pipeline run. Run a small batch (10 items) before launching 50,000. Checks: does the model respond? Is the output format correct? Are the parameters accepted? Catches configuration errors and API issues before they cause failures at scale. See Chapter 7.

State Coherence (SCoh)
: An SFV sub-dimension: the degree to which all current active state elements are mutually consistent and free of internal contradiction. Contradictions in active state are State Supersession Failure (T4) violations: the old and new versions of a decision coexist in context and compete for influence. See Chapter 9.

State Discontinuity (T5)
: An SFV threat: a session boundary causes partial or complete loss of accumulated pipeline state. The next session must reconstruct state from an incomplete record, introducing error or loss of prior decisions. Handoff documents and state serialization are the engineering countermeasures. See Chapters 9 and 10.

State Fidelity Validity (SFV)
: The degree to which an AI-assisted research or analytic pipeline preserves the accuracy and integrity of its accumulated internal state across sequential operations, such that inferences at step N remain warranted by the actual history of steps 1 through N-1. SFV is a precondition for other validity claims: if the operative history is corrupted, no downstream validity claim is defensible. The five SFV threats (T1–T5) and sub-dimensions are the practitioner vocabulary for reasoning about and designing against state degradation. Developed by Webb (2026). See Chapters 9 and 10.

State Provenance (SP)
: An SFV sub-dimension: the degree to which the origin and transformation history of key state elements can be traced. Without provenance, it is impossible to audit why a pipeline reached a given conclusion. In extraction: every node and edge in a knowledge graph must have traceable provenance to a source passage, model version, and prompt. See Chapters 4, 9, and 10.

State Supersession Failure (T4)
: An SFV threat: a superseded decision, retracted finding, or corrected value persists in the pipeline alongside its replacement. The model's attention mechanism determines which version "wins" on any given query, producing unpredictable behavior. Common in multi-session workflows where earlier context carries forward. Config-driven architecture is the countermeasure: external configuration cannot be silently superseded the way context-window state can. See Chapter 9.

statistical disclosure limitation
: The set of methods used to reduce the risk that individuals, firms, or organizations can be re-identified from released statistics, microdata, or trained models and API endpoints. Also called statistical disclosure control (SDC) or disclosure avoidance. AI workflows require the same SDC review as traditional statistical outputs: small cell counts are small cell counts regardless of how they were produced. LLM memorization of training data fragments is an additional SDC concern specific to generative models. See Chapters 4 and 12.

stochastic liabilities
: Properties of LLM systems that require design responses rather than debugging. The term distinguishes features of the system's fundamental nature — irreproducibility across runs, coherent-sounding wrong answers, inability to characterize error distributions in classical statistical terms — from defects that can be fixed. You do not fix stochastic liabilities. You design around them. See Chapter 1.

stochastic tax
: The overhead accepted every time a task is routed through a probabilistic language model when a deterministic or seed-reproducible method would suffice. Every unnecessary LLM invocation adds variance, cost, and audit burden. The design discipline of this book is, at its core, about minimizing the stochastic tax — not eliminating LLMs, but constraining their use to where they are genuinely needed. See Chapters 1, 2, and 9.

TEVV
: Test, Evaluation, Verification, and Validation. The NIST AI RMF term for systematic AI system assessment. All four components are required for federal AI use; each addresses a distinct question about system trustworthiness. Operationalized in this book as progressive test infrastructure: unit tests, smoke tests, regression tests, and golden test set evaluation. See Chapters 7 and 8.

Terminological Consistency (TC)
: An SFV sub-dimension: the degree to which key technical terms retain consistent meaning across all sessions and pipeline stages. Terminological drift is Semantic Drift (T1). In extraction pipelines: the failure to resolve "Census Bureau," "the Bureau," and "U.S. Census Bureau" to a single canonical entity is a TC failure. See Chapters 4 and 9.

token budget
: A deliberate allocation of context window capacity to different pipeline components — system prompt, configuration, task specification, data, intermediate results. The context window is a scarce resource to be managed, not a limitless workspace. Exceeding the implicit token budget causes compaction, which is a Compression Distortion (T3) risk. See Chapters 11 and 14.

training cutoff
: The date beyond which a model has no knowledge from its training data. Events, models, APIs, and best practices that postdate the cutoff are unknown to the model; queries about them produce confabulation. The training cutoff is a permanent, pervasive instance of State Supersession Failure (T4): everything the model "knows" about the current environment is from before the cutoff and has been partially superseded. Config-driven architecture is the primary countermeasure: do not let the model decide what is current. See Chapters 7 and 9.

workflow
: A defined sequence or graph of steps to accomplish a goal, executed by humans, AI, or combinations. Not all workflows involve agents; not all agents are part of complex workflows. In this book, "workflow" refers specifically to structured data processing pipelines for statistical production, where defensibility and provenance are design requirements.
```
