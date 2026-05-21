
========
ROLE: user (id=ade5edcc-615c-489a-99f3-16da13576bad)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem menu_functional_continuity
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    Continuous (MenuFunctionalF model) := by
  sorry


## Available proved lemma (use freely)


lean
theorem menu_extrema_Hausdorff_Lipschitz
    (model : RobustTrustModel) :
    ∃ L : ℝ, 0 ≤ L ∧
      ∀ (C D : CompactMenu model) (s : model.M),
        |maxPayoff model C s - maxPayoff model D s| ≤ L * dist C D ∧
        |minPayoff model C s - minPayoff model D s| ≤ L * dist C D


(NOTE: the actual proof of menu_extrema_Hausdorff_Lipschitz returns L = 1.)

## Relevant definitions


lean
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


Constraints from RobustTrustModel:
- model.α : ℝ with model.α_nonneg : 0 ≤ model.α and model.α_le_one : model.α ≤ 1
- model.τM : Measure model.M with model.τM_prob : IsProbabilityMeasure model.τM

## Math sketch

Show F is L-Lipschitz (hence continuous) using menu_extrema_Hausdorff_Lipschitz:

|F(C) - F(D)| = |∫ s, [α (max C s - max D s) + (1-α)(min C s - min D s)] dτM|
 ≤ ∫ s, α |max C s - max D s| + (1-α) |min C s - min D s| dτM
 ≤ ∫ s, α * L * dist C D + (1-α) * L * dist C D dτM   (by menu_extrema_Hausdorff_Lipschitz, both bounds)
 = L * dist C D * (α + (1-α)) * τM(univ)
 = L * dist C D * τM(univ)
 = L * dist C D   (since τM is a probability measure)

Hence F is L-Lipschitz, so continuous.

Note that α, 1-α ≥ 0 (from model.α_nonneg and model.α_le_one), so the integrand bounds work out.

## Lean strategy

Probably cleanest:

lean
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


Or simpler: prove a Lipschitz inequality directly and conclude via LipschitzWith.continuous or just Metric.continuous_iff-style.

Key Mathlib tools needed:
- MeasureTheory.integral_sub (for splitting |F(C) - F(D)|)
- MeasureTheory.abs_integral_le_integral_abs
- MeasureTheory.integral_const or IsProbabilityMeasure.measure_univ
- MeasureTheory.integral_mono_of_nonneg for nonneg dominated integrands
- LipschitzWith.continuous

Or alternatively use Continuous directly via Metric.continuous_iff:
For all ε > 0, ∃ δ > 0 with dist C D < δ → |F(C) - F(D)| < ε. Take δ := ε / (L + 1).

Both maxPayoff and minPayoff are MEASURABLE in s (since beliefDot is continuous in (s, w) and sSup/sInf preserves measurability). For Integrable, since s ↦ maxPayoff C s is BOUNDED (by something like ‖inclM s‖ * max-norm of w ∈ C, which is uniformly bounded since C compact), it's integrable on the probability measure τM. So Integrable (α maxPayoff C ·) τM and Integrable ((1-α) minPayoff C ·) τM, hence Integrable (α maxPayoff C · + (1-α) minPayoff C ·) τM. Then MeasureTheory.integral_sub applies.

But this gets into a lot of integrability bookkeeping. Try to keep the proof clean.

## Output


lean_proof
target_lemma_slug: menu_functional_continuity
status: PROVED | STUCK
tactics_used: [...]



lean
theorem menu_functional_continuity ... := by
  -- your proof


Aim for 60-120 lines. If integrability bookkeeping makes the proof huge, state STUCK with specific gaps. If you can prove pointwise Lipschitz of F (using menu_extrema_Hausdorff_Lipschitz), do so even without exhibiting a global Lipschitz constant — just Continuous (MenuFunctionalF model) suffices.

You may freely add private helper lemmas if useful.

Show more

========
ROLE: assistant (id=acc2ccd1-b400-4cd4-aa72-0ee9367cc3f3)
========
lean_proof
target_lemma_slug: menu_functional_continuity
status: STUCK
tactics_used: [obtain, LipschitzWith.continuous, pointwise_abs_estimate, MeasureTheory.norm_integral_le_of_norm_le_const]

lean
theorem menu_functional_continuity
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model) :
    Continuous (MenuFunctionalF model) := by
  obtain ⟨L, hL_nonneg, hL⟩ := menu_extrema_Hausdorff_Lipschitz model
  haveI : IsProbabilityMeasure model.τM := model.τM_prob

  -- This is the core pointwise estimate, and it closes cleanly from the supplied lemma.
  have h_point :
      ∀ (C D : CompactMenu model) (s : model.M),
        ‖(model.α * maxPayoff model C s +
              (1 - model.α) * minPayoff model C s) -
            (model.α * maxPayoff model D s +
              (1 - model.α) * minPayoff model D s)‖
          ≤ L * dist C D := by
    intro C D s
    rcases hL C D s with ⟨hmax, hmin⟩
    have hα : 0 ≤ model.α := model.α_nonneg
    have h1α : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
    have hdist_nonneg : 0 ≤ dist C D := dist_nonneg
    calc
      ‖(model.α * maxPayoff model C s +
              (1 - model.α) * minPayoff model C s) -
            (model.α * maxPayoff model D s +
              (1 - model.α) * minPayoff model D s)‖
          =
        |model.α * (maxPayoff model C s - maxPayoff model D s) +
          (1 - model.α) * (minPayoff model C s - minPayoff model D s)| := by
            rw [Real.norm_eq_abs]
            ring_nf
      _ ≤
        |model.α * (maxPayoff model C s - maxPayoff model D s)| +
        |(1 - model.α) * (minPayoff model C s - minPayoff model D s)| := by
          exact abs_add _ _
      _ =
        model.α * |maxPayoff model C s - maxPayoff model D s| +
        (1 - model.α) * |minPayoff model C s - minPayoff model D s| := by
          rw [abs_mul, abs_mul, abs_of_nonneg hα, abs_of_nonneg h1α]
      _ ≤
        model.α * (L * dist C D) +
        (1 - model.α) * (L * dist C D) := by
          gcongr
      _ = L * dist C D := by
          ring

  -- Intended final step:
  --
  --   have hLip : LipschitzWith (Real.toNNReal L) (MenuFunctionalF model) := by
  --     intro C D
  --     rw [Real.dist_eq]
  --     rw [Real.toNNReal_of_nonneg hL_nonneg]
  --     ...
  --   exact hLip.continuous
  --
  -- The missing ingredient is not algebraic.  One needs either:
  --
  --   (A) an available lemma:
  --
  --       ∀ C, Integrable
  --         (fun s =>
  --           model.α * maxPayoff model C s +
  --           (1 - model.α) * minPayoff model C s)
  --         model.τM
  --
  --   or
  --
  --   (B) a theorem already packaged for this exact API, e.g. a
  --       `dist_integral_integral_le_of_dist_le_const` lemma whose hypotheses include
  --       the needed AEStronglyMeasurable / Integrable bookkeeping.
  --
  -- With (A), the remaining Lean proof is:
  --
  --   have hLip : LipschitzWith (Real.toNNReal L) (MenuFunctionalF model) := by
  --     intro C D
  --     rw [Real.dist_eq]
  --     rw [Real.toNNReal_of_nonneg hL_nonneg]
  --     let fC : model.M → ℝ :=
  --       fun s =>
  --         model.α * maxPayoff model C s +
  --         (1 - model.α) * minPayoff model C s
  --     let fD : model.M → ℝ :=
  --       fun s =>
  --         model.α * maxPayoff model D s +
  --         (1 - model.α) * minPayoff model D s
  --     have hIntC : Integrable fC model.τM := by
  --       -- menu-integrand integrability lemma needed here
  --       ...
  --     have hIntD : Integrable fD model.τM := by
  --       -- menu-integrand integrability lemma needed here
  --       ...
  --     have hsub :
  --         (∫ s, fC s - fD s ∂model.τM)
  --           =
  --         (∫ s, fC s ∂model.τM) -
  --         (∫ s, fD s ∂model.τM) := by
  --       exact MeasureTheory.integral_sub hIntC hIntD
  --     have hbound :
  --         ‖∫ s, fC s - fD s ∂model.τM‖
  --           ≤ (L * dist C D) * model.τM.real Set.univ := by
  --       refine MeasureTheory.norm_integral_le_of_norm_le_const ?_
  --       filter_upwards with s
  --       simpa [fC, fD, Real.norm_eq_abs] using h_point C D s
  --     rw [MeasureTheory.measureReal_univ_eq_one] at hbound
  --     simpa [MenuFunctionalF, fC, fD, hsub, mul_one, Real.norm_eq_abs]
  --       using hbound
  --   exact hLip.continuous
  --
  -- I cannot honestly close the theorem from only the supplied
  -- `menu_extrema_Hausdorff_Lipschitz` lemma: Mathlib's `integral_sub`
  -- requires integrability of both menu integrands, and that fact is not in
  -- the exposed context.
  --
  -- The pointwise Lipschitz estimate above is the finished “math heart” of
  -- the proof; the remaining gap is precisely the measure-theory packaging
  -- for measurability/integrability of the menu integrand.
  sorry
