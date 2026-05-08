# Exact Route 1 Strategy Beyond Finite `M`

## Route

Keep the exact theorem alive under the current standing assumptions by working in the reduced game on the compact convex payoff set `W`, but revise the upstream existence route after the accepted kernel-topology obstruction.

## Trusted Starting Point

- The finite-`M`, compact-metric-`Theta` extension is already trusted.
- Appendix A.1 gives the compact convex payoff set `W` and the weak Pareto frontier facts.
- The selector package and exact version-and-patching lemma on `W` are trusted conditional tools.
- The old measurable-kernel compactness step is now blocked by an accepted obstruction.

## Dependency Skeleton

1. Reduce the original game to a reduced relaxed game on kernels `gamma: M \rightsquigarrow \Delta(W)`.
2. Replace the blocked full-kernel compactness lemma with a repaired upstream existence route.
3. Represent the repaired reduced saddle through posteriors and obtain `q*`-almost-everywhere local optimality.
4. Collapse the relaxed saddle barycentrically to a deterministic selector `bar w`.
5. Use the already trusted selector package on `W`.
6. Patch the `q*`-null bad set to obtain exact messagewise Bayes optimality without losing the saddle inequalities.

## Accepted Obstruction

The old step 2 is false as stated under the current imports.

Blocked claim:

- compactness of the full adviser-kernel space together with continuity of `beta -> G(beta, g)` for every deterministic measurable selector `g : M -> W`

Mechanism:

- arbitrary Borel messagewise selectors include indicators of countable Borel sets
- continuity against all such selectors forces a setwise-type continuity on induced message laws
- on infinite `M`, that requirement is incompatible with compactness of the full kernel space

Minor repair still needed in the obstruction note:

- explicitly realize the uniform posterior law `tau` by a primitive signal structure inside the paper’s model

## Current Critical Lemma

The old hinge was the exact version-and-patching saddle lemma:

- start from a deterministic reduced saddle `(beta*, bar w)`
- patch the `q*`-null bad set so that the modified selector is Bayes-optimal at every message
- preserve the adviser-side saddle inequalities against every admissible `beta`

This target is now blocked under the standing assumptions.

Reason:

- the reviewer-cleared split lemma shows that the fixed-`gamma` compactification is exact only at the level of values
- exact raw attainment / exact measurable lifting can fail because compactified minimizers may sit at closure points of the raw image `m -> \\bar w_gamma(m)` that are not realized by any raw message

Trusted local sources:

- `Context Management/logs/20260312T231155Z_prover_adviser_induced_law_compactness_response.md`
- `Context Management/logs/20260313T000741Z_prover_foreground_followup_response.md`
- `Context Management/logs/20260313T005332Z_reviewer_exact_route_value_vs_lift_response.md`

## Trusted Conditional Subpackage

Conditionally on the reduced-game Lemmas 1 to 4, the following block is now reviewed and trusted:

1. the dominating-frontier selector on `W`
2. the supporting-belief selector on the weak Pareto frontier

The exact version-and-patching saddle lemma is no longer trusted as a live route target under the standing assumptions.

## Current Repaired Route

After the atomic truncation counterexample, the best repaired route is:

- adviser-side relaxed reduced game on `W`

Source:

- `Context Management/logs/20260312T224018Z_breakdown_atomic_route_after_counterexample_response.md`

Route idea:

- do not work on the raw measurable adviser-kernel space
- do not rely on the black-box truncation-limit passage
- instead define a compact convex adviser-side class of induced objects, prove a reduced saddle there against relaxed agent kernels, and only afterwards use barycentric collapse plus the trusted exact version-and-patching lemma

## Immediate Next Scope

Do not ask for the whole theorem.

The scoped prover on the adviser-side induced-law compactness / semicontinuity lemma is now stored at:

- `Context Management/logs/20260312T231155Z_prover_adviser_induced_law_compactness_response.md`

Its local result is a split verdict:

- the fixed-`gamma` compactification is an exact value compactification
- but it is not an exact strategy compactification under the current standing assumptions

More concretely:

- the raw adviser-kernel infimum equals the compactified lower-envelope value
- but a compactified minimizer need not lift to any raw measurable adviser kernel
- exact raw attainment can fail at closure points of the image of `m -> \\bar w_gamma(m)`

The next local lemma tested after that split is now stored at:

- `Context Management/logs/20260313T000741Z_prover_foreground_followup_response.md`

That draft proves:

- exact no-gap at the level of values
- a counterexample to exact measurable lifting / exact raw attainment in general

Operational meaning:

- the exact route under current standing assumptions is now blocked at the strategy-attainment level
- the surviving object is a value theorem or a route with an added assumption ensuring exact measurable lifting

Immediate next role:

- revised breakdown on the least-strengthened exact theorem route

The next planning question is no longer “can exact lifting be proved under the current assumptions?” That question is settled negatively. The new question is:

1. what is the weakest explicit added assumption that restores exact raw lifting / exact raw attainment
2. whether that assumption still leaves a mathematically interesting exact theorem beyond finite `M`
3. what the first local lemma should be once that assumption is fixed

## Fallback

If the exact route cannot be repaired without assumption changes, the clean fallback theorem branch is the purely atomic infinite-support case.
