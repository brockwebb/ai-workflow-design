# CC Task Addendum: Working Principles and Compressed Tenets

**Date:** 2026-03-28
**Amends:** `cc_tasks/2026-03-28_addendum_12_chapter_structure.md`
**Reason:** Incorporate working principles and compressed tenets into book structure

---

## Source

Developed during Census AI strategy visioning work (March 2026). Two paired layers: compressed tenets (strategic alignment) and working principles (operational guidance).

## Compressed Tenets (strategic frame)

1. Trust defines the mission
2. Data precedes models
3. Deliver capability quickly
4. Governance must enable execution
5. Humans remain accountable
6. Defensibility is required
7. Adapt continuously
8. Build internal capability
9. Experiment under control
10. Infrastructure enables delivery

## Working Principles (practitioner layer)

1. If it cannot be explained, do not use it
2. Slow governance prevents delivery
3. Adoption determines impact
4. Build lineage before scale
5. Reuse data before collecting more
6. Access defines capability
7. Security is a system property
8. Outputs require full provenance

## Structural Integration

### Chapter 1: Why Design Matters

Introduce both layers in the opening chapter:
- Compressed tenets presented as "the principles this book operationalizes"
- Working principles introduced as "the practitioner rules that guide design decisions"
- Frame the relationship: tenets = what matters, principles = how to act
- These are not aspirational — they emerged from doing the work

### Chapter-to-Principle Mapping

Each chapter should reference the working principle(s) it implements. This gives the book a unifying backbone.

| Chapter | Primary Principle(s) | Primary Tenet(s) |
|---------|---------------------|-------------------|
| Ch 1: Why Design Matters | All (introduction) | All (introduction) |
| Ch 2: Classification & Coding | Adoption determines impact | Deliver capability quickly |
| Ch 3: Data Cleaning & Imputation | Reuse data before collecting more | Data precedes models |
| Ch 4: Detection & Extraction | If it cannot be explained, do not use it | Humans remain accountable |
| Ch 5: Ensemble & Multi-Model | Outputs require full provenance | Defensibility is required |
| Ch 6: Parallel, Serial, Bottleneck | Adoption determines impact | Deliver capability quickly |
| Ch 7: Checkpoints & Recovery | Build lineage before scale | Experiment under control |
| Ch 8: Evaluation by Design | If it cannot be explained, do not use it | Defensibility is required |
| Ch 9: State, Drift, Validity | Outputs require full provenance | Trust defines the mission |
| Ch 10: State Mgmt & Provenance | Build lineage before scale | Defensibility is required |
| Ch 11: Operating in the Real World | Security is a system property | Governance must enable execution |
| Ch 12: Cost & Practicality | Slow governance prevents delivery | Infrastructure enables delivery |

### Appendix or Reference

Consider including both lists as a standalone reference page — something a reader can photocopy or screenshot. The kind of thing that gets pinned above a desk or referenced in a team standup.

### Connection to Broader Work

These tenets originated from Census AI program strategy work but are stated universally. The book operationalizes them for the specific context of designing AI research workflows. Future work (papers, courses, strategy documents) can reference the same tenets, creating consistency across Brock's body of work.

---

## No Separate "Principles Chapter"

Do NOT create a standalone principles chapter. The tenets and working principles live in chapter 1 as framing and throughout the book as connective tissue. A standalone manifesto chapter disconnected from practical content would contradict the book's own thesis: design matters more than theory.
