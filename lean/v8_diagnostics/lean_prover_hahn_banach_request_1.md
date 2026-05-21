You are the Lean Prover. Close ONE specific sorry: `support_function_integrated_Hall_equivalence` ⇐ direction (line 4675 of main.lean).

## Target — only the ⇐ direction inside the iff

```lean
theorem support_function_integrated_Hall_equivalence
    (model : RobustTrustModel)
    (q : Measure model.M) [IsFiniteMeasure q]
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model)
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : model.M × Profile model | p.2 ∈ B p.1})
    (hsupp_meas : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Integrable (fun m => ℓ (P m)) q) :
    PosteriorCalibrationProfiles model q B P ↔
      SupportFunctionHallInequalities model q B P := by
  constructor
  · ...  -- ⇒ direction already PROVED (uses csSup_le + integrals)
  · intro hHall
    classical
    sorry  -- TARGET ⇐ direction
```

Where:
- `PosteriorCalibrationProfiles model q B P := ∀ᵐ m ∂q, P m ∈ B m`
- `SupportFunctionHallInequalities model q B P := ∀ E measurable, q E ≠ 0 → ∀ ℓ, ∫_E ℓ(P m) ≤ ∫_E sSup (ℓ '' B m)`

(Actually, please check the exact definitions in the file if needed — they're around line 4500.)

## Math sketch

This is the substantive Hahn-Banach direction:

1. **Use Hall inequalities pointwise per ℓ**: For each fixed continuous linear functional ℓ
   on Profile model (= Ω → ℝ, finite-dim), Hall says ∀ E (positive measure),
   ∫_E ℓ(P m) dq ≤ ∫_E sSup (ℓ '' B m) dq. By radon-nikodym / Lebesgue differentiation
   on positive measure sets, derive: ∀ᵐ m ∂q, ℓ(P m) ≤ sSup (ℓ '' B m).

2. **Upgrade "for each ℓ, a.e." to "a.e., for all ℓ"**: Profile model = (Ω → ℝ) with Ω finite,
   so Profile model is finite-dimensional ℝ^n. Its dual (Profile model →L[ℝ] ℝ) is also
   finite-dim, hence separable. Pick a countable dense subset {ℓ_n} of the dual unit sphere.
   For each ℓ_n, get full-measure set S_n where ℓ_n(P m) ≤ sSup (ℓ_n '' B m).
   Intersect: S := ⋂_n S_n has full measure (countable intersection).

3. **Conclude P m ∈ B m a.e.**: For m ∈ S, suppose P m ∉ B m. By closed-convex hull + 
   finite-dim Hahn-Banach (geometric_hahn_banach_closed_point or similar), ∃ continuous
   linear ℓ with ℓ(P m) > sSup (ℓ '' B m). By continuity of ℓ ↦ ℓ(P m) and ℓ ↦ sSup (ℓ '' B m)
   (on bounded closed convex B m, both continuous on dual norm), approximate ℓ by some ℓ_n
   close enough that ℓ_n(P m) > sSup (ℓ_n '' B m) — contradicting m ∈ S_n. Hence P m ∈ B m.

## Mathlib lemmas you may need

- `geometric_hahn_banach_closed_point` or `inner_le_iff` for closed convex separation
- `Metric.dense_iff_iUnion_ball` for countable dense set
- `Module.Finite.finiteDimensional` for finite-dim Profile
- `MeasureTheory.ae_iff` for the upgrade
- `MeasureTheory.ae_of_forall_measure_lt_top_ae` (or whatever the precise name is)

If any of these aren't directly available in Lean 4.29 Mathlib, identify substitutes or
declare STUCK at that point with the precise missing lemma.

## Substantive challenge

This proof has several deep components:
- Step 1 requires careful Radon-Nikodym / Lebesgue point argument.
- Step 2 requires explicit countable dense construction in finite-dim dual.
- Step 3 requires Hahn-Banach + continuity-of-sup-functional argument.

If genuinely intractable in one Pro pass, declare STUCK with a precise diagnostic of
which step is the blocker.

## Output

```
lean_proof
target_lemma_slug: support_function_integrated_Hall_equivalence_mpr
status: PROVED | STUCK
tactics_used: [...]
```

```lean
-- Just provide the ⇐ direction body (the `intro hHall; classical; ...` part)
intro hHall
classical
-- your proof
```

Aim 150-500 lines. If STUCK, clearly identify the step where you stalled and what Mathlib
infrastructure is missing.
