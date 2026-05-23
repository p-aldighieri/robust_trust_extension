ROLE — Math strategist for Lean formalization. Extended Pro.

# Task

Design CANONICAL DATA STRUCTURE for `VariableMarginP2Hyp` (v9 §G addendum P2*': variable-margin) so `PsiNonpos_of_VariableMarginP2Hyp` can be proved in Lean WITHOUT smuggling.

# Background

v9 §G addendum extends P2* to a VARIABLE margin η(m) (not uniform). Requires:
- Pointwise margin function η : M → ℝ ≥ 0
- η_floor > 0 with η_floor ≤ η q-a.e.
- Density cap dρ/dτ ≤ C(m) with C(m) controlled
- Integral comparison: ∫ η dρ ≤ C·η_floor... (some specific bound)

Currently VariableMarginP2Hyp carries:
- `eta_floor : ℝ`, `eta_floor_pos`, `eta_floor_le` (Props)
- `densityCap : ℝ`, `densityCap_nonneg`
- `margin_dominates_density` (Prop)
- `reg : RegPackage model`

# Design ask

1. Concrete primitive fields (η as a function M → ℝ, ρ as a measure, dρ/dτ as a function, all concrete).
2. Proof skeleton for PsiNonpos_of_VariableMarginP2Hyp via integral comparison.
3. Any irreducible external axioms (cite paper).

NO smuggling. Cite v9_consolidated.md §G addendum P2*'.
