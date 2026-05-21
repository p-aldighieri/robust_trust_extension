You are the Lean Prover. Close ONE specific `sorry`.

## Target lemma + context (in `namespace RobustTrustV8`, `import Mathlib`)

```lean
structure AlignedBestLabelingWstar (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) where
  wstar : model.M → ProfileInW model
  measurable_wstar : Measurable wstar
  mem_Cstar : ∀ m : model.M, wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))
  is_argmax :
    ∀ m : model.M,
      IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
        (↑opt.Cstar : Set (ProfileInW model)) (wstar m)

theorem aligned_best_labeling_selection
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model) :
    ∃ wlabel : AlignedBestLabelingWstar model opt,
      (∀ m : model.M, wlabel.wstar m ∈ (↑opt.Cstar : Set (ProfileInW model))) ∧
        (∀ m : model.M,
          IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
            (↑opt.Cstar : Set (ProfileInW model)) (wlabel.wstar m)) := by
  sorry
```

The conclusion is just `mem_Cstar + is_argmax` extracted twice. So if we can construct an `AlignedBestLabelingWstar`, the conclusion follows trivially via `⟨wlabel, wlabel.mem_Cstar, wlabel.is_argmax⟩`.

## How to construct `AlignedBestLabelingWstar`

Need `wstar : M → ProfileInW` that is measurable AND IsMaxOn over `opt.Cstar` (a NonemptyCompacts).

Apply `Inventory.measurable_argmax_selector`:

```lean
theorem Inventory.measurable_argmax_selector
    {X Y : Type*}
    [MeasurableSpace X] [TopologicalSpace Y] [MeasurableSpace Y]
    [CompactSpace Y] [Nonempty Y]
    {Γ : X → Set Y} {f : X → Y → ℝ}
    (hΓ_meas : MeasurableSet {p : X × Y | p.2 ∈ Γ p.1})
    (hΓ_ne : ∀ x, (Γ x).Nonempty)
    (hΓ_compact : ∀ x, IsCompact (Γ x))
    (hf_meas : Measurable fun p : X × Y => f p.1 p.2)
    (hf_cont : ∀ x, ContinuousOn (fun y => f x y) (Γ x)) :
    ∃ sel : X → Y, Measurable sel ∧
      ∀ x, sel x ∈ Γ x ∧ IsMaxOn (fun y => f x y) (Γ x) (sel x)
```

Set X = model.M, Y = ProfileInW model, Γ = constant `(↑opt.Cstar : Set (ProfileInW model))`, f x y = beliefDot (model.inclM x) y.val.

Difficulty: instances on ProfileInW (CompactSpace, Nonempty), measurable graph (Γ is constant so the graph is `univ ×ˢ (↑opt.Cstar)`, measurable from `MeasurableSet ↑opt.Cstar`).

If you hit ProfileInW typeclass issues, return STUCK with the specific missing instance.

## Output

```lean_proof
target_lemma_slug: aligned_best_labeling_selection
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem aligned_best_labeling_selection ... := by
  -- your proof
  sorry
```
