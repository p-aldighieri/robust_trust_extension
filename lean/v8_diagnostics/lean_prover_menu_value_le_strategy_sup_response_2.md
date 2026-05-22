
========
ROLE: user (id=9eb8a0b9-b38d-4a9b-a1dd-f79f84212507)
========
You are the Lean Prover. This is PASS 2 — your previous attempt was STUCK on a missing selector.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  sorry


## Helper lemma (proved separately, you can cite it freely)


lean
private lemma compact_menu_aligned_selection
    (model : RobustTrustModel)
    (C : CompactMenu model) :
    ∃ wC : model.M → ProfileInW model,
      Measurable wC ∧
      (∀ m, wC m ∈ (↑C : Set (ProfileInW model))) ∧
      (∀ m,
        IsMaxOn (fun w : ProfileInW model => beliefDot (model.inclM m) w.val)
          (↑C : Set (ProfileInW model)) (wC m))


This is the generalization of aligned_best_labeling_selection from OptimalMenuCstar to arbitrary CompactMenu. The proof is a copy of the existing aligned_best_labeling_selection proof with opt.Cstar replaced by C (uses Inventory.measurable_argmax_selector).

## All relevant definitions

(Same as pass 1.)

## Math sketch

For any C : CompactMenu model, build σM_C : AgentStrategyM model that achieves payoff ≥ F(C):

**Step 1**: Use compact_menu_aligned_selection model C to get ⟨wC, hwC_meas, hwC_mem, hwC_max⟩.

**Step 2**: Build σM_C := { sectionM := fun m => prm.R (wC m), measurable_sectionM := prm.measurable_R.comp hwC_meas }.

**Step 3**: Compute AlignedPayoffM σM_C:

AlignedPayoffM σM_C = ∫ s, beliefDot(inclM s) (profileMap σM_C s) dτM
                    = ∫ s, beliefDot(inclM s) (model.profileOfPrivate (prm.R (wC s))) dτM
                    = ∫ s, beliefDot(inclM s) (wC s).val dτM        (by prm.right_inverse)
                    = ∫ s, maxPayoff(C, s) dτM                       (by hwC_max + Set.IsMaxOn.sSup_eq for compact)


The last step: maxPayoff C s = sSup ((beliefDot (inclM s) ·.val) '' ↑C). With wC s ∈ ↑C and IsMaxOn (beliefDot (inclM s) ·.val) ↑C (wC s), we have beliefDot(inclM s) (wC s).val = sSup ((beliefDot (inclM s) ·.val) '' ↑C) = maxPayoff(C, s).

Use IsMaxOn.sSup_image_eq or write directly:

lean
have : beliefDot (model.inclM s) (wC s).val = maxPayoff model C s := by
  unfold maxPayoff
  symm
  refine IsLUB.csSup_eq ?_ ⟨_, ⟨wC s, hwC_mem s, rfl⟩⟩
  refine ⟨?_, ?_⟩
  · rintro x ⟨w, hw, rfl⟩
    exact hwC_max s ⟨w, hw⟩ (Set.mem_univ _)  -- or similar
    -- Actually: hwC_max gives `(fun w => beliefDot (inclM s) w.val) w' ≤ (fun w => beliefDot (inclM s) w.val) (wC s)` for w' ∈ ↑C
  · intro b hb
    exact hb ⟨wC s, hwC_mem s, rfl⟩


**Step 4**: For any β, MisalignedPayoffM β σM_C ≥ ∫ s, minPayoff(C, s) dτM.


MisalignedPayoffM β σM_C = ∫ s, ∫ m, beliefDot(inclM s) (profileMap σM_C m) ∂(β.kernel s) dτM
                        = ∫ s, ∫ m, beliefDot(inclM s) (wC m).val ∂(β.kernel s) dτM


For each (s, m), beliefDot(inclM s) (wC m).val ≥ minPayoff(C, s) (since wC m ∈ ↑C and minPayoff is sInf over ↑C).


lean
have : ∀ s m, beliefDot (model.inclM s) (wC m).val ≥ minPayoff model C s := fun s m => by
  unfold minPayoff
  apply csInf_le
  · -- BddBelow witness (need uniform bound; can be -B for some B)
    sorry
  · exact ⟨wC m, hwC_mem m, rfl⟩


Then by monotonicity of integral (or just iInf/inf bounds):

MisalignedPayoffM β σM_C ≥ ∫ s, ∫ m, minPayoff(C, s) ∂(β.kernel s) dτM
                         = ∫ s, minPayoff(C, s) * β.kernel s univ dτM
                         = ∫ s, minPayoff(C, s) dτM   (β Markov so kernel univ = 1)


**Step 5**: sInf_β MisalignedPayoff ≥ ∫ minPayoff dτM.

**Step 6**: RobustPayoffM σM_C = α AlignedPayoff + (1-α) sInf MisalignedPayoff ≥ α ∫ max + (1-α) ∫ min = F(C).

**Step 7**: UStarM ≥ RobustPayoffM σM_C ≥ F(C) via le_csSup. Need BddAbove witness for Set.range RobustPayoffM.

## Simplification

If the full proof is too long, you may **assume** BddAbove for Set.range RobustPayoffM and BddBelow for Set.range (fun w => beliefDot (inclM s) w.val) '' ↑C. Cite them as sorried helpers. The substantive content (selector + integral comparison + le_csSup chain) is what we want.

If integrability / measurability gets hairy, return STUCK with the precise gap (e.g., "need measurability of s ↦ minPayoff(C, s)" — this is the same gap as in menu_functional_continuity).

## Output


lean_proof
target_lemma_slug: menu_value_le_strategy_sup
status: PROVED | STUCK
tactics_used: [...]



lean
theorem menu_value_le_strategy_sup ... := by
  -- your proof


Aim for 80-150 lines.

Show more

========
ROLE: assistant (id=f1b1c746-a17d-4e3d-b72a-fc1c5fdcfedf)
========
lean_proof
target_lemma_slug: menu_value_le_strategy_sup
status: STUCK
tactics_used: [classical, obtain, let, have, simpa, unfold, rw, refine, constructor, rintro, exact, le_csSup, le_trans]

stuck_gap: the selector gap is fixed. The remaining nontrivial Lean gap is the kernel-integral comparison turning the pointwise bound
∀ s m, minPayoff model C s ≤ beliefDot (model.inclM s) (profileMap σ m)
into
∫ s, minPayoff model C s ∂model.tauM ≤ sInf (Set.range (fun β => MisalignedPayoffM β σ)).
This needs measurability/integrability of s ↦ minPayoff model C s, integrability of the kernel inner payoff, and the Markov-kernel mass-one lemma for β.kernel s.

lean
namespace RobustTrustV8

open scoped BigOperators
open MeasureTheory Set

/-- Allowed bookkeeping helper: boundedness of the payoff image defining `minPayoff`. -/
private lemma menu_value_le_strategy_sup_payoff_image_bddBelow
    (model : RobustTrustModel)
    (C : CompactMenu model)
    (s : model.M) :
    BddBelow
      ((fun w : ProfileInW model =>
          beliefDot (model.inclM s) w.val) ''
        (↑C : Set (ProfileInW model))) := by
  -- Compactness of `C` plus continuity/boundedness of `beliefDot`.
  sorry

/-- Allowed bookkeeping helper: robust payoffs are uniformly bounded above. -/
private lemma menu_value_le_strategy_sup_robust_range_bddAbove
    (model : RobustTrustModel) :
    BddAbove
      (Set.range (fun σ : AgentStrategyM model => @RobustPayoffM model σ)) := by
  -- Uniform boundedness of utility/payoff profiles.
  sorry

/-- Trivial model-side coefficient fact. -/
private lemma menu_value_le_strategy_sup_one_sub_alpha_nonneg
    (model : RobustTrustModel) :
    0 ≤ 1 - model.alpha := by
  exact sub_nonneg.mpr model.alpha_le_one

/--
The remaining missing measure-theory bridge.

This is exactly the place where Lean still needs the integrability/measurability package:
for each Markov kernel `β.kernel s`, integrate the pointwise lower bound in `m`,
use `β.kernel s univ = 1`, then integrate in `s`, then pass to `sInf`.
-/
private lemma menu_value_le_strategy_sup_misaligned_sInf_lower_bound
    (model : RobustTrustModel)
    (C : CompactMenu model)
    (σ : AgentStrategyM model)
    (hmin_point :
      ∀ (s m : model.M),
        @minPayoff model C s ≤
          beliefDot (model.inclM s) (@profileMap model σ m)) :
    (∫ s, @minPayoff model C s ∂model.tauM)
      ≤ sInf (Set.range (fun β => @MisalignedPayoffM model β σ)) := by
  -- Desired route:
  --
  --   refine le_csInf Set.range_nonempty ?_
  --   rintro x ⟨β, rfl⟩
  --   unfold MisalignedPayoffM
  --   refine integral_mono_ae hIntMin hIntInner ?_
  --   filter_upwards with s
  --   calc
  --     minPayoff model C s
  --         = ∫ m, minPayoff model C s ∂(β.kernel s) := by
  --             -- Markov/probability kernel: `(β.kernel s) univ = 1`.
  --     _ ≤ ∫ m, beliefDot (model.inclM s) (profileMap σ m) ∂(β.kernel s) := by
  --             -- `integral_mono`, using `hmin_point s m`.
  --
  -- Missing declarations/lemmas needed:
  --   * `Integrable (fun s => minPayoff model C s) model.tauM`
  --   * inner integrability of
  --       `fun m => beliefDot (model.inclM s) (profileMap σ m)`
  --     against each `β.kernel s`
  --   * measurability/integrability of the outer kernel integral
  --   * `∫ m, c ∂(β.kernel s) = c`
  --     from the Markov/probability property of `β.kernel s`.
  sorry

theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  classical

  obtain ⟨wC, hwC_meas, hwC_mem, hwC_max⟩ :=
    compact_menu_aligned_selection model C

  let σM_C : AgentStrategyM model :=
    { sectionM := fun m => prm.R (wC m)
      measurable_sectionM := prm.measurable_R.comp hwC_meas }

  have hprofile :
      ∀ m : model.M, @profileMap model σM_C m = (wC m).val := by
    intro m
    simpa [σM_C, profileMap] using prm.right_inverse (wC m)

  have hmax_point :
      ∀ s : model.M,
        beliefDot (model.inclM s) (@profileMap model σM_C s)
          = @maxPayoff model C s := by
    intro s
    rw [hprofile s]
    unfold maxPayoff
    symm
    refine IsLUB.csSup_eq ?_
    constructor
    · rintro x ⟨w, hw, rfl⟩
      exact hwC_max s w hw
    · intro b hb
      exact hb ⟨wC s, hwC_mem s, rfl⟩

  have hmin_point :
      ∀ (s m : model.M),
        @minPayoff model C s ≤
          beliefDot (model.inclM s) (@profileMap model σM_C m) := by
    intro s m
    rw [hprofile m]
    unfold minPayoff
    exact
      csInf_le
        (menu_value_le_strategy_sup_payoff_image_bddBelow model C s)
        ⟨wC m, hwC_mem m, rfl⟩

  have hAligned :
      @AlignedPayoffM model σM_C
        = ∫ s, @maxPayoff model C s ∂model.tauM := by
    unfold AlignedPayoffM
    refine integral_congr_ae ?_
    exact Filter.Eventually.of_forall hmax_point

  have hMisLower :
      (∫ s, @minPayoff model C s ∂model.tauM)
        ≤ sInf (Set.range (fun β => @MisalignedPayoffM model β σM_C)) := by
    exact
      menu_value_le_strategy_sup_misaligned_sInf_lower_bound
        model C σM_C hmin_point

  have hStrategy :
      MenuFunctionalF model C ≤ @RobustPayoffM model σM_C := by
    unfold MenuFunctionalF RobustPayoffM
    rw [hAligned]
    have hcoef : 0 ≤ 1 - model.alpha :=
      menu_value_le_strategy_sup_one_sub_alpha_nonneg model
    simpa using
      add_le_add_left
        (mul_le_mul_of_nonneg_left hMisLower hcoef)
        (model.alpha * ∫ s, @maxPayoff model C s ∂model.tauM)

  have hSup :
      @RobustPayoffM model σM_C ≤ UStarM model := by
    unfold UStarM
    exact
      le_csSup
        (menu_value_le_strategy_sup_robust_range_bddAbove model)
        ⟨σM_C, rfl⟩

  exact le_trans hStrategy hSup

end RobustTrustV8
