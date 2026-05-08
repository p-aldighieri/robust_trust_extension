The right conclusion is:

1. the **naive** replacement of CTR4 by “check only exposed rows” does **break the old pointwise proof**, and
2. after rewriting the proof at the **weighted first-order** level, the weakening **does go through**.

The explicit-class no-embedding lemma, the scalarized necessary condition, the maximizer-level tail-lifting inequality, and the earlier conditional CTR export lemma are already banked on this branch.   

## 1. Where the naive exposed-row weakening first fails

Fix a common-target path
[
v_j(t)=
\begin{cases}
w_j^*,& j\in A,\
(1-t)w_j^*+t\bar w,& j\in S,
\end{cases}
\qquad t\in[0,\varepsilon].
]

Let
[
E_S(w^*):=\Big{i:\inf_{j\in S} m_i\cdot w_j^*=c_i(w^*)\Big}
]
be the set of rows whose current floor is exposed to the moved set (S).

A naive hope is that it suffices to require
[
m_i\cdot \bar w\ge c_i(w^*)\qquad\forall i\in E_S(w^*)\setminus{i^*},
]
and then reuse the old proof line
[
c_i(v(t))\ge c_i(w^*)\qquad(i\neq i^*).
]

That pointwise step is false in general on a countable family of rows.

### Concrete failure of the old pointwise step

Take
[
W=\operatorname{co}{(0,0),(1,0),(0,-1)}\subset \mathbb R^2,
]
let (A={0}), (S=\mathbb N), and define
[
w_0^*=(0,0),\qquad w_j^*=(1,0)\ \ (j\in S),\qquad \bar w=(0,-1).
]
For rows (i\ge 1), take
[
m_i=\Big(\frac1i,1-\frac1i\Big).
]
Then
[
c_i(w^*)=\inf{m_i\cdot w_0^*,,m_i\cdot w_j^*:j\in S}=0,
]
while
[
\inf_{j\in S}m_i\cdot w_j^*=\frac1i>0.
]
So **no** row is (S)-exposed. Yet for (j\in S),
[
m_i\cdot v_j(t)=m_i\cdot\big((1-t)(1,0)+t(0,-1)\big)=\frac1i-t.
]
Hence for every fixed (t>0), choosing (i>1/t) gives
[
c_i(v(t))\le \frac1i-t<0=c_i(w^*).
]
So the old row-by-row argument cannot simply replace “all rows” by “exposed rows”.

That is the **first concrete obstruction**: with countably many non-exposed rows, the tail margins can go to (0), so there need not exist one common (t>0) keeping every non-exposed row pointwise safe.

## 2. The bankable repair: switch from pointwise safety to a first-order weighted estimate

The pointwise step fails, but the contradiction can still be recovered because non-exposed rows contribute only an (o(t)) weighted loss.

### Bankable weakened CTR lemma

Let (w^*) be a true reduced maximizer carrying the scoped (d_1=e_1)-type obstruction, and let (i^*) be the positively weighted obstructing row. Assume there exist (A,S,\bar w,\varepsilon) and the admissible common-target path above such that:

### (W1) Active row is genuinely supported on the moved set and is lifted by the target

[
\inf_{j\in S} m_{i^*}\cdot w_j^*=c_{i^*}(w^*)<\inf_{j\in A} m_{i^*}\cdot w_j^*,
\qquad
\Delta_*:=m_{i^*}\cdot \bar w-c_{i^*}(w^*)>0.
]

### (W2) Define exposed-row slope losses

For each (i\in E_S(w^*)\setminus{i^*}), let
[
\Gamma_i:=\big[c_i(w^*)-m_i\cdot \bar w\big]_+.
]

### (W3) Define the aligned-loss slope

[
\Lambda:=\sum_{j\in S}\tau_j\big(m_j\cdot w_j^*-m_j\cdot \bar w\big).
]

### (W4) Quantitative net-gain condition

[
(1-\alpha)\Big(\tau_{i^*}\Delta_*-\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i\Big)>\alpha \Lambda.
\tag{QNG}
]

Then no true reduced maximizer can carry that obstruction.

## 3. Local proof sketch

Because (W) is compact and each (m_i) is a posterior in a finite-dimensional simplex, there is a finite constant (C) such that
[
|m_i\cdot(u-v)|\le C
\qquad\text{for all }i\text{ and }u,v\in W.
]
This is part of the reduced-game setup inherited from the paper. 

### Step 1. Active row contributes a linear positive gain

Let
[
\eta_*:=\inf_{j\in A} m_{i^*}\cdot w_j^*-c_{i^*}(w^*)>0.
]
For (0<t\le \min{\varepsilon,\eta_*/\Delta_*}),
[
\inf_{j\in S}m_{i^*}\cdot v_j(t)
================================

# (1-t)\inf_{j\in S}m_{i^*}\cdot w_j^*+t,m_{i^*}\cdot\bar w

c_{i^*}(w^*)+t\Delta_*,
]
while the anchored coordinates still sit above that level. Hence
[
c_{i^*}(v(t))-c_{i^*}(w^*)\ge t\Delta_*.
]

### Step 2. Exposed non-active rows have at worst linear losses

If (i\in E_S(w^*)\setminus{i^*}), then
[
\inf_{j\in S}m_i\cdot v_j(t)
============================

# (1-t)\inf_{j\in S}m_i\cdot w_j^*+t,m_i\cdot\bar w

(1-t)c_i(w^*)+t,m_i\cdot\bar w.
]
Since anchored coordinates stay fixed at values (\ge c_i(w^*)),
[
c_i(v(t))-c_i(w^*)\ge -t\Gamma_i.
]

In particular, the earlier “exposed-row safety” condition
[
m_i\cdot\bar w\ge c_i(w^*)\qquad(i\in E_S(w^*)\setminus{i^*})
]
is the special case (\Gamma_i=0).

### Step 3. Non-exposed rows contribute only (o(t))

If (i\notin E_S(w^*)), define the tail margin
[
\kappa_i:=\inf_{j\in S}\big(m_i\cdot w_j^*-c_i(w^*)\big)>0.
]
For (j\in S),
[
m_i\cdot v_j(t)
===============

m_i\cdot w_j^*+t,m_i\cdot(\bar w-w_j^*)
\ge c_i(w^*)+\kappa_i-Ct.
]
Therefore
[
[c_i(w^*)-c_i(v(t))]*+\le [Ct-\kappa_i]*+.
]
Summing with weights (\tau_i),
[
\sum_{i\notin E_S(w^*)}\tau_i[c_i(w^*)-c_i(v(t))]*+
\le
\sum*{i\notin E_S(w^*)}\tau_i[Ct-\kappa_i]*+.
]
Divide by (t):
[
0\le
\frac1t\sum*{i\notin E_S(w^*)}\tau_i[Ct-\kappa_i]*+
\le
C\sum*{i\notin E_S(w^*)}\tau_i,\mathbf 1_{{\kappa_i<Ct}}.
]
For each fixed (i\notin E_S(w^*)), (\kappa_i>0), so the indicator tends to (0) as (t\downarrow 0). Since (\sum_i\tau_i<\infty), dominated convergence gives
[
\sum_{i\notin E_S(w^*)}\tau_i[c_i(w^*)-c_i(v(t))]_+=o(t).
]

This is the key repair. Non-exposed rows need **not** be pointwise safe; they are harmless at first order.

### Step 4. Weighted floor change has the right first-order lower bound

Combining the previous steps,
[
\sum_i \tau_i\big(c_i(v(t))-c_i(w^*)\big)
\ge
t\Big(\tau_{i^*}\Delta_*-\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i\Big)-o(t).
]

### Step 5. The aligned side is exactly linear

Since only (S) moves,
[
\sum_i \tau_i\big(m_i\cdot w_i^*-m_i\cdot v_i(t)\big)
=====================================================

# t\sum_{j\in S}\tau_j\big(m_j\cdot w_j^*-m_j\cdot \bar w\big)

t\Lambda.
]

### Step 6. Contradiction with tail-lifting

The banked tail-lifting inequality says
[
(1-\alpha)\sum_i \tau_i\big(c_i(v(t))-c_i(w^*)\big)
\le
\alpha\sum_i \tau_i\big(m_i\cdot w_i^*-m_i\cdot v_i(t)\big).
]
Using the two estimates above,
[
(1-\alpha)\Big(\tau_{i^*}\Delta_*-\sum_{i\in E_S(w^*)\setminus{i^*}}\tau_i\Gamma_i\Big)-\alpha\Lambda
\le o(1)
\qquad (t\downarrow 0).
]
If (QNG) holds, the left side has a strictly positive limit, impossible for all sufficiently small (t). Hence such an obstruction cannot sit at a true reduced maximizer.

## 4. What is now bankable

### Bankable

* **CTR2** and the bookkeeping clause (1\in S) are not part of the logical engine.
* The full all-rows spillover condition can be weakened from
  [
  m_i\cdot\bar w\ge c_i(w^*)\quad\forall i\neq i^*
  ]
  to control of **exposed rows only**, once the proof is rewritten at first order.
* Even exposed-row safety is stronger than necessary. The correct quantitative object is the slope loss
  [
  \Gamma_i=[c_i(w^*)-m_i\cdot\bar w]_+.
  ]
* CTR5 can be weakened from “no aligned loss” to the slope condition (QNG). The old clause (\Lambda\le 0) is sufficient, but not necessary.
* Non-exposed rows are not a true obstruction to the contradiction. Their weighted spillovers are (o(t)).

### Only plausible, not bankable yet

* Any theorem deriving the moved set (S), the common target (\bar w), or the slope condition (QNG) from the existing (d_1=e_1) obstruction data alone.
* Any automatic implication
  [
  d_1=e_1\text{-type obstruction}\Longrightarrow\text{common-target realization satisfying (QNG)}.
  ]
* Any broader export beyond the current common-target setup.

## 5. The sharp obstruction if one tries to weaken further

If one drops exposed-row control **and** does not replace it by quantitative compensation, then exposed rows are the first genuine obstruction.

Indeed, if (i\in E_S(w^*)\setminus{i^*}) and
[
m_i\cdot\bar w<c_i(w^*),
]
then
[
\inf_{j\in S} m_i\cdot v_j(t)
=============================

(1-t)c_i(w^*)+t,m_i\cdot\bar w
<
c_i(w^*)
\qquad\forall t>0,
]
so row (i) incurs a linear floor loss immediately. Those losses can only be ignored if they are explicitly paid for inside the quantitative slope inequality.

Suggested next local action: formalize the bankable first-order export lemma above, with (E_S(w^*)), (\Gamma_i), and (\Lambda) as the core objects, and then test whether the current (d_1=e_1) obstruction data can produce the slope inequality (QNG) on a non-explicit common-target class.