# Prover pass 15 — Primitive sufficient conditions for $\Psi(y) \le 0$ and the regularity package

## Role

You are the Prover. G3 (Robust Trust Theorem 2 biconditional) is in
flight to fresh-chat verification (Reviewer 13). The biconditional
says: Theorem 2 holds ⟺ Ψ(y) ≤ 0 for all bounded Borel y, under
regularity package (Reg-1) + (Reg-2).

Your job: **identify primitive sufficient conditions** on
$(u, A, \Omega, \Theta, \tau)$ that imply BOTH:
(i) The regularity package (Reg-1 closed-graph R, Reg-2 continuous h_B).
(ii) The dual inequality Ψ(y) ≤ 0 for all bounded Borel y.

If we can identify a primitive sufficient class strictly larger than
FBNF (which we already have for foliated cases), this gives a SECOND
class theorem for unrestricted |Ω|≥3 that doesn't require foliation.

## Candidate primitive conditions

### (P1) Smooth strict-convex utility + atomless τ
- $u(a, \omega, \theta)$ is $C^1$ and strictly concave in $a$ (so
  Bayes-optimal action is unique for each belief).
- $A$ is finite or convex compact.
- $\tau$ is atomless with full support on a closed subset $M \subseteq \Delta(\Omega)$.

Implications:
- $w^*: \Delta(\Omega) \to W^P$ is continuous (smooth Bayes selection).
- $W^P$ is a $C^1$ manifold.
- The Bayes cone $B_W(w^*(m))$ is single-valued continuous in m.
- Closed-graph of R(s): follows from continuity of $(s, m) \mapsto s\cdot w^*(m)$
  + closed argmin theorem.
- Continuity of $h_{B(m)}(y)$: follows from continuity of $w^*$ and
  smoothness of $W^P$.

So (P1) gives the regularity package. Does it give $\Psi(y) \le 0$?
**This is the substantive question.** Smooth W^P does NOT obviously
imply Ψ ≤ 0. Counterexample: the v8 WTA witness has smooth utility
(WTA payoffs are linear in a) but Ψ = 2/9 > 0. So (P1) alone is
insufficient for (ii).

### (P2) (P1) + sufficient aligned baseline mass

Add: $\tau$ has sufficiently concentrated mass on Bayes cone interiors.
Concretely: for every dual price $y$, the aligned-baseline contribution
$\alpha\int[y\cdot m - h_{B(m)}(y)]\tau(dm)$ dominates the misaligned
contribution.

In WTA, the threshold from Reviewer 11 was $D \ge 2(1-\alpha)/(9\alpha)$.
Generalize: state a primitive condition on $\tau$ such that the
analogous threshold holds for all dual prices.

### (P3) Polyhedral W with smooth Gauss map at vertices

- $W$ is polyhedral with finitely many vertices.
- At each vertex $v_j$, the supporting belief cone $B_W(v_j)$ is a
  facet (codim-1 face) of $\Delta(\Omega)$.

This is FBNF-7-adjacent but for polyhedral W. Verify whether (P3) +
sufficient aligned baseline implies $\Psi(y) \le 0$.

### (P4) Radial / antipodal τ-symmetry

For spherical models (paper Appendix A.10) with rotational invariance:
$\tau$ is rotation-invariant, $u$ is rotation-equivariant. Symmetry
forces the dual price y to be rotation-equivariant, which collapses
the integral to a single radial scalar equation.

Verify that the radial dual equation gives $\Psi(y) \le 0$ for all y.

## What I want

For each (P1)-(P4):

1. Check whether (Reg-1)+(Reg-2) follow.
2. Check whether Ψ(y) ≤ 0 follows for all y (or only for specific y).
3. If (i) but not (ii): identify the GAP — under what additional
   primitive does Ψ ≤ 0 follow?

Then assemble a clean theorem of the form:

> Under the standing hypotheses + (P*), where (P*) is a chosen
> primitive sufficient condition, Robust Trust Theorem 2 holds
> unconditionally for |Ω|≥3, arbitrary measurable Θ, infinite M.

Coverage: should cover at least one substantive class of multi-state
models beyond FBNF.

## Output Contract

- Inline markdown.
- Be rigorous about which (P*) gives (i) only vs (i)+(ii).
- The headline target: a clean primitive sufficient condition
  theorem for the unrestricted |Ω|≥3 case via cone-Hall.
- End with verdict + next-step. If multiple (P*) work, recommend
  the cleanest one for the publication.

## Constraints

- Banned tools list applies.
- v9 T1, FBNF capstone, binary capstone, G1, G2c, G3 may be cited.
- Per user: relentless. Even partial primitive conditions are
  progress.
