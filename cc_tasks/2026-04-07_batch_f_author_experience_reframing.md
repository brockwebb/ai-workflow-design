# CC Task: Batch F Remainder -- Author-Experience Reframing

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Reference:** Sweep synthesis item 22 + item 21; `docs/2026-04-06_sweep_synthesis_run004.md`
**Batch:** F (final items -- CC-8, CC-9, CC-10 already complete)

---

## Context

The AD-020 sweep audit (run-004) identified multiple passages across the book where design observations or operational experiences from the author's pipeline work are stated as field-established facts. The pattern: claims that read as documented, citable knowledge but are actually the author's synthesis from building the Federal Survey Concept Mapper and related projects.

The fix is consistent: add "in the author's experience/observation/assessment" or equivalent framing so the reader understands these are practitioner observations, not literature-supported claims. This is NOT retraction. The observations are valuable. The issue is attribution voice.

Ch 7 (silent failures, line 37) and Ch 11 (LangChain, lines 22/30) already have correct author-experience framing from prior CC tasks. They are not touched here.

---

## Fix 1 -- Ch 1: Market characterization (item 21)

**File:** `book/chapter-01.md`
**Section:** `## The Systems Engineering Gap`

### Fix 1a

Find the sentence:

```
The tooling market is not filling this gap.
```

Replace with:

```
In the author's assessment, the tooling market is not filling this gap.
```

The rest of the paragraph is unchanged. The market claims that follow ("The market is building for software development...") are now properly scoped under the opening "In the author's assessment."

### Fix 1b

Find the sentence (in the maturity levels discussion):

```
The tooling market is building Level 3+ infrastructure for software developers: test suites, CI/CD, type systems.
```

Replace with:

```
As of this writing, the tooling market is building Level 3+ infrastructure for software developers: test suites, CI/CD, type systems.
```

Rationale: "As of this writing" is more appropriate than "in the author's assessment" here because the claim is observational (what the market is doing now) rather than evaluative. It also signals to the reader that this is a snapshot that may change, which is the real concern -- the book acknowledges in Ch 11 that it ages fastest where it describes the current landscape.

---

## Fix 2 -- Ch 2: Cross-vendor independence (item 22)

**File:** `book/chapter-02.md`
**Section:** `**Why three vendors, not three models from one vendor?**`

Find the sentence:

```
Models from the same vendor share training pipelines, alignment approaches, and organizational biases.
```

Replace with:

```
Models from the same vendor likely share training pipelines, alignment approaches, and organizational biases.
```

Rationale: "Likely" is the right hedge here rather than "in the author's experience" because this is a reasonable inference about vendor internals (training pipelines are not published in detail), not a direct operational observation. The sentence already reads as analytical reasoning from the design pattern, and adding "in the author's experience" would misframe an inference as anecdote.

Also find:

```
Cross-vendor agreement is harder to achieve and more meaningful when it occurs.
```

Replace with:

```
Cross-vendor agreement is harder to achieve and, in the author's experience, more meaningful when it occurs.
```

Rationale: "Harder to achieve" is analytically obvious (more independent = harder agreement). "More meaningful" is the author's judgment from the Concept Mapper experience.

---

## Fix 3 -- Ch 6: 40% runtime parsing (item 22)

**File:** `book/chapter-06.md`
**Section:** Under Pike's rules, `**Bottlenecks surprise you.**`

Find the sentence:

```
In one pipeline, 40% of runtime was spent parsing structured JSON output, not waiting for the LLM.
```

Replace with:

```
In the Concept Mapper pipeline, 40% of runtime in one workflow was spent parsing structured JSON output, not waiting for the LLM.
```

Rationale: The anecdote is already signaled as specific ("In one pipeline") but the reader does not know whose pipeline. Attributing it to the Concept Mapper (the book's primary case study) makes the source clear without adding awkward "in the author's experience" phrasing to what is already an anecdotal example.

---

## Fix 4 -- Ch 9: State supersession frequency (item 22)

**File:** `book/chapter-09.md`
**Section:** `### T4: State Supersession Failure`

Find the sentence:

```
State supersession failure is common in multi-session workflows where accumulated context from earlier sessions carries forward.
```

Replace with:

```
In the author's experience, state supersession failure is common in multi-session workflows where accumulated context from earlier sessions carries forward.
```

Rationale: "Common" is a frequency claim. The author observed this repeatedly in the Concept Mapper and Seldon development, but there is no published frequency data on state supersession in LLM workflows. This is the clearest case for author-experience framing.

---

## Items Reviewed and NOT Changed

### Ch 4, line 78: Stochastic tax design principle
"Every dimension of input you withhold from the model is a dimension of stochastic tax you do not pay."

This is a logical argument derived from the metadata-only pattern example in the preceding paragraph, not a bare empirical claim. It is stated as a design principle, and the reasoning chain (fewer inputs = fewer confabulation opportunities = more reliable output) is self-contained. No reframe needed.

### Ch 6, lines 137-141: Infrastructure reinvention
"Every new workflow in the Concept Mapper required rebuilding the same infrastructure..."

Already references the Concept Mapper by name, which is the author's project. The attribution is implicit but clear. No reframe needed.

### Ch 7, line 25: Temperature parameter shelf life
"When providers introduced reasoning-focused model architectures, temperature is fixed at 1 and not user-controllable..."

This is verifiable fact (OpenAI o1/o3 documentation). Not author opinion. No reframe needed. If a citation is desired, that belongs in a citation sprint (Batch C/D), not here.

### Ch 7, line 37: Silent failures
Already has "The author experienced pipeline failures..." framing. Done in prior CC task.

### Ch 11, lines 22/30: LangChain + landscape rhetoric
Already has author-experience framing from Ch 11 AD-020 revision CC task. Done.

---

## Verification

After execution:
1. `grep -n "in the author" book/chapter-01.md` returns at least one hit
2. `grep -n "likely share" book/chapter-02.md` returns one hit at the vendor diversity paragraph
3. `grep -n "in the author" book/chapter-02.md` returns at least one hit
4. `grep -n "Concept Mapper pipeline" book/chapter-06.md` returns one hit
5. `grep -n "in the author" book/chapter-09.md` returns at least one hit (T4 section)
6. No other changes to any file beyond the specified replacements
7. `seldon verify` passes

---

## Files Modified

| File | Change |
|------|--------|
| `book/chapter-01.md` | Two market characterization reframes |
| `book/chapter-02.md` | One "likely" hedge + one "in the author's experience" addition |
| `book/chapter-06.md` | "In one pipeline" -> "In the Concept Mapper pipeline" |
| `book/chapter-09.md` | "State supersession failure is common" -> "In the author's experience, state supersession failure is common" |
