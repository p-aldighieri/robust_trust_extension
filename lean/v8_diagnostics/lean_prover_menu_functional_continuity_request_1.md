You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem menu_functional_continuity
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    Continuous (MenuFunctionalF model) := by
  sorry
```

## Available proved lemma (use freely)

```lean
theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D
```

(NOTE: the actual proof of menu_extrema_Hausdorff_Lipschitz returns L = 1.)

## Relevant definitions

```lean
noncomputable def maxPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def minPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sInf ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def MenuFunctionalF (model : RobustTrustModel)
    (C : CompactMenu model) : ℝ :=
  ∫ s, model.α * maxPayoff model C s +
    (1 - model.α) * minPayoff model C s ∂model.τM
```

Constraints from `RobustTrustModel`:
- `model.α : ℝ` with `model.α_nonneg : 0 ≤ model.α` and `model.α_le_one : model.α ≤ 1`
- `model.τM : Measure model.M` with `model.τM_prob : IsProbabilityMeasure model.τM`

## Math sketch

Show `F` is `L`-Lipschitz (hence continuous) using `menu_extrema_Hausdorff_Lipschitz`:

`|F(C) - F(D)| = |∫ s, [α (max C s - max D s) + (1-α)(min C s - min D s)] dτM|`
` ≤ ∫ s, α |max C s - max D s| + (1-α) |min C s - min D s| dτM`
` ≤ ∫ s, α * L * dist C D + (1-α) * L * dist C D dτM`   (by menu_extrema_Hausdorff_Lipschitz, both bounds)
` = L * dist C D * (α + (1-α)) * τM(univ)`
` = L * dist C D * τM(univ)`
` = L * dist C D`   (since τM is a probability measure)

Hence `F` is `L`-Lipschitz, so continuous.

Note that `α, 1-α ≥ 0` (from model.α_nonneg and model.α_le_one), so the integrand bounds work out.

## Lean strategy

Probably cleanest:
```lean
theorem menu_functional_continuity ... := by
  obtain ⟨L, hL_nn, hL⟩ := menu_extrema_Hausdorff_Lipschitz model
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  refine LipschitzWith.continuous (K := L.toNNReal) ?_
  intro C D
  -- |F(C) - F(D)| ≤ L * dist C D
  -- Equivalently: dist (F C) (F D) ≤ L.toNNReal * dist C D
  -- Use real-dist = abs
  rw [Real.dist_eq, dist_nndist]
  ...
```

Or simpler: prove a Lipschitz inequality directly and conclude via `LipschitzWith.continuous` or just `Metric.continuous_iff`-style.

Key Mathlib tools needed:
- `MeasureTheory.integral_sub` (for splitting |F(C) - F(D)|)
- `MeasureTheory.abs_integral_le_integral_abs`
- `MeasureTheory.integral_const` or `IsProbabilityMeasure.measure_univ`
- `MeasureTheory.integral_mono_of_nonneg` for nonneg dominated integrands
- `LipschitzWith.continuous`

Or alternatively use `Continuous` directly via `Metric.continuous_iff`:
For all ε > 0, ∃ δ > 0 with dist C D < δ → |F(C) - F(D)| < ε. Take δ := ε / (L + 1).

Both maxPayoff and minPayoff are MEASURABLE in s (since beliefDot is continuous in (s, w) and sSup/sInf preserves measurability). For Integrable, since `s ↦ maxPayoff C s` is BOUNDED (by something like ‖inclM s‖ * max-norm of w ∈ C, which is uniformly bounded since C compact), it's integrable on the probability measure τM. So `Integrable (α maxPayoff C ·) τM` and `Integrable ((1-α) minPayoff C ·) τM`, hence `Integrable (α maxPayoff C · + (1-α) minPayoff C ·) τM`. Then `MeasureTheory.integral_sub` applies.

But this gets into a lot of integrability bookkeeping. Try to keep the proof clean.

## Output

```
lean_proof
target_lemma_slug: menu_functional_continuity
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem menu_functional_continuity ... := by
  -- your proof
```

Aim for 60-120 lines. If integrability bookkeeping makes the proof huge, state STUCK with specific gaps. If you can prove pointwise Lipschitz of F (using `menu_extrema_Hausdorff_Lipschitz`), do so even without exhibiting a global Lipschitz constant — just `Continuous (MenuFunctionalF model)` suffices.

You may freely add private helper lemmas if useful.
