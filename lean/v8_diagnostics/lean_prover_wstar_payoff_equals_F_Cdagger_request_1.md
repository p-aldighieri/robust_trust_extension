You are the Lean Prover. Close ONE specific sorry: `wstar_payoff_equals_F_Cdagger` (line 3277 of main.lean).

## Target

```lean
theorem wstar_payoff_equals_F_Cdagger
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (cdagger : PrunedMenuCdagger model wlabel)
    (σM : AgentStrategyM model)
    (hprofile : ∀ m : model.M, profileMap model σM m = (wlabel.wstar m).val) :
    AlignedPayoffM model σM =
        ∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM ∧
      sInf (Set.range fun β : AdviserKernel model => MisalignedPayoffM model β σM) =
        ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM ∧
      RobustPayoffM model σM = MenuFunctionalF model cdagger.Cdagger := by
  sorry
```

## Available infrastructure (all PROVED in scope, earlier in file)

```lean
-- adversary_infimum_pointwise (line ~1204, PROVED)
theorem adversary_infimum_pointwise
    (model) (w : model.M → ProfileInW model)
    (hw_meas) (hg_meas) (hw_bdd) (hinf_meas) (hinf_int) (hkernel_int) :
    sInf (range β => ∫ s, ∫ m, beliefDot (inclM s) (w m).val ∂(β.kernel s) ∂τM)
      = ∫ s, sInf (range m => beliefDot (inclM s) (w m).val) ∂τM

-- sSup_image_closure_eq_of_continuous, sInf_image_closure_eq_of_continuous (lines 1281, 1304)

-- beliefDot_profileMap_uncurry_measurable, beliefDot_profileMap_uniform_bound (lines 2027+)

-- maxPayoff_integrable, minPayoff_integrable model C (any C : CompactMenu)

-- menuFunctionalF_bddAbove_uniform (in scope after my strategy_value proof)

-- strategy_value_le_menu_sup (line 1911 — gives ≤ direction)
```

## Key structural facts

```lean
structure AlignedBestLabelingWstar where
  wstar : model.M → ProfileInW model
  measurable_wstar : Measurable wstar
  mem_Cstar : ∀ m, wstar m ∈ (↑opt.Cstar : Set _)
  is_argmax : ∀ m, IsMaxOn (fun w => beliefDot (inclM m) w.val) (↑opt.Cstar) (wstar m)

structure PrunedMenuCdagger where
  Cdagger : CompactMenu model
  subset_Cstar : ↑Cdagger ⊆ ↑opt.Cstar
  closure_range_subset : closure (range wlabel.wstar) ⊆ ↑Cdagger
  range_dense : ↑Cdagger ⊆ closure (range wlabel.wstar)
  value_preserved : MenuFunctionalF Cdagger = MenuFunctionalF opt.Cstar
```

So `↑Cdagger = closure (range wlabel.wstar)` (from the two inclusions).

## Math sketch

**Conjunct 1 (Aligned = ∫ max)**:
- For each s: beliefDot (inclM s) (profileMap σM s) = beliefDot (inclM s) (wstar s).val (by hprofile).
- wstar s ∈ Cdagger (since wstar s ∈ closure(range wstar) ⊆ Cdagger).
- maxPayoff Cdagger s = sSup over Cdagger of beliefDot at inclM s
  = sSup over closure(range wstar) (by ↑Cdagger = closure(range wstar))
  = sSup over range wstar (closure-extrema lemma)
- wstar s achieves the sSup over Cstar (is_argmax). Since Cdagger ⊆ Cstar and wstar s ∈ Cdagger:
  - sSup over Cdagger ≤ sSup over Cstar = beliefDot (inclM s) (wstar s).val
  - sSup over Cdagger ≥ beliefDot (inclM s) (wstar s).val (wstar s is a member)
  - So equality.
- Hence ∫ AlignedPayoff integrand = ∫ maxPayoff Cdagger.

**Conjunct 2 (sInf Mis = ∫ min)**:
- MisalignedPayoffM β σM = ∫ s, ∫ m, beliefDot (inclM s) (profileMap σM m) ∂(β.kernel s) ∂τM
  = ∫ s, ∫ m, beliefDot (inclM s) (wstar m).val ∂(β.kernel s) ∂τM (by hprofile in inner)
- Apply adversary_infimum_pointwise with w := wlabel.wstar:
  sInf β (this) = ∫ s, sInf_m beliefDot (inclM s) (wstar m).val dτM
- sInf_m beliefDot (inclM s) (wstar m).val = sInf over range wstar
  = sInf over closure(range wstar) (closure-extrema lemma for sInf)
  = sInf over Cdagger = minPayoff Cdagger s
- Hence sInf Mis = ∫ minPayoff Cdagger.

**Conjunct 3 (Robust = MenuFunctional Cdagger)**:
- MixturePayoffM β σM = α · AlignedPayoffM σM + (1-α) · MisalignedPayoffM β σM
  = α · ∫ max Cdagger + (1-α) · MisalignedPayoffM β σM  (using conjunct 1)
- sInf β MixturePayoffM = α · ∫ max + (1-α) · sInf β MisalignedPayoffM
  (linearity of sInf under α·A + (1-α)·_ when (1-α) ≥ 0; needs both directions)
- = α · ∫ max + (1-α) · ∫ min  (using conjunct 2)
- = MenuFunctionalF Cdagger (by definition + integral_add linearity).

For the sInf linearity: need both directions.
- ≤ direction: same as `strategy_value_le_menu_sup` (already PROVED via ε-argument).
- ≥ direction: for each β, MixturePayoffM β = α · A + (1-α) · M_β ≥ α · A + (1-α) · sInf M_β (since (1-α) ≥ 0 and sInf M ≤ M_β). Apply le_csInf.

## Strategy

```lean
classical
haveI : IsProbabilityMeasure model.τM := model.τM_prob
have hα_nn : 0 ≤ model.α := model.α_nonneg
have hαc : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one
have hCdagger_eq : (↑cdagger.Cdagger : Set (ProfileInW model))
    = closure (Set.range wlabel.wstar) :=
  Set.Subset.antisymm cdagger.range_dense cdagger.closure_range_subset

-- For each s, max/minPayoff Cdagger identities
have hmax_eq : ∀ s : model.M,
    maxPayoff model cdagger.Cdagger s =
      beliefDot (model.inclM s) (wlabel.wstar s).val := by
  intro s
  -- Use sSup_image_closure_eq_of_continuous then is_argmax
  sorry

have hmin_eq_inf_range : ∀ s : model.M,
    minPayoff model cdagger.Cdagger s =
      sInf (Set.range fun m : model.M => beliefDot (model.inclM s) (wlabel.wstar m).val) := by
  intro s
  -- Use sInf_image_closure_eq_of_continuous
  sorry

-- Conjunct 1
have h1 : AlignedPayoffM model σM = ∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM := by
  unfold AlignedPayoffM
  refine integral_congr_ae ?_
  filter_upwards with s
  rw [hprofile s, hmax_eq s]

-- Conjunct 2 via adversary_infimum_pointwise
have h2 : sInf (Set.range fun β => MisalignedPayoffM model β σM) =
    ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM := by
  -- Apply adversary_infimum_pointwise with w := wlabel.wstar
  have hpoint := adversary_infimum_pointwise model wlabel.wstar
      wlabel.measurable_wstar
      (... 6 hypotheses ...)
  -- Then convert MisalignedPayoffM β σM = ∫ ∫ beliefDot (inclM s) (wstar m).val (by hprofile)
  sorry

-- Conjunct 3 via sInf linearity
have h3 : RobustPayoffM model σM = MenuFunctionalF model cdagger.Cdagger := by
  unfold RobustPayoffM
  -- sInf β (α·AlignedPayoffM + (1-α)·MisalignedPayoffM β)
  --   = α·AlignedPayoffM + (1-α)·sInf β MisalignedPayoffM
  --   = α·∫ max + (1-α)·∫ min
  --   = MenuFunctionalF Cdagger
  sorry

exact ⟨h1, h2, h3⟩
```

## Output

```
lean_proof
target_lemma_slug: wstar_payoff_equals_F_Cdagger
status: PROVED | STUCK
tactics_used: [...]
```

```lean
theorem wstar_payoff_equals_F_Cdagger ... := by
  -- your proof
```

Aim 100-300 lines. May add private helpers.

CRITICAL: model fields are `model.α/model.τM`. AdviserKernel.kernel is the field; β.isMarkov instance witness.
