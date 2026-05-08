The safest reading of the current sources is this: beyond finite (M), the problem is no longer the (\Theta)-side. Appendix A.1 already compresses private strategies to the compact convex payoff set (W \subset \mathbb R^{|\Omega|}). The remaining obstruction is on the message side, and it has two pieces that should be kept separate:

1. obtain a saddle point in a reduced game on adviser kernels over (M);
2. upgrade the resulting almost-everywhere Bayes optimality to Definition 2’s pointwise requirement for every (m \in M), without destroying adversariality.

Piotr’s note is a strong negative prior against any route that treats either piece as automatic.

## Candidate Routes

### 1. Reduced kernel game on (W), then prove an exact saddle-preserving patching lemma

**Target:** the exact theorem under the current standing assumptions.

**Core idea.** Keep the trusted finite-(M) / compact-(\Theta) route’s main reduction and only generalize the message side. Use Appendix A.1 to compress each private strategy to a payoff vector in
[
W={w\in\mathbb R^{|\Omega|}:\exists \hat\sigma,\ w(\omega)=\mathbb E_{\hat\sigma}[u(a,\omega,\theta)\mid \omega]}.
]
Then study the reduced zero-sum game
[
\widetilde U(\beta,\gamma)
==========================

\int_M \tau(ds)\Big[
\alpha\int_W s\cdot w,\gamma(dw\mid s)
+
(1-\alpha)\int_M\int_W s\cdot w,\gamma(dw\mid m)\beta(dm\mid s)
\Big],
]
where (\beta:M\to\Delta(M)) is the misaligned adviser kernel and (\gamma:M\to\Delta(W)) is a reduced agent kernel.

**Key lemmas.**

1. **Exact reduction lemma.** The full problem and the reduced ((\beta,\gamma))-game have the same value, and any exact reduced saddle point can be lifted back to the original model.
2. **Kernel-topology saddle lemma.** Choose a concrete topology on adviser kernels and reduced agent kernels, then verify compactness, convexity, and the separate semicontinuity / affinity conditions needed for a Sion / Balder style saddle theorem. This verification is part of the work, not something to assume.
3. **Barycentric collapse.** Since (W) is convex and (\widetilde U) is affine in (w), any relaxed agent kernel (\gamma(\cdot\mid m)) can be replaced by its barycenter (\bar w(m)=\int_W w,\gamma(dw\mid m)\in W) with no payoff loss.
4. **Exact version-and-patching lemma.** Starting from a reduced saddle point ((\beta^*,\bar w)), produce a Borel selector (w^*:M\to W) that is Bayes-optimal for the posterior induced by (\beta^*) at every message and still leaves (\beta^*) adversarial.
5. **Separate (\alpha=0) patch.**
6. **Measurable Bayes lift.** Lift (w^*(m)), or directly the posterior (p^*(m)), to an actual private strategy (\hat\sigma_m). If this lift is not automatic, a **Needed assumption** would be a measurable selector (p\mapsto \hat\sigma^p) from beliefs to Bayes-optimal private strategies.

**Likely failure point.** Step 4. A saddle point normally gives Bayes optimality only (q_{\beta^*})-almost everywhere, where
[
q_{\beta^*}(dm)=\alpha\tau(dm)+(1-\alpha)\int_M\tau(ds)\beta^*(dm\mid s).
]
Patching (\bar w) on a (q_{\beta^*})-null set does not change the payoff against (\beta^*), but it can lower the payoff against some other (\beta) that targets that patched set. Then (\beta^*) stops being adversarial. This is the exact beyond-finite-(M) obstruction.

### 2. Extend first to purely atomic infinite support

**Target:** an exact theorem on a weaker class.

**Needed assumption.** (M=\operatorname{supp}(\tau)) is countable and (\tau({m})>0) for every (m\in M).

**Core idea.** Treat the infinite-support problem as a countable-product version of the trusted finite-(M) argument. After the same Appendix A.1 reduction, the adviser strategy space is (\prod_{s\in M}\Delta(M)), the reduced agent space is (W^M), and both are compact by Tychonoff. The payoff is a countable sum with an (\ell^1) weight, so continuity should be available by dominated convergence. The key gain is that every message now has strictly positive aligned probability.

**Key lemmas.**

1. Reduce to the same (W)-valued messagewise game.
2. Show compactness of (\prod_{s\in M}\Delta(M)) and (W^M) in the product topology.
3. Show continuity / semicontinuity of the countable-sum payoff.
4. Apply the same saddle-point logic as in the finite case.
5. Use
   [
   q_{\beta^*}({m})\ge \alpha,\tau({m})>0
   ]
   for every message, so global best response implies messagewise Bayes optimality for every (m), not merely almost everywhere.
6. Port the trusted (\alpha=0) patch.

**Likely failure point.** Inside the atomic class, this route looks quite plausible. Its limitation is external: it stops exactly where the real hard case begins, namely when (M) contains support points of zero mass or a nonatomic component. That limitation is informative, though. If this route works, it shows that infinite cardinality by itself is not the enemy; nonatomic support is.

### 3. Impose a common dominating message measure and work modulo that measure

**Target:** an exact theorem under an added regularity restriction.

**Needed assumption.** There exists a full-support Borel probability (\lambda) on (M) such that every admissible adviser kernel satisfies (\beta(\cdot\mid s)\ll\lambda), and the family of Radon-Nikodym densities belongs to a convex weakly compact class, for example a uniformly (L^\infty(\lambda))-bounded class.

**Core idea.** Once every message law is (\lambda)-dominated, the payoff and adversariality depend only on the agent continuation rule (\lambda)-almost everywhere. Then a stable / weak compactification of kernels becomes natural, and patching on (\lambda)-null sets is harmless because no admissible adviser can target them.

**Key lemmas.**

1. Compactness of admissible adviser densities in the chosen weak or weak-* topology.
2. Compactness of reduced agent kernels modulo (\lambda)-null sets.
3. Saddle-point existence for the (\lambda)-dominated reduced game.
4. (\lambda)-a.e. Bayes-optimal selector.
5. Exact patching on (\lambda)-null sets, now harmless by construction.
6. Separate (\alpha=0) patch.

**Likely failure point.** This solves the null-message issue by assumption. It may be a mathematically clean theorem, but it is not the paper’s model as currently stated, and the dominance restriction may be economically artificial.

### 4. Stop at an almost-everywhere rationalizability theorem

**Target:** a weaker theorem under the current standing assumptions.

**Core idea.** Accept the topology’s natural output. Prove existence of a reduced-game saddle point ((\beta^*,\gamma^*)), then conclude that some optimal strategy is Bayes-optimal for the posterior induced by (\beta^*) on a (q_{\beta^*})-full set of messages. This is the statement that standard kernel minimax machinery is most likely to deliver before any exact patching.

**Key lemmas.**

1. The same (W)-reduction.
2. Saddle-point existence in a reduced kernel game.
3. Existence of a measurable posterior version on a (q_{\beta^*})-full set.
4. Measurable Bayes selector on that full set.
5. Separate (\alpha=0) patch if needed.

**Likely failure point.** This does not recover Definition 2. It gives an optimality certificate almost everywhere, but not the paper’s messagewise equilibrium-style certification for every (m\in M).

## Recommended route to pursue next

Pursue **Route 1** next, but only as a narrow breakdown around the exact patching lemma, not as a full prover pass.

That is the only route that can still hit the unrestricted theorem without adding assumptions, and the trusted finite-(M) result has already removed the (\Theta)-side from the list of live problems. The literature map is already good enough to motivate the saddle-point side. The unresolved question is no longer “which minimax theorem might apply?” but “can pointwise Bayes-optimal patching be done while preserving adversariality?”

If that breakdown fails, the best theorem-producing fallback is **Route 2**. It is clean, inspectable, and would identify the true obstruction as nonatomic support rather than infinite cardinality itself.

## Exact critical lemma or bottleneck

Let ((\beta^*,\gamma^*)) be a saddle point of the reduced game, and let (\bar w(m)=\int_W w,\gamma^*(dw\mid m)\in W). Write
[
q^*(dm)=\alpha\tau(dm)+(1-\alpha)\int_M\tau(ds)\beta^*(dm\mid s),
]
and let (p^*(m)) be a (q^*)-version of the posterior over states induced by (\beta^*).

The critical lemma is:

> **Version-and-patching saddle lemma.**
> Does there exist a Borel selector (w^*:M\to W) such that
>
> 1. (w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w) for every (m\in M), and
> 2. ((\beta^*,w^*)) still satisfies the saddle inequalities
>    [
>    \widetilde U(\beta^*,w)\le \widetilde U(\beta^*,w^*)\le \widetilde U(\beta,w^*)
>    \quad\text{for all admissible }\beta,w ?
>    ]

If this lemma is true, then the unrestricted theorem looks reachable after a measurable Bayes lift and the separate (\alpha=0) patch. If it is false, then the exact theorem probably needs either a weaker conclusion, such as Route 4, or an added restriction that kills exploitable null messages, such as Routes 2 or 3.

Suggested next local action: breakdown
