
========
ROLE: user (id=53a1698b-15db-4934-b4f7-bce558b71e1a)
========
You are the Lean Prover. Close ONE specific sorry.

## Target (in namespace RobustTrustV8, import Mathlib)


lean
theorem full_restricted_Ustar_equivalence
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp) :
    UStarFull model = UStarM model ∧
      ∀ (σFull : AgentStrategyFull model) (σM : AgentStrategyM model),
        (∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m) →
          RobustPayoffFull model σFull = RobustPayoffM model σM := by
  sorry


## Relevant definitions


lean
structure MessageSupportM (model : RobustTrustModel) where
  supportSet : Set (Belief model.Ω)
  support_eq_range : supportSet = Set.range model.inclM
  support_closed : IsClosed supportSet
  support_measurable : MeasurableSet supportSet
  τM_pushforward : model.τM.map model.inclM = model.τ

structure MessageRestrictionBridge (model : RobustTrustModel)
    (support : MessageSupportM model) where
  defaultPrivateStrategy : model.PrivateStrategy
  restrictFull : AgentStrategyFull model → AgentStrategyM model
  restrictFull_eq : ∀ σ m, (restrictFull σ).sectionM m = σ.sectionFull (model.inclM m)
  extendRestricted : AgentStrategyM model → AgentStrategyFull model
  extendRestricted_eq :
    ∀ σM m, (extendRestricted σM).sectionFull (model.inclM m) = σM.sectionM m

structure AgentStrategyFull (model : RobustTrustModel) where
  sectionFull : Belief model.Ω → model.PrivateStrategy
  measurable_sectionFull : Measurable sectionFull

structure AgentStrategyM (model : RobustTrustModel) where
  sectionM : model.M → model.PrivateStrategy
  measurable_sectionM : Measurable sectionM

noncomputable def UStarFull (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σFull : AgentStrategyFull model => RobustPayoffFull model σFull)

noncomputable def UStarM (model : RobustTrustModel) : ℝ :=
  sSup (Set.range fun σM : AgentStrategyM model => RobustPayoffM model σM)

noncomputable def RobustPayoffFull (model : RobustTrustModel)
    (σFull : AgentStrategyFull model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffFull model β σFull)

noncomputable def RobustPayoffM (model : RobustTrustModel)
    (σM : AgentStrategyM model) : ℝ :=
  sInf (Set.range fun β : AdviserKernel model => MixturePayoffM model β σM)

noncomputable def MixturePayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull : AgentStrategyFull model) : ℝ :=
  model.α * AlignedPayoffFull model σFull + (1 - model.α) * MisalignedPayoffFull model β σFull

noncomputable def MixturePayoffM (model : RobustTrustModel)
    (β : AdviserKernel model) (σM : AgentStrategyM model) : ℝ :=
  model.α * AlignedPayoffM model σM + (1 - model.α) * MisalignedPayoffM model β σM

-- The payoff "equivalence" definitions
noncomputable def AlignedPayoffFull (model : RobustTrustModel) (σFull) : ℝ :=
  AlignedPayoffM model (restrictFullToM model σFull)

noncomputable def MisalignedPayoffFull (model : RobustTrustModel)
    (β : AdviserKernel model) (σFull) : ℝ :=
  MisalignedPayoffM model β (restrictFullToM model σFull)

def restrictFullToM (model : RobustTrustModel) (σFull : AgentStrategyFull model) : AgentStrategyM model :=
  { sectionM := fun m => σFull.sectionFull (model.inclM m)
    measurable_sectionM := σFull.measurable_sectionFull.comp model.inclM_measurable }


## Math sketch

**Second conjunct first**: For σFull, σM with σFull.sectionFull ∘ inclM = σM.sectionM:
- restrictFullToM σFull has .sectionM m = σFull.sectionFull (inclM m) = σM.sectionM m. So restrictFullToM σFull = σM (as AgentStrategyM, up to .sectionM equality + measurable_sectionM proof irrelevance).
- Hence AlignedPayoffFull σFull = AlignedPayoffM (restrictFullToM σFull) = AlignedPayoffM σM (by funext + measurability of section).
- Similarly for MisalignedPayoffFull (per β).
- MixturePayoffFull β σFull = α A + (1-α) M β = MixturePayoffM β σM. So same range over β, sInf same, RobustPayoffFull σFull = RobustPayoffM σM. ✓

**First conjunct**: UStarFull = UStarM.
- ≥: For any σM, build σFull := bridge.extendRestricted σM. Then by extendRestricted_eq, σFull.section ∘ inclM = σM.section. By second conjunct, RobustPayoffFull σFull = RobustPayoffM σM. So RobustPayoffM σM ∈ range RobustPayoffFull. Hence sSup (range RobustPayoffM) ≤ sSup (range RobustPayoffFull) = UStarFull.
- ≤: For any σFull, take σM := bridge.restrictFull σFull. Then by restrictFull_eq, σM.section m = σFull.section (inclM m). By second conjunct, RobustPayoffFull σFull = RobustPayoffM σM ∈ range RobustPayoffM. So sSup range RobustPayoffFull ≤ sSup range RobustPayoffM = UStarM.

Combining: UStarFull = UStarM. ✓

For sSup-inequalities, need BddAbove of both ranges, which we should have via private_profile_bounded (similar to robust_range_bddAbove for Full version).

## Strategy


lean
classical
constructor
· -- UStarFull = UStarM via mutual ≤
  refine le_antisymm ?_ ?_
  · -- UStarFull ≤ UStarM
    refine csSup_le ?_ ?_
    · exact Set.range_nonempty _
    · rintro x ⟨σFull, rfl⟩
      let σM := bridge.restrictFull σFull
      have hsec : ∀ m, σFull.sectionFull (model.inclM m) = σM.sectionM m := by
        intro m; symm; exact bridge.restrictFull_eq σFull m
      have heq : RobustPayoffFull model σFull = RobustPayoffM model σM := by
        sorry  -- second conjunct applied
      rw [heq]
      exact le_csSup (range_bddAbove_RobustPayoffM_M model) ⟨σM, rfl⟩
  · -- UStarM ≤ UStarFull (similar)
    ...
· -- Second conjunct
  intro σFull σM hsec
  -- restrictFullToM σFull and σM agree pointwise on .sectionM (up to measurability proof).
  have hrestrict_eq : restrictFullToM model σFull = σM := by
    cases σM with
    | mk sectionM hmeas =>
      cases σFull with
      | mk sectionFull hmeas' =>
        ext m
        exact hsec m
  -- So AlignedPayoffFull σFull = AlignedPayoffM σM, similarly for MisalignedPayoffFull
  unfold RobustPayoffFull RobustPayoffM
  congr 1
  ext y
  constructor <;> rintro ⟨β, rfl⟩ <;> refine ⟨β, ?_⟩
  · unfold MixturePayoffFull MixturePayoffM AlignedPayoffFull MisalignedPayoffFull
    rw [hrestrict_eq]
  · unfold MixturePayoffFull MixturePayoffM AlignedPayoffFull MisalignedPayoffFull
    rw [hrestrict_eq]


The first conjunct needs range_bddAbove_RobustPayoffM_M (BddAbove for both ranges, same as menu_value_le_strategy_sup_robust_range_bddAbove already proved).

For restrictFullToM model σFull = σM: AgentStrategyM is a structure with sectionM and measurable_sectionM. These are equal componentwise. The measurable_sectionM proof is Prop, so by proof irrelevance these structures are equal once sectionM matches.

The cast / heq dance may need care. Try AgentStrategyM.ext or manual structure equality.

## Output


lean_proof
target_lemma_slug: full_restricted_Ustar_equivalence
status: PROVED | STUCK
tactics_used: [...]



lean
theorem full_restricted_Ustar_equivalence ... := by
  -- your proof


Aim for 60-120 lines.

Show more

========
ROLE: assistant (id=fbed4549-cd74-4c5c-9764-00d118be5fdd)
========
lean_proof
target_lemma_slug: full_restricted_Ustar_equivalence
status: PROVED
tactics_used: [constructor, ext, funext, simp, simpa, congrArg, rintro, refine]

lean
theorem full_restricted_Ustar_equivalence
    (model : RobustTrustModel)
    (msupp : MessageSupportM model)
    (bridge : MessageRestrictionBridge model msupp) :
    UStarFull model = UStarM model ∧
      ∀ (σFull : AgentStrategyFull model) (σM : AgentStrategyM model),
        (∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m) →
          RobustPayoffFull model σFull = RobustPayoffM model σM := by
  classical

  -- The reusable payoff equivalence: once the full and restricted sections
  -- agree on `inclM`, the full payoff definitions collapse to the M-payoff
  -- definitions through `restrictFullToM`.
  have payoff_equiv :
      ∀ (σFull : AgentStrategyFull model) (σM : AgentStrategyM model),
        (∀ m : model.M, σFull.sectionFull (model.inclM m) = σM.sectionM m) →
          RobustPayoffFull model σFull = RobustPayoffM model σM := by
    intro σFull σM hsec

    have hrestrict_eq : restrictFullToM model σFull = σM := by
      ext m
      simpa [restrictFullToM] using hsec m

    have hmix :
        (fun β : AdviserKernel model => MixturePayoffFull model β σFull) =
          (fun β : AdviserKernel model => MixturePayoffM model β σM) := by
      funext β
      simp [MixturePayoffFull, MixturePayoffM,
        AlignedPayoffFull, MisalignedPayoffFull, hrestrict_eq]

    simpa [RobustPayoffFull, RobustPayoffM] using
      congrArg (fun f : AdviserKernel model → ℝ => sInf (Set.range f)) hmix

  constructor
  · -- Prove equality of values by proving equality of the two payoff ranges.
    -- This avoids any `csSup` boundedness bookkeeping.
    have hrange :
        (Set.range (fun σFull : AgentStrategyFull model =>
          RobustPayoffFull model σFull)) =
        (Set.range (fun σM : AgentStrategyM model =>
          RobustPayoffM model σM)) := by
      ext x
      constructor
      · rintro ⟨σFull, rfl⟩
        let σM0 : AgentStrategyM model := bridge.restrictFull σFull
        refine ⟨σM0, ?_⟩
        have hsec : ∀ m : model.M,
            σFull.sectionFull (model.inclM m) = σM0.sectionM m := by
          intro m
          simpa [σM0] using (bridge.restrictFull_eq σFull m).symm
        exact (payoff_equiv σFull σM0 hsec).symm

      · rintro ⟨σM, rfl⟩
        let σFull0 : AgentStrategyFull model := bridge.extendRestricted σM
        refine ⟨σFull0, ?_⟩
        have hsec : ∀ m : model.M,
            σFull0.sectionFull (model.inclM m) = σM.sectionM m := by
          intro m
          simpa [σFull0] using bridge.extendRestricted_eq σM m
        exact payoff_equiv σFull0 σM hsec

    simpa [UStarFull, UStarM] using
      congrArg (fun S : Set ℝ => sSup S) hrange

  · exact payoff_equiv
