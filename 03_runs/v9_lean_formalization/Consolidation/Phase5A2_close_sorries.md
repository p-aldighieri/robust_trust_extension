ROLE — Lean 4 / Mathlib prover, PHASE 5A.2 close internal sorries. Opus.

# Mission

Phase 5A introduced the generic Choquet/Bauer barycenter axiom + the bridge lemma. The bridge lemma body has 2 narrow internal sorries (in `Inventory.V9.bayesian_barycenter_in_closed_convex` at ~L3331 and ~L3348). Close them.

# The 2 sorries

## Sorry 1 (~L3331): kernel-support → conditional-law-support transfer

The bridge needs: q-a.e. on `(MixtureCouplingGammaAlpha κ).map Prod.snd`, the conditional law `(sourceLawγα κ) m` is supported on the closed convex set `reg.B m`.

Inputs available:
- `hSupp : KernelSupportedOnRegG model reg.G κ` — kernel supported on G(s) for τM-a.e. s.
- `reg.pd.sourceLawγα_disintegrates` — disintegration identity.
- `reg.source_in_rowwise_bayes_cone : ∀ s m', m' ∈ reg.G s → model.inclM s ∈ reg.B m'` — Reg-2 primitive.
- `MeasureTheory.Measure.ae_compProd_iff` — Mathlib lemma.

Goal: derive `∀ᵐ m ∂((MixtureCouplingGammaAlpha κ).map Prod.snd), (sourceLawγα κ m) (reg.B m)ᶜ = 0`.

Path:
1. `MixtureCouplingGammaAlpha κ = α • MA_aligned ⊗ ... + (1-α) • model.τM ⊗ κ` (look up the definition).
2. The second marginal is `α • MA_aligned.map.snd + (1-α) • (model.τM ⊗ κ).map.snd`.
3. `(model.τM ⊗ κ).map Prod.snd` is the kernel-pushed marginal. For τM-a.e. s, κ.kernel s is supported on G(s); for κ.kernel s-a.e. m ∈ G(s), `inclM s ∈ reg.B m`.
4. Conditional on m, the law `(sourceLawγα κ) m` concentrates the prior measure on the preimage `inclM⁻¹(reg.B m)`. Use `ae_compProd_iff` to push the support condition through.

This is a Mathlib measure-theoretic exercise. If the disintegration is stated in a form where `ae_compProd_iff` directly applies, the proof should be 10-20 lines.

## Sorry 2 (~L3348): pushforward + apply generic axiom

After Sorry 1 gives us "conditional law supported in B(m)", we need to apply the generic Choquet/Bauer axiom to conclude `Pγα κ m ∈ reg.B m`.

Inputs:
- `(sourceLawγα κ) m` is a probability measure on `Belief model.Ω`.
- `reg.B m ⊆ Profile model = model.Ω → ℝ` is a closed convex set.
- Need to relate Belief to Profile: `beliefAsProfile : Belief Ω → Profile model = fun b => fun ω => b.val ω`.
- The bridge: push the law on `Belief Ω` forward to `Profile model` via `beliefAsProfile`.
- `pd.gamma_alpha_conditional_barycenter κ` gives: q-a.e. `beliefBarycenter (sourceLawγα κ m) = beliefAsProfile (Pγα κ m)`, where `beliefBarycenter` is `∫ b, beliefAsProfile b ∂(sourceLawγα κ m)`.
- Apply generic axiom on the pushforward measure: barycenter of measure supported in closed convex set IS in the set.
- `beliefAsProfile '' reg.B m` is closed and convex (since `beliefAsProfile` is linear, reg.B is closed convex per `reg.B_closed`, `reg.B_convex_profile`).
- Therefore `∫ x ∂(pushforward) = beliefBarycenter (sourceLawγα κ m) = beliefAsProfile (Pγα κ m) ∈ beliefAsProfile '' reg.B m`.
- Recover `Pγα κ m ∈ reg.B m` from `beliefAsProfile (Pγα κ m) ∈ beliefAsProfile '' reg.B m` via injectivity of `beliefAsProfile` (or restrict to the simplex).

This requires `Profile model` to be in `[NormedAddCommGroup, NormedSpace ℝ, FiniteDimensional ℝ, MeasurableSpace, BorelSpace]`. Check that these instances are available; if not, derive them.

# Constraints

- Build MUST PASS via `lake build MathlibStarter.V9Main` (exit code 0).
- No new axioms (Inventory.V9 stays at 9).
- No new smuggling.
- ZERO sorries in v9_appendix.lean at end.
- Edit only lean/v9_appendix.lean.
- Cap 8 iterations.

# Output

Concise report under 400 words: build status (exit code), sorry count (target 0), axiom count (9), proof sketches for both sorries.
