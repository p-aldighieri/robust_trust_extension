
========
ROLE: user (id=8624aa16-bd13-4ded-923c-21fa4781ce00)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  sorry


## Relevant definitions


lean
noncomputable def MenuFunctionalF (model : RobustTrustModel)
    (C : CompactMenu model) : ℝ :=
  ∫ s, model.α * maxPayoff model C s +
    (1 - model.α) * minPayoff model C s ∂model.τM

noncomputable def UStarM (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σM : AgentStrategyM model => RobustPayoffM model σM)

noncomputable def RobustPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  model.α * AlignedPayoffM model σM +
    (1 - model.α) * sInf (Set.range fun β : AdviserKernel model =>
      MisalignedPayoffM model β σM)

noncomputable def AlignedPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  ∫ s, beliefDot (model.inclM s) (profileMap model σM s) ∂model.τM

noncomputable def MisalignedPayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  ∫ s, ∫ m, beliefDot (model.inclM s) (profileMap model σM m) ∂(β.kernel s) ∂model.τM

noncomputable def maxPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sSup ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def minPayoff (model : RobustTrustModel)
    (C : CompactMenu model) (s : model.M) : ℝ :=
  sInf ((fun w : ProfileInW model => beliefDot (model.inclM s) w.val) ''
    (↑C : Set (ProfileInW model)))

noncomputable def profileMap (model : RobustTrustModel)
    (σM : AgentStrategyM model) (m : model.M) : Profile model :=
  model.profileOfPrivate (σM.sectionM m)


## Available lemmas (proved/usable)

- aligned_best_labeling_selection (model : RobustTrustModel) (opt : OptimalMenuCstar model) : ∃ wlabel, ∀ m, wlabel.wstar m ∈ Cstar ∧ IsMaxOn ... wlabel.wstar m
  (But this uses opt : OptimalMenuCstar, not just a CompactMenu C.)

- wstar_profile_map_implemented (...): builds σM from wlabel via prm.R.

For this lemma, we need an analogous "aligned best labeling over C" (not over Cstar) — let me give the proof strategy.

## Math sketch

For any C : CompactMenu model, we want F(C) ≤ U* = sSup (range RobustPayoffM).

Construction: Build σM_C : AgentStrategyM model that achieves payoff ≥ F(C).

**Step 1**: Get a Borel selector wC : model.M → ProfileInW model with wC m ∈ ↑C and IsMaxOn (beliefDot (inclM m) ·.val) ↑C (wC m). This is the same selector argument as in aligned_best_labeling_selection but with C instead of opt.Cstar. 

Use Inventory.measurable_argmax_selector directly:

lean
let f : model.M → C → ℝ := fun m w => beliefDot (model.inclM m) w.val.val
let Γ : model.M → Set ↥C := fun _ => Set.univ
-- Γ measurable, nonempty, compact; f measurable, continuous
obtain ⟨wsel, hwsel_meas, hwsel⟩ := Inventory.measurable_argmax_selector ...
-- wsel m : ↥C with IsMaxOn (beliefDot (inclM m) ·.val) Set.univ (wsel m)
let wC : model.M → ProfileInW model := fun m => (wsel m).val


**Step 2**: Build σM_C := { sectionM := fun m => prm.R (wC m), measurable := prm.measurable_R.comp wC.measurable }.

**Step 3**: AlignedPayoffM σM_C = ∫ s, beliefDot(inclM s, (wC s).val) dτM = ∫ s, maxPayoff(C, s) dτM (by IsMaxOn).

**Step 4**: For any β, MisalignedPayoffM β σM_C = ∫ s, ∫ m, beliefDot(inclM s, (wC m).val) dβ(s,·) dτM. Since wC m ∈ ↑C, beliefDot(inclM s, (wC m).val) ≥ minPayoff(C, s). Hence MisalignedPayoff ≥ ∫ minPayoff dτM.

**Step 5**: sInf_β MisalignedPayoff ≥ ∫ minPayoff dτM.

**Step 6**: RobustPayoffM σM_C = α AlignedPayoff + (1-α) sInf MisalignedPayoff ≥ α ∫ max + (1-α) ∫ min = F(C).

**Step 7**: U* = sSup (range RobustPayoffM) ≥ RobustPayoffM σM_C ≥ F(C). QED.

## Lean strategy

This proof requires:
1. Constructing the measurable selector wC over C (analogous to aligned_best_labeling_selection on Cstar).
2. Building σM_C from wC via prm.R.
3. Computing AlignedPayoffM = ∫ maxPayoff dτM (needs IsMaxOn unwind + integral_congr_ae).
4. Bounding MisalignedPayoff by ∫ minPayoff dτM (needs sInf bound + Fubini for ∫∫).
5. Bounding the sInf and combining via α-convex-combination.
6. le_csSup with appropriate BddAbove.

This is a 100-200 line Pro proof. Use Inventory.measurable_argmax_selector for step 1 if needed.

If you cannot fully close it, return STUCK with the precise gap.

## Output


lean_proof
target_lemma_slug: menu_value_le_strategy_sup
status: PROVED | STUCK
tactics_used: [...]



lean
theorem menu_value_le_strategy_sup ... := by
  -- your proof


Show more

========
ROLE: assistant (id=904ae504-2f2e-4b5c-93fe-3cc71c77b73e)
========
lean_proof
target_lemma_slug: menu_value_le_strategy_sup
status: STUCK
tactics_used: [classical, unfold, obtain, let, refine, le_trans]

lean
theorem menu_value_le_strategy_sup
    (model : RobustTrustModel)
    (setup : ProfileRealizationSetup model)
    (prm : ProfileRealizationMap model)
    (C : CompactMenu model) :
    MenuFunctionalF model C ≤ UStarM model := by
  classical

  -- First required missing object:
  -- a measurable maximizer over the arbitrary compact menu C.
  --
  -- Needed lemma, in Lean-shape:
  --
  --   ∃ wC : model.M → ProfileInW model,
  --     Measurable wC ∧
  --     (∀ m, wC m ∈ (↑C : Set (ProfileInW model))) ∧
  --     (∀ m,
  --       IsMaxOn
  --         (fun w : ProfileInW model =>
  --           beliefDot (model.inclM m) w.val)
  --         (↑C : Set (ProfileInW model))
  --         (wC m))
  --
  -- This should be obtained from `Inventory.measurable_argmax_selector`,
  -- but I cannot close the instantiation without the actual signature and
  -- the available continuity/measurability lemmas for
  --
  --   fun m w => beliefDot (model.inclM m) w.val.val
  --
  -- on `model.M × C`.

  -- After that selector, the intended remaining proof is:
  --
  --   let σM : AgentStrategyM model :=
  --     { sectionM := fun m => prm.R (wC m)
  --       measurable := prm.measurable_R.comp hwC_meas }
  --
  -- prove:
  --   AlignedPayoffM model σM = ∫ s, maxPayoff model C s ∂model.τM
  --   ∀ β, ∫ s, minPayoff model C s ∂model.τM ≤
  --        MisalignedPayoffM model β σM
  --   ∫ s, minPayoff model C s ∂model.τM ≤
  --        sInf (Set.range fun β : AdviserKernel model =>
  --          MisalignedPayoffM model β σM)
  --
  -- then combine with `model.α ≥ 0`, `1 - model.α ≥ 0`, and
  -- `RobustPayoffM model σM ≤ UStarM model`.
  --
  -- But the proof cannot start until the selector over arbitrary `C`
  -- is available or `Inventory.measurable_argmax_selector` can be
  -- instantiated.

  -- Precise gap:
  -- prove/instantiate the arbitrary compact-menu aligned selector:
  --
  --   compactMenu_aligned_best_labeling_selection
  --     (model : RobustTrustModel) (C : CompactMenu model) :
  --     ∃ wC : model.M → ProfileInW model,
  --       Measurable wC ∧
  --       (∀ m, wC m ∈ (↑C : Set (ProfileInW model))) ∧
  --       (∀ m,
  --         IsMaxOn
  --           (fun w : ProfileInW model =>
  --             beliefDot (model.inclM m) w.val)
  --           (↑C : Set (ProfileInW model))
  --           (wC m))

  -- STUCK
  fail_if_success exact False.elim (by contradiction)
