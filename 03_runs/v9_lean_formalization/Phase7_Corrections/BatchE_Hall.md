ROLE — Lean 4 / Mathlib prover, Phase 7 Batch E Hall correction. Opus.

# Mission

Phase 6 Batch E: PATCH_NEEDED on Hall biconditional forward direction.

Audit's specific finding (Hall biconditional ~L3968):
> "Forward direction destructs the kernel, but then proves Ψ ≤ 0 mostly from RegPackage structural facts (reg.message_in_bayes_cone, reg.source_in_rowwise_bayes_cone) and support-function inequalities. In effect, it inlines PsiNonpos_of_regPackage, rather than using the calibrated kernel's posterior condition as the core proof."

The paper's §B.5 forward direction:
> "σ(w*) robustly rationalizable ⇔ Ψ_w*(y) ≤ 0. Reverse: construct Borel kernel supported on G(s) with Pγα(·|m) ∈ B(m) q-a.e.; β* = κ is adversarial; continuation Bayes-optimal q-a.e."
> Forward direction in the paper uses the kernel's POSTERIOR CALIBRATION (Pγα κ m ∈ B m q-a.e.), not the Reg-2 primitives.

# Correction

Refactor Hall-biconditional forward direction to:
1. Destructure `reg.robustRationalizableKernelExists` into `⟨κ, hSupp, hCal⟩` where hCal : ∀ᵐ m, Pγα κ m ∈ B m.
2. Use hCal (NOT Reg-2 message_in_bayes_cone) for the support-function bound:
   `Pγα κ m · y ≤ supportFunction (B m) y` q-a.e. on the mixture marginal.
3. Integrate to get Ψ ≤ 0.

The Reg-2 primitives (message_in_bayes_cone, source_in_rowwise_bayes_cone) are still legitimate v9 paper Reg-2 hypotheses (per Phase 5B refactor). But the Hall biconditional's forward direction is the LOGICAL CHAIN from the kernel's calibration, not from Reg-2.

After this fix, `PsiNonpos_of_regPackage` becomes a STANDALONE lemma usable elsewhere (e.g., P-class theorems use it), but the Hall biconditional itself doesn't depend on it.

# Implementation strategy

```lean
theorem «Hall-biconditional» (reg : RegPackage model) :
    reg.robustRationalizableKernelExists ↔ PsiNonpos model reg := by
  refine ⟨?fwd, ?rev⟩
  case fwd =>
    intro hKernel
    rcases hKernel with ⟨κ, hSupp, hCal⟩
    intro y
    unfold regPsi
    -- Use hCal to bound the aligned-message integrand:
    -- ∫ (y · m - h_{B m}(y)) dτM
    -- The kernel's posterior is at the conditional mass: 
    -- on the second marginal of MixtureCouplingGammaAlpha κ, Pγα κ m ∈ B m.
    -- So ⟨Pγα κ m, y(m)⟩ ≤ h_{B m}(y(m)) q-a.e.
    -- For τM-a.e. m, this transfers via the disintegration identity
    -- (sourceLawβ_disintegrates + sourceLawγα_disintegrates).
    sorry  -- if intractable, narrow TODO documenting the kernel-calibration path
  case rev =>
    exact «Hall-G2c-borel-extension» reg
```

Narrow honest sorry acceptable inside the forward direction if the kernel-calibration → Ψ ≤ 0 chain requires substantive Mathlib measure theory. The KEY is that the forward direction depends on hCal, not on the Reg-2 shortcut.

# Constraints

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit 0).
- 9 axioms unchanged (Inventory.V9 stays at 9).
- The reverse direction stays via Hall-G2c-borel-extension.
- The forward direction must use the calibrated kernel's hCal, not bypass it via Reg-2 primitives.
- Narrow TODO sorries acceptable for substantive measure-theoretic gaps.
- NO smuggling (don't reintroduce a hidden shortcut).
- Edit only lean/v9_appendix.lean.
- Cap 6 iterations.

# Output

Concise report under 400 words: build status (exit code), sorry count, axiom count, Hall biconditional forward direction before/after.
