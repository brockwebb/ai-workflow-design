# CC Task: Draft Chapter 12 — Security, Supply Chain, and Model Provenance

**Date:** 2026-03-29
**Project:** AI Workflow Design for Official Statistics
**Repo:** `/Users/brock/Documents/GitHub/ai-workflow-design/`
**Depends on:** `2026-03-29_citation_infrastructure_and_bibliography.md` (for citation roles)

---

## Objective

Replace the placeholder `book/chapter-12.md` with a full chapter draft organized around the Five Safes framework applied to AI/LLM workflows. The chapter serves two audiences simultaneously: practitioners building AI workflows who need to understand security considerations, and security/IT professionals who need to understand AI workflows well enough to support them.

## Tone and Scope

This is NOT a security textbook. It is "enough so practitioners get what they need" and "enough so security/IT professionals can see how to support and move the mission forward." The Five Safes provides the organizing principle. Each safe gets a section with prose context and a question table. The chapter should be direct, practical, and enabling — security is what lets you use these tools confidently.

Do not frame this as a federal-statistics-only concern. The audience works in the federal statistical system but the principles are universal. State the context once, then let the content speak for itself.

## Chapter Structure

### Opening (1-2 pages)

Security controls exist so you can use these tools, not so you can't. The Five Safes framework — developed by ONS, adopted internationally by ABS, Stats NZ, Eurostat, embedded in the UK Digital Economy Act and Australia's DAT Act — provides the organizing principle for this chapter.

Key framing paragraph: The Five Safes is the international standard for organizing data access decisions. Every agency in the federal statistical system is already doing these things under different names with different processes. We organize this chapter using Five Safes because it maps to what everyone already does with minimal mental effort, and because extending it to cover AI workflows is a natural fit. For organizations looking to adopt a standardized framework for AI data access decisions, Five Safes is a strong recommendation.

Note for security/IT professionals: the workflow design patterns in this book can inform how you build and evaluate AI systems in your own domain. That application is beyond the scope of what we cover here, but the principles transfer.

Cite the Five Safes appropriately. Key citation: Desai, T., Ritchie, F., & Welpton, R. (2016). "Five Safes: designing data access for research." Add to `references.bib`:

```bibtex
@techreport{desai_2016,
  author    = {Desai, Tanvi and Ritchie, Felix and Welpton, Richard},
  title     = {Five Safes: Designing Data Access for Research},
  year      = {2016},
  institution = {University of the West of England},
  url       = {https://www2.uwe.ac.uk/faculties/BBS/Documents/1601.pdf},
  note      = {Original framework paper. Five dimensions: safe projects, safe people, safe settings, safe data, safe outputs.}
}
```

For NIST AI RMF reference, use `webb_2026_crosswalk` (already in references.bib). Also add:

```bibtex
@techreport{nist_ai_rmf_2023,
  author       = {{National Institute of Standards and Technology}},
  title        = {Artificial Intelligence Risk Management Framework ({AI RMF} 1.0)},
  year         = {2023},
  number       = {NIST AI 100-1},
  institution  = {NIST},
  url          = {https://csrc.nist.gov/pubs/ai/100/1/final}
}

@techreport{nist_genai_2024,
  author       = {{National Institute of Standards and Technology}},
  title        = {Artificial Intelligence Risk Management Framework: Generative Artificial Intelligence Profile},
  year         = {2024},
  number       = {NIST AI 600-1},
  institution  = {NIST},
  url          = {https://csrc.nist.gov/pubs/ai/600/1/final}
}
```

### Section: Safe Projects — Is This Use of AI Appropriate?

The question isn't "should we use AI?" It's: does this specific project justify the controls that come with it?

Key points:
- People SHOULD be using these tools for learning, exploration, literature review, drafting, code assistance. Professional development with public AI services is not a security incident.
- The project-level question separates those uses from production workflows that touch real data.
- A researcher using a public LLM to brainstorm survey question wording is a different project from a pipeline classifying 50,000 records with confidential data. Same tool category, different risk profile, different controls.

Question table — "Questions to ask about your AI project":

| Question | What you're really asking |
|---|---|
| Does this project require AI, or would a deterministic method suffice? | Are you paying the stochastic tax unnecessarily? |
| What data will the AI system touch? | Determines the control level for every other safe |
| Is there a lawful basis for processing this data through an AI system? | Which statutory protections apply? |
| What is the public benefit? | The justification for the risk |
| Could this project be accomplished with a less sensitive subset of the data? | Minimum necessary principle applied to AI inputs |
| Has this use been reviewed by your data governance body? | Not a rubber stamp — a proportionate assessment |

### Section: Safe People — Are Users Trained to Work with AI Appropriately?

Two audiences: practitioners need to understand the stochastic nature of the tools, know what they can and can't send to external services, recognize when outputs need scrutiny. Security/IT professionals need to understand what AI workflows actually do so they can provide useful guidance rather than blanket restrictions.

Key points:
- Training isn't "here's how to prompt." Training is: what does this tool do under the hood, why might it be wrong, what do you never send to an external service, how do you tell whether the system is approved for your data classification level.
- Both sides need training — practitioners on security awareness, security staff on AI literacy.

Question table — "Questions to ask about your people":

| Question | What you're really asking |
|---|---|
| Do users understand the difference between public AI services and approved production systems? | Can they self-sort appropriate tool for appropriate task? |
| Can users identify when an LLM output needs verification vs. when it's low-stakes? | Do they understand the stochastic liability concept? |
| Do users know what data classifications they work with and what each permits? | Can they make the safe project determination independently? |
| Are security/IT staff trained on how AI workflows differ from traditional software? | Can they provide useful guidance, or only blanket "no"? |
| Is there an escalation path when someone isn't sure? | Better to ask than guess wrong |
| Do users understand that "free" services have terms of service regarding data use? | Free isn't free |

### Section: Safe Settings — Is the Technical Environment Secure?

Where is the computation happening? Who controls the environment? What network paths does data traverse? Where are the servers physically located?

Key points:
- The practical reality: approved cloud environments (FedRAMP'd) for some workloads, on-premises for others, public services for non-sensitive learning and exploration. It's a portfolio, not a single choice.
- "Offline isn't offline." Local model inference that makes network calls for tokenizers, embedding models, configs, or telemetry — your air gap has holes.
- The jurisdiction question: a model hosted in a country whose data protection laws conflict with your obligations is a compliance failure, not a policy debate.

Question table — "Questions to ask about your settings":

| Question | What you're really asking |
|---|---|
| Is the AI service authorized at the appropriate level for your data? | Is this setting approved for this data classification? |
| Where are the servers physically located? Under whose jurisdiction? | Does the hosting jurisdiction's law conflict with your obligations? |
| Does the service retain input data? For how long? For what purpose? | Is your data being used to train future models? |
| If running locally, what network calls does the system make? | Is your "offline" system actually offline? |
| What is the provider's incident response and breach notification process? | If something goes wrong, how do you find out? |
| Are API calls logged and auditable? | Can you demonstrate what data went where? |
| Is there DLP or equivalent monitoring on outbound data to AI endpoints? | Technical control vs. policy-only control |

### Section: Safe Data — Has Appropriate Protection Been Applied?

Before data enters an AI workflow, what has been done to protect it? Same principles as releasing microdata to researchers — except the "researcher" is an API endpoint.

Key points:
- De-identify before LLM processing. Minimum necessary data in prompts.
- The prompt IS the data exposure surface — everything in a prompt is transmitted to the model provider for external APIs.
- Synthetic or aggregated data for development and testing. Real data only in approved production environments.
- "Free isn't free." Consumer-tier services may use inputs for model improvement. Enterprise/government tiers typically don't. Know which tier you're on.

Question table — "Questions to ask about your data":

| Question | What you're really asking |
|---|---|
| Has direct-identifying information been removed before LLM processing? | Names, addresses, SSNs not in prompts — ever |
| Is the data in the prompt the minimum necessary for the task? | Don't send the whole record when you need one field classified |
| Are you using the consumer tier or the enterprise/government tier? | Terms of service differ — data training policies differ |
| Could this task be developed and tested with synthetic or de-identified data? | Use real data only when you must |
| What happens to the data after the API call completes? | Retention, logging, training — know the policy |
| Are prompts themselves treated as data artifacts with retention policies? | The prompt is the exposure surface |

### Section: Safe Outputs — Are Results Non-Disclosive?

Agencies already check outputs for disclosure risk. AI-generated outputs need the same scrutiny, with additional considerations.

Key points:
- LLMs can memorize and reproduce fragments of training data. Classification outputs, generated text summaries, extracted entities — all need the same SDC review as any other microdata output.
- Aggregated results from AI classification pipelines need the same suppression rules as any other tabulation.
- Generated text that sounds authoritative but contains hallucinated details that happen to match real individuals — low probability in a well-designed pipeline, but the output checking process should be aware.

Question table — "Questions to ask about your outputs":

| Question | What you're really asking |
|---|---|
| Do AI-generated outputs go through the same SDC review as other outputs? | No special exemption because a machine produced it |
| Could record-level AI outputs be combined with external data to re-identify? | Same linkage risk as any microdata release |
| Are generated text outputs reviewed for inadvertent inclusion of identifiable information? | Memorization risk from training data |
| Are aggregate statistics from AI classification subject to standard suppression rules? | Small cell counts are small cell counts regardless of how they were produced |
| Is there a human review step before AI-generated content is published? | Humans remain accountable (Tenet 5) |

### Section: Model Provenance and Supply Chain (cross-cutting)

This cuts across multiple safes. Model provenance is a trust decision, not just a performance decision.

Key points:
- Where did this model come from? Who trained it? On what data? Under what corporate governance?
- Training data provenance, corporate jurisdiction, data retention policies, responsiveness to institutional requirements — all selection criteria.
- Supply chain beyond the model: tokenizers, embedding models, evaluation frameworks, packages, container images. The dependency tree is deeper than traditional software.
- Model integrity verification: checksums, signatures, trusted registries.

Question table — "Questions to ask about your models and supply chain":

| Question | What you're really asking |
|---|---|
| Who trained this model and on what data? | Provenance of the instrument |
| Under what jurisdiction is the model provider incorporated? | Legal and regulatory alignment |
| What is the provider's data retention and model training policy for government customers? | Will your inputs become their training data? |
| Are model weights verified via checksums or signatures? | Integrity of the artifact |
| What non-obvious dependencies does your pipeline have? | The "offline isn't offline" audit |
| Does the provider have existing federal/government customers and contracts? | Track record and institutional responsiveness |

### Closing: Framework Alignment (brief — 1-2 paragraphs)

For security practitioners who work in NIST frameworks: the AI RMF {cite:p}`nist_ai_rmf_2023`, the GenAI Profile {cite:p}`nist_genai_2024`, and the FCSM/NIST crosswalk {cite:p}`webb_2026_crosswalk` provide formal alignment points. The Five Safes framing maps naturally to the MAP and MANAGE functions. The crosswalk paper has the detailed mapping. Point to it, don't reproduce it.

For organizations looking to formalize their AI data access governance, the Five Safes provides a ready-made structure that the international statistical community already recognizes and that maps without great effort to what every agency is already doing, even if they call it something different.

### Chapter Bridge

Connect forward to Chapter 13 (Deploying in Institutional Environments): this chapter covered what the security controls are and why they matter. The next chapter covers the organizational reality of actually getting AI workflows deployed within institutions that have their own constraints, timelines, and cultures.

### Pedagogical Elements (per chapter pattern)

- **Opening hook:** Use the "offline isn't offline" scenario — a researcher runs a local model, network goes down, job fails. Why? The "local" model was making calls to download a tokenizer config.
- **Reflection prompts:** Distribute 2-3 throughout. Example after Safe Settings: "Look at the AI tools you used this week. For each one: do you know where the servers are? Do you know the data retention policy? If the answer is no, what would it take to find out?"
- **Thought experiment:** Your team wants to use a new open-source model from a repository. It scores well on benchmarks. The model card says it was trained on "internet data." The repository is hosted by an organization incorporated in a jurisdiction with different data protection laws than yours. Walk through each of the Five Safes for this scenario. Where do you have answers? Where do you have gaps? What would you need to know before proceeding?
- **Chapter bridge:** See above.

## Writing Guidance

- Working Principle: "Security is a system property" — reference explicitly but don't belabor.
- Tenet: "Trust defines the mission" — the reason security matters in this context.
- The question tables are the pedagogical core. They are the Feynman/Socratic element — what a thoughtful person asks before proceeding.
- Don't lecture security professionals on security. Show them what's different about AI workflows.
- Don't lecture practitioners on why security matters. Show them what the controls buy them — the ability to use these tools confidently.
- Cite Five Safes with {cite:t}`desai_2016` or {cite:p}`desai_2016`.
- Cite NIST frameworks with {cite:p}`nist_ai_rmf_2023` and {cite:p}`nist_genai_2024`.
- Cite crosswalk with {cite:p}`webb_2026_crosswalk`.
- Estimated length: 12-18 pages. Don't pad. If it's 12 pages and complete, that's better than 18 pages with filler.

## Files Modified

1. `book/chapter-12.md` — full replacement of placeholder
2. `book/references.bib` — add `desai_2016`, `nist_ai_rmf_2023`, `nist_genai_2024` entries

## Verification

1. `book/chapter-12.md` contains all six sections (five safes + provenance/supply chain)
2. Each section has a question table
3. All `{cite:t}` and `{cite:p}` roles resolve against `references.bib`
4. `grep -c 'NEEDS' book/chapter-12.md` returns 0
5. Pedagogical elements present: opening hook, reflection prompts, thought experiment, chapter bridge
6. New .bib entries present in `book/references.bib`
