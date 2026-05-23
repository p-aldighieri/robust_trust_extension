ROLE — Math strategist for Lean formalization. Extended Pro.

# Task

Design CANONICAL DATA STRUCTURE for `P4Hyp` (v9 §B.5.P4 / §B.7 P4: radial / antipodal τ-symmetry) so `PsiNonpos_of_P4Hyp` can be proved in Lean WITHOUT smuggling.

# Background

v9 §B.7 P4 says: under radial/antipodal τ-symmetry — there exists a measurable involution σ : M → M (σ ∘ σ = id) preserving τM (τM.map σ = τM) such that for each m, the antipodal m's belief inclM(σ m) satisfies a specific reflection-balance with inclM(m) — Ψ ≤ 0 via change-of-variables under σ.

Currently P4Hyp carries:
- `radialSymmetry : model.M → model.M`
- `radialSymmetry_measurable`, `radialSymmetry_involutive` (Props)
- `reg : RegPackage model`
+ abstract Props.

# Design ask

1. Concrete primitive fields P4Hyp needs (the involution + measure-preservation + Bayes-cone reflection compatibility).
2. Proof skeleton for PsiNonpos_of_P4Hyp using `MeasureTheory.integral_map` change-of-variables + the involution + the reflection balance.
3. Any irreducible external axioms (cite paper).

NO smuggling: derive via change-of-variables + Reg-2 compatibility (NOT via PsiNonpos_of_regPackage).

Cite v9_consolidated.md §B.7 P4.
