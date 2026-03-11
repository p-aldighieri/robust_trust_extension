# Robust Trust Proof State

## Purpose

This is the durable proof-state source for the ChatGPT project.

It should be kept attached as a project source and updated after every meaningful proof cycle.
It is the single durable place to record:

- active route
- current proof skeleton
- which lemmas are actually proved
- which reviewer verdicts are trustworthy
- what the next proof move should be

## Current Situation

- The first live browser runs proved that the automation works.
- The first live reviewer packets for both `main` and `route_2` were tainted by internal prompt truncation.
- Therefore the old reviewer verdicts are useful diagnostics but not final judgments on the proof text.

## Trust Status Of Existing Artifacts

### Trustworthy

- `formalizer` outputs
- `literature` outputs
- `searcher` outputs
- `breakdown` outputs
- `route_2` prover draft, because the stored prover file itself contains the later minimax and `alpha = 0` material

### Tainted

- the old reviewer passes on `main`
- the old reviewer passes on `route_2`

Reason:

- the reviewer request packets contained literal `[TRUNCATED]` markers and therefore did not expose the full proof drafts to the reviewer

## Active Branches To Reopen

### Main Route

Route:
- Reduce to a kernel game on the finite-dimensional payoff set `W`

Status:
- needs a fresh reviewer pass on the full prover text
- prepared reviewer packet: `Context Management/packets/20260311T181126Z_rereview_main_full_prover.md`

### Route 2

Route:
- `[SCOPE]` first remove finiteness of `Theta` while keeping `M` finite

Status:
- prover draft exists and already includes:
  - payoff-vector reduction
  - reduced finite-dimensional minimax block
  - explicit `alpha = 0` patch
- needs a fresh reviewer pass on the full prover text
- prepared reviewer packet: `Context Management/packets/20260311T181126Z_rereview_route2_full_prover.md`

## Route 2 Skeleton

1. Lemma 1: verification lemma
2. Lemma 2: payoff-vector set `W`
3. Lemma 3: `alpha = 0` edge case
4. Lemma 4: exact finite-dimensional reduction when `M` is finite
5. Lemma 5: reduced minimax / Sion step for `alpha > 0`
6. Lemma 6: lift reduced saddle point to robust rationalizability
7. Final glue: existence conclusion for finite `M`, arbitrary compact metric `Theta`

## Operational Rules

- Never send truncated proof artifacts.
- If a proof file is long, attach the file or narrow the role scope.
- Prefer lemma-scoped prover cycles and delta-scoped reviewer cycles.
- Update this file after every accepted reviewer pass or major proof amendment.
