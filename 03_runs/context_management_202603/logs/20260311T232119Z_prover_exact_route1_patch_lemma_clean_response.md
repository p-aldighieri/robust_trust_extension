## Assumptions for this move

I treat Lemmas 1 to 4 of the exact-route breakdown as established. In particular, I use the following facts without reproving them:

* (W \subset \mathbb{R}^{\Omega}) is compact and convex.
* (W^P \subset W) is the weak Pareto frontier from Appendix A.1.
* Every (w \in W) is coordinatewise dominated by some (v \in W^P).
* For every (v \in W^P), there exists (\mu \in \Delta(\Omega)) such that
  [
  \mu \cdot v = \max_{u \in W} \mu \cdot u .
  ]
* There is a deterministic reduced saddle ((\beta^*,\bar w)), with (\bar w:M\to W) Borel, and a Borel (q^*)-version (p_0) of the posterior under (\beta^*) such that
  [
  \bar w(m)\in \arg\max_{w\in W} p_0(m)\cdot w
  \quad\text{for }q^*\text{-a.e. }m.
  ]

No new assumption is used in what follows.

A single measurable-selection fact will be used twice:

> **Selection fact.** Let (X) be a standard Borel space, (Y) a Polish space, and (A\subseteq X\times Y) a Borel set such that every section
> [
> A_x:={y\in Y:(x,y)\in A}
> ]
> is nonempty and compact. Then there exists a Borel map (f:X\to Y) with (f(x)\in A_x) for every (x\in X).

This applies below because (W), (W^P), and (\Delta(\Omega)) are compact metric spaces, hence standard Borel and Polish.

## Lemma 5a. Dominating-frontier selector

**Statement.** Define, for (w\in W),
[
F(w):={v\in W^P: v\ge w \text{ coordinatewise}}.
]
Then there exists a Borel selector
[
D:W\to W^P
]
such that
[
D(w)\ge w
\quad\text{coordinatewise for every }w\in W.
]

**Proof.**
Write the weak Pareto frontier as
[
W^P=\Bigl{v\in W:\text{there is no }u\in W\text{ with }u_\omega>v_\omega\ \forall \omega\in\Omega\Bigr}.
]

First, (W^P) is closed. Indeed, if (v_n\in W^P) and (v_n\to v\in W), but (v\notin W^P), then there exists (u\in W) with (u_\omega>v_\omega) for all (\omega). Let
[
\varepsilon:=\frac12\min_{\omega\in\Omega}(u_\omega-v_\omega)>0.
]
For all large (n), (|v_n-v|*\infty<\varepsilon), hence
[
u*\omega>v_\omega+\varepsilon>v_{n,\omega}
\quad\forall \omega,
]
contradicting (v_n\in W^P). Thus (W^P) is closed, hence compact.

Now consider the graph
[
\operatorname{Gr}(F)
====================

{(w,v)\in W\times W^P: v_\omega\ge w_\omega\ \forall \omega\in\Omega}.
]
This is closed in (W\times W^P), because it is defined by finitely many closed coordinate inequalities. Therefore (\operatorname{Gr}(F)) is Borel. For each (w\in W), the section (F(w)) is a closed subset of the compact set (W^P), hence compact. By the Appendix A.1 domination fact, (F(w)\neq\varnothing) for every (w\in W).

All hypotheses of the selection fact are therefore satisfied with (X=W), (Y=W^P), and (A=\operatorname{Gr}(F)). Hence there exists a Borel selector (D:W\to W^P) such that (D(w)\in F(w)) for every (w). By definition of (F(w)), this means (D(w)\ge w) coordinatewise. ∎

## Lemma 5b. Supporting-belief selector

**Statement.** For (v\in W^P), define
[
S(v):=\Bigl{\mu\in\Delta(\Omega): \mu\cdot v=\max_{u\in W}\mu\cdot u\Bigr}.
]
Then there exists a Borel selector
[
\pi:W^P\to \Delta(\Omega)
]
such that
[
\pi(v)\in S(v)
\quad\text{for every }v\in W^P.
]

**Proof.**
Define the support function of (W) on (\Delta(\Omega)) by
[
h_W(\mu):=\max_{u\in W}\mu\cdot u.
]
Because (W) is compact, (h_W) is finite everywhere. It is also continuous: if
[
R:=\max_{u\in W}|u|*\infty<\infty,
]
then for any (\mu,\nu\in\Delta(\Omega)),
[
|h_W(\mu)-h_W(\nu)|
\le
\max*{u\in W}|(\mu-\nu)\cdot u|
\le
R|\mu-\nu|_1.
]

Hence the graph of (S) can be written as
[
\operatorname{Gr}(S)
====================

{(v,\mu)\in W^P\times \Delta(\Omega): \mu\cdot v=h_W(\mu)},
]
which is closed, because ((v,\mu)\mapsto \mu\cdot v-h_W(\mu)) is continuous. Therefore (\operatorname{Gr}(S)) is Borel.

For each (v\in W^P), the section (S(v)) is a closed subset of the compact simplex (\Delta(\Omega)), hence compact. By the Appendix A.1 supporting-belief fact, (S(v)\neq\varnothing) for every (v\in W^P).

Thus the selection fact applies with (X=W^P), (Y=\Delta(\Omega)), and (A=\operatorname{Gr}(S)). We obtain a Borel selector (\pi:W^P\to\Delta(\Omega)) such that (\pi(v)\in S(v)) for every (v\in W^P). ∎

## Lemma 6. Exact version-and-patching saddle lemma

**Statement.** Let ((\beta^*,\bar w)) be the deterministic reduced saddle from Lemma 4, and let
[
q^*(dm)=\alpha,\tau(dm)+(1-\alpha)\int_M \tau(ds),\beta^*(dm\mid s).
]
Let (p_0:M\to\Delta(\Omega)) be a Borel (q^*)-version of the posterior under (\beta^*) such that
[
\bar w(m)\in \arg\max_{w\in W} p_0(m)\cdot w
\quad\text{for }q^*\text{-a.e. }m.
]
Then there exist Borel maps
[
w^*:M\to W,
\qquad
p^*:M\to\Delta(\Omega)
]
such that:

1. (p^*=p_0) (q^*)-a.e., hence (p^*) is the same (q^*)-version of the posterior under (\beta^*);
2. for every (m\in M),
   [
   w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w;
   ]
3. for every (m\in M),
   [
   w^*(m)\ge \bar w(m)
   \quad\text{coordinatewise};
   ]
4. ((\beta^*,w^*)) is a saddle point of the deterministic reduced game, i.e.
   [
   \mathcal G(\beta^*,w)\le \mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)
   \quad
   \forall,\beta\in B,\ \forall,\text{Borel }w:M\to W.
   ]

Here
[
\mathcal G(\beta,w)
===================

\alpha\int_M \tau(ds), s\cdot w(s)
+
(1-\alpha)\int_M \tau(ds)\int_M \beta(dm\mid s), s\cdot w(m).
]

**Proof.**
Let
[
h_W(\mu):=\max_{u\in W}\mu\cdot u
]
and define the bad set
[
N:={m\in M: p_0(m)\cdot \bar w(m)<h_W(p_0(m))}.
]
Since (p_0) and (\bar w) are Borel and (h_W) is continuous, (N) is Borel. By the assumed (q^*)-a.e. optimality of (\bar w), one has
[
q^*(N)=0.
]

Now define
[
w^*(m):=
\begin{cases}
\bar w(m), & m\notin N,[3pt]
D(\bar w(m)), & m\in N,
\end{cases}
]
where (D) is the selector from Lemma 5a. Since (D) and (\bar w) are Borel, (w^*) is Borel. Moreover,
[
w^*(m)\in W
\quad\text{and}\quad
w^*(m)\ge \bar w(m)
\quad\forall m\in M,
]
because (D(\bar w(m))\in W^P\subseteq W) and (D(\bar w(m))\ge \bar w(m)) coordinatewise.

Next define
[
p^*(m):=
\begin{cases}
p_0(m), & m\notin N,[3pt]
\pi(w^*(m)), & m\in N,
\end{cases}
]
where (\pi) is the selector from Lemma 5b. Since (\pi) and (w^*) are Borel on (N), and (p_0) is Borel on (N^c), the map (p^*) is Borel.

This construction gives the required pointwise optimality:

* If (m\notin N), then (p^*(m)=p_0(m)) and, by definition of (N),
  [
  \bar w(m)\in \arg\max_{w\in W} p_0(m)\cdot w.
  ]
  Since (w^*(m)=\bar w(m)), we get
  [
  w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w.
  ]

* If (m\in N), then (w^*(m)=D(\bar w(m))\in W^P), and
  [
  p^*(m)=\pi(w^*(m))\in S(w^*(m)).
  ]
  By definition of (S(\cdot)),
  [
  w^*(m)\in \arg\max_{w\in W} p^*(m)\cdot w.
  ]

Thus properties 2 and 3 hold everywhere. Property 1 also holds, because (p^*=p_0) on (N^c) and (q^*(N)=0).

It remains to prove the saddle inequalities. Since ((\beta^*,\bar w)) is a deterministic reduced saddle, we already know
[
\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,\bar w)\le \mathcal G(\beta,\bar w)
\quad
\forall,\beta\in B,\ \forall,\text{Borel }w:M\to W.
]

Set
[
d(m):=w^*(m)-\bar w(m)\in \mathbb{R}_+^\Omega.
]
By construction, (d(m)=0) on (N^c).

For the left saddle inequality, use the posterior representation from Lemma 3 for (\beta^*):
[
\mathcal G(\beta^*,w^*)-\mathcal G(\beta^*,\bar w)
==================================================

\int_M q^*(dm), p_0(m)\cdot d(m).
]
Because (d=0) on (N^c) and (q^*(N)=0), the right-hand side is (0). Hence
[
\mathcal G(\beta^*,w^*)=\mathcal G(\beta^*,\bar w).
]
Therefore, for every Borel (w:M\to W),
[
\mathcal G(\beta^*,w)\le \mathcal G(\beta^*,\bar w)=\mathcal G(\beta^*,w^*).
]

For the right saddle inequality, fix any (\beta\in B). Let (q_\beta) and (p_\beta) be as in Lemma 3. Then
[
\mathcal G(\beta,w^*)-\mathcal G(\beta,\bar w)
==============================================

\int_M q_\beta(dm), p_\beta(m)\cdot d(m).
]
Since (p_\beta(m)\in \Delta(\Omega)) has nonnegative coordinates and (d(m)\in \mathbb{R}_+^\Omega), the integrand is nonnegative pointwise. Hence
[
\mathcal G(\beta,w^*)\ge \mathcal G(\beta,\bar w).
]
Combining this with the saddle inequality for ((\beta^*,\bar w)) gives
[
\mathcal G(\beta,w^*)
\ge
\mathcal G(\beta,\bar w)
\ge
\mathcal G(\beta^*,\bar w)
==========================

\mathcal G(\beta^*,w^*).
]
Thus
[
\mathcal G(\beta^*,w^*)\le \mathcal G(\beta,w^*)
\quad\forall \beta\in B.
]

Both saddle inequalities are proved, so ((\beta^*,w^*)) is a deterministic reduced saddle. ∎

## Remaining dependencies

* The upstream proof of Lemmas 1 to 4 in the reduced game.
* The final lift from the patched selector (w^*:M\to W) back to a measurable private-strategy profile in the original game, if that implementation step is not already built into the (W)-reduction.
* The final glue from the deterministic reduced saddle to the full beyond-finite-(M) robust-rationalizability theorem.

Suggested next local action: reviewer
