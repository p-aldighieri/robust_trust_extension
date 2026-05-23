ROLE — Lean ↔ paper auditor + paper-quality reviewer. Extended Pro.

# Task

Two-part audit on the v9 Lean formalization (final post-Phase 11 state, Reviewer pass 3 CLEAN ACCEPT):

## Part 1 — Per-new-step audit

For EACH new lemma / structural primitive added in Phase 11, verify:
- **Translation**: Lean statement matches v9 paper §-statement.
- **Smuggling**: no shortcut, no cert-verifier, no conclusion-shaped fields.
- **Dependencies**: any axioms used are paper-cited textbook externals.
- **Goals**: the Lean theorem proves what the v9 paper claims.

New artifacts to audit:

### Phase 11 per-class PsiNonpos lemmas:
- `PsiNonpos_of_P2StarHyp` — driver for P2-star theorem.
- `PsiNonpos_of_P3Hyp` — driver for P3 polyhedral theorem.
- `PsiNonpos_of_P4Hyp` — driver for P4 radial-antipodal theorem.
- `PsiNonpos_of_VariableMarginP2Hyp` — driver for G-addendum variable margin.
- `PsiNonpos_of_GraphFBNFPackage` — driver for G-addendum P6_G.
- `PsiNonpos_of_FBNFPackage` — driver for FBNF F4 capstone.
- `PsiNonpos_of_BinaryCapstoneData` — driver for Binary B6.
- `PsiNonpos_of_AffineMLRSingleCrossingPrimitive` — driver for affine-MLR corollary.
- `PsiNonpos_of_PolyhedralScalarizablePrimitive` — driver for polyhedral-scalarizable corollary.

### Phase 11 structural refactors of hypothesis types:
- `P2StarHyp` (added eta, jam, kappa0, C_rho, jam_le_eta_ae, structural upper bound).
- `P3Hyp` (refactored into 6 sub-structures: P3FiniteMenu + P3PolyhedralW + P3BayesConeFacets + P3RowwiseRouting + P3FiniteFlowLP + P3ConeMargin).
- `P4Hyp` (radialSymmetry_tauM_preserving + reflectionBalance + antisymmetry + structural upper bound).
- `VariableMarginP2Hyp` (variable η, densityCapFn, structural upper bound).
- `GraphFBNFPackage` (edgeFlow, graphEdgeIntegrand, structural upper bound; Prop bridges removed).
- `FBNFPackage` (foliationProjection, fiberChart, tauFiber, B/G fiber alignment, fiberPsiIntegrand, structural upper bound).
- `FBNFFoliationData` (new bundle for corollary instantiations).
- `BinaryCapstoneData` (binaryIntegrand + structural upper bound; post_eq_inclM_on_interior + binary_lhsL/R_eq removed — though wait, those were earlier round).

### Phase 5B `bayesConeFromPrior` construction on RegPackage:
- New primitives: bayesConeFromPrior, bayesConeFromPrior_self, B_eq_bayesConeFromPrior_at_inclM, G_rowwise_carries_prior_to_bayes_cone.

For each: PASS / FAIL with one-line justification.

## Part 2 — What should the English paper clarify?

The Lean formalization process surfaced structural requirements that the v9 paper may benefit from explicitly documenting. For each of the following observations, comment whether the v9 paper:
- Already states this explicitly (no action needed).
- States it implicitly (paper could clarify).
- Doesn't state it at all (paper has a gap).

Observations:

1. **Bayes cone as a function of prior**: Lean makes explicit `bayesConeFromPrior : Belief Ω → Set (Belief Ω)`. The paper says "Bayes cone B(m)" but the Lean encoding requires a construction map from prior to cone. Does the paper state this construction explicitly?

2. **Per-class structural Ψ bound**: each P-class theorem (P2*, P3, P4, VariableMargin, GraphFBNF, FBNF F4) has a Lean structural hypothesis `regPsi reg y ≤ <class-specific integral>`. These are the v9 paper's substantive geometric → Ψ derivations explicitly typed. Does the paper state the upper bound's exact form for each class?

3. **P3 finite LP encoding**: Lean's P3FiniteFlowLP requires concrete x_ij flow variables + source_balance + q_eq + n_eq + facet_feasible + ConicFarkasInstance with primal-feasibility witness. The paper says "finite-facet LP" — does it spell out the encoding to this level?

4. **P4 reflection-balance integrand**: Lean's P4Hyp.reflectionBalance is a per-message function with σ-antisymmetry. The paper says "antipodal τ-symmetry" — does it define the precise reflection-balance function?

5. **FBNF F4 fiber disintegration data**: Lean's FBNFPackage carries foliationProjection : M → Z, fiberChart : Z → ℝ → M, tauFiber : Z → Measure M, plus B/G fiber alignment τM-a.e. equalities. The paper says "fiberwise" — does it spell out the disintegration data?

6. **Binary B6 derivation chain**: Lean's binary-L_B6-capstone uses explicit B2 → B3 → B1 → B4 chain. Does the paper present the chain in this order or a different order?

7. **GraphFBNF edge flow + Kirchhoff**: Lean's GraphFBNFPackage has edgeFlow + kirchhoffBalanceScalar_zero + graphEdgeIntegrand. The paper §G6_G — does it spell out the edge flow LP?

8. **WTA threshold form**: Lean uses D ≥ 2(1−α)/(9α). v9_consolidated.md historical comment at L1785 references the corrected vs. previously-wrong reciprocal form. Anywhere else in the paper that might still have the stale form?

For each observation, suggest a 1-2 sentence clarification the v9 paper could add (if applicable).

# Output

Two-part report:

**Part 1**: per-new-artifact PASS/FAIL list with justifications.

**Part 2**: per-observation status (explicit / implicit / gap) + suggested clarifications.

End with overall: ACCEPT / NEEDS_PAPER_CLARIFICATIONS.
