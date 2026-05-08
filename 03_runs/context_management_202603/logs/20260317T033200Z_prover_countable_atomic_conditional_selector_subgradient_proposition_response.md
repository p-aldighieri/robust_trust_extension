PASS

## 1. Proposition

Proposition (countable-atomic attainment route: selector subgradient and rowwise equalization).

Let `M` be countable and `I` finite. Assume primitive payoffs are uniformly bounded by some
`B < infty`. Equip

- `X := prod_{mu in I} l^1(M)`
- `||beta||_X := sum_{mu in I} ||beta_mu||_1`

with dual

- `X* := prod_{mu in I} l^infty(M)`
- `||g||_{X*} := max_{mu in I} ||g_mu||_infty`

and pairing

- `<beta, g> := sum_{mu in I} sum_{m in M} beta_mu(m) g_mu(m)`.

Let

- `K := prod_{mu in I} Delta(M) subset X`.

Assume the standing Bayes-side hypotheses furnish a bounded selector-payoff set `G subset X*`
such that the reduced value functional is

- `V(beta) := sup_{g in G} <beta, g>`, `beta in X`,

and assume, at the minimizer `beta*` below, that every `d in partial V(beta*)` is realizable as
the payoff array of one messagewise Bayes-optimal selector family.

Assume further that the adversary problem

- `inf_{beta in K} V(beta)`

attains its minimum at some `beta* in K`.

Then there exists a messagewise Bayes-optimal selector family `g* in X*` such that

- `g* in partial V(beta*)`
- `-g* in N_K(beta*)`

equivalently

- `0 in partial V(beta*) + N_K(beta*)`.

Moreover, for each row `mu in I` there exists a scalar `c_mu in R` such that

- `g*_mu(m) = c_mu` for every `m in supp beta*_mu`
- `g*_mu(m) >= c_mu` for every `m in M`.

Thus, for each row `mu`, all messages in `supp beta*_mu` yield the same selected payoff, while
every off-support message yields a weakly higher selected payoff.

## 2. Proof skeleton

Define `V(beta) := sup_{g in G} <beta, g>`. Because primitive payoffs are bounded by `B`, every
selector-payoff array satisfies `||g||_{X*} <= B`. Hence `V` is finite on all of `X`, convex as a
supremum of continuous linear functionals, and `B`-Lipschitz:

- `|V(beta) - V(beta')| <= B ||beta - beta'||_X`.

Since `K = prod_{mu in I} Delta(M)` is closed and convex, the attained minimizer `beta*` minimizes
`F := V + iota_K`, so

- `0 in partial F(beta*)`.

Because `V` is continuous on all of `X`, the convex sum rule yields

- `partial F(beta*) = partial V(beta*) + N_K(beta*)`,

hence

- `0 in partial V(beta*) + N_K(beta*)`.

Choose `d* in partial V(beta*)` and `n* in N_K(beta*)` with `d* + n* = 0`. By the realization
hypothesis at `beta*`, the subgradient `d*` is the payoff array of one messagewise Bayes-optimal
selector family; call that array `g*`. Then

- `g* = d* in partial V(beta*)`
- `-g* = n* in N_K(beta*)`.

The rowwise normal-cone computation is the same complementarity object as in the finite simplex.
Because `K` is a finite product,

- `N_K(beta*) = prod_{mu in I} N_{Delta(M)}(beta*_mu)`.

For one row `beta in Delta(M)`,

- `N_{Delta(M)}(beta) = { z in l^infty(M) : exists c in R such that z(m) <= c for all m, and z(m) = c for all m in supp beta }`.

Applying this to `-g*` row by row yields the desired equal-payoff-on-support and weakly-better
off-support conclusion.

## 3. First exact caveat

What survives is the same complementary-slackness / equal-payoff-on-support structure as in finite
`M`, not literally a finite-dimensional LP.

The first exact point needing more than bare attainment of `beta*` is:

- every `d in partial V(beta*)` can be realized as the payoff array of one messagewise Bayes-optimal selector family.

Without that realization property, the optimality condition only gives an abstract subgradient
`d*`, and there is no automatic reason that `d*` comes from one selector family rather than from a
convex combination of active payoff arrays.

So the exact extra ingredient is Bayes-side subgradient realization, not finite-dimensional LP
duality. On this route, that is treated as already surviving from the original theorem setup.

## 4. What remains after this proposition

After this proposition, the only theorem-level issue left on this branch is adversary-side
attainment itself: prove that under the standing theorem hypotheses the minimization problem

- `inf_{beta in K} V(beta)`, with `K = prod_{mu in I} Delta(M)`,

actually attains a minimizer in the countable-atomic setting.

Since `K` is not norm-compact when `M` is infinite, this is exactly a tightness / compactness
question on the adversary side, together with the topology in which one can pass to the limit
while retaining admissibility and the value bound.

Suggested next macro action: prove the adversary-side attainment theorem, namely a
tightness/compactness principle on `K` strong enough to extract a minimizing `beta*` and pass the
value functional `V` to the limit.
