ROLE — Math strategist for zero-gap Lean formalization. Extended Pro.

# Task

The v9 Lean currently has, for each P-class (P2*, P3, P4, VariableMargin, GraphFBNF, FBNF, Binary), a STRUCTURAL UPPER BOUND field on the hypothesis package:

```lean
regPsi_le_X_integral : ∀ y, regPsi reg y ≤ <class-specific integral expression>
```

These bound `regPsi` (the integrated Hall-functional) by a class-specific finite/measure expression. Currently each is a HYPOTHESIS FIELD on the package (the v9 paper's substantive derivation result, treated as input to the Lean theorem).

User directive: each one should be DERIVED in Lean from elementary geometric primitives, mirroring the v9 paper's §B.7 / §F4 / §G6_G full derivation chain. The Lean should match or exceed the paper's rigor.

# For each class, propose:

1. The CONCRETE GEOMETRIC PRIMITIVES the hypothesis structure should carry (NOT the upper-bound as a field, but the inputs that ENABLE deriving the bound).
2. The DERIVATION CHAIN from these primitives to `regPsi reg y ≤ <class integral>`.
3. The Mathlib API needed (`integral_mono_ae`, `Measure.compProd`, `Real.le_sSup`, `Finset.sum_*`, etc.) — identify any genuine Mathlib gaps that require narrow Inventory axioms (with paper citations).

## Classes to address:

### P2* (cone-margin + bounded jamming)

Paper §B.7 P2*: under Reg-1/Reg-2, uniform margin η > 0 for `dist(m, ∂B(m)) ≥ η τ-a.e.`, rowwise minimizer kernel κ₀ supported on G(s) with target ρ ≪ τ and dρ/dτ ≤ C, plus a quantitative displacement bound keeping mixture posterior inside B(m). Then Ψ ≤ 0.

Current Lean: P2StarHyp carries eta, jam, kappa0, C_rho, jam_le_eta_ae, and `regPsi_le_jam_minus_eta_integral : ∀ y, regPsi reg y ≤ α · ∫ (jam − eta) dτM`.

Question: derive this bound from the geometric primitives. The paper's path: support-function inequality at the actual mixture posterior (which has displacement controlled by jam) + integration. Spell out the derivation chain.

### P3 (polyhedral cone-margin)

Paper §B.5.P3: polyhedral W with finite-vertex active menu, finite-facet Bayes cones, finite-flow LP feasibility, polyhedral cone-margin > 0. Then Ψ ≤ 0 via Farkas duality on the finite LP.

Current Lean: P3Hyp's 6-substructure refactor (P3FiniteMenu, P3PolyhedralW, P3BayesConeFacets, P3RowwiseRouting, P3FiniteFlowLP, P3ConeMargin) closes via 2 aux lemmas (lp.regPsi_eq_finite + Farkas dual encoding). These aux lemmas are CURRENTLY proved by structural-field projection from lp.regPsi_eq_finite and dual_eval_eq_finitePsi. Question: derive the structural fields themselves (lp.regPsi_eq_finite + dual_eval_eq_finitePsi) from the underlying P3 data + Mathlib.

### P4 (radial-antipodal τ-symmetry)

Paper §B.7 P4: measurable involution σ : M → M with τM-preservation + Bayes-cone reflection compatibility. Then Ψ ≤ 0 via change-of-variables + antisymmetry.

Current Lean: P4Hyp carries radialSymmetry, radialSymmetry_tauM_preserving, reflectionBalance, reflectionBalance_antisymmetric, plus `regPsi_le_reflectionBalance_integral : ∀ y, regPsi reg y ≤ ∫ reflectionBalance dτM`.

Question: derive this upper bound from the involution + reflection compatibility. Paper's path: pair each m with σ(m), the regPsi integrand at m + at σ(m) cancels by antisymmetry → ∫ = 0 ≥ regPsi. Spell out.

### VariableMargin (G addendum P2*')

Paper §G.P2*': variable margin η : M → ℝ ≥ 0 with η_floor > 0, density cap dρ/dτ ≤ C(m), integral comparison.

Current Lean: VariableMarginP2Hyp carries eta, densityCapFn, jam_le_eta_ae, `regPsi_le_densityCap_minus_eta_integral : ∀ y, regPsi reg y ≤ α · ∫ (densityCapFn − eta) dτM`.

Question: derive this bound from variable margin + density cap. Similar to P2* but with pointwise variable margin.

### GraphFBNF (G6_G finite-graph FBNF)

Paper §G6_G: finite affine arcs (edges), endpoint-fiber transports, Kirchhoff node balance, cross-edge dominance margin.

Current Lean: GraphFBNFPackage carries edgeFlow, kirchhoffBalanceScalar_zero, graphEdgeIntegrand_nonpos_ae, `regPsi_le_graphEdgeIntegrand_integral : ∀ y, regPsi reg y ≤ α · ∫ graphEdgeIntegrand dτM`.

Question: derive this bound from Kirchhoff + cross-edge dominance. Paper's path: per-arc finite LP (sub-Farkas), Kirchhoff conservation at nodes, sum → global Ψ ≤ 0.

### FBNF F4 capstone

Paper §F4: under FBNF-1..7, fiber disintegration of τM, per-fiber Binary B1 (Strassen endpoint-fiber lift) + fiberwise balance → integrated Ψ ≤ 0.

Current Lean: FBNFPackage carries foliationProjection, fiberChart, tauFiber, fiberPsiIntegrand, fiberPsiIntegrand_nonpos_ae, `regPsi_le_fiber_integral : ∀ y, regPsi reg y ≤ ∫ fiberPsiIntegrand dλBase`.

Question: derive this fiberwise-to-integrated bound from foliation disintegration + per-fiber Binary B1 + fiberwise balance. Paper's path: τM disintegrates as λBase ⊗ τFiber; per fiber, the Ψ-integrand reduces to fiberPsiIntegrand z via Binary B1; integrate over λBase.

### Binary B6 capstone

Paper §B.3.L_B6: TRS interval reduction (B2) → endpoint-only projected image (B3) → endpoint-fiber lift (B1, via Strassen) → interior calibration (B4) → endpoint stationarity (B5) → capstone.

Current Lean: BinaryCapstoneData carries binaryIntegrand, binaryIntegrand_nonpos_ae, `regPsi_le_binaryIntegrand_integral`.

Question: derive this bound from B1+B3+B5 chain. Paper's path: Strassen-on-endpoints gives endpoint kernel + scalar calibration; interior calibration via R-IES + TRS; integrate → Ψ ≤ 0.

# Output

Per class:
1. **New structural primitives** (replacing the `regPsi_le_X_integral` field): the more-elementary inputs needed.
2. **Derivation chain** (Lean proof skeleton from primitives → bound).
3. **Mathlib gaps** (any narrow Inventory axioms needed, with paper citations).

Goal: in the resulting Lean, NO `regPsi_le_X_integral` field exists on ANY P-class structure. Each is a derived `lemma` from more elementary geometric/measure primitives.

Cite v9_consolidated.md sections per class.
