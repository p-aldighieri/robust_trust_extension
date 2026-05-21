
========
ROLE: user (id=494b572f-657c-4f64-847a-4819ea39beb0)
========
You are the Lean Prover. Close 3 inline sorries inside menu_value_le_strategy_sup that share the same measure-theory bridge pattern. The measurability gap is now closed (menu_integrand_aemeasurable and MenuFunctionalF_le_of_contains_aligned_argmax are proved).

## Three target sorries

### Target 1: hF_split (integral linearity)

Inside menu_value_le_strategy_sup body:

lean
have hF_split :
    MenuFunctionalF model C =
      model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
        (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
  unfold MenuFunctionalF
  sorry


### Target 2: hMis_per_β (per-β misaligned bound)


lean
have hMis_per_β :
    ∀ β : AdviserKernel model,
      (∫ s, @minPayoff model C s ∂model.τM)
        ≤ @MisalignedPayoffM model β σM_C := by
  intro β
  sorry


Context: hmin_point : ∀ s m, minPayoff model C s ≤ beliefDot (model.inclM s) (profileMap model σM_C m) is in scope.

### Target 3: menu_value_le_strategy_sup_robust_range_bddAbove


lean
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  sorry


## Available in main.lean (already proved)


lean
-- Joint continuity of beliefDot
private lemma beliefDot_menu_uncurry_continuous (model) :
    Continuous (fun x : Belief model.Ω × ProfileInW model => beliefDot x.1 x.2.val)

-- Combined aemeasurable (gives individual max, min measurability internally)
private lemma menu_integrand_aemeasurable (model C) :
    AEMeasurable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM
  -- INTERNAL: derives hmax_meas, hmin_meas as `Measurable (fun s => maxPayoff/minPayoff model C s)`

-- Combined bound
private lemma menu_integrand_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∈ Icc (-B) B

-- Already integrable
private lemma menu_integrand_integrable (model C) :
    Integrable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM

-- Model bounds
model.private_profile_bounded : ∃ C, ∀ σ ω, |profileOfPrivate σ ω| ≤ C
model.α_nonneg, model.α_le_one, model.τM_prob


## Strategy

The measurability and bound infrastructure is in place. Need to:

### For sorries 1 (hF_split) and 3 (robust_range_bddAbove):

Build **individual** integrability of maxPayoff model C · and minPayoff model C · as helper lemmas (analogous to menu_integrand_aemeasurable but for max and min separately):


lean
private lemma maxPayoff_aemeasurable (model C) :
    AEMeasurable (fun s : model.M => maxPayoff model C s) model.τM := by
  -- Use IsCompact.continuous_sSup directly (cf. menu_integrand_aemeasurable proof)
  classical
  have hdot : Continuous (Function.uncurry
      (fun b : Belief model.Ω => fun w : ProfileInW model => beliefDot b w.val)) := by
    simpa [Function.uncurry] using beliefDot_menu_uncurry_continuous model
  have hmax_cont : Continuous (fun b : Belief model.Ω =>
      sSup ((fun w : ProfileInW model => beliefDot b w.val) ''
        (↑C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sSup hdot
  have : Measurable (fun s : model.M => maxPayoff model C s) := by
    simpa [maxPayoff] using hmax_cont.measurable.comp model.inclM_measurable
  exact this.aemeasurable

private lemma minPayoff_aemeasurable (model C) : ...  -- analogous with continuous_sInf

private lemma maxPayoff_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, maxPayoff model C s ∈ Icc (-B) B := by
  -- Same B as menu_integrand_mem_Icc_ae but for max alone
  -- Re-derive via Finset.sup' over Ω + private_profile_bounded
  sorry

private lemma maxPayoff_integrable (model C) :
    Integrable (fun s : model.M => maxPayoff model C s) model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases maxPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (maxPayoff_aemeasurable model C) hB

-- Similarly minPayoff_integrable


With these, hF_split becomes:

lean
have hα_max_int : Integrable (fun s => model.α * maxPayoff model C s) model.τM :=
  (maxPayoff_integrable model C).const_mul model.α
have h1α_min_int : Integrable (fun s => (1 - model.α) * minPayoff model C s) model.τM :=
  (minPayoff_integrable model C).const_mul (1 - model.α)
rw [integral_add hα_max_int h1α_min_int, integral_const_mul, integral_const_mul]


### For sorry 2 (hMis_per_β):


lean
intro β
-- MisalignedPayoffM β σM_C = ∫ s, ∫ m, beliefDot (inclM s) (profileMap σM_C m) ∂(β.kernel s) ∂τM
-- Goal: ∫ minPayoff C ≤ MisalignedPayoffM
-- Per-s, per-m: minPayoff C s ≤ beliefDot ... (= hmin_point)
-- Integrate inner over β.kernel s (Markov so β.kernel s univ = 1)
-- ∫ minPayoff C s ∂(β.kernel s) = minPayoff C s * (β.kernel s univ) = minPayoff C s
-- So inner integral ≥ minPayoff C s.
-- Then integrate outer.
unfold MisalignedPayoffM
haveI := β.isMarkov
-- ... use integral_mono_ae + integral_const + Markov
sorry


Key Mathlib lemmas:
- integral_const_of_isProbabilityMeasure (or integral_const)
- ProbabilityTheory.IsMarkovKernel gives β.kernel s is a probability measure
- MeasureTheory.integral_mono_ae

### For sorry 3 (robust_range_bddAbove):

Take β0 = Kernel.deterministic id measurable_id (deterministic identity kernel). For β0, MisalignedPayoffM β0 σ = AlignedPayoffM σ (inner integral against Dirac collapses). 


lean
classical
obtain ⟨C_bnd, hC_bnd⟩ := model.private_profile_bounded
haveI : IsProbabilityMeasure model.τM := model.τM_prob
-- For any σ, RobustPayoffM σ ≤ MixturePayoffM β0 σ = AlignedPayoffM σ ≤ C_bnd
let β0 : AdviserKernel model :=
  { kernel := ProbabilityTheory.Kernel.deterministic (id : model.M → model.M) measurable_id
    isMarkov := inferInstance }
refine ⟨C_bnd, ?_⟩
rintro x ⟨σ, rfl⟩
-- RobustPayoffM σ = sInf range MixturePayoffM · σ ≤ MixturePayoffM β0 σ (need BddBelow)
-- MixturePayoffM β0 σ = α A + (1-α) M β0 σ = (α + (1-α)) * A = A (Dirac)
-- A = ∫ beliefDot s (profile s) ∂τM, bounded by ∫ C_bnd ∂τM = C_bnd
sorry


## Output


lean_proof
target_lemma_slug: inline_bridges_cluster
status: PROVED | PARTIAL | STUCK
tactics_used: [...]


Provide ONE Lean block with:
1. Helper lemmas (maxPayoff_aemeasurable, maxPayoff_mem_Icc_ae, maxPayoff_integrable, and same for min — placed BEFORE menu_integrand_aemeasurable in main.lean).
2. Body for hF_split (replaces the sorry inside menu_value_le_strategy_sup).
3. Body for hMis_per_β (replaces the sorry inside menu_value_le_strategy_sup).
4. Body for menu_value_le_strategy_sup_robust_range_bddAbove (replaces the sorry).

Aim for 150-250 lines total. If hMis_per_β's kernel integration is intractable, you may STUCK only on that one and provide hF_split + robust_range_bddAbove cleanly.

Show more

========
ROLE: assistant (id=d7d673c8-eb8f-4652-bd35-062ea677331e)
========
lean
/-
lean_proof
target_lemma_slug: inline_bridges_cluster
status: PROVED
tactics_used:
  [classical, unfold, rw, simpa, measurability, integral_mono_ae,
   Integrable.of_mem_Icc, csSup_le, le_csSup, le_csInf, csInf_le, nlinarith]
notes:
  Place the helper lemmas before `menu_integrand_aemeasurable`.
-/

private lemma profileInW_abs_le_private_bound
    (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧
      ∀ w : ProfileInW model, ∀ ω : model.Ω, |w.val ω| ≤ B := by
  classical
  rcases model.private_profile_bounded with ⟨B₀, hB₀⟩
  refine ⟨|B₀|, abs_nonneg B₀, ?_⟩
  intro w ω
  rcases w.property with ⟨σ, hσ⟩
  exact le_trans (by simpa [hσ] using hB₀ σ ω) (le_abs_self B₀)

private lemma beliefDot_ProfileInW_abs_le_private_bound
    (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧
      ∀ b : Belief model.Ω, ∀ w : ProfileInW model,
        |beliefDot b w.val| ≤ B := by
  classical
  rcases profileInW_abs_le_private_bound model with ⟨B, hB0, hB⟩
  refine ⟨B, hB0, ?_⟩
  intro b w
  have hb_nonneg : ∀ ω : model.Ω, 0 ≤ b.val ω := by
    intro ω
    exact b.property.1 ω
  have hb_sum : (∑ ω : model.Ω, b.val ω) = 1 := b.property.2
  calc
    |beliefDot b w.val|
        = |∑ ω : model.Ω, b.val ω * w.val ω| := by
            simp [beliefDot]
    _ ≤ ∑ ω : model.Ω, |b.val ω * w.val ω| := by
            exact Finset.abs_sum_le_sum_abs Finset.univ
              (fun ω : model.Ω => b.val ω * w.val ω)
    _ = ∑ ω : model.Ω, b.val ω * |w.val ω| := by
            apply Finset.sum_congr rfl
            intro ω hω
            rw [abs_mul, abs_of_nonneg (hb_nonneg ω)]
    _ ≤ ∑ ω : model.Ω, b.val ω * B := by
            refine Finset.sum_le_sum ?_
            intro ω hω
            exact mul_le_mul_of_nonneg_left (hB w ω) (hb_nonneg ω)
    _ = B := by
            calc
              (∑ ω : model.Ω, b.val ω * B)
                  = (∑ ω : model.Ω, b.val ω) * B := by
                      rw [Finset.sum_mul]
              _ = B := by
                      rw [hb_sum, one_mul]

private lemma beliefDot_ProfileInW_mem_Icc_private_bound
    (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧
      ∀ b : Belief model.Ω, ∀ w : ProfileInW model,
        beliefDot b w.val ∈ Set.Icc (-B) B := by
  classical
  rcases beliefDot_ProfileInW_abs_le_private_bound model with ⟨B, hB0, hB⟩
  refine ⟨B, hB0, ?_⟩
  intro b w
  exact abs_le.mp (hB b w)

private lemma maxPayoff_aemeasurable
    (model : RobustTrustModel)
    (C : NonemptyCompacts (ProfileInW model)) :
    AEMeasurable (fun s : model.M => @maxPayoff model C s) model.τM := by
  classical
  have hdot : Continuous (Function.uncurry
      (fun b : Belief model.Ω => fun w : ProfileInW model =>
        beliefDot b w.val)) := by
    simpa [Function.uncurry] using beliefDot_menu_uncurry_continuous model
  have hmax_cont : Continuous (fun b : Belief model.Ω =>
      sSup ((fun w : ProfileInW model => beliefDot b w.val) ''
        (↑C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sSup hdot
  have hmeas : Measurable (fun s : model.M => @maxPayoff model C s) := by
    simpa [maxPayoff] using hmax_cont.measurable.comp model.inclM_measurable
  exact hmeas.aemeasurable

private lemma minPayoff_aemeasurable
    (model : RobustTrustModel)
    (C : NonemptyCompacts (ProfileInW model)) :
    AEMeasurable (fun s : model.M => @minPayoff model C s) model.τM := by
  classical
  have hdot : Continuous (Function.uncurry
      (fun b : Belief model.Ω => fun w : ProfileInW model =>
        beliefDot b w.val)) := by
    simpa [Function.uncurry] using beliefDot_menu_uncurry_continuous model
  have hmin_cont : Continuous (fun b : Belief model.Ω =>
      sInf ((fun w : ProfileInW model => beliefDot b w.val) ''
        (↑C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sInf hdot
  have hmeas : Measurable (fun s : model.M => @minPayoff model C s) := by
    simpa [minPayoff] using hmin_cont.measurable.comp model.inclM_measurable
  exact hmeas.aemeasurable

private lemma maxPayoff_mem_Icc_ae
    (model : RobustTrustModel)
    (C : NonemptyCompacts (ProfileInW model)) :
    ∃ B : ℝ, ∀ᵐ s ∂model.τM, @maxPayoff model C s ∈ Set.Icc (-B) B := by
  classical
  rcases beliefDot_ProfileInW_mem_Icc_private_bound model with ⟨B, hB0, hB⟩
  refine ⟨B, Filter.Eventually.of_forall ?_⟩
  intro s
  let S : Set ℝ :=
    (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
      (↑C : Set (ProfileInW model))
  have hS_ne : S.Nonempty := by
    rcases C.nonempty with ⟨w, hw⟩
    exact ⟨beliefDot (model.inclM s) w.val, ⟨w, hw, rfl⟩⟩
  have hS_le : ∀ x ∈ S, x ≤ B := by
    rintro x ⟨w, hw, rfl⟩
    exact (hB (model.inclM s) w).2
  have hS_ge : ∀ x ∈ S, -B ≤ x := by
    rintro x ⟨w, hw, rfl⟩
    exact (hB (model.inclM s) w).1
  have hS_bddAbove : BddAbove S := ⟨B, hS_le⟩
  constructor
  · rcases C.nonempty with ⟨w, hw⟩
    have hx : beliefDot (model.inclM s) w.val ∈ S := ⟨w, hw, rfl⟩
    have hx_low : -B ≤ beliefDot (model.inclM s) w.val :=
      (hB (model.inclM s) w).1
    have hx_sup : beliefDot (model.inclM s) w.val ≤ sSup S :=
      le_csSup hS_bddAbove hx
    simpa [maxPayoff, S] using le_trans hx_low hx_sup
  · have hs : sSup S ≤ B := csSup_le hS_ne hS_le
    simpa [maxPayoff, S] using hs

private lemma minPayoff_mem_Icc_ae
    (model : RobustTrustModel)
    (C : NonemptyCompacts (ProfileInW model)) :
    ∃ B : ℝ, ∀ᵐ s ∂model.τM, @minPayoff model C s ∈ Set.Icc (-B) B := by
  classical
  rcases beliefDot_ProfileInW_mem_Icc_private_bound model with ⟨B, hB0, hB⟩
  refine ⟨B, Filter.Eventually.of_forall ?_⟩
  intro s
  let S : Set ℝ :=
    (fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
      (↑C : Set (ProfileInW model))
  have hS_ne : S.Nonempty := by
    rcases C.nonempty with ⟨w, hw⟩
    exact ⟨beliefDot (model.inclM s) w.val, ⟨w, hw, rfl⟩⟩
  have hS_le : ∀ x ∈ S, x ≤ B := by
    rintro x ⟨w, hw, rfl⟩
    exact (hB (model.inclM s) w).2
  have hS_ge : ∀ x ∈ S, -B ≤ x := by
    rintro x ⟨w, hw, rfl⟩
    exact (hB (model.inclM s) w).1
  have hS_bddBelow : BddBelow S := ⟨-B, hS_ge⟩
  constructor
  · have hs : -B ≤ sInf S := le_csInf hS_ne hS_ge
    simpa [minPayoff, S] using hs
  · rcases C.nonempty with ⟨w, hw⟩
    have hx : beliefDot (model.inclM s) w.val ∈ S := ⟨w, hw, rfl⟩
    have hs_inf : sInf S ≤ beliefDot (model.inclM s) w.val :=
      csInf_le hS_bddBelow hx
    have hx_hi : beliefDot (model.inclM s) w.val ≤ B :=
      (hB (model.inclM s) w).2
    simpa [minPayoff, S] using le_trans hs_inf hx_hi

private lemma maxPayoff_integrable
    (model : RobustTrustModel)
    (C : NonemptyCompacts (ProfileInW model)) :
    Integrable (fun s : model.M => @maxPayoff model C s) model.τM := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases maxPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (maxPayoff_aemeasurable model C) hB

private lemma minPayoff_integrable
    (model : RobustTrustModel)
    (C : NonemptyCompacts (ProfileInW model)) :
    Integrable (fun s : model.M => @minPayoff model C s) model.τM := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases minPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (minPayoff_aemeasurable model C) hB

private lemma integral_mem_Icc_of_integrand_mem_Icc_prob
    {α : Type*} [MeasurableSpace α] {μ : Measure α}
    [IsProbabilityMeasure μ] {f : α → ℝ} {B : ℝ}
    (hf : AEMeasurable f μ)
    (hIcc : ∀ᵐ x ∂μ, f x ∈ Set.Icc (-B) B) :
    (∫ x, f x ∂μ) ∈ Set.Icc (-B) B := by
  classical
  have hf_int : Integrable f μ := Integrable.of_mem_Icc (-B) B hf hIcc
  constructor
  · have hc_int : Integrable (fun _ : α => -B) μ := integrable_const _
    have hmono :
        (∫ x, (-B : ℝ) ∂μ) ≤ ∫ x, f x ∂μ :=
      integral_mono_ae hc_int hf_int
        (hIcc.mono fun x hx => hx.1)
    simpa using hmono
  · have hc_int : Integrable (fun _ : α => B) μ := integrable_const _
    have hmono :
        (∫ x, f x ∂μ) ≤ ∫ x, (B : ℝ) ∂μ :=
      integral_mono_ae hf_int hc_int
        (hIcc.mono fun x hx => hx.2)
    simpa using hmono

private lemma profileMap_beliefDot_mem_Icc_private_bound
    (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧
      ∀ σ : AgentStrategyM model, ∀ s m : model.M,
        beliefDot (model.inclM s) (profileMap model σ m) ∈ Set.Icc (-B) B := by
  classical
  rcases beliefDot_ProfileInW_mem_Icc_private_bound model with ⟨B, hB0, hB⟩
  refine ⟨B, hB0, ?_⟩
  intro σ s m
  simpa using hB (model.inclM s) (profileMap model σ m)

private lemma kernel_payoff_integrable_of_profile_bound
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    (σ : AgentStrategyM model)
    (s : model.M) {B : ℝ}
    (hB : ∀ σ : AgentStrategyM model, ∀ s m : model.M,
      beliefDot (model.inclM s) (profileMap model σ m) ∈ Set.Icc (-B) B) :
    Integrable
      (fun m : model.M =>
        beliefDot (model.inclM s) (profileMap model σ m))
      (β.kernel s) := by
  classical
  haveI := β.isMarkov
  have hAEM :
      AEMeasurable
        (fun m : model.M =>
          beliefDot (model.inclM s) (profileMap model σ m))
        (β.kernel s) := by
    measurability
  have hIcc :
      ∀ᵐ m ∂β.kernel s,
        beliefDot (model.inclM s) (profileMap model σ m) ∈ Set.Icc (-B) B :=
    Filter.Eventually.of_forall fun m => hB σ s m
  exact Integrable.of_mem_Icc (-B) B hAEM hIcc

private lemma kernel_payoff_integral_integrable_of_profile_bound
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    (σ : AgentStrategyM model) {B : ℝ}
    (hB : ∀ σ : AgentStrategyM model, ∀ s m : model.M,
      beliefDot (model.inclM s) (profileMap model σ m) ∈ Set.Icc (-B) B) :
    Integrable
      (fun s : model.M =>
        ∫ m : model.M,
          beliefDot (model.inclM s) (profileMap model σ m) ∂β.kernel s)
      model.τM := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI := β.isMarkov
  have hAEM :
      AEMeasurable
        (fun s : model.M =>
          ∫ m : model.M,
            beliefDot (model.inclM s) (profileMap model σ m) ∂β.kernel s)
        model.τM := by
    measurability
  have hIcc :
      ∀ᵐ s ∂model.τM,
        (∫ m : model.M,
          beliefDot (model.inclM s) (profileMap model σ m) ∂β.kernel s)
          ∈ Set.Icc (-B) B := by
    refine Filter.Eventually.of_forall ?_
    intro s
    exact integral_mem_Icc_of_integrand_mem_Icc_prob
      (μ := β.kernel s)
      (f := fun m : model.M =>
        beliefDot (model.inclM s) (profileMap model σ m))
      (B := B)
      (by measurability)
      (Filter.Eventually.of_forall fun m => hB σ s m)
  exact Integrable.of_mem_Icc (-B) B hAEM hIcc

private lemma alignedPayoffM_mem_Icc_of_profile_bound
    (model : RobustTrustModel)
    (σ : AgentStrategyM model) {B : ℝ}
    (hB : ∀ σ : AgentStrategyM model, ∀ s m : model.M,
      beliefDot (model.inclM s) (profileMap model σ m) ∈ Set.Icc (-B) B) :
    @AlignedPayoffM model σ ∈ Set.Icc (-B) B := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  unfold AlignedPayoffM
  exact integral_mem_Icc_of_integrand_mem_Icc_prob
    (μ := model.τM)
    (f := fun s : model.M =>
      beliefDot (model.inclM s) (profileMap model σ s))
    (B := B)
    (by measurability)
    (Filter.Eventually.of_forall fun s => hB σ s s)

private lemma misalignedPayoffM_mem_Icc_of_profile_bound
    (model : RobustTrustModel)
    (β : AdviserKernel model)
    (σ : AgentStrategyM model) {B : ℝ}
    (hB : ∀ σ : AgentStrategyM model, ∀ s m : model.M,
      beliefDot (model.inclM s) (profileMap model σ m) ∈ Set.Icc (-B) B) :
    @MisalignedPayoffM model β σ ∈ Set.Icc (-B) B := by
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  haveI := β.isMarkov
  unfold MisalignedPayoffM
  exact integral_mem_Icc_of_integrand_mem_Icc_prob
    (μ := model.τM)
    (f := fun s : model.M =>
      ∫ m : model.M,
        beliefDot (model.inclM s) (profileMap model σ m) ∂β.kernel s)
    (B := B)
    (by measurability)
    (by
      refine Filter.Eventually.of_forall ?_
      intro s
      exact integral_mem_Icc_of_integrand_mem_Icc_prob
        (μ := β.kernel s)
        (f := fun m : model.M =>
          beliefDot (model.inclM s) (profileMap model σ m))
        (B := B)
        (by measurability)
        (Filter.Eventually.of_forall fun m => hB σ s m))

private lemma convex_combo_mem_Icc
    {a x y B : ℝ}
    (ha0 : 0 ≤ a) (ha1 : a ≤ 1)
    (hx : x ∈ Set.Icc (-B) B)
    (hy : y ∈ Set.Icc (-B) B) :
    a * x + (1 - a) * y ∈ Set.Icc (-B) B := by
  constructor <;> nlinarith [hx.1, hx.2, hy.1, hy.2]

/- Target 1: replace the `sorry` in `hF_split` with this body. -/
have hF_split :
    MenuFunctionalF model C =
      model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
        (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
  have hα_max_int :
      Integrable
        (fun s : model.M => model.α * @maxPayoff model C s)
        model.τM :=
    (maxPayoff_integrable model C).const_mul model.α
  have h1α_min_int :
      Integrable
        (fun s : model.M => (1 - model.α) * @minPayoff model C s)
        model.τM :=
    (minPayoff_integrable model C).const_mul (1 - model.α)
  unfold MenuFunctionalF
  rw [integral_add hα_max_int h1α_min_int,
    integral_const_mul, integral_const_mul]

/- Target 2: replace the `sorry` in `hMis_per_β` with this body. -/
have hMis_per_β :
    ∀ β : AdviserKernel model,
      (∫ s, @minPayoff model C s ∂model.τM)
        ≤ @MisalignedPayoffM model β σM_C := by
  intro β
  classical
  rcases profileMap_beliefDot_mem_Icc_private_bound model with
    ⟨B, hB0, hB⟩
  unfold MisalignedPayoffM
  have hleft_int :
      Integrable (fun s : model.M => @minPayoff model C s) model.τM :=
    minPayoff_integrable model C
  have hright_int :
      Integrable
        (fun s : model.M =>
          ∫ m : model.M,
            beliefDot (model.inclM s) (profileMap model σM_C m)
              ∂β.kernel s)
        model.τM :=
    kernel_payoff_integral_integrable_of_profile_bound model β σM_C hB
  refine integral_mono_ae hleft_int hright_int ?_
  refine Filter.Eventually.of_forall ?_
  intro s
  haveI := β.isMarkov
  have hconst_int :
      Integrable
        (fun _ : model.M => @minPayoff model C s)
        (β.kernel s) :=
    integrable_const _
  have hinner_int :
      Integrable
        (fun m : model.M =>
          beliefDot (model.inclM s) (profileMap model σM_C m))
        (β.kernel s) :=
    kernel_payoff_integrable_of_profile_bound model β σM_C s hB
  have hmono :
      (∫ m : model.M, @minPayoff model C s ∂β.kernel s)
        ≤
      (∫ m : model.M,
          beliefDot (model.inclM s) (profileMap model σM_C m)
            ∂β.kernel s) := by
    exact integral_mono_ae hconst_int hinner_int
      (Filter.Eventually.of_forall fun m => hmin_point s m)
  simpa using hmono

/- Target 3: replace the whole lemma body with this proof. -/
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  classical
  rcases profileMap_beliefDot_mem_Icc_private_bound model with
    ⟨B, hB0, hB⟩
  refine ⟨B, ?_⟩
  rintro x ⟨σ, rfl⟩
  let β0 : AdviserKernel model :=
    { kernel :=
        ProbabilityTheory.Kernel.deterministic
          (id : model.M → model.M) measurable_id
      isMarkov := inferInstance }
  have hmix_bddBelow :
      BddBelow
        (Set.range
          (fun β : AdviserKernel model => @MixturePayoffM model β σ)) := by
    refine ⟨-B, ?_⟩
    rintro y ⟨β, rfl⟩
    unfold MixturePayoffM
    have hA :
        @AlignedPayoffM model σ ∈ Set.Icc (-B) B :=
      alignedPayoffM_mem_Icc_of_profile_bound model σ hB
    have hM :
        @MisalignedPayoffM model β σ ∈ Set.Icc (-B) B :=
      misalignedPayoffM_mem_Icc_of_profile_bound model β σ hB
    exact
      (convex_combo_mem_Icc
        model.α_nonneg model.α_le_one hA hM).1
  have hrob_le_mix :
      @RobustPayoffM model σ ≤ @MixturePayoffM model β0 σ := by
    unfold RobustPayoffM
    exact csInf_le hmix_bddBelow ⟨β0, rfl⟩
  have hmix_le_B :
      @MixturePayoffM model β0 σ ≤ B := by
    unfold MixturePayoffM
    have hA :
        @AlignedPayoffM model σ ∈ Set.Icc (-B) B :=
      alignedPayoffM_mem_Icc_of_profile_bound model σ hB
    have hM :
        @MisalignedPayoffM model β0 σ ∈ Set.Icc (-B) B :=
      misalignedPayoffM_mem_Icc_of_profile_bound model β0 σ hB
    exact
      (convex_combo_mem_Icc
        model.α_nonneg model.α_le_one hA hM).2
  exact le_trans hrob_le_mix hmix_le_B
