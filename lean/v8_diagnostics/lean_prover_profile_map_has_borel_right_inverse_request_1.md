You are the Lean Prover. Close ONE specific `sorry`.

## Target lemma

```lean
theorem profile_map_has_borel_right_inverse
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    ∃ R : ProfileInW model → model.PrivateStrategy,
      Measurable R ∧
        ∀ w : ProfileInW model, model.profileOfPrivate (R w) = w.val := by
  sorry
```

(In `namespace RobustTrustV8`, `import Mathlib`.)

## Relevant context

```lean
abbrev Profile (model : RobustTrustModel) : Type := model.Ω → ℝ
def PayoffProfileSet (model : RobustTrustModel) : Set (Profile model) :=
  Set.range model.profileOfPrivate
abbrev ProfileInW (model : RobustTrustModel) : Type :=
  {w : Profile model // w ∈ PayoffProfileSet model}

structure ProfileRealizationSetup (model : RobustTrustModel) where
  Φ : model.PrivateStrategy → Profile model
  Φ_eq_profile : Φ = model.profileOfPrivate
  Φ_continuous : Continuous Φ
  W_compact : IsCompact (PayoffProfileSet model)
  W_convex : Convex ℝ (PayoffProfileSet model)
  Φ_surjective_onto_W :
    ∀ w : Profile model, w ∈ PayoffProfileSet model → ∃ σ, Φ σ = w
  fibers_compact : ∀ w : Profile model, IsCompact (Φ ⁻¹' {w})
  fibers_nonempty : ∀ w : Profile model, w ∈ PayoffProfileSet model →
    (Φ ⁻¹' {w}).Nonempty

namespace Inventory
theorem krn_borel_right_inverse
    {X Y : Type*}
    [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X] [StandardBorelSpace X]
    [TopologicalSpace Y] [MeasurableSpace Y] [BorelSpace Y] [StandardBorelSpace Y]
    [CompactSpace X]
    (Φ : X → Y)
    (hΦ_cont : Continuous Φ)
    (hΦ_surj : Function.Surjective Φ)
    (hfib_compact : ∀ y, IsCompact (Φ ⁻¹' {y}))
    (hfib_ne : ∀ y, (Φ ⁻¹' {y}).Nonempty) :
    ∃ R : Y → X, Measurable R ∧ ∀ y, Φ (R y) = y := sorry
end Inventory
```

`model.PrivateStrategy` has typeclass instances: `TopologicalSpace`, `CompactSpace`, `MeasurableSpace`, `BorelSpace`, `StandardBorelSpace`, `Nonempty` (via `attribute [instance] RobustTrustModel.PrivateStrategy_*` declarations after the model structure).

## Math

We want a Borel right inverse for `Φ : PrivateStrategy → Profile` restricted to `ProfileInW` (the subtype mapping into PayoffProfileSet).

Strategy: Apply `Inventory.krn_borel_right_inverse` with `X = PrivateStrategy`, `Y = ProfileInW`. Need to construct `Φ' : PrivateStrategy → ProfileInW` (using prs.Φ + the fact that prs.Φ's range is PayoffProfileSet), then verify continuity, surjectivity, compact-nonempty fibers.

The PrivateStrategy → ProfileInW map: σ ↦ ⟨prs.Φ σ, ⟨σ, rfl⟩⟩ if Φ_eq_profile is used. Or use `model.profileOfPrivate σ` directly: σ ↦ ⟨profileOfPrivate σ, ⟨σ, rfl⟩⟩.

Then apply Inventory.krn_borel_right_inverse to this Φ'. The fibers of Φ' over w : ProfileInW are the same as fibers of profileOfPrivate over w.val, which is the same as `Φ ⁻¹' {w.val}` (using Φ_eq_profile). prs.fibers_compact, fibers_nonempty give the needed properties.

ProfileInW needs `TopologicalSpace`, `MeasurableSpace`, `BorelSpace`, `StandardBorelSpace` instances. These mostly auto-derive from `Profile model = model.Ω → ℝ` (pi types on Fintype Ω).

If the typeclass plumbing for ProfileInW is brittle, return STUCK with the missing instance.

## Output

```lean_proof
target_lemma_slug: profile_map_has_borel_right_inverse
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem profile_map_has_borel_right_inverse
    (model : RobustTrustModel)
    (prs : ProfileRealizationSetup model) :
    ∃ R : ProfileInW model → model.PrivateStrategy,
      Measurable R ∧
        ∀ w : ProfileInW model, model.profileOfPrivate (R w) = w.val := by
  -- your proof
  sorry
```
