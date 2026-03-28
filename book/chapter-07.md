# Chapter 7: Checkpoints, Failures, and Recovery

<!-- STATUS: Placeholder -->

## Working Notes

- Everything fails. Design for it.
- Checkpoint patterns: save state after each successful step
- Retry logic: idempotent operations, exponential backoff
- Picking up where you left off after a crash
- Config-driven state management
- Error classification: transient (retry) vs permanent (escalate) vs data (log and continue)
- Logging that gives you diagnostics, not just timestamps
