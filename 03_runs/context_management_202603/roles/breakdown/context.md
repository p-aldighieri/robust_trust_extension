# Breakdown Context

## Status

Run only after the route is chosen.
Codex should inspect the route choice before this role starts.

## Primary Local Sources

- current route memo
- current trustworthy proof-state note
- any branch-specific reviewer correction that affects the skeleton
- any accepted reviewer corrections

## Output To Maintain

- numbered lemmas
- dependency order
- one explicit critical lemma
- fallback branch if the critical lemma fails

## Promotion Rule

The active breakdown should usually be attached temporarily to prover and reviewer chats.

## Approval Rule

- Any new or amended breakdown should be inspected by Codex before the next prover cycle starts.
- Do not send a broad breakdown that mixes multiple routes or too many unresolved subgoals.
