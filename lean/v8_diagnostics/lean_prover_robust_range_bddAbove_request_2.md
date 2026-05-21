You are the Lean Prover. Close ONE specific sorry: the `BddAbove (range RobustPayoffM)` helper.

## Target

```lean
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  sorry
```

## What's now available in main.lean (all PROVED in scope, place BEFORE if needed)

```lean
private lemma beliefDot_menu_uncurry_continuous (model) :
    Continuous (fun x : Belief model.Ω × ProfileInW model => beliefDot x.1 x.2.val)

private lemma profileInW_abs_le_private_bound (model) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ w : ProfileInW model, ∀ ω : model.Ω, |w.val ω| ≤ B

private lemma beliefDot_ProfileInW_abs_le_private_bound (model) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ b : Belief model.Ω, ∀ w : ProfileInW model, |beliefDot b w.val| ≤ B

private lemma maxPayoff_aemeasurable (model C) :
    AEMeasurable (fun s : model.M => maxPayoff model C s) model.τM
private lemma minPayoff_aemeasurable (model C) :
    AEMeasurable (fun s : model.M => minPayoff model C s) model.τM
private lemma maxPayoff_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, maxPayoff model C s ∈ Set.Icc (-B) B
private lemma minPayoff_mem_Icc_ae (model C) :
    ∃ B, ∀ᵐ s ∂model.τM, minPayoff model C s ∈ Set.Icc (-B) B
private lemma maxPayoff_integrable (model C) :
    Integrable (fun s : model.M => maxPayoff model C s) model.τM
private lemma minPayoff_integrable (model C) :
    Integrable (fun s : model.M => minPayoff model C s) model.τM
```

Also: `model.private_profile_bounded : ∃ C, ∀ σ ω, |profileOfPrivate σ ω| ≤ C`, `model.α_nonneg`, `model.α_le_one`, `model.τM_prob`.

## Definitions

```lean
noncomputable def AlignedPayoffM (model : RobustTrustModel) (σM : AgentStrategyM model) : ℝ :=
  ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM
-- profileMap σM s = model.profileOfPrivate (σM.sectionM s)

noncomputable def MisalignedPayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM

noncomputable def MixturePayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  model.α * AlignedPayoffM model σM + (1 - model.α) * MisalignedPayoffM model β σM

noncomputable def RobustPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM)
```

## Math sketch

Take β0 := `Kernel.deterministic id measurable_id` (identity Dirac kernel).
For β0: `MisalignedPayoffM β0 σ = ∫ s, ∫ m, beliefDot (inclM s) (profileMap σ m) ∂(Dirac s) ∂τM = ∫ s, beliefDot (inclM s) (profileMap σ s) dτM = AlignedPayoffM σ`.

So `MixturePayoffM β0 σ = α A + (1-α) A = AlignedPayoffM σ`.

Bound `AlignedPayoffM σ ≤ C` via:
- For each s: `|beliefDot (inclM s) (profileMap σ s)| ≤ C_bnd` (using model.private_profile_bounded since profileMap σ s = profileOfPrivate (σ.sectionM s) ∈ PayoffProfileSet).
- Hence ∫ beliefDot ≤ ∫ C_bnd dτM = C_bnd * τM(univ) = C_bnd (using IsProbabilityMeasure).
- This uses `MeasureTheory.integral_mono_ae` with bounded integrand and `integral_const`.

For the `BddBelow` needed for `csInf_le`:
- For any β, MixturePayoffM β σ ≥ -(α C_bnd + (1-α) C_bnd) = -C_bnd via similar bound.

Then `RobustPayoffM σ = sInf (range Mix) ≤ MixturePayoffM β0 σ = AlignedPayoffM σ ≤ C_bnd`.

## Strategy

```lean
classical
obtain ⟨C_bnd, hC_bnd⟩ := model.private_profile_bounded
haveI : IsProbabilityMeasure model.τM := model.τM_prob
refine ⟨C_bnd, ?_⟩
rintro x ⟨σ, rfl⟩
-- Show RobustPayoffM σ ≤ C_bnd
let β0 : AdviserKernel model :=
  { kernel := ProbabilityTheory.Kernel.deterministic (id : model.M → model.M) measurable_id
    isMarkov := inferInstance }
-- BddBelow witness for range MixturePayoffM
have hbdd : BddBelow (Set.range fun β : AdviserKernel model => MixturePayoffM model β σ) := by
  refine ⟨-C_bnd, ?_⟩
  rintro y ⟨β, rfl⟩
  -- |MixturePayoffM β σ| ≤ C_bnd, so MixturePayoffM β σ ≥ -C_bnd
  sorry  -- bound construction
-- RobustPayoffM σ = sInf ≤ MixturePayoffM β0 σ
have h1 : RobustPayoffM model σ ≤ MixturePayoffM model β0 σ := by
  unfold RobustPayoffM
  exact csInf_le hbdd ⟨β0, rfl⟩
-- MisalignedPayoffM β0 σ = AlignedPayoffM σ (Dirac kernel collapse)
have h2 : MisalignedPayoffM model β0 σ = AlignedPayoffM model σ := by
  unfold MisalignedPayoffM AlignedPayoffM
  refine MeasureTheory.integral_congr_ae ?_
  filter_upwards with s
  show (∫ m, beliefDot (model.inclM s) (profileMap model σ m) ∂(β0.kernel s)) = _
  rw [show β0.kernel s = Measure.dirac s from
        ProbabilityTheory.Kernel.deterministic_apply measurable_id s]
  simp
-- MixturePayoffM β0 σ = α A + (1-α) A = A
have h3 : MixturePayoffM model β0 σ = AlignedPayoffM model σ := by
  unfold MixturePayoffM
  rw [h2]
  ring
-- AlignedPayoffM σ ≤ C_bnd
have h4 : AlignedPayoffM model σ ≤ C_bnd := by
  -- |beliefDot (inclM s) (profileMap σ s)| ≤ C_bnd pointwise, then integrate
  sorry  -- integral bound
linarith [h1, h3, h4]
```

The 2 remaining sorries (BddBelow + AlignedPayoffM bound) both use the same uniform bound from `model.private_profile_bounded`. Provide the explicit construction.

## Output

```
lean_proof
target_lemma_slug: menu_value_le_strategy_sup_robust_range_bddAbove
status: PROVED | STUCK
tactics_used: [...]
```

```lean
private lemma menu_value_le_strategy_sup_robust_range_bddAbove ... := by
  -- your proof
```

May freely add private helpers (e.g., `alignedPayoffM_abs_le`, `misalignedPayoffM_abs_le` — analogous to maxPayoff_mem_Icc_ae). Aim for 80-150 lines.
