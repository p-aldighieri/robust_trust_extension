# Packet: Prover on conditional countable-atomic selector/subgradient proposition

## Branch

`beyond_finite_M`

## Route

`countable_atomic_attainment`

## Role

`prover`

## Goal

Prove the theorem-sized conditional proposition identified by the reviewer-cleared route switch:

- countable atomic `M`
- finite row index set `I`
- bounded payoffs
- `X := prod_{mu in I} l^1(M)`
- `X* := prod_{mu in I} l^infty(M)`
- `K := prod_{mu in I} Delta(M) subset X`

Assume the adversary problem attains a minimizer `beta* in K`.

Under the already trusted Bayes-selector existence hypotheses from the original theorem setup, prove that one can choose a messagewise Bayes-optimal selector family `g* in X*` such that

- `g* in partial V(beta*)`
- equivalently `0 in partial V(beta*) + N_K(beta*)`

and therefore, for every row `mu`, all messages in `supp beta*_mu` yield the same selected payoff, while every off-support message yields a weakly higher payoff for that row.

This should be treated as the main conditional beyond-finite-`M` proposition on the new route, not as a local lemma.

## Trusted inputs

- The old countable-atomic direct recurrence route is exhausted on the present record.
- The reviewer-cleared route switch says the new active branch is the countable-atomic attainment route.
- The reviewer-cleared route verdict says:
  - the `l^1 / l^infty` lift is coherent once a minimizer `beta*` exists
  - the first real new burden is adversary-side attainment / tightness
  - the normal cone to the countable simplex gives the same equal-payoff-on-support conclusion row by row
  - what survives from finite `M` is the support-function representation, one active selector giving one subgradient, and normal-cone equalization
- The alternative finite-`M` proof already established the selector/subgradient mechanism in finite dimensions.

## Hard requirements

- Do not fall back to the old recurrence branch.
- Do not reduce this to a tiny local technicality.
- Write the proposition cleanly enough that it can serve as a new theorem statement on this branch.
- Be explicit about the exact caveat:
  - what survives is the same complementary-slackness / equal-payoff-on-support structure
  - not literally a finite-dimensional LP
- If a step genuinely needs one extra hypothesis beyond attainment of `beta*`, isolate it exactly and say whether it is already part of the standing theorem assumptions.

## Concrete tasks

1. State the conditional proposition cleanly.
2. Define the reduced value functional `V` on `X` at the right level of generality.
3. Show why `V` is convex and continuous / Lipschitz.
4. Construct one Bayes-optimal selector family at `beta*`.
5. Prove that the resulting payoff array is a subgradient at `beta*`.
6. Compute the normal cone `N_K(beta*)` row by row for the countable simplex.
7. Deduce the exact equal-payoff-on-support conclusion needed later.
8. State clearly what theorem-level question remains after this proposition is proved.

## Output format

Return only substantive markdown.

Start with exactly one of:

- `PASS`
- `FAIL`

Then give exactly these sections:

1. Proposition
2. Proof skeleton
3. First exact caveat
4. What remains after this proposition

If `PASS`, the proposition should be written in theorem-ready form.
If `FAIL`, identify the first exact broken step.

End with one line beginning exactly:

`Suggested next macro action:`
