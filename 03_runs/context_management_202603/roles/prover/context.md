# Prover Context

## Status

Do not start until the breakdown is stable enough to support a focused cycle.
The prover should be working on one lemma block or one reviewer-identified delta, not the whole branch at once.

## Primary Local Sources

- active breakdown
- route memo
- latest reviewer feedback
- any narrow technical notes relevant to the current lemma

## Output To Maintain

- exact lemma progress
- explicit gaps
- any `Needed assumption`
- any `BREAKDOWN_AMEND` request

## Scope Rule

- Pass only the current lemma target, the active breakdown, and the exact reviewer delta being patched.
- Do not attach the full branch history unless the task is final glue or consolidation.
- If the packet starts to sprawl, stop and split the move into a smaller proof task.

## Promotion Rule

Promote only the latest accepted prover note, not every exploratory attempt.
