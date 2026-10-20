# CC Task: Batch E — OWASP ASI Code Verification + Consistency Fix

**Date:** 2026-04-07
**Project:** ai-workflow-design
**Source:** `docs/2026-04-06_sweep_synthesis_run004.md` Section 2B, CG-V1

---

## Verification Results

All five ASI codes in appendix-security were verified against the published OWASP Top 10 for Agentic Applications 2026 (released December 9, 2025, https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/).

| Appendix Usage | Code | Official OWASP Name | Status |
|---|---|---|---|
| "Agent goal hijack (ASI01)" | ASI01 | Agent Goal Hijack | Correct |
| "Tool Misuse and Exploitation (ASI02)" | ASI02 | Tool Misuse and Exploitation | Correct |
| "Cascading Failures (ASI08)" | ASI08 | Cascading Failures | Correct |
| "Identity and Privilege Abuse (ASI03)" | ASI03 | Identity and Privilege Abuse | Correct |
| "OWASP ASI09: Human-Agent Trust Exploitation" | ASI09 | Human-Agent Trust Exploitation | Correct |

The sweep synthesis concern that "at least two codes (ASI08, ASI03) may be wrong" was a false positive. All codes, names, and descriptions match the published taxonomy.

For reference, the full OWASP Top 10 for Agentic Applications 2026:
- ASI01: Agent Goal Hijack
- ASI02: Tool Misuse and Exploitation
- ASI03: Identity and Privilege Abuse
- ASI04: Agentic Supply Chain Vulnerabilities
- ASI05: Unexpected Code Execution
- ASI06: Memory and Context Poisoning
- ASI07: Multi-Agent Coordination (unnamed in sources reviewed — verify exact title)
- ASI08: Cascading Failures
- ASI09: Human-Agent Trust Exploitation
- ASI10: Rogue Agents

---

## Fix: Add ASI06 Code to Memory/Context Poisoning Description

**File:** `book/appendix-security.md`
**Location:** Line 29, the sentence beginning "Memory and context poisoning"
**Issue:** All other OWASP threats in the appendix receive parenthetical ASI code treatment. This one does not. Inconsistent formatting.

**Find:** `Memory and context poisoning (corruption of an agent's persistent state to distort reasoning)`

**Replace with:** `Memory and Context Poisoning (ASI06; corruption of an agent's persistent state to distort reasoning)`

**Rationale:** Five threats are discussed. Four get "(ASI0X)" codes. The fifth must get the same treatment. Capitalizing "Memory and Context Poisoning" also aligns with the capitalization pattern used for the other four threat names.

---

## Verification Checklist

- [ ] Grep `appendix-security.md` for all ASI codes: ASI01, ASI02, ASI03, ASI06, ASI08, ASI09 should all appear
- [ ] Confirm "Memory and Context Poisoning (ASI06;" appears in the text
- [ ] Confirm no other OWASP threats are described without their ASI code

## Files Modified

`book/appendix-security.md` (one line)
