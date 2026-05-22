You are the Lean Prover. Close ONE specific inline sorry — the integral linearity step inside `menu_value_le_strategy_sup`.

## Target inline sorry

Inside `menu_value_le_strategy_sup` (already wrapped):
```lean
have hF_split :
    MenuFunctionalF model C =
      model.α * (∫ s, @maxPayoff model C s ∂model.τM) +
        (1 - model.α) * (∫ s, @minPayoff model C s ∂model.τM) := by
  unfold MenuFunctionalF
  sorry
```

## What's available

The following are already proved in main.lean (above the splice point):
```lean
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
```

Also available: `model.private_profile_bounded : ∃ C, ∀ σ ω, |profileOfPrivate σ ω| ≤ C`, `model.α_nonneg`, `model.α_le_one`, `model.τM_prob : IsProbabilityMeasure τM`.

`MenuFunctionalF model C := ∫ s, model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∂model.τM`.

## Strategy

1. Define new private helpers RIGHT BEFORE menu_value_le_strategy_sup (you'll provide them):
   - `maxPayoff_aemeasurable model C : AEMeasurable (fun s => maxPayoff model C s) model.τM`
   - `minPayoff_aemeasurable model C : AEMeasurable (fun s => minPayoff model C s) model.τM`
   - `maxPayoff_integrable model C : Integrable (fun s => maxPayoff model C s) model.τM`
   - `minPayoff_integrable model C : Integrable (fun s => minPayoff model C s) model.τM`

   These mirror the structure of `menu_integrand_aemeasurable` and use `Integrable.of_mem_Icc` with bounds.
   
   **Critical placement constraint**: these helpers must appear BEFORE `menu_value_le_strategy_sup_robust_range_bddAbove` (line 1287 currently) AND must reference `beliefDot_menu_uncurry_continuous` (at line 1681). So you'll need to MOVE `beliefDot_menu_uncurry_continuous` before the helpers (move it before line 1287).

   For boundedness: derive a uniform bound `B` from `model.private_profile_bounded` (similar to `menu_integrand_mem_Icc_ae`'s proof — which uses per-coord max + Finset.sup' + sum-over-Ω bound). The cleanest factoring:
   
```lean
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
```

2. Then hF_split body becomes:
```lean
have hF_split : ... := by
  have hα_max_int : Integrable (fun s => model.α * maxPayoff model C s) model.τM :=
    (maxPayoff_integrable model C).const_mul model.α
  have h1α_min_int : Integrable (fun s => (1 - model.α) * minPayoff model C s) model.τM :=
    (minPayoff_integrable model C).const_mul (1 - model.α)
  unfold MenuFunctionalF
  rw [integral_add hα_max_int h1α_min_int, integral_const_mul, integral_const_mul]
```

## Output

Provide ONE Lean code block containing:
1. The 6 helper lemmas (profileInW_abs_le_private_bound, beliefDot_ProfileInW_abs_le_private_bound, maxPayoff_aemeasurable, minPayoff_aemeasurable, maxPayoff_mem_Icc_ae, minPayoff_mem_Icc_ae, maxPayoff_integrable, minPayoff_integrable).
2. The hF_split body (just the proof, to be spliced inline).

Do NOT include namespace wrappers (already inside `RobustTrustV8`).

**CRITICAL**: do NOT use `NonemptyCompacts (ProfileInW model)` — use `CompactMenu model` instead (which IS NonemptyCompacts (ProfileInW model) via abbrev).

```
lean_proof
target_lemma_slug: hF_split_with_individual_integrability
status: PROVED | STUCK
tactics_used: [...]
```

Aim for 100-150 lines.
