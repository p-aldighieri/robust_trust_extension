## VERDICT

`HOLD`

The alternative-proof architecture does **not** reveal a genuinely earlier structural condition that is credibly antecedent to the current countable-atomic endpoint. What it reveals, once separated cleanly, is this:

1. the selector/subgradient mechanism is not the problem anymore once a minimizer `beta*` exists,
2. the real finite-`M` engine was compact finite-dimensional attainment on the adversary side,
3. in countable atomic `M`, that engine fails exactly by escape of mass,
4. the surviving honest theorem endpoint remains:

   * one tight near-optimal sublevel set,
   * lower semicontinuity of `V`,
   * Bayes-side subgradient realization at the attained minimizer.

So the right branch decision is to **hold** the current conditional theorem as the honest endpoint on this architecture.

## Where finiteness enters

There are three distinct places where finite `M` is doing real work in the finite alternative proof.

First, and decisively, finite `M` makes the adversary domain `K = prod_{mu in I} Delta(M)` a compact finite-dimensional product of simplices. That is what gives existence of a minimizer `beta*` by ordinary compactness/continuity. On the countable-atomic branch, this is exactly the step that fails unconditionally: minimizing sequences can send mass to the tail and have no convergent subsequence in the product-`l^1` norm unless one imposes tightness. This is the real structural use of finiteness, not a cosmetic proof convenience.

Second, finite `M` makes the rowwise perturbation and KKT geometry literally finite-coordinate. One can move `epsilon` mass between two message coordinates inside a simplex face and read off first-order conditions on finitely many coordinates. But on the current branch this is **not** the main missing theorem burden anymore, because the banked countable-atomic selector/subgradient proposition already shows that, conditional on attainment of `beta*`, the same normal-cone conclusion extends in the Banach pair
`X = prod_{mu in I} l^1(M)`, `X* = prod_{mu in I} l^infty(M)`,
and still yields rowwise equal-payoff-on-support. So finite-dimensional KKT is not the surviving obstruction.

Third, finite `M` makes every rowwise minimization over messages an attained minimum on a finite set. In countable `M`, even if each row has a bounded payoff array, the infimum can drift down an infinite tail. This is the rowwise shadow of the same global escape-of-mass problem. Again, once a global minimizer is attained, the countable normal-cone argument is already banked. So this rowwise finite-attainment point is another face of the attainment/tightness issue, not an independent new primitive.

So the exact diagnosis is: in the finite alternative proof, finiteness matters primarily through **adversary compactness / minimizer existence**, while the convexity-subgradient part is largely portable once attainment is restored.

## Best candidate earlier condition

The best candidate suggested by the alternative-proof architecture is a **uniform rowwise inf-compactness of the selector payoff arrays on one near-optimal set**.

A clean version would be:

**Needed assumption candidate.** There exist `eta > 0` and, for every `eps > 0` and row `mu`, a finite set `F_{mu,eps} subset M` such that for every `beta in A_eta := {V <= inf_K V + eta}` and for every realizable Bayes-side selector/subgradient array `g in partial V(beta)` relevant to the rowwise minimization step, every message outside `F_{mu,eps}` is uniformly `eps` worse than the row minimum in row `mu`.

Equivalently in a stronger gap form: there exist `eta > 0`, finite sets `F_{mu,n} ↑ M`, and rowwise gaps `delta_n > 0` such that for every `beta in A_eta` and every relevant selector array `g`,
`g_mu(m) >= inf_{m'} g_mu(m') + delta_n`
for all `m ∉ F_{mu,n}`.

This is the most natural “earlier” condition visible from the finite proof because the finite proof’s local optimality statements are written in terms of messagewise payoff coefficients and simplex normal cones. If one wants a primitive before explicit probability-tail tightness, this rowwise uniform finite-capture of near-minimizing messages is the closest thing the architecture suggests.

But I do **not** think it is genuinely earlier in theorem-design substance.

Why not? Because to make it strong enough to force attainment, it must hold **uniformly over the same near-optimal set `A_eta`** and **uniformly over the same selector/subgradient objects** that drive the minimization. Once stated at that strength, it is essentially the tightness/coercivity package translated from probability tails into coefficient-array language. It is not new structural content coming from the finite proof. It is tightness wearing a different hat.

I do not see a weaker candidate from the alternative-proof architecture that is both:

1. structurally earlier than tightness, and
2. strong enough to rule out the known escape-of-mass counterexample.

## Does it imply tightness?

For the strong rowwise inf-compactness candidate above, the implication to tightness is **heuristically yes**, but only because the hypothesis already encodes the same coercive content.

Here is the mechanism. Fix `beta in A_eta`. In row `mu`, the adversary is minimizing expected selector payoff against `beta_mu`. If all messages outside a finite set `F_{mu,eps}` are uniformly worse than the row minimum by at least `eps`, then any positive tail mass outside `F_{mu,eps}` raises the row objective by at least `eps * beta_mu(M \ F_{mu,eps})`. Hence a row that stays near-optimal cannot place substantial mass outside `F_{mu,eps}`. Running this for each row and using finiteness of `I` yields a common product-tail bound, hence rowwise uniform tightness of `A_eta`. After that, the already-banked `l^1` precompactness and lower-semicontinuity argument gives attainment.

So the implication is believable, and in a sharpened formulation it can be made rigorous.

But this is exactly why it is **not** a theorem-design advance. The condition already says that on a near-optimal set, mass outside finitely many messages is uniformly penalized. That is the same coercive content as the current tight-sublevel hypothesis, just pushed one layer deeper into the local rowwise coefficient arrays. It is not genuinely antecedent.

By contrast, weaker candidates that really would be earlier, such as:

* compactness of the reduced payoff set `W`,
* finite-dimensionality of `W`,
* existence of subgradients,
* geometric connectedness/non-hollowness of trust regions,
* finite-face or finite-label structure of local witness types,

do **not** imply tightness on the present record. The project notes already isolate that finite-dimensional compact-convex geometry by itself does not force a finite stratification or a tail recurrence principle, and the escape-of-mass counterexample already lives inside the support-function architecture. So none of those weaker structural inputs closes the gap.

## Recommended theorem statement

The honest theorem statement should remain the current conditional package.

**Theorem package.** Let `M` be countable atomic and `I` finite. Let
`K := prod_{mu in I} Delta(M) subset X := prod_{mu in I} l^1(M)`.
Assume `V : K -> R` is lower semicontinuous.

1. If there exists `eta > 0` such that
   `A_eta := { beta in K : V(beta) <= inf_K V + eta }`
   is rowwise uniformly tight, then `V` attains its infimum on `K`.

2. If, moreover, Bayes-side subgradient realization holds at an attained minimizer `beta*`, then the banked selector/subgradient proposition applies:
   there exists a messagewise Bayes-optimal selector family `g*` with
   `g* in partial V(beta*)` and `-g* in N_K(beta*)`,
   hence rowwise equal-payoff-on-support.

3. The unconditional attainment theorem under the standing hypotheses alone is false by escape of mass.

If desired, one may append:

**Equivalent reformulation, not a new primitive.** Coercive finite-set capture may be stated as an equivalent reduced-form restatement of the one-tight-sublevel hypothesis.

I would **not** promote the rowwise inf-compactness candidate into the main theorem statement. If it is recorded at all, it should be labeled as a **Needed assumption candidate** and explicitly described as a coefficient-array reformulation of message coercivity, not as a new structural theorem.

## Next move

Freeze this branch as `HOLD`.

Concretely, the next move should be:

1. record in the durable notes that the alternative-proof architecture did **not** produce a genuinely earlier structural condition beyond tightness/coercivity,
2. keep the current branch endpoint exactly as:

   * tight near-optimal sublevel set,
   * lower semicontinuity,
   * Bayes-side subgradient realization,
3. stop spending theorem-design effort on repackagings of tightness inside the same architecture.

A new theorem branch would be worth opening only if it introduces genuinely new primitive content that is absent from the finite alternative proof, for example an exogenous tail cost, a primitive restriction on feasible adviser kernels, or some model-side monotonicity that directly prevents mass from escaping to infinitely many messages. Nothing of that sort is visible from the current alternative-proof architecture itself.
