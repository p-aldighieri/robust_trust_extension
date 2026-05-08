# Post-`route_2` Route Ranking Beyond Finite `M`

## Status

This note supersedes the earlier pre-`route_2` route ranking.

It is based on the planning pass in:

- `Context Management/logs/20260311T210610Z_plan_beyond_finite_M_response.md`

## Current Reading Of The Problem

The `Theta` side is no longer the live obstruction.

Appendix A.1 already compresses private strategies to the compact convex payoff set `W`.
The remaining obstruction is on the message side:

1. obtain a saddle point in a reduced game on adviser kernels over `M`
2. upgrade almost-everywhere Bayes optimality to Definition 2's pointwise requirement for every message without destroying adversariality

Piotr's note should be treated as a strong negative prior against any route that assumes this upgrade is automatic.

## Ranked Routes

### Route 1

**Name:** reduced kernel game on `W` plus an exact saddle-preserving patching lemma

**Target:** the exact theorem under the current standing assumptions

**Assessment:** best current route, but only if the next step is a narrow breakdown around the patching lemma rather than a broad prover attempt

**Critical risk:** a patch on a `q_{beta*}`-null set may preserve payoff against `beta*` but destroy adversariality against some other admissible `beta`

### Route 2

**Name:** purely atomic infinite support

**Target:** an exact theorem on a weaker class where `M = supp(tau)` is countable and every message has positive `tau`-mass

**Assessment:** best fallback theorem-producing route if Route 1 fails

**Interpretation:** if this works, then infinite cardinality itself is not the enemy; the true obstruction is nonatomic support

### Route 3

**Name:** dominate message kernels by a common measure

**Target:** an exact theorem under an added domination regularity assumption

**Assessment:** mathematically clean but changes the theorem by assumption

### Route 4

**Name:** almost-everywhere rationalizability only

**Target:** a weaker theorem under the current standing assumptions

**Assessment:** likely easier than the exact theorem, but it does not recover Definition 2

## Recommended Immediate Next Route

Pursue **Route 1** next.

But do **not** start a full prover pass.
The next step should be a **breakdown** focused only on the critical lemma below.

## Exact Critical Lemma

Let `(beta*, gamma*)` be a saddle point of the reduced game, let

- `bar w(m) = integral_W w gamma*(dw | m)`
- `q*(dm) = alpha tau(dm) + (1-alpha) integral_M tau(ds) beta*(dm | s)`
- `p*(m)` be a `q*`-version of the posterior induced by `beta*`

The bottleneck is:

> **Version-and-patching saddle lemma**
>
> Does there exist a Borel selector `w*(m)` such that
>
> 1. `w*(m)` is Bayes-optimal for `p*(m)` at every message
> 2. replacing `bar w` by `w*` still preserves the saddle inequalities against every admissible `beta`

If this lemma is true, the exact theorem still looks reachable.
If it fails, the project likely has to move to Route 2, Route 3, or Route 4.

## Recommended Next Local Action

- `breakdown`

The breakdown should isolate only the exact reduction, saddle-topology, barycentric collapse, and version-and-patching steps needed for Route 1.
