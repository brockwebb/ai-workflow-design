# Foreword

<!-- STATUS: Draft -->

## Knowing the Name vs. Knowing the Thing

Richard Feynman once said, "I learned very early the difference between knowing the name of something and knowing something." That distinction is the reason this book exists.

Right now, across federal statistical agencies, research organizations, and data science teams, people are integrating large language models into their workflows. They know the names: GPT, Claude, Gemini, embeddings, RAG, fine-tuning, prompt engineering. They can call the APIs, get fluent output, and show impressive demos. But knowing the names of these things is not the same as knowing them.

Knowing something means you can explain *why* it works. It means you can predict when it will fail. It means you can design around its limitations, defend your results to a skeptical reviewer, and recover when things go wrong. Most people building AI-powered research workflows today cannot do these things, not because they lack intelligence or expertise, but because nobody has taught them how to think about these systems as systems.

This is the gap between knowing the name and knowing the thing. This book exists to close it.

## First Principles, Not Recipes

This book does not teach you how to use specific tools. Tools change weekly. A tutorial on today's framework is a historical artifact by next quarter. Instead, this book teaches you how to think about the problem.

What are these systems, actually? They are pattern machines that operate stochastically over language. That is their nature, and it has consequences for every design decision you make. What are their real constraints? Token throughput, rate limits, irreproducible outputs, context window drift, coherent-sounding wrong answers. How do you design around those constraints? That is what the chapters that follow address.

If you understand the principles, you can evaluate any tool, adapt to any model release, and design workflows that survive the next three platform shifts. If you only know the recipes, you are starting over every time something changes. In a landscape that shifts weekly, recipes are expensive. Principles are durable.

## The Hardest Part

Feynman's first principle of scientific integrity: "The first principle is that you must not fool yourself, and you are the easiest person to fool."

This is the hardest part of working with AI systems, and it is the part nobody talks about honestly. When your AI workflow produces output that looks right and confirms what you expected, that is the most dangerous moment. Not because the output is wrong (it might be fine), but because you have no way of knowing without the infrastructure to check.

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

Feynman again: "Have no respect whatsoever for authority; forget who said it and instead look at what he starts with, where he ends up, and ask yourself, 'Is it reasonable?'" Apply that standard to this book. If something doesn't make sense, don't take it on authority. Work through it. Break it. That is how you learn.

## Where We Begin

If you are coming from *AI for Official Statistics*, the predecessor to this book: that book built your foundation. What AI is, how it works, where it applies. This book picks up with a different question: now that you know what it is, how do you build systems with it that you can trust and defend?

If you are new to this: you do not need the predecessor as a prerequisite. Chapter 1 will orient you. The book is self-contained.

Either way, the first chapter begins with the nature of the instrument itself: what it means that your processing node is stochastic, why that changes everything about how you design, and what breaks when you ignore it.
