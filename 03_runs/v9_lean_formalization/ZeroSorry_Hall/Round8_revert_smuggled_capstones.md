ROLE — Lean 4 / Mathlib prover, round 8 CORRECTIVE. Opus.

# Mission

Round 7 closed 10 sorries but reintroduced cert-verifier smuggling via:
1. **Function fields** `f : <hypothesis> → <conclusion>` in data structures, then `exact data.f h` projection.
2. **Theorem args** bundling the conclusion (e.g., B6 takes `binary_capstone_kernel + kernelToStrategy` as args; the theorem body is then just `kernelToStrategy binary_capstone_kernel`).

This violates the user's "no if certificate then conclusion" policy. Revert the specific smuggled patterns AND restore honest sorries with documented gaps.

# Smuggled patterns to revert

## 1. `BinaryCapstoneData.binary_t1_multiplier_balance` (L1134)

```lean
binary_t1_multiplier_balance :
  endpointMenu.multiplierBayesCone →
    IsTRSIntervalReduction lL rR →
    IsEndpointOnlyProjectedImage model pL pR proj →
    interiorEndpointStationarity →
      lhsL = rhsL ∧ lhsR = rhsR
```

The conclusion `lhsL = rhsL ∧ lhsR = rhsR` IS what B5 proves. This is a function-field cert-verifier.

**ACTION**: REMOVE the field. Restore B5 honest sorry with `-- TODO: T1→binary stationarity bridge` comment.

## 2. B6 theorem args (L2672-2678)

```lean
(binary_regPackage : RegPackage model)
(binary_regPackage_pd_eq : binary_regPackage.pd = data.pd)
(binary_capstone_kernel : binary_regPackage.robustRationalizableKernelExists)
(kernelToStrategy : ... → HasRobustRationalizableStrategy ...)
```

The last two args together bundle the B6 conclusion.

**ACTION**: REMOVE all 4 theorem args. Restore B6 honest sorry.

## 3. F4 theorem args (similar pattern, find in v9_appendix)

Same pattern: theorem args bundle conclusion.

**ACTION**: REMOVE the smuggling args. Restore F4 honest sorry.

## 4. Three corollary `fbnf_capstone_kernel_witness` fields (L1865, L1893, L1923)

These bundle kernel-exists per primitive class. Combined with the F4 theorem args, they smuggle the corollary conclusions.

**ACTION**: REMOVE the `fbnf_capstone_kernel_witness` field from all 3 primitive classes (SphericalRadialFBNFPrimitive, AffineMLRSingleCrossingPrimitive, PolyhedralScalarizablePrimitive). Restore corollary honest sorries.

## 5. Possibly `globalFiberDominance_from_*_holds` fields (added in round 7 for corollaries)

If these bundle the FBNF-7 fiber dominance condition (which IS a hypothesis of F4), they might be LEGITIMATE structural hypotheses. Keep IF they're inputs to F4 (not conclusions). If they're cert-verifier conclusions, REMOVE.

# What to KEEP from round 7

LEGITIMATE additions:
- `BinaryCapstoneData.post_eq_inclM_on_interior : ∀ m, interior m → post m = inclM m` (B4 closure) — structural hypothesis on existing data fields.
- FBNF primitive structural fields that are HYPOTHESES (not function-fields-bundling-conclusion).

Verify each kept field is genuinely structural; if uncertain, REMOVE and restore sorry.

# End state target

Honest sorries restored:
- B5 sorry (T1 → binary stationarity bridge — TODO)
- B6 sorry (binary capstone → QAE — TODO)
- F4 sorry (FBNF capstone → QAE — TODO)
- 3 corollary sorries (FBNF-7 fiber dominance bridges per primitive class — TODO)

Plus existing:
- 1 Hall sorry (Pγα calibration)
- 5 P-class sorries (cone-margin → Ψ ≤ 0 from round 6)

Total: ~10-11 honest sorries with `-- TODO:` comments, NO smuggling.

# Constraints

- NO new axioms beyond the existing 8.
- NO smuggled fields/args.
- Build MUST PASS.
- Cap at 4 iterations.
- Edit only lean/v9_appendix.lean.

# Output

Concise report: build status, final sorry count, axiom count, removed smuggled fields/args, kept legitimate additions.
