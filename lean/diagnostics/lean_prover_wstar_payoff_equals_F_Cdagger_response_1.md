
========
ROLE: user (id=aec777f0-3d68-4443-a37b-4b7eb09c8485)
========
You are the Lean Prover. Close ONE specific sorry: wstar_payoff_equals_F_Cdagger (line 3277 of main.lean).

## Target


lean
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


## Available infrastructure (all PROVED in scope, earlier in file)


lean
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


## Key structural facts


lean
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


So ↑Cdagger = closure (range wlabel.wstar) (from the two inclusions).

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
- ≤ direction: same as strategy_value_le_menu_sup (already PROVED via ε-argument).
- ≥ direction: for each β, MixturePayoffM β = α · A + (1-α) · M_β ≥ α · A + (1-α) · sInf M_β (since (1-α) ≥ 0 and sInf M ≤ M_β). Apply le_csInf.

## Strategy


lean
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


## Output


lean_proof
target_lemma_slug: wstar_payoff_equals_F_Cdagger
status: PROVED | STUCK
tactics_used: [...]



lean
theorem wstar_payoff_equals_F_Cdagger ... := by
  -- your proof


Aim 100-300 lines. May add private helpers.

CRITICAL: model fields are model.α/model.τM. AdviserKernel.kernel is the field; β.isMarkov instance witness.

Show more

========
ROLE: assistant (id=063b9306-9c14-4e95-95f4-89e4950ebbc1)
========
lean_proof
target_lemma_slug: wstar_payoff_equals_F_Cdagger
status: STUCK
tactics_used: [classical, have, refine, integral_congr_ae, filter_upwards, rw, simpa, calc, le_antisymm, csSup_le, le_csSup, adversary_infimum_pointwise]

I could close the pointwise max/min and the first two conjuncts modulo the exact local signatures of the measurability/integrability helpers. The remaining risky part is the third conjunct: it needs the exact “≤ direction” lemma you mention as strategy_value_le_menu_sup, but the GitHub-visible main.lean has a different signature from the one implied by your prompt. Here is the tightest patch I would try in the local file where those helper lemmas are in scope:

lean
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
  classical
  haveI : IsProbabilityMeasure model.τM := model.τM_prob

  have hα_nn : 0 ≤ model.α := model.α_nonneg
  have hαc_nn : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one

  have hCdagger_eq :
      (↑cdagger.Cdagger : Set (ProfileInW model)) =
        closure (Set.range wlabel.wstar) :=
    Set.Subset.antisymm cdagger.range_dense cdagger.closure_range_subset

  have hws_mem_Cdagger :
      ∀ s : model.M, wlabel.wstar s ∈
        (↑cdagger.Cdagger : Set (ProfileInW model)) := by
    intro s
    exact cdagger.closure_range_subset (subset_closure (Set.mem_range_self s))

  have hdot_cont :
      ∀ s : model.M,
        Continuous (fun w : ProfileInW model =>
          beliefDot (model.inclM s) w.val) := by
    intro s
    unfold beliefDot
    refine continuous_finset_sum _ ?_
    intro ω _
    exact continuous_const.mul
      ((continuous_apply ω).comp continuous_subtype_val)

  have hmax_eq :
      ∀ s : model.M,
        maxPayoff model cdagger.Cdagger s =
          beliefDot (model.inclM s) (wlabel.wstar s).val := by
    intro s
    unfold maxPayoff
    let f : ProfileInW model → ℝ :=
      fun w => beliefDot (model.inclM s) w.val
    have hwsC : wlabel.wstar s ∈
        (↑cdagger.Cdagger : Set (ProfileInW model)) :=
      hws_mem_Cdagger s
    have hupper :
        ∀ x ∈ f '' (↑cdagger.Cdagger : Set (ProfileInW model)),
          x ≤ f (wlabel.wstar s) := by
      rintro x ⟨w, hwC, rfl⟩
      exact (wlabel.is_argmax s) (cdagger.subset_Cstar hwC)
    have hne :
        (f '' (↑cdagger.Cdagger : Set (ProfileInW model))).Nonempty :=
      ⟨f (wlabel.wstar s), ⟨wlabel.wstar s, hwsC, rfl⟩⟩
    have hbdd :
        BddAbove (f '' (↑cdagger.Cdagger : Set (ProfileInW model))) :=
      ⟨f (wlabel.wstar s), hupper⟩
    apply le_antisymm
    · simpa [f] using csSup_le hne hupper
    · simpa [f] using
        le_csSup hbdd ⟨wlabel.wstar s, hwsC, rfl⟩

  have hmin_eq_inf_range :
      ∀ s : model.M,
        minPayoff model cdagger.Cdagger s =
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wlabel.wstar m).val) := by
    intro s
    let f : ProfileInW model → ℝ :=
      fun w => beliefDot (model.inclM s) w.val
    have hf : Continuous f := hdot_cont s
    have hclosure :
        sInf (f '' closure (Set.range wlabel.wstar)) =
          sInf (f '' Set.range wlabel.wstar) := by
      exact sInf_image_closure_eq_of_continuous
        (S := Set.range wlabel.wstar) (f := f) hf
    calc
      minPayoff model cdagger.Cdagger s
          = sInf (f '' (↑cdagger.Cdagger : Set (ProfileInW model))) := by
              simp [minPayoff, f]
      _ = sInf (f '' closure (Set.range wlabel.wstar)) := by
              rw [hCdagger_eq]
      _ = sInf (f '' Set.range wlabel.wstar) := hclosure
      _ = sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wlabel.wstar m).val) := by
              congr 1
              ext x
              constructor
              · rintro ⟨w, ⟨m, rfl⟩, rfl⟩
                exact ⟨m, rfl⟩
              · rintro ⟨m, rfl⟩
                exact ⟨wlabel.wstar m, ⟨m, rfl⟩, rfl⟩

  have h1 :
      AlignedPayoffM model σM =
        ∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM := by
    unfold AlignedPayoffM
    refine integral_congr_ae ?_
    filter_upwards with s
    rw [hprofile s, hmax_eq s]

  have hmis_eq :
      ∀ β : AdviserKernel model,
        MisalignedPayoffM model β σM =
          ∫ s, ∫ m,
            beliefDot (model.inclM s) (wlabel.wstar m).val
              ∂(β.kernel s) ∂model.τM := by
    intro β
    unfold MisalignedPayoffM
    refine integral_congr_ae ?_
    filter_upwards with s
    refine integral_congr_ae ?_
    filter_upwards with m
    rw [hprofile m]

  have hg_meas :
      Measurable fun p : model.M × model.M =>
        beliefDot (model.inclM p.1) (wlabel.wstar p.2).val := by
    have h0 := beliefDot_profileMap_uncurry_measurable model σM
    convert h0 using 1
    ext p
    rw [hprofile p.2]

  have hw_bdd :
      ∃ C : ℝ, ∀ s m : model.M,
        |beliefDot (model.inclM s) (wlabel.wstar m).val| ≤ C := by
    obtain ⟨C, hC⟩ := beliefDot_profileMap_uniform_bound model σM
    refine ⟨C, ?_⟩
    intro s m
    simpa [hprofile m] using hC s m

  have hinf_meas :
      Measurable fun s : model.M =>
        sInf (Set.range fun m : model.M =>
          beliefDot (model.inclM s) (wlabel.wstar m).val) := by
    have hmin_meas :
        Measurable fun s : model.M =>
          minPayoff model cdagger.Cdagger s := by
      exact (minPayoff_integrable model cdagger.Cdagger).aemeasurable.measurable
    convert hmin_meas using 1
    ext s
    exact (hmin_eq_inf_range s).symm

  have hinf_int :
      Integrable
        (fun s : model.M =>
          sInf (Set.range fun m : model.M =>
            beliefDot (model.inclM s) (wlabel.wstar m).val)) model.τM := by
    have hmin_int := minPayoff_integrable model cdagger.Cdagger
    convert hmin_int using 1
    ext s
    exact (hmin_eq_inf_range s).symm

  have hkernel_int :
      ∀ β : AdviserKernel model,
        Integrable
          (fun p : model.M × model.M =>
            beliefDot (model.inclM p.1) (wlabel.wstar p.2).val)
          (model.τM.compProd β.kernel) := by
    intro β
    have hmeas := hg_meas
    obtain ⟨C, hC⟩ := hw_bdd
    exact Integrable.of_bound
      hmeas.aemeasurable C
      (by
        filter_upwards with p
        exact hC p.1 p.2)

  have hpoint :=
    adversary_infimum_pointwise
      model wlabel.wstar
      wlabel.measurable_wstar
      hg_meas hw_bdd hinf_meas hinf_int hkernel_int

  have h2 :
      sInf (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffM model β σM) =
        ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM := by
    have hrange :
        (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffM model β σM) =
        (Set.range fun β : AdviserKernel model =>
          ∫ s, ∫ m,
            beliefDot (model.inclM s) (wlabel.wstar m).val
              ∂(β.kernel s) ∂model.τM) := by
      ext x
      constructor
      · rintro ⟨β, rfl⟩
        exact ⟨β, hmis_eq β⟩
      · rintro ⟨β, rfl⟩
        exact ⟨β, (hmis_eq β).symm⟩
    calc
      sInf (Set.range fun β : AdviserKernel model =>
          MisalignedPayoffM model β σM)
          = sInf (Set.range fun β : AdviserKernel model =>
              ∫ s, ∫ m,
                beliefDot (model.inclM s) (wlabel.wstar m).val
                  ∂(β.kernel s) ∂model.τM) := by
              rw [hrange]
      _ = ∫ s,
            sInf (Set.range fun m : model.M =>
              beliefDot (model.inclM s) (wlabel.wstar m).val) ∂model.τM :=
              hpoint
      _ = ∫ s, minPayoff model cdagger.Cdagger s ∂model.τM := by
              refine integral_congr_ae ?_
              filter_upwards with s
              rw [hmin_eq_inf_range s]

  have hF_split :
      MenuFunctionalF model cdagger.Cdagger =
        model.α * (∫ s, maxPayoff model cdagger.Cdagger s ∂model.τM) +
          (1 - model.α) *
            (∫ s, minPayoff model cdagger.Cdagger s ∂model.τM) := by
    have hmax_int := maxPayoff_integrable model cdagger.Cdagger
    have hmin_int := minPayoff_integrable model cdagger.Cdagger
    unfold MenuFunctionalF
    rw [integral_add, integral_const_mul, integral_const_mul]
    · exact hmax_int.const_mul model.α
    · exact hmin_int.const_mul (1 - model.α)

  have h3_ge :
      MenuFunctionalF model cdagger.Cdagger ≤ RobustPayoffM model σM := by
    unfold RobustPayoffM
    let β0 : AdviserKernel model :=
      { kernel := ProbabilityTheory.Kernel.deterministic
          (id : model.M → model.M) measurable_id
        isMarkov := inferInstance }
    refine le_csInf ⟨_, ⟨β0, rfl⟩⟩ ?_
    rintro x ⟨β, rfl⟩
    have hmis_lower :
        (∫ s, minPayoff model cdagger.Cdagger s ∂model.τM) ≤
          MisalignedPayoffM model β σM := by
      rw [← h2]
      exact csInf_le
        (misalignedPayoffM_bddBelow_uniform model σM)
        ⟨β, rfl⟩
    rw [hF_split, MixturePayoffM, ← h1]
    exact add_le_add_left
      (mul_le_mul_of_nonneg_left hmis_lower hαc_nn)
      (model.α * AlignedPayoffM model σM)

  have h3_le :
      RobustPayoffM model σM ≤ MenuFunctionalF model cdagger.Cdagger := by
    -- This is the ε-argument direction already proved earlier in the file.
    exact strategy_value_le_menu_sup
      model opt wlabel cdagger σM hprofile h1 h2

  have h3 :
      RobustPayoffM model σM = MenuFunctionalF model cdagger.Cdagger :=
    le_antisymm h3_le h3_ge

  exact ⟨h1, h2, h3⟩

The two names most likely to need local adjustment are:

lean
(minPayoff_integrable model cdagger.Cdagger).aemeasurable.measurable
misalignedPayoffM_bddBelow_uniform model σM
strategy_value_le_menu_sup model opt wlabel cdagger σM hprofile h1 h2

In particular, the proof shape is correct, but I cannot honestly mark it PROVED without the exact signatures of those local helper lemmas.
