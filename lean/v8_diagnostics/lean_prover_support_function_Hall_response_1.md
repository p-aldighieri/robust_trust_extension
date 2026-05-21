
========
ROLE: user (id=cd5686a8-7c6e-4a0e-bd03-cef79cd70fc7)
========
You are the Lean Prover. Close ONE specific sorry — an iff between posterior calibration and Hall inequalities (essentially Hahn-Banach in integral form).

## Target (in namespace RobustTrustV8, import Mathlib)


lean
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


## Definitions


lean
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


## Math sketch

### (⇒) Calibration → Hall

For ∀ᵐ m ∂q, P m ∈ B m:
- For each ℓ : ℓ (P m) ≤ sSup (ℓ '' B m) a.e. m (since P m ∈ B m, ℓ(P m) is in the image).
- For any E with q E ≠ 0, integrate: ∫_E ℓ(P m) ∂q ≤ ∫_E sSup (ℓ '' B m) ∂q.
- Apply MeasureTheory.setIntegral_mono_ae (or integral_mono_ae restricted).

### (⇐) Hall → Calibration

Contrapositive. Suppose calibration fails: q {m | P m ∉ B m} > 0. By Hahn-Banach in finite-dim (Profile model is model.Ω → ℝ finite-dim):
- For each m with P m ∉ B m, ∃ ℓ_m separating: ℓ_m (P m) > sSup (ℓ_m '' B m).
- Need a MEASURABLE selection of separators (essentially a measurable Hahn-Banach).
- Then for some E ⊆ {m | P m ∉ B m} with q E > 0 and some ℓ, ∫_E ℓ (P m) > ∫_E sSup (ℓ '' B m).

The measurable Hahn-Banach selection is the substantive measure-theoretic content. May not have clean Mathlib API.

**Alternative approach (cleaner)**: Use countable-dense subset of dual.

For finite-dim Profile model = model.Ω → ℝ, the dual is also finite-dim. The unit sphere of the dual is compact. By separability, ∃ countable dense {ℓ_n} ⊆ dual unit sphere. The set {m | P m ∉ B m} equals (by Hahn-Banach + density):
⋃_n {m | ℓ_n (P m) > sSup (ℓ_n '' B m)} (modulo strict inequality vs. ≤). Each set is measurable. If their union has positive q-measure, at least one has positive measure, giving a counterexample to Hall.

Hmm — this still needs the separating ℓ to come from a countable dense set, which is fine in finite dim.

## Strategy

The (⇒) direction is straightforward via integral monotonicity.

The (⇐) direction is the harder Hahn-Banach + measurable selection argument. If too involved, you may **prove only (⇒) and STUCK on (⇐)** with the precise gap.

Or splice an Iff proof with sorry on one side:

lean
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


This gives PARTIAL progress — one direction proved + one direction sorried.

## Output


lean_proof
target_lemma_slug: support_function_integrated_Hall_equivalence
status: PROVED | PARTIAL | STUCK
tactics_used: [...]



lean
theorem support_function_integrated_Hall_equivalence ... := by
  -- your proof (may be PARTIAL with sorry for ⇐)


PARTIAL is acceptable — even just the (⇒) direction is substantive content. Aim for 60-150 lines.

Show more

========
ROLE: assistant (id=8b8a977b-78c2-40ca-93e4-913c1b75a0ac)
========
lean_proof
target_lemma_slug: support_function_integrated_Hall_equivalence
status: PARTIAL
tactics_used: [constructor, intro, refine, filter_upwards, setIntegral_mono_ae, le_csSup, Bornology.IsBounded.image, Bornology.IsBounded.bddAbove]

The forward direction is closed. The remaining sorry is exactly the measurable Hahn-Banach/countable-dual-density step for the reverse direction.

lean
import Mathlib

open MeasureTheory
open Set

namespace RobustTrustV8

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
    (hsupp_meas : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Measurable fun m => sSup (ℓ '' B m))
    (hsupp_int : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Integrable (fun m => sSup (ℓ '' B m)) q)
    (hP_int : ∀ ℓ : Profile model →L[ℝ] ℝ,
        Integrable (fun m => ℓ (P m)) q) :
    PosteriorCalibrationProfiles model q B P ↔
      SupportFunctionHallInequalities model q B P := by
  constructor
  · intro hCalib
    intro E hE_meas hE_pos ℓ

    -- Global integrability implies integrability over every restricted set.
    have hP_int_E :
        IntegrableOn (fun m => ℓ (P m)) E q :=
      (hP_int ℓ).integrableOn
    have hsupp_int_E :
        IntegrableOn (fun m => sSup (ℓ '' B m)) E q :=
      (hsupp_int ℓ).integrableOn

    -- Pointwise support-function domination on the calibration event.
    have hpoint :
        (fun m => ℓ (P m)) ≤ᶠ[ae q]
          fun m => sSup (ℓ '' B m) := by
      filter_upwards [hCalib] with m hm

      -- Since `P m ∈ B m`, its ℓ-value is an element of the support set.
      have hmem : ℓ (P m) ∈ ℓ '' B m := by
        exact ⟨P m, hm, rfl⟩

      -- A continuous linear map sends bounded sets to bounded sets; in ℝ,
      -- bornology-bounded sets are order-bounded above.
      have hbdd_image : Bornology.IsBounded (ℓ '' B m) := by
        exact Bornology.IsBounded.image ℓ (hB_bounded m)
      have hbdd_above : BddAbove (ℓ '' B m) := by
        exact hbdd_image.bddAbove

      -- Any member of a bounded-above real set is at most its `sSup`.
      exact le_csSup hbdd_above hmem

    -- Integrate the a.e. pointwise inequality over `E`.
    exact MeasureTheory.setIntegral_mono_ae hP_int_E hsupp_int_E hpoint

  · intro hHall
    classical

    /-
      Remaining gap: Hall inequalities → posterior calibration.

      Mathematical route:
      1. For each fixed continuous linear functional `ℓ`, use the Hall
         inequalities on measurable positive-measure sets to show
           ℓ (P m) ≤ sSup (ℓ '' B m)
         for q-a.e. `m`.

      2. Upgrade from “for each fixed ℓ, a.e.” to “for q-a.e. m, for all ℓ”.
         Since `Profile model` is finite-dimensional, choose a countable dense
         subset of the dual unit sphere, intersect the corresponding full-measure
         sets, and use continuity of
           ℓ ↦ ℓ (P m)
         and
           ℓ ↦ sSup (ℓ '' B m)
         on bounded closed convex fibers.

      3. For a remaining bad point with `P m ∉ B m`, use finite-dimensional
         Hahn-Banach separation for the closed convex set `B m` to find `ℓ`
         with
           ℓ (P m) > sSup (ℓ '' B m),
         then approximate `ℓ` by the countable dense family to contradict
         the pointwise inequalities.

      This is the substantive measurable Hahn-Banach / separability step.
    -/
    sorry

end RobustTrustV8
