I keep the `countable_atomic_direct` branch and repair only the local defect identified in the two reviewer passes: finite nonempty (J_i) does **not** by itself force row mass (1), and Step 1 Case 2 must be redone using the two separate limsup bounds, plus an explicit uniform estimate on the **difference quotients** before dominated convergence.   

### Setup

Work in the already-established reduced countable-atomic problem
[
R(w)=\alpha\sum_{j\in I}\tau_j,m_j!\cdot! w_j+(1-\alpha)\sum_{i\in I}\tau_i,\phi_i(w),
\qquad
\phi_i(w):=\inf_{j\in I} m_i!\cdot! w_j,
]
with (I=\mathbb N), (\tau_j>0), (W\subset \mathbb R^N) compact convex, and (w^*=(w_j^*)*{j\in I}\in W^I) a maximizer. For each row (i), write
[
a*{ij}:=m_i!\cdot! w_j^*,\qquad
c_i:=\inf_{j\in I} a_{ij},\qquad
J_i:={j\in I:a_{ij}=c_i}.
]
For each column (j), let
[
N_j:=N_W(w_j^*)={z\in\mathbb R^N: z!\cdot!(x-w_j^*)\le 0\ \forall x\in W}.
]

Fix a finite window (F\subset I). Define
[
\delta_i^F:=\inf_{j\notin F}(a_{ij}-c_i)\in[0,\infty).
]
Call row (i) (F)-isolated if (\delta_i^F>0), and (F)-tail-touching if (\delta_i^F=0).

For (j\in F), choose (x_j\in W), set
[
d_j:=x_j-w_j^*,\qquad w_j^t:=w_j^*+t d_j=(1-t)w_j^*+t x_j,
]
and for (j\notin F) set (d_j:=0), (w_j^t:=w_j^*). Then (w^t\in W^I) for (t\in[0,1]). Also set
[
b_{ij}:=m_i!\cdot! d_j
\qquad (j\in I),
]
so (b_{ij}=0) for (j\notin F).

Define
[
\psi_i(t):=\phi_i(w^t)=\inf_{j\in I}(a_{ij}+t b_{ij}),
\qquad
\Delta_i^F(t,d):=\frac{\psi_i(t)-c_i}{t}.
]

---

### Step 1. Correct right derivative row by row

#### Lemma 1

For every row (i), the right derivative
[
\rho_i^F(d):=\lim_{t\downarrow 0}\Delta_i^F(t,d)
]
exists and is
[
\rho_i^F(d)=
\begin{cases}
\min_{j\in J_i} b_{ij}, & \delta_i^F>0,[1mm]
\min!\Bigl{0,\ \min_{j\in J_i\cap F} b_{ij}\Bigr}, & \delta_i^F=0,
\end{cases}
]
with the convention (\min\varnothing=+\infty), so the second line equals (0) when (J_i\cap F=\varnothing).

#### Proof

##### Case 1: (\delta_i^F>0)

Then (J_i\subset F). Also (J_i\neq\varnothing): if (J_i=\varnothing), then since (F) is finite and every outside index satisfies (a_{ij}\ge c_i+\delta_i^F), the infimum (c_i) would have to be attained in (F), contradiction.

Because (F) is finite and (J_i\subset F), set
[
\gamma_i^F:=\min\Bigl{\delta_i^F,\ \min_{j\in F\setminus J_i}(a_{ij}-c_i)\Bigr}>0,
]
where the second minimum is (+\infty) if (F\setminus J_i=\varnothing). Also set
[
B_i^F(d):=\max_{j\in F}|b_{ij}|<\infty.
]
If (0<t<\gamma_i^F/(2(B_i^F(d)\vee 1))), then for every (j\notin J_i),
[
a_{ij}+t b_{ij}\ge c_i+\gamma_i^F-tB_i^F(d)>c_i+\frac{\gamma_i^F}{2},
]
while for every (j\in J_i),
[
a_{ij}+t b_{ij}=c_i+t b_{ij}\le c_i+tB_i^F(d)<c_i+\frac{\gamma_i^F}{2}.
]
Hence for all such (t),
[
\psi_i(t)=\min_{j\in J_i}(c_i+t b_{ij})
= c_i+t\min_{j\in J_i} b_{ij}.
]
Therefore
[
\rho_i^F(d)=\min_{j\in J_i} b_{ij}.
]

##### Case 2: (\delta_i^F=0)

Set
[
g_i^F(d):=\min\Bigl{0,\ \min_{j\in J_i\cap F} b_{ij}\Bigr}\le 0.
]

We prove the upper bound by the two **separate** limsup estimates requested by the reviewer.

First, if (J_i\cap F\neq\varnothing), then for each (j\in J_i\cap F),
[
\psi_i(t)\le a_{ij}+t b_{ij}=c_i+t b_{ij}.
]
Hence
[
\limsup_{t\downarrow 0}\Delta_i^F(t,d)
\le \min_{j\in J_i\cap F} b_{ij}.
\tag{U1}
]

Second, because (\delta_i^F=0), for every (\varepsilon>0) and every (t>0) there exists (k\notin F) such that
[
a_{ik}<c_i+\varepsilon t.
]
Since (b_{ik}=0) for (k\notin F),
[
\psi_i(t)\le a_{ik}<c_i+\varepsilon t.
]
Therefore
[
\limsup_{t\downarrow 0}\Delta_i^F(t,d)\le \varepsilon.
]
As (\varepsilon>0) was arbitrary,
[
\limsup_{t\downarrow 0}\Delta_i^F(t,d)\le 0.
\tag{U2}
]

Combining (U1) and (U2) yields
[
\limsup_{t\downarrow 0}\Delta_i^F(t,d)\le g_i^F(d),
]
with the understanding that if (J_i\cap F=\varnothing), only (U2) is used and then (g_i^F(d)=0).

Now for the lower bound. If (j\notin F), then
[
a_{ij}+t b_{ij}=a_{ij}\ge c_i\ge c_i+t g_i^F(d).
]
If (j\in J_i\cap F), then
[
a_{ij}+t b_{ij}=c_i+t b_{ij}\ge c_i+t g_i^F(d).
]
If (j\in F\setminus J_i), then (a_{ij}-c_i>0). Since (F\setminus J_i) is finite, there exists (t_i(d)>0) such that for all (0<t<t_i(d)),
[
a_{ij}+t b_{ij}\ge c_i+t g_i^F(d)
\qquad\forall j\in F\setminus J_i.
]
Indeed, when (g_i^F(d)\le b_{ij}) this is immediate; when (g_i^F(d)>b_{ij}), it is enough to require
[
t<\frac{a_{ij}-c_i}{g_i^F(d)-b_{ij}},
]
and finitely many indices allow a common positive choice.

Hence for all sufficiently small (t>0),
[
a_{ij}+t b_{ij}\ge c_i+t g_i^F(d)\qquad\forall j\in I.
]
Taking the infimum over (j) gives
[
\psi_i(t)\ge c_i+t g_i^F(d),
]
so
[
\liminf_{t\downarrow 0}\Delta_i^F(t,d)\ge g_i^F(d).
]

Thus (\lim_{t\downarrow 0}\Delta_i^F(t,d)=g_i^F(d)), i.e.
[
\rho_i^F(d)=\min\Bigl{0,\ \min_{j\in J_i\cap F} b_{ij}\Bigr}.
]
This proves the lemma. (\square)

---

### Uniform bound on the difference quotients and the first-order inequality

The reviewer also asked for a bound on the **difference quotients themselves**, not only on their limits. That bound is immediate from the infimum representation.

Fix any norm (|\cdot|) on (\mathbb R^N), with dual norm (|\cdot|**). Since each (m_i\in\Delta(\Omega)\subset\mathbb R^N),
[
C_M:=\sup*{i\in I}|m_i|**<\infty.
]
For every (i), (t>0), and (d),
[
c_i+t\inf*{j\in I} b_{ij}
\le \inf_{j\in I}(a_{ij}+t b_{ij})
\le c_i+t\sup_{j\in I} b_{ij},
]
hence
[
\inf_{j\in I} b_{ij}\le \Delta_i^F(t,d)\le \sup_{j\in I} b_{ij}.
]
Since (b_{ij}=0) for (j\notin F),
[
|\Delta_i^F(t,d)|
\le \max_{j\in F}|b_{ij}|
\le C_M \max_{j\in F}|d_j|
\le C_M,\operatorname{diam}(W),
\tag{DQ}
]
uniformly in (i) and (t\in(0,1]).

Because (w^*) maximizes (R) and (w^t\in W^I),
[
0\ge \frac{R(w^t)-R(w^*)}{t}
============================

\alpha\sum_{j\in F}\tau_j,m_j!\cdot! d_j
+
(1-\alpha)\sum_{i\in I}\tau_i,\Delta_i^F(t,d).
]
By Lemma 1, (\Delta_i^F(t,d)\to \rho_i^F(d)) for every (i), and by (DQ) the family is dominated by the (\tau)-summable constant (C_M\operatorname{diam}(W)). Therefore dominated convergence gives
[
0\ge
\alpha\sum_{j\in F}\tau_j,m_j!\cdot! d_j
+
(1-\alpha)\sum_{i\in I}\tau_i,\rho_i^F(d).
\tag{1}
]

---

### Step 2. Corrected finite-window minimax certificate

For each row (i), define
[
K_i^F:=
\begin{cases}
\Bigl{q_i\in[0,1]^F:\ q_{ij}=0\ \forall j\in F\setminus J_i,\ \sum_{j\in F}q_{ij}=1\Bigr},
& \delta_i^F>0,[2mm]
\Bigl{q_i\in[0,1]^F:\ q_{ij}=0\ \forall j\in F\setminus J_i,\ \sum_{j\in F}q_{ij}\le 1\Bigr},
& \delta_i^F=0.
\end{cases}
]
Then
[
\rho_i^F(d)=\inf_{q_i\in K_i^F}\sum_{j\in F} q_{ij},m_i!\cdot! d_j.
\tag{2}
]

This is immediate from Lemma 1:

* if (\delta_i^F>0), then (K_i^F) is the simplex of probabilities on (J_i), so the infimum is (\min_{j\in J_i}m_i!\cdot! d_j);
* if (\delta_i^F=0), then (K_i^F) is the set of subprobabilities on (J_i\cap F), so the minimizer either puts mass (1) on the most negative coefficient in (J_i\cap F), or puts zero mass, yielding
  [
  \min\Bigl{0,\min_{j\in J_i\cap F}m_i!\cdot! d_j\Bigr}.
  ]

Now define
[
Q_F:=\prod_{i\in I} K_i^F,\qquad
D_F:=\prod_{j\in F}(W-w_j^*),
]
and
[
H_F(q,d):=
\alpha\sum_{j\in F}\tau_j,m_j!\cdot! d_j
+
(1-\alpha)\sum_{i\in I}\tau_i\sum_{j\in F} q_{ij},m_i!\cdot! d_j.
]

For fixed finite (F):

1. each (K_i^F) is compact and convex in (\mathbb R^F);
2. (Q_F) is compact and convex in the product topology on (\prod_{i\in I}\mathbb R^F);
3. (D_F) is compact and convex;
4. for every ((q,d)\in Q_F\times D_F),
   [
   \left|\sum_{j\in F} q_{ij},m_i!\cdot! d_j\right|
   \le
   \sum_{j\in F}q_{ij},|m_i!\cdot! d_j|
   \le C_M\operatorname{diam}(W)\sum_{j\in F}q_{ij}
   \le C_M\operatorname{diam}(W),
   ]
   so the series defining (H_F) is uniformly absolutely convergent;
5. hence (H_F) is jointly continuous and affine in each variable.

Use Sion’s minimax theorem in the following form: if (X,Y) are compact convex subsets of Hausdorff locally convex topological vector spaces and (h:X\times Y\to\mathbb R) is jointly continuous, quasi-convex in the first variable, and quasi-concave in the second, then
[
\inf_{x\in X}\sup_{y\in Y} h(x,y)=\sup_{y\in Y}\inf_{x\in X} h(x,y).
]
Here (X=Q_F), (Y=D_F), and (h=H_F). All hypotheses hold because (H_F) is affine in both variables.

By (1) and (2),
[
\sup_{d\in D_F}\inf_{q\in Q_F}H_F(q,d)\le 0.
]
Hence Sion gives some (q^F\in Q_F) such that
[
H_F(q^F,d)\le 0\qquad \forall d\in D_F.
\tag{3}
]

Now fix (j\in F) and (x\in W). Choose (d\in D_F) by
[
d_j=x-w_j^*,\qquad d_k=0\ \ (k\in F,\ k\neq j).
]
Plugging into (3) yields
[
\Bigl[\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i q^F_{ij}m_i\Bigr]!\cdot!(x-w_j^*)\le 0
\qquad \forall x\in W.
]
Therefore
[
\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i q^F_{ij}m_i\in N_j
\qquad \forall j\in F.
\tag{4}
]

So the corrected finite-window certificate is exactly this:

* row mass (1) on (F)-isolated rows;
* row mass only (\le 1) on (F)-tail-touching rows;
* normal-cone conditions on every column in (F).

---

### Step 3. Diagonal passage

Take an exhaustion (F_1\subset F_2\subset\cdots) with (\bigcup_n F_n=I). For each (n), choose (q^{(n)}:=q^{F_n}) from (4), and extend it to all (I\times I) by setting
[
q_{ij}^{(n)}:=0\qquad\text{for } j\notin F_n.
]
Since (I\times I) is countable and each coordinate lies in ([0,1]), a diagonal subsequence satisfies
[
q_{ij}^{(n_k)}\to \lambda_{ij}\in[0,1]
\qquad \forall i,j.
]

Support is preserved:
[
\lambda_{ij}=0\qquad\text{whenever } j\notin J_i,
\tag{5}
]
because every (q_{ij}^{(n)}) vanishes whenever (j\notin J_i).

For row sums, fix (i) and finite (G\subset I). For all large (k), (G\subset F_{n_k}), so
[
\sum_{j\in G}q_{ij}^{(n_k)}\le 1.
]
Passing to the limit,
[
\sum_{j\in G}\lambda_{ij}\le 1.
]
Taking the supremum over finite (G),
[
\sum_{j\in I}\lambda_{ij}\le 1
\qquad \forall i.
\tag{6}
]

Now define the globally isolated rows
[
\mathcal I_{\mathrm{iso}}
:=
\Bigl{
i\in I:\exists\text{ finite }F\subset I\text{ with }\delta_i^F>0
\Bigr}.
]
This is equivalent to
[
\mathcal I_{\mathrm{iso}}
=========================

\Bigl{
i\in I:
0<|J_i|<\infty
\ \text{and}
\inf_{j\notin J_i}(a_{ij}-c_i)>0
\Bigr}.
]
Indeed:

* if (\delta_i^F>0) for some finite (F), then (J_i\subset F), so (J_i) is finite and nonempty, and
  [
  \inf_{j\notin J_i}(a_{ij}-c_i)
  \ge
  \min\Bigl{\delta_i^F,\ \min_{j\in F\setminus J_i}(a_{ij}-c_i)\Bigr}>0;
  ]
* conversely, if (0<|J_i|<\infty) and (\inf_{j\notin J_i}(a_{ij}-c_i)>0), taking (F=J_i) gives (\delta_i^F>0).

If (i\in\mathcal I_{\mathrm{iso}}), then (J_i) is finite and
[
\inf_{j\notin J_i}(a_{ij}-c_i)>0.
]
Hence for all large (n) with (J_i\subset F_n),
[
\delta_i^{F_n}=\inf_{j\notin F_n}(a_{ij}-c_i)\ge \inf_{j\notin J_i}(a_{ij}-c_i)>0.
]
So for all large (n), row (i) of (q^{(n)}) has total mass (1) and is supported on the finite set (J_i). Therefore coordinatewise convergence gives
[
\sum_{j\in I}\lambda_{ij}
=========================

# \sum_{j\in J_i}\lambda_{ij}

\lim_{k\to\infty}\sum_{j\in J_i}q_{ij}^{(n_k)}
=1
\qquad \forall i\in\mathcal I_{\mathrm{iso}}.
\tag{7}
]

Finally fix (j\in I). For all large (k), (j\in F_{n_k}), so by (4),
[
a_j^{(k)}:=
\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i q_{ij}^{(n_k)}m_i
\in N_j.
]
Since (0\le q_{ij}^{(n_k)}\le 1), dominated convergence gives
[
a_j^{(k)}\to
\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i\lambda_{ij}m_i
=:a_j(\lambda).
]
Because
[
N_j=\bigcap_{x\in W}{z:z!\cdot!(x-w_j^*)\le 0}
]
is an intersection of closed half-spaces, it is closed. Hence
[
a_j(\lambda)\in N_j
\qquad \forall j\in I.
\tag{8}
]

---

### Strongest corrected supporting-kernel proposition justified by this repair

**Proposition.** There exists a matrix (\lambda=(\lambda_{ij})_{i,j\in I}) such that:

1. (\lambda_{ij}\ge 0) for all (i,j);
2. (\lambda_{ij}=0) whenever (j\notin J_i);
3. (\sum_{j\in I}\lambda_{ij}\le 1) for every row (i);
4. if (i\in\mathcal I_{\mathrm{iso}}), then (\sum_{j\in I}\lambda_{ij}=1);
5. for every column (j\in I),
   [
   \alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i\lambda_{ij}m_i\in N_W(w_j^*).
   ]

This is the strongest corrected supporting-kernel statement obtained from the repaired finite-window argument.

A clean corollary is immediate.

**Corollary.** If every row is globally isolated, equivalently if for every (i),
[
0<|J_i|<\infty
\quad\text{and}\quad
\inf_{j\notin J_i}(a_{ij}-c_i)>0,
]
then (\sum_j\lambda_{ij}=1) for every row (i), so the above (\lambda) is already an honest countably additive supporting kernel.

---

### What remains open after this repair

The repaired argument settles exactly the globally isolated rows. The unresolved rows are precisely
[
\mathcal T:=I\setminus \mathcal I_{\mathrm{iso}}.
]
By the equivalence above, this is exactly the disjoint union of:

[
\mathcal T_\infty:={i:|J_i|=\infty},
]
[
\mathcal T_{\mathrm{near}}
:=
\Bigl{
i:0<|J_i|<\infty,\ \inf_{j\notin J_i}(a_{ij}-c_i)=0
\Bigr},
]
[
\mathcal T_\emptyset:={i:J_i=\varnothing}.
]

For rows in (\mathcal T_\infty\cup\mathcal T_{\mathrm{near}}), the finite-window argument only yields
[
r_i:=1-\sum_j\lambda_{ij}\ge 0.
]
This deficit is genuine. It corresponds to mass that can hide in an outside zero-slope tail, so the finite-window first-order conditions do not determine how to complete the row to mass (1) while preserving all the column normal-cone conditions.

For rows in (\mathcal T_\emptyset), the obstruction is sharper: support on (J_i) is meaningless unless one first proves attainment of the infimum.

So after the local repair, the exact remaining crux is:

* on attained tail-touching rows (i\in\mathcal T_\infty\cup\mathcal T_{\mathrm{near}}), can one complete the deficits (r_i) to row mass (1) on (J_i) without destroying the column normal-cone inequalities;
* on unattained rows (i\in\mathcal T_\emptyset), can one prove (J_i\neq\varnothing), or else the direct support target must be modified.

Suggested next local action: isolate the tail-touching completion problem itself by trying to prove or refute a separate deficit-completion lemma on (\mathcal T_\infty\cup\mathcal T_{\mathrm{near}}), before touching the attainment problem on (\mathcal T_\emptyset).
