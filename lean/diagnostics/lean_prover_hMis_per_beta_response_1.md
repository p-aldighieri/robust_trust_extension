
========
ROLE: user (id=1801f390-1fdb-4ae8-8e2b-16dc61e6ffb4)
========
You are the Lean Prover. Close ONE specific inline sorry — the per-β misaligned lower bound inside menu_value_le_strategy_sup.

## Target inline sorry (line 1597 of main.lean, inside menu_value_le_strategy_sup)


lean
have hMis_per_β :
    ∀ β : AdviserKernel model,
      (∫ s, @minPayoff model C s ∂model.τM)
        ≤ @MisalignedPayoffM model β σM_C := by
  intro β
  -- Same gap as menu_value_le_strategy_sup_misaligned_sInf_lower_bound
  -- but applied per-β. The sInf version follows by taking inf over β.
  sorry


## Available local context (in scope at the sorry)


lean
-- σM_C : AgentStrategyM model
-- wC : model.M → ProfileInW model  (selector into compact menu)
-- hwC_mem : ∀ s, (wC s).val ∈ ...
-- hwC_max : ∀ s, ∀ w' ∈ menu, beliefDot (inclM s) w'.val ≤ beliefDot (inclM s) (wC s).val
-- hprofile : ∀ m, profileMap σM_C m = (wC m).val
-- hmin_point : ∀ s m, minPayoff model C s ≤ beliefDot (inclM s) (profileMap σM_C m)
-- hAligned : AlignedPayoffM σM_C = ∫ s, maxPayoff model C s ∂τM
-- C : CompactMenu model
-- model.τM_prob : IsProbabilityMeasure model.τM


## Available helpers in scope (just proved last session, all above)


lean
private lemma beliefDot_menu_uncurry_continuous (model) :
    Continuous (fun x : Belief model.Ω × ProfileInW model => beliefDot x.1 x.2.val)

private lemma minPayoff_aemeasurable (model C) :
    AEMeasurable (fun s : model.M => minPayoff model C s) model.τM
private lemma minPayoff_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, minPayoff model C s ∈ Set.Icc (-B) B
private lemma minPayoff_integrable (model C) :
    Integrable (fun s : model.M => minPayoff model C s) model.τM


Also: model.private_profile_bounded : ∃ C, ∀ σ ω, |profileOfPrivate σ ω| ≤ C, model.α_nonneg, model.τM_prob. AdviserKernel.kernel is ProbabilityTheory.Kernel model.M model.M with IsMarkovKernel β.kernel.

## Definitions


lean
noncomputable def MisalignedPayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM


## Math sketch

For each fixed s, the inner integral satisfies:

∫ m, beliefDot (inclM s) (profileMap σM_C m) ∂(β.kernel s)
  ≥ ∫ m, minPayoff model C s ∂(β.kernel s)        [hmin_point: pointwise ≥]
  = minPayoff model C s * (β.kernel s univ)        [integral_const]
  = minPayoff model C s * 1                         [β Markov → kernel s probability]
  = minPayoff model C s


Then by integral_mono_ae on the outer τM-integral:

∫ s, (inner) ∂τM ≥ ∫ s, minPayoff C s ∂τM


i.e. MisalignedPayoffM β σM_C ≥ ∫ s, minPayoff C s ∂τM.

## Strategy


lean
unfold MisalignedPayoffM
haveI : IsProbabilityMeasure model.τM := model.τM_prob
-- Step 1: pointwise inner bound (per s)
have hInner :
    ∀ᵐ s ∂model.τM,
      minPayoff model C s
        ≤ ∫ m, beliefDot (model.inclM s) (profileMap model σM_C m) ∂(β.kernel s) := by
  filter_upwards with s
  have hβ_prob : IsProbabilityMeasure (β.kernel s) := β.isMarkov.isProbabilityMeasure s
  haveI : IsProbabilityMeasure (β.kernel s) := hβ_prob
  -- Use integral_const + integral_mono
  have h_const_int :
      ∫ m, minPayoff model C s ∂(β.kernel s) = minPayoff model C s := by
    simp [MeasureTheory.integral_const, measure_univ]
  -- Integrability of inner integrand (bounded measurable)
  have hf_meas : Measurable (fun m : model.M =>
      beliefDot (model.inclM s) (profileMap model σM_C m)) := by
    -- profileMap σM_C m = profileOfPrivate (σM_C.sectionM m). Lookup standard measurability.
    sorry  -- HELPER: needs measurability proof for profileMap σM_C composition
  have hf_int :
      Integrable (fun m => beliefDot (model.inclM s) (profileMap model σM_C m))
        (β.kernel s) := by
    -- Bounded by C_bnd (from private_profile_bounded), and probability measure ⇒ integrable
    sorry  -- HELPER: bounded measurable ⇒ integrable on probability measure
  -- Now apply integral_mono
  rw [← h_const_int]
  refine MeasureTheory.integral_mono_ae ?_ hf_int ?_
  · exact integrable_const _
  · filter_upwards with m
    exact hmin_point s m
-- Step 2: outer integral monotonicity
-- (∫ s, minPayoff dτM) ≤ ∫ s, (inner) dτM = MisalignedPayoffM β σM_C
have hMisalignedInt :
    Integrable
      (fun s => ∫ m, beliefDot (model.inclM s) (profileMap model σM_C m) ∂(β.kernel s))
      model.τM := by
  sorry  -- HELPER: kernel integrability transfer (Markov + bounded ⇒ integrable)
refine MeasureTheory.integral_mono_ae (minPayoff_integrable model C) hMisalignedInt ?_
exact hInner


The 3 inner helper-sorries need explicit Mathlib lemmas:
- MeasureTheory.Integrable.of_bounded or MeasureTheory.Integrable.of_mem_Icc for inner integrability
- ProbabilityTheory.Kernel.measurable_integral or similar for outer integrability
- Composition measurability via section_measurable: profileMap σM_C = profileOfPrivate ∘ σM_C.sectionM is measurable since sectionM is AgentStrategyM.sectionM_measurable and profileOfPrivate is model.profileOfPrivate_measurable (standard from inventory)

If kernel integrability is genuinely intractable, status: STUCK with the precise Mathlib lemma name needed.

## Output


lean_proof
target_lemma_slug: hMis_per_beta_inline
status: PROVED | STUCK
tactics_used: [...]


Provide ONE Lean code block with the entire have hMis_per_β : ... := by body (and any new private helpers needed, placed BEFORE menu_value_le_strategy_sup near line 1287). Aim 80-150 lines.

CRITICAL: do NOT use model.alpha/model.tauM — actual fields are model.α/model.τM (Greek letters).

Show more

========
ROLE: assistant (id=69d7373e-9869-4c1d-8ebe-8f4e794f993a)
========
lean_proof
target_lemma_slug: hMis_per_beta_inline
status: PROVED
tactics_used: [unfold, filter_upwards, integral_mono_ae, integral_const, Integrable.of_bound, kernel integral measurability, uniform boundedness]

lean
/-
Helpers to place before `menu_value_le_strategy_sup`.
-/

@[fun_prop]
private lemma beliefDot_continuous_profile_for_kernel_bound
    (model : RobustTrustModel) :
    Continuous
      (fun x : Belief model.Ω × (model.Ω → ℝ) =>
        beliefDot x.1 x.2) := by
  classical
  unfold beliefDot
  fun_prop

@[measurability]
private lemma profileMap_measurable_for_kernel_bound
    (model : RobustTrustModel) (σM : AgentStrategyM model) :
    Measurable (fun m : model.M => profileMap model σM m) := by
  simpa [profileMap] using
    model.profileOfPrivate_measurable.comp
      (AgentStrategyM.sectionM_measurable σM)

private lemma beliefDot_abs_le_of_forall_abs_le
    {Ω : Type*} [Fintype Ω]
    (p : Belief Ω) (w : Ω → ℝ) {B : ℝ}
    (hB : ∀ ω : Ω, |w ω| ≤ B) :
    |beliefDot p w| ≤ B := by
  classical
  have hp_nonneg : ∀ ω : Ω, 0 ≤ p.val ω := by
    intro ω
    exact p.property.1 ω
  have hp_sum : (∑ ω : Ω, p.val ω) = 1 := by
    exact p.property.2
  calc
    |beliefDot p w|
        = |∑ ω : Ω, p.val ω * w ω| := by
            simp [beliefDot]
    _ = ‖∑ ω : Ω, p.val ω * w ω‖ := by
            rw [Real.norm_eq_abs]
    _ ≤ ∑ ω : Ω, ‖p.val ω * w ω‖ := by
            exact norm_sum_le _ _
    _ = ∑ ω : Ω, p.val ω * |w ω| := by
            refine Finset.sum_congr rfl ?_
            intro ω _
            rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg (hp_nonneg ω)]
    _ ≤ ∑ ω : Ω, p.val ω * B := by
            refine Finset.sum_le_sum ?_
            intro ω _
            exact mul_le_mul_of_nonneg_left (hB ω) (hp_nonneg ω)
    _ = (∑ ω : Ω, p.val ω) * B := by
            rw [Finset.sum_mul]
    _ = B := by
            rw [hp_sum, one_mul]

private lemma profileMap_abs_le_private_bound
    (model : RobustTrustModel) (σM : AgentStrategyM model) :
    ∃ B : ℝ, ∀ m : model.M, ∀ ω : model.Ω,
      |profileMap model σM m ω| ≤ B := by
  classical
  obtain ⟨B, hB⟩ := model.private_profile_bounded
  refine ⟨|B|, ?_⟩
  intro m ω
  have h0 := hB (σM.sectionM m) ω
  have h1 : |profileMap model σM m ω| ≤ B := by
    simpa [profileMap] using h0
  exact h1.trans (le_abs_self B)

private lemma beliefDot_profileMap_uniform_bound
    (model : RobustTrustModel) (σM : AgentStrategyM model) :
    ∃ B : ℝ, ∀ s : model.M, ∀ m : model.M,
      ‖beliefDot (model.inclM s) (profileMap model σM m)‖ ≤ B := by
  classical
  obtain ⟨B, hB⟩ := profileMap_abs_le_private_bound model σM
  refine ⟨B, ?_⟩
  intro s m
  rw [Real.norm_eq_abs]
  exact
    beliefDot_abs_le_of_forall_abs_le
      (model.inclM s)
      (profileMap model σM m)
      (hB m)

private lemma beliefDot_profileMap_uncurry_stronglyMeasurable
    (model : RobustTrustModel) (σM : AgentStrategyM model) :
    StronglyMeasurable
      (Function.uncurry
        (fun s : model.M => fun m : model.M =>
          beliefDot (model.inclM s) (profileMap model σM m))) := by
  classical
  change StronglyMeasurable
    (fun x : model.M × model.M =>
      beliefDot (model.inclM x.1) (profileMap model σM x.2))
  have hIncl :
      Measurable (fun x : model.M × model.M => model.inclM x.1) := by
    fun_prop
  have hProf :
      Measurable (fun x : model.M × model.M => profileMap model σM x.2) := by
    exact (profileMap_measurable_for_kernel_bound model σM).comp measurable_snd
  exact
    ((beliefDot_continuous_profile_for_kernel_bound model).measurable.comp
      (hIncl.prod_mk hProf)).stronglyMeasurable

private lemma beliefDot_profileMap_integrable_kernel
    (model : RobustTrustModel) (β : AdviserKernel model)
    (σM : AgentStrategyM model) (s : model.M) :
    Integrable
      (fun m : model.M =>
        beliefDot (model.inclM s) (profileMap model σM m))
      (β.kernel s) := by
  classical
  haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
  haveI : IsProbabilityMeasure (β.kernel s) :=
    β.isMarkov.isProbabilityMeasure s
  obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
  refine MeasureTheory.Integrable.of_bound ?_ B ?_
  · have hPair : Measurable (fun m : model.M => (s, m)) := by
      fun_prop
    exact
      ((beliefDot_profileMap_uncurry_stronglyMeasurable model σM).comp_measurable
        hPair).aestronglyMeasurable
  · exact Filter.Eventually.of_forall (hB s)

private lemma beliefDot_profileMap_kernel_integral_integrable
    (model : RobustTrustModel) (β : AdviserKernel model)
    (σM : AgentStrategyM model) :
    Integrable
      (fun s : model.M =>
        ∫ m : model.M,
          beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s))
      model.τM := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov
  obtain ⟨B, hB⟩ := beliefDot_profileMap_uniform_bound model σM
  refine MeasureTheory.Integrable.of_bound ?_ B ?_
  · have hsm :=
      MeasureTheory.StronglyMeasurable.integral_kernel_prod_right
        (κ := β.kernel)
        (beliefDot_profileMap_uncurry_stronglyMeasurable model σM)
    exact hsm.aestronglyMeasurable
  · filter_upwards with s
    haveI : IsProbabilityMeasure (β.kernel s) :=
      β.isMarkov.isProbabilityMeasure s
    have hnorm :=
      MeasureTheory.norm_integral_le_of_norm_le_const
        (μ := β.kernel s)
        (f := fun m : model.M =>
          beliefDot (model.inclM s) (profileMap model σM m))
        (C := B)
        (Filter.Eventually.of_forall (hB s))
    have hreal : (β.kernel s).real Set.univ = 1 := by
      simp
    simpa [hreal] using hnorm

/-
Replacement for the inline sorry inside `menu_value_le_strategy_sup`.
-/

have hMis_per_β :
    ∀ β : AdviserKernel model,
      (∫ s, @minPayoff model C s ∂model.τM)
        ≤ @MisalignedPayoffM model β σM_C := by
  intro β
  unfold MisalignedPayoffM
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI : ProbabilityTheory.IsMarkovKernel β.kernel := β.isMarkov

  have hInner :
      ∀ᵐ s ∂model.τM,
        minPayoff model C s
          ≤ ∫ m : model.M,
              beliefDot (model.inclM s) (profileMap model σM_C m)
                ∂(β.kernel s) := by
    filter_upwards with s
    haveI : IsProbabilityMeasure (β.kernel s) :=
      β.isMarkov.isProbabilityMeasure s

    have h_const_int :
        (∫ _m : model.M, minPayoff model C s ∂(β.kernel s))
          = minPayoff model C s := by
      simpa using
        (MeasureTheory.integral_const
          (μ := β.kernel s)
          (c := minPayoff model C s))

    rw [← h_const_int]
    refine
      MeasureTheory.integral_mono_ae
        (integrable_const (minPayoff model C s))
        (beliefDot_profileMap_integrable_kernel model β σM_C s)
        ?_
    exact Filter.Eventually.of_forall (fun m => hmin_point s m)

  have hMisalignedInt :
      Integrable
        (fun s : model.M =>
          ∫ m : model.M,
            beliefDot (model.inclM s) (profileMap model σM_C m)
              ∂(β.kernel s))
        model.τM :=
    beliefDot_profileMap_kernel_integral_integrable model β σM_C

  simpa using
    MeasureTheory.integral_mono_ae
      (minPayoff_integrable model C)
      hMisalignedInt
      hInner
