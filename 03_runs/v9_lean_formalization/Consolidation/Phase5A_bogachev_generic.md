ROLE — Lean 4 / Mathlib prover, PHASE 5A. Opus.

# Mission

Refactor `Inventory.V9.bayesian_barycenter_in_closed_convex` from its v9-specific shape to a GENERIC Choquet/Bauer barycenter theorem, then add a Lean-side derivation chain in the v9 use site.

# Current shape (v9-specific, retained from Phase 4)

```lean
axiom Inventory.V9.bayesian_barycenter_in_closed_convex
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (κ : AdviserKernel model)
    (hSupp : KernelSupportedOnRegG model reg.G κ) :
    ∀ᵐ m ∂((MixtureCouplingGammaAlpha κ).map Prod.snd),
      reg.pd.Pγα κ m ∈ reg.B m
```

This takes RegPackage + AdviserKernel + kernel-support hypothesis, gives the v9 calibration. Phase 3 audit flagged: "Lean shape is v9-specific in shape." Phase 4 retained per budget. NOW we fix it.

# Target generic shape

```lean
axiom Inventory.V9.barycenter_of_supported_measure_in_closed_convex_generic
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
    [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) [IsProbabilityMeasure μ]
    (S : Set E) (hSclosed : IsClosed S) (hSconvex : Convex ℝ S)
    (hIntegrable : Integrable id μ)
    (hSupp : μ Sᶜ = 0) :
    ∫ x, x ∂μ ∈ S
```

This is the classical Choquet/Bauer barycenter theorem: barycenter of a probability measure supported on a closed convex set is in the set. Standard external textbook result:
- Bogachev V.I. (2007), *Measure Theory*, Vol II, Springer, §11.7 (barycenters and Choquet theory).
- Phelps R.R. (2001), *Lectures on Choquet's Theorem*, Springer Lecture Notes 1757, Ch. 1, FD case.
- Aliprantis & Border (2006), *Infinite Dimensional Analysis*, 3rd ed., Springer, §15.2 (Bauer maximum principle).

# Lean-side bridge derivation (NEW)

Add a lemma that derives the v9-specific `Pγα κ m ∈ reg.B m` q-a.e. claim FROM the generic axiom + v9 primitives:

```lean
lemma Inventory.V9.bayesian_barycenter_in_closed_convex
    {model : RobustTrustModel}
    (reg : RegPackage model)
    (κ : AdviserKernel model)
    (hSupp : KernelSupportedOnRegG model reg.G κ) :
    ∀ᵐ m ∂((MixtureCouplingGammaAlpha κ).map Prod.snd),
      reg.pd.Pγα κ m ∈ reg.B m := by
  -- Step 1: For q-a.e. m, the conditional law (sourceLawγα κ) m is a probability
  --         measure on Belief model.Ω.
  -- Step 2: This conditional law is supported on the closed convex set
  --         reg.B m ⊆ Belief model.Ω (use hSupp + reg.G's relation to B
  --         via source_in_rowwise_bayes_cone or via the v9 setup).
  --         Specifically: KernelSupportedOnRegG ⟹ kernel(s) supported on G(s)
  --         ⟹ for q-a.e. m, sourceLawγα κ m supported on the preimage of m
  --         under inclM ∘ G... need to think about this carefully.
  -- Step 3: The Pγα κ m is the barycenter of the conditional law:
  --         pd.gamma_alpha_conditional_barycenter gives
  --         beliefAsProfile (pd.Pγα κ m) = beliefBarycenter ((sourceLawγα κ) m)
  --         which equals ∫ x ∂(sourceLawγα κ m).
  -- Step 4: Apply generic axiom: barycenter of measure supported in
  --         closed convex reg.B m IS IN reg.B m.
  sorry  -- substantive derivation; substantial work
```

The derivation chain may involve:
- `MeasureTheory.Measure.ae_compProd_iff` to push kernel support through to conditional law support.
- `sourceLawγα_disintegrates` to factor MixtureCouplingGammaAlpha.
- `gamma_alpha_conditional_barycenter` to identify Pγα κ m with the barycenter.
- `reg.B_closed`, `reg.B_convex_profile` for the closed convex hypothesis.
- The crucial substantive step: kernel-supported-on-G ⟹ conditional-law-supported-on-B.
  Reg-2 should give this (the message m's Bayes cone IS where the supported beliefs concentrate).
  Specifically: G(s) is the rowwise minimizer correspondence; conditional law on m given the kernel + α-mixture concentrates on the preimage under inclM ∘ G ∘ inclM⁻¹ of m... 

This is genuinely substantial. The derivation might require an intermediate axiom or careful Mathlib measure-theory work.

# Constraints

- The GENERIC axiom `barycenter_of_supported_measure_in_closed_convex_generic` is added as a new Inventory.V9 axiom (legitimate external — Choquet/Bauer is a real textbook theorem).
- The v9-specific claim becomes a LEMMA `Inventory.V9.bayesian_barycenter_in_closed_convex` (same name, now a lemma not axiom).
- Net axiom count: 8 unchanged + 1 generic = 9 (replacing the old v9-shape).
- If the bridge lemma requires intermediate sub-results that need Mathlib measure theory we don't have, narrow `-- TODO: <specific gap>` sorries are acceptable INSIDE the bridge lemma.
- Build MUST PASS via `lake build MathlibStarter.V9Main` (verify exit code 0, NOT just `lake env lean`).
- Edit only lean/v9_appendix.lean.
- Cap 8 iterations.

# Files

- Edit: `lean/v9_appendix.lean`
- Read-only: `lean/v8_main.lean`

# Verification command (REQUIRED for "build PASS"):

```bash
cat lean/v8_main.lean lean/v9_appendix.lean > lean/main.lean
cp lean/main.lean /c/Users/Public/Documents/Lean/MathlibStarter/MathlibStarter/V9Main.lean
cd /c/Users/Public/Documents/Lean/MathlibStarter
lake build MathlibStarter.V9Main
# Verify exit code 0
```

`lake env lean` is INSUFFICIENT — it bypasses some build-time checks. Always verify via `lake build`.

# Output

Concise report under 500 words: build status (verified via `lake build` exit code 0), axiom count, generic axiom + bridge lemma summary, internal sorries (target 0).
