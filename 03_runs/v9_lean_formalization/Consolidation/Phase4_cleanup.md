ROLE — Lean 4 / Mathlib prover, PHASE 4 cleanup. Opus.

# Mission

Phase 3 final audit identified ~5% residual smuggling. Fix the actual smuggling:

## A. B5 scalar equality smuggling — FIX

Current state (v9_appendix.lean around L1140 and L2727):

```lean
-- In BinaryCapstoneData (smuggled fields):
binary_lhsL_rhsL_eq : lhsL = rhsL
binary_lhsR_rhsR_eq : lhsR = rhsR

-- B5 theorem body (smuggled use):
theorem «binary-L_B5-endpoint-stationarity-total-balance»
    (data : BinaryCapstoneData model)
    (_hT1 : ...) ... :
    IsEndpointStationarityTotalBalance lhsL rhsL lhsR rhsR := by
  exact ⟨data.binary_lhsL_rhsL_eq, data.binary_lhsR_rhsR_eq⟩
```

**The smuggling**: `IsEndpointStationarityTotalBalance` UNFOLDS to `lhsL = rhsL ∧ lhsR = rhsR`. The two added fields ARE the two conjuncts. Theorem trivializes.

**Fix strategies (preferred to least preferred)**:

1. **Real T1-projection derivation**: refactor lhsL/rhsL/lhsR/rhsR to be `noncomputable def`s computed FROM `endpointMenu.g`, `endpointMenu.q` (the T1 multipliers). Then prove `lhsL = rhsL ∧ lhsR = rhsR` from T1's multiplier-Bayes-cone + mass balance + simplex constraints. This requires the FiniteMenuData structure already has `g`, `q` fields (verify) — use them.

2. **Restructure**: change B5 theorem statement to NOT use raw scalar fields but instead state the conclusion in terms of the T1-derived multipliers directly. E.g., `∑ ω, endpointMenu.g 0 ω = endpointMenu.q 0 ∧ ∑ ω, endpointMenu.g 1 ω = endpointMenu.q 1` (mass balance at k=2). This is provable from T1's mass_balance field (if FiniteMenuData has it).

3. **Honest sorry restore**: remove the 2 smuggled fields, restore narrow `sorry` with `-- TODO: T1 scalar projection at k=2 — requires Clarke subdifferential calculation` comment.

Try (1) first. If genuinely intractable, fall back to (3). DO NOT keep the 2 scalar equality fields.

## B. Axiom shape cleanups (3 axioms)

Each currently has v9-specific Lean shape. Restate generically + add a Lean-side bridge derivation from generic axiom to v9 use site.

### B.1 `clarke_product_normal_cone_projection_bridge` (line ~446)

Current shape: takes ProductProfile, ClarkeNormalCone, NormalConeW (v9-specific types).

Generic restatement: a Clarke product-calculus theorem on a general normed space, then a Lean lemma instantiating it for the v9 setup. Goal:
```lean
axiom Inventory.V9.clarke_product_normal_cone_projection_generic
    {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] ...
    (S : Set E) (T : Set F) (x : E) (y : F) (ξ : E × F →L[ℝ] ℝ)
    (h : ξ ∈ ClarkeNormalCone (S ×ˢ T) (x, y)) :
    ∃ ξ₁ ξ₂, ξ = ξ₁.prod_smul ξ₂ ∧ ξ₁ ∈ ... ∧ ξ₂ ∈ ...
```
(Adjust signature to match actual Clarke product calculus.) Then derive the v9-specific bridge as a `lemma` invoking the generic axiom.

### B.2 `kantorovich_rubinstein_scalar_bridge` (line ~2837)

Current shape: takes RegPackage (v9-specific) + PsiNonpos hypothesis.

Generic restatement: KR scalar duality on a Polish space with a closed graph relation. E.g.:
```lean
axiom Inventory.V9.kantorovich_rubinstein_scalar_duality_generic
    {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]
    [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) (R : Set (X × Y))
    (hRclosed : IsClosed R) (hDom : <some_dominance_condition>) :
    ∃ π : Measure (X × Y), IsCoupling π μ ν ∧ π Rᶜ = 0
```
Wait — that's actually Strassen. KR is different. Let me think... Kantorovich-Rubinstein is the LP duality of optimal transport: max ∫ f dμ - ∫ g dν over Lipschitz pairs (f, g) with f - g ≤ c.

Restate generically + bridge to v9 specific PsiNonpos use.

### B.3 `bayesian_barycenter_in_closed_convex` (line — search for it)

Current shape: takes RegPackage, AdviserKernel, gives `Pγα κ m ∈ B m`.

Generic restatement: barycenter of a probability measure supported in a closed convex subset of a finite-dimensional space lies in the closed convex set. This is the Choquet/Bauer theorem.
```lean
axiom Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
    (μ : Measure E) [IsProbabilityMeasure μ] (S : Set E)
    (hSclosed : IsClosed S) (hSconvex : Convex ℝ S)
    (hSupp : μ Sᶜ = 0) :
    barycenter ℝ μ ∈ S
```
Then add a Lean-side derivation from this generic axiom + `pd.gamma_alpha_conditional_barycenter` + `reg.B_closed` + `reg.B_convex_profile` + kernel support condition, to conclude `Pγα κ m ∈ B m`.

# Constraints (BLOCKING)

- Build MUST PASS.
- ZERO sorries — derive everything in Lean (or honest TODO for B5 if intractable).
- Final axiom count: 9 (unchanged in count, but 3 of them now generic).
- The 6 already-legitimate axioms stay as-is.
- NO new smuggled axioms (each generic restatement must be a genuine textbook theorem, citing the actual external source).
- Edit only lean/v9_appendix.lean.
- Cap at 8 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`
- Source: v9_consolidated.md §B.3, §B.5, §B.7

# Output

Report under 600 words: build status, sorry count, axiom count (target 9), per-axiom restate summary (B.1, B.2, B.3), B5 fix approach used.
