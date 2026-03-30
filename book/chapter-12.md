# Chapter 12: Security, Supply Chain, and Model Provenance

<!-- STATUS: Draft -->
<!-- AUDIENCE: Practitioners building AI workflows AND security/IT professionals supporting them -->
<!-- Organizing principle: Five Safes framework applied to AI/LLM workflows -->
<!-- Working Principle: Security is a system property -->
<!-- Tenet: Trust defines the mission -->

## The Controls That Let You Work

A researcher downloads an open-source language model to run locally, outside of any cloud service. No API calls, no data leaving the building. The job starts, processes a few hundred records, then fails. The network went down. Why would an offline model need the network?

Because the model's tokenizer configuration was being fetched from a remote repository on first load. The "local" inference was making network calls the researcher never asked for and never knew about. Offline wasn't offline.

This is not a story about a security breach. No data was leaked, no policy was violated. It is a story about assumptions. The researcher assumed "local" meant "contained." The system did not share that assumption. Security in AI workflows is not about preventing researchers from working. It is about making sure the systems do what you think they do, so you can use them confidently.

The controls described in this chapter exist so you *can* use these tools. They are enabling, not prohibitive. Security is a system property, not a gate you pass through once and forget. It is present in every design decision, from model selection to data handling to output review. And it maps directly to what the statistical community already knows how to do.

## The Five Safes Framework

The Five Safes framework {cite:p}`desai_2016`, developed at the UK Office for National Statistics and adopted internationally by the Australian Bureau of Statistics, Statistics New Zealand, Eurostat, and embedded in the UK Digital Economy Act and Australia's Data Availability and Transparency Act, provides the organizing principle for this chapter.

Every agency in the federal statistical system is already doing these things under different names with different processes. The Five Safes provides a common vocabulary: safe projects, safe people, safe settings, safe data, safe outputs. Extending it to cover AI workflows is a natural fit, because the core question is the same: how do you provide access to data for legitimate purposes while managing risk?

For organizations looking to adopt a standardized framework for AI data access decisions, the Five Safes is a strong recommendation. It maps to what everyone already does with minimal mental effort. What follows applies each safe to the specific considerations that AI workflows introduce.

A note for security and IT professionals: the workflow design patterns throughout this book can inform how you build and evaluate AI systems in your own domain. That application is beyond the scope of what we cover here, but the principles transfer.

## Safe Projects: Is This Use of AI Appropriate?

The question is not "should we use AI?" That question has been answered by the people already using it. The question is: does this specific project justify the controls that come with it?

People should be using these tools for learning, exploration, literature review, drafting, and code assistance. A researcher using a public LLM to brainstorm survey question wording, review a draft methodology section, or generate boilerplate code is engaged in professional development and routine work. This is not a security incident. It does not require a governance review. Treating it as one is how organizations drive AI use underground, where there are no controls at all.

The project-level question separates routine use from production workflows that touch real data. A researcher exploring question wording on a public service is a different project from a pipeline classifying 50,000 records against a confidential frame. Same tool category, different risk profile, different controls. The Five Safes framework handles this naturally: the project determines the control level for every other safe.

*What questions should you ask about your AI project?*

| Question | What you're really asking |
|---|---|
| Does this project require AI, or would a deterministic method suffice? | Are you paying the stochastic tax unnecessarily? |
| What data will the AI system touch? | Determines the control level for every other safe |
| Is there a lawful basis for processing this data through an AI system? | Which statutory protections apply? |
| What is the public benefit? | The justification for the risk |
| Could this project be accomplished with a less sensitive subset of the data? | Minimum necessary principle applied to AI inputs |
| Has this use been reviewed by your data governance body? | Not a rubber stamp, a proportionate assessment |

## Safe People: Are Users Trained to Work with AI Appropriately?

Two groups of people need to understand each other's domain. Practitioners need to understand the stochastic nature of the tools, know what they can and cannot send to external services, and recognize when outputs need scrutiny. Security and IT professionals need to understand what AI workflows actually do, so they can provide useful guidance rather than blanket restrictions.

Training for practitioners is not "here's how to write a prompt." Training is: what does this tool do under the hood? Why might it be wrong? What do you never send to an external service? How do you tell whether the system you are using is approved for your data classification level? These are operational questions that determine whether someone can make sound decisions independently.

Training for security staff is equally important and more often neglected. An IT security professional who understands how an LLM inference pipeline works, what data flows where, and what the actual threat surface looks like can provide nuanced guidance. One who does not will default to "no," which is the correct answer when you do not understand the risk, but the wrong answer when understanding would have revealed an acceptable one.

*What questions should you ask about your people?*

| Question | What you're really asking |
|---|---|
| Do users understand the difference between public AI services and approved production systems? | Can they self-sort the appropriate tool for the appropriate task? |
| Can users identify when an LLM output needs verification vs. when it's low-stakes? | Do they understand the stochastic liability concept? |
| Do users know what data classifications they work with and what each permits? | Can they make the safe project determination independently? |
| Are security/IT staff trained on how AI workflows differ from traditional software? | Can they provide useful guidance, or only blanket "no"? |
| Is there an escalation path when someone isn't sure? | Better to ask than guess wrong |
| Do users understand that "free" services have terms of service regarding data use? | Free isn't free |

*How would you rate your own team on these questions? If you are a practitioner, could you explain to a security reviewer what data your pipeline sends where? If you are a security professional, could you describe what happens during an LLM inference call well enough to assess the risk?*

## Safe Settings: Is the Technical Environment Secure?

Where is the computation happening? Who controls the environment? What network paths does data traverse? Where are the servers physically located, and under whose jurisdiction?

The practical reality is a portfolio of settings, not a single choice. Approved cloud environments (FedRAMP authorized at the appropriate level) for some workloads. On-premises infrastructure for others. Public services for non-sensitive learning and exploration. The setting matches the data classification and the project risk profile.

"Offline isn't offline" is the recurring lesson. Local model inference that makes network calls for tokenizers, embedding models, configuration files, or telemetry has a network dependency that contradicts the "local" assumption. An air-gapped environment is only air-gapped if you have verified that every component of the pipeline functions without network access. This requires testing, not assuming.

The jurisdiction question matters. A model hosted in a country whose data protection laws conflict with your legal obligations is a compliance failure, not a policy debate. This is not hypothetical. Model hosting, API routing, and data residency requirements intersect in ways that require specific answers, not general assurances.

*What questions should you ask about your settings?*

| Question | What you're really asking |
|---|---|
| Is the AI service authorized at the appropriate level for your data? | Is this setting approved for this data classification? |
| Where are the servers physically located? Under whose jurisdiction? | Does the hosting jurisdiction's law conflict with your obligations? |
| Does the service retain input data? For how long? For what purpose? | Is your data being used to train future models? |
| If running locally, what network calls does the system make? | Is your "offline" system actually offline? |
| What is the provider's incident response and breach notification process? | If something goes wrong, how do you find out? |
| Are API calls logged and auditable? | Can you demonstrate what data went where? |
| Is there DLP or equivalent monitoring on outbound data to AI endpoints? | Technical control vs. policy-only control |

## Safe Data: Has Appropriate Protection Been Applied?

Before data enters an AI workflow, what has been done to protect it? The principle is the same as releasing microdata to researchers, except the "researcher" is an API endpoint that does not sign a confidentiality agreement.

De-identify before LLM processing. This is the minimum necessary principle applied to AI inputs: remove direct identifiers before data enters a prompt. Names, addresses, Social Security numbers do not belong in prompts, ever. If the task requires context that includes identifying information, the workflow design needs to provide that context through a mechanism that does not transmit it to an external service.

The prompt is the data exposure surface. Everything in a prompt is transmitted to the model provider for external APIs. This includes context, instructions, examples, and the data being processed. Minimize what goes in. Send the field that needs classification, not the entire record.

Use synthetic or aggregated data for development and testing. Real data goes into production environments that meet the appropriate authorization level. Development on a laptop with consumer-tier API access uses synthetic data. This is not a new principle; it is the same principle the statistical community applies to research data access, applied to a new context.

"Free isn't free." Consumer-tier AI services typically reserve the right to use inputs for model improvement. Enterprise and government tiers typically do not. Know which tier you are on. Read the terms of service. If you cannot determine the data retention policy for the service you are using, you cannot make a safe data determination.

*What questions should you ask about your data?*

| Question | What you're really asking |
|---|---|
| Has direct-identifying information been removed before LLM processing? | Names, addresses, SSNs not in prompts, ever |
| Is the data in the prompt the minimum necessary for the task? | Don't send the whole record when you need one field classified |
| Are you using the consumer tier or the enterprise/government tier? | Terms of service differ, data training policies differ |
| Could this task be developed and tested with synthetic or de-identified data? | Use real data only when you must |
| What happens to the data after the API call completes? | Retention, logging, training: know the policy |
| Are prompts themselves treated as data artifacts with retention policies? | The prompt is the exposure surface |

## Safe Outputs: Are Results Non-Disclosive?

Agencies already check outputs for disclosure risk. AI-generated outputs need the same scrutiny, with additional considerations specific to how language models produce results.

LLMs can memorize and reproduce fragments of their training data. This is a known property, not a theoretical risk. Classification outputs, generated text summaries, extracted entities: all need the same statistical disclosure control review as any other output derived from protected data. The method of production (human analyst vs. AI pipeline) does not change the disclosure risk of the output.

Aggregated results from AI classification pipelines need the same suppression rules as any other tabulation. Small cell counts are small cell counts regardless of how they were produced. AI does not change the mathematics of disclosure.

Generated text presents an additional consideration. Text that sounds authoritative but contains hallucinated details that happen to match real individuals is a low-probability event in a well-designed pipeline, but the output checking process should be aware of the possibility. This is another reason for human review before publication: not because the human is smarter than the model, but because Tenet 5 applies: humans remain accountable.

*What questions should you ask about your outputs?*

| Question | What you're really asking |
|---|---|
| Do AI-generated outputs go through the same SDC review as other outputs? | No special exemption because a machine produced it |
| Could record-level AI outputs be combined with external data to re-identify? | Same linkage risk as any microdata release |
| Are generated text outputs reviewed for inadvertent inclusion of identifiable information? | Memorization risk from training data |
| Are aggregate statistics from AI classification subject to standard suppression rules? | Small cell counts are small cell counts regardless of how they were produced |
| Is there a human review step before AI-generated content is published? | Humans remain accountable (Tenet 5) |

## Model Provenance and Supply Chain

Model provenance cuts across multiple safes. It is a trust decision, not just a performance decision.

Where did this model come from? Who trained it? On what data? Under what corporate governance? These are not idle questions. They determine whether you can satisfy the safe settings, safe data, and safe outputs requirements. A model trained on data that includes material from jurisdictions with conflicting legal requirements introduces compliance risk that has nothing to do with the model's benchmark scores.

The supply chain extends beyond the model itself. Tokenizers, embedding models, evaluation frameworks, Python packages, container images: the dependency tree for an AI workflow is deeper than traditional software. Each dependency is a trust decision. Each one can introduce behavior you did not ask for, as the "offline isn't offline" example illustrates.

Model integrity verification matters. Checksums, cryptographic signatures, trusted registries: the same supply chain security practices that apply to software artifacts apply to model artifacts. A model weight file downloaded from an unverified source is no different from an unsigned binary.

*What questions should you ask about your models and supply chain?*

| Question | What you're really asking |
|---|---|
| Who trained this model and on what data? | Provenance of the instrument |
| Under what jurisdiction is the model provider incorporated? | Legal and regulatory alignment |
| What is the provider's data retention and model training policy for government customers? | Will your inputs become their training data? |
| Are model weights verified via checksums or signatures? | Integrity of the artifact |
| What non-obvious dependencies does your pipeline have? | The "offline isn't offline" audit |
| Does the provider have existing federal/government customers and contracts? | Track record and institutional responsiveness |

## Framework Alignment

For security practitioners who work in NIST frameworks: the AI Risk Management Framework {cite:p}`nist_ai_rmf_2023`, the Generative AI Profile {cite:p}`nist_genai_2024`, and the FCSM/NIST crosswalk {cite:p}`webb_2026_crosswalk` provide formal alignment points. The Five Safes framing maps naturally to the MAP and MANAGE functions of the AI RMF. The crosswalk paper has the detailed mapping between NIST AI RMF and FCSM statistical quality standards. Point to it rather than reproducing it here.

For organizations looking to formalize their AI data access governance, the Five Safes provides a ready-made structure that the international statistical community already recognizes and that maps without great effort to what every agency is already doing, even if they call it something different.

### Thought Experiment

Your team wants to use a new open-source model from a public repository. It scores well on benchmarks relevant to your task. The model card says it was trained on "internet data." The repository is hosted by an organization incorporated in a jurisdiction with different data protection laws than yours.

Walk through each of the Five Safes for this scenario. *Safe project:* is this the right tool for this task? *Safe people:* does your team understand the implications? *Safe settings:* where will you run it, and what network calls will it make? *Safe data:* what will you send to it, and what are the retention policies? *Safe outputs:* how will you verify the results don't disclose?

Where do you have answers? Where do you have gaps? What would you need to know before proceeding?

---

This chapter covered what the security controls are and why they matter. The next chapter covers the organizational reality of actually getting AI workflows deployed within institutions that have their own constraints, timelines, and cultures. Security tells you what to do. Institutional deployment tells you what happens when you try to do it.
