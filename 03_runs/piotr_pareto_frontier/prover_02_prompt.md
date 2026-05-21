# Prover pass 02 — Lemmas 7 and 8: Fermat stationarity → Calibration is the multiplier

## Role

You are the Prover for a smart-scaffolding proof project. You have just
read the verified Lemma 6 (Integral Clarke-Danskin representation) and
its PATCH_SMALL reviewer note (durable sources `prover_01_response.md`
and `reviewer_01_response.md`). Your job in this pass is to prove the
two **load-bearing** lemmas of the route:

- **Lemma 7**: Clarke Fermat rule yields normal-cone stationarity
  \(g\in N_{W^k}(\bar w)\), equivalently \(g_i\in N_W(w_i)\) for every \(i\).
- **Lemma 8**: The Clarke multipliers from Lemma 6 are exactly the
  **calibration kernel** — the integrand multipliers \(\lambda^-(s)\),
  with appropriate normalization, deliver the calibrated adversarial
  posterior at every active payoff label.

Lemma 8 is the hinge of the entire route: it converts the abstract
Fermat normality of \(g_i\) into a concrete Bayes-calibration statement
\(p_i\in N_W(w_i)\cap\Delta(\Omega)\), which is Pareto-Hall calibration
at each finite payoff label.

## Patched Lemma 6 (the form to cite downstream)

The reviewer's small patch replaces the equality version of L5 in
Step 2 with the inclusion form. The patched Lemma 6 conclusion is
**unchanged**, but the proof's intermediate object is the **larger**
active-weight correspondence
\[
R(s) \;:=\; \alpha\,\operatorname{co}\big\{e_i\otimes s : i\in I_+(s)\big\} \;+\; (1-\alpha)\,\operatorname{co}\big\{e_i\otimes s : i\in I_-(s)\big\},
\]
where \(I_+(s) := \arg\max_j s\!\cdot w_j\), \(I_-(s) := \arg\min_j s\!\cdot w_j\),
and \(e_i\otimes s\in(\R^N)^k\) is zero except in the \(i\)-th block.
Clarke's sum rule gives only \(\Psi(s)\subseteq R(s)\); equality may
fail at ties (reviewer's k=2, N=1 example shows this). The Aumann
integration is on \(R(s)\), and the conclusion is the same.

**For all downstream uses (Lemmas 7-8), treat Lemma 6 as:** *every
\(g\in\partial_C F_k(\bar w)\) admits Borel \(\lambda^\pm:M\to\Delta(k)\)
with \(\operatorname{supp}\lambda^+(s)\subseteq I_+(s)\) and
\(\operatorname{supp}\lambda^-(s)\subseteq I_-(s)\) τ-a.e., and
\(g_i = \alpha\!\int\lambda_i^+(s)s\,\tau(ds) + (1-\alpha)\!\int\lambda_i^-(s)s\,\tau(ds)\).*

## Lemma 7 — Clarke Fermat normal-cone stationarity

**Hypotheses.** \(W\) closed convex compact in \(\R^N\) (paper Lemma 2
of Theorem 1). \(\bar w = (w_1,\ldots,w_k)\in W^k\) is an **ambient
local maximizer** of \(F_k\) over \(W^k\) — i.e., there is an open
neighborhood \(U\) of \(\bar w\) in \((\R^N)^k\) such that \(F_k(\bar w)\ge F_k(\bar v)\)
for every \(\bar v\in U\cap W^k\). (Frontier-local maximality lifts to
ambient by L3, which you may assume; see breakdown.)

**Statement.** There exists \(g = (g_1,\ldots,g_k)\in\partial_C F_k(\bar w)\)
such that
\[
g \;\in\; N_{W^k}(\bar w) \;=\; \prod_{i=1}^k N_W(w_i).
\]
Equivalently, \(g_i\in N_W(w_i)\) for every \(i\).

**Tools.** Clarke's Fermat rule for constrained local optima: if \(f\)
is locally Lipschitz and \(x_0\in C\) is a local minimum of \(f\) on
\(C\) with \(C\) closed convex, then \(0\in\partial_C f(x_0) + N_C(x_0)\).
Convex normal cone calculus on product sets. Apply to \(-F_k\)
minimized over \(W^k\).

**Proof outline.** Apply Clarke's necessary condition for
\(-F_k\) at the local max \(\bar w\) on \(W^k\). Use
\(\partial_C(-F_k) = -\partial_C F_k\) (true for locally Lipschitz
functions). Product formula \(N_{W^k}(\bar w) = \prod_i N_W(w_i)\)
(true for any product of closed convex sets, since the normal cone of
a product is the product of normal cones).

## Lemma 8 — Clarke multipliers ARE the calibration kernel

**Hypotheses.** Lemmas 6 and 7 hold. \(\bar w\) is an ambient local
maximizer.

**Statement.** Let \(g\in\partial_C F_k(\bar w)\) be the normal
subgradient delivered by Lemma 7, with measurable multiplier
decomposition \(\lambda^\pm:M\to\Delta(k)\) per (patched) Lemma 6.

For each \(i\in\{1,\ldots,k\}\), define
\[
q_i \;:=\; \alpha\!\int_M\lambda_i^+(s)\,\tau(ds) \;+\; (1-\alpha)\!\int_M\lambda_i^-(s)\,\tau(ds).
\]

(a) **Mass balance.** \(\sum_i q_i = 1\); each \(q_i\ge 0\).

(b) **Normalized multiplier is a posterior.** When \(q_i>0\), define
\[
p_i \;:=\; \frac{g_i}{q_i} \;=\; \frac{\alpha\int\lambda_i^+(s)\,s\,\tau(ds) + (1-\alpha)\int\lambda_i^-(s)\,s\,\tau(ds)}{q_i}.
\]
Then \(p_i\in\Delta(\Omega)\) (probability vector on the state space).

(c) **Calibration.** \(p_i\in N_W(w_i)\cap\Delta(\Omega) = B_W(w_i)\)
(the Bayes-optimality cone of \(W\) at \(w_i\); cf. L1).

(d) **Kernel realization.** Define the original-game adversarial
kernel on payoff labels as
\[
\hat\kappa(\{i\}\mid s) \;:=\; \lambda_i^-(s).
\]
Define the message-marginal in payoff-label coordinates as
\[
\tilde q(\{i\}) \;:=\; q_i \;=\; \alpha\!\int_M\lambda_i^+(s)\,\tau(ds) + (1-\alpha)\!\int_M\lambda_i^-(s)\,\tau(ds).
\]
Define the joint source-label distribution
\[
\tilde\gamma_\alpha \;:=\; \alpha\sum_i\!\int_M\lambda_i^+(s)\,\tau(ds)\otimes\delta_i \;+\; (1-\alpha)\sum_i\!\int_M\lambda_i^-(s)\,\tau(ds)\otimes\delta_i,
\]
i.e., the law of \((s, I)\) where \(s\sim\tau\) and \(I\mid s\) is
distributed as \(\lambda^+\) (with weight \(\alpha\)) or \(\lambda^-\)
(with weight \(1-\alpha\)). Then the disintegration of \(\tilde\gamma_\alpha\)
over its second marginal \(\tilde q\) yields the posterior
\[
P_{\tilde\gamma_\alpha}(\cdot\mid i) \;=\; p_i \;\in\; B_W(w_i) \;=\; N_W(w_i)\cap\Delta(\Omega) \quad \tilde q\text{-a.e. }i.
\]

**Tools.** Lemma 6 (multiplier representation), Lemma 7 (Fermat
stationarity), L1 (\(N_W(w)\cap\Delta(\Omega) = B_W(w)\); cite without
re-proving). Standard Bayes-rule + disintegration on a finite state
space.

**Proof outline.** Direct computation. Mass balance follows from
\(\sum_i\lambda_i^\pm(s) = 1\) τ-a.e. and Fubini. Posterior in
simplex follows because numerator is nonneg with \(\sum_\omega [p_i]_\omega = 1\)
(use \(s\in\Delta(\Omega)\) and definition of \(q_i\)). Calibration
\(p_i\in N_W(w_i)\) follows because \(g_i\in N_W(w_i)\) by Lemma 7 and
\(p_i\) is a positive rescaling of \(g_i\); \(N_W(w_i)\) is a cone, so
positive scalar multiplication preserves membership.

**Kernel realization** is the cleanest interpretation: the
multipliers \(\lambda^\pm\) define a joint distribution \(\tilde\gamma_\alpha\)
on \(M\times\{1,\ldots,k\}\), and Bayes' rule on this finite-state-space
disintegration yields exactly \(p_i\).

## What I want you to produce

Produce **two rigorous proofs**, in the following structure:

```
# Lemmas 7 and 8 — Fermat stationarity + Calibration is the multiplier

## Lemma 7 — Clarke Fermat normal-cone stationarity

### Statement
(Restate exactly.)

### Hypotheses used
(Standing + ambient local maximality of w̄ on W^k.)

### Proof
- Step 1: Cite Clarke's necessary condition for −F_k on W^k.
  Verify hypotheses: W^k closed convex (product), F_k locally Lipschitz
  (Lemma 2 / L2).
- Step 2: Apply, obtain 0 ∈ ∂_C(−F_k)(w̄) + N_{W^k}(w̄). Equivalently,
  ∂_C F_k(w̄) ∩ (−N_{W^k}(w̄)) ≠ ∅. Since N_{W^k}(w̄) is a closed convex
  cone, this gives g ∈ ∂_C F_k(w̄) with g ∈ N_{W^k}(w̄) (after the
  sign convention).
- Step 3: Use the product normal cone formula N_{W^k}(w̄) = ∏_i N_W(w_i).
  Conclude g_i ∈ N_W(w_i) for every i.

(Cite Clarke 1983 Optimization and Nonsmooth Analysis Thm 6.1.1 or
equivalent; cite Rockafellar 1970 §16 for the product normal cone formula.)

### Sanity check
Take k=1: ambient local max of F_1(w) = α s·w + (1-α) s·w = s·w
(degenerate; take a non-degenerate F_k with k≥2 if needed). Verify
g_i ∈ N_W(w_i) in a simple binary example.

## Lemma 8 — Calibration is the multiplier

### Statement
(Restate exactly.)

### Hypotheses used
(Lemmas 6 patched + 7.)

### Proof
- Step 1 (mass balance). ∑_i q_i = α + (1-α) = 1; each q_i ≥ 0.
- Step 2 (posterior in simplex). Show p_i has nonneg components
  summing to 1. Use ∑_ω [p_i]_ω · q_i = ∑_ω g_i(ω) =
  ∑_ω [α∫λ_i^+(s)s(ω)dτ + (1-α)∫λ_i^-(s)s(ω)dτ] = (α+(1-α)) q_i = q_i
  (since s∈Δ(Ω) ⇒ ∑_ω s(ω) = 1, and ∫λ_i^±(s)dτ contributes to q_i).
- Step 3 (calibration). Since g_i ∈ N_W(w_i) (Lemma 7) and N_W(w_i)
  is a convex cone (closed under positive scalar mult), p_i = g_i / q_i
  ∈ N_W(w_i) ∩ Δ(Ω) = B_W(w_i) (by L1) whenever q_i > 0.
- Step 4 (kernel realization). Define the finite-label adversarial
  kernel κ̂(·|s) := λ^-(s) and the label-marginal q̃. Disintegrate
  γ̃_α over its second marginal. Compute the conditional barycenter
  formula and identify it as p_i = g_i / q_i. Verify the joint law
  is well-defined (Borel measurability of λ^±) and that disintegration
  on finite spaces is automatic.

### Sanity check
For k=2, N=2, w_1=(1,0), w_2=(0,1), α=1/2, τ uniform on Δ — using the
multipliers from Lemma 6's sanity check, compute q_1, q_2, p_1, p_2
explicitly. Verify p_i ∈ B_W(w_i) (e.g., p_1 puts more weight on ω=1
since w_1 dominates in coord 1).

## Conclusion

State the **finite-menu Pareto-Hall calibration theorem** as the
combined conclusion of Lemmas 6, 7, 8:

> Let C* = {w_1, ..., w_k} ⊂ W^P be a Pareto-completed local maximizer
> of F_k. Then there exist measurable adversarial weights λ^-:M → Δ(k)
> with supp λ^-(s) ⊆ I_-(s), such that the induced finite-label
> message marginal q̃ and the induced posterior p_i = g_i/q_i satisfy
> p_i ∈ B_W(w_i) for every i with q_i > 0.

State that the route to robust rationalizability for finite-label
menus is now complete modulo Lemmas 1-5 (which are standard), Lemma
3 (ambientization certificate via paper Lemma 2 of Theorem 1), and
the original-message lift (Lemma 12 / downstream).

## Open issues remaining
- Original-message lift (Lemma 12): finitely many payoff labels need
  to be lifted to original messages m ∈ M via the labeling w*:M → C*.
  This is a separate measurable-selection step.
- Lift to compact C*: extending from finite to compact menus via
  stratified Gauss-map regularity / Painlevé-Kuratowski stability.
- Compatibility with v8 sharpness package: verify the finite-menu
  theorem does not contradict Lemma 7 (cone intersection) + Theorem 8
  (no-free-dust) in the WTA ternary witness.
```

## Output Contract

- Return everything inline in this chat as plain markdown.
- Stick to the section ordering above.
- Be rigorous about Step 3 of Lemma 8 (the calibration claim). The
  proof that p_i = g_i/q_i ∈ N_W(w_i) is the LOAD-BEARING step of
  the entire route. Spell it out completely:
  - g_i ∈ N_W(w_i) ⇔ ∀v ∈ W, v·(v - w_i) ≤ 0 (wait, ∀v∈W, g_i · (v - w_i) ≤ 0)? No: normal cone condition is g_i · (v - w_i) ≤ 0 for all v ∈ W. Confirm the sign.
  - p_i = g_i / q_i, so g_i = q_i p_i. For q_i > 0, p_i · (v - w_i) ≤ 0 for all v ∈ W. Equivalently, p_i ∈ N_W(w_i).
  - p_i ∈ Δ(Ω) (Step 2 of Lemma 8) + p_i ∈ N_W(w_i) ⇒ p_i ∈ B_W(w_i).
- DO NOT skip checking the **sign convention** (Clarke Fermat gives g
  with what sign? The Lemma 7 statement should be unambiguous.) Be
  pedantic.
- DO NOT silently use atomlessness, smoothness, or genericity.
- DO NOT extend to general compact C* in this pass — stay finite-menu.

## Constraints

- Banned re-proposals: see `prior_attempts_digest.md`.
- Stay focused on Lemmas 7 and 8. If a tangential issue appears in
  Lemma 6 or in L1-L5 that you cannot ignore, flag it.
- After the proofs, write a one-paragraph **next-step signal**: which
  Lemma the next prover should attack (likely L9-L11 to wrap up the
  finite-menu capstone), or whether the next move is the original-
  message lift / general-compact lift.
