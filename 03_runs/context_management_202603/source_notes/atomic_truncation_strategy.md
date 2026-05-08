# Atomic Truncation Strategy

## Current Route Choice

Selected route after the post-obstruction repair breakdown:

- non-topological finite truncations plus exact limit passage on the atomic branch

Source:

- `Context Management/logs/20260312T191259Z_breakdown_infinite_M_route_repair_response.md`

## Theorem Target

Aim first at the weaker but clean atomic theorem:

- if `M = supp(tau)` is countable and `tau({m}) > 0` for every message, then there exists a robustly rationalizable strategy

## Why This Route

- it is still theorem-producing
- it uses the trusted finite-`M` theorem as a black box instead of reopening settled work
- it avoids the already refuted full-kernel continuity route
- it tests the sharpest remaining atomic bottleneck directly

## First Decision Lemma

`Atomic truncation-limit decision lemma`

Fix a concrete finite approximation scheme `M_n \uparrow M` for the countable atomic branch. Using the trusted finite-`M` theorem as a black box, either:

1. prove that every cluster point of finite-stage saddle pairs is a saddle pair of the full atomic reduced game, or
2. construct an explicit counterexample showing that adviser tail concentration creates a value gap

## Current Status

This first decision lemma is now resolved negatively.

Source:

- `Context Management/logs/20260312T214211Z_prover_atomic_truncation_limit_decision_slim_response.md`

What failed:

- the raw black-box truncation-limit passage
- adviser-side lower-semicontinuity on the full atomic reduced game

Failure mechanism:

- moving-tail minimizers

Stable local note:

- `Context Management/source_notes/atomic_truncation_counterexample.md`

## Hard Limits

- do not ask again for the false compact-topology lemma on the full measurable reduced game
- do not broaden back into route comparison
- do not ask for reviewer work on the old atomic fallback draft

## Next Move

- revised breakdown
- ask only for the next repaired route after this counterexample
- acceptable outputs are:
  1. an extra ingredient that could rescue a countable-atomic theorem
  2. a weaker but still meaningful infinite-`M` theorem
  3. a route that isolates the genuinely nonatomic obstruction cleanly
