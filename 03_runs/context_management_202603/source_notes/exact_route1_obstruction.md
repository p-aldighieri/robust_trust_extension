# Exact Route 1 Upstream Obstruction

## Status

This note is now trusted as a local result for exact Route 1.

Conclusion:

- under the current imports, the old upstream compact-topology saddle lemma for the full measurable reduced game is false

Source artifacts:

- `Context Management/logs/20260312T002523Z_prover_exact_route1_reduced_game_upstream_response.md`
- `Context Management/logs/20260312T012451Z_reviewer_exact_route1_obstruction_lean_response.md`

## What Is Refuted

The blocked claim is the existence of a compact topology on the full adviser-kernel space `B` such that:

1. `B` is compact
2. for every deterministic measurable selector `g : M -> W`, the map `beta -> G(beta, g)` is continuous

Because deterministic selectors embed in the reduced agent space as Dirac kernels, this already kills the intended two-sided compact-topology saddle package.

## Mechanism

- on infinite `M`, arbitrary Borel messagewise selectors include indicators of arbitrary countable Borel sets
- continuity against all such selectors forces a setwise-type continuity on induced message laws
- that demand is incompatible with compactness of the full kernel space

## Reviewer-Requested Repair

The obstruction proof is accepted with one minor clarifying repair:

- add an explicit primitive signal structure generating the uniform posterior law `tau` used in the counterexample

Concrete witness suggested by the reviewer:

- prior `mu0(1) = 1/2`
- signal `s in [0,1]`
- conditional densities:
  - `pi(ds | omega = 1) = 2 s ds`
  - `pi(ds | omega = 0) = 2 (1 - s) ds`

Then the unconditional law of `s` is Lebesgue on `[0,1]` and Bayes gives `P(omega = 1 | s) = s`.

## Operational Consequence

Do not launch another prover step on the old measurable-kernel compactness lemma.

The next move must be a revised breakdown that decides which of the following is coherent:

1. a repaired upstream existence route for the exact theorem
2. a weaker theorem
3. a clearly labeled needed assumption
4. a fallback branch such as the purely atomic infinite-support case
