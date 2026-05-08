### Setup

Fix the countable atomic support (M={m_j}*{j\in I}) with (I=\mathbb N), weights (\tau_j>0), the compact convex payoff set (W\subset \mathbb R^N), and the reduced objective
[
R(w)=\alpha\sum*{j\in I}\tau_j, m_j!\cdot! w_j+(1-\alpha)\sum_{i\in I}\tau_i,\phi_i(w),
\qquad
\phi_i(w):=\inf_{j\in I} m_i!\cdot! w_j,
]
for (w=(w_j)*{j\in I}\in W^I). Let (w^*=(w_j^*)*{j\in I}) be a reduced maximizer.

For each row (i), write
[
a_{ij}:=m_i!\cdot! w_j^*,\qquad c_i:=\inf_{j\in I} a_{ij},\qquad J_i:={j\in I:a_{ij}=c_i}.
]
For each on-path (j), let (N_j:=N_W(w_j^*)).

For a finite window (F\subset I), define the outside isolation gap
[
\delta_i^F:=\inf_{j\notin F}(a_{ij}-c_i)\in[0,\infty).
]
Call row (i) **(F)-isolated** if (\delta_i^F>0), and **(F)-tail-touching** if (\delta_i^F=0).

The reviewer’s objection is exactly that the old argument conflated
[
J_i\subset F
\quad\text{with}\quad
\delta_i^F>0.
]
Those are not equivalent. The hybrid case is (J_i\subset F) but (\delta_i^F=0), meaning the exact minimum is attained inside (F) while an outside near-minimizing tail still survives.

---

### Step 1 repaired: the correct right derivative

Fix finite (F\subset I). For (j\in F), choose (x_j\in W) and set
[
d_j:=x_j-w_j^*,\qquad
w_j^t:=(1-t)w_j^*+t x_j \quad (j\in F),
]
and (d_j:=0,\ w_j^t:=w_j^*) for (j\notin F). Then (w^t\in W^I) for (t\in[0,1]).

For each row (i), write
[
b_{ij}:=m_i!\cdot! d_j
\quad\text{for } j\in F,\qquad
b_{ij}:=0
\quad\text{for } j\notin F.
]
Define
[
\rho_i^F(d):=\lim_{t\downarrow 0}\frac{\phi_i(w^t)-\phi_i(w^*)}{t}.
]

**Lemma 1.** For every row (i),
[
\rho_i^F(d)=
\begin{cases}
\min_{j\in J_i} b_{ij}, & \delta_i^F>0,[1mm]
\min!\Bigl{0,\ \min_{j\in J_i\cap F} b_{ij}\Bigr}, & \delta_i^F=0,
\end{cases}
]
with the convention (\min\varnothing=+\infty), so the second line equals (0) when (J_i\cap F=\varnothing).

#### Proof

Let
[
\psi_i(t):=\phi_i(w^t)=\inf_{j\in I}(a_{ij}+t b_{ij}).
]

##### Case 1: (\delta_i^F>0)

Then no index outside (F) is minimizing, so (J_i\subset F). Also (J_i\neq\varnothing): if (J_i=\varnothing), then since (F) is finite and every outside index is at distance at least (\delta_i^F>0) above (c_i), the infimum would have to be attained inside (F), contradiction.

Now set
[
\gamma_i^F:=\min!\Bigl{\delta_i^F,\ \min_{j\in F\setminus J_i}(a_{ij}-c_i)\Bigr}>0,
]
where the second minimum is (+\infty) if (F\setminus J_i=\varnothing). For all sufficiently small (t>0),
[
a_{ij}+t b_{ij}>c_i+\tfrac12\gamma_i^F
\qquad\text{for all } j\notin J_i,
]
while for (j\in J_i),
[
a_{ij}+t b_{ij}=c_i+t b_{ij}.
]
Hence, for small (t),
[
\psi_i(t)=c_i+t\min_{j\in J_i} b_{ij},
]
which gives the first formula.

##### Case 2: (\delta_i^F=0)

Set
[
g_i^F(d):=\min!\Bigl{0,\ \min_{j\in J_i\cap F} b_{ij}\Bigr}\le 0.
]

For the upper bound, if (J_i\cap F\neq\varnothing), then
[
\psi_i(t)\le c_i+t\min_{j\in J_i\cap F} b_{ij}\le c_i+t,g_i^F(d).
]
Also, because (\delta_i^F=0), for every (\varepsilon>0) and every (t>0) there exists (k\notin F) with
[
a_{ik}<c_i+\varepsilon t.
]
Since (b_{ik}=0) for (k\notin F),
[
\psi_i(t)\le a_{ik}<c_i+\varepsilon t.
]
Thus
[
\limsup_{t\downarrow 0}\frac{\psi_i(t)-c_i}{t}\le 0,
]
and therefore
[
\limsup_{t\downarrow 0}\frac{\psi_i(t)-c_i}{t}\le g_i^F(d).
]

For the lower bound, if (j\notin F), then
[
a_{ij}+t b_{ij}=a_{ij}\ge c_i\ge c_i+t g_i^F(d).
]
If (j\in J_i\cap F), then
[
a_{ij}+t b_{ij}=c_i+t b_{ij}\ge c_i+t g_i^F(d).
]
If (j\in F\setminus J_i), then (a_{ij}-c_i>0); since (F\setminus J_i) is finite, for all small (t>0),
[
a_{ij}+t b_{ij}\ge c_i+t g_i^F(d).
]
Taking the infimum over (j) gives
[
\psi_i(t)\ge c_i+t g_i^F(d)
]
for all small (t), hence
[
\liminf_{t\downarrow 0}\frac{\psi_i(t)-c_i}{t}\ge g_i^F(d).
]
So equality holds.

(\square)

---

### First-order inequality

Fix any norm on (\mathbb R^N), with dual norm (|\cdot|**). Since each (m_i\in\Delta(\Omega)\subset\mathbb R^N), the constant
[
C_M:=\sup*{i\in I}|m_i|**<\infty.
]
Hence
[
|\rho_i^F(d)|\le \max*{j\in F}|m_i!\cdot! d_j|
\le C_M \max_{j\in F}|d_j|
\le C_M \operatorname{diam}(W),
]
uniformly in (i). Since (\sum_i\tau_i=1), dominated convergence applies to the (\sum_i\tau_i)-sum.

Because (w^*) maximizes (R) and (w^t\in W^I),
[
R(w^t)\le R(w^*) \qquad \forall t\in[0,1].
]
Therefore
[
0\ge \lim_{t\downarrow 0}\frac{R(w^t)-R(w^*)}{t}
================================================

\sum_{j\in F}\alpha\tau_j, m_j!\cdot! d_j
+
(1-\alpha)\sum_{i\in I}\tau_i,\rho_i^F(d).
\tag{1}
]

---

### Step 2 repaired: the corrected finite-window minimax certificate

For each row (i), define
[
K_i^F:=
\begin{cases}
\Bigl{q_i\in[0,1]^F:\ q_{ij}=0\ \forall j\notin J_i,\ \sum_{j\in F}q_{ij}=1\Bigr}, & \delta_i^F>0,[2mm]
\Bigl{q_i\in[0,1]^F:\ q_{ij}=0\ \forall j\notin J_i,\ \sum_{j\in F}q_{ij}\le 1\Bigr}, & \delta_i^F=0.
\end{cases}
]
Then
[
\rho_i^F(d)=\inf_{q_i\in K_i^F}\sum_{j\in F} q_{ij}, m_i!\cdot! d_j.
\tag{2}
]
Indeed:

* if (\delta_i^F>0), the feasible set consists of probabilities supported on (J_i), so the infimum is (\min_{j\in J_i}m_i!\cdot! d_j);
* if (\delta_i^F=0), the feasible set consists of subprobabilities supported on (J_i\cap F), so the infimum is (\min{0,\min_{j\in J_i\cap F}m_i!\cdot! d_j}).

Now define
[
Q_F:=\prod_{i\in I} K_i^F,\qquad
D_F:=\prod_{j\in F}(W-w_j^*),
]
and
[
H_F(q,d):=
\sum_{j\in F}\alpha\tau_j, m_j!\cdot! d_j
+
(1-\alpha)\sum_{i\in I}\tau_i\sum_{j\in F} q_{ij}, m_i!\cdot! d_j.
]

For fixed finite (F):

* each (K_i^F) is compact and convex;
* (Q_F) is compact and convex in the product topology;
* (D_F) is compact and convex;
* the series defining (H_F) is uniformly absolutely convergent on (Q_F\times D_F), because
  [
  \left|\sum_{j\in F} q_{ij}, m_i!\cdot! d_j\right|
  \le C_M \operatorname{diam}(W),
  ]
  and (\sum_i\tau_i=1);
* hence (H_F) is jointly continuous and affine in each variable.

By (1) and (2),
[
\sup_{d\in D_F}\inf_{q\in Q_F} H_F(q,d)\le 0.
]
Use the minimax theorem in the following form: if (X,Y) are compact convex sets and (h:X\times Y\to\mathbb R) is jointly continuous, convex in the first variable, and concave in the second, then
[
\inf_{x\in X}\sup_{y\in Y} h(x,y)=\sup_{y\in Y}\inf_{x\in X} h(x,y).
]
Apply it with (X=Q_F), (Y=D_F), (h=H_F). Since (H_F) is affine in both arguments, the hypotheses are satisfied. Therefore there exists (q^F\in Q_F) such that
[
H_F(q^F,d)\le 0\qquad \forall d\in D_F.
\tag{3}
]

Fix (j\in F) and (x\in W). Choose (d\in D_F) with
[
d_j=x-w_j^*,\qquad d_k=0\ \ (k\in F,\ k\neq j).
]
Plugging this into (3) yields
[
\Bigl[\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i q^F_{ij}m_i\Bigr]!\cdot! (x-w_j^*)\le 0
\qquad \forall x\in W.
]
Hence
[
\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i q^F_{ij}m_i\in N_j
\qquad \forall j\in F.
\tag{4}
]

So the repaired finite-window certificate is:

* row mass (1) on (F)-isolated rows;
* row mass only (\le 1) on (F)-tail-touching rows;
* normal-cone conditions on every column in (F).

---

### Step 3: diagonal limit

Choose an exhaustion (F_1\subset F_2\subset\cdots) with (\bigcup_n F_n=I), and for each (n) choose (q^{(n)}:=q^{F_n}) from (4). Since (I\times I) is countable and each coordinate lies in ([0,1]), a diagonal subsequence converges coordinatewise:
[
q_{ij}^{(n_k)}\to \lambda_{ij}\in[0,1]
\qquad \forall i,j.
]

Support is preserved, so
[
\lambda_{ij}=0 \qquad \text{whenever } j\notin J_i.
\tag{5}
]

For row sums, if (G\subset I) is finite, then for large (k),
[
\sum_{j\in G} q_{ij}^{(n_k)}\le 1.
]
Passing to the limit gives
[
\sum_{j\in G}\lambda_{ij}\le 1.
]
Since this holds for every finite (G),
[
\sum_{j\in I}\lambda_{ij}\le 1
\qquad \forall i.
\tag{6}
]

Now define the globally isolated rows:
[
\mathcal I_{\mathrm{iso}}
:=
\Bigl{
i\in I:
\exists \text{ finite }F\subset I\text{ with }\delta_i^F>0
\Bigr}.
]
Equivalently,
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
If (i\in\mathcal I_{\mathrm{iso}}), choose finite (F_i) with (\delta_i^{F_i}>0). For every (n) large enough that (F_i\subseteq F_n), monotonicity of (F\mapsto\delta_i^F) gives (\delta_i^{F_n}>0), hence by construction
[
\sum_{j\in I} q_{ij}^{(n)}=1
\qquad\text{for all large } n.
]
Also (J_i\subset F_i), hence (J_i) is finite; therefore coordinatewise convergence implies
[
\sum_{j\in I}\lambda_{ij}=1
\qquad\forall i\in\mathcal I_{\mathrm{iso}}.
\tag{7}
]

Finally, fix an on-path (j). For all large (k), (j\in F_{n_k}), so by (4),
[
a_j^{(k)}:=
\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i q_{ij}^{(n_k)}m_i
\in N_j.
]
Because (|q_{ij}^{(n_k)}|\le 1) and (\sum_i\tau_i=1), dominated convergence yields
[
a_j^{(k)}\to
\alpha\tau_j m_j+(1-\alpha)\sum_{i\in I}\tau_i\lambda_{ij}m_i
=:a_j(\lambda).
]
Since (N_j) is closed,
[
a_j(\lambda)\in N_j
\qquad \forall \text{ on-path } j.
\tag{8}
]

---

### Strongest corrected partial proposition

**Proposition.** There exists a matrix (\lambda=(\lambda_{ij})_{i,j\in I}) such that:

1. (\lambda_{ij}\ge 0) for all (i,j);
2. (\lambda_{ij}=0) whenever (j\notin J_i);
3. (\sum_j \lambda_{ij}\le 1) for every row (i);
4. if (i\in\mathcal I_{\mathrm{iso}}), then (\sum_j \lambda_{ij}=1);
5. for every on-path (j),
   [
   \alpha\tau_j m_j+(1-\alpha)\sum_i \tau_i\lambda_{ij}m_i\in N_W(w_j^*).
   ]

This is the strongest supporting-kernel statement justified by the repaired finite-window argument.

An immediate corollary is:

**Corollary.** If every row is globally isolated, equivalently if for every (i),
[
0<|J_i|<\infty
\quad\text{and}\quad
\inf_{j\notin J_i}(m_i!\cdot! w_j^*-c_i)>0,
]
then (\lambda) is already an honest countably additive supporting kernel. So the direct reduced certification closes under this isolation condition.

---

### What remains open after the repair

The previous claim

> “deficits can occur only on rows with (J_i) infinite or empty”

was too strong. After the repair, the settled rows are exactly the globally isolated ones, and the unresolved rows are exactly the **tail-touching** rows
[
\mathcal T:=I\setminus \mathcal I_{\mathrm{iso}}.
]

This class has three distinct subclasses:

1. **Infinite exact-tie rows**
   [
   \mathcal T_\infty:={i: |J_i|=\infty}.
   ]
   Every finite window leaves an outside exact minimizer, so the row derivative always has the extra (0)-option.

2. **Finite exact-tie rows with outside near-minimizing tail**
   [
   \mathcal T_{\mathrm{near}}
   :=
   \Bigl{
   i: 0<|J_i|<\infty,\ \inf_{j\notin J_i}(a_{ij}-c_i)=0
   \Bigr}.
   ]
   This is the reviewer’s hybrid class. Even though (J_i) is finite and nonempty, the minimizing value is not isolated, so finite-window perturbations still only force subprobability mass.

3. **Unattained rows**
   [
   \mathcal T_\emptyset:={i:J_i=\varnothing}.
   ]
   Here the infimum is not attained at all.

For rows in (\mathcal T_\infty\cup\mathcal T_{\mathrm{near}}), the finite-window argument leaves a genuine deficit
[
r_i:=1-\sum_j \lambda_{ij}\ge 0
]
that represents mass which can always hide in an outside zero-slope tail. No finite-window first-order test sees where that missing mass should go.

For rows in (\mathcal T_\emptyset), the issue is even sharper: an honest kernel with (\operatorname{supp}\beta_i\subseteq J_i) cannot exist unless one first proves attainment. So these rows are not merely a deficit-completion problem; they are an attainment obstruction.

Thus the exact remaining crux is:

* on attained tail-touching rows (i\in\mathcal T_\infty\cup\mathcal T_{\mathrm{near}}), can the deficits (r_i) be completed to row mass (1) on (J_i) while preserving every column normal-cone condition;
* on unattained rows (i\in\mathcal T_\emptyset), can one prove (J_i\neq\varnothing), or else the direct “support on (J_i)” target itself must be changed.

Suggested next local action: attack the completion/attainment problem only on the tail-touching class (\mathcal T), with separate subcases (\mathcal T_\infty), (\mathcal T_{\mathrm{near}}), and (\mathcal T_\emptyset); the repaired finite-window argument has already settled all globally isolated rows.
