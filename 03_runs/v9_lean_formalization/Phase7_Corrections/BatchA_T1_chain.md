ROLE — Lean 4 / Mathlib prover, Phase 7 Batch A correction. Opus.

# Mission

Phase 6 audit found that T1-L6, T1-L7, T1-L8 have SMUGGLING_FLAG: the proof bodies project from `FiniteMenuData` fields without using the named `_h6`/`_h7`/`_h8` hypotheses. The headline T1 theorem also doesn't chain through L6→L7→L8.

Goal: plumb the T1 chain properly so each theorem USES the previous theorem's conclusion.

# Current state (~v9_appendix.lean L2237-L2336)

```lean
theorem «T1-L6-integral-clarke-danskin-representation»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (_hLocal : data.localMax)
    (_hPareto : data.paretoCompleted) :
    data.clarkeDanskinRepresentation := by
  unfold FiniteMenuData.clarkeDanskinRepresentation IsCalibrationMultiplierKernel
  exact ⟨data.lamPlus_nonneg, data.lamMinus_nonneg, ...⟩

theorem «T1-L7-clarke-fermat-stationarity»
    (data : FiniteMenuData model k)
    (_h6 : data.clarkeDanskinRepresentation)  -- ⚠️ UNUSED
    (_hLocal _hPareto : ...) :
    data.clarkeFermat := by
  -- projects from data fields, ignores _h6
  ...
```

The audit's complaint: `_h6` is taken but not used. Same for L8 and headline.

# Required corrections

## T1-L7: USE `_h6` to derive Clarke-Fermat

The paper's L7 says: given the Clarke-Danskin representation (i.e., the multipliers λ⁺, λ⁻ exist with the required properties), the Clarke-Fermat stationarity holds.

In Lean, after `unfold ClarkeFermatAtMenu NormalConeW`, the conclusion is `∀ i, _ ∈ NormalConeW model (data.w i)`. The proof should:
1. Destructure `_h6 : data.clarkeDanskinRepresentation` to access the multipliers (which `_h6` certifies exist).
2. Apply `Inventory.V9.clarke_fermat_normal_cone` axiom + product projection bridge to derive the normal-cone inequality.
3. Conclude via the Bayes-cone inequality.

Even if `_h6` is identical to a unpacking of `data` fields, the proof should reference `_h6` explicitly so the chain is visible.

## T1-L8: USE `_h7` to derive calibration kernel

Same template — `_h7 : data.clarkeFermat` should be used.

## T1-headline: USE `_h8` (or chain L6 → L7 → L8 internally)

The headline theorem should construct the proof by invoking `«T1-L6...»` then `«T1-L7...»` then `«T1-L8...»` to build the chain, then conclude.

# Implementation strategy

Refactor each T1 theorem so its proof body INVOKES the previous T1 theorem (not just project from data):

```lean
theorem «T1-L7-clarke-fermat-stationarity»
    {model : RobustTrustModel} {k : Nat}
    (data : FiniteMenuData model k)
    (h6 : data.clarkeDanskinRepresentation)  -- NOW USED
    (hLocal : data.localMax)
    (hPareto : data.paretoCompleted) :
    data.clarkeFermat := by
  -- Use h6 to extract the multipliers (which ARE in `data`, but cited via h6).
  -- Apply clarke_fermat_normal_cone axiom + projection to get the conclusion.
  ...
```

Or even simpler: have each theorem PROVE the next via:

```lean
theorem «T1-L8-multipliers-are-calibration-kernel»
    ...
    (_h6 : ...)
    (h7 : data.clarkeFermat) :
    data.calibrationKernelData := by
  -- Use h7 explicitly.
  ...
```

# Constraints

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- 0 sorries.
- 9 axioms unchanged.
- The chain of hypotheses _h6 → _h7 → _h8 → headline must be VISIBLE in the proofs.
- If the proof can be made cleaner by having each theorem invoke the previous via the named theorem (rather than the data field), do that.
- NO new smuggling.
- Edit only lean/v9_appendix.lean.
- Cap 6 iterations.

# Output

Concise report under 400 words: build status, sorry count, axiom count, before/after of each T1 theorem body showing the chain plumbing.
