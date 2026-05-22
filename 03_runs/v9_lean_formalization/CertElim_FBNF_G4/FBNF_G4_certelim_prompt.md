ROLE — Lean 4 / Mathlib prover, cert-elim mode. Model: gpt-5.5 with extra-high reasoning (Codex CLI).

# Mission

Eliminate certificate-verifier pattern from the **FBNF block** and **G4 LP threshold** in `lean/v9_appendix.lean`. These are the last two cert-verifier targets in the v9 surface.

# Targets

## FBNF block (4 theorems + 3 corollaries = 7)

1. `«FBNF-F1-conditional-B1-measurable-pasting»` — projects from `pkg.conditionalB1PastingWitness`
2. `«FBNF-F2-endpoint-only-projected-fiber-image»` — projects from `pkg.endpointSupportedFiberImageWitness`
3. `«FBNF-F3-localized-stationarity-FBNF6»` — projects from `pkg.localizedStationarityFBNF6Witness`
4. `«FBNF-F4-capstone»` — projects from `pkg.capstoneWitness`
5. `«FBNF-corollary-spherical-radial»` — uses `prim.capstoneWitness`
6. `«FBNF-corollary-affine-MLR-single-crossing»` — uses `prim.capstoneWitness`
7. `«FBNF-corollary-polyhedral-scalarizable»` — uses `prim.capstoneWitness`

## G4 LP threshold (1 theorem)

8. `«G4-finite-facet-polyhedral-LP-threshold»` — projects from `PolyhedralLPInstance` witness fields (`psiNonpos`, `lpFeasible` both abstract `Prop`).

# Source math

- **FBNF block** (v9_consolidated.md §B.4, exposition_v9.tex §9): |Ω|≥3 unconditional under FBNF-1..5,7. F1 uses Binary B1 conditional on fiber (Strassen + measurable pasting via foliation chart). F2 endpoint-supported projection. F3 stationarity from T1 universal + two-sided perturbability. F4 capstone combines F1+F2+F3+FBNF-7.
- **G4 LP threshold** (v9_consolidated.md §B.5.G4, exposition_v9.tex §13): For polyhedral W with finite-vertex C*, `Ψ ≤ 0 ↔ ∀ y* extreme directions, a_j(y*) + b_j(y*) ≤ 0`. Direct application of `Inventory.V9.farkas_lp_duality_conic` to a finite polyhedral facet instance.

# Refactor strategy (same template as T1 round 2, WTA, Hall, Binary)

1. **Remove cert-verifier witness fields** from `FBNFPackage`, `PolyhedralLPInstance`, and the three FBNF primitive classes (`SphericalRadialFBNFPrimitive`, `AffineMLRSingleCrossingPrimitive`, `PolyhedralScalarizablePrimitive`):
   - FBNFPackage: `conditionalB1PastingWitness`, `endpointSupportedFiberImageWitness`, `localizedStationarityFBNF6Witness`, `capstoneWitness`.
   - PolyhedralLPInstance: replace abstract `psiNonpos`, `lpFeasible` with concrete unfolds.
   - Primitive classes: drop `capstoneWitness` field.

2. **Derive each FBNF theorem**:
   - F1: apply Binary B1 conditionally on the fiber chart (use `pkg.foliation`); measurable pasting via the chart's measurability.
   - F2: from `pkg.fiberPreservingTRS` + algebra.
   - F3: apply T1 universal hypothesis at k=2 (endpoints), local two-sided perturbability gives equality.
   - F4: combine F1 + F2 + F3 + FBNF-7 (globalFiberDominance) to construct robustly rationalizable strategy.
   - Corollaries: build an FBNFPackage from the primitive class data, then apply F4. The previous round added `fbnf_trivial_pasting` / `fbnf_trivial_fiberProj` helpers — these may need real implementations now.

3. **Derive G4** via `Inventory.V9.farkas_lp_duality_conic` on the polyhedral facet LP. The `PolyhedralLPInstance` should wrap a concrete `ConicFarkasInstance` (similar to what was done for Hall G1).

# Constraints (BLOCKING)

- NO new axioms beyond Inventory.V9 + paper-cited bridges.
- NO `exact pkg.<witness>` / `exact prim.<witness>` projections.
- Honest sorry acceptable for documented Mathlib gaps.
- Build MUST PASS.
- Downstream typecheck: nothing downstream of FBNF/G4 (they're at the leaf of the dependency DAG).

# Plan suggestion

Big task with 8 theorems. Acceptable honest partial:
- G4: should be fully derivable from Inventory.V9.farkas_lp_duality_conic (same pattern as Hall G1).
- F2: algebraic, should be derivable.
- F4: capstone needs a QAE-bridge sorry (same as Binary B6 / Hall bridge).
- F3: T1-universal application, may need sorry for the perturbation→equality step.
- F1: Strassen-on-fiber + measurable-pasting may need sorry on the global kernel assembly (same gap as Hall G2c + Binary B1).
- Three FBNF corollaries: scope the primitive class data and apply F4 — may need a sorry on the FBNFPackage-from-prim construction if the primitive bridge predicates aren't strong enough.

Acceptable to leave ~5-7 honest sorries total in this block, but MUST eliminate all 8 `exact .<witness>` projections.

# Files

- Edit: `lean/v9_appendix.lean` only.
- Source: v9_consolidated.md §B.4 and §B.5.G4, exposition_v9.tex §9 and §13.

# Build verification

```bash
cat "lean/v8_main.lean" "lean/v9_appendix.lean" > "lean/main.lean"
cp "lean/main.lean" "C:/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean"
cd "C:/Users/Public/Documents/Lean/MathlibStarter" && lake build MathlibStarter.V9Main
```

(Fall back to lake env lean if ACL blocks cp.)

# Output

Short report:
- Build status.
- Sorry count (total + new).
- New axioms.
- Witness fields removed.
- Per-theorem body shape.
- Honest sorries with PRECISE reasons.
