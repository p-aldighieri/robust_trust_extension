PASS

## 1. Conditional attainment theorem

**Theorem (conditional attainment from one tight near-optimal sublevel).**
Let (M) be countable, let (I) be finite, and write
[
X:=\prod_{\mu\in I}\ell^1(M),\qquad
|\beta|*X:=\sum*{\mu\in I}|\beta_\mu|*1,
\qquad
K:=\prod*{\mu\in I}\Delta(M)\subset X.
]
Let (V:K\to \mathbb R) be the countable-atomic reduced value functional on the active route, and set
[
c:=\inf_{\beta\in K}V(\beta).
]
Assume only that (V) is lower semicontinuous for the (X)-norm. Suppose there exists (\eta>0) such that the near-optimal sublevel set
[
A_\eta:={\beta\in K:V(\beta)\le c+\eta}
]
is **rowwise uniformly tight**, meaning:

for every (\varepsilon>0) and every row (\mu\in I), there exists a finite set (F_{\mu,\varepsilon}\subset M) such that
[
\sup_{\beta\in A_\eta}\beta_\mu(M\setminus F_{\mu,\varepsilon})\le \varepsilon .
]

Then there exists (\beta^*\in K) such that
[
V(\beta^*)=c=\inf_{\beta\in K}V(\beta).
]

Under the standing support-function architecture on this route, continuity of (V) is available, but the attainment argument uses only lower semicontinuity. Also, this is the sharper one-sublevel hypothesis requested on the record; the looser wrapper “every near-minimizing sequence is tight” is not needed, though it follows immediately because every minimizing sequence is eventually contained in (A_\eta). 

## 2. Proof skeleton

Let ((\beta^n)\subset K) satisfy
[
V(\beta^n)\le c+\min{\eta,1/n}.
]
Then (\beta^n\in A_\eta) for all (n).

Because (I) is finite, rowwise uniform tightness can be merged into one finite-message tail bound in the product norm: for every (\varepsilon>0), there exists a finite (F_\varepsilon\subset M) such that
[
\sup_{\beta\in A_\eta}\sum_{\mu\in I}\beta_\mu(M\setminus F_\varepsilon)\le \varepsilon.
]
Indeed, choose (F_{\mu,\varepsilon/|I|}) row by row and take their finite union.

Now fix (\varepsilon_k=2^{-k}), and choose finite (F_k\uparrow M) with
[
\sup_{\beta\in A_\eta}\sum_{\mu\in I}\beta_\mu(M\setminus F_k)\le 2^{-k}.
]
Since (I\times F_k) is finite, the coordinate block
[
\big(\beta_\mu(m)\big)*{(\mu,m)\in I\times F_k}
]
ranges in a compact finite-dimensional box. A diagonal extraction therefore yields a subsequence, still denoted (\beta^n), such that for every ((\mu,m)\in I\times M),
[
\beta^n*\mu(m)\to \beta^*_\mu(m)
]
for some nonnegative array (\beta^*=(\beta^**\mu)*{\mu\in I}).

Fix (k). Since convergence holds on the finite set (F_k),
[
\sum_{\mu\in I}\sum_{m\in F_k}\big|\beta^n_\mu(m)-\beta^**\mu(m)\big|\to 0.
]
Also,
[
\sum*{\mu\in I}\beta^n_\mu(M\setminus F_k)\le 2^{-k}
]
for every (n), and passing mass on (F_k) to the limit gives
[
\sum_{\mu\in I}\beta^**\mu(M\setminus F_k)\le 2^{-k}.
]
Hence
[
|\beta^n-\beta^*|*X
\le
\sum*{\mu\in I}\sum*{m\in F_k}\big|\beta^n_\mu(m)-\beta^**\mu(m)\big|
+\sum*{\mu\in I}\beta^n_\mu(M\setminus F_k)
+\sum_{\mu\in I}\beta^*_\mu(M\setminus F_k),
]
so first (n\to\infty), then (k\to\infty), implies (\beta^n\to\beta^*) in (X). In particular, (\beta^*\in K): each row is nonnegative and has total mass (1).

Thus every sequence in (A_\eta) has an (X)-convergent subsequence with limit in (K). Since (V) is lower semicontinuous, (A_\eta={V\le c+\eta}) is closed in (K), hence compact.

Finally, the chosen minimizing sequence lies in (A_\eta), so some subsequence converges to (\beta^*\in A_\eta). Lower semicontinuity yields
[
V(\beta^*)\le \liminf_{n\to\infty}V(\beta^n)\le c.
]
By definition of (c), necessarily (V(\beta^*)=c). So (V) attains its infimum on (K).

This uses exactly the compactness mechanism banked on the record: on a countable discrete message space, uniform tightness of probabilities is the missing (\ell^1)-precompactness, and finiteness of (I) upgrades rowwise control to compactness in the product norm. No recurrence input and no new topology are used. 

## 3. Selector/subgradient corollary

**Needed assumption for this corollary, already isolated on the record.**
At the attained minimizer (\beta^*), every (d\in \partial V(\beta^*)) is realizable as the payoff array of one messagewise Bayes-optimal selector family.

Under that additional hypothesis, the already-banked selector/subgradient proposition applies directly to the minimizer (\beta^*) just obtained. Therefore there exists a messagewise Bayes-optimal selector family (g^*\in X^*=\prod_{\mu\in I}\ell^\infty(M)) such that
[
g^*\in \partial V(\beta^*),\qquad -g^*\in N_K(\beta^*),
\qquad\text{equivalently}\qquad
0\in \partial V(\beta^*)+N_K(\beta^*).
]

Unwinding the normal cone row by row gives: for each (\mu\in I), there exists (c_\mu\in\mathbb R) with
[
g^**\mu(m)=c*\mu \quad \text{for all } m\in \operatorname{supp}\beta^**\mu,
]
and
[
g^**\mu(m)\ge c_\mu \quad \text{for all } m\in M.
]
So all messages used with positive (\beta^*_\mu)-mass deliver the same selected payoff in row (\mu), and every off-support message delivers a weakly higher selected payoff. This is exactly the rowwise equal-payoff-on-support conclusion needed to reactivate the downstream commitment step from the finite alternative proof.

The key separation is now explicit: lower semicontinuity plus tightness is enough for attainment, but Bayes-side subgradient realization is still needed only at the selector/subgradient step. 

## 4. Resulting theorem statement

**Resulting theorem on the active beyond-finite-(M) route.**

Let (M) be countable atomic and (I) finite. Work in
[
X:=\prod_{\mu\in I}\ell^1(M),\qquad K:=\prod_{\mu\in I}\Delta(M)\subset X.
]

1. **Unconditional negative part.** Under the standing hypotheses alone, attainment of
   [
   \inf_{\beta\in K}V(\beta)
   ]
   is false in general: there is a genuine escape-of-mass counterexample, so the old unconditional attainment claim must be discarded.

2. **Conditional positive attainment part.** If there exists (\eta>0) such that
   [
   A_\eta={\beta\in K:V(\beta)\le \inf_KV+\eta}
   ]
   is rowwise uniformly tight, then (V) attains its infimum on (K). For this implication, lower semicontinuity of (V) is sufficient.

3. **Conditional selector/subgradient part.** If, in addition, the already-isolated Bayes-side subgradient-realization hypothesis holds at the attained minimizer (\beta^*), then there exists a messagewise Bayes-optimal selector family (g^*) with
   [
   g^*\in \partial V(\beta^*),\qquad -g^*\in N_K(\beta^*),
   ]
   hence rowwise equal-payoff-on-support. Consequently, the same downstream commitment/LP step used in the finite alternative proof becomes available on the countable-atomic branch.

This is the least-strengthened theorem package currently justified on the route: the standing hypotheses do **not** give attainment; one tight near-optimal sublevel set is the surviving positive replacement; and once attainment is present, the already-banked selector/subgradient machinery closes the equal-payoff-on-support step. 

## 5. Remaining open point

The live open point is no longer recurrence and no longer the existence of the selector/subgradient mechanism **conditional on attainment**. The remaining theorem-level question is whether the primitive standing assumptions imply, or can be supplemented by a natural message-coercivity condition implying, the existence of one rowwise uniformly tight near-optimal sublevel set (A_\eta). Equivalently: what is the weakest primitive condition preventing escape of mass along minimizing sequences?

So the branch is now cleanly split. The unconditional theorem is false. The conditional attainment-plus-selector theorem is bankable. What remains open is the primitive source of the tightness/coercivity hypothesis. 

Suggested next macro action: write this theorem package into the durable route notes as the new branch endpoint, and then isolate one primitive message-coercivity assumption that implies rowwise tightness of (A_\eta).
