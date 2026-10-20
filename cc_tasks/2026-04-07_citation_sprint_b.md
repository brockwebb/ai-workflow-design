# CC Task: Citation Sprint B -- Reframings, Corrections, and Qualifier Fixes

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` Section 2B; Perplexity verification batches PQ-A through PQ-G (author-provided April 7, 2026)
**Scope:** Prose reframings where Perplexity results showed claims need qualifying, softening, or correction. No new BibTeX entries (those are in Citation Sprint A). No structural changes.

---

## Fix 1: Ch 1 -- Terminology drift reframed as practitioner observation (CG-T1)

**File:** `book/chapter-01.md`
**Location:** Find the sentence about "terminology drift" in long sessions.
**Issue:** No empirical study specifically measures within-session vocabulary drift as a named phenomenon. Literature covers "context drift" broadly but not lexicalization drift specifically.
**Action:** If the current text presents terminology drift as a documented/studied phenomenon, reframe it as a practitioner observation.

**Search for:** "terminology drift" in chapter-01.md.

If the sentence says something like "The terminology drift problem, where a model starts using slightly different terms..." -- this is already framed as an observation ("the terminology drift problem"), not attributed to literature. **Verify the framing.** If it reads as a literature claim, add a qualifier like "a pattern practitioners commonly observe" or "an empirically noted but not yet formally studied pattern." If it is already framed as an observation, no change needed.

---

## Fix 2: Ch 7 + Ch 11 -- Remove "frontier models" qualifier from SWE-CI (CG-T3)

**File:** `book/chapter-07.md`
**Search for:** "frontier" near "SWE-CI" or "chen_2026_sweci" or "18 models"
**Issue:** The SWE-CI paper (arXiv 2603.03823) describes "18 models from 8 providers" but does NOT use the word "frontier" to describe them. If Ch 7 or Ch 11 calls them "frontier models," the qualifier must be removed.

**Action:** If found, replace "frontier models" with "18 models from 8 providers" or simply "models" -- matching the paper's own language.

**File:** `book/chapter-11.md`
**Search for:** same pattern.
**Action:** same fix.

---

## Fix 3: Ch 7 -- Temperature parameter on reasoning models (CG-T2)

**File:** `book/chapter-07.md`
**Location:** Find the passage about reasoning models and temperature parameter removal.
**Issue:** OpenAI's o1 models do not "remove" the temperature parameter. They fix it at 1 (not 0). The API accepts the parameter but silently overrides it. The text should reflect "fixed/not user-controllable" rather than "removed."

**Search for:** "temperature" near "o1" or "reasoning model" in chapter-07.md.

**Action:** If the text says temperature was "removed" or "eliminated," change to: "temperature is fixed at 1 and not user-controllable; the API accepts the parameter but silently overrides it." If the text already says "fixed" or "not user-controllable," no change needed.

---

## Fix 4: Ch 3 -- Fine-tuning threshold reframed (CG-F4)

**File:** `book/chapter-03.md`
**Search for:** "\$50" or "fifty thousand" or "fine-tuning" near "threshold" or "crossover" or "break-even"
**Issue:** No recognized standard threshold exists for when fine-tuning becomes more cost-effective than API use. If Ch 3 presents "\$50k" as an established threshold, it needs reframing as an author planning estimate or scenario-dependent decision.

**Action:** If found, reframe. Example: change "the approximately \$50,000 threshold" to "a threshold that varies by model size, method (full vs. parameter-efficient fine-tuning), and infrastructure costs -- there is no standard crossover point, but teams spending tens of thousands annually on API calls with stable, high-volume workloads should model the comparison explicitly."

If Ch 3 already frames this as a rough planning estimate or uses hedged language, verify and leave as-is.

---

## Fix 5: Ch 3 -- Deployment timeline (CG-F5)

**File:** `book/chapter-03.md`
**Search for:** "6-18 month" or "six to eighteen" or "deployment timeline"
**Issue:** FedRAMP/ATO evidence supports 12-18 months as the typical range for AI SaaS. The "6-month" lower bound is only defensible if an existing FedRAMP authorization is being reused or the system is low-risk enough for an accelerated path.

**Action:** If the text says "6-18 months" without qualification, either:
- (a) Change to "12-18 months" if the context is about new FedRAMP/ATO, OR
- (b) Keep "6-18 months" but add a qualifier: "ranging from as few as 6 months when an existing authorization covers the use case to 18 months or more for new authorizations requiring full FedRAMP ATO"

Use judgment based on the surrounding context.

---

## Fix 6: Ch 8 -- FCSM dimension count (CG-X5)

**File:** `book/chapter-08.md`
**Location:** Line ~31, the sentence: `*FCSM-only (4 dimensions):* No NIST equivalent.`
**Issue:** FCSM-20-04 defines 11 dimensions in 3 domains (utility, objectivity, integrity). The "4 dimensions" in Ch 8 refers to the 4 FCSM dimensions that have NO NIST equivalent -- this is correct in context (it is describing the crosswalk gap, not the total FCSM framework).

**Action:** Verify the sentence reads as describing the crosswalk gap (FCSM dimensions with no NIST equivalent), not the total FCSM framework. If it could be misread as "FCSM has only 4 dimensions," add a clarifying parenthetical. Example: `*FCSM-only (4 of the framework's 11 dimensions):*`

---

## Fix 7: Ch 4 -- Knowledge graph vs concept map (CG-T4)

**File:** `book/chapter-04.md`
**Search for:** "concept map" or "knowledge graph" near any claim about W3C or formal standards defining the boundary.
**Issue:** No W3C standard defines the boundary between knowledge graphs and concept maps. KGs are grounded in RDF/OWL (W3C); concept maps are from Novak's pedagogical framework (no standards body). If Ch 4 implies a W3C-defined boundary, remove that implication.

**Action:** If the text claims a standards-body-defined boundary, soften to: "knowledge graphs are grounded in formal representations (RDF, OWL) designed for machine reasoning; concept maps are pedagogical tools for organizing human understanding, with no formal semantics or standards-body specification." If Ch 4 already uses informal language, no change needed.

---

## Verification Checklist

- [ ] Grep chapter-01.md for "terminology drift" -- verify framing as observation, not literature claim
- [ ] Grep chapter-07.md and chapter-11.md for "frontier" near SWE-CI -- should not appear after fix
- [ ] Grep chapter-07.md for "temperature" near reasoning/o1 -- verify "fixed at 1" not "removed"
- [ ] Grep chapter-03.md for fine-tuning threshold language -- verify reframed or already hedged
- [ ] Grep chapter-03.md for deployment timeline -- verify qualified
- [ ] Grep chapter-08.md line ~31 -- verify FCSM count is clear
- [ ] Grep chapter-04.md for "concept map" -- verify no W3C boundary claim
- [ ] No em-dashes introduced
- [ ] No bare `$` signs introduced

## Files Modified

`book/chapter-01.md` (possible terminology drift qualifier)
`book/chapter-03.md` (possible fine-tuning threshold reframe, deployment timeline qualifier)
`book/chapter-04.md` (possible KG/concept map softening)
`book/chapter-07.md` (possible "frontier" removal, temperature fix)
`book/chapter-08.md` (possible FCSM count clarification)
`book/chapter-11.md` (possible "frontier" removal)
