
========
ROLE: user (id=ec917114-a37b-40f3-ba5e-41b53f14450f)
========
You are the Lean Prover. Close ONE specific inline sorry — the integral linearity step inside menu_value_le_strategy_sup.

## Target inline sorry

Inside menu_value_le_strategy_sup (already wrapped):

lean
have hF_split :
    MenuFunctionalF model C =
      model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
        (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
  unfold MenuFunctionalF
  sorry


## What's available

The following are already proved in main.lean (above the splice point):

lean
private lemma beliefDot_menu_uncurry_continuous (model : RobustTrustModel) :
    Continuous (fun x : Belief model.Ω × ProfileInW model => beliefDot x.1 x.2.val)

private lemma menu_integrand_aemeasurable (model C) :
    AEMeasurable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM
  -- Proof uses IsCompact.continuous_sSup/_sInf to derive
  -- hmax_meas, hmin_meas : Measurable (fun s => max/minPayoff model C s)

private lemma menu_integrand_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∈ Icc (-B) B

private lemma menu_integrand_integrable (model C) :
    Integrable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM


Also available: model.private_profile_bounded : ∃ C, ∀ σ ω, |profileOfPrivate σ ω| ≤ C, model.α_nonneg, model.α_le_one, model.τM_prob : IsProbabilityMeasure τM.

MenuFunctionalF model C := ∫ s, model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∂model.τM.

## Strategy

1. Define new private helpers RIGHT BEFORE menu_value_le_strategy_sup (you'll provide them):
   - maxPayoff_aemeasurable model C : AEMeasurable (fun s => maxPayoff model C s) model.τM
   - minPayoff_aemeasurable model C : AEMeasurable (fun s => minPayoff model C s) model.τM
   - maxPayoff_integrable model C : Integrable (fun s => maxPayoff model C s) model.τM
   - minPayoff_integrable model C : Integrable (fun s => minPayoff model C s) model.τM

   These mirror the structure of menu_integrand_aemeasurable and use Integrable.of_mem_Icc with bounds.
   
   **Critical placement constraint**: these helpers must appear BEFORE menu_value_le_strategy_sup_robust_range_bddAbove (line 1287 currently) AND must reference beliefDot_menu_uncurry_continuous (at line 1681). So you'll need to MOVE beliefDot_menu_uncurry_continuous before the helpers (move it before line 1287).

   For boundedness: derive a uniform bound B from model.private_profile_bounded (similar to menu_integrand_mem_Icc_ae's proof — which uses per-coord max + Finset.sup' + sum-over-Ω bound). The cleanest factoring:
   

lean
-- Boundedness on ProfileInW (uniform across w ∈ ProfileInW model):
private lemma profileInW_abs_le_private_bound (model) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ w : ProfileInW model, ∀ ω : model.Ω, |w.val ω| ≤ B
-- Proof: w.val ∈ PayoffProfileSet = range profileOfPrivate, so |w.val ω| = |profileOfPrivate σ ω| ≤ C
-- for some σ in the preimage.

-- Boundedness on beliefDot (∀ b ∈ Belief Ω, ∀ w ∈ ProfileInW model):
private lemma beliefDot_ProfileInW_abs_le_private_bound (model) :
    ∃ B, 0 ≤ B ∧ ∀ b : Belief model.Ω, ∀ w : ProfileInW model, |beliefDot b w.val| ≤ B
-- Proof: probability simplex + previous lemma.

-- Apply to max/min:
private lemma maxPayoff_mem_Icc_ae (model C) : ∃ B, ∀ᵐ s ∂τM, maxPayoff model C s ∈ Icc (-B) B
private lemma minPayoff_mem_Icc_ae (model C) : ∃ B, ∀ᵐ s ∂τM, minPayoff model C s ∈ Icc (-B) B
-- These follow from previous + sSup/sInf of bounded sets.

private lemma maxPayoff_integrable (model C) : Integrable (fun s => maxPayoff model C s) τM :=
  Integrable.of_mem_Icc ...
private lemma minPayoff_integrable (model C) : Integrable (fun s => minPayoff model C s) τM := ...


2. Then hF_split body becomes:

lean
have hF_split : ... := by
  have hα_max_int : Integrable (fun s => model.α * maxPayoff model C s) model.τM :=
    (maxPayoff_integrable model C).const_mul model.α
  have h1α_min_int : Integrable (fun s => (1 - model.α) * minPayoff model C s) model.τM :=
    (minPayoff_integrable model C).const_mul (1 - model.α)
  unfold MenuFunctionalF
  rw [integral_add hα_max_int h1α_min_int, integral_const_mul, integral_const_mul]


## Output

Provide ONE Lean code block containing:
1. The 6 helper lemmas (profileInW_abs_le_private_bound, beliefDot_ProfileInW_abs_le_private_bound, maxPayoff_aemeasurable, minPayoff_aemeasurable, maxPayoff_mem_Icc_ae, minPayoff_mem_Icc_ae, maxPayoff_integrable, minPayoff_integrable).
2. The hF_split body (just the proof, to be spliced inline).

Do NOT include namespace wrappers (already inside RobustTrustV8).

**CRITICAL**: do NOT use NonemptyCompacts (ProfileInW model) — use CompactMenu model instead (which IS NonemptyCompacts (ProfileInW model) via abbrev).


lean_proof
target_lemma_slug: hF_split_with_individual_integrability
status: PROVED | STUCK
tactics_used: [...]


Aim for 100-150 lines.

Show more

========
ROLE: assistant (id=98a4ddd1-103c-48e0-bc64-2e4edf361ce6)
========
lean
private lemma profileInW_abs_le_private_bound (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ w : ProfileInW model, ∀ ω : model.Ω, |w.val ω| ≤ B := by
  rcases model.private_profile_bounded with ⟨B0, hB0⟩
  refine ⟨max B0 0, le_max_right B0 0, ?_⟩
  intro w ω
  rcases (by simpa [PayoffProfileSet] using w.property) with ⟨σ, hσ⟩
  calc
    |w.val ω| = |profileOfPrivate σ ω| := by
      rw [← hσ]
    _ ≤ B0 := hB0 σ ω
    _ ≤ max B0 0 := le_max_left B0 0

private lemma beliefDot_ProfileInW_abs_le_private_bound (model : RobustTrustModel) :
    ∃ B : ℝ, 0 ≤ B ∧
      ∀ b : Belief model.Ω, ∀ w : ProfileInW model, |beliefDot b w.val| ≤ B := by
  rcases profileInW_abs_le_private_bound model with ⟨B, hB_nonneg, hB⟩
  refine ⟨B, hB_nonneg, ?_⟩
  intro b w
  have hb_nonneg : ∀ ω : model.Ω, 0 ≤ b.val ω := by
    intro ω
    exact b.property.1 ω
  have hb_sum : (∑ ω : model.Ω, b.val ω) = 1 := by
    exact b.property.2
  unfold beliefDot
  calc
    |∑ ω : model.Ω, b.val ω * w.val ω|
        ≤ ∑ ω : model.Ω, |b.val ω * w.val ω| := by
          exact Finset.abs_sum_le_sum_abs
            (s := Finset.univ)
            (f := fun ω : model.Ω => b.val ω * w.val ω)
    _ = ∑ ω : model.Ω, b.val ω * |w.val ω| := by
          apply Finset.sum_congr rfl
          intro ω _hω
          rw [abs_mul, abs_of_nonneg (hb_nonneg ω)]
    _ ≤ ∑ ω : model.Ω, b.val ω * B := by
          apply Finset.sum_le_sum
          intro ω _hω
          exact mul_le_mul_of_nonneg_left (hB w ω) (hb_nonneg ω)
    _ = B := by
          rw [← Finset.sum_mul, hb_sum, one_mul]

private lemma maxPayoff_aemeasurable
    (model : RobustTrustModel) (C : CompactMenu model) :
    AEMeasurable (fun s => maxPayoff model C s) model.τM := by
  have hcont :
      Continuous
        (fun s : Belief model.Ω =>
          sSup
            ((fun w : ProfileInW model => beliefDot s w.val) ''
              (C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sSup
      (f := fun (s : Belief model.Ω) (w : ProfileInW model) => beliefDot s w.val)
      (beliefDot_menu_uncurry_continuous model)
  simpa [maxPayoff] using hcont.aemeasurable

private lemma minPayoff_aemeasurable
    (model : RobustTrustModel) (C : CompactMenu model) :
    AEMeasurable (fun s => minPayoff model C s) model.τM := by
  have hcont :
      Continuous
        (fun s : Belief model.Ω =>
          sInf
            ((fun w : ProfileInW model => beliefDot s w.val) ''
              (C : Set (ProfileInW model)))) :=
    C.isCompact.continuous_sInf
      (f := fun (s : Belief model.Ω) (w : ProfileInW model) => beliefDot s w.val)
      (beliefDot_menu_uncurry_continuous model)
  simpa [minPayoff] using hcont.aemeasurable

private lemma maxPayoff_mem_Icc_ae
    (model : RobustTrustModel) (C : CompactMenu model) :
    ∃ B : ℝ, ∀ᵐ s ∂model.τM, maxPayoff model C s ∈ Icc (-B) B := by
  rcases beliefDot_ProfileInW_abs_le_private_bound model with ⟨B, _hB_nonneg, hB⟩
  refine ⟨B, Filter.Eventually.of_forall ?_⟩
  intro s
  let S : Set ℝ :=
    (fun w : ProfileInW model => beliefDot s w.val) '' (C : Set (ProfileInW model))
  have hS_nonempty : S.Nonempty := by
    rcases C.nonempty with ⟨w0, hw0⟩
    exact ⟨beliefDot s w0.val, ⟨w0, hw0, rfl⟩⟩
  have hS_upper : ∀ y ∈ S, y ≤ B := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB s w)).2
  have hS_lower : ∀ y ∈ S, -B ≤ y := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB s w)).1
  have hS_bddAbove : BddAbove S := ⟨B, hS_upper⟩
  have hmax_le : sSup S ≤ B :=
    csSup_le hS_nonempty hS_upper
  have hle_max : -B ≤ sSup S := by
    rcases hS_nonempty with ⟨y, hy⟩
    exact le_trans (hS_lower y hy) (le_csSup hS_bddAbove hy)
  refine ⟨?_, ?_⟩
  · simpa [maxPayoff, S] using hle_max
  · simpa [maxPayoff, S] using hmax_le

private lemma minPayoff_mem_Icc_ae
    (model : RobustTrustModel) (C : CompactMenu model) :
    ∃ B : ℝ, ∀ᵐ s ∂model.τM, minPayoff model C s ∈ Icc (-B) B := by
  rcases beliefDot_ProfileInW_abs_le_private_bound model with ⟨B, _hB_nonneg, hB⟩
  refine ⟨B, Filter.Eventually.of_forall ?_⟩
  intro s
  let S : Set ℝ :=
    (fun w : ProfileInW model => beliefDot s w.val) '' (C : Set (ProfileInW model))
  have hS_nonempty : S.Nonempty := by
    rcases C.nonempty with ⟨w0, hw0⟩
    exact ⟨beliefDot s w0.val, ⟨w0, hw0, rfl⟩⟩
  have hS_upper : ∀ y ∈ S, y ≤ B := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB s w)).2
  have hS_lower : ∀ y ∈ S, -B ≤ y := by
    rintro y ⟨w, _hw, rfl⟩
    exact (abs_le.mp (hB s w)).1
  have hS_bddBelow : BddBelow S := ⟨-B, hS_lower⟩
  have hle_min : -B ≤ sInf S :=
    le_csInf hS_nonempty hS_lower
  have hmin_le : sInf S ≤ B := by
    rcases hS_nonempty with ⟨y, hy⟩
    exact le_trans (csInf_le hS_bddBelow hy) (hS_upper y hy)
  refine ⟨?_, ?_⟩
  · simpa [minPayoff, S] using hle_min
  · simpa [minPayoff, S] using hmin_le

private lemma maxPayoff_integrable
    (model : RobustTrustModel) (C : CompactMenu model) :
    Integrable (fun s => maxPayoff model C s) model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases maxPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (maxPayoff_aemeasurable model C) hB

private lemma minPayoff_integrable
    (model : RobustTrustModel) (C : CompactMenu model) :
    Integrable (fun s => minPayoff model C s) model.τM := by
  haveI : IsProbabilityMeasure model.τM := model.τM_prob
  rcases minPayoff_mem_Icc_ae model C with ⟨B, hB⟩
  exact Integrable.of_mem_Icc (-B) B (minPayoff_aemeasurable model C) hB

-- hF_split body:
by
  have hα_max_int :
      Integrable (fun s => model.α * maxPayoff model C s) model.τM :=
    (maxPayoff_integrable model C).const_mul model.α
  have h1α_min_int :
      Integrable (fun s => (1 - model.α) * minPayoff model C s) model.τM :=
    (minPayoff_integrable model C).const_mul (1 - model.α)
  unfold MenuFunctionalF
  rw [integral_add hα_max_int h1α_min_int, integral_const_mul, integral_const_mul]

lean_proof
target_lemma_slug: hF_split_with_individual_integrability
status: PROVED
tactics_used: [rcases, refine, calc, rw, simpa, unfold, Finset.sum_congr, Finset.sum_le_sum, IsCompact.continuous_sSup, IsCompact.continuous_sInf, Filter.Eventually.of_forall, csSup_le, le_csSup, le_csInf, csInf_le, Integrable.of_mem_Icc, integral_add, integral_const_mul]
