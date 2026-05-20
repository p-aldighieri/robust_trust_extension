You are the Lean Prover. Close THREE related sorries in one chat — all share the same measure-theory bridge pattern.

## Targets (all in namespace RobustTrustV8, import Mathlib)

These three lemmas/sub-proofs all need: **integration of a bounded function against a Markov kernel + sInf/sSup linearity in α-convex combination + finite measure**. Discharging them together is most efficient.

### Sorry 1: `menu_value_le_strategy_sup_robust_range_bddAbove`

```lean
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  sorry
```

### Sorry 2: `hMis_per_β` (inline inside `menu_value_le_strategy_sup`)

Context:
```lean
  -- σM_C : AgentStrategyM model is built earlier via prm.R ∘ wC, with
  -- hwC_mem : ∀ m, wC m ∈ ↑C and hwC_max giving IsMaxOn beliefDot.
  -- We also have hmin_point : ∀ s m, minPayoff C s ≤ beliefDot (inclM s) (profileMap σM_C m)
  
  have hMis_per_β :
      ∀ β : AdviserKernel model,
        (∫ s, @minPayoff model C s ∂model.τM)
          ≤ @MisalignedPayoffM model β σM_C := by
    sorry
```

### Sorry 3: `hF_split` (inline inside `menu_value_le_strategy_sup`)

```lean
  have hF_split :
      MenuFunctionalF model C =
        model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
          (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
    sorry
```

## Available context (already proven in main.lean)

```lean
-- Probability measure on M
haveI : IsProbabilityMeasure model.τM := model.τM_prob

-- Uniform sup-norm bound on profileOfPrivate (from model structure)
obtain ⟨C_bnd, hC_bnd⟩ := model.private_profile_bounded
-- hC_bnd : ∀ σ ω, |model.profileOfPrivate σ ω| ≤ C_bnd

-- Uniform bound for menu integrand (proved, can be invoked)
private lemma menu_integrand_mem_Icc_ae : ∃ B, ∀ᵐ s, α*max + (1-α)*min ∈ Icc -B B

-- Pointwise inequality
hmin_point : ∀ (s m : model.M), @minPayoff model C s ≤ beliefDot (model.inclM s) (@profileMap model σM_C m)
```

## Definitions

```lean
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
```

## Math sketch

### For sorry 1 (robust_range_bddAbove):

Take β0 = `Kernel.deterministic id measurable_id` (deterministic identity kernel). Then:
- `MisalignedPayoffM β0 σ = AlignedPayoffM σ` (Dirac collapses inner integral).
- `MixturePayoffM β0 σ = α A + (1-α) A = A`.
- So `RobustPayoffM σ = sInf (range Mix · σ) ≤ Mix β0 σ = AlignedPayoffM σ ≤ C_bnd` (using uniform bound on profileOfPrivate + probability measure τM).

The integrability of `s ↦ beliefDot (inclM s) (profileMap σ s)` follows from boundedness + AEStronglyMeasurable. Bound: `|beliefDot (inclM s) (profileMap σ s)| ≤ C_bnd` (probability simplex + uniform sup-norm). The function is measurable as composition: `inclM_measurable` + linear ops + `σ.measurable_sectionM`.

For BddBelow of range MixturePayoffM (needed for csInf_le_of_le): use `-C_bnd` as lower bound by the same boundedness argument.

### For sorry 2 (hMis_per_β):

Goal: `∫ s, minPayoff C s ∂τM ≤ MisalignedPayoffM β σM_C` for any β.

Proof:
```
MisalignedPayoffM β σM_C
  = ∫ s, ∫ m, beliefDot (inclM s) (profileMap σM_C m) ∂(β.kernel s) ∂τM
  ≥ ∫ s, ∫ m, minPayoff C s ∂(β.kernel s) ∂τM    [by hmin_point + integral_mono on inner integral]
  = ∫ s, (minPayoff C s) * (β.kernel s univ).toReal ∂τM
  = ∫ s, minPayoff C s ∂τM                       [Markov: β.kernel s univ = 1]
```

Key Mathlib invocations:
- `MeasureTheory.integral_mono_ae` (for inner integral monotonicity, needs Integrable both sides)
- `MeasureTheory.integral_const` or `MeasureTheory.integral_const_of_isProbabilityMeasure`
- `ProbabilityTheory.IsMarkovKernel.isProbabilityMeasure_apply` (gives β.kernel s is probability)

### For sorry 3 (hF_split):

Goal: `MenuFunctionalF model C = α * ∫ max + (1-α) * ∫ min`.

By definition, `MenuFunctionalF model C = ∫ s, α * max C s + (1-α) * min C s ∂τM`.

Split via `MeasureTheory.integral_add` (needs Integrable both terms) + `MeasureTheory.integral_const_mul`.

Need:
- `Integrable (fun s => α * maxPayoff C s) τM` 
- `Integrable (fun s => (1-α) * minPayoff C s) τM`

From `menu_integrand_mem_Icc_ae` (which gives bound `B` on the sum), bound each separately using `α, 1-α ≥ 0` and individual `|maxPayoff|, |minPayoff| ≤ B'` (proven inside menu_integrand_mem_Icc_ae's proof — see `hmax_le`, `hmax_ge`, `hmin_le`, `hmin_ge` in that proof body).

Actually, since menu_integrand_mem_Icc_ae's proof internally derives individual bounds on max and min, one approach is to factor those out as separate lemmas:

```lean
private lemma maxPayoff_bound : ∃ B, ∀ᵐ s, |maxPayoff C s| ≤ B
private lemma minPayoff_bound : ∃ B, ∀ᵐ s, |minPayoff C s| ≤ B
```

But those individual bounds require **measurability** of maxPayoff and minPayoff (to even state Integrable). And measurability is `menu_integrand_aemeasurable` (separate sorry, not in scope of this chat).

**You can ASSUME `menu_integrand_aemeasurable` is proven** (other chat is closing it). So when proving hF_split, you may freely cite:

```lean
have hmax_meas : AEMeasurable (fun s => maxPayoff model C s) model.τM := sorry  -- assume
have hmin_meas : AEMeasurable (fun s => minPayoff model C s) model.τM := sorry  -- assume
```

If your proof requires this measurability, **STATE it as a `sorry`** inside the proof body — but do not return STUCK for the whole proof if only this remains.

## Lean strategy

Submit a single coherent proof block addressing all 3 sorries. For each, provide:
- Full proof if possible
- Or precise inline `sorry` with comment naming the missing Mathlib API

You may freely add private helper lemmas (e.g., `aligned_payoff_bounded`, `kernel_integral_const`, etc.).

## Output

```
lean_proof
target_lemma_slug: measure_theory_bridge_cluster
status: PROVED | PARTIAL | STUCK
tactics_used: [...]
```

Then ONE Lean block containing the helper lemmas + replacement bodies for the 3 sorries (organized as: helpers first, then robust_range_bddAbove, then explanatory comments for where to splice hMis_per_β and hF_split inline into menu_value_le_strategy_sup).

Aim for 100-200 lines total. PARTIAL is acceptable if one of the three needs additional Mathlib that you can name precisely.
