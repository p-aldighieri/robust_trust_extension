
========
ROLE: user (id=f86e1cf3-4998-4929-bd31-46a9720ed208)
========
You are the Lean Prover. This is PASS 2 — your previous attempt was STUCK at integrability bookkeeping.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem menu_functional_continuity
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    Continuous (MenuFunctionalF model) := by
  sorry


## Pass-1 status

You completed the pointwise estimate:
|(α maxPayoff C s + (1-α) minPayoff C s) - (α maxPayoff D s + (1-α) minPayoff D s)| ≤ L * dist C D

This is the "math heart". You then noted the missing piece: integrability of fun s => α * maxPayoff C s + (1-α) * minPayoff C s against model.τM.

## Integrability strategy (use this for pass 2)

The integrand is **bounded** and **measurable**, hence integrable on the finite measure model.τM.

### Boundedness

Recall:
- model.inclM s : Belief model.Ω, so each coordinate is in [0, 1] and sums to 1.
- w : ProfileInW model, so w.val : model.Ω → ℝ with w.val ∈ PayoffProfileSet model = Set.range model.profileOfPrivate.
- beliefDot (inclM s) w.val = ∑_ω (inclM s).val ω * w.val ω.

Since C is compact and w ↦ ‖w.val‖_∞ is continuous (or at least bounded), there's a constant M_C with |w.val ω| ≤ M_C for all w ∈ C and ω. Then |beliefDot (inclM s) w.val| ≤ M_C * (∑_ω (inclM s).val ω) = M_C * 1 = M_C.

So |maxPayoff C s| ≤ M_C and |minPayoff C s| ≤ M_C uniformly in s. Hence the integrand is bounded by |α| * M_C + |1-α| * M_C = M_C (since 0 ≤ α ≤ 1).

**Establishing M_C**: Since C : NonemptyCompacts (ProfileInW model), the underlying set ↑C is a compact subset of ProfileInW model, which is itself bounded (within PayoffProfileSet which is compact by prs.W_compact). So ‖w.val‖_∞ ≤ some constant for all w ∈ C. You can express this via IsCompact.bddAbove_image or similar.

Actually a SIMPLER bound: |beliefDot (inclM s) w.val| ≤ sup_{w ∈ ↑C} sup_ω |w.val ω|. For C compact, this is finite.

### Measurability of s ↦ maxPayoff C s

This needs s ↦ sSup ((fun w => beliefDot (inclM s) w.val) '' ↑C) to be measurable.

This is a "support function" type measurability. There may be a direct Mathlib lemma. Alternatively:

For each w : ProfileInW model, s ↦ beliefDot (inclM s) w.val is measurable (composition of inclM_measurable with the linear functional μ ↦ ∑_ω μ.val ω * w.val ω, which is Borel since it's a polynomial in the coords).

sSup over compact set is measurable when the map (s, w) ↦ f s w is measurable in (s, w) jointly and C has compact sections (which it does). Mathlib has Measurable.sSup_image_compact or similar.

Worst case, you can bound maxPayoff C s by a measurable function using:
- For each fixed s, the sup is attained (C compact + f continuous in w → attained max).
- The "argmax" selector is measurable (via Inventory.measurable_argmax_selector applied with f).

But the cleanest: just use Continuous.measurable if you can show s ↦ maxPayoff C s is continuous (which it is, being a continuous function of (s, w) maximised over compact w-set — but that's a Berge-type result).

### Simplest path: use MeasureTheory.continuous_integral_of_dominated_convergence machinery, or skip integrability and directly bound.

**Cleanest approach** (recommended): Use Continuous.intervalIntegral-style results, OR use LipschitzWith directly:


lean
theorem menu_functional_continuity ... := by
  obtain ⟨L, hL_nonneg, hL⟩ := menu_extrema_Hausdorff_Lipschitz model
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  refine (LipschitzWith.continuous (K := L.toNNReal) ?_)
  intro C D
  -- |F(C) - F(D)| ≤ L * dist C D
  -- F(C) - F(D) = ∫ s, [α(max C s - max D s) + (1-α)(min C s - min D s)] dτM
  -- |F(C) - F(D)| ≤ ∫ s, L * dist C D dτM = L * dist C D * 1 = L * dist C D
  ...


Use:
- MeasureTheory.integral_sub (with integrability hyps; for finite measure with bounded measurable integrand, integrability is automatic)
- MeasureTheory.norm_integral_le_of_norm_le_const (bound by const on finite measure)

For the bounded measurable integrand on a finite (probability) measure, you can use:
- MeasureTheory.Integrable.of_bounded or
- MeasureTheory.Integrable.bdd_measurable (a bounded measurable function on finite measure is integrable)

### Concrete integrability proof template


lean
-- For any C, the integrand fun s ↦ α * maxPayoff C s + (1-α) * minPayoff C s is integrable on τM.
-- This requires:
-- 1. AEMeasurable (or Measurable) (or AEStronglyMeasurable)
-- 2. Bounded a.e.

-- For (1), maxPayoff is the sSup of a continuous function over a compact set.
-- For (2), bounded by M_C := sup_{w ∈ C} ‖w.val‖_∞.

-- If the measurability is hard, you may be able to dodge with:
-- `MeasureTheory.integral_undef` (if not integrable, integral = 0) gives ... no that's bad.


If the integrability proof is too involved, **simplify**: define a private helper lemma menu_functional_lipschitz that establishes the Lipschitz constant 1 (or L) modulo a sorry for integrability, then derive continuity from it. The reviewer will accept this as long as the integrability sorry is documented.

Actually, **cleanest fallback**: invoke Continuous.measurable recursively:

Maybe even simpler: use the existing beliefDot_lipschitz (private helper from menu_extrema_Hausdorff_Lipschitz) which says LipschitzWith 1 (fun w => beliefDot (inclM s) w.val). Then maxPayoff C s IS the sSup of a 1-Lipschitz function over a compact set, which is continuous in C (already established) AND continuous in s (jointly continuous → continuous over compact).

Then s ↦ maxPayoff C s is **continuous** for fixed C (Berge's maximum theorem / IsCompact.continuous_sSup_image). Continuous ⟹ measurable.

For continuous-in-s and continuous-in-C jointly (which we'd need for F continuous), we have:
- s ↦ maxPayoff C s continuous (each fixed C).
- Lipschitz in C uniformly in s.

These suffice for Continuous (MenuFunctionalF) via dominated convergence or directly.

## Hint: explicit bound for ProfileInW

Since model.profileOfPrivate σ : Profile model = model.Ω → ℝ, and model.PrivateStrategy has [CompactSpace], the image Set.range model.profileOfPrivate is bounded (continuous image of compact). Hence w.val is uniformly bounded for w ∈ PayoffProfileSet model.

Specifically: IsCompact.bddAbove applied to Set.range model.profileOfPrivate gives an upper bound, and similarly for lower bound. So ‖w.val‖_∞ is uniformly bounded for all w ∈ ProfileInW model (which is a subtype of PayoffProfileSet).

## Output


lean_proof
target_lemma_slug: menu_functional_continuity
status: PROVED | STUCK
tactics_used: [...]



lean
theorem menu_functional_continuity ... := by
  -- your proof


You may freely add private helper lemmas. If you still get stuck, try the most aggressive simplification: prove an auxiliary LipschitzWith _ (MenuFunctionalF model) and use that to conclude. If the integrability is truly intractable, return STUCK with a precise Mathlib API request (e.g., "need MeasureTheory.Integrable.of_bdd_measurable_compact_image").

Avoid sorry in the final proof. If you must use it, document it as a precise stub that can be discharged by a single Mathlib lemma.

Show more

========
ROLE: assistant (id=c0814142-1583-41c5-8297-0c718a148dbd)
========
lean_proof
target_lemma_slug: menu_functional_continuity
status: STUCK
tactics_used: [LipschitzWith.of_dist_le', integral_sub, norm_integral_le_of_norm_le_const, Integrable.of_mem_Icc, simp, calc]

lean
import Mathlib

noncomputable section

open MeasureTheory
open scoped BigOperators

namespace RobustTrustV8

/-
Precise remaining API stub 1.

Needed lemma:
  compact-extremum measurability for a Carathéodory/support-function map.

In this application:
  F s w = beliefDot (model.inclM s) w.val

For fixed `w`, `s ↦ F s w` is measurable.
For fixed `s`, `w ↦ F s w` is continuous.
For compact `C`, this should give AEMeasurable/Measurable for
  s ↦ maxPayoff C s
and
  s ↦ minPayoff C s.
-/
private lemma menu_integrand_aemeasurable
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (C : NonemptyCompacts (ProfileInW model)) :
    AEMeasurable
      (fun s =>
        model.α * maxPayoff C s + (1 - model.α) * minPayoff C s)
      model.τM := by
  sorry

/-
Precise remaining API stub 2.

Needed lemma:
  uniform boundedness of the menu integrand.

A sufficient route is:
  ∃ B, ∀ w : ProfileInW model, ∀ ω, |w.val ω| ≤ B

from compactness of the payoff-profile set, plus:
  0 ≤ (model.inclM s).val ω,
  ∑ ω, (model.inclM s).val ω = 1,
  0 ≤ model.α,
  model.α ≤ 1.

Then:
  |maxPayoff C s| ≤ B,
  |minPayoff C s| ≤ B,
  |model.α * maxPayoff C s + (1 - model.α) * minPayoff C s| ≤ B.
-/
private lemma menu_integrand_mem_Icc_ae
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (C : NonemptyCompacts (ProfileInW model)) :
    ∃ B : ℝ,
      ∀ᵐ s ∂model.τM,
        model.α * maxPayoff C s + (1 - model.α) * minPayoff C s ∈
          Set.Icc (-B) B := by
  sorry

private lemma menu_integrand_integrable
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (C : NonemptyCompacts (ProfileInW model)) :
    Integrable
      (fun s =>
        model.α * maxPayoff C s + (1 - model.α) * minPayoff C s)
      model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases menu_integrand_mem_Icc_ae model setup C with ⟨B, hB⟩
  exact
    Integrable.of_mem_Icc (-B) B
      (menu_integrand_aemeasurable model setup C)
      hB

theorem menu_functional_continuity
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    Continuous (MenuFunctionalF model) := by
  obtain ⟨L, _hL_nonneg, hL⟩ := menu_extrema_Hausdorff_Lipschitz model
  haveI : IsProbabilityMeasure model.τM := model.τM_prob

  refine (LipschitzWith.of_dist_le' (K := L) ?_).continuous
  intro C D

  let fC :=
    fun s =>
      model.α * maxPayoff C s + (1 - model.α) * minPayoff C s
  let fD :=
    fun s =>
      model.α * maxPayoff D s + (1 - model.α) * minPayoff D s

  have hC : Integrable fC model.τM := by
    simpa [fC] using menu_integrand_integrable model setup C
  have hD : Integrable fD model.τM := by
    simpa [fD] using menu_integrand_integrable model setup D

  have hBound :
      ∀ᵐ s ∂model.τM, ‖fC s - fD s‖ ≤ L * dist C D := by
    filter_upwards with s
    have hs := hL C D s
    simpa [fC, fD, Real.norm_eq_abs] using hs

  rw [Real.dist_eq]
  calc
    |MenuFunctionalF model C - MenuFunctionalF model D|
        = |∫ s, fC s - fD s ∂model.τM| := by
            simp [MenuFunctionalF, fC, fD,
              MeasureTheory.integral_sub hC hD]
    _ = ‖∫ s, fC s - fD s ∂model.τM‖ := by
            simp [Real.norm_eq_abs]
    _ ≤ (L * dist C D) * model.τM.real Set.univ := by
            exact MeasureTheory.norm_integral_le_of_norm_le_const hBound
    _ = L * dist C D := by
            simp

The integral-to-Lipschitz part is closed. The remaining lock is exactly the compact-extremum measurability lemma plus the uniform profile bound. Once those two helper lemmas are available, Integrable.of_mem_Icc discharges integrability on the finite probability measure, and norm_integral_le_of_norm_le_const gives the final integral estimate. 
Lean Community
+2
Lean Community
+2
