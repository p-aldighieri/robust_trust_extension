FAIL

## 1. Attainment theorem candidate

The theorem that would finish the active route is:

- if `I` is finite, `M` is countable atomic, `K = prod_{mu in I} Delta(M) subset X = prod_{mu in I} l^1(M)`, and
  `V(beta) = sup_{g in G} <beta, g>` under the standing hypotheses, then `inf_{beta in K} V(beta)` is attained.

On the current record, that statement is false.

What is true instead is the exact tightness criterion behind any successful proof:

- if `(beta_n) subset K` is a minimizing sequence for `V` and for every `epsilon > 0` there exists a finite
  `F subset M` such that
  - `sup_n sup_{mu in I} beta_n,mu(M \\ F) <= epsilon`,
  then `inf_{beta in K} V(beta)` is attained.

So the real theorem-sized burden is not generic compactness of `K`, but rowwise uniform tightness of
near-minimizers.

## 2. Main mechanism

The only credible attainment mechanism is:

- rowwise uniform tightness of minimizing sequences
- implies norm precompactness in `X`
- implies attainment by continuity of `V`.

Proof sketch:

- diagonalize coordinatewise on countable `M`
- use uniform tightness plus Fatou to show the limit stays in `Delta(M)` row by row
- because `I` is finite, rowwise tightness is simultaneous
- that upgrades coordinatewise convergence to convergence in the `X` norm
- boundedness of `G subset X*` gives norm-continuity of `V`
- so the limit of a tight minimizing sequence attains the infimum

Thus the compactness mechanism is bankable once rowwise uniform tightness is available. On countable
discrete `M`, this is the right Prokhorov-style replacement inside `l^1`: tightness gives norm
precompactness, not merely weak precompactness.

## 3. First exact obstruction or proof

The first exact broken step is the tightness step itself.

Under the standing hypotheses alone, minimizing sequences need not be rowwise uniformly tight. There is
a genuine escape-of-mass counterexample already inside the support-function architecture.

Take:

- `M = N`
- any nonempty finite `I`
- `a_m := 1/m`
- `F_m := { a_m 1_I } subset R^I`

Then the reduced functional has the form

- `V(beta) = sum_{mu in I} sum_{m >= 1} beta_mu(m) / m`.

This `V` is linear, convex, Lipschitz, and norm-continuous on `X`.

Define a minimizing sequence by putting every row on message `n`:

- `beta_n,mu = delta_n` for every `mu in I`.

Then:

- `V(beta_n) = |I| / n -> 0`
- so `inf_{beta in K} V(beta) = 0`

But no `beta in K` attains that value, because every row has total mass `1` and every coefficient
`1/m` is strictly positive, so `V(beta) > 0` for all `beta in K`.

This is genuine escape of mass:

- `(beta_n)` is not rowwise tight
- its coordinatewise limit is the zero array, which lies outside `K`
- there is no norm-convergent subsequence since `||delta_n - delta_k||_1 = 2` for `n != k`
- by the Schur property of `l^1`, there is no weakly convergent subsequence either

So the failure is not a lower-semicontinuity gap and not a missing local lemma. It is a true
obstruction: bounded continuous support-function structure alone does not prevent adversarial mass
from running down an infinite tail of messages whose costs approach the infimum without ever
achieving it.

## 4. Consequence for the beyond-finite-M program

The current countable-atomic attainment route does not close under the standing hypotheses alone.
Adversary-side minimization can genuinely fail to attain.

What survives is the sharp conditional statement:

- once `epsilon`-minimizers are rowwise uniformly tight, attainment follows immediately in
  `X = prod_{mu in I} l^1(M)`,
- and then the already banked selector/subgradient proposition reactivates without further
  finite-dimensional patchwork.

So the new burden is not another selector lemma. It is a new primitive coercivity or inf-compactness
assumption on the message index. A natural reduced-form version is:

- for every `epsilon > 0` there exists a finite `F subset M` such that
  - `V(beta) <= inf_K V + epsilon`
  - implies `beta_mu(F) >= 1 - epsilon` for all `mu in I`.

That hypothesis rules out the counterexample exactly.

Suggested next macro action: add an explicit near-minimizer tightness or message-coercivity
hypothesis to the theorem statement, prove the tightness criterion as the attainment lemma, and
then reconnect the already banked selector/subgradient theorem.
