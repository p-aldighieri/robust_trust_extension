# Robust Trust Extension Update

## Purpose

This bundle summarizes the current mathematical state of the automated proof search for extending the existence direction of Theorem 2 in `Robust Trust`.

It is organized to separate:

- reviewer-cleared results that I would treat as mathematically trustworthy
- exploratory route diagnostics that were useful for navigation but should not be presented as final theorems

The goal of the project remains:

- extend the existence theorem beyond finite `M` and finite `Theta` without smuggling in new assumptions

## Executive Summary

The strongest positive theorem now in hand is:

- if `M` is finite and `Theta` is compact metric, then a robustly rationalizable strategy exists

This extends the paper from:

- finite `M`, finite `Theta`

to:

- finite `M`, compact metric `Theta`

Beyond finite `M`, the current picture is sharper but more negative:

- one natural full-kernel compact-topology route is now refuted under the standing assumptions
- one natural atomic truncation-limit route is also refuted
- a repaired adviser-side compactification route survives only at the level of values, not at the level of exact strategy lifting

So under the original standing assumptions, the strongest currently trustworthy beyond-finite-`M` local result is:

- a fixed-`gamma` raw-vs-compactified no-gap theorem
- together with a counterexample to exact raw lifting / exact raw attainment

That is mathematically meaningful, but it is not an existence theorem for robustly rationalizable strategies beyond finite `M`.

## Chronicle

### 1. Finite-`Theta` was removed while keeping `M` finite

This branch succeeded.

The trusted theorem is:

- under the paper’s standing assumptions, if `M` is finite and `Theta` is compact metric, then a robustly rationalizable strategy exists

Technically, this route used:

- the payoff-vector reduction through the compact convex set `W`
- an explicit `alpha = 0` patch
- an exact finite-dimensional reduction when `M` is finite
- a reduced minimax / Sion step for `alpha > 0`
- a lift of the reduced saddle point back to a robustly rationalizable strategy

The result depends on two durable background inputs already in the paper / Appendix A.1:

- compactness of `W`
- the paper’s wlog reduction that the adviser may be restricted to messages in `M`

### 2. The first exact route beyond finite `M` failed

The first natural route tried to put a compact topology on the full adviser-kernel space and require continuity of

- `beta -> G(beta, g)`

for every deterministic measurable selector `g : M -> W`.

This route is now locally refuted under the standing assumptions.

The mechanism is that on infinite `M`, arbitrary measurable messagewise selectors force something close to setwise continuity of induced message laws, which is incompatible with compactness of the full kernel space.

This is a real obstruction, not just an incomplete draft.

### 3. The atomic infinite-support fallback was tested

The next fallback was:

- keep `M = supp(tau)` countable with strictly positive atomic masses
- approximate by finite `M_n`
- try to pass from finite-stage saddles to a full infinite atomic saddle

This branch was useful, but the naive version did not work.

The first issue was adviser-side continuity / semicontinuity on the full reduced-agent class `W^M`. Even in the countable atomic case, fixed-`beta` continuity in the agent variable survives, but the adviser-side semicontinuity needed for minimax is still problematic.

### 4. The raw truncation-limit passage is false

We then isolated the exact decision lemma on the atomic branch:

- do cluster points of finite-stage saddle pairs remain saddle pairs of the full atomic reduced game?

The answer is no in the raw black-box form.

The counterexample is a moving-tail-minimizer construction:

- each `g_n` is benign at every fixed message
- but the adviser’s minimum keeps following a newly introduced bad tail coordinate

So:

- fixed-message Bayes optimality may pass to the limit
- adviser optimality does not

This kills the raw truncation-limit route.

### 5. The repaired adviser-side compactification route partly survives

After the atomic obstruction, the best repaired route was:

- move to an adviser-side compactification in the reduced `W`-game
- prove existence and minimization there
- then try to lift back to raw adviser kernels

This produced a genuine split theorem.

For fixed relaxed reduced-agent kernel `gamma`, the compactified adviser problem is exact at the level of values:

- the compactified minimum exists
- the compactified minimum equals the raw adviser-kernel infimum

But exact lifting back to raw adviser kernels fails in general:

- a compactified minimizer may sit at a closure point of the raw image `m -> \bar w_gamma(m)` that is not realized by any actual message
- so the raw infimum need not be attained

This means the route survives as a value theorem but fails as an exact strategy theorem under the current assumptions.

### 6. Current frontier

At this point, the strongest trustworthy mathematical frontier is:

1. theorem-level extension: finite `M`, compact metric `Theta`
2. local beyond-finite-`M` theorem: fixed-`gamma` value no-gap theorem
3. exact-strategy obstruction: exact raw lifting / exact raw attainment can fail

So the present state is not “the theorem is false.” It is:

- several natural proof routes are false under the standing assumptions
- one partial extension theorem is proved
- one weaker beyond-finite-`M` theorem is proved
- the remaining exact existence problem likely requires an explicit additional regularity assumption

## Review Status

### Reviewer-cleared and safe to present as results

- `reviewed/partial_extension_finite_M.md`
  - theorem: finite `M`, compact metric `Theta`
- `reviewed/exact_route1_obstruction.md`
  - obstruction: old full-kernel compact-topology route is false
- `reviewed/fixed_gamma_value_theorem.md`
  - theorem/obstruction package: fixed-`gamma` value no-gap survives; exact lifting fails

These are the items I would treat as the reliable mathematical output of the current pass.

### Included as route diagnostics, not final theorem claims

- `exploratory/atomic_truncation_counterexample.md`
  - very useful local obstruction on the atomic branch
  - but I would present it as a branch-killing diagnostic, not as one of the core “final” results

### Raw reviewer artifacts included for traceability

- `reviewed/reviewer_route2_pass.md`
- `reviewed/reviewer_exact_route1_obstruction.md`
- `reviewed/reviewer_exact_route_value_vs_lift.md`

These are included so the trust status of the main claims is auditable.

## Recommended Research Direction

The best next direction is not to keep trying for an exact theorem under the unchanged standing assumptions.

The best next direction is:

- identify the weakest explicit additional assumption that restores exact raw lifting / exact raw attainment
- then re-open the exact theorem under that clearly labeled strengthened hypothesis

The most obvious candidate seen so far is:

- continuity of `m -> \bar w_gamma(m)`

I would not commit to that specific assumption yet as “the right one,” but it is the cleanest current starting point because it directly addresses the failure mode in the nonattainment counterexample.

So tomorrow’s default plan is:

1. breakdown on the least-strengthened exact theorem route
2. choose the best added assumption
3. prove the first local lemma for that strengthened exact theorem

## Files In This Bundle

### Reviewed

- `reviewed/partial_extension_finite_M.md`
- `reviewed/exact_route1_obstruction.md`
- `reviewed/fixed_gamma_value_theorem.md`
- `reviewed/reviewer_route2_pass.md`
- `reviewed/reviewer_exact_route1_obstruction.md`
- `reviewed/reviewer_exact_route_value_vs_lift.md`

### Exploratory / route-state

- `exploratory/atomic_truncation_counterexample.md`
- `exploratory/proof_state.md`
- `exploratory/exact_route1_strategy.md`
