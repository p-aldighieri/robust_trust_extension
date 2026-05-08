## Imported assumptions

I import only the standing model assumptions and the Appendix A.1 reduction facts already in the project sources:

* (\Omega) is finite, hence (\Delta(\Omega)) is compact metric.
* (M=\operatorname{supp}\tau\subset \Delta(\Omega)) is therefore compact metric.
* (W\subset \mathbb R^{|\Omega|}) is compact and convex.
* In the reduced game, continuation payoffs depend on the agent’s private strategy only through (w\in W), via (s\cdot w).
* Misaligned adviser strategies are Borel kernels (\beta:M\rightsquigarrow \Delta(M)), and reduced agent strategies are Borel kernels (\gamma:M\rightsquigarrow \Delta(W)).

I do **not** import any extra regularity on (m\mapsto \gamma(\cdot\mid m)) beyond Borel measurability, and I do **not** quotient kernels by any fixed reference measure.

## Kernel-topology saddle block: precise obstruction

The requested Lemma 2 is false under these imports. The obstruction is already present in a very simple instance satisfying all standing assumptions.

### Counterexample environment

Take:

* (\Omega={0,1}).
* (\Theta={\ast}).
* (A={0,1}), with mixed actions allowed through (\Delta(A)).
* Utility
  [
  u(a,\omega)=\mathbf 1{a=1,\omega=1}.
  ]
* (M=[0,1]), where (s\in[0,1]) is the adviser’s posterior probability of state (1).
* (\tau) equal to Lebesgue measure on ([0,1]), so (M=\operatorname{supp}\tau) and
  [
  c:=\int_0^1 s,\tau(ds)=\frac12>0.
  ]
* Fix any (\alpha\in[0,1)).

A private strategy is just a probability (w\in[0,1]) of playing action (1). The state-contingent payoff vector is ((0,w)), so after identifying ((0,w)) with (w), the Appendix A.1 feasible-payoff set is
[
W=[0,1].
]
The reduced payoff for a deterministic selector (g:M\to W) is
[
\mathcal G(\beta,g)
===================

\alpha\int_0^1 s,g(s),\tau(ds)
+
(1-\alpha)\int_0^1 \tau(ds)\int_0^1 s,g(m),\beta(dm\mid s).
]

### Proposition

In this reduced game, there is **no** topology on (B) such that

1. (B) is compact, and
2. for every deterministic measurable selector (g:M\to W), the map
   [
   \beta\mapsto \mathcal G(\beta,g)
   ]
   is continuous.

Hence there is no pair of compact topologies on (B) and (\Gamma) satisfying the requested Lemma 2, because deterministic selectors are a subset of (\Gamma) via Dirac kernels.

### Proof

For each (x\in[0,1]), let (\beta^x\in B) be the constant kernel
[
\beta^x(\cdot\mid s)=\delta_x(\cdot)
\quad\forall s\in[0,1].
]

Assume toward contradiction that a topology with properties (1)-(2) exists.

Choose pairwise distinct points (x_1,x_2,\dots\in[0,1]). By compactness of (B), the sequence ((\beta^{x_n})*{n\ge1}) has a convergent subnet; write it as
[
\beta^{x*{n(d)}}\to \beta^*.
]

Define a finite measure
[
\lambda^*(A):=\int_0^1 s,\beta^*(A\mid s),\tau(ds),
\qquad A\in\mathcal B([0,1]),
]
and normalize it to a probability measure
[
\nu^*(A):=\frac{\lambda^*(A)}{c}.
]
Since (\lambda^*([0,1])=c), (\nu^*) is a countably additive Borel probability measure.

Now fix any subset (S\subseteq \mathbb N), and let
[
A_S:={x_n:n\in S}\subseteq [0,1].
]
Because (A_S) is countable, it is Borel. Let
[
g_S(m):=\mathbf 1_{A_S}(m).
]
Then (g_S:M\to W=[0,1]) is a deterministic measurable selector, so (\beta\mapsto \mathcal G(\beta,g_S)) is continuous by assumption.

For each subnet index (d),
[
\mathcal G(\beta^{x_{n(d)}},g_S)
================================

\alpha\int_{A_S} s,\tau(ds)
+
(1-\alpha)c,\mathbf 1_S(n(d)),
]
while
[
\mathcal G(\beta^*,g_S)
=======================

\alpha\int_{A_S} s,\tau(ds)
+
(1-\alpha)c,\nu^*(A_S).
]
Continuity therefore yields
[
\mathbf 1_S(n(d))\to \nu^*(A_S)
\quad\text{for every }S\subseteq\mathbb N.
\tag{1}
]

Apply (1) first with (S=\mathbb N). Then (\mathbf 1_{\mathbb N}(n(d))=1) for all (d), so
[
\nu^*(A_{\mathbb N})=1.
\tag{2}
]

Apply (1) next with (S={k}). Because the subnet map (d\mapsto n(d)) is cofinal, for each fixed (k) we eventually have (n(d)\neq k). Hence
[
\mathbf 1_{{k}}(n(d))\to 0,
]
so
[
\nu^*({x_k})=0
\quad\forall k\ge1.
\tag{3}
]

But (A_{\mathbb N}={x_1,x_2,\dots}) is the disjoint countable union of the singletons ({x_k}). Since (\nu^*) is countably additive,
[
\nu^*(A_{\mathbb N})
====================

# \sum_{k=1}^\infty \nu^*({x_k})

0
]
by (3), contradicting (2).

This contradiction proves the proposition. (\square)

### Diagnosis

The failure is structural, not cosmetic.

Because the agent is allowed **arbitrary Borel messagewise selectors** (g), she can choose indicators of arbitrary countable Borel sets. Because the misaligned adviser can ignore his signal and use constant kernels, continuity of (\beta\mapsto \mathcal G(\beta,g)) for all such (g) forces a setwise-type continuity on induced message laws. On infinite (M), that is too strong to coexist with compactness of the full kernel space.

So the requested compactness/continuity package for the full measurable reduced game cannot hold under the present assumptions. The obstruction appears before any minimax theorem is invoked.

## Remaining dependencies

1. **Needed assumption.** To recover an upstream existence theorem, one needs extra regularity that removes the arbitrary-Borel-selector obstruction. Examples of the kind of restriction that would do this are:

   * discreteness / atomicity on (M), or
   * a restriction of the admissible reduced agent strategies to a compact class with continuity in the message variable.
     I am not adopting either here.

2. Until such an upstream replacement is supplied, the posterior-representation / (q^*)-a.e. local-optimality block and the barycentric-collapse block are downstream conditional steps only. I do not claim them in this move because the requested saddle-existence lemma fails first.

Suggested next local action: revised breakdown.
