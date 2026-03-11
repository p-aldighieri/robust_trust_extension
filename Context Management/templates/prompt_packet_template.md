# Prompt Packet Template

## Role

`ROLE_NAME`

## Scope Of This Move

State the exact lemma block, delta, or review target for this packet.

## Goal

State the exact subproblem for this role.

## Hard Constraints

- No assumption smuggling.
- Any extra condition must be labeled `Needed assumption`.
- If the route fails, prefer a concrete obstruction or counterexample.
- Never truncate attached proof artifacts. If the move is too large, narrow the scope instead.

## Local Context Included

- list the local files used to build this packet

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Context Management/source_notes/proof_state.md`

## Temporary Files To Attach In This Chat

- list only the files needed for this move

## Deliberately Excluded Context

- list branch artifacts that are intentionally not being passed to keep the packet focused

## Required Output

Specify the exact markdown sections expected from the role.

## Proof-State Update Target

State exactly what should be updated in `Context Management/source_notes/proof_state.md` if this answer is accepted.

## Expected Next-Step Signal

End with a short line saying what Codex should decide next:

- continue same role
- hand off to another role
- branch
- terminate route
