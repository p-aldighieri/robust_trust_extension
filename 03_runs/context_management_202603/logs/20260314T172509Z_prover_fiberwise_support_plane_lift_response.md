Verdict: OBSTRUCTION

## Statement

The fiberwise support-plane lift lemma is false under the standing beyond-finite-(M) inputs.

More precisely, let (F=\bar w^*:M\to W), let (\rho^*=F_# q^*), and let (\hat p:W\to \Delta(\Omega)) be a reduced-side supporting-belief selector with
[
w\in \arg\max_{u\in W}\hat p(w)\cdot u
\qquad \rho^*\text{-a.e. }w.
]
It is **not** true, in general, that one can choose a raw adviser kernel (\tilde \beta^*) whose collapse through (F) equals the adviser side of the banked reduced saddle and whose raw-message posterior version satisfies
[
p_{\tilde\beta^*}(m)=\hat p(F(m))
\qquad q^*\text{-a.e. }m.
]

What survives is only a conditional replacement:

> **Fiberwise posterior-transport condition.**
> For (\rho^*)-a.e. (w), the truthful aligned mass on the fiber (E_w:=F^{-1}(w)) must admit a nonnegative completion by misaligned mass so that the induced posterior is constant on that fiber and equal to (\hat p(w)).

That condition is strictly stronger than the already-banked reduced data, and it is the first precise obstruction for the stronger choice-of-lift route.

## Proof idea or obstruction mechanism

The old reviewer-cleared obstruction showed that the Bayes gap is not identified from collapsed data for a **fixed** raw lift. The present question is tougher and more primitive: can we exploit freedom in the **choice** of raw lift to force the pulled-back reduced support plane? The answer is still no, for a different reason.

### 1. The true necessary condition on a fiber

Fix (w\in W) and write (E_w=F^{-1}(w)). Let (q_w) be the total raw-message law on that fiber under a candidate raw lift (\tilde\beta). Suppose that on (E_w) the induced posterior is constant and equals (r:=\hat p(w)), i.e.
[
p_{\tilde\beta}(m)=r
\qquad q_w\text{-a.e. on }E_w.
]

Then for each state (\omega), the joint state-message measure on (E_w) must satisfy
[
r(\omega),q_w(dm)=\Pr_{\tilde\beta}(\omega,dm)
\quad\text{on }E_w.
]
But aligned truthful reporting contributes, at message (m), the unavoidable nonnegative mass
[
\alpha, m(\omega),\tau(dm).
]
The misaligned contribution can only add mass, never subtract it. Therefore a necessary condition is the componentwise domination
[
r(\omega),q_w(dm);\ge;\alpha, m(\omega),\tau(dm)
\qquad \forall \omega,\ \text{on }E_w.
\tag{*}
]
This is the first precise obstruction. It is a message-by-message mass-balance requirement inside each fiber. The reduced collapse does not encode it.

Equivalently: even if the reduced kernel fixes only the **aggregate** mass assigned to the fiber (E_w), to make the posterior constant on that fiber one needs enough total fiber mass to dominate the truthful aligned mass at **every raw message in the fiber**. That is a local transport constraint, not a reduced-side consequence.

### 2. Explicit counterexample

Take the following minimal environment.

* States: (\Omega={1,2}).
* Adviser posterior support:
  [
  M={m_1,m_2},\qquad m_1=(1,0),\quad m_2=(0,1),
  ]
  with
  [
  \tau(m_1)=\tau(m_2)=\tfrac12.
  ]
* Alignment probability:
  [
  \alpha>\tfrac12.
  ]
* Agent problem: one available action with constant payoff (0) in every state and type.

Because the agent has only one payoff vector, the feasible payoff set is a singleton
[
W={w_0}.
]
So (W) is compact and convex, the reduced game is trivial, and the deterministic reduced selector is necessarily
[
\bar w^*(m)=w_0
\qquad \forall m\in M.
]
Hence (F=\bar w^*) is constant, so every raw adviser kernel collapses to the same reduced adviser side. Collapse-matching is automatic.

Now choose the reduced-side supporting-belief selector
[
\hat p(w_0)=\Bigl(\tfrac12,\tfrac12\Bigr).
]
This is legitimate because every belief supports the unique point (w_0) in the singleton (W).

Suppose, toward contradiction, that there exists a raw lift (\tilde\beta) whose posterior version satisfies
[
p_{\tilde\beta}(m_1)=p_{\tilde\beta}(m_2)=\Bigl(\tfrac12,\tfrac12\Bigr).
]
Let (q(m_i)) be the unconditional probability of raw message (m_i) under that lift.

At message (m_1), the aligned truthful adviser reports (m_1) with probability (\alpha/2), and on that event state (1) occurs with probability (1). Therefore
[
\Pr(\omega=1,m_1)\ge \alpha/2.
]
But if the posterior at (m_1) were ((1/2,1/2)), then
[
\Pr(\omega=1,m_1)=\tfrac12, q(m_1).
]
Hence
[
\tfrac12,q(m_1)\ge \alpha/2
\quad\Longrightarrow\quad
q(m_1)\ge \alpha.
]
By the same argument at (m_2),
[
q(m_2)\ge \alpha.
]
So
[
1=q(m_1)+q(m_2)\ge 2\alpha>1,
]
a contradiction.

Thus no raw lift can make the posterior constant on the nontrivial fiber and equal to the pulled-back reduced support plane, even though the collapse condition is completely satisfied.

### 3. Why this is the right obstruction

This is not the old “Bayes labels are not identified” obstruction in disguise. That old obstruction said: from collapsed reduced data alone, the gap
[
g(m)=h_W(p(m))-p(m)\cdot F(m)
]
need not be pinned down inside a fiber.

The new point is sharper: sometimes the desired fiberwise labeling is not merely unidentified, it is **infeasible**. The aligned truthful mass already nails down too much state-message structure at each raw message, and a constant posterior on the whole fiber would require more total fiber mass than probability theory allows.

So the first precise obstruction is:

> **Within-fiber posterior-transport feasibility.**
> For each relevant fiber (E_w), one must solve the linear domination constraints ((*)) together with the fixed total mass implied by the collapse. The banked reduced-side inputs do not imply that this system is feasible.

## Exact dependency on banked inputs

This obstruction uses only the currently banked route ingredients:

1. the exact route works in the reduced game on the compact convex payoff set (W);
2. the beyond-finite-(M) frontier is already reduced to a deterministic selector (F=\bar w^*);
3. the only open hinge is deriving a raw-message posterior version that makes (\bar w^*) Bayes-optimal (q^*)-a.e.;
4. the reviewer-cleared fixed-lift obstruction already showed that reduced data do not identify the zero-gap condition inside fibers.

No injective-fiber condition is used. No posterior-labeled raw-lift assumption is used. No new regularity assumption is smuggled in. The counterexample even uses the smallest possible reduced game, where (W) is a singleton, so the obstruction is coming purely from message-side feasibility, not from geometry of (W).

## Consequence for the exact route

The unconditional exact route cannot be closed by the fiberwise support-plane lift lemma. The route should now be recorded as conditionally closed only under an explicit **fiberwise liftability** hypothesis, stronger than the reduced-side package and weaker than injective-fiber.

A clean replacement hypothesis is:

> For the adviser side of the banked reduced saddle and the chosen reduced-side supporting selector (\hat p), each relevant fiber (E_w) admits a nonnegative disintegration of raw-message mass satisfying the within-fiber posterior-transport constraints, so that the induced raw-message posterior equals (\hat p(w)) (q^*)-a.e. on (E_w).

Under that hypothesis, the already-cleared exact version-and-patching lemma should go through unchanged. Without it, the stronger choice-of-lift route fails at the fiber level.

Suggested next local action: Formulate the within-fiber posterior-transport feasibility condition explicitly as the new theorem hypothesis and repackage the beyond-finite-(M) exact theorem conditionally on that liftability property.
