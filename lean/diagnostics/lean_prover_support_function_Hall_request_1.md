You are the Lean Prover. Close ONE specific sorry — an iff between posterior calibration and Hall inequalities (essentially Hahn-Banach in integral form).

## Target (in namespace RobustTrustV8, import Mathlib)

```lean
theorem support_function_integrated_Hall_equivalence
    (model : RobustTrustModel)
    (q : Measure model.M)
    [IsFiniteMeasure q]
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model)
    (hP_meas : Measurable P)
    (hB_closed : ∀ m, IsClosed (B m))
    (hB_convex : ∀ m, Convex ℝ (B m))
    (hB_nonempty : ∀ m, (B m).Nonempty)
    (hB_bounded : ∀ m, Bornology.IsBounded (B m))
    (hB_meas_graph : MeasurableSet {p : model.M × Profile model | p.2 ∈ B p.1})
    (hsupp_meas : ∀ ℓ : Profile model →L[ℝ] ℝ, Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : Profile model →L[ℝ] ℝ, Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : Profile model →L[ℝ] ℝ, Integrable (fun m => ℓ (P m)) q) :
    PosteriorCalibrationProfiles model q B P ↔
      SupportFunctionHallInequalities model q B P := by
  sorry
```

## Definitions

```lean
def PosteriorCalibrationProfiles (model : RobustTrustModel)
    (q : Measure model.M)
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model) : Prop :=
  ∀ᵐ m ∂q, P m ∈ B m

def SupportFunctionHallInequalities (model : RobustTrustModel)
    (q : Measure model.M)
    (B : model.M → Set (Profile model))
    (P : model.M → Profile model) : Prop :=
  ∀ E : Set model.M, MeasurableSet E → q E ≠ 0 →
    ∀ ℓ : Profile model →L[ℝ] ℝ,
      ∫ m in E, ℓ (P m) ∂q ≤ ∫ m in E, sSup (ℓ '' B m) ∂q
```

## Math sketch

### (⇒) Calibration → Hall

For `∀ᵐ m ∂q, P m ∈ B m`:
- For each ℓ : `ℓ (P m) ≤ sSup (ℓ '' B m)` a.e. m (since P m ∈ B m, ℓ(P m) is in the image).
- For any E with q E ≠ 0, integrate: `∫_E ℓ(P m) ∂q ≤ ∫_E sSup (ℓ '' B m) ∂q`.
- Apply `MeasureTheory.setIntegral_mono_ae` (or `integral_mono_ae` restricted).

### (⇐) Hall → Calibration

Contrapositive. Suppose calibration fails: `q {m | P m ∉ B m} > 0`. By Hahn-Banach in finite-dim (Profile model is `model.Ω → ℝ` finite-dim):
- For each m with P m ∉ B m, ∃ ℓ_m separating: `ℓ_m (P m) > sSup (ℓ_m '' B m)`.
- Need a MEASURABLE selection of separators (essentially a measurable Hahn-Banach).
- Then for some E ⊆ {m | P m ∉ B m} with q E > 0 and some ℓ, `∫_E ℓ (P m) > ∫_E sSup (ℓ '' B m)`.

The measurable Hahn-Banach selection is the substantive measure-theoretic content. May not have clean Mathlib API.

**Alternative approach (cleaner)**: Use countable-dense subset of dual.

For finite-dim Profile model = model.Ω → ℝ, the dual is also finite-dim. The unit sphere of the dual is compact. By separability, ∃ countable dense {ℓ_n} ⊆ dual unit sphere. The set `{m | P m ∉ B m}` equals (by Hahn-Banach + density):
`⋃_n {m | ℓ_n (P m) > sSup (ℓ_n '' B m)}` (modulo strict inequality vs. ≤). Each set is measurable. If their union has positive q-measure, at least one has positive measure, giving a counterexample to Hall.

Hmm — this still needs the separating ℓ to come from a countable dense set, which is fine in finite dim.

## Strategy

The (⇒) direction is straightforward via integral monotonicity.

The (⇐) direction is the harder Hahn-Banach + measurable selection argument. If too involved, you may **prove only (⇒) and STUCK on (⇐)** with the precise gap.

Or splice an `Iff` proof with sorry on one side:
```lean
refine ⟨?_, ?_⟩
· -- ⇒ direction: PROVED
  intro hCalib E hE_meas hE_pos ℓ
  refine setIntegral_mono_ae (hP_int ℓ).restrict (hsupp_int ℓ).restrict ?_
  filter_upwards [hCalib] with m hm
  have hP_in_B : P m ∈ B m := hm
  -- ℓ (P m) ≤ sSup (ℓ '' B m) since P m ∈ B m
  exact le_csSup (IsCompact.bddAbove ⟨B m, ...⟩) ⟨P m, hP_in_B, rfl⟩
· -- ⇐ direction: STUCK
  sorry
```

This gives PARTIAL progress — one direction proved + one direction sorried.

## Output

```
lean_proof
target_lemma_slug: support_function_integrated_Hall_equivalence
status: PROVED | PARTIAL | STUCK
tactics_used: [...]
```

```lean
theorem support_function_integrated_Hall_equivalence ... := by
  -- your proof (may be PARTIAL with sorry for ⇐)
```

PARTIAL is acceptable — even just the (⇒) direction is substantive content. Aim for 60-150 lines.
