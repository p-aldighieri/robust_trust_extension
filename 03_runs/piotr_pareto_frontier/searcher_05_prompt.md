# Searcher pass 05 — Unrestricted |Ω|≥3 (beyond FBNF-7)

## Role

You are the Searcher. The pipeline has now produced TWO unconditional
infinite-extensions of Theorem 2 in the substantive α∈(0,1) regime:

1. **Binary** (|Ω|=2) under (R-EE)+(R-TD)+(R-IES).
2. **FBNF** (|Ω|≥3) under FBNF-1...5 + FBNF-7, covering spherical,
   affine MLR, polyhedral with scalarizable faces.

Both are reviewer-verified, committed to git, and in v9 exposition
(`exposition_v9.pdf`, 11 pages, durable source).

**Per user override (2026-05-21): keep trying.** The pipeline should
attack the **unrestricted |Ω|≥3 case** (without FBNF-7 or any
foliation hypothesis). This is the v8 closure memo's named open
object: the **deletion-compatible Hall duality theorem**.

The WTA ternary witness (v8 §8) fails FBNF-7 by construction. The
v8 closure memo classifies it as a "menu-engine artefact, not a
primitive counterexample". So the witness does not preclude a
primitive infinite-extension; it just shows FBNF-7-style global
dominance is needed unless you can construct a calibration kernel via
a DIFFERENT mechanism.

## Available tools (new since v8 closure)

Pass 3+ produced two new technical mechanisms that v8 didn't have:

- **v9 T1: Finite-menu Pareto-Hall via Clarke-Danskin.** Calibration
  emerges as a Lagrange multiplier at any finite-menu Pareto-completed
  ambient local maximizer of $F_k$. This is a NEW proof method,
  unconditional in payoff-label coordinates.
- **FBNF measurable pasting (F1).** Conditional B1 kernels can be
  measurably pasted across a Borel foliation. The pasting machinery is
  a standard-Borel disintegration argument.

## Candidate attack vectors

### Attack A: Sinkhorn / IPF for multidim Hall transport

The deletion-compatible Hall duality is a coupling problem: find a
kernel $\kappa: M\to\Delta(M)$ supported on $G(s)$ such that the
disintegration posterior on $\Omega$ lies in the Bayes cone $B_W(w^*(m))$
$q$-a.e. This is a constrained OT problem with cone-valued conditional
marginal constraints.

Sinkhorn iteration handles constrained OT with marginal constraints.
Can a Sinkhorn-style ITERATIVE PROPORTIONAL FITTING with Bayes-cone
PROJECTION step converge? Specifically:
- Start with any kernel $\kappa_0$ supported on $G(s)$.
- Compute current posterior $\mu_m^{(t)}$ at each message $m$.
- Project $\mu_m^{(t)}$ onto $B_W(w^*(m))$ (closest belief in the cone).
- Re-couple to maintain marginal constraints.
- Iterate.

**Question**: under what primitive conditions does this iteration
converge to a calibrated kernel? Standard Sinkhorn convergence
results (Cuturi 2013, Léger 2021) give exponential convergence under
boundedness + finite-state. For continuous M, need an infinite-state
extension (Carlier-Duval-Peyré-Schmitzer 2017).

### Attack B: Doval-Smolin full duality

Doval-Smolin "Persuasion and Welfare" (2024) is cited in the paper.
The literature pass already noted this is the closest dual candidate.
The full framework (not just the W^P definition) gives DUAL price
functions on beliefs. Maybe these dual prices admit a disintegration
interpretation that closes calibration.

**Question**: state the Doval-Smolin duality precisely and check
whether the dual price function at the optimum admits a Bayes-cone
calibration interpretation.

### Attack C: Multi-layer foliation

Generalize FBNF: instead of a SINGLE 1-d foliation, allow a MULTI-LAYER
foliation where Δ(Ω) is foliated at multiple scales. For |Ω|=3, this
might be a 2-d foliation with binary fibers at each layer.

**Question**: state the multi-layer FBNF class precisely. Does it
cover the WTA ternary witness?

### Attack D: Stratified normal fan with cross-stratum patching

Drop the affine foliation assumption; replace with a stratification
of Δ(Ω) into sub-domains where the Gauss map is locally well-behaved,
plus a cross-stratum patching condition.

**Question**: does cross-stratum patching reduce to FBNF-7-like global
dominance, or is it genuinely new?

### Attack E: ε-relaxation of FBNF-7

For every ε > 0, define ε-FBNF-7: cross-fiber messages dominate
in-fiber endpoints by at most ε. Get an ε-version of the FBNF theorem.

**Question**: does the ε-version close for ALL primitive models (in
particular the WTA ternary witness)? If yes, this is a sharp
ε-relaxation result.

### Attack F: Direct attack on WTA ternary

Can we construct a calibrated kernel for the v8 WTA ternary witness
under a primitive condition the v8 closure memo didn't consider? The
witness has W^P = {v_0, v_1, v_2} (vertex menu), τ atomless full-
support on Δ(Ω). The cone-intersection lemma + no-free-dust theorem
say no Borel τ-null dust can repair calibration.

**Question**: does the witness have a calibrated kernel under a
sufficiently fine grid of τ (e.g., uniform with positive density on
each face)? If yes, the obstruction theorem is sharp for the abstract
menu-engine but bypassed by primitive structure.

### Attack G: Cone-valued Hall theorem (genuinely new theorem)

State and attempt to prove a Hall-type theorem with cone-valued
constraints: given finite marginals + cone-valued conditional
constraints, when does a coupling exist? Standard Hall theory handles
set-valued constraints; cone-valued is new.

**Tools to try**: Strassen 1965 with cone-valued upper sets, Beiglböck-
Nutz martingale OT with conjugate constraints, abstract intersection
theorems on conjugate cones.

## What I want

Rank Attacks A-G by:
- Probability of yielding a usable primitive result for unrestricted
  |Ω|≥3.
- Distance from v8's failed Routes 1+2 (we don't want to redo).
- Novel ingredient: what technical tool would close the gap.

Pick the TOP attack. State its first prover target.

## Constraints

- Banned tools list applies.
- The v8 closure memo's R6 (constrained persuasion duality) and
  Routes 1+2 already tried direct Hall-type attacks; new attack must
  introduce a genuinely new ingredient.
- v8 sharpness witness (WTA ternary) MUST be addressed: either
  calibrate it under some primitive, or correctly exclude it.

## Output Contract

- Inline markdown.
- End with: (a) one-line top attack + (b) first prover target + (c)
  whether the route can also reopen the WTA ternary as primitively
  calibrable, or only as excluded by hypothesis class.

Per user instruction: keep going. The expectation is that this pass
will either find a real next angle OR honestly conclude the locked
gate is structural beyond all available tools. Don't fall back to
consolidation.
