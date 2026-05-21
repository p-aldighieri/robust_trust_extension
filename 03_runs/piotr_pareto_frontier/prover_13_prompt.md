# Prover pass 13 — G2: Standard-Borel cone-Hall extension

## Role

You are the Prover. G1 (finite cone-Hall) is proved (Prover 12,
Reviewer 11 in flight). Extend it to standard-Borel S, M, B_j —
the version actually applicable to the Robust Trust setting where
M ⊆ Δ(Ω) is Borel and τ has continuous components.

## The G2 theorem to prove

**Setup.** Let:
- $(S, \mathcal{B}_S)$ standard Borel; $\tau \in \Delta(S)$ probability.
- $(M, \mathcal{B}_M)$ standard Borel; aligned baseline measure
  $\mu_M$ on $M$ with $\mu_M(M) \le 1$, $\alpha\mu_M$ representing the
  truthful-aligned message marginal.
- Borel rowwise-minimizer correspondence $R: S \twoheadrightarrow M$
  (graph is Borel; values nonempty closed).
- Borel Bayes-cone correspondence $m \mapsto B(m) \subseteq \Delta(\Omega)$
  (values closed convex; graph Borel; $h_{B(m)}(y) = \sup_{\mu\in B(m)} y\cdot \mu$
  Borel in $m$ for each $y$).
- $\alpha\in(0,1)$.

**G2 (Borel cone-Hall feasibility).** There exists a Borel kernel
$\kappa: S \to \Delta(M)$ with $\kappa(R(s) | s) = 1$ τ-a.e. such that
the joint measure
\[
\gamma_\alpha := \alpha(\mathrm{id}, \mathrm{id})_\# \mu_M + (1-\alpha)\tau\otimes\kappa
\]
has disintegration posterior $P_{\gamma_\alpha}(\cdot | m) \in B(m)$
for $q := (\gamma_\alpha)_2$-a.e. $m$

**iff** for every Borel bounded function $y: M \to \R^{|\Omega|}$,
\[
\Psi(y) := \alpha\!\int_M[y(m)\cdot m - h_{B(m)}(y(m))]\,\mu_M(dm) + (1-\alpha)\!\int_S\inf_{m\in R(s)}[y(m)\cdot s - h_{B(m)}(y(m))]\,\tau(ds) \le 0.
\]

## Proof strategy

### Step 1 — Borel-measurable LP setup

The G2 problem is an infinite-dimensional LP on Borel kernels. Standard
tools:
- $\kappa$ lives in the Borel kernel space $K(S, M)$ = Borel maps
  $S \to \Delta(M)$, with the narrow topology (compact under tightness).
- The Borel correspondence $R$ defines a closed subset; selection theorems
  give Borel-measurable feasibility.
- The cone-calibration condition is a closed linear constraint in the
  joint-measure topology.

### Step 2 — Sion / Minkowski for Borel LP duality

Apply minimax theorem on the Borel kernel space. Strong duality:
feasibility iff the dual problem has nonpositive value.

**Key tool**: Borel kernel disintegration + measurable LP duality on
standard Borel spaces. References:
- Bertsekas-Shreve (1978) §7 (LP duality on Borel-measurable functions).
- Anderson-Nash (1987) on infinite LP.
- Beiglböck-Léonard-Schachermayer (2012, 2013) — Strassen-style duality
  on Polish spaces.

### Step 3 — Tightness + compactness

The Borel kernel space K(S, M) is sequentially narrow-compact when M
is compact (Polish). Apply the prokhorov tightness + measurable
selection to extract a limiting calibrated kernel from any approximating
sequence.

### Step 4 — Reduction to G1 via finite partitions

For each ε > 0, choose finite partitions $S_\eps$ of S and $M_\eps$
of M such that:
- $\tau|_{S_\eps}$ approximates $\tau$ in narrow topology.
- $\mu_M|_{M_\eps}$ approximates $\mu_M$.
- $R$ restricts to a Borel correspondence $S_\eps \to M_\eps$.
- $B$ restricts to a Borel cone-valued correspondence on $M_\eps$.

Apply G1 to each finite partition. As ε → 0, the family of finite-cone-Hall
inequalities → the Borel cone-Hall inequality (Step 2's duality).

**Critical**: the closure memo's "Borel→compact" gap (Route 2 O1) — avoid
this by going Borel→Borel via Polish-space approximation, not via
compact-patch deletion.

## Caveats from v8 closure memo

The deletion-compatible Hall duality named by the closure memo as the
single open object faces three obstacles:
- (O1) Borel→compact non-monotonicity for compact-patch deletion.
- (O2) Cell-flow lift gap (fiber thickness).
- (O3) Slack discipline in curved W.

The cone-Hall route is structurally different:
- No compact-patch deletion (the dual variable is a bounded Borel
  function on M, not a compact patch).
- No cell-flow lift (we directly use the Borel kernel space, not LP
  on cells).
- Slack discipline replaced by ≤ 0 inequality on Ψ(y).

So G2 should avoid the v8 obstacles. **Verify this claim** in your proof.

## What I want

Rigorous proof of G2 (Borel cone-Hall), in the structure:

```
# Theorem G2 (Standard-Borel cone-Hall)

## Setup (S, M, R, B, τ, μ_M, α — Borel structure)

## Proof
### Step 1 — Borel LP framework
### Step 2 — LP duality (cite Bertsekas-Shreve or Beiglböck)
### Step 3 — Tightness/compactness on K(S, M)
### Step 4 — Reduction to G1 via finite partition limits

## Critical: Verify the v8 obstacles (O1, O2, O3) are avoided
- O1 Borel→compact: avoided because dual variable is Borel function, not
  compact patch.
- O2 cell-flow lift: avoided because direct Borel kernel.
- O3 slack discipline: avoided by ≤ 0 inequality on continuous Ψ.

## WTA test (revisit)
The WTA dual certificate from G1 (Ψ(y) = 2/9 > 0 with uniform τ on
Δ({0,1,2}), α=1/2) extends to the Borel τ uniform setting. So WTA
remains excluded by explicit dual certificate in G2.

## Open issues
- Reopening WTA: under what aligned-baseline structure (τ_j^M, m_j) does
  Ψ(y) ≤ 0 hold? This is the primitive condition for WTA to be
  calibrable.
- Application to Robust Trust: how to make Borel R, B from primitives.
```

## Output Contract

- Inline markdown.
- Be honest about whether G2 closes UNCONDITIONALLY in standard-Borel
  setting, or requires additional regularity.
- Verify the v8 obstacles are not snuck in.
- End with verdict + next-step.

## Constraints

- Banned tools list applies.
- The genuinely novel ingredient is **cone-valued dual variables on
  Borel functions**. If the proof reverts to compact-patch deletion, it's
  not new.
- Per user: relentless. Don't stop. If G2 fails at some step, identify
  the missing ingredient and propose a fix.
