PASS

## 1. Best primitive hypothesis

Let
[
c:=\inf_{\beta\in K}V(\beta),\qquad K:=\prod_{\mu\in I}\Delta(M),
]
with (M) countable and (I) finite. For each finite (F\subset M), define the product-tail gauge
[
T_F(\beta):=\sum_{\mu\in I}\beta_\mu(M\setminus F).
]

The best current theorem-level primitive on this route is:

**Coercive finite-set capture of the reduced value.** There exist

* a number (\bar\eta>0),
* an increasing exhaustion (F_1\subset F_2\subset\cdots\uparrow M) by finite sets,
* a sequence (r_n\downarrow 0),

such that for every (n),
[
\inf\Big{V(\beta):\beta\in K,\ T_{F_n}(\beta)\ge r_n\Big}\ \ge\ c+\bar\eta.
\tag{CFC}
]

Interpretation: any adversary profile that leaves at least (r_n) total mass outside the (n)-th finite message core is uniformly separated from the optimum by the same positive value gap (\bar\eta). Since (r_n\to 0), the allowed tail level shrinks to zero along an exhaustion of (M).

This is the right reduced-form message-coercivity hypothesis on the present route. It is an inf-compactness statement for (V) relative to the explicit product-(\ell^1) tail gauges, which are exactly the objects that matter for the banked attainment theorem.

## 2. Why it is not tautological

It is not the statement that some (A_\eta) is tight. It is a value-gap exclusion principle on the reduced objective itself.

What the hypothesis controls is not compactness, but the cost of escape of mass. It says:

* putting a nonvanishing amount of mass into the far message tail is not merely inconvenient,
* it is uniformly incompatible with being near-optimal.

That is strictly more structural than saying “the near-optimal set is tight,” because it identifies the obstruction through explicit tail gauges (T_{F_n}) built from message labels.

It is also the right shape for this branch. A more classical coercivity hypothesis of the form
[
V(\beta)\ge c+\sum_{\mu}\sum_{m}\phi(m)\beta_\mu(m)
\quad\text{with}\quad \phi(m)\to\infty
]
is not natural here, because (V) is a bounded support-function-type payoff. Global domination by an unbounded message penalty is therefore the wrong geometry. The honest bounded-objective replacement is a **fixed positive tail gap near the infimum**, which is exactly what (CFC) supplies.

Finally, it excludes the already-banked escape-of-mass counterexample for the right reason. In that example, one can keep (V(\beta^n)\downarrow c) while all mass runs down a tail. So the failure is precisely the failure of any fixed positive gap (\bar\eta) against product-tail escape.

## 3. Why it implies tightness

Fix any
[
0<\eta<\bar\eta,
]
for instance (\eta=\bar\eta/2), and consider
[
A_\eta:={\beta\in K:V(\beta)\le c+\eta}.
]

I claim that (A_\eta) is rowwise uniformly tight.

Take (\beta\in A_\eta). If for some (n) we had (T_{F_n}(\beta)\ge r_n), then by (CFC),
[
V(\beta)\ge c+\bar\eta>c+\eta,
]
contradicting (\beta\in A_\eta). Hence every (\beta\in A_\eta) satisfies
[
T_{F_n}(\beta)<r_n\qquad\forall n.
\tag{1}
]

Now let (\varepsilon>0) be given. Choose (n) with (r_n<\varepsilon). Then for every (\beta\in A_\eta) and every row (\mu\in I),
[
\beta_\mu(M\setminus F_n)\le \sum_{\nu\in I}\beta_\nu(M\setminus F_n)=T_{F_n}(\beta)<r_n<\varepsilon.
]
So the single finite set (F_n) works simultaneously for all rows. Therefore (A_\eta) is rowwise uniformly tight.

This is exactly the implication the branch needs. No lower semicontinuity is used here. The argument is purely coercive: a fixed positive value gap fences the near-optimal set into a vanishing family of finite message cores.

## 4. Resulting theorem package

The branch theorem should become:

**Theorem.** Let (M) be countable atomic, (I) finite, and let
[
V:K=\prod_{\mu\in I}\Delta(M)\to\mathbb R,\qquad c=\inf_K V.
]
Assume:

1. (V) is lower semicontinuous in the product-(\ell^1) norm;
2. (V) satisfies coercive finite-set capture (CFC).

Then (V) attains its infimum on (K).

**Proof.** By Section 3, (A_{\bar\eta/2}) is rowwise uniformly tight. The already-banked conditional attainment theorem then applies verbatim, since its only theorem-level input is one tight near-optimal sublevel set plus lower semicontinuity. Hence there exists (\beta^*\in K) with (V(\beta^*)=c).

At that point the already-banked selector/subgradient proposition reactivates.

**Needed assumption, already isolated on the branch.** Bayes-side subgradient realization at the attained minimizer (\beta^*).

Under that added assumption, the existing countable-atomic selector/subgradient theorem gives a messagewise Bayes-optimal selector family (g^*\in X^*=\prod_{\mu\in I}\ell^\infty(M)) with
[
g^*\in \partial V(\beta^*),\qquad -g^*\in N_K(\beta^*),
]
hence rowwise equal-payoff-on-support.

So the full countable-atomic package becomes:

* coercive finite-set capture (+) lower semicontinuity (\Rightarrow) attainment;
* attainment (+) Bayes-side subgradient realization (\Rightarrow) rowwise equal-payoff-on-support.

## 5. Tradeoff versus stronger alternatives

The main comparison points are:

First, the banked assumption “some (A_\eta) is tight” is weaker, but it is too close to the desired compactness conclusion. It tells us **that** escape of mass does not happen, but not **why** the reduced objective blocks it.

Second, a gap hypothesis for every fixed tail threshold (\varepsilon>0),
[
\inf{V(\beta): T_F(\beta)\ge \varepsilon}\ge c+\delta(\varepsilon),
]
is stronger than needed unless one also proves a uniform positive lower bound on (\delta(\varepsilon)) along a shrinking tail scale. Without such uniformity, one does not get a single fixed (\eta>0) and hence does not get one tight near-optimal sublevel set. The present hypothesis is the minimum uniformity that actually buys the theorem: one fixed gap (\bar\eta) along one coercive scale (r_n\downarrow0).

Third, the alternative-proof formalization suggests a more model-tethered but stronger condition, namely a uniform tail gap on the rowwise linear cost profiles (m\mapsto c_\mu(m)) produced by a common Bayes-optimal selector family. That would be attractive, but on the present record it is not the right main theorem hypothesis, because those selector-side objects are only canonically available after attainment or after a stronger subgradient-realization input across a near-optimal band. So it is less honest as the current branch hypothesis.

So the chosen condition sits in the right middle. It is stronger than raw tightness, but it is the weakest non-tautological objective-side coercivity condition I can currently justify that genuinely forces one fixed tight near-optimal sublevel.

## 6. Recommended branch statement

Yes. On this branch, this should replace raw tightness as the main theorem statement.

More precisely, the new beyond-finite-(M) branch statement should be:

> In the countable-atomic reduced game, assume (V) is lower semicontinuous and satisfies coercive finite-set capture of the reduced value. Then (V) attains its infimum on (K=\prod_{\mu\in I}\Delta(M)). If, moreover, Bayes-side subgradient realization holds at the attained minimizer, then the banked selector/subgradient proposition yields rowwise equal-payoff-on-support.

That is the cleanest theorem-scale upgrade currently supported by the record. It is reduced-form rather than fully model-primitive, but that is exactly the honest frontier of this route.

Suggested next macro action: update the route notes so the branch’s main hypothesis is coercive finite-set capture, then test whether the finite-message alternative-proof row costs can furnish this gap via finite truncation comparisons.
