You are the Lean Prover. Close ONE specific `sorry`.

## Target lemma

```lean
theorem posterior_disintegration_menuHall_kernel_coincides
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂MixtureMessageLaw model κ, pd.Pβ κ m = pd.Pγα κ m := by
  sorry
```

(In namespace `RobustTrustV8`. Imports: `import Mathlib`.)

## Relevant definitions

```lean
structure PosteriorDisintegration (model : RobustTrustModel) where
  Pβ : AdviserKernel model → model.M → Belief model.Ω
  Pγα : AdviserKernel model → model.M → Belief model.Ω
  sourceLawβ : AdviserKernel model → Kernel model.M (Belief model.Ω)
  sourceLawγα : AdviserKernel model → Kernel model.M (Belief model.Ω)
  -- ... measurability, Markov, ...
  conditional_barycenter :
    ∀ β, ∀ᵐ m ∂(MixtureMessageLaw model β),
      beliefBarycenter ((sourceLawβ β) m) = beliefAsProfile (Pβ β m)
  gamma_alpha_conditional_barycenter :
    ∀ κ, ∀ᵐ m ∂((MixtureCouplingGammaAlpha model κ).map Prod.snd),
        beliefBarycenter ((sourceLawγα κ) m) = beliefAsProfile (Pγα κ m)
  -- KEY: real disintegration identities (added in pass-3 patch)
  sourceLawβ_disintegrates :
    ∀ β, (MixtureCouplingGammaAlpha model β).map
        (fun p : model.M × model.M => (p.2, model.inclM p.1)) =
      (MixtureMessageLaw model β).compProd (sourceLawβ β)
  sourceLawγα_disintegrates :
    ∀ κ, (MixtureCouplingGammaAlpha model κ).map
        (fun p : model.M × model.M => (p.2, model.inclM p.1)) =
      ((MixtureCouplingGammaAlpha model κ).map Prod.snd).compProd
        (sourceLawγα κ)

structure MenuHall (model : RobustTrustModel)
    (pd : PosteriorDisintegration model) ... where
  ...
  q : Measure model.M
  q_eq_qκ : q = MixtureMessageLaw model κ
  q_eq_gamma_second : q = (MixtureCouplingGammaAlpha model κ).map Prod.snd
  ...
```

## Math

Both `sourceLawβ κ` and `sourceLawγα κ` disintegrate the same swapped coupling (the v8 patch). Specifically:
- `(γα κ).map swap = (MixtureMessageLaw κ).compProd (sourceLawβ κ)` (from `sourceLawβ_disintegrates`)
- `(γα κ).map swap = ((γα κ).map snd).compProd (sourceLawγα κ)` = `(MixtureMessageLaw κ).compProd (sourceLawγα κ)` (from `sourceLawγα_disintegrates` + `mh.q_eq_gamma_second` + `mh.q_eq_qκ`)

By uniqueness of disintegration (a.e.), `sourceLawβ κ m = sourceLawγα κ m` for `MixtureMessageLaw`-a.e. m.

Then `beliefBarycenter (sourceLawβ κ m) = beliefAsProfile (Pβ κ m)` (from conditional_barycenter, MixtureMessageLaw-a.e.) and `beliefBarycenter (sourceLawγα κ m) = beliefAsProfile (Pγα κ m)` (from gamma_alpha_conditional_barycenter at MixtureMessageLaw, via mh.q_eq_qκ + mh.q_eq_gamma_second).

Combining: `beliefAsProfile (Pβ κ m) = beliefAsProfile (Pγα κ m)` a.e. Since `beliefAsProfile` is injective (it's just `.val`), `Pβ κ m = Pγα κ m` a.e.

## Suggested Mathlib API

- `MeasureTheory.Measure.compProd_eq_compProd_iff_kernel_eq_ae` (or similar — uniqueness of disintegration)
- `Filter.EventuallyEq` for a.e. equality
- `MeasureTheory.AEEqOfIntegral` lemmas

## Output

```lean_proof
target_lemma_slug: posterior_disintegration_menuHall_kernel_coincides
status: PROVED | STUCK
tactics_used: [...]
proof_length_lines: <int>
introduces_have_clauses: <int>
```

```lean
theorem posterior_disintegration_menuHall_kernel_coincides
    (model : RobustTrustModel)
    (pd : PosteriorDisintegration model)
    (σstar : AgentStrategyFull model)
    (ec : ExactContact model σstar)
    (κ : AdviserKernel model)
    (mh : MenuHall model pd σstar ec κ) :
    ∀ᵐ m ∂MixtureMessageLaw model κ, pd.Pβ κ m = pd.Pγα κ m := by
  -- your proof
  sorry
```

If you hit a missing API call you can't resolve, return STUCK with the specific obstruction. This proof is genuinely non-trivial (uniqueness of disintegration); a STUCK with a clear blocker is OK.
