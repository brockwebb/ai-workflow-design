# Introduction

<!-- STATUS: Draft -->

## A New Design Space

Large language models have opened a design space that did not previously exist. They have not just accelerated existing work. They have made it possible to approach problems that were never approachable before, and they have given people with domain expertise the ability to exercise their ideas and creativity in ways that were previously locked behind specialized engineering teams. That democratization is real, and its consequences for research, operations, and public service are only beginning to be understood.

The tools let you dig a lot of holes fast. A working prototype that demonstrates a concept is now days of effort, not months. That speed matters, because it lets you move horizontally across problems, find the ones that have real value, and invest deeply where it counts. Not every idea should become a production system. Not every prototype should scale. Part of what these tools enable is the ability to explore widely and identify where the real opportunities are.

But the gap between a prototype and a production system has not gone away. A prototype shows that something can be done. A production system shows how it is actually done: operationally, reliably, sustainably. That gap exists for a reason. And because these tools have opened the door to so many more people, many of those now building have never had to cross it before.

This book is about crossing that gap. These systems break a convention that most tools in a professional career have followed: the assumption that the same input produces the same output. Statisticians work with stochastic methods, but those methods are transparent about their randomness. LLMs produce stochastic output that reads like deterministic human reasoning, and that is what makes the variance invisible. They fail in ways that look like success. They degrade without warning. The principles that keep complex systems reliable apply here, but they are not obvious, and they are not part of standard training in any field now adopting these tools.

You do not have to learn these principles the hard way. If you start with the right understanding of how these systems actually behave, your prototypes will be better informed, your designs will be more honest about what will and will not scale, and when the time comes to make the leap from idea to real research, you will know what that requires.

For those working in official statistics, scientific research, and public-facing evidence production, the stakes of crossing that gap are specific: the work must withstand independent audit, public scrutiny, and the standard of integrity that the public trust demands. A prototype that produces plausible output is not sufficient. A production system that produces defensible output, with evidence chains, provenance, and verifiable quality, is the minimum standard. This book teaches the design discipline to meet that standard.

## First Principles, Not Recipes

This book does not teach you how to use specific tools. Tools change weekly. A tutorial on today's framework is a historical artifact by next quarter. Instead, this book teaches you how to think about the problem.

What are these systems, actually? They are pattern machines that operate stochastically over language. That is their nature, and it has consequences for every design decision you make. What are their real constraints? Token throughput, rate limits, irreproducible outputs, context window drift, coherent-sounding wrong answers. How do you design around those constraints? That is what the chapters that follow address.

If you understand the principles, you can evaluate any tool, adapt to any model release, and design workflows that survive the next three platform shifts. If you only know the recipes, you are starting over every time something changes. In a landscape that shifts weekly, recipes are expensive. Principles are durable.

## The Hardest Part

The hardest part of working with AI systems is something that gets surprisingly little attention in practitioner guidance: you are the easiest person to fool. When your AI workflow produces output that looks right and confirms what you expected, that is the most dangerous moment. Not because the output is wrong (it might be fine), but because you have no way of knowing without the infrastructure to check.

Confirmation bias is the silent killer in AI-assisted research. When output looks wrong, at least you know to investigate. When it looks right but *is* wrong, you have been fooled by a pattern machine that produces fluent, confident, plausible-looking incorrect answers. The failure mode is not noise or garbage. It is a well-formed, reasonable-sounding wrong answer that passes casual inspection.

The design discipline in this book exists to protect you from yourself as much as from the AI. Evidence chains, dual-path verification, provenance tracking, statistical quality checks: these are not bureaucratic overhead. They are guardrails against self-deception at scale.

## Learning to See

Over time, you develop a practitioner's eye. You learn to look for *signs* of correct output rather than reviewing every line. You build mental models of what the result should look like before you see it. When outputs confirm expectations, you check for confirmation bias. When they violate expectations, you investigate why. Both directions demand scrutiny.

This is what makes the process scalable. Without this skill, you are stuck micromanaging every output, unable to process more than one person can read in a day. With it, you operate where your judgment matters most: the ambiguous cases, the disagreements, the edge conditions that require domain knowledge no model has.

This is *not* about being lazy or cutting corners. It is about being strategic with your attention. You cannot read everything. You cannot check everything. So you build systems that check for you, and you focus on the decisions that require human judgment. The chapters that follow teach you how to build those systems.

## Find Your Edge

This book is a self-guided tour, not a race. There is no single right pace.

Different readers bring different strengths. Some are strong on statistical methodology and weaker on systems thinking. Some have deep domain expertise but have never designed a pipeline. Some have engineering backgrounds but are new to the constraints of official statistics. The book meets you where you are. It helps you figure out where *you* synergize with AI, where *your* judgment is irreplaceable, and where the design patterns in these chapters can fill the gaps.

The thought experiments and reflection prompts throughout the book are not academic exercises. They are invitations to try, break, and understand. You learn more by building something wrong and taking it apart than by reading about someone else's correct answer. The book pushes you to think, but it is alongside you, not above you. Its job is to find your edge and push you just past it.

Apply that standard to this book. If something does not make sense, do not take it on authority. Work through it. Break it. That is how you learn.

The learning curve is not linear. You grind through manual processes at a pace that feels slow, then something clicks (a process improvement, a conceptual shift) and you are operating at a fundamentally different velocity. These velocity shifts are real and they compound. The levels of AI automation in research in Chapter 1 describe those thresholds. You will look back at what you were doing three months ago and it will seem impossibly slow. That is the trajectory.

## How This Book Is Organized

The book moves through five phases, from the nature of the instrument to the institutional reality of deploying it.

### Foundations

**Chapter 1: Why Design Matters.** LLMs are stochastic instruments, not deterministic tools. The chapter introduces *stochastic liabilities* (properties to design around, not defects to fix), the *stochastic tax* (every unnecessary LLM invocation is avoidable variance, cost, and audit burden), and the maturity levels that separate a VBA macro helper from a defensible production pipeline. The organizing framework for the book, ten compressed tenets and eight working principles, is established here.

### Domain Workflows

**Chapter 2: Classification and Coding Workflows.** 6,954 survey questions, 152 categories, \$15 per-run inference cost. The Federal Survey Concept Mapper case study demonstrates dual-model cross-validation, structured arbitration, confidence routing, and complete evidence chains. Classification is the natural entry point because it has ground truth, making it evaluable in ways that open-ended generation is not.

**Chapter 3: Data Wrangling and Standardization Workflows.** Fixing bad codes, standardizing formats, combining disparate sources, extracting structured data from unstructured input. Where LLMs handle the semantic reasoning parts of the data quality pipeline and where traditional methods (MICE, hot-deck, Fellegi-Holt) still win. The fine-tuning cost trap: most teams do not do the total cost of ownership comparison honestly.

**Chapter 4: Detection and Extraction Workflows.** Entity extraction, pattern detection, and disclosure review assistance. Knowledge graphs as "confidence laundering machines": extraction pipelines that look authoritative and are structurally wrong due to garbage chunking, lazy entity resolution, and no validation against source. SFV sub-dimensions applied to extraction fidelity: compression fidelity, Terminological Consistency (TC), and state provenance.

### Cross-Cutting Patterns

**Chapter 5: The Ensemble and Multi-Model Playbook.** The silence of a single model: single-model pipelines bury uncertainty in confident-sounding output. Three topologies for multi-model design: parallel consensus, generator-critic loops, and LLM-as-judge. A decision framework for choosing between them, and a clear argument that multi-model is the baseline, not the advanced technique.

**Chapter 6: Parallel, Serial, and the Bottleneck.** Force multipliers amplify good design and bad design equally. The LLM API call is almost always the bottleneck: design around it, not through it. Parallel versus serial is a task-dependency question, not a preference. Model selection as an engineering decision: simpler models earn their place by default.

**Chapter 7: Checkpoints, Failures, and Recovery.** Everything fails. Config-driven architecture as the "save the random seed" principle extended to LLM pipelines. Progressive test infrastructure: unit tests, smoke tests, regression tests defined for practitioners who may not come from software engineering. Error classification: transient errors retry, permanent errors escalate, data errors log and continue.

**Chapter 8: Evaluation by Design.** No benchmark exists for your pipeline. The FCSM/NIST crosswalk provides the scaffolding: two evaluation frameworks apply simultaneously, one for data quality, one for AI system trustworthiness. Valid and Reliable is a binary gate, not one dimension among many. Golden test sets, continuous regression testing, and evaluation economics.

### Validity

**Chapter 9: State, Drift, and Validity.** The instrument that changes itself. State Fidelity Validity (SFV): when the composite instrument (fixed weights plus mutable context window) degrades, it silently becomes a different instrument. Five threats (T1 through T5) with concrete pipeline examples. The engineering practices from prior chapters revealed as SFV countermeasures.

**Chapter 10: State Management and Research Provenance.** Defensible by design: can you prove your pipeline's chain from input to output under independent audit? Eight requirements for research provenance, from typed artifacts to automated integrity verification. DOORS had the right requirements decades ago; AI partners change the cost equation that killed traceability systems. The graph-of-artifacts pattern as a worked example.

### Delivery

**Chapter 11: Workflow Orchestration and the Tool Landscape.** The orchestration tool researchers need largely does not exist as a product. Four evaluation dimensions: coupling, friction, transparency, volatility. The 90/10 rule and the last mile. Tool design for observability in agentic systems. The full treatment of recursive stochasticity: building with LLM tools introduces the same variance you are trying to control. Patterns are durable, products are volatile.

**Chapter 12: Security, Supply Chain, and Model Provenance.** Security controls exist so you *can* use these tools, not so you cannot. The Five Safes framework applied to AI workflows: safe projects, safe people, safe settings, safe data, safe outputs. Agencies already do these things under different names; the Five Safes provides a common vocabulary. Model provenance as a trust decision, not just a performance decision.

**Chapter 13: Deploying in Institutional Environments.** The last mile is organizational. Authorization gaps, procurement timelines, governance review cadence. The compressed tenets and working principles as diagnostic lens for institutional friction: governance-as-gate versus governance-as-enabler, incentive misalignment, the culture shift from planned releases to continuous delivery.

**Chapter 14: Cost and Practicality.** Every cost discussion is a comparison: AI pipeline cost versus the status quo alternative. The status quo has costs too; they are just already in the budget. The cost taxonomy (inference, development, operational, opportunity), batch economics, when cheap models win, and a template for making the case to budget authority.

### Where to Start

If you are a statistician or domain expert new to pipeline engineering, start at Chapter 1 and read through. The domain chapters (2 through 4) will be familiar territory; the cross-cutting chapters (5 through 8) are where you will learn the most new material. The validity chapters (9 and 10) formalize the engineering discipline in terms that connect to measurement theory you already know.

If you are a software engineer or data scientist new to official statistics, Chapter 1 provides the stochastic framing, then Chapter 8 (evaluation) and Chapter 12 (security and the Five Safes) give the institutional context that changes everything about how you design. The governance and cost chapters (13 and 14) explain constraints you may not have encountered in commercial software development.

If you are a manager or program leader, Chapter 13 (institutional deployment) and Chapter 14 (cost) provide the operational picture. Chapter 1 provides the design philosophy. Chapter 8 (evaluation) provides the quality argument you will need when stakeholders ask how you know the pipeline is working.

If you already build LLM pipelines, Chapter 9 (SFV) is probably the most novel content. It names the validity problem that practitioners discover empirically but rarely have a framework for reasoning about. Chapter 5 (multi-model) and Chapter 10 (provenance) will challenge assumptions about single-model sufficiency and ad-hoc state tracking.

If you are coming from *AI for Official Statistics*, the predecessor to this book: that book built the foundation, what AI is, how it works, where it applies. This book picks up with a different question: now that you know what it is, how do you build systems with it that you can trust and defend? If you are new to this work entirely, Chapter 1 is self-contained. No prerequisites required.
