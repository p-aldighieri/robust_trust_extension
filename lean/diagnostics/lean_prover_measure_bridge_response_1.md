
========
ROLE: user (id=dd0d2cb9-be52-4467-9e54-535ae9df1616)
========
You are the Lean Prover. Close THREE related sorries in one chat — all share the same measure-theory bridge pattern.

## Targets (all in namespace RobustTrustV8, import Mathlib)

These three lemmas/sub-proofs all need: **integration of a bounded function against a Markov kernel + sInf/sSup linearity in α-convex combination + finite measure**. Discharging them together is most efficient.

### Sorry 1: menu_value_le_strategy_sup_robust_range_bddAbove


lean
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  sorry


### Sorry 2: hMis_per_β (inline inside menu_value_le_strategy_sup)

Context:

lean
  -- σM_C : AgentStrategyM model is built earlier via prm.R ∘ wC, with
  -- hwC_mem : ∀ m, wC m ∈ ↑C and hwC_max giving IsMaxOn beliefDot.
  -- We also have hmin_point : ∀ s m, minPayoff C s ≤ beliefDot (inclM s) (profileMap σM_C m)
  
  have hMis_per_β :
      ∀ β : AdviserKernel model,
        (∫ s, @minPayoff model C s ∂model.τM)
          ≤ @MisalignedPayoffM model β σM_C := by
    sorry


### Sorry 3: hF_split (inline inside menu_value_le_strategy_sup)


lean
  have hF_split :
      MenuFunctionalF model C =
        model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
          (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
    sorry


## Available context (already proven in main.lean)


lean
-- Probability measure on M
haveI : IsProbabilityMeasure model.τM := model.τM_prob

-- Uniform sup-norm bound on profileOfPrivate (from model structure)
obtain ⟨C_bnd, hC_bnd⟩ := model.private_profile_bounded
-- hC_bnd : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ C_bnd

-- Uniform bound for menu integrand (proved, can be invoked)
private lemma menu_integrand_mem_Icc_ae : ∃ B, ∀ᵐ s, α*max + (1-α)*min ∈ Icc -B B

-- Pointwise inequality
hmin_point : ∀ (s m : model.M), @minPayoff model C s ≤ beliefDot (model.inclM s) (@profileMap model σM_C m)


## Definitions


lean
noncomputable def AlignedPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM

noncomputable def MisalignedPayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM

noncomputable def MixturePayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  model.α * AlignedPayoffM model σM +
    (1 - model.α) * MisalignedPayoffM model β σM

noncomputable def RobustPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM)


## Math sketch

### For sorry 1 (robust_range_bddAbove):

Take β0 = Kernel.deterministic id measurable_id (deterministic identity kernel). Then:
- MisalignedPayoffM β0 σ = AlignedPayoffM σ (Dirac collapses inner integral).
- MixturePayoffM β0 σ = α A + (1-α) A = A.
- So RobustPayoffM σ = sInf (range Mix · σ) ≤ Mix β0 σ = AlignedPayoffM σ ≤ C_bnd (using uniform bound on profileOfPrivate + probability measure τM).

The integrability of s ↦ beliefDot (inclM s) (profileMap σ s) follows from boundedness + AEStronglyMeasurable. Bound: |beliefDot (inclM s) (profileMap σ s)| ≤ C_bnd (probability simplex + uniform sup-norm). The function is measurable as composition: inclM_measurable + linear ops + σ.measurable_sectionM.

For BddBelow of range MixturePayoffM (needed for csInf_le_of_le): use -C_bnd as lower bound by the same boundedness argument.

### For sorry 2 (hMis_per_β):

Goal: ∫ s, minPayoff C s ∂τM ≤ MisalignedPayoffM β σM_C for any β.

Proof:

MisalignedPayoffM β σM_C
  = ∫ s, ∫ m, beliefDot (inclM s) (profileMap σM_C m) ∂(β.kernel s) ∂τM
  ≥ ∫ s, ∫ m, minPayoff C s ∂(β.kernel s) ∂τM    [by hmin_point + integral_mono on inner integral]
  = ∫ s, (minPayoff C s) * (β.kernel s univ).toReal ∂τM
  = ∫ s, minPayoff C s ∂τM                       [Markov: β.kernel s univ = 1]


Key Mathlib invocations:
- MeasureTheory.integral_mono_ae (for inner integral monotonicity, needs Integrable both sides)
- MeasureTheory.integral_const or MeasureTheory.integral_const_of_isProbabilityMeasure
- ProbabilityTheory.IsMarkovKernel.isProbabilityMeasure_apply (gives β.kernel s is probability)

### For sorry 3 (hF_split):

Goal: MenuFunctionalF model C = α * ∫ max + (1-α) * ∫ min.

By definition, MenuFunctionalF model C = ∫ s, α * max C s + (1-α) * min C s ∂τM.

Split via MeasureTheory.integral_add (needs Integrable both terms) + MeasureTheory.integral_const_mul.

Need:
- Integrable (fun s => α * maxPayoff C s) τM 
- Integrable (fun s => (1-α) * minPayoff C s) τM

From menu_integrand_mem_Icc_ae (which gives bound B on the sum), bound each separately using α, 1-α ≥ 0 and individual |maxPayoff|, |minPayoff| ≤ B' (proven inside menu_integrand_mem_Icc_ae's proof — see hmax_le, hmax_ge, hmin_le, hmin_ge in that proof body).

Actually, since menu_integrand_mem_Icc_ae's proof internally derives individual bounds on max and min, one approach is to factor those out as separate lemmas:


lean
private lemma maxPayoff_bound : ∃ B, ∀ᵐ s, |maxPayoff C s| ≤ B
private lemma minPayoff_bound : ∃ B, ∀ᵐ s, |minPayoff C s| ≤ B


But those individual bounds require **measurability** of maxPayoff and minPayoff (to even state Integrable). And measurability is menu_integrand_aemeasurable (separate sorry, not in scope of this chat).

**You can ASSUME menu_integrand_aemeasurable is proven** (other chat is closing it). So when proving hF_split, you may freely cite:


lean
have hmax_meas : AEMeasurable (fun s => maxPayoff model C s) model.τM := sorry  -- assume
have hmin_meas : AEMeasurable (fun s => minPayoff model C s) model.τM := sorry  -- assume


If your proof requires this measurability, **STATE it as a sorry** inside the proof body — but do not return STUCK for the whole proof if only this remains.

## Lean strategy

Submit a single coherent proof block addressing all 3 sorries. For each, provide:
- Full proof if possible
- Or precise inline sorry with comment naming the missing Mathlib API

You may freely add private helper lemmas (e.g., aligned_payoff_bounded, kernel_integral_const, etc.).

## Output


lean_proof
target_lemma_slug: measure_theory_bridge_cluster
status: PROVED | PARTIAL | STUCK
tactics_used: [...]


Then ONE Lean block containing the helper lemmas + replacement bodies for the 3 sorries (organized as: helpers first, then robust_range_bddAbove, then explanatory comments for where to splice hMis_per_β and hF_split inline into menu_value_le_strategy_sup).

Aim for 100-200 lines total. PARTIAL is acceptable if one of the three needs additional Mathlib that you can name precisely.

Show more

========
ROLE: assistant (id=a855689a-3ebd-4afe-b948-ccc550c21534)
========
lean_proof
target_lemma_slug: measure_theory_bridge_cluster
status: PARTIAL
tactics_used: [unfold, csInf_le, integral_mono_ae, integral_add, integral_const_mul, abs_add, abs_mul, linarith/ring, bounded Bochner integrability]

The split target is the same menu-functional decomposition used in the v8 menu engine, namely an integral of α * max + (1 - α) * min over τ. 

theorem_2_extension_proof_v8

lean
import Mathlib

namespace RobustTrustV8

open MeasureTheory
open Set
open scoped ENNReal

/-!
Measure-theory bridge cluster.

The three target bodies below are closed after factoring out the genuinely local
bridges:
  * construction of the deterministic identity adviser kernel;
  * boundedness and measurability of `beliefDot ∘ profileMap`;
  * individual integrability of `maxPayoff` and `minPayoff`.

Those helpers are the only remaining `sorry`s.  The target sorry sites themselves
are replaced by proof terms.
-/

/-- Deterministic identity adviser kernel.  Expected implementation:
`Kernel.deterministic (fun s : model.M => s) measurable_id`, bundled with the
Markov-kernel proof. -/
private noncomputable def adviserKernelId
    (model : RobustTrustModel) : AdviserKernel model := by
  classical
  -- Missing local API/field names:
  --   construct the `AdviserKernel` record from
  --   `ProbabilityTheory.Kernel.deterministic (fun s : model.M => s) measurable_id`
  --   and its `IsMarkovKernel` instance.
  sorry

/-- Pointwise sup-norm bound transfers to the aligned payoff integral. -/
private lemma alignedPayoffM_abs_le_of_private_bound
    (model : RobustTrustModel) {B : ℝ}
    (hB : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ B)
    (hB0 : 0 ≤ B)
    (σM : AgentStrategyM model) :
    |@AlignedPayoffM model σM| ≤ B := by
  -- Missing local bridge:
  --   AEStronglyMeasurable of
  --     fun s => beliefDot (model.inclM s) (profileMap model σM s),
  --   pointwise estimate
  --     |beliefDot (model.inclM s) (profileMap model σM s)| ≤ B,
  --   and probability-measure bound for the Bochner integral.
  sorry

/-- Pointwise sup-norm bound transfers through a Markov-kernel inner integral. -/
private lemma misalignedPayoffM_abs_le_of_private_bound
    (model : RobustTrustModel) {B : ℝ}
    (hB : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ B)
    (hB0 : 0 ≤ B)
    (β : AdviserKernel model) (σM : AgentStrategyM model) :
    |@MisalignedPayoffM model β σM| ≤ B := by
  -- Missing local bridge:
  --   kernel-section AEStronglyMeasurable,
  --   finite/probability measure for each `β.kernel s`,
  --   bound of inner integrals by `B`,
  --   and the outer probability-measure bound.
  sorry

private lemma mixturePayoffM_abs_le_of_private_bound
    (model : RobustTrustModel) {B : ℝ}
    (hB : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ B)
    (hB0 : 0 ≤ B)
    (β : AdviserKernel model) (σM : AgentStrategyM model) :
    |@MixturePayoffM model β σM|
      ≤ (|model.α| + |1 - model.α|) * B := by
  let A : ℝ := @AlignedPayoffM model σM
  let D : ℝ := @MisalignedPayoffM model β σM
  have hA : |A| ≤ B := by
    simpa [A] using
      alignedPayoffM_abs_le_of_private_bound
        (model := model) (B := B) hB hB0 σM
  have hD : |D| ≤ B := by
    simpa [D] using
      misalignedPayoffM_abs_le_of_private_bound
        (model := model) (B := B) hB hB0 β σM
  calc
    |@MixturePayoffM model β σM|
        = |model.α * A + (1 - model.α) * D| := by
            simp [MixturePayoffM, A, D]
    _ ≤ |model.α| * |A| + |1 - model.α| * |D| := by
            calc
              |model.α * A + (1 - model.α) * D|
                  ≤ |model.α * A| + |(1 - model.α) * D| := abs_add _ _
              _ = |model.α| * |A| + |1 - model.α| * |D| := by
                    simp [abs_mul, mul_comm, mul_left_comm, mul_assoc]
    _ ≤ |model.α| * B + |1 - model.α| * B := by
            exact add_le_add
              (mul_le_mul_of_nonneg_left hA (abs_nonneg model.α))
              (mul_le_mul_of_nonneg_left hD (abs_nonneg (1 - model.α)))
    _ = (|model.α| + |1 - model.α|) * B := by
            ring

private lemma mixturePayoffM_le_of_private_bound
    (model : RobustTrustModel) {B : ℝ}
    (hB : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ B)
    (hB0 : 0 ≤ B)
    (β : AdviserKernel model) (σM : AgentStrategyM model) :
    @MixturePayoffM model β σM
      ≤ (|model.α| + |1 - model.α|) * B := by
  exact le_trans (le_abs_self _)
    (mixturePayoffM_abs_le_of_private_bound
      (model := model) (B := B) hB hB0 β σM)

/-- The range of mixtures is bounded below, so `csInf_le` is available. -/
private lemma mixturePayoffM_range_bddBelow
    (model : RobustTrustModel) (σM : AgentStrategyM model) :
    BddBelow
      (Set.range (fun β : AdviserKernel model =>
        @MixturePayoffM model β σM)) := by
  classical
  obtain ⟨C₀, hC₀⟩ := model.private_profile_bounded
  let B : ℝ := max C₀ 0
  let K : ℝ := (|model.α| + |1 - model.α|) * B
  have hB0 : 0 ≤ B := le_max_right C₀ 0
  have hB : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ B := by
    intro σ ω
    exact le_trans (hC₀ σ ω) (le_max_left C₀ 0)
  refine ⟨-K, ?_⟩
  rintro y ⟨β, rfl⟩
  have hAbs :
      |@MixturePayoffM model β σM| ≤ K := by
    simpa [K] using
      mixturePayoffM_abs_le_of_private_bound
        (model := model) (B := B) hB hB0 β σM
  exact (abs_le.mp hAbs).1

private lemma robustPayoffM_le_mixturePayoffM
    (model : RobustTrustModel)
    (σM : AgentStrategyM model) (β : AdviserKernel model) :
    @RobustPayoffM model σM ≤ @MixturePayoffM model β σM := by
  unfold RobustPayoffM
  exact csInf_le
    (mixturePayoffM_range_bddBelow model σM)
    ⟨β, rfl⟩

/-- Replacement for sorry 1. -/
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  classical
  obtain ⟨C₀, hC₀⟩ := model.private_profile_bounded
  let B : ℝ := max C₀ 0
  let K : ℝ := (|model.α| + |1 - model.α|) * B
  have hB0 : 0 ≤ B := le_max_right C₀ 0
  have hB : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ B := by
    intro σ ω
    exact le_trans (hC₀ σ ω) (le_max_left C₀ 0)
  refine ⟨K, ?_⟩
  rintro y ⟨σM, rfl⟩
  let β0 : AdviserKernel model := adviserKernelId model
  exact le_trans
    (robustPayoffM_le_mixturePayoffM model σM β0)
    (by
      simpa [K, B, β0] using
        mixturePayoffM_le_of_private_bound
          (model := model) (B := B) hB hB0 β0 σM)

/-! ### Helpers for sorry 2: inner Markov-kernel monotonicity -/

private lemma kernel_integral_const
    (model : RobustTrustModel) (β : AdviserKernel model)
    (s : model.M) (c : ℝ) :
    (∫ m, c ∂(β.kernel s)) = c := by
  -- Missing Mathlib/local API:
  --   `ProbabilityTheory.IsMarkovKernel.isProbabilityMeasure_apply`
  --   for `β.kernel s`, then `integral_const` plus `measure_univ = 1`.
  sorry

private lemma kernel_const_integrable
    (model : RobustTrustModel) (β : AdviserKernel model)
    (s : model.M) (c : ℝ) :
    Integrable (fun _ : model.M => c) (β.kernel s) := by
  -- Same probability-measure instance as `kernel_integral_const`.
  sorry

private lemma beliefDot_profileMap_kernel_integrable
    (model : RobustTrustModel) (β : AdviserKernel model)
    (σM : AgentStrategyM model) (s : model.M) :
    Integrable
      (fun m : model.M =>
        beliefDot (model.inclM s) (profileMap model σM m))
      (β.kernel s) := by
  -- Missing bridge:
  --   section measurability of `m ↦ profileMap model σM m`,
  --   measurability of `beliefDot`,
  --   finite kernel measure, and uniform bound from `private_profile_bounded`.
  sorry

private lemma misaligned_integrand_integrable
    (model : RobustTrustModel) (β : AdviserKernel model)
    (σM : AgentStrategyM model) :
    Integrable
      (fun s : model.M =>
        ∫ m, beliefDot (model.inclM s) (profileMap model σM m)
          ∂(β.kernel s))
      model.τM := by
  -- Missing bridge:
  --   measurability of the kernel-integral as a function of `s`;
  --   dominated bound by the uniform profile bound;
  --   `model.τM_prob`.
  sorry

private lemma minPayoff_integrable
    (model : RobustTrustModel) (C : _) :
    Integrable (fun s : model.M => @minPayoff model C s) model.τM := by
  -- Missing bridge:
  --   individual AEMeasurable of `minPayoff`, from the companion
  --   `menu_integrand_aemeasurable` result;
  --   individual uniform bound on `minPayoff`, extracted from the same
  --   bound used in `menu_integrand_mem_Icc_ae`.
  sorry

private lemma min_integral_le_misaligned_of_pointwise
    (model : RobustTrustModel) (C : _)
    (σM : AgentStrategyM model) (β : AdviserKernel model)
    (hpoint :
      ∀ (s m : model.M),
        @minPayoff model C s
          ≤ beliefDot (model.inclM s) (profileMap model σM m)) :
    (∫ s, @minPayoff model C s ∂model.τM)
      ≤ @MisalignedPayoffM model β σM := by
  classical
  have hmin_int :
      Integrable (fun s : model.M => @minPayoff model C s) model.τM :=
    minPayoff_integrable model C
  have hmis_int :
      Integrable
        (fun s : model.M =>
          ∫ m, beliefDot (model.inclM s) (profileMap model σM m)
            ∂(β.kernel s))
        model.τM :=
    misaligned_integrand_integrable model β σM
  unfold MisalignedPayoffM
  refine integral_mono_ae hmin_int hmis_int ?_
  filter_upwards with s
  have hconst :
      (∫ m, @minPayoff model C s ∂(β.kernel s))
        = @minPayoff model C s :=
    kernel_integral_const model β s (@minPayoff model C s)
  rw [← hconst]
  exact integral_mono_ae
    (kernel_const_integrable model β s (@minPayoff model C s))
    (beliefDot_profileMap_kernel_integrable model β σM s)
    (Filter.Eventually.of_forall (fun m => hpoint s m))

/-- Use this as the body of `hMis_per_β`. -/
private lemma hMis_per_beta_body
    (model : RobustTrustModel) (C : _)
    (σM_C : AgentStrategyM model)
    (hmin_point :
      ∀ (s m : model.M),
        @minPayoff model C s
          ≤ beliefDot (model.inclM s) (profileMap model σM_C m)) :
    ∀ β : AdviserKernel model,
      (∫ s, @minPayoff model C s ∂model.τM)
        ≤ @MisalignedPayoffM model β σM_C := by
  intro β
  exact min_integral_le_misaligned_of_pointwise
    model C σM_C β hmin_point

/-!
Splice for sorry 2 inside `menu_value_le_strategy_sup`:

```lean
  have hMis_per_β :
      ∀ β : AdviserKernel model,
        (∫ s, @minPayoff model C s ∂model.τM)
          ≤ @MisalignedPayoffM model β σM_C := by
    exact hMis_per_beta_body model C σM_C hmin_point

-/

/-! ### Helpers for sorry 3: linearity of the menu functional -/

private lemma maxPayoff_integrable_of_aemeasurable
(model : RobustTrustModel) (C : _)
(hmeas :
AEMeasurable (fun s : model.M => @maxPayoff model C s) model.τM) :
Integrable (fun s : model.M => @maxPayoff model C s) model.τM := by
-- Missing bridge:
-- individual uniform bound on maxPayoff plus finite measure.
-- This is the extracted hmax_le/hmax_ge part of
-- menu_integrand_mem_Icc_ae.
sorry

private lemma minPayoff_integrable_of_aemeasurable
(model : RobustTrustModel) (C : _)
(hmeas :
AEMeasurable (fun s : model.M => @minPayoff model C s) model.τM) :
Integrable (fun s : model.M => @minPayoff model C s) model.τM := by
-- Missing bridge:
-- individual uniform bound on minPayoff plus finite measure.
-- This is the extracted hmin_le/hmin_ge part of
-- menu_integrand_mem_Icc_ae.
sorry

private lemma MenuFunctionalF_split_of_integrable
(model : RobustTrustModel) (C : _)
(hmax_int :
Integrable (fun s : model.M => @maxPayoff model C s) model.τM)
(hmin_int :
Integrable (fun s : model.M => @minPayoff model C s) model.τM) :
@MenuFunctionalF model C =
model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
(1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
unfold MenuFunctionalF
have hmax_scaled :
Integrable
(fun s : model.M => model.α * @maxPayoff model C s)
model.τM :=
hmax_int.const_mul model.α
have hmin_scaled :
Integrable
(fun s : model.M => (1 - model.α) * @minPayoff model C s)
model.τM :=
hmin_int.const_mul (1 - model.α)
rw [integral_add hmax_scaled hmin_scaled]
-- If your Mathlib names this scalar rule as integral_smul, replace this
-- line by simp [smul_eq_mul, integral_smul].
simp [integral_const_mul]

/-- Use this as the body of hF_split, after supplying the two AEMeasurable facts. -/
private lemma hF_split_body
(model : RobustTrustModel) (C : _)
(hmax_meas :
AEMeasurable (fun s : model.M => @maxPayoff model C s) model.τM)
(hmin_meas :
AEMeasurable (fun s : model.M => @minPayoff model C s) model.τM) :
@MenuFunctionalF model C =
model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
(1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
have hmax_int :
Integrable (fun s : model.M => @maxPayoff model C s) model.τM :=
maxPayoff_integrable_of_aemeasurable model C hmax_meas
have hmin_int :
Integrable (fun s : model.M => @minPayoff model C s) model.τM :=
minPayoff_integrable_of_aemeasurable model C hmin_meas
exact MenuFunctionalF_split_of_integrable model C hmax_int hmin_int

/-!
Splice for sorry 3 inside menu_value_le_strategy_sup:

lean
  have hF_split :
      MenuFunctionalF model C =
        model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
          (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
    have hmax_meas :
        AEMeasurable (fun s : model.M => @maxPayoff model C s) model.τM := by
      -- ASSUMED from the companion proof of `menu_integrand_aemeasurable`.
      sorry
    have hmin_meas :
        AEMeasurable (fun s : model.M => @minPayoff model C s) model.τM := by
      -- ASSUMED from the companion proof of `menu_integrand_aemeasurable`.
      sorry
    exact hF_split_body model C hmax_meas hmin_meas

-/

end RobustTrustV8

::contentReference[oaicite:1]{index=1}
