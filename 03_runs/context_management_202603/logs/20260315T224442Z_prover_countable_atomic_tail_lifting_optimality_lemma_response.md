Using the reduced formulation already established on the countable atomic branch,
[
\Phi(w)=\sum_{i\ge 1}\tau_i\Big[\alpha, m_i!\cdot w_i+(1-\alpha),c_i(w)\Big],
\qquad
c_i(w):=\inf_{j\ge 1} m_i!\cdot w_j,
]
for deterministic reduced profiles (w=(w_j)_{j\ge 1}\in W^{\mathbb N}). Here (W\subset \mathbb R^{|\Omega|}) is the compact convex payoff set from the reduced game, and ((m_i,\tau_i)) is the countable atomic support. This is exactly the objective used in the latest embedding attempt. 

## Lemma actually provable from the reduced objective alone

**Lemma (global tail-lifting optimality).**
Let (w^*\in W^{\mathbb N}) be a true maximizer of (\Phi). Then for every comparison profile (v\in W^{\mathbb N}),
[
(1-\alpha)\sum_{i\ge 1}\tau_i\big(c_i(v)-c_i(w^*)\big)
;\le;
\alpha\sum_{i\ge 1}\tau_i\big(m_i!\cdot w_i^*-m_i!\cdot v_i\big).
\tag{TL}
]
Equivalently, any aggregate increase in the rowwise floor term must be paid for by at least as much aggregate loss in the aligned term.

A path version is immediate. If (w:[0,\varepsilon]\to W^{\mathbb N}) is any admissible path with (w(0)=w^*), then for every (t\in(0,\varepsilon]),
[
(1-\alpha)\sum_{i\ge 1}\tau_i\big(c_i(w(t))-c_i(w^*)\big)
;\le;
\alpha\sum_{i\ge 1}\tau_i\big(m_i!\cdot w_i^*-m_i!\cdot w_i(t)\big).
\tag{TL-path}
]
Hence
[
\limsup_{t\downarrow 0}\frac{\Phi(w(t))-\Phi(w^*)}{t}\le 0.
\tag{Dini}
]

### Proof

Since (w^*) is a maximizer and (v\in W^{\mathbb N}) is feasible,
[
\Phi(v)-\Phi(w^*)\le 0.
]
Expanding the definition of (\Phi),
[
\Phi(v)-\Phi(w^*)
=================

\alpha\sum_{i\ge 1}\tau_i\big(m_i!\cdot v_i-m_i!\cdot w_i^*\big)
+
(1-\alpha)\sum_{i\ge 1}\tau_i\big(c_i(v)-c_i(w^*)\big).
]
Rearranging gives (TL). Applying this with (v=w(t)) gives (TL-path). Since (\Phi(w(t))\le \Phi(w^*)) for each (t>0), the upper Dini inequality (Dini) follows immediately.

So there is a clean maximizer-level statement, but it is global. It uses only the reduced objective and maximality, with no extra regularity.

## What this lemma rules out

A direct corollary is the no-free-tail-lift principle:

**Corollary.**
If there exists (v\in W^{\mathbb N}) such that
[
m_i!\cdot v_i \ge m_i!\cdot w_i^* \quad \forall i,
\qquad
c_i(v)\ge c_i(w^*) \quad \forall i,
]
and strict inequality (c_i(v)>c_i(w^*)) holds on a set of rows of positive (\tau)-mass, then (w^*) cannot be a maximizer.

This is exactly the maximizer-level correction to the finite-window story: true maximality must control infinite-support floor-lifting comparisons, not only finitely supported perturbations.

## Test against the failed embedding attempt

In the explicit obstruction geometry,
[
W={(x,0):0\le x\le 1},\qquad
w_1^*=(0,0),\quad w_2^*=(1,0),\quad w_n^*=\Bigl(\frac1{n-1},0\Bigr)\ (n\ge 3),
]
with
[
m_2=e_1,\qquad m_i=e_2\ \ (i\neq 2),
]
all rows except (i=2) are payoff-irrelevant, and
[
\Phi(w)=\tau_2\Big[\alpha x_2+(1-\alpha)\inf_j x_j\Big].
]
Take the comparison profile (\bar w_j=(1,0)) for every (j). Then
[
m_2!\cdot \bar w_2 = 1 = m_2!\cdot w_2^*,
\qquad
c_2(\bar w)=1>0=c_2(w^*),
]
while every (i\neq 2) still contributes zero. Therefore
[
\Phi(\bar w)-\Phi(w^*)=(1-\alpha)\tau_2>0
]
for (\alpha<1). So (w^*) is not a true reduced maximizer. Equivalently, the straight-line path from (w^*) to (\bar w) is an admissible infinite-support tail-lifting path that violates (TL-path). This is exactly the failure isolated in the embedding note. 

So the candidate maximizer-level lemma is true, and it is strong enough to kill that concrete obstruction.

## Why this still does **not** yield the direct-route completion lemma

The direct branch needs something much stronger than (TL). It needs to convert the rowwise tail-touching data on
[
T=\mathcal T_\infty\cup \mathcal T_{\mathrm{near}}
]
into the columnwise completion system
[
(1-\alpha)\sum_{i\in T}\tau_i,\mu_{ij}m_i \in N_j-z_j(\lambda)\qquad \forall j,
\tag{C}
]
with the prescribed row supplies (r_i) and supports (j\in J_i). That is the reviewer-cleared bottleneck. 

The reduced objective alone does not supply (C). The reason is exact:

1. (\Phi) only records the scalar floors (c_i(w)=\inf_j m_i!\cdot w_j). After taking the infimum, all columnwise information is collapsed.
2. By contrast, (C) is a column-by-column vector feasibility statement inside the normal-cone geometry at each column (j).
3. Therefore maximality of (\Phi) gives only inequalities against **actual feasible comparison profiles** (v) or admissible paths (w(t)). It does **not** by itself manufacture such a profile from a failure of completion.

So the proof stalls at the implication
[
\text{failure of completion (C)}
\quad\Longrightarrow\quad
\text{existence of an admissible }v\in W^{\mathbb N}\text{ violating (TL)}.
\tag{*}
]
Nothing in the reduced objective alone yields ((*)).

That is exactly why the reviewer-cleared abstract obstruction remains live. In that obstruction, one row in (\mathcal T_{\mathrm{near}}) with (J_i={1}) forces a forbidden positive first-coordinate increment at column (1), while (N_1) only allows nonpositive first coordinate. So completion fails. But this is only a columnwise geometric impossibility; it is not yet an admissible comparison profile beating (w^*). 

Said differently, true maximality gives a variational inequality for every genuine comparison profile. The completion system would be a countably additive columnwise representation of that variational information. The current machinery does not justify that representation when the problematic rows are of tail type.

## Exact crux lemma

The missing ingredient is a realization or duality lemma of the following form:

> **Crux lemma needed.**
> Fix a reduced maximizer (w^*) and the tail-touching row supplies (r_i) on (T=\mathcal T_\infty\cup \mathcal T_{\mathrm{near}}). Then either
> (a) there exists a completion (\mu) satisfying the column constraints (C), or
> (b) there exists an admissible comparison profile (v\in W^{\mathbb N}), equivalently an admissible infinite-support path from (w^*) to (v), whose rowwise floor gains dominate its aligned losses and therefore violate (TL).

Without such a lemma, reduced maximality only says “no profitable comparison profile exists.” It does not say “therefore the specific transport completion must exist.”

So the status is:

* **Yes**, a maximizer-level tail-lifting optimality lemma is provable from the reduced objective alone, namely (TL)/(TL-path).
* **No**, that lemma does not by itself force the scoped completion system or close the countable-atomic direct route.
* The proof stalls exactly at the missing implication from failed completion to an actual admissible tail-lifting comparison profile.

Suggested next local action: formulate the missing realization/duality lemma turning failure of the transport completion system on (T_\infty\cup T_{\mathrm{near}}) into an explicit admissible comparison profile (v) that violates (TL), and test that lemma first on the reviewer-cleared abstract obstruction.
