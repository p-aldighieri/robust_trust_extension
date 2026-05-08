## Reduction of the explicit obstruction to the reduced objective

Let (M={m_i}*{i\ge 1}) be the countable atomic support with weights ((\tau_i)), and let (w=(w_j)*{j\ge 1}\in W^{\mathbb N}) be a deterministic reduced profile. On this branch, the reduced objective is
[
\Phi(w)
=======

\sum_{i\ge 1}\tau_i\Bigl[\alpha, m_i!\cdot w_i +(1-\alpha)\inf_{j\ge 1} m_i!\cdot w_j\Bigr].
]
This is the payoff-vector reduction of the original max-min objective to the compact convex payoff set (W).

Now plug in the explicit obstruction geometry already banked:
[
W={(x,0):0\le x\le 1}\subset \mathbb R^2,
\qquad
w_1^*=(0,0),\quad
w_2^*=(1,0),\quad
w_n^*=\Bigl(\frac1{n-1},0\Bigr)\ (n\ge 3),
]
and
[
m_2=e_1=(1,0),\qquad m_i=e_2=(0,1)\ \ (i\neq 2).
]

Write every feasible point as
[
w_j=(x_j,0),\qquad x_j\in[0,1].
]
Then for every (i\neq 2),
[
m_i\cdot w_j=e_2\cdot(x_j,0)=0
\qquad \forall j,
]
so rows (i\neq 2) contribute identically zero to (\Phi). Hence the whole reduced objective collapses to
[
\Phi(w)=\tau_2\Bigl[\alpha x_2 +(1-\alpha)\inf_{j\ge 1}x_j\Bigr].
\tag{1}
]

So in this geometry there is only one economically active row: row (2). The aligned part wants (x_2) high; the misaligned part wants the global floor (\inf_j x_j) high.

## The obstruction profile is not an actual reduced maximizer

At the obstruction profile (w^*=(w_j^*)),
[
x_2^*=1,\qquad \inf_j x_j^*=0,
]
because (x_1^*=0). Therefore
[
\Phi(w^*)=\tau_2\bigl[\alpha\cdot 1 +(1-\alpha)\cdot 0\bigr]=\alpha\tau_2.
\tag{2}
]

Now consider the feasible path that lifts **every** coordinate toward the right endpoint ((1,0)):
[
\bar w:=(1,0)\in W,
\qquad
w_j(t):=(1-t)w_j^*+t\bar w
\quad (t\in[0,1]).
]
Since (W) is a line segment, (w_j(t)\in W) for every (j) and (t).

In coordinates,
[
x_1(t)=t,\qquad x_2(t)=1,\qquad x_n(t)=t+(1-t)\frac1{n-1}\quad (n\ge 3).
]
Hence
[
\inf_j x_j(t)=t.
]
Plugging this into (1),
[
\Phi(w(t))
==========

\tau_2\Bigl[\alpha\cdot 1 +(1-\alpha)t\Bigr].
]
Therefore, for every (t>0),
[
\Phi(w(t))-\Phi(w^*)
====================

(1-\alpha)\tau_2, t.
\tag{3}
]

So in the nontrivial obstruction regime (\alpha<1) and (\tau_2>0),
[
\Phi(w(t))>\Phi(w^*)
\qquad \forall t\in(0,1].
]
Thus the explicit obstruction profile (w^*) cannot be an actual reduced maximizer.

Equivalently, the exact one-sided directional maximality inequality that fails is
[
D^+\Phi(w^*;d)\le 0
\quad\text{for } d_j:=\bar w-w_j^*,
]
because along the feasible path (w^*+td=w(t)),
[
D^+\Phi(w^*;d)=\lim_{t\downarrow 0}\frac{\Phi(w(t))-\Phi(w^*)}{t}=(1-\alpha)\tau_2>0.
\tag{4}
]

That is the precise maximality failure.

## Why the earlier obstruction still passed the banked finite-window tests

This is the important needle-eye.

The repaired tail-touching machinery only generated finite-window / finitely supported first-order conditions. Those do **not** see the failure above.

Indeed, let (h=(h_j)) be any feasible perturbation with finite support. For all sufficiently small (t>0),
[
x_j^*+th_j=
\begin{cases}
0+th_1 & j=1,\
1+th_2 & j=2,\
\frac1{n-1}+th_n & j\in \operatorname{supp}(h)\setminus{1,2},\
\frac1{n-1} & j\notin \operatorname{supp}(h),\ n\ge 3.
\end{cases}
]
Because the untouched tail still contains coordinates (\frac1{n-1}\to 0), one has
[
\inf_j (x_j^*+th_j)=0
\qquad\text{for all small }t>0.
]
So every finitely supported perturbation leaves the misaligned term flat to first order. Then (1) gives
[
D^+\Phi(w^*;h)=\alpha\tau_2 h_2.
]
Since (x_2^*=1) lies at the right endpoint of (W), every feasible one-sided perturbation satisfies (h_2\le 0). Hence
[
D^+\Phi(w^*;h)\le 0
\qquad\text{for every finitely supported feasible }h.
\tag{5}
]

So the obstruction profile can satisfy all the banked finite-window directional maximality conditions and yet fail to be a true maximizer. The reason is simple but nasty: the profitable move is not finite-window. It is an **infinite-support floor-lifting deviation** that raises the global floor (\inf_j x_j).

## Exact conclusion for this move

So the answer is:

* the explicit obstruction geometry does **not** occur at an actual reduced maximizer;
* the exact maximality inequality that fails is the one-sided maximizer inequality along the infinite-support feasible direction
  [
  d_j=(1,0)-w_j^*,
  ]
  equivalently the global comparison with the constant profile ((1,0));
* what the obstruction was missing is a genuinely **maximizer-specific tail ingredient**:

> actual reduced maximality must control infinite-support deviations that raise the rowwise floor term (\inf_j m_i\cdot w_j), whereas the corrected supporting-kernel proposition and the repaired finite-window derivative formula only control finitely supported / finite-window variations.

In this example, that missing ingredient can be stated very concretely:

> if a profile is a true reduced maximizer, then it must be stable against admissible tail-lifting paths that increase (\inf_j m_i\cdot w_j) while leaving the aligned term at its maximum.

The obstruction profile fails exactly that test.

Suggested next local action: formulate and prove a maximizer-level lemma on the countable-atomic branch that one-sided optimality must hold for admissible infinite-support tail-lifting paths, then test that lemma against the general scoped obstruction geometry on (T_\infty\cup T_{\mathrm{near}}).
