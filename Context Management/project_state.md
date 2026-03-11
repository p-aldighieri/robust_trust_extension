# Project State

## Objective

Extend the existence direction of Theorem 2 in `Robust Trust` beyond finite `M` and `Theta` without smuggling new assumptions.

## Durable Project Sources In ChatGPT

- `objective_statement.md`
- `Robust_trust_Dworczak_Smolin.pdf`
- `Context Management/source_notes/proof_state.md`
- optional next durable additions:
  - `project_brief.md`
  - `Context Management/source_notes/piotr_topology_note.md`
  - `Context Management/source_notes/literature_map.md`

## Completed Or Skippable Stages

- claim parsing / formal statement: locally complete enough to skip by default
- core model description: locally complete enough to skip by default

## Recommended Next Role

`reviewer`

Task:
Re-review the old `main` and `route_2` proof artifacts using the full prover files, because the first live reviewer packets were internally truncated.

Prepared packets:
- `Context Management/packets/20260311T181126Z_rereview_main_full_prover.md`
- `Context Management/packets/20260311T181126Z_rereview_route2_full_prover.md`

## Author Guidance

- Piotr reports that his general-proof attempts did not work.
- Treat that as evidence that a successful extension likely needs the right topology and may require additional restrictions on the spaces.
- Reject any claimed unrestricted proof that does not explicitly resolve those existence/topology issues.

## Last Verified Browser Facts

- project name: `Robust Trust proof`
- composer effort control: `Pro` pill next to `+`
- required setting: `Extended`
- result label after switching: `Extended Pro`
- project tabs: `Chats`, `Sources`

## Logging Rule

Every browser interaction that produces a mathematical answer must be saved in `logs/` before the next role starts.

## Current Recovery Rule

- Do not restart from `formalizer` when a late-stage branch already exists.
- Restart from the latest trustworthy branch artifact.
- If a prior reviewer packet was truncated, treat its verdict as tainted and rerun the review on the full proof text.

## Local Automation Status

- packet builder script: available
- JSON conversation logger: available
- browser source management: feasible but not yet scripted
- browser prompt submission and polling: feasible but not yet scripted
