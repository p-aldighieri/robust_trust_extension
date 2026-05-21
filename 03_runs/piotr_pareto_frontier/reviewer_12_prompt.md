# Reviewer pass 12 — Verify G2c (compact-closed cone-Hall)

## Role

Fresh-chat reviewer on Prover 13's G2c (compact-closed cone-Hall
extension) from `prover_13_response.md`. The headline claim:

- **G2 (bare standard-Borel) FAILS** by a boundary-escape counterexample.
- **G2c (compact closed M) PASSES**, and all three v8 closure-memo
  obstacles (O1 Borel→compact, O2 cell-flow lift, O3 slack discipline)
  are genuinely avoided by cone-Hall's bounded-Borel dual variables +
  global conic separation.

**Critical for the project**: in Robust Trust, $M = \operatorname{supp}\tau \subseteq \Delta(\Omega)$
is automatically compact (closed subset of the compact simplex
$\Delta(\Omega)$). So G2c applies directly to Robust Trust, giving an
**unconditional Borel cone-Hall theorem** for the actual paper setup.

## What you're verifying

**G2c Theorem statement**: For compact metric $M$, Polish $S$,
Borel $R: S \rightrightarrows M$ with closed values, Borel $B: M \rightrightarrows \Delta(\Omega)$
with closed convex values, $\alpha\in(0,1)$, $\tau\in\Delta(S)$,
$\mu_M\in\Delta(M)$:

Exists a Borel kernel $\kappa: S\to\Delta(M)$ with $\kappa(R(s)|s) = 1$
τ-a.e. and disintegration posterior $\in B(m)$ q-a.e.

**iff**

$\Psi(y) := \alpha\int_M[y(m)\cdot m - h_{B(m)}(y(m))]\,\mu_M(dm) + (1-\alpha)\int_S\inf_{m\in R(s)}[y(m)\cdot s - h_{B(m)}(y(m))]\,\tau(ds) \le 0$

for every bounded Borel $y: M \to \R^{|\Omega|}$.

## Specific checks

### 1. The compact-closed proof
Verify the conic separation argument on the primal flow polytope $T(\Pi_R)$
(transport polytope on the graph of R) vs the product cone $C$ (cone of
admissible posteriors).

### 2. Obstacles audit

- **O1 Borel→compact**: prover claims the dual variable is a global
  Borel function on M, not a compact patch. Verify.
- **O2 Cell-flow lift**: prover claims the primal is already a measure
  on Gr R (the joint), and disintegration gives the kernel directly.
  Verify (no cell-flow lift needed).
- **O3 Slack discipline**: prover claims no ε-net; separation gives
  one continuous price. Verify.

### 3. Boundary-escape counterexample
Verify the prover's counterexample to bare standard-Borel G2. Confirm
the counterexample's M is genuinely non-compact (not closed in a
compact ambient space).

### 4. Applicability to Robust Trust
**Critical**: in Robust Trust, $M = \operatorname{supp}\tau$ is a closed subset of
$\Delta(\Omega)$ (since support is always closed). $\Delta(\Omega)$ is
the compact simplex in $\R^{|\Omega|}$ (since $|\Omega|$ finite). So
$M$ is automatically compact in Robust Trust.

Therefore G2c applies UNCONDITIONALLY to Robust Trust, and there's no
boundary-escape issue for the actual setup.

Verify this claim. If correct, G2c is the **deletion-compatible Hall
duality theorem** named in v8 closure memo as the single open object.

### 5. WTA test
G2c WTA test should give the same explicit dual certificate Ψ(y) = 2/9 > 0
as G1 (since compact uniform is the simplest case). Verify.

## Verdict format

- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.
- If PASS: confirm this is the **deletion-compatible Hall duality
  theorem** the v8 closure memo named.
- End with next-step (P14 applies to Robust Trust Theorem 2 biconditional).
