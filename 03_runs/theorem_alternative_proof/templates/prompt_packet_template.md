# Prompt Packet Template

## Role

`ROLE_NAME`

## Scope Of This Move

State the exact proof block, lemma, or review target for this packet.

## Goal

State the exact subproblem for this role.

## Hard Constraints

- No assumption smuggling.
- Any extra condition must be labeled `Needed assumption`.
- If the proof sketch has a genuine gap, document it precisely rather than filling it silently.
- Never truncate attached proof artifacts. If the move is too large, narrow the scope instead.
- Do not import results from the separate extension project in `Context Management/`.

## Local Context Included

- list the local files used to build this packet

## Durable Project Sources Already In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Robust trust_alternative proof_minimax theorem.pdf`
- `source_notes/proof_state.md`

## Project Sources To Refresh Before This Chat

- list only durable files that must be removed and re-added through the project `Sources` tab before submission

## Temporary Files To Attach In This Chat

- list only chat-specific files for this move
- do not duplicate durable project sources here

## Deliberately Excluded Context

- list branch artifacts that are intentionally not being passed to keep the packet focused

## Required Output

Specify the exact markdown sections expected from the role.

## Proof-State Update Target

State exactly what should be updated in `source_notes/proof_state.md` if this answer is accepted.

## Expected Next-Step Signal

End with a short line saying what the orchestrator should decide next:

- continue same role
- hand off to another role
- branch
- request routing review
