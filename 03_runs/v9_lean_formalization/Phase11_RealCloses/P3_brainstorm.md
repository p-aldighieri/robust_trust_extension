ROLE — Math strategist for Lean formalization. Extended Pro (gpt-5.5-pro-xhigh).

# Task

Help design the CANONICAL DATA STRUCTURE for `P3Hyp` in Lean so that the lemma `PsiNonpos_of_P3Hyp : (hyp : P3Hyp model) → PsiNonpos model hyp.reg` can be proved in Lean WITHOUT smuggling.

# Background

v9 paper §B.5.P3 says: under polyhedral W with finite-vertex C* and a positive polyhedral cone-margin, `Ψ ≤ 0` for all bounded Borel test profiles `y : M → ℝ^|Ω|`. The derivation passes through a finite-vertex LP: enumerate the extreme rays of the polyhedral cone, apply Farkas duality on the finite LP, conclude Ψ ≤ 0.

Currently `P3Hyp` in v9_appendix.lean carries:
- `vertexIndex : Type` with `[Fintype]` instance
- `polyhedralConeMarginScalar : ℝ` with `polyhedralConeMarginScalar_pos : 0 < polyhedralConeMarginScalar`
- abstract Props: `polyhedralW`, `finiteVertexMenu`, `positiveConeMargin`, `finiteLPFeasible`
- `reg : RegPackage model`

These are bare Props — no concrete LP data (vertex coordinates, constraint matrix). Phase 9 attempted to close the sorry via Farkas but found it required fabricating non-canonical data (smuggling).

# Design question

What CONCRETE CANONICAL DATA should P3Hyp carry to enable a real polyhedral → Ψ ≤ 0 derivation in Lean via:
- `Inventory.V9.farkas_lp_duality_conic` (the standard Farkas axiom)
- `Inventory.V9.clarke_product_normal_cone_projection_generic`
- Standard Mathlib LP / convex analysis

The challenge: the data should be GENUINELY STRUCTURAL (e.g., a finite vertex set with coordinates in the simplex Δ(Ω), plus the polyhedral cone they generate) and NOT carry a `PsiNonpos`-shaped or `regBridge`-shortcut field.

# Output

Propose a refactored P3Hyp structure with:
1. List of new structural primitive fields needed (with Lean types).
2. The proof skeleton for `PsiNonpos_of_P3Hyp` using these fields (high-level math chain — Lean tactic-level not needed).
3. Identify any irreducible external axiom additions (if any). Cite paper for each.

Cite v9_consolidated.md §B.5.P3 for the math content.

Be specific. The goal is to design a structure that lets a Lean prover close the geometric → Ψ derivation honestly.
