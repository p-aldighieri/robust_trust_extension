ROLE — Math strategist for Lean formalization. Extended Pro.

# Task

Design CANONICAL DATA STRUCTURE for `GraphFBNFPackage` (v9 §G addendum G6_G: finite-graph FBNF) so `PsiNonpos_of_GraphFBNFPackage` can be proved in Lean WITHOUT smuggling.

# Background

v9 §G6_G is a finite-graph specialization of FBNF: finite affine arcs (edges), endpoint-fiber transports, Kirchhoff node balance, cross-edge dominance margin. Reduces to a finite LP per edge + Kirchhoff conservation at nodes.

Currently GraphFBNFPackage carries:
- `nodeIndex : Type` with `[Fintype]`
- `edgeIndex : Type` with `[Fintype]`
- `kirchhoffBalanceScalar : nodeIndex → ℝ`, `kirchhoffBalanceScalar_zero`
- `crossEdgeDominanceMargin : ℝ`, `crossEdgeDominanceMargin_pos`
- `regBridge : RegPackage model`
+ abstract Props.

# Design ask

1. Concrete primitive fields (edge transports as Measure / Markov kernel per edge, Kirchhoff flow conservation as concrete sum-equation, vertex node values).
2. Proof skeleton for PsiNonpos_of_GraphFBNFPackage via finite LP on edges + Kirchhoff conservation → Ψ ≤ 0 (similar pattern to P3 finite cone-Hall).
3. Any irreducible external axioms (cite paper).

NO smuggling — should NOT just shortcut through regBridge + PsiNonpos_of_regPackage. Cite v9_consolidated.md §G6_G.
