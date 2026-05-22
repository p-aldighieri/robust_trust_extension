You are the Lean Prover. This is PASS 3 — your previous attempt failed AXLE check.

## Previous failures

Your v1: `Kernel.ae_eq_of_compProd_eq` couldn't find `IsFiniteMeasure (MixtureMessageLaw model κ)`.

Your v2: Added `haveI : IsFiniteMeasure (MixtureMessageLaw model κ) := by unfold MixtureMessageLaw; infer_instance`. STILL failed:

```
error(lean.synthInstanceFailed): failed to synthesize instance of type class
  IsFiniteMeasure
    (ENNReal.ofReal model.α • model.τM + ENNReal.ofReal (1 - model.α) • Measure.map Prod.snd (model.τM ⊗ₘ κ.kernel))
```

`infer_instance` after unfolding cannot synthesize the finite measure instance for the unfolded sum-of-scaled measures. Need explicit construction.

## Fix needed for v3

Build IsFiniteMeasure explicitly:

```lean
haveI : IsFiniteMeasure (MixtureMessageLaw model κ) := by
  unfold MixtureMessageLaw
  -- Each summand is a finite measure:
  -- ENNReal.ofReal α • τM : finite if τM is finite + α ofReal is finite (which it is, α≤1)
  -- ENNReal.ofReal (1-α) • (τM ⊗ₘ κ).map Prod.snd : same
  have h1 : IsFiniteMeasure ((ENNReal.ofReal model.α) • model.τM) := by
    apply MeasureTheory.IsFiniteMeasure.smul_of_lt_top  -- or similar
    exact ENNReal.ofReal_lt_top
  have h2 : IsFiniteMeasure
      ((ENNReal.ofReal (1 - model.α)) • ((model.τM.compProd κ.kernel).map Prod.snd)) := by
    haveI : IsFiniteMeasure (model.τM.compProd κ.kernel) := inferInstance
    haveI : IsFiniteMeasure ((model.τM.compProd κ.kernel).map Prod.snd) :=
      MeasureTheory.IsFiniteMeasure.map _ measurable_snd
    apply MeasureTheory.IsFiniteMeasure.smul_of_lt_top
    exact ENNReal.ofReal_lt_top
  exact MeasureTheory.IsFiniteMeasure.add h1.toIsFiniteMeasure h2.toIsFiniteMeasure
```

(adjust to actual Mathlib4 API). If those exact names don't exist, search for the correct ones. The key idea: each summand is finite, sum of finite measures is finite.

Alternative: use `Measure.add.isFiniteMeasure` from `MeasureTheory.Measure.Add`. Or instance synthesis with extra hints.

If you can't get IsFiniteMeasure to work, STUCK with the API trace.

## Output

```lean_proof
target_lemma_slug: posterior_disintegration_menuHall_kernel_coincides
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem posterior_disintegration_menuHall_kernel_coincides ... := by
  ...
```
