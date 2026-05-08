# Fixed-Gamma Value Theorem

## Status

This note records the strongest currently trustworthy beyond-finite-`M` local result under the standing assumptions.

Primary source:

- `Context Management/logs/20260313T013831Z_consolidator_fixed_gamma_value_theorem_response.md`

Supporting sources:

- `Context Management/logs/20260312T231155Z_prover_adviser_induced_law_compactness_response.md`
- `Context Management/logs/20260313T000741Z_prover_foreground_followup_response.md`
- `Context Management/logs/20260313T005332Z_reviewer_exact_route_value_vs_lift_response.md`
- `Context Management/logs/20260313T011501Z_breakdown_after_exact_lifting_obstruction_response.md`

## Trusted Local Theorem

For each fixed relaxed reduced-agent kernel `gamma : M \rightsquigarrow \Delta(W)`, the adviser-side compactification is exact at the level of values:

- the compactified adviser minimum exists
- the compactified minimum equals the raw adviser-kernel infimum
- equivalently, there is no value gap between the compactified and raw adviser problems for fixed `gamma`

## Trusted Local Obstruction

The same route fails at the level of strategies:

- exact raw measurable lifting of a compactified minimizer can fail
- exact raw attainment of the raw adviser infimum can fail

Mechanism:

- compactified minimizers may sit at closure points of the raw image `m -> \bar w_gamma(m)` that are not realized by any raw message

## Mathematical Interpretation

What survives under the standing assumptions:

- a value theorem for the fixed-`gamma` adviser compactification

What does not survive under the standing assumptions:

- an exact strategy-level compactification
- the old exact version-and-patching target
- a robustly rationalizable existence theorem beyond finite `M` through this route

## Exactness Upgrade

A sufficient extra assumption for exact raw lifting is:

- continuity of `m -> \bar w_gamma(m)`

Under that added assumption, the raw image is compact, pointwise minima are attained, and exact measurable lifting can be restored.

This assumption is not part of the standing hypotheses and must be labeled explicitly if used.
