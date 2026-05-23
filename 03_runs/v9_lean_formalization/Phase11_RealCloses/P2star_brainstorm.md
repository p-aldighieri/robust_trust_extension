ROLE — Math strategist for Lean formalization. Extended Pro.

# Task

Design CANONICAL DATA STRUCTURE for `P2StarHyp` (v9 §B.5.P2* / §B.7 P2*: cone-margin plus bounded rowwise jamming) so `PsiNonpos_of_P2StarHyp` can be proved in Lean WITHOUT smuggling.

# Background

v9 §B.7 P2* says: under Reg-1/Reg-2, if truthful messages sit uniformly inside their Bayes cones (`dist(m, Δ(Ω)∖B(m)) ≥ η τ-a.e.`), and there's a rowwise-minimizer kernel κ₀ supported on G(s) with target marginal ρ satisfying ρ ≪ τ + dρ/dτ ≤ C, AND a quantitative displacement bound keeping the mixture posterior inside the Bayes cone, then Ψ ≤ 0.

Currently P2StarHyp carries:
- `coneMarginScalar : ℝ > 0`
- `jammingBound : ℝ ≥ 0`
- `alignedBaselineFloor : ℝ`
- `margin_dominates_jamming` (numerical inequality)
- `reg : RegPackage model`
+ abstract Props.

# Design ask

Propose:
1. Concrete primitive fields P2StarHyp needs (η, κ₀, ρ, dρ/dτ bound, displacement bound — as Lean types).
2. Proof skeleton for PsiNonpos_of_P2StarHyp.
3. Any irreducible external axioms (cite paper).

NO smuggling: no PsiNonpos field, no regBridge-implies field. The geometric/measure data should let a Lean prover honestly derive Ψ ≤ 0 via the v9 paper's actual P2* argument (cone-margin + bounded jamming → bounded displacement → posterior stays in B(m) → Ψ ≤ 0 via support function).

Cite v9_consolidated.md §B.7 P2*.
