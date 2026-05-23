ROLE — Lean 4 / Mathlib prover, Phase 8 close Hall forward sorry. Opus.

# Mission

The Hall biconditional forward direction has 1 narrow TODO sorry (~L4356) at the mixture-marginal q-a.e. → τM-a.e. measure-theoretic bridge. Close it.

# Current state

```lean
-- Forward direction body extracts hCalLoadBearing and hSuppLoadBearing
-- Then needs to transfer the q-a.e. (Pγα κ m ∈ B m on mixture marginal)
-- to τM-a.e. (regPsi integrand bound on τM)
-- Specifically: 
--   ∫ m, (beliefDot (model.inclM m) y - supportFunction (reg.B m) y) ∂model.τM ≤ 0
-- needs to follow from hCal + α-weighted decomposition.
sorry  -- TODO: mixture-marginal-q-a.e. to τM-a.e. measure-theoretic bridge
```

# Path

The MixtureCouplingGammaAlpha κ decomposes as:
`α • τM.map diag + (1-α) • (model.τM ⊗ κ)`

The second marginal:
`α • τM + (1-α) • (model.τM ⊗ κ).map Prod.snd = α • τM + (1-α) • MixtureMessageLaw κ`

The hCal q-a.e. statement is on this mixture marginal. To get τM-a.e., note that τM ≪ mixture marginal (since `α • τM` is absolutely continuous in the mixture). So q-a.e. ⟹ τM-a.e. (with appropriate Radon-Nikodym).

Actually simpler: the aligned piece of the mixture marginal IS τM (with weight α). So hCal restricted to the aligned piece gives the τM-a.e. statement directly.

```lean
-- Extract aligned part:
have hCal_aligned : ∀ᵐ m ∂model.τM, reg.pd.Pγα κ m ∈ reg.B m := by
  -- Use that α • τM is absolutely continuous in the mixture marginal
  -- (since α > 0 and mixture = α • τM + (1-α) • ...).
  -- Or use the decomposition directly via reg.mixtureMessageLaw_eq_gammaAlpha_snd.
  ...

-- Then for τM-a.e. m, Pγα κ m ∈ B m.
-- Show: beliefDot (inclM m) y ≤ supportFunction (B m) y via le_csSup + image.
-- The integrand at m is then ≤ 0.
-- Apply integral_nonpos_of_ae.
```

This requires:
- Knowing α > 0 (might need this as an extra hypothesis OR documentable in the v9 standing setup).
- Mathlib's `MeasureTheory.Measure.AbsolutelyContinuous` API.
- Or just direct computation via the mixture decomposition.

If α = 0, the aligned piece vanishes and the bridge requires different reasoning. For Hall biconditional, we typically have α ∈ (0,1) — but the theorem might not require α > 0.

If genuinely intractable, keep the narrow sorry with stronger TODO documentation. But try to close.

# Constraints

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- 9 axioms unchanged.
- NO new smuggling.
- Edit only lean/v9_appendix.lean.
- Cap 5 iterations.
- If genuinely intractable, document the remaining gap precisely.

# Output

Concise report under 400 words: build status, sorry count (target 6 instead of 7), the Hall forward derivation summary.
