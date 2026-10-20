# CC Task: Foreword & Introduction Audit Fixes

**Date:** 2026-03-31
**Session:** 15
**Status:** PENDING
**Scope:** `book/foreword.md`, `book/intro.md`

---

## Context

Session 15 substantive audit of foreword and introduction identified 5 prose-level issues. No structural problems. All fixes are precision tightening — no argument or architecture changes.

Decision: Foreword is allowed personality and motivational tone. Items initially flagged as "throat-clearing" in the foreword were withdrawn (author decision). The foreword motivates readers to want to read; it is not held to the same factual-claim standard as chapter content.

---

## Fixes

### Fix 1: Foreword §On Purpose, paragraph 2

**File:** `book/foreword.md`

**Current text:**
> Official statistics, scientific research, evidence that informs policy: these carry obligations that commercial software does not.

**Problem:** Factually overbroad. Commercial software in healthcare, aviation, and finance carries heavy obligations. The actual distinction is about democratic accountability and public trust, not obligations broadly.

**Replace with:**
> Official statistics, scientific research, evidence that informs policy: these carry a specific obligation to the public trust that shapes every design decision.

**Rationale:** Tightens the claim to what is actually distinct about this audience's work — public trust and democratic accountability — without making a false claim about commercial software having no obligations.

---

### Fix 2: Foreword §On AI-Assisted Authoring — "AI partner" consistency check

**File:** Book-wide (check triggered by `book/foreword.md`)

**Current text (foreword):**
> The AI partner executed against those specifications.

**Action:** Search all chapter files for the term "AI partner" and related anthropomorphizing terms ("AI collaborator," "AI teammate," etc.). Determine whether the book has a consistent policy. If "AI partner" is used elsewhere, no change needed — it is a deliberate voice choice. If it appears only in the foreword, replace with "The AI tool executed against those specifications." Report findings.

**This is a check, not a predetermined fix.** The CC executor should grep and report.

---

### Fix 3: Introduction §A New Design Space, paragraph 4

**File:** `book/intro.md`

**Current text:**
> These systems break the conventions that every other tool in a professional career has followed.

**Problem:** Overbroad. Statisticians already work with stochastic tools (sampling theory, Bayesian methods, Monte Carlo simulations). What is new is not stochasticity itself but stochasticity combined with natural language output that mimics human reasoning, making the variance invisible.

**Replace with:**
> These systems break a convention that most tools in a professional career have followed: the assumption that the same input produces the same output. Statisticians work with stochastic methods, but those methods are transparent about their randomness. LLMs produce stochastic output that reads like deterministic human reasoning, and that is what makes the variance invisible.

**Rationale:** Preserves the force of the claim while acknowledging the audience's existing experience with stochastic tools. The distinction — stochasticity disguised as deterministic reasoning — is the actual novel problem.

---

### Fix 4: Introduction §The Hardest Part, paragraph 1

**File:** `book/intro.md`

**Current text:**
> The hardest part of working with AI systems is something nobody talks about honestly

**Problem:** Unsupported broad claim. Confirmation bias in AI is discussed in NAS reports, NIST AI 600-1, ML fairness literature. The claim that "nobody talks about it honestly" is the kind of unverified assertion this book flags in other contexts.

**Replace with:**
> The hardest part of working with AI systems is something that gets surprisingly little attention in practitioner guidance: you are the easiest person to fool.

**Rationale:** Makes the same point without the unsupported "nobody" claim. "Surprisingly little attention in practitioner guidance" is defensible — most tutorial-level material does not address confirmation bias in AI-assisted research.

---

### Fix 5: Introduction §Find Your Edge, paragraphs 5-7

**File:** `book/intro.md`

**Current text (three paragraphs starting with):**
> The experience of learning to work with these tools is not linear. You grind through manual processes, hit frustrations, work at a pace that feels slow. Then something clicks...
>
> These bursts come at every level...
>
> It is okay to be at whatever level you are at when you start. The acceleration will come. The intention to learn, to operate differently, to push past the current edge, that is what matters.

**Problem:** Motivational drift. The nonlinear learning curve and velocity shifts are valid points, but the surrounding prose is soft reassurance. "It is okay to be at whatever level you are at" reads as reassurance for anxious students, not federal professionals.

**Replace all three paragraphs with:**
> The learning curve is not linear. You grind through manual processes at a pace that feels slow, then something clicks — a process improvement, a conceptual shift — and you are operating at a fundamentally different velocity. These velocity shifts are real and they compound. The maturity levels in Chapter 1 describe those thresholds. You will look back at what you were doing three months ago and it will seem impossibly slow. That is the trajectory.

**Rationale:** Preserves the nonlinear learning curve point and the maturity levels callback. Cuts the reassurance. One paragraph instead of three.

---

## Verification

After applying fixes, run `seldon verify --fix` to update content hashes and check for any downstream issues.

---

## Notes

- Fix 2 is a grep-and-report task, not a predetermined edit. The CC executor should report what they find and only make changes if inconsistency is confirmed.
- All fixes are prose tightening. No cross-references, citations, or structural elements are affected.
