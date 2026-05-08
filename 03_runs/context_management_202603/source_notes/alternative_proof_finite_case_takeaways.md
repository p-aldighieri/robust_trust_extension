# Alternative Proof Takeaways

This note extracts only the durable theorem-design content from
`Theorem_alternative_proof/alternative_proof_formalization.tex`.

## Scope

- finite-case formalization of the alternative proof of Theorem 2
- intended use: branch design for beyond-finite-`M`
- not a full replacement for the formalization file

## Banked finite-case lessons

1. The finite alternative proof is correct in the finite case.
2. The right envelope object is one-sided directional differentiation together with a jointly chosen
   Bayes-optimal selector family.
3. The key convex-analytic step is:
   - at an attained minimizer `beta*`, extract `g* in partial V(beta*)`
   - pair it with `-g* in N_K(beta*)`
   - conclude rowwise equal-payoff-on-support from the simplex normal cone
4. This selector/subgradient mechanism is the portable core of the proof.

## Where finite `M` really matters

The finite proof uses finite `M` mainly through adversary-side compactness:

- `K = prod_{mu in I} Delta(M)` is a compact finite-dimensional product of simplices
- therefore the adversary minimization problem attains a minimizer `beta*`
- once `beta*` exists, the selector/subgradient and normal-cone steps are largely formal

So the main beyond-finite-`M` obstruction is not selector geometry by itself. It is failure of
attainment via escape of mass.

## What does not seem to come from the finite proof

The finite alternative-proof architecture does not by itself generate a genuinely earlier structural
condition than the current countable-atomic endpoint:

- one tight near-optimal sublevel set
- lower semicontinuity of `V`
- Bayes-side subgradient realization at the attained minimizer

Any rowwise inf-compactness / finite-capture condition strong enough to restore attainment appears to
be just a reformulation of this same coercive content, not a new primitive assumption.

## Practical branch lesson

On the countable-atomic attainment route, the honest theorem endpoint remains:

1. if there exists `eta > 0` such that
   - `A_eta := { beta in K : V(beta) <= inf_K V + eta }`
   is rowwise uniformly tight,
2. and `V` is lower semicontinuous,
3. then `V` attains its infimum on `K`,
4. and with Bayes-side subgradient realization at the minimizer, the selector/subgradient corollary
   gives rowwise equal-payoff-on-support.

The unconditional attainment theorem is false on this branch because of escape of mass.
