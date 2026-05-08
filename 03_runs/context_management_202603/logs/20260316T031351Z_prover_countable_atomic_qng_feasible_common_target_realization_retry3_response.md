I do **not** think the present record realizes a QNG-feasible common target beyond the settled explicit class. The sharpest bankable advance is a reduction of the missing step to a compact concave program, together with a clean sufficient realization lemma. The obstruction is now genuinely geometric, not bookkeeping. 

## Fixed-tail reduction

Fix a true reduced maximizer (w^*), the positively weighted obstructing row (i^*), and an admissible infinite moved tail (S). Write
[
E:=E_S(w^*)\setminus{i^*}.
]
For (w\in W), define
[
\Delta_*(w):=m_{i^*}\cdot w-c_{i^*}(w^*),
\qquad
\Gamma_i(w):=[c_i(w^*)-m_i\cdot w]*+ \ \ (i\in E),
]
and
[
\Lambda_S(w):=\sum*{j\in S}\tau_j\big(m_j\cdot w_j^*-m_j\cdot w\big).
]
Then the QNG score is
[
\mathcal N(S,w)
===============

(1-\alpha)\Big(\tau_{i^*}\Delta_*(w)-\sum_{i\in E}\tau_i\Gamma_i(w)\Big)-\alpha\Lambda_S(w).
]
Expanding the definitions gives
[
\mathcal N(S,w)
===============

G_S\cdot w-C_S-(1-\alpha)\sum_{i\in E}\tau_i[c_i(w^*)-m_i\cdot w]*+,
\tag{1}
]
where
[
G_S:=(1-\alpha)\tau*{i^*}m_{i^*}+\alpha\sum_{j\in S}\tau_j m_j,
\qquad
C_S:=(1-\alpha)\tau_{i^*}c_{i^*}(w^*)+\alpha\sum_{j\in S}\tau_j,m_j\cdot w_j^*.
]
Since (W) is compact convex and each map (w\mapsto-[c_i(w^*)-m_i\cdot w]_+) is concave, (w\mapsto \mathcal N(S,w)) is continuous and concave on (W). Hence it attains a maximum on every closed slice of (W). 

This yields an exact fixed-(S) realization criterion:

> For a fixed admissible infinite (S), a QNG-feasible common target exists **iff** there is some (\varepsilon>0) such that
> [
> M_{S,\varepsilon}
> :=
> \max{\mathcal N(S,w): w\in W,\ m_{i^*}\cdot w\ge c_{i^*}(w^*)+\varepsilon}>0.
> \tag{2}
> ]
>
> Proof: if ((S,\bar w)) is QNG-feasible, take (\varepsilon=\Delta_*(\bar w)/2). Conversely, if (M_{S,\varepsilon}>0), any maximizer on the slice has (\Delta_*\ge\varepsilon>0) and (\mathcal N>0).

So the missing lemma is not vague anymore. It is exactly the problem of proving (2) for some admissible infinite (S).

## A plausible local realization lemma

There is a clean sufficient route that avoids exposed-row penalties altogether.

For (\varepsilon>0), define the exposed-safe active-gain slice
[
K_{S,\varepsilon}
:=
\Big{
w\in W:
m_{i^*}\cdot w\ge c_{i^*}(w^*)+\varepsilon,
\ \
m_i\cdot w\ge c_i(w^*)\ \forall i\in E
\Big}.
]
If (K_{S,\varepsilon}\neq\varnothing), let (h_{K_{S,\varepsilon}}(G_S):=\sup_{w\in K_{S,\varepsilon}} G_S\cdot w) be its support value in direction (G_S).

### Local realization lemma

If for some admissible infinite (S) and some (\varepsilon>0),
[
K_{S,\varepsilon}\neq\varnothing
\qquad\text{and}\qquad
h_{K_{S,\varepsilon}}(G_S)>C_S,
\tag{3}
]
then any maximizer (\bar w\in K_{S,\varepsilon}) of (G_S\cdot w) is QNG-feasible.

### Proof

For (\bar w\in K_{S,\varepsilon}), we have (\Delta_*(\bar w)\ge\varepsilon>0) and (\Gamma_i(\bar w)=0) for every (i\in E). Plugging into (1),
[
\mathcal N(S,\bar w)=G_S\cdot \bar w-C_S=h_{K_{S,\varepsilon}}(G_S)-C_S>0.
]
So ((S,\bar w)) satisfies the QNG hypothesis.

This is a genuine local realization lemma. It is stronger than necessary, because it kills all exposed-row losses rather than merely controlling them, but it is mathematically clean and exactly matches the explicit-class mechanism: find one common target that raises the active floor, keeps exposed rows above floor, and wins the weighted support comparison.

## First concrete obstruction

The present obstruction data still do **not** supply either part of (3), nor do they prove the more general positivity test (2). That is the first concrete obstruction.

Concretely, beyond the explicit class the current record still does not provide:

1. an admissible infinite moved tail (S) for which the exposed-safe active-gain slice (K_{S,\varepsilon}) is known to be nonempty for some (\varepsilon>0);

2. a support inequality
   [
   h_{K_{S,\varepsilon}}(G_S)>C_S;
   ]
   equivalently, a single common target in (W) that beats the aligned weighted benchmark while preserving every exposed floor;

3. more generally, positivity of the exact concave program
   [
   \max{\mathcal N(S,w): w\in W,\ m_{i^*}\cdot w\ge c_{i^*}(w^*)+\varepsilon}.
   ]

This is stricter and more concrete than the previous generic diagnosis. The unresolved object is now a support/feasibility problem on (W), parametrized by (S), not a loose appeal to “some good path should exist.” The back end is banked: once (\Delta_*>0) and (\mathcal N>0) are realized, the reviewer-cleared QNG lemma closes the contradiction. What is missing is the front-end geometric realization. 

A slightly sharper way to say the same thing is this. For fixed (S), any maximizer (w_S) of (w\mapsto\mathcal N(S,w)) must satisfy a normal-cone condition
[
q_S\in \mathsf N_W(w_S),
]
for some
[
q_S
\in
G_S
+
(1-\alpha)\sum_{i\in B_<(w_S)}\tau_i m_i
+
(1-\alpha)\sum_{i\in B_=(w_S)}[0,\tau_i],m_i,
]
where
[
B_<(w_S):={i\in E: m_i\cdot w_S<c_i(w^*)},
\qquad
B_=(w_S):={i\in E: m_i\cdot w_S=c_i(w^*)}.
]
So the missing realization is exactly the absence, on the current record, of a point of (W) whose supporting normal is generated by the active row, the aligned-tail aggregate, and the exposed-loss rows with these coefficients, while also lying strictly above the active floor. That is the first concrete geometric obstruction.

## What is now bankable

* The explicit class remains dead.
* The QNG lemma is a valid conditional export lemma on the countable-atomic direct branch.
* For each fixed admissible infinite (S), realization reduces exactly to the compact concave maximization problem (2).
* The exposed-safe support criterion (3) is a correct sufficient realization lemma.

## What is still only diagnostic

* That the current (d_1=e_1)-type obstruction data imply nonemptiness of some (K_{S,\varepsilon}).
* That they imply the support gap (h_{K_{S,\varepsilon}}(G_S)>C_S).
* That failure of the exposed-safe criterion rules out all QNG realization, since one could still win with controlled exposed deficits.

Suggested next local action: for one admissible infinite candidate tail (S), compute the exact fixed-(S) concave program (2) and first test the stronger exposed-safe support criterion (h_{K_{S,\varepsilon}}(G_S)>C_S); if that fails, record whether the failure is slice-emptiness or support-gap failure.
