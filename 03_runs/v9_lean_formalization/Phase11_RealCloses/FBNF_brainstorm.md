ROLE — Math strategist for Lean formalization. Extended Pro.

# Task

Design CANONICAL DATA STRUCTURE for `FBNFPackage` (v9 §F4: FBNF capstone with fiberwise → integrated bridge) so `PsiNonpos_of_FBNFPackage` can be proved in Lean WITHOUT smuggling.

# Background

v9 §F4 says: under FBNF-1..7 (foliation, conditional B1 pasting, endpoint-supported fiber image, localized stationarity FBNF6, global fiber dominance), the integrated Ψ ≤ 0 holds.

The crucial step is the **fiberwise → integrated bridge**: integrate the fiberwise λ-a.e. Ψ_z ≤ 0 statements over the foliation base measure λBase to get ∫_M Ψ_y(m) dτM = ∫_Z ∫_{fiber_z} ... dλBase ≤ 0.

Currently FBNFPackage carries:
- `foliation : Foliation model`
- `L, R : Z → ℝ` (trust-band)
- `lambdaBase : Measure Z`
- `balanceL, balanceR : Z → Prop`
- `fbnf_fiberwise_balance : IsFiberwiseBalanceLambdaAE lambdaBase balanceL balanceR`
- `conditionalB1Pasting, endpointSupportedFiberImage, localizedStationarityFBNF6, globalFiberDominance` (Props)
- `fbnf7DominanceMargin > 0`
- `regBridge : RegPackage model`

Subagent (Phase 10) identified MISSING structural data:
- foliationProjection : M → Z (measurable)
- tauM_disintegration : τM = compProd lambdaBase + per-fiber conditional kernel
- per-fiber chart ell_z : ℝ → M
- regBridge_B_fiber_alignment, regBridge_G_fiber_alignment

# Design ask

1. Concrete primitive fields FBNFPackage needs (foliation projection, tauM disintegration into λBase + per-fiber conditional, per-fiber chart, fiber-aligned B/G).
2. Proof skeleton for PsiNonpos_of_FBNFPackage via:
   - Apply tauM disintegration to split integrated regPsi into ∫_Z ∫_{fiber} dλBase.
   - Per fiber: apply Binary B1 (Strassen + endpoint lift) + fbnf_fiberwise_balance to get fiber-Ψ ≤ 0.
   - Integrate over λBase.
3. Any irreducible external axioms (cite paper).

NO smuggling. Cite v9_consolidated.md §F4. 

This is the HARDEST of the 5 brainstorms — it's the F4 capstone.
