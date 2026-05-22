ROLE — Lean 4 / Mathlib prover, math template, fresh-context Opus subagent fork.

Your task: discharge the v9 **FBNF block** in `lean/v9_appendix.lean` — 4 sub-lemmas (F1, F2, F3, F4) + 3 corollaries (spherical-radial, affine-MLR, polyhedral-scalarizable). 7 theorems total. Follow the same data-witness pattern as T1/T2/Binary/Hall.

Files:
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean` (edit ONLY this)
- `C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean` (read-only)
- `v9_consolidated.md` §B.4 (FBNF source)
- `exposition_v9.tex` §9

# v9 FBNF (Fibered Binary Normal Fan) — |Ω| ≥ 3 unconditional class

Per `exposition_v9.tex §9`, FBNF is the |Ω|≥3 generalization of the binary capstone, using affine 1-d foliation of Δ(Ω) over a standard Borel base. The FBNF class consists of model primitives admitting:

- (FBNF-1) Measurable affine foliation.
- (FBNF-2) Fiber-preserving TRS.
- (FBNF-3) Endpoint-supported (PROJECTED) fiber image.
- (FBNF-4) Fiberwise endpoint exposure.
- (FBNF-5) Fiberwise tie discipline.
- (FBNF-6) Localized stationarity (derived from optimality via F3).
- (FBNF-7) Global fiber dominance.

# Theorems to discharge

```lean
-- §15 FBNF F1 … F4

theorem «FBNF-F1-conditional-B1-measurable-pasting»
    (pkg : FBNFPackage model)
    (_hB1 : ∀ data : BinaryCapstoneData model,
      data.endpointStationarityTotalBalance → data.endpointFiberLift) :
    pkg.conditionalB1Pasting := by sorry

theorem «FBNF-F2-endpoint-only-projected-fiber-image»
    (pkg : FBNFPackage model)
    (_hTRS : pkg.fiberPreservingTRS) :
    pkg.endpointSupportedFiberImage := by sorry

theorem «FBNF-F3-localized-stationarity-FBNF6»
    (pkg : FBNFPackage model)
    (_hT1 : ∀ k (fd : FiniteMenuData model k), fd.multiplierBayesCone)
    (_hF2 : pkg.endpointSupportedFiberImage)
    (_hPert : pkg.localTwoSidedPerturbability) :
    pkg.localizedStationarityFBNF6 := by sorry

theorem «FBNF-F4-capstone»
    (pkg : FBNFPackage model)
    (_hF1 : pkg.conditionalB1Pasting)
    (_hF2 : pkg.endpointSupportedFiberImage)
    (_hF3 : pkg.localizedStationarityFBNF6)
    (_hDom : pkg.globalFiberDominance) :
    HasRobustRationalizableStrategy model pkg.pd := by sorry

-- §19 FBNF instantiation corollaries

theorem «FBNF-corollary-spherical-radial»
    (prim : SphericalRadialFBNFPrimitive model) :
    ∃ pkg : FBNFPackage model,
      HasRobustRationalizableStrategy model pkg.pd := by
  let pkg := { ... } -- constructed from prim
  refine ⟨pkg, ?_⟩
  sorry

-- Similar for FBNF-corollary-affine-MLR-single-crossing
-- and FBNF-corollary-polyhedral-scalarizable
```

Currently F1, F2, F3, F4 use `pkg.<field>` (abstract Prop) as their conclusions. The corollaries already build a pkg from `prim` but leave the final apply as `sorry`.

# Pattern (same as T1/T2/Binary/Hall)

1. Add module-scope `Is*` predicates encoding concrete claims:
   - `IsConditionalB1Pasting model foliation κL κR ...` (Borel-measurable kernel pair on the affine fiber chart).
   - `IsEndpointSupportedFiberImage model foliation proj ...` (projected-payoff-only-on-fiber-endpoints).
   - `IsLocalizedStationarityFBNF6 ...` (fiberwise total-balance equalities; FBNF-6).
   - (FBNF-F4 returns `HasRobustRationalizableStrategy model pkg.pd` directly — no new predicate; uses a `capstoneWitness` field.)

2. Add data-witness fields to `FBNFPackage`:
   - `conditionalB1Pastingdata : IsConditionalB1Pasting ...`
   - `endpointSupportedFiberImagedata : IsEndpointSupportedFiberImage ...`
   - `localizedStationarityFBNF6data : IsLocalizedStationarityFBNF6 ...`
   - `capstoneWitness : HasRobustRationalizableStrategy model pd`

3. Refactor `FBNFPackage.{conditionalB1Pasting, endpointSupportedFiberImage, localizedStationarityFBNF6}` to `def`s unfolding via the witness fields. Theorems discharge by projection.

4. For the THREE corollaries: build `pkg` from primitive fields (already done in the skeleton), then either:
   - Apply `«FBNF-F4-capstone»` directly using primitive bridge proofs (if the primitive carries enough), OR
   - Use `sorry` for the final apply and flag it as a follow-up (the primitive classes carry abstract Prop bridge fields — they're placeholders).

# Constraints

- DO NOT modify `v8_main.lean`.
- DO NOT add new Inventory axioms.
- DO NOT regress T2, T1, Binary, Hall (current source sorry count: 16).
- Cap at 5 build attempts.
- Lean 4 / Mathlib v4.30.0-rc1.
- F3 should take the universal T1 hypothesis (T1 multiplier-bayes-cone available via `fd.bayesConeCertificate`).

# Build verification

```
cat "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v8_main.lean" "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/v9_appendix.lean" > "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean"
cp "C:/Users/dep89/OneDrive/Economia/RA Piotr/robust_trust_extension/lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter"
lake build MathlibStarter.V9Main
```

# Output

Report in under 600 words: theorems discharged (out of 7), build status, new sorry count, FBNFPackage / SphericalRadialFBNFPrimitive / etc. refinement summary, flagged follow-ups.

The artifact is the edited file.
