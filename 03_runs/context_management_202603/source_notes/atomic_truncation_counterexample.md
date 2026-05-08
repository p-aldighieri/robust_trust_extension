# Atomic Truncation Counterexample

## Status

This note records the scoped prover result saved at:

- `Context Management/logs/20260312T214211Z_prover_atomic_truncation_limit_decision_slim_response.md`

The result is a substantive counterexample to the raw truncation-limit passage proposed for the countable atomic branch.

## What Fails

The following black-box step is false in the current atomic route:

- from finite-stage saddle pairs on `M_n`, one cannot conclude that every cluster point is a saddle pair of the full atomic reduced game on `M`

The failure is on the adviser side:

- the lower-semicontinuity needed to pass finite-stage adviser optimality to the limit fails

## Tail Mechanism

The counterexample uses a moving-tail minimizer:

- choose `M = {m_0, m_1, m_2, ...}` with strictly positive atomic masses
- define selectors `g_n` that are benign everywhere except at the newest tail message `m_n`
- `g_n` converges coordinatewise to a harmless limit selector
- but the adviser minimum keeps chasing the moving bad coordinate

So:

- fixed-message Bayes optimality can pass to the limit
- adviser optimality cannot pass without extra structure

## Consequence

The atomic branch does not advance through the raw truncation-limit lemma alone.

Any repaired route now needs at least one additional ingredient such as:

1. selector regularity along the chosen finite-stage saddles
2. a domination or tightness restriction that blocks moving-tail exploitation
3. a different reduced-agent or adviser-side formulation

## Next Move

- revised breakdown
