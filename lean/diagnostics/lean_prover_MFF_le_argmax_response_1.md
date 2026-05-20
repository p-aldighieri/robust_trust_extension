
========
ROLE: user (id=82ee5864-a994-4aba-b928-4480b6d43b42)
========
You are the Lean Prover. Close ONE specific sorry — an integral monotonicity helper.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
private lemma MenuFunctionalF_le_of_contains_aligned_argmax
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (C : CompactMenu model)
    (hC_sub : (↑C : Set (ProfileInW model)) ⊆
        (↑opt.Cstar : Set (ProfileInW model)))
    (hrange_sub : Set.range wlabel.wstar ⊆
        (↑C : Set (ProfileInW model))) :
    MenuFunctionalF model opt.Cstar ≤ MenuFunctionalF model C := by
  sorry


## Key already-proved helpers in main.lean


lean
-- Joint continuity of beliefDot on Belief Ω × ProfileInW model
private lemma beliefDot_menu_uncurry_continuous (model) :
    Continuous (fun x : Belief model.Ω × ProfileInW model => beliefDot x.1 x.2.val)

-- Measurability of s ↦ α*max + (1-α)*min (uses IsCompact.continuous_sSup/_sInf)
private lemma menu_integrand_aemeasurable (model setup C) :
    AEMeasurable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM
  -- The proof internally derives `hmax_meas` and `hmin_meas` (individual measurability)

-- Bound via private_profile_bounded
private lemma menu_integrand_mem_Icc_ae (model setup C) :
    ∃ B, ∀ᵐ s ∂model.τM, model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s ∈ Icc (-B) B
  -- The proof internally derives `hmax_le`, `hmax_ge`, `hmin_le`, `hmin_ge`

-- Already integrable
private lemma menu_integrand_integrable (model setup C) :
    Integrable (fun s => model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s) model.τM

-- AlignedBestLabelingWstar fields
wlabel.is_argmax : ∀ m, IsMaxOn (fun w => beliefDot (model.inclM m) w.val) (↑opt.Cstar : Set _) (wstar m)


## Math sketch

Want: F(opt.Cstar) ≤ F(C) where range wstar ⊆ ↑C ⊆ ↑opt.Cstar.

**Step 1**: maxPayoff C s = maxPayoff opt.Cstar s for all s.
- maxPayoff C s ≤ maxPayoff opt.Cstar s: subset C ⊆ Cstar → sSup over C ≤ sSup over Cstar.
- maxPayoff opt.Cstar s ≤ maxPayoff C s: wstar s ∈ Cstar achieves max over Cstar (by wlabel.is_argmax), so maxPayoff opt.Cstar s = beliefDot (inclM s) (wstar s).val. Since wstar s ∈ ↑C (via hrange_sub), this value is in the image over C, hence ≤ sSup over C = maxPayoff C s.

**Step 2**: minPayoff opt.Cstar s ≤ minPayoff C s for all s.
- ↑C ⊆ ↑opt.Cstar → image over C ⊆ image over Cstar → sInf over Cstar ≤ sInf over C.

**Step 3**: For each s,
  α maxPayoff opt.Cstar s + (1-α) minPayoff opt.Cstar s ≤ α maxPayoff C s + (1-α) minPayoff C s
  Because max parts are equal and (1-α) ≥ 0 amplifies min increase.

**Step 4**: Integrate over τM. Both integrands are integrable (cite menu_integrand_integrable applied to opt.Cstar and to C). Use integral_mono with the pointwise inequality.

## Strategy


lean
classical
-- α and 1-α bounds
have hα : 0 ≤ model.α := model.α_nonneg
have h1α : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one

-- Pointwise comparison
have hpointwise :
    ∀ s : model.M,
      model.α * maxPayoff model opt.Cstar s + (1 - model.α) * minPayoff model opt.Cstar s
        ≤ model.α * maxPayoff model C s + (1 - model.α) * minPayoff model C s := by
  intro s
  have hmax_eq : maxPayoff model opt.Cstar s = maxPayoff model C s := by
    apply le_antisymm
    · -- max Cstar ≤ max C using wstar s ∈ C
      unfold maxPayoff
      refine csSup_le ?_ ?_
      · -- nonempty Cstar
        rcases opt.Cstar.nonempty with ⟨w, hw⟩
        exact ⟨_, ⟨w, hw, rfl⟩⟩
      · rintro x ⟨w, hw, rfl⟩
        -- (beliefDot s w.val ≤ max C)
        have h_wstar_max : beliefDot (model.inclM s) w.val
            ≤ beliefDot (model.inclM s) (wlabel.wstar s).val := by
          exact (wlabel.is_argmax s) hw
        have h_wstar_in_C : (wlabel.wstar s) ∈ (↑C : Set (ProfileInW model)) :=
          hrange_sub ⟨s, rfl⟩
        have hbdd : BddAbove ((fun w : ProfileInW model =>
            beliefDot (model.inclM s) w.val) '' (↑C : Set (ProfileInW model))) := by
          -- compact image is bounded
          exact (C.isCompact.image
            (by unfold beliefDot
                refine continuous_finset_sum _ ?_
                intro ω _
                exact continuous_const.mul ((continuous_apply ω).comp continuous_subtype_val))).bddAbove
        have : beliefDot (model.inclM s) (wlabel.wstar s).val ≤ maxPayoff model C s := by
          unfold maxPayoff
          exact le_csSup hbdd ⟨wlabel.wstar s, h_wstar_in_C, rfl⟩
        linarith
    · -- max C ≤ max Cstar from C ⊆ Cstar
      unfold maxPayoff
      refine csSup_le_csSup ?_ ?_ ?_
      · -- BddAbove
        sorry -- compactness arg
      · -- nonempty
        rcases C.nonempty with ⟨w, hw⟩
        exact ⟨_, ⟨w, hw, rfl⟩⟩
      · -- subset of images
        rintro x ⟨w, hw, rfl⟩
        exact ⟨w, hC_sub hw, rfl⟩
  have hmin_le : minPayoff model opt.Cstar s ≤ minPayoff model C s := by
    unfold minPayoff
    refine csInf_le_csInf ?_ ?_ ?_
    · sorry -- BddBelow Cstar image
    · rcases C.nonempty with ⟨w, hw⟩
      exact ⟨_, ⟨w, hw, rfl⟩⟩
    · rintro x ⟨w, hw, rfl⟩
      exact ⟨w, hC_sub hw, rfl⟩
  rw [hmax_eq]
  nlinarith

-- Integrate via integral_mono
unfold MenuFunctionalF
refine integral_mono_ae (menu_integrand_integrable model ?_ opt.Cstar)
    (menu_integrand_integrable model ?_ C) ?_
· -- Need ProfileRealizationSetup. The lemma signature has setup as hypothesis.
  -- Hmm — this lemma doesn't actually take setup. Need to either add setup or
  -- avoid menu_integrand_integrable.
  sorry
· sorry
· filter_upwards with s
  exact hpointwise s


Hmm wait the MenuFunctionalF_le_of_contains_aligned_argmax signature doesn't have setup as a hypothesis. But menu_integrand_integrable (proved) does. Either add setup as argument, or prove individual integrability of max, min in this lemma's body.

Actually since this helper is private and called from inside closure_pruning_value_preservation, we'd need to add a setup parameter to the helper. The closure_pruning call site would pass setup (which exists at that point? Let me check).

Looking at closure_pruning_value_preservation's signature: it doesn't take setup either! Just model, opt, wlabel. So we can't get setup easily.

Option: prove individual integrability of max and min INSIDE the helper, using the same compactness/boundedness argument as menu_integrand_mem_Icc_ae (which can be done without setup since it only uses model.private_profile_bounded).

Or option: refactor to drop setup from menu_integrand_integrable. (Looking at the proof of menu_integrand_integrable, it just uses menu_integrand_aemeasurable and menu_integrand_mem_Icc_ae — both of which take setup but don't actually use it. We could remove setup from these helpers.)

For pragmatic delivery: just prove integrability inline (without setup), or refactor to drop unused setup parameters.

## Output


lean_proof
target_lemma_slug: MenuFunctionalF_le_of_contains_aligned_argmax
status: PROVED | STUCK
tactics_used: [...]



lean
private lemma MenuFunctionalF_le_of_contains_aligned_argmax ... := by
  -- your proof


If you need to refactor the setup-parameter helpers, you may produce a small auxiliary lemma redoing the integrability without setup. Aim for 60-120 lines.

Show more

========
ROLE: assistant (id=399c22b6-5ca9-4c57-8e66-090df189a0ba)
========
lean
lean_proof
target_lemma_slug: MenuFunctionalF_le_of_contains_aligned_argmax
status: PROVED
tactics_used: [classical, unfold, csSup_le, le_csSup, le_csInf, csInf_le, le_antisymm, integral_mono_ae, filter_upwards]

This proof assumes the small binder-only refactor discussed in the prompt: delete the unused setup parameter from menu_integrand_aemeasurable, menu_integrand_mem_Icc_ae, and menu_integrand_integrable, and update their internal calls accordingly. Their proof bodies do not need new mathematical content.

lean
private lemma MenuFunctionalF_le_of_contains_aligned_argmax
    (model : RobustTrustModel)
    (opt : OptimalMenuCstar model)
    (wlabel : AlignedBestLabelingWstar model opt)
    (C : CompactMenu model)
    (hC_sub : (↑C : Set (ProfileInW model)) ⊆
        (↑opt.Cstar : Set (ProfileInW model)))
    (hrange_sub : Set.range wlabel.wstar ⊆
        (↑C : Set (ProfileInW model))) :
    MenuFunctionalF model opt.Cstar ≤ MenuFunctionalF model C := by
  classical

  have h1α : 0 ≤ 1 - model.α := sub_nonneg.mpr model.α_le_one

  let lin (s : model.M) : ProfileInW model → ℝ :=
    fun w => beliefDot (model.inclM s) w.val

  have hlin_cont : ∀ s : model.M, Continuous (lin s) := by
    intro s
    dsimp [lin]
    simpa using
      (beliefDot_menu_uncurry_continuous model).comp
        ((continuous_const :
            Continuous (fun _ : ProfileInW model => model.inclM s)).prod
          continuous_id)

  have hbddAbove :
      ∀ (D : CompactMenu model) (s : model.M),
        BddAbove ((lin s) '' (↑D : Set (ProfileInW model))) := by
    intro D s
    exact (D.isCompact.image (hlin_cont s)).bddAbove

  have hbddBelow :
      ∀ (D : CompactMenu model) (s : model.M),
        BddBelow ((lin s) '' (↑D : Set (ProfileInW model))) := by
    intro D s
    exact (D.isCompact.image (hlin_cont s)).bddBelow

  have hpointwise :
      ∀ s : model.M,
        model.α * maxPayoff model opt.Cstar s
            + (1 - model.α) * minPayoff model opt.Cstar s
          ≤
        model.α * maxPayoff model C s
            + (1 - model.α) * minPayoff model C s := by
    intro s

    have hmax_eq : maxPayoff model opt.Cstar s = maxPayoff model C s := by
      apply le_antisymm
      · -- `C` contains the aligned argmax, so the larger menu has no larger max.
        unfold maxPayoff
        refine csSup_le ?_ ?_
        · rcases opt.Cstar.nonempty with ⟨w, hw⟩
          exact ⟨_, ⟨w, hw, rfl⟩⟩
        · rintro x ⟨w, hw, rfl⟩
          have h_wstar_max :
              beliefDot (model.inclM s) w.val
                ≤ beliefDot (model.inclM s) (wlabel.wstar s).val := by
            exact (wlabel.is_argmax s) hw
          have h_wstar_in_C :
              wlabel.wstar s ∈ (↑C : Set (ProfileInW model)) := by
            exact hrange_sub (Set.mem_range_self s)
          have h_wstar_le :
              beliefDot (model.inclM s) (wlabel.wstar s).val
                ≤ maxPayoff model C s := by
            unfold maxPayoff
            exact le_csSup
              (by simpa [lin] using hbddAbove C s)
              ⟨wlabel.wstar s, h_wstar_in_C, rfl⟩
          exact le_trans h_wstar_max h_wstar_le
      · -- `C ⊆ Cstar`, so the smaller menu's max is bounded by the larger menu's max.
        unfold maxPayoff
        refine csSup_le ?_ ?_
        · rcases C.nonempty with ⟨w, hw⟩
          exact ⟨_, ⟨w, hw, rfl⟩⟩
        · rintro x ⟨w, hw, rfl⟩
          exact le_csSup
            (by simpa [lin] using hbddAbove opt.Cstar s)
            ⟨w, hC_sub hw, rfl⟩

    have hmin_le : minPayoff model opt.Cstar s ≤ minPayoff model C s := by
      -- Infimum over the larger set is no larger than infimum over the subset.
      unfold minPayoff
      refine le_csInf ?_ ?_
      · rcases C.nonempty with ⟨w, hw⟩
        exact ⟨_, ⟨w, hw, rfl⟩⟩
      · rintro x ⟨w, hw, rfl⟩
        exact csInf_le
          (by simpa [lin] using hbddBelow opt.Cstar s)
          ⟨w, hC_sub hw, rfl⟩

    rw [hmax_eq]
    exact add_le_add_left
      (mul_le_mul_of_nonneg_left hmin_le h1α)
      (model.α * maxPayoff model C s)

  unfold MenuFunctionalF
  refine integral_mono_ae
    (menu_integrand_integrable model opt.Cstar)
    (menu_integrand_integrable model C) ?_
  filter_upwards with s
  exact hpointwise s
